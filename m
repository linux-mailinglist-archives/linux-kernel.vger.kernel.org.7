Return-Path: <linux-kernel+bounces-825281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54763B8B7CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA05D4E21F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB32E2F1A;
	Fri, 19 Sep 2025 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkIrvUcM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39282E0B73
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321202; cv=none; b=MGOkWU60LFW6MvI0xF5ARnumW9dnZb98XMIVJGsBeavuOH0ByYdzrqEsnSzumpDWWgotvCsN+mvtKIaroNdVfQDfe4xyCYDg7PEP+hMTL44AXlBsEBGfA2Mx4KRaDTDlXk/WXLpVPGGd2JTO26BYtTMOHOrtk5xCzlS/0znZnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321202; c=relaxed/simple;
	bh=ez4a0EvjjtyHc093VLzuQLspYqBK0zm6wW8jLJdW4u0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkMR8JGd19iUetEkaXhStySuSz9hxtn+RhGUEien7x6XtRbA+oEHgtkgCKJ0xSCUw7/Ww7K9jksBEfM4rr33YGYRjG1J27622KjfMNwQ8vFM2MeY+PmIZngfWJzEWVuYTH2ARgPmi9PXtKedDG7ASsQjruPdG6dpyqMSgqXRSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkIrvUcM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec2211659so2566102a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321200; x=1758926000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pOmn1hzdWZ666uhIyCKCS3d5Tvi+EBzamfmIdMDGoZg=;
        b=FkIrvUcMMOlDvaHz4TtYYg+OqZ6bGIjIfGA06RdlWDaX3OAwlZVrNCkFTfo/YGPakm
         3617E8eDGx2DJyFdMBZWmi2giukJVytur129LjAjIT1swneau721DWCQ05OLmpkDfJoH
         M/o9SNMuOtMm0eH9fZfAk/HeQZy8EH0D4uPNy0Wv+v8TMHUqA5xNpD/8TofuBHNHPoQW
         BctppUFp7WxOxwZQ2grS8FZmPm6I+4gtXmwVuaAROPLJIuoONJvW6hxmBJqkUIcaDYYk
         xq5FQpPHDnT7d6wSrQoBKStVN5d9+tgB7v7aoPnYfhZ0MlWkPAP8qjD9IGwZExUwy/P6
         XceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321200; x=1758926000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOmn1hzdWZ666uhIyCKCS3d5Tvi+EBzamfmIdMDGoZg=;
        b=rn4ptujUqhOE6YVp2wzKp9ZZoJHRJM6+nbSVrziOxEGuG+Lqq8fW15F6v8Z8ZkH/t2
         qzgtIAcs98s8FB5ZHMtR/X4XUyFOF4mtMw35fmJ7jA6Ur2Y125UGfKp0JlNuJoxUAotB
         09KR9oYQqDCIHX60dYOGtfH3iTEg5RjjBuHDmoDMmkQ0kaQH+B1CUV8McCi5mo1jbC6Z
         JK7DeJwL05H9fAnIE0ncD2slE+ThEi3Vu4NhxFRS+tT84lFUBGh7VYQwxzYWtIf18Ct3
         w1q7Nrp67vr2L5f4ePhVsLcE+BfvcLvLcGXcUOx3I9AbaezYQLU7mvMO88LA0n/QXIPx
         nYYA==
X-Forwarded-Encrypted: i=1; AJvYcCU6UEocaDmvoKFF9jo+pgSslbW8I8cbJIkTBH4Wj05gBCyE28QmpfxP1a63WnZfv8nfIayas2IAFXrFgdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cvinypfJ+13xJxMYfz4RaXu0lgzUcLtA3Wutc4NcW+89pAJq
	7n6jENufcufKRGlHpsZPigXjhkS1o3Xxl+M2PJqMzJvUht2Og1EkkhxnlY8eSrlFQuXKlzK8tC+
	O/hoDXQ==
X-Google-Smtp-Source: AGHT+IHPp+EMEqqepgMRLXkmh2NAYmJDXHdpPXFvlA0cxdH2fcNuhXSpiI6o1vBaj4gvOZIsi3vnHYEIRwA=
X-Received: from pjbmf16.prod.google.com ([2002:a17:90b:1850:b0:32b:95bb:dbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e703:b0:30a:4874:5397
 with SMTP id 98e67ed59e1d1-3309800134amr5713441a91.9.1758321200242; Fri, 19
 Sep 2025 15:33:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:17 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-11-seanjc@google.com>
Subject: [PATCH v16 10/51] KVM: x86: Add fault checks for guest CR4.CET setting
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Yang Weijiang <weijiang.yang@intel.com>

Check potential faults for CR4.CET setting per Intel SDM requirements.
CET can be enabled if and only if CR0.WP == 1, i.e. setting CR4.CET ==
1 faults if CR0.WP == 0 and setting CR0.WP == 0 fails if CR4.CET == 1.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ae402463f991..d748b1ce1e81 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1176,6 +1176,9 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	    (is_64_bit_mode(vcpu) || kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE)))
 		return 1;
 
+	if (!(cr0 & X86_CR0_WP) && kvm_is_cr4_bit_set(vcpu, X86_CR4_CET))
+		return 1;
+
 	kvm_x86_call(set_cr0)(vcpu, cr0);
 
 	kvm_post_set_cr0(vcpu, old_cr0, cr0);
@@ -1376,6 +1379,9 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
+	if ((cr4 & X86_CR4_CET) && !kvm_is_cr0_bit_set(vcpu, X86_CR0_WP))
+		return 1;
+
 	kvm_x86_call(set_cr4)(vcpu, cr4);
 
 	kvm_post_set_cr4(vcpu, old_cr4, cr4);
-- 
2.51.0.470.ga7dc726c21-goog


