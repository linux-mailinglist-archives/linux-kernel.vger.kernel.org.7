Return-Path: <linux-kernel+bounces-885223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EBC324AB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC44F1E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5947286D7E;
	Tue,  4 Nov 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fSzdf/m5"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D42561AB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276568; cv=none; b=p/Mr2iu9qcYR8Ad29DUZ0lSaSvnBbdRDtZaUX9F+EGWLcVX5VP0ZcgyNsYKXti/mH6m6pO/EoGf8Xb1KunZO/iNQCqywrTISblNECIYi6W8OcQY+Vppa/A8/QRHjZ2OeRfDU/Y/I6XCh+jNwTQcsopb45FbtlzAV60l3k9uHlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276568; c=relaxed/simple;
	bh=SmOlJHMCU3N0iiMuL6yxjLUgY6uVNyAMSu7BIUAUq1U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SJ3FSFibEQO7JnARtO/BVo3AnJnM+lRCVHb9pdLkzSQULWsg1q02tsSKXS9Vn2wZ2K4xqgrWg1sOyDcSgeEsYfZKW3wKKjt9S4iQIW4kX77jbp5zsHzN/MqOZ3q0CBA89NELj0T8BRLvItOOZQHggE35rx+7BOEU34iziO+aTo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fSzdf/m5; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dbddd71c46so922293137.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762276564; x=1762881364; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYRIwHVTAIDIVPCP3DGFctoy8qfBR9V8THP2tXgflxE=;
        b=fSzdf/m5B9ZgaPEU17kxFl366hMcDegKSnoU9tIMeXVn/ksKo8J9El7WhwDsm60REH
         e5W1Fw1lIoBe429kV9pAUGJ4BQPPaun5ihjyGwwY8F7g5Bbg/RrNsMz+CibAbQ22sM7k
         AZg139Z1D8OcPR0V4cqTUSU9V81g5vw3KumNdvhQSHpscGp++0sB0UrUeIrACK49D/E5
         JEIp89lXeYYkDjvRxBmQ8C2gPDrepdlfMeI7HUaLO0cNxYLT4djCMZsQ4wR7EHYCHeEJ
         IL5FnqPwjq2wzmCOXiN1bV7v3jr67RiRx8B+c6JckGPvYMWl06nPmPSVU1Tr5mBgsA09
         +8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276564; x=1762881364;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYRIwHVTAIDIVPCP3DGFctoy8qfBR9V8THP2tXgflxE=;
        b=BRjwnkWpJaCwq3mc1Twm1dMPyB6CiG68czFQ3H027c81flL7VdLOXBWUXdLzZ5fVju
         anbbLKsI/xrMsDU6IP1+92JPu5VkRAFSNickcLQrhu01sjjdBOiOztget4Kip2aV31XL
         a2hSSvU/7xF/Da8l1GWCg9nPIb4elruAuSgzkq2TfT2xectLc8UlhQv1uPYU9JY7raSS
         kw9XAfdnn1OpKcwc6YeDs/AL8sw/Jn5sqROfIO74CdUpDWLZTt0yanti1DVEt59jDVHt
         /gC/XRFdDEDbpa9Lasho7iplVGaspghFgbyA1PkT3JWkVF8NEBBjxvWj3DH9uCixw1T3
         UWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVgvsbfKvyeAx36QrFhWVoGQ42javNyl1C4IekXaeAvEB7IQ4GDYzKk0RpDSh6xtpT5eGwxoH4BY/WBOAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCqK8syd9wjRcRBg4QJ3wWQbjrZhRaXMWIDVH27tFTSZmdI4D
	lXsCCBdEXGhKKPerQ8Ni504CG81LknA/lQ54AiAVfNusjDLvAKd73Q18KQumCe3zvNY=
X-Gm-Gg: ASbGncvgV6u0sb36IRMRIYnzQVQSeltxjVMIA3DUClVPCU3QFI7sp2VnXeaVN8/qndK
	BK/JrVM6MUHIjPBgDTAcqcJiR7LzaTBRNY3FmKDV/2iXYuK91Q2xVdUQkU7z4M1C44ITVcYUm2d
	X6VCrVbfv2Gp1wzD1NAx0RKjMPAWm273Q9oT8f6iy5QAIW55uiP3owf+s8ik+8h6ldqE0WeJxB1
	PhCwUUpnl8r7Qq12OTWJUoabFEA73JeCzikTOcxCeGUxNGJ9MN96009aPH/dJWGkNmUzWn6+ECN
	fg9BJzl4JC1k55bs5UqQpdJZxwTfhCWwuZ+9RQjFiBdWSSuZdWtWxkbca4fMrHYl/YqBHdCdLNk
	7tt2nmE3+X7LaulgbQYqkqtB05EF7fvC/AdT5GIrrLXQ7c8+2YqkxGJu7pWGEGTn9kTFtsOM/Iw
	qKMOGQzNrhE8fhfF/vCAS0THFhBUZhqkkL9XmhMSpL
X-Google-Smtp-Source: AGHT+IEdFZfoyB0a7ipyiBqso5hQN6E2nOyD5VtEKAQ+Y8UX6OI7Mixp8oW53NeKonlQJoc+6trK8g==
X-Received: by 2002:a05:6102:94d:b0:5d3:feef:b821 with SMTP id ada2fe7eead31-5dd893e3fd2mr106592137.16.1762276562669;
        Tue, 04 Nov 2025 09:16:02 -0800 (PST)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88069246fe4sm11675776d6.11.2025.11.04.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:16:01 -0800 (PST)
Date: Tue, 4 Nov 2025 12:16:00 -0500 (EST)
From: Nicolas Pitre <npitre@baylibre.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: David Laight <david.laight.linux@gmail.com>, linux-kernel@vger.kernel.org, 
    u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, 
    Yu Kuai <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, 
    Jens Axboe <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 0/9] Implement mul_u64_u64_div_u64_roundup()
In-Reply-To: <20251030212924.35d15008efe63256762a294b@linux-foundation.org>
Message-ID: <r6541sps-1nrq-o4ro-5688-0p7n2ps0o315@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251030212924.35d15008efe63256762a294b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Oct 2025, Andrew Morton wrote:

> Thanks, I added this to mm.git's mm-nonmm-unstable branch for some
> linux-next exposure.  I have a note that [3/9] may be updated in
> response to Nicolas's comment.

This is the change I'd like to see:

----- >8
FRom: Nicolas Pitre <npitre@baylibre.com>
Subject: lib: mul_u64_u64_div_u64(): optimize quick path for small numbers

If the 128-bit product is small enough (n_hi == 0) we should branch to
div64_u64() right away. This saves one test for this quick path which is
more prevalent than divide-by-0 cases and div64_u64() can deal with the
(theoretically undefined behavior) zero divisor just fine too. The cost 
remains the same for regular cases.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 4e4e962261c3..d1e92ea24fce 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -247,6 +247,9 @@ u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 
 	n_hi = mul_u64_u64_add_u64(&n_lo, a, b, c);
 
+	if (!n_hi)
+		return div64_u64(n_lo, d);
+
 	if (unlikely(n_hi >= d)) {
 		/* trigger runtime exception if divisor is zero */
 		if (d == 0) {
@@ -259,9 +262,6 @@ u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
 		return ~0ULL;
 	}
 
-	if (!n_hi)
-		return div64_u64(n_lo, d);
-
 	/* Left align the divisor, shifting the dividend to match */
 	d_z_hi = __builtin_clzll(d);
 	if (d_z_hi) {

