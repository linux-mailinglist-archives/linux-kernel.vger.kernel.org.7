Return-Path: <linux-kernel+bounces-812898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05090B53DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FC4189DC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1F36C061;
	Thu, 11 Sep 2025 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSF1UUAu"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC6353346
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626761; cv=none; b=Ny1hnhaAn2CVvTwOTAT2NkkZ2mUH6SsXw4F8UxgLyPuXZ5NGO2LPq/6e8sHuDkNqcaxogJ6B3oTQpsqXEs40uP2gSk6M0RFJtEyJMR8IiueJvE1F/o1MFHEf4/80jZHT0oJb2hLS0Xg3PQG8NgEgiicsiZZhNcfmACghCqfD9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626761; c=relaxed/simple;
	bh=SAMH6bX/vL3va8sFv4toy+dDvica3sbvYihqhhgIHr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcvUym1nhDXJwBpwHaMY/QV4ETuo269ai3d5Qkous8o2VQjThPUhyIAigrpsA/3fw2Mrv9DHfOnaxM9SzDooJEp+flVRXwPv4bayV1sNselM4DS4rA+/kwtZ6pJA7I9Bpo5vDZw/DETBAfK+SAyg2IeeEOT0E7m1KUNI4avXRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSF1UUAu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88758c2a133so103757539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626758; x=1758231558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3z8Tk8lrK8AXvTeNfDXtN9XLGvTU1P/hpcdsNXRN/Q=;
        b=LSF1UUAuGtAZPcws+phpd8lPyX7UDvXRksal+TMT+H5w8anzdmMeKLcDwhT+w1XjBD
         06SoUOq1fdNGoigy7sQYeQqePN4Jsldp85eW447FoEMOV4gAS6noCeNOxdHCrJqHJBC6
         jreATpI6wc+Ve67l92jGt2vZ/jd76XzOz8sDv9Ge8PwOK+lyF1LT3x2h6vbs23qLhevP
         OknbloTSofPCpSAG+ufrdRAEClaRylTRU58z7Wywt+fYcBt3IR/VCJBhdRg17cSMzlXV
         eUuapaJaQB0/TZpd2Ot9FdEm9DVSIT9bLzkiU7pz/BPk2TSbdwInhJShbQiiQcxulAKc
         G66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626758; x=1758231558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3z8Tk8lrK8AXvTeNfDXtN9XLGvTU1P/hpcdsNXRN/Q=;
        b=DfCdUw39G87c4Nf0EZ11k89NqKNBhsRsdZtRbuZ9dxTzlZGBasstEMc79rESAAK5to
         3j/BJqcbtfe28QgyZR0FSv+H5ahFM6nqLsEVPE0k6gFPxh5CI5flCio9dkXK+AdK6YSM
         wSNHNuEd7FRaA6iojZFEgIWb6OHf1GPXIfvUjYcoiYmvEcPe4gTbOaHE1MknJD2zP9WY
         l3pMqsE+uDNJZ59+A5ZtHLW3L/Biqml3mk5Wc2J8r4qev/WPLZVFa6a9pvsWm4uEwsTx
         1CeIUt8DmvLiRPTCakZVXppO4WV8xRXBfpUXIukKEE1/n1FMJAD7+wbR8+Rnq+QKNQwx
         ul5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAMigqP3tWEgUTOdgI/lmfFePFNOwSDdqhNzPy0J7okQzrsiiDB+pFPWB5IY3Be8R0bdrob/C8WYntdqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhGJi1du6dDWkN6EWZo/lLR1lxGKcZ9vMhtM+ra3grVS4GxrA
	zOwCCOgA7ohHSppYjlCzDDKBgJZE/K+B+Q0p3yqh2lx8sDHo08eVrsqY
X-Gm-Gg: ASbGncucInzwKaagrde6Z0yb7px/1ayhq6A3N8Hjze5rNgNeslXe4X3hu9cTWnjjF8K
	rRt9YPN3tlkiwz6TXasOyS1bOFlxuuSzXgca8/+WVvRk5ae9feb/zoBNn6ng+kqTF3ha5bzdzS/
	dDWVJVLC51e5Om8TM+AL0NbOId3s9zS6Fwp6IreBL0BheaFxf/jiJ0u+utvLp1E7/RYGpO5t5Ct
	4filwXGO9tW1XLDlVXgyp95bP875i37W+eLlSFAUwDh3oSpsBY+g9MLDuJ4vJ0qFKZWnLooqhQ8
	bhqwHU5obGXvFo771vr7CKNAZgMerjmMDtogSSmHgi68sHCIeyoZJB1HKOCLBY3W3sgUS9zvP7k
	LyND++aOgqmtFM/okDMIcn6fg6dd9AHOKXwJk8B4vGX9CwukfgfUDFw3kDXhuyrzDwtv16h6hLv
	gHRhtknj1USsNVmw==
X-Google-Smtp-Source: AGHT+IGh0GcENOAUp5idBZd9L09iBpK6xbRxEplx5rapSkwcsRu7LEbIzUFebORy2+6g+12n4y5PXA==
X-Received: by 2002:a05:6602:634e:b0:887:76b1:59d9 with SMTP id ca18e2360f4ac-890322353ffmr127570539f.2.1757626757647;
        Thu, 11 Sep 2025 14:39:17 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH 30/30] docs/dyndbg: add classmap info to howto
Date: Thu, 11 Sep 2025 15:38:23 -0600
Message-ID: <20250911213823.374806-31-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
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


