Return-Path: <linux-kernel+bounces-589295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5823A7C466
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687FD1785BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987622A4CA;
	Fri,  4 Apr 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo5T1hzw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BB229B03
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795627; cv=none; b=FlGNTjUD3KVe1myMPCp0B0DJNxnqaF6rkvCEcvj5N6Lb1x+JiJqbaVme0CGvyzeXW27FHITJ/zxGOTn9ckz4t1B1SaGsC0HtkC9UYIjUxr6wA403z38tVoz12Ag+uL/tTUBWLuq3RyFQgVlZmL8u/X0ZfVc6iSCUtQEX70uD79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795627; c=relaxed/simple;
	bh=UU0Srm9ir/IuonBFXeQo8x1rxrol77G2fsdv1A/P49Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ffynnwqvb+licYAt3UBK/IktgDyhK3156wNbyMBLge2HHw2qrp6ndkzPrT3WhNrjoh16yXVyY+mn146m78GtVgt4vNjO2EKpJ5cfDkBk+13C7HTLOL5zr9i6ft+J5BJDouyja1No3n7tTSZVvlpdKRm6uI4PVd+nqv8AH7eCUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo5T1hzw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394792f83cso1890927b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795625; x=1744400425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lSWfLEFHgxrxwFBenufoQIAU5IDy2E3h/30rrI47RK0=;
        b=Oo5T1hzw84VCnxnTNyMZ6ZFbTGbtZmeLfjnaFyPQb+A7th3QBQHsteKE1qDfNvykkC
         hXbJoONJPeQGlnsSRcJS97R3s1j2xZtU1cUq6i4nSkOzo2qL35Lapy7Iflw9fIdKN42b
         nFVxosqDrVbVcHDH27Z0DVFTQzh+Ohl6ihaCskRKSdftD+RR2Oo067CxwJMc0EKC8vgF
         ysI3Dwl22BvYaS/DHRU7pTitbqUliYcHdxNzrSfjebibxAobXAWOV27ON4zuq714CDWP
         BFW+dnOnX2qiYfLf9nF53sz04Ryt22Cb42iYd+QdNWJ7SpzD3Y/LoWpDiA+Ow21UIrAS
         lFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795625; x=1744400425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSWfLEFHgxrxwFBenufoQIAU5IDy2E3h/30rrI47RK0=;
        b=MMDokTwNhsWv/vzrghcou6imxwowJG4E7w9mgCd9CdNMCQCh8QArg9X8uwnyhd2RuV
         CPBVtJ/fz5jLfRHwK0sTtOPoX8Ht+gGkX/7NlgwubXl/2anEjyaUHz4NTxoVae3dBOk7
         QYq09eCb641szWRfzR4EdC+waz3lRHK+/e+RNVuoCTnCdsqx5vd1M3kKpEYZTebMuAOz
         VWQAuGeCqjREtgCWgLaF9jn9+OZ2ykOyVadOMesb9kUHpFY7YbvVTy21JGliDVElSTYe
         uzd06f1Vfnl+9gXZNRBVS/xkpuOTR1Rh4GoUSyTmxj2XzQNd4QPWYNoRLcNrPuQfqFuK
         1x+A==
X-Forwarded-Encrypted: i=1; AJvYcCUTVLY9uV6nLCSIeitmjBfqkiE4wg8ZEiJu9TqLgrI9ZkjvWWZQUiAVlrSBm5xiJPrAok4pUVBNKC1/X+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYCO0sMQSM3gfmG868Tcg5PRX3uRQnvBE0n33KMHJLHvqVe05q
	bGAhBTjLJLvVOw00pU3KG9V3t0AuyRDS3evcVGaAIGi5xQajbUZvd9qFJIG+vTO1kw+NpcCWaNm
	cuw==
X-Google-Smtp-Source: AGHT+IEtlaa9i6xhVrmng7fmvBFIIniBMBstQlCiIyFf9+8ses6o9CMRLUsjMBJaIcUpUnWLOYu2dil1vbU=
X-Received: from pgc8.prod.google.com ([2002:a05:6a02:2f88:b0:af8:c3c6:e3f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:168e:b0:1f5:59e5:8ad2
 with SMTP id adf61e73a8af0-20113c7136bmr786221637.24.1743795625080; Fri, 04
 Apr 2025 12:40:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:37 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-23-seanjc@google.com>
Subject: [PATCH 22/67] KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU
 has erratum #1235
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

Disable IPI virtualization on AMD Family 17h CPUs (Zen2 and Zen1), as
hardware doesn't reliably detect changes to the 'IsRunning' bit during ICR
write emulation, and might fail to VM-Exit on the sending vCPU, if
IsRunning was recently cleared.

The absence of the VM-Exit leads to KVM not waking (or triggering nested
VM-Exit) of the target vCPU(s) of the IPI, which can lead to hung vCPUs,
unbounded delays in L2 execution, etc.

To workaround the erratum, simply disable IPI virtualization, which
prevents KVM from setting IsRunning and thus eliminates the race where
hardware sees a stale IsRunning=1.  As a result, all ICR writes (except
when "Self" shorthand is used) will VM-Exit and therefore be correctly
emulated by KVM.

Disabling IPI virtualization does carry a performance penalty, but
benchmarkng shows that enabling AVIC without IPI virtualization is still
much better than not using AVIC at all, because AVIC still accelerates
posted interrupts and the receiving end of the IPIs.

Note, when virtualizaing Self-IPIs, the CPU skips reading the physical ID
table and updates the vIRR directly (because the vCPU is by definition
actively running), i.e. Self-IPI isn't susceptible to the erratum *and*
is still accelerated by hardware.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[sean: rebase, massage changelog, disallow user override]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index eea362cd415d..aba3f9d2ad02 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1199,6 +1199,14 @@ bool avic_hardware_setup(void)
 	if (x2avic_enabled)
 		pr_info("x2AVIC enabled\n");
 
+	/*
+	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
+	 * due to erratum 1235, which results in missed GA log events and thus
+	 * missed wake events for blocking vCPUs due to the CPU failing to see
+	 * a software update to clear IsRunning.
+	 */
+	enable_ipiv = enable_ipiv && boot_cpu_data.x86 != 0x17;
+
 	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
 
 	return true;
-- 
2.49.0.504.g3bcea36a83-goog


