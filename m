Return-Path: <linux-kernel+bounces-847300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6ABCA7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4295481264
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A362ECE9B;
	Thu,  9 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN7hU8CU"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D72EB5B8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032744; cv=none; b=FdWK7jHc5Lup3EaGyKY260qi9dgoJp9qPi/UzL/QxTyt8HLIcu7SM5UNXOY7cxHPEmJZ4AFXpk0IgJQc1gxmU24i1/j6helkcNZHzv7Lc/uWODDfSbNwVkQ56cWLuF39qyuC98tNlPEuDtdkTZdcIUME8n46cTZYvcyY4YFyU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032744; c=relaxed/simple;
	bh=iMHKQHA3tjs9UQ7SjiSntNwXKBEfD825xQLKxsfFxt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgYtf9gOVdy6u/df2rBNjGsLteUHm472eobUSA4g8Js5RemFthPqgQNRZxw/Za2YpfHMnhtpSaTl9HBwGKFFSdoWgFFhL3Pz/GEyvvcXESW6JVR28BYuUSuDFVG9uGX9M26Kh3QGfblAWgqe6DOmBm6tqEeZyYlXWffPW+OQlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN7hU8CU; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-9399ddb3ffeso117165539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032741; x=1760637541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUjBG8W7JviM3Ypn5iExypGYjiK1aXkryX0lsVYOg2Q=;
        b=nN7hU8CUxwp4vWjo0qBrJWso8u5+iN5v+9cemMKwcnJvnWz0KvMahYQ/hlgvEvxgHS
         FgodBTcINE5VTPlzZ6rEAJSnWvBJSsrJohG3MiP12MgTqHY3md3bzF8/fLTTx1KKYA0X
         t3PAdry//uK5YiKLvk1TSVvAXLc6aQ5PFS6K3P52RTCH0Y9cPszQKOVtNtR22cn3LWl4
         Nm989wtXd6Z0di0z9MhyQRCo/6qy3M1eQWwEPY0sELpVLOBfZkuLQKk2Ve5LnGGXMi2Z
         vaDN6bCfNi6CkBrC/miJpj7Cej21INoUKMbKyl+Qw8pc62aTue9NlyTUg42kZUTwzJk3
         h7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032741; x=1760637541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUjBG8W7JviM3Ypn5iExypGYjiK1aXkryX0lsVYOg2Q=;
        b=ShPqtOHBZCil/bBxG8BmqLtEJ2WookM9v6+vI0vZ0uIj7KUvovneQnlEq7XLRif06e
         Xif64U2jJQn8HXMEslw1RM2VQCqPPtgh2CjW9kuISypqK4r7JlJBVQwZUH5UqVzwmeRk
         AUudh2fI5N920DpndHyntrKmYBCTZlTBYVKA+ECTzzYkF9OzMERc/EFnN+zcWWLMSI0J
         yymotZF0fYFC/rUvvEJCw4rdm2OwNFarxH/G3S+SgGaRyBZaPdAXc36kWqsmhBn1LXVB
         Pp+MoIIwM+5Y2NT97q72AzRuQTC55uLlhgEGujPggAk48p1aS8ujt6Zzu7bgjLZpl31a
         cLkA==
X-Forwarded-Encrypted: i=1; AJvYcCUyjLS4nm+Q7d6YMnl6KAzONg5RXt5wiOblKc8gSPrF1R49PHginV8jqz4DL1mbBZA5/lJWvbujrdYN+ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZSBS0Dfd/eVrkJocIIUdGLi0JFe0HPUoLzFoOucDK0My4iTU
	d4feF6hSgbQm8A7qkIqFnFMKJifB1JIiGR9tDP/Hh5JF3gUd8PjopU+j
X-Gm-Gg: ASbGnctQgueAVDTSCimXwBIvgBi9i4PQwvSxdt6DiSVheo6+xr+lkbCz1i6BVEAyxZ3
	ML5r+VEu1vCsCA3a4M+upHgoT8FT1SR4VHSFdd45YNMKXtXIMXiIcv84QvAA2kXLDCDwLWNYsMc
	Ot3r81MkMI4oYJJ4SPTPbnQ9d2o/urMTpuQw1RGbFu6pOCJwwgrKaTCENJrMn7qxuXXlH7rSpZW
	gWVJR0hg9lxbbi39UU7gpqEROZCvK4UEIkQgvWdsuo0IJSpmVeYHOHtcT1me7QjSED4nS1HQG0i
	tYo46OxZwwBEwawHMOASF+de/pEORHa0vBntCKAAgSQvg0TAtAB0qhTwex+Vaw8f+yz/zm4Zc9T
	ZdciBkriQCM0YB8urHvE8TVRuOZ9sXk6yn4vmzDrdPqjh8RBHou8dCnxiWAK7bDIIoG3wcCtUSU
	BRM6iYiC4UrVH9fIGb7agdpKDV271TpH7tY2E7hA==
X-Google-Smtp-Source: AGHT+IEs4KDkEu/Tkx7PA7Q0xJUK7cMMLKchJ3R9IgY6/hfuRIJ7D8MjEdR+TiVWsfUwI1oIJ916bw==
X-Received: by 2002:a05:6e02:1fc4:b0:427:d82b:1f36 with SMTP id e9e14a558f8ab-42f874010aemr82928145ab.32.1760032740923;
        Thu, 09 Oct 2025 10:59:00 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:00 -0700 (PDT)
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
Subject: [PATCH v5 13/30] dyndbg: DECLARE_DYNDBG_CLASSMAP needs stub defn
Date: Thu,  9 Oct 2025 11:58:17 -0600
Message-ID: <20251009175834.1024308-14-jim.cromie@gmail.com>
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

Add a DECLARE_DYNDBG_CLASSMAP stub/do-nothing defn, so that callers
will compile properly with CONFIG_DYNAMIC_DEBUG=n

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 39 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e458d4b838ac..2a6ebc3c1459 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -91,25 +91,6 @@ struct ddebug_class_map {
 	enum class_map_type map_type;
 };
 
-/**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
- * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
- */
-#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
-	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
-		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
-		.base = _base,						\
-		.map_type = _maptype,					\
-		.length = ARRAY_SIZE(_var##_classnames),		\
-		.class_names = _var##_classnames,			\
-	}
-
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
@@ -134,6 +115,25 @@ struct ddebug_class_param {
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
+/**
+ * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_base:  offset of 1st class-name. splits .class_id space
+ * @classes: class-names used to control class'd prdbgs
+ */
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	static struct _ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_classes") _var = {			\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.map_type = _maptype,					\
+		.length = ARRAY_SIZE(_var##_classnames),		\
+		.class_names = _var##_classnames,			\
+	}
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -300,6 +300,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)
 
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.51.0


