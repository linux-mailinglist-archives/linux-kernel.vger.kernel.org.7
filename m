Return-Path: <linux-kernel+bounces-841847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB845BB8622
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A32E345EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FD02D24B8;
	Fri,  3 Oct 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzJmGkOR"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC228BAA6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533982; cv=none; b=nq4pob0cDjzabP56hMRP+EunpKCDdpjDV1FRQV1bU1NYZnHwac4TwHhaUzqqOEKCoEmNXLI1QRO2u/ka1ONbmRBzITVqcg1yNOBcPoZkK7CgzNMiyI2OmAnIqlnx7H3I9UuWr5m/Y41G/O1m5vKeJUBUgHsehpMInv6JS8TUE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533982; c=relaxed/simple;
	bh=eekP/dx3x8jqekvGeoDTkRGaGODTC4nEEgFN30UFNN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JHuBP1IhpvXJZKbn4vbQCGAURRp6ccgiMbFFGp8baxglxsrmBceOekS8JNOilbyfpuG/tVkdNQaoqE+cWD/yXKMcRQBuLTkx3UCECB57uvH3tiV08ySXM5GLq9wWPqwQJ0pEz+wGj6BkiyK71lK4KT/AQukp+YUv9fsVOFReZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzJmGkOR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78106e63bc9so3136385b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533980; x=1760138780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9k0A/wIlTiMIkK4NIRv5JkCn3UX2zyXw07XNqkpaasU=;
        b=XzJmGkORhOa6aGhus8ckD2NNPUfKdrr0e2j3SKKb2cmjpFPxwTl4MamyXKLRuNHWbf
         5lx97KFvPjtCSG7NNcfEc2Ds04NafrD6nahjKY0ZaU7kkzw18spJaVwLzef2OQRxOsSn
         nB969vqE54rrwI9DBIPuifITsglVZnGOI3AsGK4g0KPOMbAQOPpEOz9dble5HTBTmKHl
         VpNYS/RNQWOdgRQDBVUOoSRsSQFbI5Ofwgfa/aME+h6yO2nNzL82eke8HsUL3Lkyg0PK
         LUJR9DOCTxuTpUQ60h3+YB6wH8uBWJ0sItG2YQrjg9zrNR3ktcWITcOG+zAzEnWjRWdQ
         Y0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533980; x=1760138780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9k0A/wIlTiMIkK4NIRv5JkCn3UX2zyXw07XNqkpaasU=;
        b=Rs+qb4+bJCmYz5cDxCmQwYxjhzZE0jp95UK0JaFQpDG+8kxggNY97Rg0W2Ct0u+ndy
         tyX85RrJueudWnFg+dBWw+IkF9SK5YTH2is46kNxpqzR9ktFSIfAnFO352crZIFjdabo
         DU4Z+qFpsi0cq/EL78U+Ta41iDnpU19f6LwkHa4z+YJCpoqU8OEKtFo90WocHty3shEJ
         1krRNYsUJXzrORLzx+myFd98DcKXqLwY2W5EgmAvdRLXMi87tlwmk4Gq+dUnn4U6kFnl
         0MeMsU45eYI40lgYMjuZbbkuXTxP40c716H2XemwkeFniTwyFLNfhbsoAVUVcm2WZjS2
         P6Og==
X-Forwarded-Encrypted: i=1; AJvYcCVygg0q63dKZFTvIRK8hDr3bW2oPDSuxbUrk+1C2xuvAHdJmUoXUBCz3jQZnSSWaT8e4D04AtYL05gSaBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NQ3d/JwdY5d3zZU81aIVEmffEBpBIr16Oz9r2bkj82Q6LHk0
	M9lyzoasWfRZ/aH0nmK5pc48BFdAiKTZT05fON63DG9ELJGA7FgyTALNH5ykx2+mS6dJBeLyxhi
	Ivhu+fQ==
X-Google-Smtp-Source: AGHT+IH4nZpvTnjztjJocS+gtKNwmiitFnPO1cCK3pCOnqgiERq2oUPG+XolQgX15umxzn7SATNJ8PGMQ+s=
X-Received: from pfux39.prod.google.com ([2002:a05:6a00:be7:b0:77f:6432:dc09])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d51:b0:781:2320:5a33
 with SMTP id d2e1a72fcca58-78c98d5d5a9mr5435952b3a.9.1759533980009; Fri, 03
 Oct 2025 16:26:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  3 Oct 2025 16:25:57 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003232606.4070510-5-seanjc@google.com>
Subject: [PATCH v2 04/13] KVM: Explicitly mark KVM_GUEST_MEMFD as depending on KVM_GENERIC_MMU_NOTIFIER
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add KVM_GENERIC_MMU_NOTIFIER as a dependency for selecting KVM_GUEST_MEMFD,
as guest_memfd relies on kvm_mmu_invalidate_{begin,end}(), which are
defined if and only if the generic mmu_notifier implementation is enabled.

The missing dependency is currently benign as s390 is the only KVM arch
that doesn't utilize the generic mmu_notifier infrastructure, and s390
doesn't currently support guest_memfd.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 1b7d5be0b6c4..a01cc5743137 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -113,6 +113,7 @@ config KVM_GENERIC_MEMORY_ATTRIBUTES
        bool
 
 config KVM_GUEST_MEMFD
+       depends on KVM_GENERIC_MMU_NOTIFIER
        select XARRAY_MULTI
        bool
 
-- 
2.51.0.618.g983fd99d29-goog


