Return-Path: <linux-kernel+bounces-682647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58304AD62FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380551772AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098A25A351;
	Wed, 11 Jun 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRPZRfrA"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4322561B9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682021; cv=none; b=oMV1E5xrJF5iKiYbZeVWR+EzNnZFi0KT3EUbdDZfvD6igtxAXSt1VAKGzrXIHQbmHZWiD7Ah5zD21pzkoYXDcoh91+E/AtZKxJHNxxarshl+nGpVJ6xJA2jSGjZQN7gpauHjgIe3+NkCMrvbAdlaowHpeuEs9c6OzbAfNh6xH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682021; c=relaxed/simple;
	bh=3RinVstCvuPOndpP2qbzIU1WkDpDfa7DXhIJNaW07EI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQtpFUYpaC3eOUhrsbDmbGWtNtgu9s8EOfDOaE4YkJmH9C7CuoJ7uauiHIefYCy6OrRkTk8IZX6t1MiFQK05M5gw2+ZRocRXluYpCNAYXvOFlWmHIzHkoYgoRUMGwZIuOJyirgQNn981abqYOFP4FOHWtnQ9mIBVgtyRsb7eXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRPZRfrA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so306797a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682019; x=1750286819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J8/39YMW2TnSu0vcgq5sLc/aWRKEr8Y6tOCzdbkWep0=;
        b=XRPZRfrAMeLjtk8c99XvSfscEUWXqAK1T0+URQXkLXtLs51+74j4/xt1I/DpW75W9+
         vzJiuHncIkdZaB+tnpm4NuDZbDY0AWIk1ZJNk+au+bIdd5uOabmDk7vucsDjAu3mG4vT
         RlVu40PpaeP+b+cxTWCtg6+zv6nmWgBG9cvOyUbbd2nEuAm+iP8hEO5JeVhGSd/bRnss
         JmStWyBQdjoO7+Ip4jpPEPgcJerqPQxnIUF64bCfhzyIfj0ZTa2QPn9qg0XyUwKE6Z8s
         ngjsgjg3PTUzt3GXmo4TBoEp6ZE2W41Jq8bnEAVfWRHXD+zJVK/X7FQl9jGCw4DSzUmr
         FaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682019; x=1750286819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8/39YMW2TnSu0vcgq5sLc/aWRKEr8Y6tOCzdbkWep0=;
        b=INQHZiXTLx1q3RLuvDPTT7SPKwccTcKxfYL3iD2MdLuH060iLTz9SwU3LPIzDRO1Hr
         HWcweycG7oVN+pn8ZNhZK54w1eWiHnMQEwEOB59CKdc5ilY7OFgzNuByWRjpp5sLiHB0
         jynvY2sllcAPnGaxstgMJdw85qWNNcBXWgIhZPwKSLRG4BzIW8NyqCUvKxU6Pb9rrkFa
         0nGtktyuzFUMMDqcQbG7NKmRGeF7CT9XXhryWC59KFU1VZORE7wvSB+0wgdQakYiHXX/
         W3LSpEG8HZZW409xRJqvoywLYV1JRoM07o+I2DaHBQ9dSv6GQuEU73pi7CE7mR5dQzGC
         Gmnw==
X-Forwarded-Encrypted: i=1; AJvYcCV/1JXnV0fB7FeWqNn5T4/VhsvkWEuzxDxgCkPwh2o8MxLuijKOgoX8O3u7oRls0Q9MzWhkmosX7sxFLvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfW989I/A83pjknVkyL4tQgOFIpk2D/eUJ0PfEnqK/hiYOXHt4
	/VHiu8mm1qG3MKXwxih6fXrtbSP68XgmoabRrUv0XPLeKYKzTa4OS7Y0KLXxeg5gov28ncJ1FuY
	X3Bp0CA==
X-Google-Smtp-Source: AGHT+IE4n+pz35x0pb/YvabbWEbD1z+qTn+f+8VFoLc/qnaff30Vgk2g7VglikeaFDWzSwKhNVkNo49sz8M=
X-Received: from pjbpa3.prod.google.com ([2002:a17:90b:2643:b0:311:46e:8c26])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3902:b0:311:abba:53c9
 with SMTP id 98e67ed59e1d1-313bfba1132mr1720309a91.7.1749682019303; Wed, 11
 Jun 2025 15:46:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:05 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-4-seanjc@google.com>
Subject: [PATCH v3 02/62] KVM: arm64: WARN if unmapping vLPI fails
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if unmapping a vLPI in kvm_vgic_v4_unset_forwarding() fails, as
failure means an IRTE has likely been left in a bad state, i.e. IRQs
won't go where they should.  WARNing in arch code will eventually allow
dropping all the plumbing a similar WARN in kvm_irq_routing_update(),
and thus avoid having to plumb back a return code just to WARN.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/vgic/vgic-v4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 193946108192..86e54cefc237 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -546,6 +546,7 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int host_irq)
 		atomic_dec(&irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count);
 		irq->hw = false;
 		ret = its_unmap_vlpi(host_irq);
+		WARN_ON_ONCE(ret);
 	}
 
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


