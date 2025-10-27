Return-Path: <linux-kernel+bounces-871416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C5C0D2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94F2404558
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89442FC00E;
	Mon, 27 Oct 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGo7/+Ys"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEF2FBE18
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565082; cv=none; b=LAeUJEmw9gIqxkvFsBRj9wTdtrBtEWytwNFLIKkboGrkC++ez6YNKn9sXnwa9pO9Xz/jdJnethG53uStHxc4qukmo2XYJNxubjF2GhDeQpTEWsVVyiC3CrDZVpxjFoan2Pc/+gazbvcoo/iR7rMfgeK+PRpC9oixswWqE2vnf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565082; c=relaxed/simple;
	bh=JtPobr8U8OyEtWz0+PGGaZRwq4swI0tEr8EEUNz/8Bo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=TG1O339IaFVbU/RXa0rZfCQwswfSHNooo95dxP4vyHxMvR7x51bZFo1xWlIgnPtqcsDpyMpyOAi8RtmcGPVJ9NnOYX+r+aByjViJBnrTfvy9nJrpGyDf38XwlUXwYf0WqrtyLRb966rKSXZGdc0UQwZRkrtkklMozPdZz2NiZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGo7/+Ys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761565079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0IYenQhIa9PZj00vW7IIruD0UnAnXJ3V9tGf3ph9/f0=;
	b=VGo7/+Ys5Dd3Pzzf8dyqsznvrnmthjtvQpStb3yzJ0GONnh63DaqEGsY8V5YNqOT/OqjP3
	dNgBECqsl7SbV+21uZ6hij5v7+wrj6gU2ZJjc5EfI7t/qNe6+ss4gp90Qr5FpDmWfiuqI2
	6EMR/Tu3bpt7nIVsBZREh6HNGZHiBQA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Ef3ZD4NdMJOuwTQB_JW2Bg-1; Mon, 27 Oct 2025 07:37:58 -0400
X-MC-Unique: Ef3ZD4NdMJOuwTQB_JW2Bg-1
X-Mimecast-MFC-AGG-ID: Ef3ZD4NdMJOuwTQB_JW2Bg_1761565077
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4256fae4b46so3221648f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565077; x=1762169877;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IYenQhIa9PZj00vW7IIruD0UnAnXJ3V9tGf3ph9/f0=;
        b=oklBGGcFL56OtvODC5aKUqgdLz0ZpVMrwB2v0FXK31E/dsuYrLwylPjXpD0B7c7Sxi
         hk/+/zdggutSyynkmOrxs4zZxDqd+r2AnK1JFzVWQmfLIkSeZvphobn72kVSFdDry3bu
         dHHrs8lRVcVw6J8s/c6JCfhwbAJT2vPrnG4yXpqVnAuvysmLyyC2XwItWtHnSeZdZVjs
         x56IMrkOiETTN5+SXepRq9J1syUg5w1FPe0qGb/F1L4fY4HmIahLd/bXoNPjJCyfCVtu
         UWSM9K6LQu4gWWJwfly5Wt30xGM9FFjVXZ0oyKXvyvbqVtcDNFsWF7i647FmOt3tgsvW
         Rf0A==
X-Forwarded-Encrypted: i=1; AJvYcCXUsK9jOR3S3kWIMr0iH1bcNxF+AOW3XSB8U0Aj1YfMGrH2DqIk6+9bOCIterRZorbTqiMQqK6EYeMIQ44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0FyDNde1bcjmEJTjdTxR3nEsdazACaEULM3LsjyhiZHxpm9F
	F4g6h0VzkOGQd0WheR/ZXosXvWXHWaW9zr75FyZJhjXzDkk3NIuWtcLtiW49EAs20lXvnEQMNuH
	cXpkcsqWZBcIrGdssboaS6D5FPNLU+dPqKGjQFhY4qA1XwMHyGLzdlD/3f8n4RYuyOw==
X-Gm-Gg: ASbGncsjUGQ2p34mmCAQssbyLXHa/6iYVkkmmB9krf9HMIGhQ+tLpYtw15yAHMBfMsd
	v1eefeEEUbNRASE4NbIOlR5pZh1zOiNZ4e93E/boBSe9v+T4lyAjt7qJDVIdoT2AxJTtMelPhop
	1QtmxSz6nhlQ9StOREfzjv2EKjJNowUM8ty3DpUCZkaHlFqm3GWDB1uThLMGZqAun2lOaZtNNIb
	pxNKapvKYbmtjdU2UOv5/NDa/PJL6PyMY691pY1kO4UQpsaEdUyVDOtFLkMblIMryQdxH4gdRoQ
	Ca7HyJzY9KAMj4UZtxbNbPBD60lBOZnWciKVrMdewL49vB7FmMWVkhoiHgGM8V7rUDuQHNL97mT
	pqzqZZCXtRU1mgIDb2/5d2dB6sGhKR/sEEq0Qptt8YzgKrO7o
X-Received: by 2002:a5d:5c89:0:b0:425:7406:d298 with SMTP id ffacd0b85a97d-42704d7e9ebmr30407494f8f.5.1761565076785;
        Mon, 27 Oct 2025 04:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGx4uKgsYoM0fU52HYyWEvQMrYgypwVSrAUmI9lNjcwUX5i2uMZCdkDcF1SDu586SVN9WApQ==
X-Received: by 2002:a5d:5c89:0:b0:425:7406:d298 with SMTP id ffacd0b85a97d-42704d7e9ebmr30407464f8f.5.1761565076305;
        Mon, 27 Oct 2025 04:37:56 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7e8sm14108931f8f.19.2025.10.27.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:37:55 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:37:54 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
    Sascha Bischoff <Sascha.Bischoff@arm.com>
cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Zenghui Yu <yuzenghui@huawei.com>, Joey Gouly <joey.gouly@arm.com>, 
    Joey Gouly <joey.gouly@arm.com>, Will Deacon <will@kernel.org>, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Failing no-vgic-v3 test
Message-ID: <f9c7fffa-53ba-a506-b48b-07e3df2d1d5a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hey,

on an ampere altra I've got a sad selftest:

[root@virtlab-arm11 kvm]# ./arm64/no-vgic-v3
Random seed: 0x6b8b4567
==== Test Assertion Failure ====
   arm64/no-vgic-v3.c:66: handled
   pid=3793 tid=3793 errno=4 - Interrupted system call
      1  0x0000000000402feb: test_run_vcpu at no-vgic-v3.c:128
      2  0x000000000040214f: test_guest_no_gicv3 at no-vgic-v3.c:155 (discriminator 17)
      3   (inlined by) main at no-vgic-v3.c:174 (discriminator 17)
      4  0x0000ffff873eb587: ?? ??:0
      5  0x0000ffff873eb65f: ?? ??:0
      6  0x00000000004022af: _start at ??:?
   ICC_PMR_EL1 no read trap

This is a guest without VGICv3 on GICv3 HW. The test expects UNDEF on reg
access - which is not happening since:

3193287ddffb KVM: arm64: gic-v3: Only set ICH_HCR traps for v2-on-v3 or v3 guests

As a local fix I've done:
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 6fbb4b099855..1fe53a021926 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -297,11 +297,15 @@ void vcpu_set_ich_hcr(struct kvm_vcpu *vcpu)
  {
  	struct vgic_v3_cpu_if *vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;

  	if (!vgic_is_v3(vcpu->kvm))
  		return;

  	/* Hide GICv3 sysreg if necessary */
-	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
+	if (!kvm_has_gicv3(vcpu->kvm) ||
+	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
  		vgic_v3->vgic_hcr |= (ICH_HCR_EL2_TALL0 | ICH_HCR_EL2_TALL1 |
  				      ICH_HCR_EL2_TC);
  		return;


but following the intention of the patch above maybe we should do smth
like:
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 6fbb4b099855..1fe53a021926 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -297,11 +297,15 @@ void vcpu_set_ich_hcr(struct kvm_vcpu *vcpu)
  {
  	struct vgic_v3_cpu_if *vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;

  	if (!vgic_is_v3(vcpu->kvm))
  		return;

  	/* Hide GICv3 sysreg if necessary */
-	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
+	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR0_EL1, GIC, NI) ||
+	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
  		vgic_v3->vgic_hcr |= (ICH_HCR_EL2_TALL0 | ICH_HCR_EL2_TALL1 |
  				      ICH_HCR_EL2_TC);
  		return;

Thoughts?
Sebastian


