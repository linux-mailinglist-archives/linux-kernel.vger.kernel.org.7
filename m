Return-Path: <linux-kernel+bounces-812891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6EAB53DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F683A91D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF932ED35;
	Thu, 11 Sep 2025 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lANsnwSJ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4612EBB8B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626754; cv=none; b=suF6lCc/kKJ1Z96v8RnLoLTaHwoGxNI4fANcG9Tfs6HcUkWmCHjIVZo5sMrVs5WKV7BpmLCXYYIvf1+CX/9CRHe3LQ2sD0CmMA2+1BTZD+L/3g2WWSGsQn1fzQhTruWAEvTcGXnDf+QD5AfwBkF3O1Jj9G7MtwNrWYedhzU2UYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626754; c=relaxed/simple;
	bh=Stb9gWLH6uJuqT+1HZagkMDgNJ+3r9ifT5CAmLLMAl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4QSTu3ScdyJkztvDp82n/024YNM5eJg3hOZtS99NqazfeBoYZj5dBf+Uh/1kCopCQFo2iL/bfadSDDRHjSgngcTqxoJ8L1lgM+MddGuY+9fiDyDbHGx5pClTJp0lfQMW2KArmD7hycnHYjvVdg9Gc5L0+4aew7stXAcNpUZksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lANsnwSJ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432e1af6dso91939039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626750; x=1758231550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0XzNWaGxbCntgrurWhYrm4iEPkiXeipxXgUvuzvBHw=;
        b=lANsnwSJdGeTYnCgTVtfAzCudWWfOR5kZaVh+4mhZAcNX83B7R4ZAMOJVmr1wegroF
         Gea3/QeNPFNLhUxDmCGkCgkAJH3IMVJjaY2eLpEWkljTMcVQGnEgO6jArodHJGHTOeSL
         jYYdKojB8wz5AuzHdvwxEZrcsGiRh/koK1dX10hIn/j5E5Z/dIh9nCLVDQP+o6JLyoHW
         bPYwQlHDf9Ge9VQVTpMHhplf+Zf2fYC+IWrouPn1prUN/YW4y+n/pjE1f8wcUr9ilsYG
         wA3YKEJ3XMR2+tAUQZkWnWBwcQjdeUAFJudLechLLRHDijv65c9V8BNVROdzG8JGNNNj
         SqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626750; x=1758231550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0XzNWaGxbCntgrurWhYrm4iEPkiXeipxXgUvuzvBHw=;
        b=KuKNUl3a4O89TrKZP62EoM4hxr2YmaZ+BehRw4ioR2xijbLzc0b6N1GBzXX+0li7ln
         P4uIipJgCwQPTobTy977cmsnIjFhoF0kD/GMQ3HAp0vDqktm2PajdrZxp3DIQ1DGZIQf
         mwCQ/UMnzL1pnghBmTtZc1csAxzodIBnP292Pl3hVQAyJLUsm1hTY+yW+IARpWirzyZe
         a1o3RPFWo00utIvLjhqsixJOHGRhQHn/a5AbmdSmMzdipmYpVzyMlbV2u53QWy9DZUyB
         KdZdoD5TFNi8/TB1DpwnzM52b8vACpN8jYiQ/nsXktuoGaO6PSmjD/EimEke+BylC8vz
         3oUw==
X-Forwarded-Encrypted: i=1; AJvYcCWc4iNDw8NmgcpTd/GCoW66Ogb9qMxQNxruUYEgyHc73WwxOs6b/J6PHUJSjtpoy/59CsH0q/VoVQ6caF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EP59dguRO7Fc9GMd6kkg9eZZLYc/fHW9pfBFmsNmxw2OjY8X
	H69RkcHTilpVpMM+CGeLe/AiXl5kIsahQw3zqohrzpBg9N9XBdF2has6
X-Gm-Gg: ASbGnct6oa1rx+xVWlGJOv5wUN9zoQmgqOquj4yY7Tr8lD8xh6r4/GqVw/aE5DWF3qi
	dK96i8ewhVRAvMvlym/ughD0Rkci1aiLUOBXkIDGscLnOi8zSkSmIyO0knIbCyTqXPJti5ds22M
	BKW5pJofmIgfL2a+exU1mdComAYqZC6smE0CuDiwWa+1QeI0AwWIPxZUNUWvTiLM9H2yO64oMDa
	lyfFI+WHYt8JfbeBObant9oQ52Viz34Etbv4gyj7iheT4oZ+pWBbWEw7eQkepsIbqV9aIAklcBV
	131i9MGcwNrbISc1Ec5xPmBM5L1uVPTtjUILMDZvp2puLX54ZpBwqoxsYAKQ4namgXB14e8WzO8
	ETIcIh1anNqouppsPqqL2Tp+WlHCRpWye9zOCjsI+P6O0Or2vqlIzrqZz7T4pq5DaK78/Lry3EB
	46dPI23eBEpLws4Ah8wE+z19jV
X-Google-Smtp-Source: AGHT+IGPEwXrxn6n0S7/ZE+Uf+F5x6+mjgx7v8qaZx2zlfhPwr9AtRp6Hg3uPX0TJjiA3OVC01GP4Q==
X-Received: by 2002:a05:6602:600e:b0:887:29c4:d64d with SMTP id ca18e2360f4ac-890351afe7fmr149942639f.19.1757626749633;
        Thu, 11 Sep 2025 14:39:09 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 22/30] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at compile-time
Date: Thu, 11 Sep 2025 15:38:15 -0600
Message-ID: <20250911213823.374806-23-jim.cromie@gmail.com>
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

Add __DYNAMIC_DEBUG_CLASSMAP_CHECK to implement the following
arg-checks at compile-time:

	0 <= _base < 63
	class_names is not empty
	class_names[0] is a string
	(class_names.length + _base) < 63

These compile-time checks will prevent several simple misuses, and
will issue obvious errors if violated.

4 such examples are added to test_dynamic_debug_submod.ko, and will
fail compilation if -DDD_MACRO_ARGCHECK is added to cflags.  This
wouldn't be a useful CONFIG_ item, since it breaks the build.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v4- deconflict after pulling macro-stubs forward
v3- $macro_name =~ s/DYNDBG/DYNAMIC_DEBUG/

prev-
- split static-asserts to __DYNDBG_CLASSMAP_CHECK
- move __DYNDBG_CLASSMAP_CHECK above kdoc for DYNDBG_CLASSMAP_DEFINE
  silences kernel-doc warnings
---
 include/linux/dynamic_debug.h |  9 +++++++++
 lib/test_dynamic_debug.c      | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2c64f2401e51..b96f069290bd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -180,6 +180,14 @@ struct _ddebug_class_param {
  * __pr_debug_cls(22, "no such class"); compiles but is not reachable
  */
 
+#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base)			\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length exceeds range")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -193,6 +201,7 @@ struct _ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base));	\
 	extern struct _ddebug_class_map _var;				\
 	struct _ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 1ba4be9a403a..b2bdfdfb6ba1 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -133,7 +133,7 @@ DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
  * Enable with -Dflag on compile to test overlapping class-id range
  * detection.  This should warn on modprobes.
  */
-DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 #endif
 
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
@@ -146,8 +146,19 @@ DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
 DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
 
+#if defined(DD_MACRO_ARGCHECK)
+/*
+ * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
+ * These will break compilation.
+ */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
 #endif
 
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
-- 
2.51.0


