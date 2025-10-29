Return-Path: <linux-kernel+bounces-876843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A25C1C992
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D3D660065
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A373546EB;
	Wed, 29 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1nHV+r5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6F1E2307
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759557; cv=none; b=Hsym06W7wfKjrqqLgInGNw3zvIDwrd5n0DHOMb1X/45zCJsk+f60xYECAtwvMj4nkzyg9oGE3+iCMrpFZHWfUxifyVK4iGtrdb7noOFZf7jwr4qgFf6wDVNYO91wwoHixyq4fFy9mnGVlKD2FUyyK4vawy3dGJPxv2LjPFSZr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759557; c=relaxed/simple;
	bh=zXxfYSuarlcdX7wkRJ5fQQu9ihnL5EPvoYU9sZehLCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJTbjPD7JcpdOmDcP+emq3Vy8zW62qaIje39IupSGfsaMpQnrPBKIeiIgpMiFiCRe+xAMBqaRCQqWuV74ReKRsoKBVbBCcxb/k6tuH5SZ1HVg93ZBXRXHsds+v+AX2jiYQV5yTJGsQJofF5eXSMbdMSNENT6zmJKwl8PQOCk4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1nHV+r5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso839715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759553; x=1762364353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd2SwmO3s42C6B+THDT/QkC+mSXRUeoaYVSZH4hdUjs=;
        b=a1nHV+r5qz4RTbf/O01Jw6p8+5TYzTrwuKHlLNctPnb/hG1tj3IWKLUDbYTdZR/wCM
         v66BntoxuNYXK9aGbs9Wq7QOF+bSBqTpE8U8SM/eck9gVCjyRp06vF+aWeWxggWgAmcO
         nwG+2cFV1lgTn/PlAgByDVpnIt0EdrPLKmYSK4eeCkv7l2vypOhsWL8ZSsH6/Q8uHOJJ
         VF9lgnMue+jvgP87hQp6sKMmI9FpBIY4IoV4Zbzn2xz3Ct7J5GSsPwGH25jW2F5NkTrn
         BcYe2OUNGstM4Jw0VF1JAMD/VRDDXN0eRYcvqdObR0u2qelFzxuaohFnl4nAaRUN9y3S
         LMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759553; x=1762364353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd2SwmO3s42C6B+THDT/QkC+mSXRUeoaYVSZH4hdUjs=;
        b=Giq90LjP7IKHR35AJYR1/q4JfRWEFIy9lpmBKpzbfN7MhEW3NKtF98NPKMPBaI8kCM
         IbGRLMmAD/AVJ7HW1TLxhYwgf0aQYBmg8Tf4hl8dufDPMiHOFyLTAhIHSjuWZCUcm1Sf
         w6Xoz4NFkWy3YPWvJkld8U36dmq9Qq0djaTSqZBuJ1YvZb8erVCY1ipwYhZLEyLM+07+
         7tygibn9WMPcQ6rsEBkjaA9MGxWNXfQuAUX3MJKqnB+cQSyehHgNSVFy/ppCehgYr5UF
         SDz4SzRJIsHPZWeSvGiOq7HJFtfoiiX8qMOgObDiFse8NgkKSzoYlDJ+7xGAmz9eF6pQ
         VzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPdgVWVxH+fR85HXi0/VXPFCRSUjRyC1lznXK51hdphNtLD03dDGoHczGTH4AMpFLAGF4SFGUHbnw+jPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWscOU7cbHRJtxf6paPIEN+XpgxvXSCyvVRdioMrd0/Xbr3zcj
	NwWaoPp4IRP09tF0Fkf8DrfwDE/+CgRcW1YvPOP41evfg0vOOsNJIcPc
X-Gm-Gg: ASbGncuuRRBUaDA+POAsPS6eDEZBipZdM/wzvkDDx1E9pS5olel8dANRT6AMD1KB7zD
	3G8bmXyOdaZx4wO086UrEQ/sXu+2t+Axj4tyQv6L0l9/5RpyHR/DO+B+rB/gdJGcfMaCppXPgX+
	k4ra4bNeopD/TPsRrGukvI/ee9j8Sa+6y0ckM6OBnMkj+emtD1XaWp0do7e/rXt9gXLww02X0vt
	Q1NKcYRS4DtUd12Cm06F5TzbAge0izARP6iXvLE0G1J29DYZdrYa71HkTi+gM83MDmgOX+0a9Rv
	6BE/G715p4yRXt+vQixrhizv+VffYYiOXZ3wq5UyY1RbthdMd8BVXHk4zikwAEHsvgFBzxfN1mR
	JThD/ErdZk3wdl9rMRfiVNMHR7mnrC/JOijugM2gKOiqYaub+ZS0PV0/zkVntiDJDgRev+/RK2B
	xkjOiQxK1WnMcUxf1g/zzqxF8cpswnzCiHiOsQp7MUg6ZuMaVqApgZXob2+YaA
X-Google-Smtp-Source: AGHT+IHhr91+Bfr8yPDxQuAt1LS8V31mfkbT0U8xn6O5zXuWwhTctTa0JaAaXvbdZwX5WjAK4Fv/Kw==
X-Received: by 2002:a05:600c:3506:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-4771e3b849fmr37597855e9.30.1761759553398;
        Wed, 29 Oct 2025 10:39:13 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.12
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
Subject: [PATCH v4 next 1/9] lib: mul_u64_u64_div_u64() rename parameter 'c' to 'd'
Date: Wed, 29 Oct 2025 17:38:20 +0000
Message-Id: <20251029173828.3682-2-david.laight.linux@gmail.com>
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

Change to prototype from mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
to mul_u64_u64_div_u64(u64 a, u64 b, u64 d).
Using 'd' for 'divisor' makes more sense.

An upcoming change adds a 'c' parameter to calculate (a * b + c)/d.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---
 lib/math/div64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index bf77b9843175..0ebff850fd4d 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -184,10 +184,10 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 EXPORT_SYMBOL(iter_div_u64_rem);
 
 #ifndef mul_u64_u64_div_u64
-u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
+u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 {
 	if (ilog2(a) + ilog2(b) <= 62)
-		return div64_u64(a * b, c);
+		return div64_u64(a * b, d);
 
 #if defined(__SIZEOF_INT128__)
 
@@ -212,37 +212,37 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 
 #endif
 
-	/* make sure c is not zero, trigger runtime exception otherwise */
-	if (unlikely(c == 0)) {
+	/* make sure d is not zero, trigger runtime exception otherwise */
+	if (unlikely(d == 0)) {
 		unsigned long zero = 0;
 
 		OPTIMIZER_HIDE_VAR(zero);
 		return ~0UL/zero;
 	}
 
-	int shift = __builtin_ctzll(c);
+	int shift = __builtin_ctzll(d);
 
 	/* try reducing the fraction in case the dividend becomes <= 64 bits */
 	if ((n_hi >> shift) == 0) {
 		u64 n = shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;
 
-		return div64_u64(n, c >> shift);
+		return div64_u64(n, d >> shift);
 		/*
 		 * The remainder value if needed would be:
-		 *   res = div64_u64_rem(n, c >> shift, &rem);
+		 *   res = div64_u64_rem(n, d >> shift, &rem);
 		 *   rem = (rem << shift) + (n_lo - (n << shift));
 		 */
 	}
 
-	if (n_hi >= c) {
+	if (n_hi >= d) {
 		/* overflow: result is unrepresentable in a u64 */
 		return -1;
 	}
 
 	/* Do the full 128 by 64 bits division */
 
-	shift = __builtin_clzll(c);
-	c <<= shift;
+	shift = __builtin_clzll(d);
+	d <<= shift;
 
 	int p = 64 + shift;
 	u64 res = 0;
@@ -257,8 +257,8 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 		n_hi <<= shift;
 		n_hi |= n_lo >> (64 - shift);
 		n_lo <<= shift;
-		if (carry || (n_hi >= c)) {
-			n_hi -= c;
+		if (carry || (n_hi >= d)) {
+			n_hi -= d;
 			res |= 1ULL << p;
 		}
 	} while (n_hi);
-- 
2.39.5


