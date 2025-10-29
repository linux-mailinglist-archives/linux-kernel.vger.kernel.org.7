Return-Path: <linux-kernel+bounces-876845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38494C1CA39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D3F660C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923D354AE5;
	Wed, 29 Oct 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4VKdvMA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8C23D7DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759560; cv=none; b=kriArMv3aaeZKdbrqrpHzkfkjfKopStyjwJAV1qz2BXrbehrutAV045g6Zr0RTkIzEtf0WTPoFSG2BP2s56+fZAqhV1zlBT0T9W/kp+dcC+Lv5h9GF98QkamC5bpu3Z0aekLuGieY6GUcM6TGFb0T6cxLvunw5i6M48PyoTjjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759560; c=relaxed/simple;
	bh=MKwhK3JcbaRztRiku8FMycQox/iKFVXWtOASr3ZhwMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow8/Vf9mEFRcejH2wqq9E9wSbHvIh4af++5IK7gE4awmClW7sv9db5DaKx0tOp3p3M0DWRnHNULKSO55XY4XaOST5/CyqsNYXMGdGs4iC2EPDblqy1M1H8GEToWmYfTfqui4LVuDPs1g146LqM5yRoT3SQgreygEeD6anT/zrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4VKdvMA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47109187c32so569035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759555; x=1762364355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73i5y2n0GA2A+e7j+S3Mi6jDYb6pvGaIa2tmoB3gAh4=;
        b=T4VKdvMAcCquhqVukaMoTg+9l2O1nAUx7u73STIemz+rvARfWihrEP8P4NUb317PLI
         zUBBj5ShXhS+LTZ9yQbtlys0/+W9SAYEMpkz+5+RMu56lHT4Od1d+zgKP2ecpFiFrh8R
         EoZTf9QqS6oiZcARek8FElHB5Rnxdb8uxbp/H7PuhhqtIgCLjFhxhyWDIAkdAVDX0uhb
         Ihho9BUrY4LdhHWcTL7pUjYd4gRjwTag9JM0w0tzJBWmRi7SHTngHi7odueeZwJI+gVH
         /s5XL6KM5P886AYZ8Qq3Wcj5+iVHQNeNMkdjjK+hJf7r0m39yp4o8XpH1t0PuMVeylV2
         0nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759555; x=1762364355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73i5y2n0GA2A+e7j+S3Mi6jDYb6pvGaIa2tmoB3gAh4=;
        b=qxNPECcPU0z5PsKtqKOa5O3ohd3iZQeYE0S2GXYf1JeVEJXTJMXyQg5PPeeFOWk0VH
         UD3gI1IiinURwXve/x4AJrqhFawfVmXA5Cqr0zUkHDHJqdQP94V/sWDpfPj1VKrQE/su
         kkPt3KUxEBhO8f2p3HAUft32rrGJD2NNUjW/3k44SxnBXIhMisLdcu4EuXJcppOhPs5+
         kLY4dLpZgsy7wbzspUMPYy2sHeTq0+eXFu4TUowSor28xx+V64G8QcgAzB5hPsXTuucn
         BKMR4+ti/2FNpFj1wP1cknphF64zoL/0vmeuKCTrLvmxyPs4zmFJOQyfdfQt2dMNaoC5
         12xA==
X-Forwarded-Encrypted: i=1; AJvYcCXfmZwxts97LDnomFpd8CV9cmNYxk6dbpxxxY5U2DC2syB2j1+XPaa29cRMeEnr33r+YTvX+9fPu2DBego=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4A5sZTFgLFXBe7OUNLJd29133NgjY4pi4ecCpSy1WBT+T7Lnf
	n7UQZkx7qO5Unf6sJjNCWuM4aCeUavnqNSVDiMipNO/FaKeaGjH+MRfv
X-Gm-Gg: ASbGnctvihFXc9Y9z85U4dEEvQpI+QOVZwfcdR9qyrKuqEjHFHTbb1z+t9+cTEFVoZK
	YTWbvTVhZjj7wTDA4M1XXu0JOkeMxO1WDV2F2cyHU2X6r+VE7gkrs469WEZBRl7Uj67sqRNsavc
	A7yStsGJV6DDNws7l+4XFZbdRmuYz8tceDKO2bRE+lemEi+aMgFr+RLGjjdV7jAHuw0bJrFkxVk
	QCmz0aMQmddzYzTRbK93i14ShxTJs/Pu/11XvMDLde+Xm9c/adMb3774Tz2VAnk84l86v6g+9fx
	Iva4LW0QTRrIGxGBnp2R0DiB+5HoPd1h+bvHFom4Q9G68qvOQhu4MiXsveTCgv8smgd32GtHeTu
	4AYGGic3Dnq3U3JJZowHGsTDPzIPbE4gXHNVT8S9cQoD8U0yUgBKUJGX2QHMb7cNRCUc5EjGIRA
	k6tV7zXXZs0RYIgJZbLoNFhMaUmY89JLZUeN5ZuoiupJPgeI0k2cjUcNNj2S/FWmijiJNTE1s=
X-Google-Smtp-Source: AGHT+IHDRSHnAfg1acOm/XZuYqhG+cfYrkmYCtrskf/kG6Ag6vPjm8134fKm36AOnpOS+6umWU41yQ==
X-Received: by 2002:a05:600c:45c7:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4771e39c87fmr30450815e9.9.1761759554909;
        Wed, 29 Oct 2025 10:39:14 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:14 -0700 (PDT)
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
Subject: [PATCH v4 next 3/9] lib: mul_u64_u64_div_u64() simplify check for a 64bit product
Date: Wed, 29 Oct 2025 17:38:22 +0000
Message-Id: <20251029173828.3682-4-david.laight.linux@gmail.com>
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

If the product is only 64bits div64_u64() can be used for the divide.
Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
simple post-multiply check that the high 64bits are zero.

This has the advantage of being simpler, more accurate and less code.
It will always be faster when the product is larger than 64bits.

Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
(for the low 64bits) even when div64_u64() is called - so the early
check gains nothing and is just extra code.

32bit cpu will need a compare (etc) to generate the 64bit ilog2()
from two 32bit bit scans - so that is non-trivial.
(Never mind the mess of x86's 'bsr' and any oddball cpu without
fast bit-scan instructions.)
Whereas the additional instructions for the 128bit multiply result
are pretty much one multiply and two adds (typically the 'adc $0,%reg'
can be run in parallel with the instruction that follows).

The only outliers are 64bit systems without 128bit mutiply and
simple in order 32bit ones with fast bit scan but needing extra
instructions to get the high bits of the multiply result.
I doubt it makes much difference to either, the latter is definitely
not mainstream.

If anyone is worried about the analysis they can look at the
generated code for x86 (especially when cmov isn't used).

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Split from patch 3 for v2, unchanged since.

 lib/math/div64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 1092f41e878e..7158d141b6e9 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
 #ifndef mul_u64_u64_div_u64
 u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 {
-	if (ilog2(a) + ilog2(b) <= 62)
-		return div64_u64(a * b, d);
-
 #if defined(__SIZEOF_INT128__)
 
 	/* native 64x64=128 bits multiplication */
@@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 		return ~0ULL;
 	}
 
+	if (!n_hi)
+		return div64_u64(n_lo, d);
+
 	int shift = __builtin_ctzll(d);
 
 	/* try reducing the fraction in case the dividend becomes <= 64 bits */
-- 
2.39.5


