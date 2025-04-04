Return-Path: <linux-kernel+bounces-589299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6FA7C443
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E5189FC5B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3022B59C;
	Fri,  4 Apr 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0CE4mLS"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9522ACF2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795634; cv=none; b=kvfNuYe8KgOc9TSqCAVRDtSjtOFU8Ci3SSQ0SmFj38XBnmiWJzC+VzCs1SSTwrBftfOjPQHH5DHRs4IYVL6DiYICel0ihXZCW2BCflM5ic6h/jm0FircLYXUasRQ5pgL63Zz8FCsICiWZrpH1dWC26l+e+L1R+0+t4epN1wQ5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795634; c=relaxed/simple;
	bh=numHIJ2fVUixTwPl70w3f1Z9LTsloAbGJqKA3GVrevU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcHL+ZrUyJKj7CCGP+11IhzogxLL1i8fz7DXjli6t3dik4zay7CcghEnmBjYANoh86CTAJ70Sf8eJUwde2Yl4Ej4wyc/VELrXzeaKyBpPySBixKp4S43ulwVdgjEJCpFfleMrK5htEdKPBKyOKrLCCg8LVbqVnSOSLDt5FpcBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0CE4mLS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2264e5b2b7cso21467395ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795632; x=1744400432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VyaPnhLqGsMwpjiZdqn/1mWwUn+QLwb4TwRlvb1iqoM=;
        b=q0CE4mLS1t+wNDlrPgZ3F5a6jicDZRs3RPVTNmQHdl9z53ZRBw7FCXkHj0iFOLa0lN
         o+kB6S4tIhspRsedPGkm5ydFFVnAheT19OZLIrXSfZLTSlgexwRx5xRMLLAFOmc58AYY
         w4hL2jkKQ0Np/DEJp39FBTqPavSsMIsMB8Vhih8jzf+0c/HfA7zwItO4SWsprJ9KT2J2
         yG1JG1Av87szK4CQkK5Icl5WsRmi/dZVGmTcfpIvO8vSuYTK8/bvP9RWAiikAWmwFnbc
         ogIEoc8TrexvQzwJkGKhRbaJVT6qR9j8u0YWSat3oo7XVegMq69FVVqLLPENf0aLm2mQ
         sVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795632; x=1744400432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyaPnhLqGsMwpjiZdqn/1mWwUn+QLwb4TwRlvb1iqoM=;
        b=TcjFNOVzJzVYJiNX/RQ9OyDDkn8WripwaqEf9252WXs1O94yX5HF5+aDYpTh7aGi9T
         XBpEJRFklzFFwEFo+B4HlsBO04tlGIFtUCwaoCKm/qumOqB6HxX4My9Hv5oa+2QDHutZ
         kfPaapqEwP0z9xSzIeBxWsEM35m2HMM7p1q6hVv+usjL8PCQBprknz7RbCdh2mgxttoi
         3Q1mo7GamhH1JJGIkocoOhsxmWEljfoCEdLjPOQJDUJQnxxgplcxm2+UrtT4cZeowD2j
         Trg3686ZmSOpc4/xeTbMs64vdPsxs2i8yEN3yOSsZRNQoOECzXDRvezuv36l77lGBlny
         56qw==
X-Forwarded-Encrypted: i=1; AJvYcCWmJE1Y2/Rslvg+BlDpJ1ZBhGL0lZbjsx6T0ITvos1C8zXMy1ibkGgLAF6gKITCuay5a3Rb2J+mRGq3laI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3V7+gIaTRmbpY4aniQoHpdEJvDjfhqiFZW1Z/DbBYNqzX+xb
	4GYEKGqvYTFv4SA+S9ERg1b8oXT0ktwHfUWPtxxbaGsxqYkWiz6vdo3HojdA7Rrig166gn/3oG2
	VcA==
X-Google-Smtp-Source: AGHT+IGMwxs0YOBPs8h+elgyRVkuAbPHKTSrU7awNNYaCT+HPFTcP/hO7N3HdKAFdFfYL9/K+0CGHpH7MBY=
X-Received: from pfop9.prod.google.com ([2002:a05:6a00:b49:b0:739:9e9:feea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f605:b0:220:e9f5:4b7c
 with SMTP id d9443c01a7336-22a8a865825mr59456785ad.17.1743795632180; Fri, 04
 Apr 2025 12:40:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:41 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-27-seanjc@google.com>
Subject: [PATCH 26/67] iommu/amd: KVM: SVM: Delete now-unused cached/previous
 GA tag fields
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the amd_ir_data.prev_ga_tag field now that all usage is
superfluous.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c             |  2 --
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 10 ----------
 include/linux/amd-iommu.h           |  1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 9024b9fbca53..7f0f6a9cd2e8 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -943,9 +943,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		/**
 		 * Here, pi is used to:
 		 * - Tell IOMMU to use legacy mode for this interrupt.
-		 * - Retrieve ga_tag of prior interrupt remapping data.
 		 */
-		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
 	} else {
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..319a1b650b3b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1060,7 +1060,6 @@ struct irq_2_irte {
 };
 
 struct amd_ir_data {
-	u32 cached_ga_tag;
 	struct amd_iommu *iommu;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 635774642b89..3c40bc9980b7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3858,23 +3858,13 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
 
-	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
 		ir_data->ga_vector = vcpu_pi_info->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		ret = amd_iommu_activate_guest_mode(ir_data);
-		if (!ret)
-			ir_data->cached_ga_tag = pi_data->ga_tag;
 	} else {
 		ret = amd_iommu_deactivate_guest_mode(ir_data);
-
-		/*
-		 * This communicates the ga_tag back to the caller
-		 * so that it can do all the necessary clean up.
-		 */
-		if (!ret)
-			ir_data->cached_ga_tag = 0;
 	}
 
 	return ret;
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 4f433ef39188..deeefc92a5cf 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -19,7 +19,6 @@ struct amd_iommu;
  */
 struct amd_iommu_pi_data {
 	u32 ga_tag;
-	u32 prev_ga_tag;
 	bool is_guest_mode;
 	struct vcpu_data *vcpu_data;
 	void *ir_data;
-- 
2.49.0.504.g3bcea36a83-goog


