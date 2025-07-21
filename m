Return-Path: <linux-kernel+bounces-739707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0992B0C9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04851895DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19AB2E2661;
	Mon, 21 Jul 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO7DHEEU"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761622E1741
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119756; cv=none; b=HHmK3kcxk05saCZdc6J2RWRXagQy7umb6E+bUpG8t0Ks2lAEgQfVwc2FwX0IXJKoqCVafe2j+7zzDM0Ll4eJiSrSoy5DXSUc2EvSTG4Ig3ob13u75+s0PB3jfOllpeMIhnHlc+imLsFBcdUmZgoSpsu9mscOeCgKjoANCkIBqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119756; c=relaxed/simple;
	bh=ml4TnR4sP/EVC1oe7s+toDvQMMcdqYX1P0e8iVPbGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcO47CLPzB+Lvy8GToS1CdxUQ439PoH8WAabQGYnxby3mVXxh/FfSHBTmkYRwb9NLmSNmpSYfwD02fS/BTB7DI6x8zHdrlhrZk/G5Ui/2A45pRV2vKOw1d0sVRo35AWbKnGItMado7zSrTt1bSGmWEVrOuGf+B6FK1yWMLRv/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO7DHEEU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a522224582so2298225f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753119752; x=1753724552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQThOSBsBRUCLy3pjNEC09Q7CAIuH9ypnMR0nLbKiM0=;
        b=OO7DHEEUNGfEzcMtzOq29frs+WmScBgl+f9mqnGBmGjFsdGXCzsEjtjlBuXohuNmgK
         GOFBHjIYLhE4ikHIpTR7LglYJq+1/0umCrqyDPRcqFBwhiAzJulse/acQeyZurgnmGaY
         jH9Pjjsu+GMp66RbRX6S/LFfplnixFF9mlFJvwlXKZ86jpCIt/+6oVLIdUyhX+uqd7LN
         9tEAIqwc9+nl9IFufstCc+8Lwi9oQWAQCWSDE/IttayXfjAi9enfnBnX3fGcmLlDEVr9
         nrZ2GpCYkDdDb15pOMtqUhWdPvpWP7tsN7CBZjQzpCcBWVQejqW/Wc/jP+kqZxEpXAzu
         3AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119752; x=1753724552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQThOSBsBRUCLy3pjNEC09Q7CAIuH9ypnMR0nLbKiM0=;
        b=Qgpq6JjX9ekrnGNAYWYKIvPws+MGASzTUDaM0roIjXi1dLSUjpVuA/TEkDHqb/6zvy
         yh1ui2wqNfqOiFFd1067DrE1h/bESfopsU+2W5iDVKg5n6qNgZwzHF54Hkar7ocW/Dj1
         wG8XWGNHSdWIrHxQLqOukQgQADVNQ8srT8YO8f8KRTakrsQNX+3NT7H2T+21HNtdJGPX
         VP89t+knMLqBYtI4c/BMRAog1FBwq7qvhtnphiYN28SaJIZvLcdHUvqT2f98GaXQHvCc
         5kj0VZKL+uBDIkvKPd2tBK9NmO/kptaxiZPYRoCOunMUJAN00F11Vmw06io1ZykS07cj
         ykXg==
X-Gm-Message-State: AOJu0YyFbi5HpsuZnmceCWzxwOlg8WcYRPERw32VkkiqGKieRvwlPmND
	3YfkStmwFKlpvolOHujsrYBtnmjaemum9yUpT1CkaSJQ4x0kHKGPWd8qCuaOEg==
X-Gm-Gg: ASbGncujsy7V0SGJWPfcBnLzmq1+G+B3fpMF4MZaMM08rYE2jMNsXod20H2rOB4+csy
	mCeMYmHu/KOKpKfcgiXuh0eP0/OKze3XDe0vcAHxzgmQfPx9RmKErQ5uxiJNJ0yLCTZUjO0raLw
	6ZEYQz+XBymQmuR8GE+2razcFXEtJdleyn/XzeDL2u5JfIDXsHxUVhy7tEbPKewSCXCeei1lJ6p
	1HcBsNoEjIzZNKd/59pphKhXeHXmil/3mOE26zNkQWzffuXmee3f/OKoaBKJzvRLd82nkD4yU/Q
	bQ4Wj8W7fTrOFq9gUZ3bRiIoauyN8t6sqSZ0dD/L1X/FgI4qbWKfNmyybmsy08NR7hW5S9UF0YI
	GoSSZ1VnhblSMxrz7p+JqVg==
X-Google-Smtp-Source: AGHT+IG2rGrbvmpNi8K1y9wCaXTQI0iB85ZJrAs9cb+LbZ6PXwE3wRjw4xYrH0KHJ0hDGCTvBVgJRg==
X-Received: by 2002:a5d:5d0c:0:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b60dd95a75mr17979631f8f.32.1753119752210;
        Mon, 21 Jul 2025 10:42:32 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4294sm165928435e9.3.2025.07.21.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:42:31 -0700 (PDT)
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
Subject: [PATCH RESEND 2/2] ucount: Use atomic_long_try_cmpxchg() in atomic_long_inc_below()
Date: Mon, 21 Jul 2025 19:41:44 +0200
Message-ID: <20250721174227.28002-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721174227.28002-1-ubizjak@gmail.com>
References: <20250721174227.28002-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use atomic_long_try_cmpxchgi() instead of
atomic_long_cmpxchg (*ptr, old, new) == old in atomic_long_inc_belowi().
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


