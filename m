Return-Path: <linux-kernel+bounces-618603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC94A9B0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FA24A2009
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34E293B4A;
	Thu, 24 Apr 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQRWxIZ8"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4EF291177
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504064; cv=none; b=Cs4s2PIP2+7DCVxK7zUhenV/whIBMsSpJLeDgFX4j20FBykzbGf3lKoov5p/3fH5V3krQ7lXOsqVjYLkuYAoqlJkwe1evZaWWH/tbX7Qe9j8yEePJEyiwnZ/pnFMmBMiUIra4VEQrTVIZg8O7IVMPHy/DSoxSKZoTS4ulmkSCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504064; c=relaxed/simple;
	bh=l8MXGFGw31uuwPrLVCURxj+dBhiUP5Eq/JDGE+Ioyyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTchR76HhnFxPEQVix0P4olVbiBY6+BI7eyruJd5ShmPt5Gq3a+SfVFL1gDBt3kYQU1ZQ8gYCTb5JSHhMdO7L5CouEgSKps8gpqacU7giDkXZEyFtDCrLg15WX9rThNJRk15h8e+X/DMwHV3Cz/afmp+TqdeFG5eudjdK6/q0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQRWxIZ8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a064a3e143so567539f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745504060; x=1746108860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULK/WgQrAoOKgv7yTbnqoplbgLc/ybTV2ol4z7wD4V8=;
        b=rQRWxIZ8fpXO6y7A7UEoBuCu58ZSGVRY0fjpUvj5yf8BrVkOihzZTjogYnJHmrD9OG
         5bBkzKMlKMuW7rijJvKvn5tzGE4ax3rinG5VQMmuwWDDuQieJiCbQmPJDAMonyD/KNBe
         cfZbIYruffocTqvtlrq7tyjPuoXof+RxuzdU2huHJcpAqTA1ujaVCIQRTZKoTztXvzwh
         qZMS1XOZsce0KykvQTP+oDgnnDxzTkiBHhsH6l3NUVVKKeZ39mJEAUhN2/65eho8OO4X
         IHXSFmu5YI3FeaFhWrHR1akw5UVoAhlIobKVnFlNNIkIfax5YE5OOBHoU4//QWZhg5DI
         vofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504060; x=1746108860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULK/WgQrAoOKgv7yTbnqoplbgLc/ybTV2ol4z7wD4V8=;
        b=ZYu32yI2AKFxezuPgJYKdH9keDvlb0DUKGXirTfYwaXz4EWA9mmqDak9u8jHyi2xeI
         Rl9BkaRinpUpQU4+p4L/pqIvxDVpkxtMe3XfpW0tW7pxV+XHd6VgKjpqnqReJFzG/Pq0
         wN02nYquqkPQUOYC1npZURSxL4e/zLON4VEy6Cv+Rhjl4yZ0WMlFkY5fMfkdME+n6sSD
         ZkkgHW77O608Dv0YoAWLSWsYeufC9VASgzqGZhLhSoiWDIWCCsKXuLQ5BHApRPJDU0v2
         bfaKCJu0Ue++qf9QKxSt2nklSUt2nzmltbAeejJyy404J/lT45pI4uUMSIBGi7VxJxu3
         u9BQ==
X-Gm-Message-State: AOJu0Ywfo6a5tqI4W3Zp5gD2g4EHWQbUBneG8DBUoobDQAbOP0NkSXhS
	vg1QoKQux0iKG9YXN+BevajeInMCGGOAXlLN6Q4Udsuwrv1l0cM6GADmEVpaLO9Tc/2UlnKa6GJ
	a
X-Gm-Gg: ASbGnctqnpEUSqTTXQ0Dpkvxew8OmhT1O7zawzAtxn0vLBXLsq+YKuz3ivAPBRDzLIs
	YG7Zq4DWOkp9c41eSLzZA7CrkRFVrVfpUfA9U2NVtsoHGvveKwfSjt+FMUpDYCeTYDcYd8v1L2K
	+bpmLSK3GKJVb+cAbcEx6x4n6GJAi92DrnAntDr8btkAl1/dxv/1UiWPwtreT3x1m/nufnuWbYB
	V5FHd/vOpde9TXvuSSm/qC1u0XuQZ+VVciesiA5L4rL+f5tfGDrOawwWn/imUXdyIL+tkQ6s5Gp
	EE3Rh/NMswToPp1BajJnQLRJnA3qTZ7MBKxruXS42Qq14Wn25culC547PBz3r6He0ONyTcf7VE6
	yafi66U4wOSca8YfA
X-Google-Smtp-Source: AGHT+IFE5/vk9/X0Lu9aLCAdTyRnF+oi4a9Eo+hij9nbvfLjJtzlSBwWD4MqvNxQh/Fi8Qjri674AQ==
X-Received: by 2002:a05:6000:220c:b0:3a0:65bc:3543 with SMTP id ffacd0b85a97d-3a06cf65a2bmr2283431f8f.35.1745504059899;
        Thu, 24 Apr 2025 07:14:19 -0700 (PDT)
Received: from seksu.systems-nuts.com (stevens.inf.ed.ac.uk. [129.215.164.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4a8150sm2199951f8f.7.2025.04.24.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:14:19 -0700 (PDT)
From: Karim Manaouil <karim.manaouil@linaro.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: Karim Manaouil <karim.manaouil@linaro.org>,
	Alexander Graf <graf@amazon.com>,
	Alex Elder <elder@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
	Quentin Perret <qperret@google.com>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Haripranesh S <haripran@qti.qualcomm.com>,
	Carl van Schaik <cvanscha@qti.qualcomm.com>,
	Murali Nalajala <mnalajal@quicinc.com>,
	Sreenivasulu Chalamcharla <sreeniva@qti.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Stefan Schmidt <stefan.schmidt@linaro.org>
Subject: [RFC PATCH 26/34] gunyah: Share memory parcels
Date: Thu, 24 Apr 2025 15:13:33 +0100
Message-Id: <20250424141341.841734-27-karim.manaouil@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424141341.841734-1-karim.manaouil@linaro.org>
References: <20250424141341.841734-1-karim.manaouil@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gunyah Resource Manager sets up a virtual machine based on a device
tree which lives in guest memory. Resource manager requires this memory
to be provided as a memory parcel for it to read and manipulate.
Implement a function to construct a memory parcel from the guest's
pinned memory pages.

Signed-off-by: Karim Manaouil <karim.manaouil@linaro.org>
---
 arch/arm64/kvm/gunyah.c | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/kvm/gunyah.c b/arch/arm64/kvm/gunyah.c
index 7216db642174..ef0971146b56 100644
--- a/arch/arm64/kvm/gunyah.c
+++ b/arch/arm64/kvm/gunyah.c
@@ -634,6 +634,86 @@ static int gunyah_memory_reclaim_folio(struct gunyah_vm *ghvm,
 	return ret;
 }
 
+static int gunyah_share_memory_parcel(struct gunyah_vm *ghvm,
+		struct gunyah_rm_mem_parcel *parcel, gfn_t gfn, u64 nr)
+{
+	struct kvm *kvm = &ghvm->kvm;
+	struct kvm_memory_slot *memslot;
+	struct page **pages;
+	int ret;
+	u64 i;
+
+	if (!nr)
+		return -EINVAL;
+
+	memslot = gfn_to_memslot(kvm, gfn);
+	if (!memslot)
+		return -ENOENT;
+
+	parcel->mem_entries = kcalloc(nr, sizeof(*parcel->mem_entries), GFP_KERNEL);
+	if (!parcel->mem_entries)
+		return -ENOMEM;
+	parcel->n_mem_entries = nr;
+
+	pages = memslot->arch.pages + (gfn - memslot->base_gfn);
+
+	for (i = 0; i < nr; i++) {
+		parcel->mem_entries[i].size = cpu_to_le64(PAGE_SIZE);
+		parcel->mem_entries[i].phys_addr = cpu_to_le64(page_to_phys(pages[i]));
+	}
+
+	parcel->n_acl_entries = 1;
+	parcel->acl_entries = kcalloc(parcel->n_acl_entries,
+				      sizeof(*parcel->acl_entries), GFP_KERNEL);
+	if (!parcel->n_acl_entries) {
+		ret = -ENOMEM;
+		goto free_entries;
+	}
+	parcel->acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
+	parcel->acl_entries[0].perms |= GUNYAH_RM_ACL_R;
+	parcel->acl_entries[0].perms |= GUNYAH_RM_ACL_W;
+	parcel->acl_entries[0].perms |= GUNYAH_RM_ACL_X;
+	parcel->mem_handle = GUNYAH_MEM_HANDLE_INVAL;
+
+	ret = gunyah_rm_mem_share(ghvm->rm, parcel);
+	if (ret)
+		goto free_acl;
+
+	return ret;
+free_acl:
+	kfree(parcel->acl_entries);
+	parcel->acl_entries = NULL;
+free_entries:
+	kfree(parcel->mem_entries);
+	parcel->mem_entries = NULL;
+	parcel->n_mem_entries = 0;
+
+	return ret;
+}
+
+static int gunyah_reclaim_memory_parcel(struct gunyah_vm *ghvm,
+		struct gunyah_rm_mem_parcel *parcel, gfn_t gfn, u64 nr)
+{
+	int ret;
+
+	if (parcel->mem_handle != GUNYAH_MEM_HANDLE_INVAL) {
+		ret = gunyah_rm_mem_reclaim(ghvm->rm, parcel);
+		if (ret) {
+			dev_err(ghvm->parent, "Failed to reclaim parcel: %d\n",
+				ret);
+			/* We can't reclaim the pages -- hold onto the pages
+			 * forever because we don't know what state the memory
+			 * is in
+			 */
+			return ret;
+		}
+		parcel->mem_handle = GUNYAH_MEM_HANDLE_INVAL;
+		kfree(parcel->mem_entries);
+		kfree(parcel->acl_entries);
+	}
+	return 0;
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
-- 
2.39.5


