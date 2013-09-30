package com.pdi.hybridge;

import java.util.Observable;

import org.json.JSONArray;
import org.json.JSONObject;

import com.pdi.hybridge.HybridgeConst.Event;

import android.webkit.WebView;

public class HybridgeBroadcaster extends Observable {
	
	private static HybridgeBroadcaster instance;
	
	private boolean isInitialized = false;
	
	public HybridgeBroadcaster () {
	}

    public static HybridgeBroadcaster getInstance () {
        if (instance == null) {
            instance = new HybridgeBroadcaster();
        }
        return instance;
    }
    
    public void initJs (WebView view, JSONArray actions, JSONArray events) {
    	//if (!isInitialized) {
			runJsInWebView(view, "window.HybridgeGlobal||(HybridgeGlobal = {" +
		            "  isReady : true" +
		            ", version : " + HybridgeConst.VERSION +
		            ", actions : " + actions.toString() +
		            ", events : " + events.toString() +
		        "})" + 
		        ";window.$&&$(\"#hybridgeTrigger\").toggleClass(\"switch\");");
			isInitialized = true;
    	//}
    }
	
	public void firePause (WebView view) {
		HybridgeConst.Event event = HybridgeConst.Event.PAUSE;
		notifyObservers(event);
		fireJavascriptEvent(view, event, null);
	}
	
	public void fireResume (WebView view) {
		HybridgeConst.Event event = HybridgeConst.Event.RESUME;
		notifyObservers(event);
		fireJavascriptEvent(view, event, null);
	}
	
	public void fireJavascriptEvent (WebView view, Event event, JSONObject data) {
		String json = data != null ? data.toString() : "{}";
		StringBuffer js = new StringBuffer("HybridgeGlobal.fireEvent(\"");
		js.append(event.getJsName()).append("\",").append(json).append(");");
		runJsInWebView(view, js.toString());
	}
	
	public void runJsInWebView (WebView view, String js) {
		view.loadUrl("javascript:(function(){" + js + "})()");
	}
}
