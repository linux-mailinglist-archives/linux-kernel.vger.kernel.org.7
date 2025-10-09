Return-Path: <linux-kernel+bounces-847306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FEBCA80B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFF4FC328
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512612F0690;
	Thu,  9 Oct 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW4/XVLI"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9B2EE607
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032750; cv=none; b=ttrWkk/ImAvsZWToSOY5RHbWuM9E3eLVNy6HvyhW7HWcsl9avqnNyE5+nCkCpWGUmHGq2Pj+nIZQOOgHGwYMzbWUpHACAaq7tHszQYwJaUMzrEChTzNnt54uj5u9MQ+yKlIjrNjqzS+mYvH4VIN/COOabjT/INB6Aquq3ccvQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032750; c=relaxed/simple;
	bh=imH4oGjtC/DVv6V74aFKG/eXjYLLf9oli7Nh0hAHYa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Son8FMBEQIEcU1wulhd6J/y7ktw2wsXJ1g/DHL6oPdNR/mJIpD5kXZq1kyu5iTA47jw7EHnj0sezg6dFBPTzfJDn2pBQrmU19wfdpu0l1Db3zZ069NZCg7gXyh+LzA3n2LQF4Iwq/SlnE98FY/pA4iT7NQPvHBRlh1cWOYXTMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW4/XVLI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-42e758963e4so11462565ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032748; x=1760637548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBVZWusQDNba37/oJBvqNeU2d7R0nqKRYCmReL4RLfo=;
        b=RW4/XVLIQi49Sa3wUJD9jjj/pEd1nUIvsrvbeqC0jSM27+2VPRanlt7wf48OTtDTDo
         4dr+Ahqr97K/1soTWjA6azZ2/3cnL6/b5FAxLAnxG1tZrrEGXlan3I30R9eZHOvEDjaE
         yBKum1pqgL3AhwCjMdD4Yfynt3+ReA79/0PGaSipcepkuFm8zHAXU775vK+iuXwso7AX
         OkpV82+eZ0RRQ7QnlN86jP5NDuvU8TYfN40cVTm1jOU7wjkm+8WGa7bvDwtnlSUtwggs
         pD+5r4kcnBEDlTM0kxF08qCHu03lCypNgyggiE21lVtefvZMaK0f+mJ47lwozwozfUv+
         dGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032748; x=1760637548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBVZWusQDNba37/oJBvqNeU2d7R0nqKRYCmReL4RLfo=;
        b=la1WCKHJaCJqlVA7Z40SmDYZ5UNu4AypC6d0pAkufzuN+ekRbXx0lxoNigDJqMSuIq
         txlTkWQ7bw28NDqbX06V6u83K8A3dzE+lgETEt7posj4f/VMJrr8z20HBjIVlN8+4XzH
         3SA6B0eW0iwhB2J0U0xNCTr/1eMvWyNq+Me6vKOsc/G5vK6a8HofWbA0Z4T3r8Ue3gVP
         YS/fdsL/1csa5tqh+ZC+Mzm7iPtHyOJVyM0KxhcR0kBDSnc6wAreOnTOn7U5oIBz1YVs
         rzdgHXYP1nZlC04qvMz1QjzvTEGN93CVu2LQnSsYToxCjDqp+XpyaSAKORBN0QCd6FgC
         zp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSz6+1wKmkBGwhzJXcCp9sKtcRtdo/P/YlTrkG+yFKv4OthuE3nG0MW7PUBEg9EPu70V3ehOMjF8k/jpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtC8vAa/OIPIoyGmRMwAXvRmwurSfWukmal+n3mlUroumAy5e
	AAA15wsy9hTI22LBsRiClmPrmYY54MBWQRyNMJGkTq206r5WbkQRSsmk
X-Gm-Gg: ASbGncv8ST7aWpuHIWz1dW++SLHEYJ8SI4093JFh8ONzq2txLhMqwolGtCSWzexvaNz
	HoYWAUAScnDOpDBbEhMq303Go4qt03kgUg4m5/MyI8X31vQUsUMrffJDPc0cYxot2/ZA1QYKJH2
	C7rb4kcLere3BSATHejfc5JPdboNxaA6W/ydv50zn9UPwah722t8IXm5KXCzX10D2tHWAYJGgqW
	gm0dqP8EbEFMDsaU+QtMBGXYT1IPTpvyYKNWKtoICrLKsPfb4BQMmiZ/ETXcqKGh6z2c0dZcuu9
	ijxLwOxNsvURvv6gKWCjPAOFtlhHXUUvvhlIEZYLMLW/ePQ36e9HYjb1xPLn7VyYEHIsuTBTgVZ
	y9BqMKQr2Zlm8UiryLH+DVbCh7QIrVykJ6FVb6az546lKFcD7gGd6od4M9Qq4U6sPzR/HhZ/GVr
	/lnBs7uFYbcO57hP7Mq/8cfCN3QOA=
X-Google-Smtp-Source: AGHT+IGyz5PWJ72Qylu52JN98V5hPC/owd9s7jI1qO3g0mG+L/5zspcKIM0k6PzzDXXuTsCSBFWwxA==
X-Received: by 2002:a05:6e02:1a88:b0:42d:86cc:1bd2 with SMTP id e9e14a558f8ab-42f87410bd5mr76537985ab.32.1760032747736;
        Thu, 09 Oct 2025 10:59:07 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:07 -0700 (PDT)
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
Subject: [PATCH v5 19/30] dyndbg: change __dynamic_func_call_cls* macros into expressions
Date: Thu,  9 Oct 2025 11:58:23 -0600
Message-ID: <20251009175834.1024308-20-jim.cromie@gmail.com>
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

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 include/linux/dynamic_debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b6f3689912fe..68568a71f265 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -217,20 +217,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id))				\
 		func(&id, ##__VA_ARGS__);			\
-} while (0)
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id))					\
 		func(__VA_ARGS__);					\
-} while (0)
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
-- 
2.51.0


