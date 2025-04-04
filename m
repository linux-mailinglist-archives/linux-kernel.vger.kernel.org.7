Return-Path: <linux-kernel+bounces-589293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD823A7C44C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA21017718C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBE2288FE;
	Fri,  4 Apr 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zxUXS5V"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307D227BB5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795623; cv=none; b=LpLMhHebBr1UZ+LU6wXIRN32vMh5RwYBZpKBI5mAGuLNPUUxZGTb+76rN8k69Aoj9F0Ck6TSnZWLf2ijp/O1DE+xhWkTIFyDbdebEnwCCId5xWJ3y1KOzdLicgdOjjdaXJAedvOah1s6XgqDkTGT9brRXpl4x7kdGhcPHHqf7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795623; c=relaxed/simple;
	bh=ncnSIRMStjRgoaLxhUROgr9SOC8QWiUmuvo8MAqoaW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDeqEfqzC2o7XgST57DbqHXu1PEKagVS89kISzDZF/YhsLZF6XW9xNGij1Ayp89JAe15XE9NDgZJauGryZSh7wACqF1BiCKWopYJxdCvBxViUsd3UzK8xBk5rPa50OXBD2woabi6/ztIUyT0gsQwOTMgz/gZyi/k4Lw8hP01QS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zxUXS5V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241e7e3addso21001185ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795621; x=1744400421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VCMo/RGlrbOJASvtC7+TsYQlxqkzXA/5CTBjvXO9fqA=;
        b=0zxUXS5VvheRhTDTt4E5k3pwatpRkZyKHSMSZmD4QylBBBgMk3QgSgF9mp30QgaqA4
         JPg/4E5AfGRMSRolkKQOz5OnTdCae9BAUJX9AB3nhLoO7BTImC4pecF331gQKauUAxpH
         LM+xJFyC7Rt7QaoepixUnrBcYnct6Yz/NHrf4zGvegLNTslPJwZbEWgkuG+FkhM2lt7T
         uHF6HKYsNyyGuF2aqM30nF7QsgDNyaO0h+u2AepYWuk1EYlqp4kJBh9hVR9VLa/S5Vbp
         WBW6K7v7wccXnb8lAPNERJAB9ngA5dck6Dyt92ojZ+bJKMMnMeL/OjIXMtiMJPl1duTJ
         fbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795621; x=1744400421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCMo/RGlrbOJASvtC7+TsYQlxqkzXA/5CTBjvXO9fqA=;
        b=p3zhKa3+P3v+pRLaWSGZHRmTfmvlQZTuEAbP4t2W1UEAzA7KePa+6E0AJkRTP985bw
         Csc7/X9f52Mee+bZHe1W9gK7FwvjrbuBFAfQKSCtG6js0VTH9+o/i3D4r4o1VR3GdkVF
         ZEmHZ+Vehzh5ilOUZOKqiWHYUJ4/A+ZazsxjWfLHGcpU7hmK45kgFxi7GmeA9FjyNnad
         InznEVwtfioIftzIzUh5DSGeWhl9Zvn07nyzwjKlZhKnhLaEy2vtX1Eg6Mu6pqeOyx3G
         DPFGBCLmSh2C8bC6wYtjyUj8HIoBIdXDDYggZCtnewR9wZQvpLtK/NRIpePJxf1bKfWl
         /81g==
X-Forwarded-Encrypted: i=1; AJvYcCVHX8aq50Qnarzb/tLVtndK5H2qxAUcGuo4B1dup76HhIs/S/oCdwRVblIV46jZHUXcSqQzZmkNExFmKUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBNRdKxuoEHVRMOXD2OwWf0zWP8frvD8kepV1P7jM/pBPopmX
	hXuuN5eEZo6zUCTHfl1yxWBEV91UOoWt7G3zcLxL36qSZBtsfHbX7Iu30hCPUUluMjf9M/1k1do
	guA==
X-Google-Smtp-Source: AGHT+IE5XbiMqRGlDARtEBjYgWidaO1ecxsBHLfL544ofCTr9/DpC8oice4f7Zykt01Y3R60ZjSJF5IkHjo=
X-Received: from pfbbe6.prod.google.com ([2002:a05:6a00:1f06:b0:736:aeb1:8ace])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd2:b0:224:1af1:87f4
 with SMTP id d9443c01a7336-22a8a06b3d0mr64838025ad.22.1743795621644; Fri, 04
 Apr 2025 12:40:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:35 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-21-seanjc@google.com>
Subject: [PATCH 20/67] KVM: VMX: Move enable_ipiv knob to common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move enable_ipiv to common x86 so that it can be reused by SVM to control
IPI virtualization when AVIC is enabled.  SVM doesn't actually provide a
way to truly disable IPI virtualization, but KVM can get close enough by
skipping the necessary table programming.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/capabilities.h | 1 -
 arch/x86/kvm/vmx/vmx.c          | 2 --
 arch/x86/kvm/x86.c              | 3 +++
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0583d8a9c8d4..85f45fc5156d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1932,6 +1932,7 @@ struct kvm_arch_async_pf {
 extern u32 __read_mostly kvm_nr_uret_msrs;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
+extern bool __read_mostly enable_ipiv;
 extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index cb6588238f46..5316c27f6099 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -15,7 +15,6 @@ extern bool __read_mostly enable_ept;
 extern bool __read_mostly enable_unrestricted_guest;
 extern bool __read_mostly enable_ept_ad_bits;
 extern bool __read_mostly enable_pml;
-extern bool __read_mostly enable_ipiv;
 extern int __read_mostly pt_mode;
 
 #define PT_MODE_SYSTEM		0
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ac7f1df612e8..56b68db345a7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -111,8 +111,6 @@ static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
 module_param(enable_apicv, bool, 0444);
-
-bool __read_mostly enable_ipiv = true;
 module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 23376fcd928c..52d8d0635603 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -227,6 +227,9 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
+bool __read_mostly enable_ipiv = true;
+EXPORT_SYMBOL_GPL(enable_ipiv);
+
 bool __read_mostly enable_device_posted_irqs = true;
 EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
 
-- 
2.49.0.504.g3bcea36a83-goog


