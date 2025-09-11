Return-Path: <linux-kernel+bounces-812887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED7B53DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6D01678E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871822E8B9E;
	Thu, 11 Sep 2025 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERgowJjs"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F352DF3CF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626749; cv=none; b=ADVx13yf7WF5z8MOyKVv8SmgWu8mkMskCWIouTqPWdH8+bFMOZRlFYPiEdHsy49Dv+1lpQH8zk64ttJG1XtLHQ0iQygr2Rn/g1IcaKYQM3zXSn+/0R4uq50dba/kYvuQjjp5h/nVD1wb5E9rre0maBHK/yhleFhy0L7hwx0QxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626749; c=relaxed/simple;
	bh=imH4oGjtC/DVv6V74aFKG/eXjYLLf9oli7Nh0hAHYa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJLDYV3hkZApuEznPjVhc3pYw2QKOLTI1w+h0UESXeMKHtJZY5YMxnPsXmTlSxTVvLxQXKd08lgKatPUNPzU27w3qbbRwYBABrbUc4XV6jvLLIhbBCyTMvZM13girbmKWpa3ET+JUg2Fls7TM652PTqMgZOAZhRhN2zzCE1tSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERgowJjs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-884328c9473so27510639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626746; x=1758231546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBVZWusQDNba37/oJBvqNeU2d7R0nqKRYCmReL4RLfo=;
        b=ERgowJjsMnEhuU3AHrFnmCoUVkwmVt7wyfM4nUN5kxKAeXEFQ+B5w2yWSDVm7kbK9x
         Kwo/d+qIVXVfd/BAGVXgVg5NwLGXE5i27qLhhau7+y7wN8vXvp2gQVuQvgzbw4J0MrKj
         l3bL9JMHkcSlGKwc/awB0TymvPctPI4DEVwP4UAbAgioEaIELPRstgsEq1jYwCCurJlE
         mAAuuyhBKfTGqvlk/JIZ2x63fr0vMrVzQcXqZKpTx/0DDzXvFafWtSEW2LQ1v+p12G2h
         haMov43WtLmXi8tvUdRnTyBnKUvnYSf8xz5TSwq1JC/RC5QNq328nBI88r4cjYfD/fI6
         uKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626746; x=1758231546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBVZWusQDNba37/oJBvqNeU2d7R0nqKRYCmReL4RLfo=;
        b=I5F8yCtVuT7YPbJd8S9DH+mzSkiz0zwDYHpRn7/FuPe7UXOQd5+Uj4wtFhRrdxs7HT
         RqAiMXjN0HafOyskZqr/5SF92Ii/rDbx4tnFuwcYG92HLTkaMfFOBWtNCbAUKRJvvrRm
         KZscg7inOIpE2hE0lBxaB8Xf6SoodP9S8qh7UCzd7zo1+Nma5VNdQXkceVEnucmQZS72
         EFEF3FPuRwe15MvFXzDp1JnZ9rAQxyFdgsyp9fH8YHB1l/A1w//XNSXz8bh+nEparUJs
         ekTTSVa7EqqfNcGTsGXTxUFVCDBG2MrdHfzndu1FY008gRN6x0F99aY1lorl2R3HnmdR
         9aCw==
X-Forwarded-Encrypted: i=1; AJvYcCW+yMvaZyPKDMrnQ5RX+4SJIuQLUMR9vM97NB+F5rogydUs65PaollRUCKJS4RVHRtyPhrHxxT9HSXFPXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9HqlwOG44tcDlS48IACdQv1b9bDWJWU89IdhgqzUMI8SUGIu
	LA+oR8/b7ObH2EfOGpdD8m/HhXKA9FRKo2nbPfOSD/+mpNfihgcJSFds
X-Gm-Gg: ASbGncseJlgc792al4TbJw7z5dyq1r9m4HZnVv9WZZNUxntevQ44/WJdqU1NmI2Iv4P
	x4qDmacbgEQiv9uPkqEMPdLC0bAWB4owXKMIb8zQc4Xi0GgHYzKzbyDa0YJ5hGX6HC06Z87T0k/
	J+/FeWnrC6adg5elBnJNuGbC0kBylpB/sWQ7CEZrgLKpemaxf2lIY256u8U5dG7VgOl6Mgq1xdq
	q3379l5IMVvsrrg5QknfKYfKonemnBUAe/Vf4jCIT7f8VO1uDS1PHgJ45eflGtoTKOlFxlja9I0
	AUPdCz6yNUd46ecHvezIz6SyZLjThg/6mdwgx4ZY1iF8D76Oj8DKDBUVEGYDdVpVMIecyLaQnsy
	g8M15ovdBKhw232lS5SarZuLpQnLs2NUBOLxWPyDpzqbCqpGVtD9t3bWAZKkw7ukJdDkW7X8VUB
	siPk+Sz9JNx9qfXg==
X-Google-Smtp-Source: AGHT+IHYtJcTWnc/cq5Ri6ps3srDsSmMJL9tKwhFikXfRBeZA97aRQKju+koXUHbj1+UQ2neoDZNZQ==
X-Received: by 2002:a6b:5a0d:0:b0:884:125c:6949 with SMTP id ca18e2360f4ac-88ec393cd49mr689570139f.7.1757626746543;
        Thu, 11 Sep 2025 14:39:06 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 19/30] dyndbg: change __dynamic_func_call_cls* macros into expressions
Date: Thu, 11 Sep 2025 15:38:12 -0600
Message-ID: <20250911213823.374806-20-jim.cromie@gmail.com>
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


