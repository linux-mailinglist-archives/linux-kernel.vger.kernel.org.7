Return-Path: <linux-kernel+bounces-812881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80167B53DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D595A5D80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9F2E612D;
	Thu, 11 Sep 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnpE2se7"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2E2E3B18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626743; cv=none; b=RfjfPWDl5Ag04WYNzz5Pmx/oUpcfPhqZnNbRJJl8jf7cXcQuKdD/kbjJEe0LTjH5yMKeTxw5InkSa66Z3qnpPmBoPqmq+VK9CJ/UtGQZB4JFwTcQF6wLivPQWDhGqeWKlUPN8J7hGIEoO5o2WKnhSpjT7RQVWJ15yZ06CBMfepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626743; c=relaxed/simple;
	bh=iMHKQHA3tjs9UQ7SjiSntNwXKBEfD825xQLKxsfFxt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eINee2MarusZysJkhGVILKZrUcTejMFnf9Ey2bHXJvacfuPxCUsJbBb9KbOYRuJlfWVRgmp0ihBDf4g/Frhoq+miW65AvVTCqQKyyaXQRE2YoJDr9lp54lKLi3GWqHogZ5j1oiipHG49H1dGLborv84IgBVqvWchBm4p4f4XdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnpE2se7; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88432e91223so28307939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626740; x=1758231540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUjBG8W7JviM3Ypn5iExypGYjiK1aXkryX0lsVYOg2Q=;
        b=gnpE2se718enzfQtqKUdM7i97yblTOLTo6bw0Ljxk9IZuiaPl2iibpYoT4rCIpz3MF
         jqNVKiaT7awphXqVGfoSigstJhWE+yHx7An6kdvaXuukc1O5nYo7nbmIWrMRViCwoknU
         2sM0k7aVtZgjzgMvfg28aGbXBhHshhJZ8eS49YyB7CWuIs6nuRjCxL9U7An2+zSLfvs6
         qb8okMehbX0+g790NN43QI9JV+S9NgK6H45/imUTcZ1k3yUzcpDEGd6Q/7NsiTnEYhll
         t6wRM0cwizvbewwxt74Va7HzV4CSOt4a52zX170L2iOMYMkP1KFKvwRR54VKwCwb6mJd
         qdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626740; x=1758231540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUjBG8W7JviM3Ypn5iExypGYjiK1aXkryX0lsVYOg2Q=;
        b=kJrzCcz6YUgqvrG9sLpB8Nn95bw0Aw0j2ZS2zFrnqC1HmjM+hEjhf4vG0h3z3LM3Hn
         6akdTGtt5edME5PccBugkgrNeTyAPXKpFdLJdeMsXm4G+xw+b6BmCTnJUHN9Y3fAhNj2
         jFt6Dc3BJWYjsZqgqi/NzBVJ+QWlrAoVP6y5gdeOZNpGng8AWFhX2+kHMhemQ0ftTqPp
         FIaqQoyqvEX4IdXo7z/KKfCOi7o4axeRUebS/x3rSN9j7uYzPCtqdqQtXn3qVtwrEPSN
         PQldcDxn0SKXX3lrvFgtpTaNtH+wDBkmj/Y/x3MSUMf8tadUxuzCcOlfdf6dGHxy00eW
         NzaA==
X-Forwarded-Encrypted: i=1; AJvYcCVWy45L65xwoY9hefeynbwfrIrckxYuGCrAtTnDUXbj+wOBzMi5lgTpv6HHG6+/ZgkMmr2p+oHbtZtqoGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C1ziLKlmPMex0HMMfd8h40u5vUj3Wn11MLUOvnRYuGUtmLmn
	onD8f+AnEVDx0uSNIc1z1WflsjpCAfHnCaIZNqKfJPSI4mkrzQLtggFj
X-Gm-Gg: ASbGncuKtYDNbl5AMrxjYKnvm1f7OFfyYS7jTgiBr9G+ItTpXYytFyNp8CqEAWYb9Tq
	7MqA+dy/gu8EfVzrQIMCtHMaevZ/f3xYlz6gIHBvF1w6Cws8lbC814p6LvGP8rSVaQ9klW/hK8J
	BqFg0Qj4H3ZApo6QaBW6ToDv4Mf2jcRYeWcXT+y7rub3g1kBkcbikKQbSuvAXWzPPq/GZrDoRIx
	86U9BUAhISUJDCxZO5hZ4qZ7iRwG7FuR7fLUiRq4WeregburHhe+pt9wi1g8H0ngnlq24ZYUMXL
	hP9crR3PjXs/LAk5sMjsUU3SMItDjiJl52DBHV5Vu9mBQZXIhke+Wfr6lo+aU7bC+9JMcRmM4oM
	9oQwPCJ7mXNywo7SbOYxV0I5Xqt60DOxVNO36AlMQ3xTLc3ARjJqKz6Wb5Y8MnwY6v439qJhQBH
	+KkOI=
X-Google-Smtp-Source: AGHT+IFy+M+sM5H1leUcrJZuOhZH5FegT+n18iAnK5oozu4QUtKLeKOnXdtqce8YIcWAmq2x+j4OYg==
X-Received: by 2002:a05:6602:6422:b0:88c:3a35:ff43 with SMTP id ca18e2360f4ac-8903451f48fmr131460739f.15.1757626740483;
        Thu, 11 Sep 2025 14:39:00 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 13/30] dyndbg: DECLARE_DYNDBG_CLASSMAP needs stub defn
Date: Thu, 11 Sep 2025 15:38:06 -0600
Message-ID: <20250911213823.374806-14-jim.cromie@gmail.com>
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


