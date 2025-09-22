Return-Path: <linux-kernel+bounces-827756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D9B92A41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7967B35F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547D31A072;
	Mon, 22 Sep 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XevxrgIr"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E614386D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566868; cv=none; b=qz93GVXr7Ts/rO4VM8ckrCc2X1/8I0nGAvI57q66c53AUGmlwvcb3O4YrjuoSb9Ci9ktmvVPbxjbQv59WhsUfPlnNGrYDwQ+CDtNVEK63mKE0BMCXE/3UMbPtNMwoD9A1/xTt5KrobR8bkNkH5ffoAF7RB6Tt97zjCKx7L61aoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566868; c=relaxed/simple;
	bh=wbUDsEuejmM6LgX1Hj/KaKt6+BgZxwAmcKIRV/X+mqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZXOFC6cm2QyJ3jtXchM0Rhnes8vKkiAVrkY2fsrU941E8tXQHib4Og9E9BvuvUZ7X7Bz63DgI5Qads31Fl6/7JukYq69JdbvIaKYhNJ2cQuYGctnNzoYUNPcNsoXFsBDiS0tFozuwKbY0Qi9vo/JG5uC4RSGDe1WfmjZ0XCar+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XevxrgIr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so7597492a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758566866; x=1759171666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0UpDKhoRLh7dpDRy6uigY5bqnigEpXRuNEVRYUji54=;
        b=XevxrgIraHfykLM0SGuXBJhCyf9zUf0Ii1fiG3vmTn+yXNcE2zdMqdmoZYRPj5uWnr
         YduJIoKBI50wzuFndyNrIeVuUSBb73H3xLAmL4prs+ekQ6BeP5dGkhj6a/DpU5f1OsmW
         HwaceTNN6Bf3gZoj0XtQ4z3mFSpT6yRDPoYHGv+gxeUkZnuMYb4UrB0rfmucwwzw5fW4
         yjSeAsqq7m6IPSNYk0EZfJsM1fgX7ItQr+NLbiPU40ayMgFUyzwsY/bvw3d52sZk7L1D
         9xCnhVUGK0pakznKXCEeNxaasGDifmjwTX4qBstkQfZfbYhfGn0HKJSjSi6CNL7xT/vv
         4FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566866; x=1759171666;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0UpDKhoRLh7dpDRy6uigY5bqnigEpXRuNEVRYUji54=;
        b=HxnhSbZQoQ3lO1LUsdaL6XMuuR0A+vakzfVLIEeV9DD8EYQAVwfZHKKTBJ7r3EWgCh
         TBFxiFStr15a2ELAgE1yIKjDJ43ILOj2CNHskKcyvr17aiz1DIDwML2OX9utrSVhzemI
         YV/vH9FsIL+hI4Y72P7G1ZN288Xat2E5QDPd7IEQgaqgPGjWeXsbQB8QdxY/wvjsgb4d
         o6HEMMmN6QeaUnAkjmukQvQSbg1LJgEzHvycNKxBYxCi7jBcdRuWycZlxhiDpjgUdeCH
         HjUJtyx1SMfjx9PaD6ItBBRwcbT4Goka9wajDlJM0sIwLkhHNwihGvyTtRV8xDKEswQ8
         Fc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG7M3xPy6qOivjVkiNizAs0aItY8lkR678L2Gm1pKMqhpepecs7mKoRVLV11ttZLj24jwYeve3AWIx9pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UDqtmW/PgMwFhoRkMoOwpzqX4EmZD3lf9KBfN+knvIfyaFPj
	/8auGk/HQDW5VpyOeFBDnFUUhiCW7ZKNrmfM0v4C7+nvfMOd5bF6HSx3/UqH8Ki0UvVBZecVnB0
	cDnMAWQ==
X-Google-Smtp-Source: AGHT+IEjlvdFs7P6ZUHLEhAT6cz3bcJ8IRMZO+Skz6MNKFJhZvvHWfyBM2xfHi4RsFjemOBmhymu89gdFCc=
X-Received: from pjbqn13.prod.google.com ([2002:a17:90b:3d4d:b0:31f:2a78:943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5109:b0:32e:e18a:368c
 with SMTP id 98e67ed59e1d1-33097fdca4dmr15334777a91.7.1758566866504; Mon, 22
 Sep 2025 11:47:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 22 Sep 2025 11:47:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922184743.1745778-1-seanjc@google.com>
Subject: [PATCH (CET v16 26.5)] KVM: x86: Initialize allow_smaller_maxphyaddr
 earlier in setup
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Initialize allow_smaller_maxphyaddr during hardware setup as soon as KVM
knows whether or not TDP will be utilized.  To avoid having to teach KVM's
emulator all about CET, KVM's upcoming CET virtualization support will be
mutually exclusive with allow_smaller_maxphyaddr, i.e. will disable SHSTK
and IBT if allow_smaller_maxphyaddr is enabled.

In general, allow_smaller_maxphyaddr should be initialized as soon as
possible since it's globally visible while its only input is whether or
not EPT/NPT is enabled.  I.e. there's effectively zero risk of setting
allow_smaller_maxphyaddr too early, and substantial risk of setting it
too late.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---

As the subject suggests, I'm going to slot this in when applying the CET
series as this is a dependency for disabling SHSTK and IBT if
allow_smaller_maxphyaddr.  Without this, SVM will incorrectly clear (or not)
SHSTK.  VMX isn't affected because !enable_ept disables unrestricted guest,
which also clears SHSTK and IBT, but as the changelog calls out, there's no
reason to wait to initialize allow_smaller_maxphyaddr.

https://lore.kernel.org/all/20250919223258.1604852-28-seanjc@google.com

 arch/x86/kvm/svm/svm.c | 30 +++++++++++++++---------------
 arch/x86/kvm/vmx/vmx.c | 16 ++++++++--------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 54ca0ec5ea57..74a6e3868517 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5413,6 +5413,21 @@ static __init int svm_hardware_setup(void)
 			  get_npt_level(), PG_LEVEL_1G);
 	pr_info("Nested Paging %s\n", str_enabled_disabled(npt_enabled));
 
+	/*
+	 * It seems that on AMD processors PTE's accessed bit is
+	 * being set by the CPU hardware before the NPF vmexit.
+	 * This is not expected behaviour and our tests fail because
+	 * of it.
+	 * A workaround here is to disable support for
+	 * GUEST_MAXPHYADDR < HOST_MAXPHYADDR if NPT is enabled.
+	 * In this case userspace can know if there is support using
+	 * KVM_CAP_SMALLER_MAXPHYADDR extension and decide how to handle
+	 * it
+	 * If future AMD CPU models change the behaviour described above,
+	 * this variable can be changed accordingly
+	 */
+	allow_smaller_maxphyaddr = !npt_enabled;
+
 	/* Setup shadow_me_value and shadow_me_mask */
 	kvm_mmu_set_me_spte_mask(sme_me_mask, sme_me_mask);
 
@@ -5492,21 +5507,6 @@ static __init int svm_hardware_setup(void)
 
 	svm_set_cpu_caps();
 
-	/*
-	 * It seems that on AMD processors PTE's accessed bit is
-	 * being set by the CPU hardware before the NPF vmexit.
-	 * This is not expected behaviour and our tests fail because
-	 * of it.
-	 * A workaround here is to disable support for
-	 * GUEST_MAXPHYADDR < HOST_MAXPHYADDR if NPT is enabled.
-	 * In this case userspace can know if there is support using
-	 * KVM_CAP_SMALLER_MAXPHYADDR extension and decide how to handle
-	 * it
-	 * If future AMD CPU models change the behaviour described above,
-	 * this variable can be changed accordingly
-	 */
-	allow_smaller_maxphyaddr = !npt_enabled;
-
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
 	return 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 509487a1f04a..ace8208fc1be 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8479,6 +8479,14 @@ __init int vmx_hardware_setup(void)
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Shadow paging doesn't have a (further) performance penalty
+	 * from GUEST_MAXPHYADDR < HOST_MAXPHYADDR so enable it
+	 * by default
+	 */
+	if (!enable_ept)
+		allow_smaller_maxphyaddr = true;
+
 	if (!cpu_has_vmx_ept_ad_bits() || !enable_ept)
 		enable_ept_ad_bits = 0;
 
@@ -8715,14 +8723,6 @@ int __init vmx_init(void)
 
 	vmx_check_vmcs12_offsets();
 
-	/*
-	 * Shadow paging doesn't have a (further) performance penalty
-	 * from GUEST_MAXPHYADDR < HOST_MAXPHYADDR so enable it
-	 * by default
-	 */
-	if (!enable_ept)
-		allow_smaller_maxphyaddr = true;
-
 	return 0;
 
 err_l1d_flush:

base-commit: d44fa096b63659f2398a28f24d99e48c23857c82
-- 
2.51.0.534.gc79095c0ca-goog


