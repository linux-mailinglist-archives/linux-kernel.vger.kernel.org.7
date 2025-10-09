Return-Path: <linux-kernel+bounces-847317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3A1BCA835
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7270A3B46C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253162F747B;
	Thu,  9 Oct 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/aecxGj"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17212F60B2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032764; cv=none; b=ACDeTkOmuNDXrSDSYD/vs6XI15otmIFipTJuJE6+7M+6IH7m9oFKSyxKhRNnNE8QV3ie2E9VXBxWfVkXRAfAsqrAoHWRbtK5SCtny5Gy1rHGOM1KfYgan37szKllQP6X3L6emp/ToPyf68HraTmDJjmd4mJLTyIGnZxRKuZTsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032764; c=relaxed/simple;
	bh=SAMH6bX/vL3va8sFv4toy+dDvica3sbvYihqhhgIHr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyIcjQsAq7Rx7UrG5oXPin0acTj/48x79RClEJTOHvFaWSrThewkOhEN5cKdj9DugrWG4//jFLkJ9jdneAI8PBQ7gQM7oVcAYft3bGZZGV8cprAOgYeeaTOTKESnKmdhPFHWayT+WWRvmRkNKBxKSoNs97QAiNDKt2iyorBriqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/aecxGj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so104074639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032760; x=1760637560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3z8Tk8lrK8AXvTeNfDXtN9XLGvTU1P/hpcdsNXRN/Q=;
        b=D/aecxGje3VE6vLulOW8FRoB61YSczaqiMpCQI8RiIe0h1bcAHAnFyCeO958rJt1bu
         lJ5FrlTNaT8HAYNXWf5QF2oUPMRJl+NdQ6anuq1nu+QgCkvGARGZd1ifAQu/SCzjOZ30
         mMeADlpfFxXrAy2fi6i0rFcvjKsFHOv+ftVex8yPrzJ5USrE7s9OLyvQn9Nh1MAXo033
         mwoNupIWnsFft7R/tL76iuQZLuEiTOX5mz6B1y3kR2+wJTHI8C1e9cqHGvaGMx+fSfZb
         XX4w2hkRTDJqcGPXFtv9K3blX0xUHmR+A42TpCGQ+6Sm6wD/g3rf1L8y+6wrR9pmfaGn
         hoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032760; x=1760637560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3z8Tk8lrK8AXvTeNfDXtN9XLGvTU1P/hpcdsNXRN/Q=;
        b=KK0WgplRSVXflo4/GJx9mIUglulHZdbWat/CeUSVMOlN2ATQN3QiK6znBbkpIcnMUW
         QY2icDQV2lqTOzdshnK1Lxu2Bjt5oENfk34C6kZbonq9FbKXqhFZ88jhx642eIszocFT
         +IiPEh6uVAe+KFPfT8A/Ak2muoN4ec58dDbMeaOrozSxNt4raKzDxQhFUcF0xWce+e9d
         VM6d4B4fktrPd4jMzhm0F79KixSGVbTmYzXebcTk3eloxdxZ3QFD8MH3zbHR/jHwF9C5
         rl+R+Oxj7Yd5RhKBTI+VuMvDUdItRs9DqbwfTXOG96F2aibF0bNpakv0qlqffDCfgf/N
         +zlA==
X-Forwarded-Encrypted: i=1; AJvYcCXYq+qifyvOreZl4HoBf6oVrKmAo5FBvSd4TsMN2fS0+/C8qn6BA7ww80i//j6Lr9axqS1BTNG4L5cu7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+ryQBvGsb7kTdfvkh+/5GfdMNUZbNg6m06QAAPLLuXDpLpve
	c6XVZbh5jBo9k4cMIhg/RDSWJgGCaAla9VV2yG27hB+3oQpM0acNtS/8
X-Gm-Gg: ASbGncufYqZj15X9GLU6k9zdlKqWVKNiLbv1MM1Dj8cefGex1fV+DeyogXB+FRWnXzJ
	XjSxOcmlyuwbAPKJpW2Nasd3/eSvD02CyOjeJ2aeRJ4eSM0XoKTlXrqXyUXoenXKdvTe7yKTwjX
	KsYwXDjIIgPDUnympwlm+G2h+ferxYzIrpPWYTQLmE1YuUaGAgNGh06PKAnDcC5QfEVJ2JEaIxE
	mbq+RyBijy5LDd6BRDYBWXlUv9JZ+LNcdGzCInmO6sv1TtxM4h3lp2pyAWjBlS6oAGYnARIgAMo
	EoUfg8TkQ9rK7pgbn+xUf9WTu9YqIvJj7TBtpiBFDnEDDYdR0liPP7GMS2e3txNQqW3D37QYp/u
	QjkUoyHpmNNLmnaQ8SJhrNQWBaKp2LjT5Gc5HCTEj8QE7VRHlHgC5ECxY3zdk90C7sqndRma4Vn
	IceIdSLKTBSN/3Yq2GBphvmHWPF4g=
X-Google-Smtp-Source: AGHT+IFR+shW7+C0q+f1Fmrt23B3YTQHyjOfr3zpgzC23vGg6C8CMdPg7iTrZ94nDfkkiwmOyi5W4Q==
X-Received: by 2002:a05:6e02:4405:20b0:42f:9888:48f1 with SMTP id e9e14a558f8ab-42f98884980mr10397445ab.1.1760032759717;
        Thu, 09 Oct 2025 10:59:19 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 30/30] docs/dyndbg: add classmap info to howto
Date: Thu,  9 Oct 2025 11:58:34 -0600
Message-ID: <20251009175834.1024308-31-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the 3 API macros providing dynamic_debug's classmaps

DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

NB: The _DEFINE & _USE model makes the user dependent on the definer,
just like EXPORT_SYMBOL(__drm_debug) already does.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3- rework protection around PARAM

v0.5 adjustments per Randy Dunlap
v0.7 checkpatch fixes
v0.8 more
v0.9 rewords

fixup-howto
---
 .../admin-guide/dynamic-debug-howto.rst       | 129 ++++++++++++++++--
 1 file changed, 116 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 1ceadf4f28f9..adac32a5cd23 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -146,7 +146,9 @@ keywords are:::
   "1-30" is valid range but "1 - 30" is not.
 
 
-The meanings of each keyword are:
+Keywords:::
+
+The meanings of each keyword are::
 
 func
     The given string is compared against the function name
@@ -194,16 +196,6 @@ format
 	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
 	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
 
-class
-    The given class_name is validated against each module, which may
-    have declared a list of known class_names.  If the class_name is
-    found for a module, callsite & class matching and adjustment
-    proceeds.  Examples::
-
-	class DRM_UT_KMS	# a DRM.debug category
-	class JUNK		# silent non-match
-	// class TLD_*		# NOTICE: no wildcard in class names
-
 line
     The given line number or range of line numbers is compared
     against the line number of each ``pr_debug()`` callsite.  A single
@@ -218,6 +210,24 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
+class
+
+    The given class_name is validated against each module, which may
+    have declared a list of class_names it accepts.  If the class_name
+    accepted by a module, callsite & class matching and adjustment
+    proceeds.  Examples::
+
+	class DRM_UT_KMS	# a drm.debug category
+	class JUNK		# silent non-match
+	// class TLD_*		# NOTICE: no wildcard in class names
+
+.. note ::
+
+    Unlike other keywords, classes are "name-to-change", not
+    "omitting-constraint-allows-change".  See Dynamic Debug Classmaps
+
+Flags:::
+
 The flags specification comprises a change operation followed
 by one or more flag characters.  The change operation is one
 of the characters::
@@ -238,11 +248,15 @@ The flags are::
   s    Include the source file name
   l    Include line number
 
+Notes:
+
+To query without changing	``+_`` or ``-_``.
+To clear all flags		``=_`` or ``-fslmpt``.
+
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 the ``p`` flag has meaning, other flags are ignored.
 
-Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-fslmpt``.
+The regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
 
 
 Debug messages during Boot Process
@@ -394,3 +408,92 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+Dynamic Debug Classmaps
+=======================
+
+The "class" keyword selects prdbgs based on author supplied,
+domain-oriented names.  This complements the nested-scope keywords:
+module, file, function, line.
+
+The main difference from the others: classes must be named to be
+changed.  This protects them from unintended overwrite:
+
+  # IOW this cannot undo any drm.debug settings
+  :#> ddcmd -p
+
+This protection is needed; /sys/module/drm/parameters/debug is ABI.
+drm.debug is authoritative when dyndbg is not used, dyndbg-under-DRM
+is an implementation detail, and must not behave erratically, just
+because another admin fed >control something unrelated.
+
+So each class must be enabled individually (no wildcards):
+
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+That makes direct >control wordy and annoying, but it is a secondary
+interface; it is not intended to replace the ABI, just slide in
+underneath and reimplement the guaranteed behavior.  So DRM would keep
+using the convenient way, and be able to trust it.
+
+  :#> echo 0x1ff > /sys/module/drm/parameters/debug
+
+That said, since the sysfs/kparam is the ABI, if the author omits the
+CLASSMAP_PARAM, theres no ABI to guard, and he probably wants a less
+pedantic >control interface.  In this case, protection is dropped.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this maps
+classnames (a list of strings) onto class-ids consecutively, starting
+at _base.
+
+DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
+call this to refer to the var _DEFINEd elsewhere (and exported).
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
+maps/exposes bits 0..N as class-names.
+
+Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize
+dyndbg to update those classes.  "class FOO" queries are validated
+against the classes, this finds the classid to alter; classes are not
+directly selectable by their classid.
+
+NB: It is an inherent API limitation (due to int class_id defn) that
+the following are possible:
+
+  // these errors should be caught in review
+  __pr_debug_cls(0, "fake DRM_UT_CORE msg");  // this works
+  __pr_debug_cls(62, "un-known classid msg"); // this compiles, does nothing
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like drm.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM - modelled after module_param_cb, it
+refers to a DEFINEd classmap, and associates it to the param's
+data-store.  This state is then applied to DEFINEr and USEr modules
+when they're modprobed.
+
+The PARAM interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+amongst the contained classnames; all classes are independent in the
+control parser itself.  There is no implied meaning in names like "V4"
+or "PL_ERROR" vs "PL_WARNING".
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they (all the classmaps) share the limited 0..62
+per-module-group _class_id range, without overlap.
+
+If a module encounters a conflict between 2 classmaps its _USEing or
+_DEFINEing, it can invoke the extended _USE_(name,_base) macro to
+de-conflict the respective ranges.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the class'd pr_debug callsites can be forced off by toggling the
+classmap-kparam all-on then all-off.
-- 
2.51.0


