Return-Path: <linux-kernel+bounces-823061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E31B856D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956D87C4E32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1502367DF;
	Thu, 18 Sep 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8o7GE2s"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146422A4F1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207668; cv=none; b=du8itc9aX5IZ1u/Uy60TKRblagfUtDA7BviUKLmTp8ieVPN7prFzOBDPqiG1aXCMn4jPGP8stbZLGPOX1yJlrMptE/oxKgdgkqvVxEiPeihCbiXgFXSA6dj0hQhhqYf0Y/A+Aqp6PTNYmKmODZa2may8PvGdjS8GEDQ43wr57QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207668; c=relaxed/simple;
	bh=BsgbLzi8ykvPS6jo1iruqUwjXtbQRUgckgzTsgqQuRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbxtBBsSO9otxubtRryWP/Mj95o6ZblOUv1q60u3zD14tt/zyIBEoOfIc+FW8cjkKi+wIPg6U1eNteBOdvgm+MCSaxuX5g1vyyFarMe2mYIA/gHMmSrNo9nQYz/P3Wr6fV/QreZFmMbTOtgOpKSDOOqbY6EEEKhG+jgSTL6g2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8o7GE2s; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7742adc1f25so842971b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207665; x=1758812465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXM1tE5z3e4zIfIy5XocMUApUPbo2Ex8jjAHwT/2auY=;
        b=c8o7GE2sd2jEknOx+5kBt8uDYT4hYeepEl5pDywIrEbRu96OQtTZr3ABh4HsDUDu2h
         e2JxgljErFZriVePnBPEcd9anu4YHujfVTQiIbz2BwjgD6OyuRsQrd6N8DUl7wimmoDr
         wswscDO5/t1Sg7ez8cM8LeszYwWWQHGjQ1qnNkUfNTWfJhfuPq0p5TvYZuhCKwpq1k0a
         CTOVYeEp10/Nen4xRihNZnbHKVQwqcIMa16U539cslGw31D303loZ3M7OgyU4Qik8l9G
         DbqfFqaEG0i2hBHGE5+tTE4rQ15e6LooJG17Xc4gpWI4x4T/CeB8XAXkO6ejVc2aABL2
         /SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207665; x=1758812465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXM1tE5z3e4zIfIy5XocMUApUPbo2Ex8jjAHwT/2auY=;
        b=KvYpsFqBsnbLnh9XMsO51+hqygWJQ6bMWEgdENE2lIuUUFEgnRlVR1YZmczMIwTyIg
         s4XesQvnJTU0SEOWPYdentWNDo3qgKYM+P9Qy1yPHcQzv6TiND+icdJsxcj3FS/JTaZv
         S0ulpQIzq/7sb6oPSANCx9hfUsFGTFM9zbryui4enO4fbqLgBM1Lt4Vskv4hghv2dvFg
         zGPhJMCxBK8Od6hJCL+XfXbyoUJm4EAU+reGZ7vcDvZIU2WP4tiFTLIgNzCkar3MJJDQ
         JyU7TrXx6QGfQg3Xp0amW/Jw2reVHtS9W83l+uHv9o2vEOwN6Ij2YmtUBHbhml2ZFbIU
         Sarw==
X-Forwarded-Encrypted: i=1; AJvYcCUXxrv/+NMNObPcdRmscJV+dlLN7z6G2kmVZ+LjkdSJpDbw9EzINl05fFTT6yHGT92lGZM7ph7SEKJ0Pho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56b6/5VxKP9KV8tOoASTr1VCb+32/jYxKRO89GCPaYj4Xa6wN
	7W3GY/VwRmzWXh79LHh/FBnM93VE8IcMoIy6/n6tbb/Sa/W7Zf0KaqzITbR6a7B8
X-Gm-Gg: ASbGncuvfieLtMrRD7L6W+oQ9oajjSdEFr0gdTfvlrdeK6ZWu+C5mjsRo9E3rpZPNjE
	Sw6ZZHeZ7eh8ZR+rOoGI25rFfUUJ7d9qMtV1Nf6pY3qQ/xBel6ymn7Q6/RNBP8dTypkmM6520sD
	cwIrLD9SvMFefjtSU7xCfWpV5qBSmtSWDSdFIkJiFI81vbLmbQsYiQxLMceAqmbRVVOuursoMry
	aMCuYuzIkqHdgsrShXCdi41s1E7O0BdtxgwtI3uyj/my1yAdBTH9pl4Me6tg6pCbkDKZyw4XhRG
	lczcoiwGkYp7w1E9ce7VPufyCbRJlU8ADf4qoUwrgAOgBVfopnRbitkR3eRU/TR7uq+0GThI5nO
	o2ufQv8yyQQzDO0GHmonxYUoW/Yd5ASCQAbqR/qzxrKPd6tqKOcFvqIFLteiFuXL9ag==
X-Google-Smtp-Source: AGHT+IH+J9A3txSiiKsGwoZYqM/WkCKpiuJbHT/7NSTE/twbx2+d6WnfUG7cuj7YDeh4EAjo0eJHNw==
X-Received: by 2002:a17:903:1b24:b0:268:15f:8358 with SMTP id d9443c01a7336-268138fe34cmr88902925ad.42.1758207665172;
        Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:04 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 1/5] x86/hyperv: Don't use hv apic driver when Secure AVIC is available
Date: Thu, 18 Sep 2025 11:00:19 -0400
Message-Id: <20250918150023.474021-2-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have
hv_apic_init() return immediately without doing
anything.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..e669053b637d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
-- 
2.25.1


