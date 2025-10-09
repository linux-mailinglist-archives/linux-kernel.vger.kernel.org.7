Return-Path: <linux-kernel+bounces-847309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC3BCA820
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A241883A67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232362F3C03;
	Thu,  9 Oct 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlfBRDw7"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDF2F25EC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032755; cv=none; b=lZcS0M6+7qH/D6zl8edc7Lc7cjdVuZtU7uzmyOQ7aNrkIJe44HRQ8h6d68WuwuD4QJ3XLzyasz3dnOjA1ktTqElbDfR54XY+RXds/nWhOh0AhTgw4L484Q7yOnhp4HCnO3xZ/GmUZGt8AP6OuZf+fQF65yJFM9i3QM+ioWjBJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032755; c=relaxed/simple;
	bh=Stb9gWLH6uJuqT+1HZagkMDgNJ+3r9ifT5CAmLLMAl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAZPwvpeDoCVOp0zQRLOblMn1U5B3iwNrnQBBOHVQ67HG7UGOQkAtjYB8Qsz9AYly91ZujunyWlKJShsbKOuuF5g440HkpWH0heR3xp5owpf5eM5jcS1x9k8FJc4a2aIQWl3WX5HHfEDC8674oyQLarZevcAoEXcT0v2nxIF6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlfBRDw7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so12594365ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032751; x=1760637551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0XzNWaGxbCntgrurWhYrm4iEPkiXeipxXgUvuzvBHw=;
        b=BlfBRDw77G+dxT9JEnd0lFE4OL+ZBc3/qdvMw/SwVAbOhsmTtbXFtRMxEaB5OH+k/n
         27BdlJ6W4aav0KmnrpRjXyigaumeVJ0I10/4wMn4VimgFLmCdR+ZklFk1lVbCa+UOTb5
         emcVGN63D0ns+MyKKr1FIH6ixSqw0LaH0jr37dIgHVLwPpayTOPZ3BsmDDLnfaH7Sm62
         prPCXMzm7PtYUigfseh/MJ6NaIJNM3TFuVMR0yQ1+m4b0h59xwBWM2zYEuKjEYIRZc0x
         Bzn3PSWG0QlqMvSnaobILg8D396AA6ZARcxj5Rx6fDufsEu5Cj558yV3jc1LCFiSL2NK
         VeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032751; x=1760637551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0XzNWaGxbCntgrurWhYrm4iEPkiXeipxXgUvuzvBHw=;
        b=HLnJkg575g+4jWTPDfQMltlCXvr/GPYvE8KmNaaHSLwqMiBcKFBSCvKrG/0Y79KS7+
         7jsTPL2sGhrwmcufJSBZjkb+Uc1lkgGJ5BOn2lrXpkJ6G/So0N8Quf1REb3F9NKAjXdy
         qCMCQB0fINOrnlCYVqoI2/KWPTZSS4qy+9qb9xMP/uy/2QpjfyUAekjJR8H7sSQtFr5O
         SOt2C8LFM2AfmViSLRaswkrDsEnE/kOotVSFT3t/i5Ucg9bKFdaheJ4NdO0rm+2ODAqf
         hIEEXEgLN5SZl+/g5assbRLB0Dxh4k+UHQEu4Ejhsj/2jXVm6aVLwoKW/rxKRqbZnnH5
         WQgA==
X-Forwarded-Encrypted: i=1; AJvYcCXbXrOUbXUMgxm1hwY4DovrKcgpgUF2/ATnhz56qsklT+XWCtGbLY3BAKWeFfeH/Yj+FLjeIp79TT9ng54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbem9YwNlDBCrIvCR7W+mxdcs5tP0FmNc3PvoIeKc4KvVz9tgs
	ST7P6G1iZIBit8QQMHbMPn1/MPtEqkdZBSI26xkByTuM3+O521f8rOD2
X-Gm-Gg: ASbGncuIJPsfggKbZt8yPhUb7sley/h+ELPK8sVi4/Vj9gsNboiNdLFHx6bWzyE8IrE
	RI0a/4vqLVGphumTb+/Z6bpamSUtmGnkUQjNyEDM1Cmzdyavzt1S+uaD9ol4iBEg2E/VfCYb2CM
	9hqQjexubknjoj5w6MS7cLu2NvnPi6oHOeUqZuhlA7xoaPsz3WQ3xC2BvWEfbIp83QmXNUUVKT5
	n1l4cItigz77Rk4Hob0jZfuXcgaN+gVclzTWDFp3dCnI6oEQghvJPeIbwa8TmKK0hvKooh/Y6AA
	QWWuSd261zINHD43HjMMS64bgmZotUD3LMI3ULOCLtmegVEHDrZyd3rWfyb/l6DjU72QovqPiQb
	LnaSA7gFiq6EHhjPh6VAiURR9HFoevGMpqJmS1i1Kp0N2GQP4twSebi6Bz2ZAXXokiE3VDohubK
	RDUNXSUkrwmPtZHrUE9U1jmtYzSPA=
X-Google-Smtp-Source: AGHT+IEYsyaeLyf8EZpNw3F9lCq0tpNVoC1uSjvB+6nwdk9sRQjO0dbdJ/WpD+G+dOz+8SbQ7siORg==
X-Received: by 2002:a05:6e02:378c:b0:42e:2c30:285d with SMTP id e9e14a558f8ab-42f8735201emr80190015ab.6.1760032751102;
        Thu, 09 Oct 2025 10:59:11 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:10 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 22/30] dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at compile-time
Date: Thu,  9 Oct 2025 11:58:26 -0600
Message-ID: <20251009175834.1024308-23-jim.cromie@gmail.com>
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


