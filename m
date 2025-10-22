Return-Path: <linux-kernel+bounces-864716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA8BFB66A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBE905032B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CC321F20;
	Wed, 22 Oct 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fg8JtWvL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D222322A24
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128785; cv=none; b=C4xR0AA98r78TH8yWwWJdMXmc+oqL5lR+SFPqoEKd7kKNVlvpQgDP2t4rvti7OccnIq9ZB7hVTsLgPRQKX1q2UJE4QC+esGjrZDkY0S9VBXLovYp7nVBKOProGC1u/Gpa0gjUClfnvoFRQnBm/h6AMUYYmL7BbQtv7mBCjnME14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128785; c=relaxed/simple;
	bh=xks3pzq509NsNrjTHZqfSN/c9dZ7LmayYUa23B1o8k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd/Bw227YcjTq7bITioVCDkZ6G1cKZSxct05k3AHFzDrlk7r/zv44YOaW5qrS1yL5ORX3RJHVoC/aCAHlutqSGevlm8HBJ4WhkshCng8TbBsReEdKxvpGUmVsDji7zFRda47RzD5qzAvxUfaaNdliLEvtxkUTYTUbigIqz4hqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fg8JtWvL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426ff579fbeso798386f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761128780; x=1761733580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alcVKMUt+tlMZmPP/SPA6cWASZ+xss81mljJu0f+zw4=;
        b=Fg8JtWvLUXaBiGysrcBk2ONWj+1W3ieq9YG8JCmOC1FTZYjjL75ek4pY4ywjT8NBv8
         /Hs2y9GRwNi/ku6ve0jNllz57XzSe04qFXY486YncRLFWhFw+0ggqBCbkpcXWuzQCAx8
         zWuFGbWdO7UkMaRME+a7a3Xxm/UYdLl/ec3vgAKn3zxXUALHMT8pFXfXiRhadPfit+dI
         uu5gSlegCTjpkZLBwRxz1EPGJR9WCXRxmv93zllrHnD33JboZFgLCDtDRqoEPkR0ObXd
         57hqSqhDwLFDBD60oWWV0mzQ11TKhBMD7aKX+rCro2/K8q1/NwJ+fNSbl1Og8aVrrv7q
         zyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128780; x=1761733580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alcVKMUt+tlMZmPP/SPA6cWASZ+xss81mljJu0f+zw4=;
        b=xGeM6JL+XCAX0uEiSK/kpNUjTRoyOoNYX9hXs4Qe4o4qKntd1tJCZCIcYBOukCvWhV
         zCzLBIDS0oaeiAgE/FRKM2PvfeaE/fHEvuuCwfFj+/ycjEFBE4LV35X/jc63OFhD5PNM
         zsEbalW2XUGuc6pgCtNqk8hFjdSx7DDPytmBaGsC2FPGekwhBNcUinu3LUFYKsgQTp/0
         tkp0tByc1B+RdXOjHKKq6povQ6CN/MmCIWjy2cFo95HdXpSssHWy2v3UOVahUbxFbfvY
         dx6ZIQuIHAuWJsdZe9xk2rj1VnOY5jChvtMvNxgIfZ81H0sb5LdM1Mj5l9zmz5E3Croq
         e2rg==
X-Forwarded-Encrypted: i=1; AJvYcCUUGl+9L3tM+skcyOzTkngp64rFq9CnFkETKKmWI5g1+r3q/NaprWuHFzZjVVN5zftyKG5f3+qu8ltnWZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJ6xZRAiz5huHMcjbc+k+Eve4sOZfXhlQ+JElNPDhdqEBTLAC
	86Vddc45GxWOarzJmk+/Ye3YTzRwUR0BiyCUel0LbXU7h17vqUleVmqlCEM/YPFD0AE=
X-Gm-Gg: ASbGnctNvOZkgbyNnNSTRdjGDtuWIAPnVDpAFytIP02F+qN+doLrwV56JM+lHnjyABa
	FpAxc4aepcO9LN5vqupY2jOwcKcQd+Ro37mGdHbTKm23/6kvtDgZn1m076ueba/r2KMzPfyemgs
	yr0vrLlM8gbHbyckaE90OIDSNCfeaq2LQdUahg6tGd5onMpLHHvtEy2F+ExcVns4nBYvgKzhNUD
	cFS3pjgCxmfi3qRyOMv5UM9xrRHqMYcAcfc5Ibc3BXQJRn0JosqimLYleeYjWFlrVTyS4XL1DT2
	nVuINJO+CYEipkokKr/OgmWLUHlRRaTZCRHPdv5dC9cYXRGFxB7goAAwwmmJOlxYEDYr+Lcnj7i
	JBoGC+V6CAay5oWwjt8YySRpsP7/nh7NXNOMqZsmuSOlXLB5VeFPPfYv463PAaPAU3W51CXCnnU
	uvSz21zBgmXhAg4NHV2PeXRnl4la26oOx0FBpI/Mt8VljcSoQUTrWVHKaX1CKfBmJ0zQJdGZPB3
	eRYWA==
X-Google-Smtp-Source: AGHT+IGA/5ixI3whDOaoz9CffkO9FRerNi7Whju8HcdIJ+i6Az3912BHtx16GsmJqLHiU0A2MRkwyg==
X-Received: by 2002:a05:6000:2404:b0:425:6fb5:2ac8 with SMTP id ffacd0b85a97d-4284e57a373mr2391699f8f.9.1761128779719;
        Wed, 22 Oct 2025 03:26:19 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce56csm24070170f8f.50.2025.10.22.03.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:26:19 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v3 1/2] x86/tsx: Make tsx_ctrl_state static
Date: Wed, 22 Oct 2025 12:26:12 +0200
Message-ID: <775b10382ef40a7756b64f4a72779550e2720cb5.1761127696.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761127696.git.ptesarik@suse.com>
References: <cover.1761127696.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all definitions related to tsx_ctrl_state to tsx.c. They are
never referenced outside this file.

No functional change.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/cpu.h | 9 ---------
 arch/x86/kernel/cpu/tsx.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index bc38b2d56f26..5c7a3a71191a 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -42,15 +42,6 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
 			    *const __x86_cpu_dev_end[];
 
 #ifdef CONFIG_CPU_SUP_INTEL
-enum tsx_ctrl_states {
-	TSX_CTRL_ENABLE,
-	TSX_CTRL_DISABLE,
-	TSX_CTRL_RTM_ALWAYS_ABORT,
-	TSX_CTRL_NOT_SUPPORTED,
-};
-
-extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
-
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
 void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 49782724a943..8be08ece2214 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -19,7 +19,14 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "tsx: " fmt
 
-enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
+enum tsx_ctrl_states {
+	TSX_CTRL_ENABLE,
+	TSX_CTRL_DISABLE,
+	TSX_CTRL_RTM_ALWAYS_ABORT,
+	TSX_CTRL_NOT_SUPPORTED,
+};
+
+static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
 
 static void tsx_disable(void)
 {
-- 
2.51.0


