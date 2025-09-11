Return-Path: <linux-kernel+bounces-812875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27AB53DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E55A5F88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B02DF145;
	Thu, 11 Sep 2025 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUZmkrhn"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B02DF138
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626736; cv=none; b=okSDYWyvuaPFs8xDAMD0RIOKNrDtLSUDK1YXLBtrcSjCYvUuM51BI3y/egAe62Wm4JSPKwA9EZO3Q8l0yozJfzMlmPSpkMCZld1fCZu2KVU/YaSGDniYY9GsKhC2+tjUPeMvTiVgkj5G89y0h50XjSjm+uPXFxshXtfXYtGaV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626736; c=relaxed/simple;
	bh=kfrqrzBKdI5m1IsAj48HkDg3z3FjqKlovuaaRAQV+k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DliHpQ3D6FmUAXtiCRFS5uOHXiW/GSLV0ytyPhzoUH36JApL3Ny9uY+BMnafdNdJSM+F3+e5E0MF+suutE29GGLEP28aQB5dQC71pj9SrEe8fTAAWePgzQ0zlzbBYf78xXXROH6sXMJ83V9HukdD0wx4zDmWAUDu10+dgTBq/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUZmkrhn; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8877677dbaeso29816439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626734; x=1758231534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU2dh1AcXNpIKiB0LgzN/RHkM4liyYcW5Vvv24TZfyg=;
        b=nUZmkrhnrkcDAdfjmFRmXtVELBAbNFuVbIFJgveuEbUxD5XeTh5mzYk+uxdYurTx7+
         jfAsH3kjRBqHc7/3FJXdVCrbIpyh2cb4lyFhAQnv6GeTwXcNBJNN0VHZTIaZgGvXAYcC
         bZnkA4+aP+19L+AHfcHKWYmGL1EcG/S1LsTQ23VrfnZoC2qrSg4L3ar6S0puLbtCEo0H
         eMxQtgvshtHPx5SY+KBDkVvUjxo1w/7naqx3BNEpZqtrLqbUfUjsoj6fwh3We3bB3PJJ
         7FbOh/4qN+mN4u37qcmKsvCBHiii94zdbjNfvwYp17KUba6GXjlTkOnS6m9P5rCiaF2S
         GJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626734; x=1758231534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU2dh1AcXNpIKiB0LgzN/RHkM4liyYcW5Vvv24TZfyg=;
        b=cfrH6cCxm3jPvnapJA4eF9hYQm7JVoCruMDcXTNplDUKPz+COfwg8iMti7vtLqpGCA
         Pk/77qSZjoIQAFxGyyKFOVgI6badIjwC98ZacK9MfKJAr98y5gkx338Tgp5ah200G6Hm
         VaK71KzHPENsv7POfwvUBAzEcju+2717pYdPUgu1lhZqcfAVG2smJz5Xodt9cabiAIic
         cWLvIz0LYy/Ba/yQDtHHYZG9d4ups1Me6MeRvPc5QspyLXG3or7h42X/FszBfjPLPAEV
         +6PjSJ5kRaiPek3sC3lx4bn6DxB1GN3XsISwAk3uY5H/WlCCa1zbqB47/ojpx4lE3IM9
         Udzg==
X-Forwarded-Encrypted: i=1; AJvYcCWcaLI+94+G/ID5wRAEZH8v/uJgf4o02Y7i7GWxPQ5lmTintFLabGt13i/yzLWOuWpwT0xqOlXjaKeJTyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEy1y+syk0lqB0y4Ds6TVW0onfRU+PdE93H/M5qteY2T5U3sj
	7KhANIObI9Hz8w98bdRO++qvf9eqacWykUc7bvd/YTZuIHrUsuqLRib/
X-Gm-Gg: ASbGncuJIwdqEAuzxidB2JkV/nnJW6BUeGmPELcBQYjcyumg1fwd5Zi+3Rp+Z+ledk+
	UqnDKZ5ExShz49R7E24bnKpebiE5pw9eaffs4E7XDDZs5iLBmd23T77sXhmrImYdThTru+PzvlX
	CyJTXDJzFJaty1va5t1OBx3RKOx5SyYk/XwppnTcXOrX3bUHodZWJA9nEGrDtdth1ZkTJZHYHaa
	ugB+hq5C/7bE34Z63u6+i9ebfDgy2weKOt7lrbB0GpxkG5x0ezwXfKt3b/43DFGsT0IdKuTnIkc
	qvtvfae7LNLBXrXx0avi4KYDWy4W15+nQrMZeTSlqz2vzfBNh2mXQHNvoND4XO4rHY/n8psmRi7
	vxR6C0awMda91sB1BldWLiq7rkLD43k+VzNK7QLr5VGP/ZiZHpZL/Id6AbXxybpi1XtXjJlbFVP
	Oy3PjPOTG8de7/lw==
X-Google-Smtp-Source: AGHT+IGq/bsKwq5FiX0eWOdjNgWpXbASW1tUrX21YO7tYwHijODsZ+hrvU5H0+HSy9a0/Sga6ta6cA==
X-Received: by 2002:a05:6602:6011:b0:888:826c:1902 with SMTP id ca18e2360f4ac-8903280bcf2mr143062639f.2.1757626734072;
        Thu, 11 Sep 2025 14:38:54 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/30] dyndbg: tweak pr_fmt to avoid expansion conflicts
Date: Thu, 11 Sep 2025 15:38:00 -0600
Message-ID: <20250911213823.374806-8-jim.cromie@gmail.com>
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

Disambiguate pr_fmt(fmt) arg, by changing it to _FMT_, to avoid naming
confusion with many later macros also using that argname.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 55df35df093b..2751056a5240 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) "dyndbg: " fmt
+#define pr_fmt(_FMT_) "dyndbg: " _FMT_
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.51.0


