Return-Path: <linux-kernel+bounces-660095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE5AC190E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F3E1BA59B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2621ADD6;
	Fri, 23 May 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVbBMXU2"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276F212B2B
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962019; cv=none; b=e7pnlz1vnC263AqlGaR+LJ7JDNEAC+4ROIS2UDujRHBczIiHzDRjlNyPMT1UEynLmKDGM1AabY564XpZz5v9bMRhL32sE64ja/eMZ1dc8gf4eeE6hJHwNLH08zF/Yh8c5QtsfYq5xtPN4LA97UXyKhzSj5KSn/eKkSp2KYxtKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962019; c=relaxed/simple;
	bh=oo94zQ9KP44wU971cBBIeljSw8H5jEienGLBcJLhnEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkuMSEhMeZxMwljYwjjOUkJGyMJlNtruIa2jDpW5UU7pW+hhfridx68zcgm0Io/SdMB5/N5xlwb9ZoL7adVNhxJCVgcp4yYUhnh3l9Gft4wC0pTDFelGvkAWWJcFDQlqbfEWzw3Zg2ALdFpJoAWjVSMJ5TQMhi8OO5igwTNLLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVbBMXU2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7425efba1a3so369857b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962017; x=1748566817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq62gkgLP+wVktrApN5Abqg6uzedhCCWd9aEc00+u+w=;
        b=uVbBMXU2SxR3z2p1u4X+HCvvDi/UJYsjvuKq/+KMe9X616+R2M650fvw6IzKZTJoNp
         tqQz97dpjisJ2S1D0pHd8MjhwSfj0gqechHILkX9pDQIVkxKLBDALW0JgAlDmuGLZJIk
         UTscWtHErhHqwEoJz9cJ9ws5bFZhELZ83qi/gKdwOJMcHHrbKo3OpXTzkVZv96o1Utzw
         LyqLDe9byASIRyhZRUNZ/b/7qLFGlOFI3M2ovpC0r3JGL7f6/yqQTF7UWLb503eq633k
         OgIYXpwbXxNhMA6vTj9CjZ+/nhimCxG17f/OCq8Y+x5VnZviS38/tZFRMADBk2unNwqT
         3EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962017; x=1748566817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq62gkgLP+wVktrApN5Abqg6uzedhCCWd9aEc00+u+w=;
        b=IN0CX591xr0SU5SA7GbUCjTmLPfx3YGJyn/I+uIctrucHcgImxnqm9EpZ/e/GtARZO
         NDZWS3gcbLbuNlom8CiDBDr1XKykrmFwMjOmGQzfj5LXTItllrCdp13SgtysHlTG+5Uk
         bb+qXMyeDbfE6B+abwsw9miVvxy2OwHeSuImE5S6T8rChAoh5HdYe5GAIPXuQfsVkJ5T
         90mT4wKdvyLUZ8sVtW+Xn8Y/iprm2+quOZgV62Uzd0mDsY1nFRtUripoF6NvUZqHGGNP
         Jhuf7ym3ehuwVLGTfe1kEfKBHKlrGV+mOa2rmsyM2tcBazn2/UO7ZPewBy4M0D3RzQ54
         LHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUk2YYBa4t03YD5eVLLPB+unsJOfrx+iJICnnkcgE6YgXm5ngai8uxozI0pgOJ9dbDprGYRdmXU9mC2usU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJZZrU7OT8+NtBeq4jRvJ/adspP/22dyHJ+vyyP6KNXPqUdiK
	AAa45Y/rur4qSgAjwR8nTRIggNMWXfdsCp2fSOrzq1iDh65Xks5xYV15BEeF8sAd2UpIBb4Nj4h
	vIoiQvw==
X-Google-Smtp-Source: AGHT+IGuYoObsP1SNouvA21unXNvbU7VlCtk1/aF9baeg7tLlY7NAY16P1XuLv+D0VMCs09pXt7is6cf1ZE=
X-Received: from pfqz29.prod.google.com ([2002:aa7:9e5d:0:b0:740:6f6:7346])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d8c:b0:73b:ac3d:9d6b
 with SMTP id d2e1a72fcca58-745ece00f2cmr2255014b3a.4.1747962017305; Thu, 22
 May 2025 18:00:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:09 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-5-seanjc@google.com>
Subject: [PATCH v2 04/59] iommu/amd: KVM: SVM: Delete now-unused
 cached/previous GA tag fields
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the amd_ir_data.prev_ga_tag field now that all usage is
superfluous.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c             |  2 --
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 10 ----------
 include/linux/amd-iommu.h           |  2 +-
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ed7374f0bd5a..4e8380d2f017 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -938,9 +938,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		/**
 		 * Here, pi is used to:
 		 * - Tell IOMMU to use legacy mode for this interrupt.
-		 * - Retrieve ga_tag of prior interrupt remapping data.
 		 */
-		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
 	}
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5089b58e528a..57a96f3e7b84 100644
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
index f34209b08b4c..f23635b062f0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3887,23 +3887,13 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
 
-	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
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
index 062fbd4c9b77..1f9b13d803c5 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -19,8 +19,8 @@ struct amd_iommu;
  */
 struct amd_iommu_pi_data {
 	u32 ga_tag;
-	u32 prev_ga_tag;
 	u64 base;
+
 	bool is_guest_mode;
 	struct vcpu_data *vcpu_data;
 	void *ir_data;
-- 
2.49.0.1151.ga128411c76-goog


