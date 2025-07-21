Return-Path: <linux-kernel+bounces-739716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38657B0CA01
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EAF1AA406D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088492E338B;
	Mon, 21 Jul 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbEJGPmz"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424981A5B92
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119981; cv=none; b=dYQcai4xJXNrwg9Oof99p0JpX3nz8WwqDlxXPzFVt6vbpRY78iBvBkLZToTvmVS+DsITCkDMZazm4OoepvulXDZfdPHmgM0/n26LEIRaUu47KLFTMl3xQ8vcVIL8Ho1TWEb1PPeDlgmgreaAKx3nEzQfUeqSHQln+V9Z9ugsgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119981; c=relaxed/simple;
	bh=cjO1fbFRUWBELqTlmTozS4ZIZpsbbhc2s/ckd2BiwWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEcsEPpUJ5VU9j4vIZvFDeHRsfovgMWKwLa86BCcL17zrS3DjnvTWEs+vEpt9Xz+Ly4NtSD8QBXgGHJFYGMVxXLh60iffHM/rF1Xr2f7+lyIAx//XjsbOvW1EEeMPdpvXlDMHhid98VCxYPKtU7oEXfKNZTxuNYDAGhfiJJKqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbEJGPmz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ab112dea41so2726474f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753119977; x=1753724777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At+//X/YlgJ71aMdTQG9DPHWLMxmFnHWnpIHr0dWI/M=;
        b=RbEJGPmz/hq7fP6a/kMUV7SevqtUHsqsdAp8I9+kZBde9FitAgo2LemzZII7DwyPmQ
         LuR10vhKcKTUkC1OD5vEOjRGcT+bBKg8GbH53cR9/baIZTjLIaxQ7C0FEWankisl0iF9
         p9HI65N0HEUVNmTViX2JFi9I1p1zUkvza+nKufWBTub+PutMkNpgXEqEQasYObiipa7k
         eMtfLXjH2t4weY1J+lwjoT9a/8Hs5XLwvREAQIuIh+BICpzMrwWPwzgr5oX6nJattly2
         xlLhM+IKFOncvCxbdP7kI55CUmYft/dj+Xqd/H4ct9t8UD7BXoU4fUg8vYnAoxQtnYL6
         PK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119977; x=1753724777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At+//X/YlgJ71aMdTQG9DPHWLMxmFnHWnpIHr0dWI/M=;
        b=bg1GFkSfZmNGXx0rRriYP1+ePEjuZbPuAxMEnxs7vSHLFWC8EMei9MGjfvSSKeiL/C
         e91strrgQIWt02J0r/wRDKUzeQKro9b8BNoQAQTNm2iEcHNhtzXkRLnP4LxASldmHG/T
         OjP0OFw6d4WBEnE0Kvs9onSlqdj8Ttu0smK8in0oO6mjJqW1VxgNL1zgRwI1lKifh8i9
         ICWsri8Y6FNIgZ1C/eOw8OFQia19e9jLePasmIZ28R2T+vdwoP2VZ5XxVpynW5y29l/N
         vT79beY1s9dt4ACSO8D5oMkceJBtXPrlu66gayODvtoSqoAebOWfi+JiOVFEn2PIEpOo
         jtAg==
X-Gm-Message-State: AOJu0Yx9G+rBYUr/05qi511gCkUN4xytjchlo+OZkbSOD3yuTy3i5k7c
	kitG/+q1R19LqpPm37HSdxRiOezFq18ztghOcfi5dEZUySHXOGbeDcEH/cPF2Q==
X-Gm-Gg: ASbGncthVtjcd356c8e8sK6WHP4Q7n4gY2WYH+wgXtNydeAM/2CPCVNSdXxjRUBvR5E
	jB0rdyhzeRTj9MnRPzTc4DTZeqIqU4tpjkqrY4U84PLpkZoZnMlOoUEJJdvpCoApreqHjhNBX10
	sGxoptW17C/SyLPzInqH6ARmUY1shTBvr23o4+xpwQNuyIaG/vdbOZqCX8d2bZ/9ZMKuSxxikau
	MG9VEUU/uPtFXOkdZSQz2oFGlL2LeMjmjUdUm610Mim+fTNyPm8YhZq+KkaWbndC+hFg873Apk6
	eCzYI6TYp4cJ5wgq00ka5Sz8ufT3YxAOvh6Wc1R/2XliqYyh4YxQ8SqqK1fRWu2wxB6jzAhqCn2
	QNpChULN08mPPhwFLsqvFRz5d4mJ3NGhW
X-Google-Smtp-Source: AGHT+IGclBYwneP7C1cVx2zvAL+8tGbhrUhBQjU0+bfFiBl2GGEs0MQPJu58BeBgK5CNwvX8fGV5VA==
X-Received: by 2002:a05:6000:4602:b0:3b5:e6f2:ab4d with SMTP id ffacd0b85a97d-3b60dd997cbmr15551632f8f.42.1753119977037;
        Mon, 21 Jul 2025 10:46:17 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b6b020ddf4sm8819467f8f.87.2025.07.21.10.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:46:15 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexey Gladkov <legion@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	MengEn Sun <mengensun@tencent.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RESEND v2 2/2] ucount: Use atomic_long_try_cmpxchg() in atomic_long_inc_below()
Date: Mon, 21 Jul 2025 19:45:58 +0200
Message-ID: <20250721174610.28361-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721174610.28361-1-ubizjak@gmail.com>
References: <20250721174610.28361-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use atomic_long_try_cmpxchg() instead of
atomic_long_cmpxchg (*ptr, old, new) == old in atomic_long_inc_below().
x86 CMPXCHG instruction returns success in ZF flag, so this change saves
a compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_long_try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Alexey Gladkov <legion@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: MengEn Sun <mengensun@tencent.com>
Cc: "Thomas Weißschuh" <linux@weissschuh.net>
---
 kernel/ucount.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index f629db485a07..586af49fc03e 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -201,16 +201,14 @@ void put_ucounts(struct ucounts *ucounts)
 
 static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
-	long c, old;
-	c = atomic_long_read(v);
-	for (;;) {
+	long c = atomic_long_read(v);
+
+	do {
 		if (unlikely(c >= u))
 			return false;
-		old = atomic_long_cmpxchg(v, c, c+1);
-		if (likely(old == c))
-			return true;
-		c = old;
-	}
+	} while (!atomic_long_try_cmpxchg(v, &c, c+1));
+
+	return true;
 }
 
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
-- 
2.50.1


