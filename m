Return-Path: <linux-kernel+bounces-887240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95468C37A47
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF0A3B3975
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B085345CD1;
	Wed,  5 Nov 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja2xwrdl"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062E3203A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373456; cv=none; b=oy4BcORdX8z70Da7MpAGzVmCD6wKa/jK5/POCUrAL/mfDWcvxIns4c2VFPTpCgsSLFYgHfY9usU9SXQmYL5xEnX6MHLTbRHGHwdl/ktqG5gzqIzZsSD8Gaz09tsImOSEGqrLepLaenIic8xcpqIpwfnJSRMnHvQiniY+jy/UC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373456; c=relaxed/simple;
	bh=y6LNer88uh0HuzeiccT8aDtkO9mUG6rh3Xseiqd5Ey8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYruKi3FANOCWCDTLIe4j7m9s8XFL92fkEDDtEMASl1hKyo0a5PaPSOHHDkCkXkrd7pU975t1tbPR1esSzrRoAKyCVRcfmvdXwx6biQYVe/qes0u+mU0WBh5k9JV4mixiFCbcqEngh7OsoNY6OxuHLwat15wR8LSC15t2tFsb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja2xwrdl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so1276255e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373453; x=1762978253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUBbmLbrucox9uCClvSdAxdwcj7AhBFvDyn0xKMfcrs=;
        b=ja2xwrdlbVOPi+cq1Sh0y7mBv+194rVFoQHF3IYpSdZwzoXvkfKEgwWWS9i5IDsKBh
         6HG+4Cp7iuwYDmwc4aSQAmTi0oKIm1IYZ8ZldtpHiV+23G7ImhimKUYfF7KkW/hLzED9
         3F4A/6ExWppFg3oMlqu7qB2n2nQif3zw72naY4VCjOl680UixRkdbJ4fFuOj88fWdTs8
         VLmA++8Xf05ZynYt4DNPM+/HLgovHGbf3nOS9ewrhf7jSv7qNvZPiXgaMeS19rzskjb1
         vGVKGdYJSy0OUmCtBdBflXs54hCtN+1Oa9meL6b+NL0ZnybVzi6P4lSr6M0VgRBvPnw+
         6cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373453; x=1762978253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUBbmLbrucox9uCClvSdAxdwcj7AhBFvDyn0xKMfcrs=;
        b=bL5wLipD8iSb8HpN/Aqok1zWmDgSu2bAiM1G41rEOsSXjM9DbM/nmNx/1XXNz6Ikaa
         iEz3HJHnNxyQi5e8wE2GXADE6T9IX9xr0DqtS7ciMNnLmnX4e+Iex7ATvx40gayTVTLI
         DGWldgAY+kaTzwDW/aZX18+RcKI6r6ecvinWurLTxJQdPc4DLXTrSfL/Pas575PZHc2Z
         uHL+qEoAf+4Db1ASKf8WHxGPQJ773PC/59k+GeL6xyOEFDFCXMJLdsMbrg2zEEl3EGcD
         SXejPnKq6FeLim67OlnSzD8rn5401ikTed4gJGOc+tb1XA45PqT9G+C6rJhAK368xq+6
         VAhA==
X-Forwarded-Encrypted: i=1; AJvYcCWHE1jk0l3RtdjFFaAZxN8OW0oAzOh9dTj3Uoyaha0IRcXJwp+p9xZkFcd4Kb2V9DIDdLF4hSZ3r70dW+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOB45IjT2oMtlma2P8WNPKAa+vOoLcu5AU61lqgyL0yEyigrVC
	N8DJfOryXrFlT8Em0W0oLVWJKjMDwsfsx2eglN/OVB9Tgo8djBW75Hdo
X-Gm-Gg: ASbGncujySbUXGDm+F5/j5RzLHsZURMS/GDPUsoVLrJR9Yx5B3tph/o2bxxVC6rpaX1
	OG38YMr+XOvzXiuNR9znAGbkYz/69Mfy99ZZPAEd3MOY0Lw2FIvcg8TxapXdvZ+bHeNZJXnOwQc
	ShDwIYnKqrHFMm4aH7jXIN4gvjk4adYizUUOzm+x/ipH2Z/F/PArdeGRonAkORQF90OxpXZ9u9I
	V61xaltF1zUU52Yckkilp6mvTcULJcnlat0HbNSw8PiH919qYEr3cnHqoOnkJ4fTiV8Uv0PH0/U
	Vu4EqmzdL69Rbc3c8QddOwDQXM/yHImg72k941UAMC3Oa7OtX5igxAbLE8YW1kO0LSd2Qj2E9F5
	QK5lEPDO5DUmB2f+hNj/3vJjd6QR/pgssG/V5CqfK/7KhpK9scg7ERoYd7PKHcEEqkbTH2z5l0Q
	CdEmxZV2UVoX5zVrbqdPsYbm5PRX/JLA/VQOUbMItsckPiVbEegzQD1kXGo2oTSVGty/4RH6g/
X-Google-Smtp-Source: AGHT+IHDBxFlsBIdPH8XlgV+0m2kGnYHrAYLuJDDatQcp9SAWJx1GAGMDuN7auiXQsAIDvLjgKS7og==
X-Received: by 2002:a05:600c:4e88:b0:475:de14:db1f with SMTP id 5b1f17b1804b1-4775ce19f93mr42387865e9.30.1762373452762;
        Wed, 05 Nov 2025 12:10:52 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:52 -0800 (PST)
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
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v5 next 2/9] lib: mul_u64_u64_div_u64() Combine overflow and divide by zero checks
Date: Wed,  5 Nov 2025 20:10:28 +0000
Message-Id: <20251105201035.64043-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105201035.64043-1-david.laight.linux@gmail.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com>
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
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---

V3 contained a different patch 2 that did different changes to the
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


