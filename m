Return-Path: <linux-kernel+bounces-876844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE8C1C825
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165A219C01E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D935470F;
	Wed, 29 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF3DBLvF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22C351FD7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759558; cv=none; b=lWM+0TVlB9GRq1nP6/Sathw4wztGWOwg2QI91HKlNVrKqtcClIcSOxcQA7BkvEDi8xexJf6KyZZY2LR3Ju4cbVTRVBUIVJ5C7q/FzWYNnOu1x4bFN3e33N357uXA7Q9C2Pm1hQ6l+yn7m+VGc2Gvb+yc55Qk/bApc5P6SIiYr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759558; c=relaxed/simple;
	bh=gBefb6TqXpK7acbrPQobkS7HLgFQZCifBHYFs8GUpJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXHWCkPG1uekdQTOh/ekWviqrOnmA87bNIuiTefABMgMZg7N+UvUVkKppgSK15TgqMJQaLkF2E75kWQK/w+xusAbyYxZ2NGPhD5ToViU/xA29ZJ1C59siqAKRRvdYPPUwJlqm01LWqsmBqfCwgED7vlDQ4U47VQwiwQBYxJorBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF3DBLvF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dd54d7cdso456845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759554; x=1762364354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BzVG5MnbPwlPbESmRwYUVZfmKVQyQaqYcMPWkRLlE8=;
        b=dF3DBLvFxed+650zVeP8h863Yle78hobNeKOKn+IJktW//5fB0odz42tVJUQqxvA+a
         /BoFVCwXjoVA0UtAapAu6KQzdmdtx7pfT0J6fDB6WtcJ/VacUYcwArk4CHzWIRySjfkm
         jpY3b/Ix5bVQcRIP0sOq1e8bQ+7scqz2/Oe+q1MEOWikD67hdXNfBYx0XYoyOfHQC7B1
         a+qpPoSgrpG3jI6RqX6oUeLEz9pU428lVnUy9ok919uIqFU2EtuGd5hk7SUKsXzhasZY
         02qGp/5iV6HhYJz6if2Te0jvzyIo5tNbtWZS0xd70MGnCju+Ik/8J5dVP8LYf37aXuar
         o+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759554; x=1762364354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BzVG5MnbPwlPbESmRwYUVZfmKVQyQaqYcMPWkRLlE8=;
        b=VKbL6vCHIZ/OayPlBy5vFqvHxtIDTcvpAbcqYDUpW7FRty+sVDRGXMQHl7BcRzdqiD
         4E/pZl3NV7xIKu34sn1aQSws4524YHnPNTOPUixnwrICBBA2Cp1eK7lpDHiuhhzSPb30
         pixANvnW86CmTOcLHP7hec3mdGSepHklluFUrD/PMqqqw6VWQHtxcGODvr3u/Q0+aOeH
         uqykTrMq9TWVcYzt4oE5nrTesXSfotI6VBr5U4kLoPOoyRpa8jWvgoGyOwpqNCz6uQKg
         bzYcss2xR4syNyQPRNzHvH9uVGFNvHu5iovZisMCM9gfr2wjBBxz/sDvVER8lEbt46RO
         jTxA==
X-Forwarded-Encrypted: i=1; AJvYcCVfgieXbWrnTbQRqjv4iKSmQr+CWNQnlbVTa9VClC+w9tmEYtA1E8l7QCqJDhAoEcYQy3T1FvVWMWjQPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti6HpZfj8aobdbKF4rPxYpUqsX4BZIVDWyAB62Q4I5ruHd6Su
	JyWBSiPxs8j2Z7NQamRdptZ+YBrjtSaWrSTWG89AgWGz3D7XfZThcG1h
X-Gm-Gg: ASbGncuKr1U6ZH0Z7myxXS6qlYtNNO4Qt1DE/JNkinZhwzdWlsXtgaZZTtQMSsE8TBj
	o0oevzHyqju9n48zppixdasOF53zr3A8N9Z6j0nyKoQ3JVz/XzDz8vyI0OyF1pbhFx3LuMRojea
	c7xcCxP9YxXsWzLazGTDwjX8VZZ0GzNfFLnNmADtJoxNrD/b4RwxTKkpG8AodS3C0lDcRDO1OGF
	f756s+oRGNB1E3PK8z7lE5Xwmi9/Z6cbC08aOpKxKGv+T0FsSpSRMEkkQgFXQLslCQpz9Sb5to2
	1BLUXev8iStz3hlQuT69l5Cs/HsBwAtrOczULCZJV9UIDUQaXYj2TOdF2GFrsvktpva2k8YTsjb
	iTi7quit5g9mJ9AsP9O7fXlNHkmEmltu3z/mYkLGeekmLBK6LpzxD2mhz/s/eQ6eLyMg8NnbzgH
	dFVP04J/+VloiAXPdm2sgDOgJQP4t8gYi6Y6IX+oh55gM3uqCc0VjtPSWB15e1
X-Google-Smtp-Source: AGHT+IGl0NDHjcqHERE0/tdzJRGWl9OHItubCGkefGK9qCcwbrWMRpil+4PA5SDhZx6H7QnJ8j68Jw==
X-Received: by 2002:a05:600c:3b1e:b0:471:a73:a9d2 with SMTP id 5b1f17b1804b1-4771e39c8damr30167895e9.11.1761759554128;
        Wed, 29 Oct 2025 10:39:14 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:13 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	u.kleine-koenig@baylibre.com,
	Nicolas Pitre <npitre@baylibre.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v4 next 2/9] lib: mul_u64_u64_div_u64() Combine overflow and divide by zero checks
Date: Wed, 29 Oct 2025 17:38:21 +0000
Message-Id: <20251029173828.3682-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251029173828.3682-1-david.laight.linux@gmail.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the overflow check always triggers when the divisor is zero
move the check for divide by zero inside the overflow check.
This means there is only one test in the normal path.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

V3 contained a different patch 2 that did different chenges to the
error paths.

 lib/math/div64.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 0ebff850fd4d..1092f41e878e 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -212,12 +212,16 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 
 #endif
 
-	/* make sure d is not zero, trigger runtime exception otherwise */
-	if (unlikely(d == 0)) {
-		unsigned long zero = 0;
+	if (unlikely(n_hi >= d)) {
+		/* trigger runtime exception if divisor is zero */
+		if (d == 0) {
+			unsigned long zero = 0;
 
-		OPTIMIZER_HIDE_VAR(zero);
-		return ~0UL/zero;
+			OPTIMIZER_HIDE_VAR(zero);
+			return ~0UL/zero;
+		}
+		/* overflow: result is unrepresentable in a u64 */
+		return ~0ULL;
 	}
 
 	int shift = __builtin_ctzll(d);
@@ -234,11 +238,6 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 		 */
 	}
 
-	if (n_hi >= d) {
-		/* overflow: result is unrepresentable in a u64 */
-		return -1;
-	}
-
 	/* Do the full 128 by 64 bits division */
 
 	shift = __builtin_clzll(d);
-- 
2.39.5


