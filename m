Return-Path: <linux-kernel+bounces-823065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41FB856FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0E7E17FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB730F922;
	Thu, 18 Sep 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX8f40vZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E230E0C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207681; cv=none; b=IqiD2WwzGwXptBqnQrOW7nt7S4u0VW+pptHrjIRO0ztUkq/qZiR1mJRPgPfp3zhGOYBxmc9IB+nvMiytcfvXOrEwFZ+I4zLhyE+lkhJi2GZBVoorBld2Mkq2i5au45Wtja9JVqhUh0eMrabz3aOtuniEqyNay/UICtRWF/dQAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207681; c=relaxed/simple;
	bh=eVQr/Kx6NZQK3rRjt7zFL4OZxVMPYo8FaFD5GEZkQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9msGjFHLQgOlh/Udcy55XqwiGTzbb1K85qA6Hwrfd7hWHWa4w1koCCqp14ji9/EV2dNZ0BiZJJOkr4sin5dGUaGgwNnkVF7PerOmT02v9rflC+TfffU38yN84f8yrH1Me4xFUBIwo6sB2aUEb81XvDeI9fMWPAJEx/2fytfhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX8f40vZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77d94c6562fso717006b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207679; x=1758812479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG0jro0uTdkJs/pzarvH7pNTSG+qtFn+7rA2b+WmfoU=;
        b=cX8f40vZbQapzX8D1VSxwmrNjoJxNqWNoWGiLwgrBITmSpWCQ9mMTGvm8YMY6vr5+7
         R4MHIIzCzO2a9M7drYcChZlBox3pBt3vVRY73tcBDsPnJo4YDYMy+jrqFn4AyIfuArR1
         e8uEDu22+zLsZYgymsdiCIpzzpMj/J8ezH5yImJiK/uLGbDcKjMzWvQOkifL7njLWE7W
         Dvi/rPT5fgfhalEi0gIty3B/p82ZTftPwXFXB82tkuk5mfmIY9GKQ0wP2XB1qzo9gpfQ
         3xDn7k4+avHOD23KcDeTwGldoKQ0yVUPKTshsQLZBvARrrCMBbY2vOliDScv/YKe+1BD
         hntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207679; x=1758812479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG0jro0uTdkJs/pzarvH7pNTSG+qtFn+7rA2b+WmfoU=;
        b=G3UpzljM04SSvfVu8LAdSVm9+gHd9TF4abmM00UH4zy1GOoSM1ksesTM9nOTn7F3oO
         wykfqt/qzm2PKIJFO0qKFLSckhI92BD5BTaCUtBFZQ1Eq4gAOf44MrPuJlatp+/G4GbJ
         w2CMu7xIuhSndAaAK5ArMG8TaG4wDzYfL3S8y9NsWHgk620lLTKxz0BQm2irh5blInku
         pXXtocWzFkTbE/9ESfc9iNTpHkhaMJ59arKE2cIWNUeSC4ugI4eNN6jgkN89OhycJ0pU
         SkEPu57nao9SCa6aAc6blZ2kX3dV5GCLDelrVkTIgkZ7nzkp7jR5ZzvqPyUy9vksvpWQ
         XsVg==
X-Forwarded-Encrypted: i=1; AJvYcCWlnYxKlQIMbxnbfsH2uTCryZA7tY91NWFhmPugRRUpgT9dfqO1JNiW8SO37Fp76wT/CnjcATyXOOulU/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzxJBs2bganb2gll1BDws4zDdslN0sDE5MOfyE+dvTtHI7Eoi
	K87Xm86yE9V++wbopUI9oa0Y6cGmvCG6CJwbBP6MYseo8mJiUPF3E1FQ
X-Gm-Gg: ASbGncueneCuyQ4L8ZDJEYihtOsBudTrjTmCnHnSMlZ0SBaPZP6idl4KKPv/hEA0jN7
	FoMTUBSK4aYwJ5XBUyN1jPPkV74rWFgTnIALCaFy8A4rSlTSiO2tyafE9fv2Dxq30RQdjKUU78+
	bBn4CPNuz3mx195FBN9k3/fKWKSyOXFZGB0wMZnRXwg3MQwpDPjz2w2vw8jLgSGw/nzRK4pHnHX
	J5DCr1WM/U10d39ca+zQ6A+jIKeRfUzPJvJ0fKDXeOQVY1qgNVj2uhEWJ4uxcWKG53bXAoklzyO
	WDsdbb8JqaLDLzn54SYZy7q5UBiRIyUC77l4qnUSYefdOHwjEak71ExLmTIazQCeNKxx0OxkDrA
	KIA7jwGSXV7xZ6fUMMuXpekPJIAHRpMqoyHMcCzX7doimp5E4UVBlQu3Q5ah982CYafrMv044rL
	uS
X-Google-Smtp-Source: AGHT+IFLnIbH2uyT2zEhKLQLVqmq/YgG9sNgP7kOLxvII749sNXuGepABW+zJ4LvDcTkJfKXX8GKWw==
X-Received: by 2002:a17:903:124e:b0:267:cd93:cba9 with SMTP id d9443c01a7336-268137f318bmr84863505ad.35.1758207676944;
        Thu, 18 Sep 2025 08:01:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:16 -0700 (PDT)
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
Subject: [PATCH 4/5] x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
Date: Thu, 18 Sep 2025 11:00:22 -0400
Message-Id: <20250918150023.474021-5-tiala@microsoft.com>
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

When Secure AVIC is enabled, call Secure AVIC
function to allow Hyper-V to inject STIMER0 interrupt.

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index afdbda2dd7b7..a38bb96c9f5e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -133,6 +133,10 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
+	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
+
 	return hyperv_init_ghcb();
 }
 
@@ -240,6 +244,9 @@ static int hv_cpu_die(unsigned int cpu)
 		*ghcb_va = NULL;
 	}
 
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, false);
+
 	hv_common_cpu_die(cpu);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
-- 
2.25.1


