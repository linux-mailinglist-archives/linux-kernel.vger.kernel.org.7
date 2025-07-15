Return-Path: <linux-kernel+bounces-732372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF5B065DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB3D1AA6F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A42BDC2B;
	Tue, 15 Jul 2025 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSmn5Hsx"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B401DF98D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603507; cv=none; b=Ldk+rSz673SM9wSDpaTWyOvG3H8D0HBuvem09F4rtqeWEoGf+tPkDkKBKPELusMD4oA1xkeExdeg7axTnmKnbKwMwGro+GgXoi6sE6KmlqA8XEJTQR2AnIDxDaB0qa0ls6J5yt/BK8FVqYVEAtHr6PA9mmjPYFMc7ttQij9AqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603507; c=relaxed/simple;
	bh=qcvqc8oLaGRLuXSRpWox/aDYP69XfzCOSQXaDX8oV5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpAuoNWa1JGGgiMxOeoR3mSzFJnuzSN+Rb4kcMQY/xWlvIMgO7wYMdPwRHRsEkQFWRlU2OmVHrzU9RbiB60CPUlN4bR1FOg3QELx6PTjir/is1oB1kjKTaTs8AtneBO39kWVF4ikrVQ4FZhgKRgcNHcT1SA/VBysZ2ys1jPa+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSmn5Hsx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561607166aso20685715e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752603504; x=1753208304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVuDVmGf7oesqGybYnWb6Y4xeT4D+EHS0Aob/ILQknk=;
        b=KSmn5HsxKKacsG/bSkOtnN25EP71FqPuF4+2xwTgrVglESNVyu8lMjeda0v/lE7rIC
         nrE+PWxol6TM8CSGCuJZRv4aqwLUG9yIbSgl4WgbsdAOIRo+eG+LBuszNPbWGbH+6UwA
         ojExV9152/PyF6i56aANPaOdDaAM+6DJhMER0X8Cwe7/7UvcG00Iuo9WcGyf5bHMF8l2
         7v56w1H4W1J2/TY0YVkwG9ddO1UMrCHZYTazxopalZEL0mWxQ59O6/nIfEYX+AjVfkVV
         4gKck0I5oUXySK6MjFm1hO2e3TCh1rBxR+Ex+MPlQdo5mL4MzS/Wqmz6Xug4yukl537Q
         Bcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603504; x=1753208304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVuDVmGf7oesqGybYnWb6Y4xeT4D+EHS0Aob/ILQknk=;
        b=BWhCEBGKTdm/lxTcJEs6R8ct6JsIbv13/iHkbKQrRVBT6hPd9M9VTxHfVMzOd3sLqh
         4k+LEnY7lYDJMMwdaqEUC9QP6gXO8mbcR4lTYIvE3bNu+r7N3Ghos4vwNT0X8p4C7m6R
         BjudjOvTdtvaVRMXpSY3RjQUIUSEj2y2N/DKEkPkApK0JZJGqXHSQIgmoXnGeE/WJxD4
         cqLwX8XvPvNC3PPsZPM7ug+VcWHwGtCUJQiz3n6YOc9CczcZikUOVzvxQ4Ifw9wftBDf
         n6nCcWDU+UpAKlttHgycVJFthmp9kJ8CrwVfdBWc2e+1IReWoqpD/F7oP2wT+P9uLBd+
         JFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYzqDtHZq4ZFBtHLRRDlwvMLWRsUTKKOYWzxpp7kOkzGpRbmWY4tQ1ycuro7/CKG9AjxBQaoe9w/krGzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKon4a0mffBFWi4uE2TVod0f+LEX5lBWrU7nYPZbUF5QdfnWgT
	ECC+SxFFsPjjJSC+vCwp/gaWk1p9OXrwENobAmiwLEGvePj+nfpjwV/A
X-Gm-Gg: ASbGncuM4N1zKO1n8biiEhii0kK0f+d1eQyXct+DOn0unR9hnKVunKrjwQbwLS8Ne/Z
	mM8GK9sdjXwgnaKLwigvyPxNQVGhklkqCCsLd4/9sXUnhduqXKyBSIuz6g84FbwJnp2j1lvQ1pQ
	tU3wIHFGJ/oeRjyHEzlj5cCDk6UoFoiCYwbtzrGX6iKcTbZgtutH7qRme/IBV/kXtlEPtlRtRN3
	3Ma3BEfoQNLD6rPMH7vD8PJWCW4HNE2vGwQNIsnx7GQ5ZYIXQPs8P5LEFhnZOOEEszuIcVhZ3iC
	7hKDQH0Kf63n5RhXcJpvUrTqZ2VeTYo4dNrFVkUeb1Zs6BGAwNmQhJjZWmeLx6xnydgVACoGIfj
	UdpgpUlp3g1tme7KN854TNHcIdLLV2/soJhX9
X-Google-Smtp-Source: AGHT+IG6eCGCaaHJMRbIGELke0mffzAEoqDqKwwHr2pjG1SgUecI96A1UlM5mGQOvElx0Hsy0VRaUA==
X-Received: by 2002:a05:600c:c0c1:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-45576aab8a3mr113062375e9.33.1752603503993;
        Tue, 15 Jul 2025 11:18:23 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45626c8e104sm19329965e9.0.2025.07.15.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:18:23 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	ardb@kernel.org,
	ubizjak@gmail.com,
	brgerst@gmail.com,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
Date: Tue, 15 Jul 2025 18:16:10 +0000
Message-ID: <20250715181709.1040-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

When Initializing cr4 bit PSE and PGE, cr4 is written twice for	
each bit. This is redundancy.

Instead, set both bits first and write CR4 once, avoiding redundant
writes. This makes consistent with cr0 writes, which is set bits and
write once.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 arch/x86/kernel/head_64.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4390a28f7dad..dfb5390e5c9a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -222,12 +222,9 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 
 	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
 	btsl	$X86_CR4_PSE_BIT, %ecx
-	movq	%rcx, %cr4
-
-	/*
-	 * Set CR4.PGE to re-enable global translations.
-	 */
+	/* Set CR4.PGE to re-enable global translations. */
 	btsl	$X86_CR4_PGE_BIT, %ecx
+	
 	movq	%rcx, %cr4
 
 #ifdef CONFIG_SMP
-- 
2.49.0


