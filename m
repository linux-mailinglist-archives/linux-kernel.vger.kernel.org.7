Return-Path: <linux-kernel+bounces-857030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A1BE5AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D8405E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63C2E8DEE;
	Thu, 16 Oct 2025 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMjMcreb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CA2E6CC9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653710; cv=none; b=CxJHirwlRelCaLX2umf0xNiz5ng2ycWsLQlPgJm8N7/vIom+mfCXYV4yZnTq/bIQKW3OztBZFkWShhIDjE97JuokcF7H5M6oCwLyGKf7+5ir/vPguLiNiwNwIzCm2NcE4VtglrUfN6823ymr25FBH/5xcn2Sg93kPGUeEPiv4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653710; c=relaxed/simple;
	bh=oY878RYH2mslJwg0qdtPgRwIaldHQ7WLLqDkmC1ip5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5LeEskR9rhYNS6PHGofmRb0KofHMvbdCVIIf4B8v/ECJvPzy1RSuD9KHA6JIcBTKFGFPBr4Suo3h2jN8bUOTwGZe9a3VtZ0raiaN7PvOBV55A7vxKprfbj1lxw5jaIpKVl8uY6/lk25oPsFYciIQRDO7c0T55KnamkmgL6wD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aMjMcreb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so1994923a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760653708; x=1761258508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sod+h68sOef8XvTYH5hL66cOeE3tT8hv2lEauZbhw70=;
        b=aMjMcrebsvEVDGem52AzRNEsfOLc2COtELee/OXTzqx+XkHK/e3AABs6PvMDe2F4yT
         P5UgiQ1sx1246kMqzuVCjNt2+wiZ62bNpq8n8wkFi62z6fAjx+7Q7u40URB9FFiLbz9m
         1dUcOzpO2oUxRAeclliqVcmtw+EldGBU/zTCjXOIuiz7AMC1qCzdhWbhRDgvLhZNTB7v
         MdQi907MaYKb0mT0+gJzN/i++dBlPNC/n07Haen0ZHC78cyDF7OZc9We0PGSNrwqYz9O
         YR0kK7iDTQfV7406ILu4N/QzP+bJT5MyapQFaQYoABEIZFxXb/EYJqH6hePiePCdldHa
         2t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653708; x=1761258508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sod+h68sOef8XvTYH5hL66cOeE3tT8hv2lEauZbhw70=;
        b=o1qLMNMvwCcvinLcAZCHfP3F1RT0mSqYMdpaxXSJifm9znGDMFPpY2xprAbHsnv7jd
         Pa8TBr+notAkZNIN10XPX6ev7RueSipj1Vn6I99z6Wbdj4bPZyPevzu5Oo74BwHQoO5v
         jN6TPAwNSvpo7JUai8iSK4h2sHu8JMiVAh+ys0Hfz302wqpA4Pu7FqooSn2U2wg/K3zD
         Z+h0whJoXl+GWj9viDO2VbAljRyJZjIAAg2sRwiA652gYzHF5/Q+nNaQcCJ8QTxBiMJE
         PDoYVzlqBooCumdZwdE7lQC/BmqlHcuejPFsiBtPKBOpNElbe5bf4lHOf4Z1qo+gfB2P
         pgbA==
X-Forwarded-Encrypted: i=1; AJvYcCU6TAc1v11ofYjLqbksKVDCpWmoQ30P2Slks+3vgU7/cC7rwR+2yYmcvEfZmNPuyuSoMYoGjYOQxoM9ICE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifPaRQAc+5falQZ6QXpNB2q0mW/qnJcYriOAEVh3uoeVET4/f
	fYUsrgpWjxdwcfQ4M9GbQpmHteoY7A6R1mieMnm7eukIiULnG4x+kw8pE9MD2WSKI1CHFFdjPv3
	CBI9N2Q==
X-Google-Smtp-Source: AGHT+IEwdDYnEGjMumhEIrDhiWelgfr9l1shpL6etMLfOeb3DaDY5Ntm6comWTq6+d8o1CvS2P0n7vWtfUo=
X-Received: from pjbhi22.prod.google.com ([2002:a17:90b:30d6:b0:33b:51fe:1a83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c89:b0:32e:7bbc:bf13
 with SMTP id 98e67ed59e1d1-33bcf91b83bmr1495993a91.34.1760653707913; Thu, 16
 Oct 2025 15:28:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 15:28:16 -0700
In-Reply-To: <20251016222816.141523-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016222816.141523-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016222816.141523-5-seanjc@google.com>
Subject: [PATCH v4 4/4] KVM: x86: Drop "cache" from user return MSR setter
 that skips WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_user_return_msr_update_cache() to __kvm_set_user_return_msr()
and use the helper in kvm_set_user_return_msr() to make it obvious that
the double-underscores version is doing a subset of the work of the "full"
setter.

While the function does indeed update a cache, the nomenclature is
slightly misleading now that there is a "get" helper (see commit
9bc366350734 ("KVM: x86: Add helper to retrieve current value of user
return MSR"), as the current value isn't _just_ the cached value, it's
also the value that's currently loaded in hardware (modulo the fact that
writing .curr and the actual MSR isn't atomic and may have significant
"delays" in certain setups).

Opportunistically rename "index" to "slot" in the prototypes.  The user-
return APIs deliberately use "slot" to try and make it more obvious that
they take the slot within the array, not the index of the MSR.

Opportunistically tweak the local TDX helper to drop "cache" from its
name and to use "sync" instead of "update", so that it's more obvious the
goal is to sync (with hardware), versus doing some arbitrary update.

No functional change intended.

Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/aM2EvzLLmBi5-iQ5@google.com [1]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/vmx/tdx.c          | 10 +++++-----
 arch/x86/kvm/x86.c              | 21 ++++++++++-----------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 48598d017d6f..dc2476f25c75 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2377,8 +2377,8 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 
 int kvm_add_user_return_msr(u32 msr);
 int kvm_find_user_return_msr(u32 msr);
-int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
-void kvm_user_return_msr_update_cache(unsigned int index, u64 val);
+int kvm_set_user_return_msr(unsigned int slot, u64 val, u64 mask);
+void __kvm_set_user_return_msr(unsigned int slot, u64 val);
 u64 kvm_get_user_return_msr(unsigned int slot);
 
 static inline bool kvm_is_supported_user_return_msr(u32 msr)
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 2f3dfe9804b5..b7e2957d53d9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -803,13 +803,13 @@ static struct tdx_uret_msr tdx_uret_msrs[] = {
 	{.msr = MSR_TSC_AUX,},
 };
 
-static void tdx_user_return_msr_update_cache(void)
+static void tdx_sync_user_return_msrs(void)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(tdx_uret_msrs); i++)
-		kvm_user_return_msr_update_cache(tdx_uret_msrs[i].slot,
-						 tdx_uret_msrs[i].defval);
+		__kvm_set_user_return_msr(tdx_uret_msrs[i].slot,
+					  tdx_uret_msrs[i].defval);
 }
 
 static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
@@ -1063,7 +1063,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	tdx_load_host_xsave_state(vcpu);
 
 	if (tdx->need_user_return_msr_sync) {
-		tdx_user_return_msr_update_cache();
+		tdx_sync_user_return_msrs();
 		tdx->need_user_return_msr_sync = false;
 	}
 
@@ -3446,7 +3446,7 @@ static int __init __tdx_bringup(void)
 		 *
 		 * this_cpu_ptr(user_return_msrs)->registered isn't checked
 		 * because the registration is done at vcpu runtime by
-		 * tdx_user_return_msr_update_cache().
+		 * tdx_sync_user_return_msrs().
 		 */
 		tdx_uret_msrs[i].slot = kvm_find_user_return_msr(tdx_uret_msrs[i].msr);
 		if (tdx_uret_msrs[i].slot == -1) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 394a30bb33da..68daf94e0deb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -655,6 +655,15 @@ static void kvm_user_return_register_notifier(struct kvm_user_return_msrs *msrs)
 	}
 }
 
+void __kvm_set_user_return_msr(unsigned int slot, u64 value)
+{
+	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
+
+	msrs->values[slot].curr = value;
+	kvm_user_return_register_notifier(msrs);
+}
+EXPORT_SYMBOL_GPL(__kvm_set_user_return_msr);
+
 int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
 {
 	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
@@ -667,21 +676,11 @@ int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
 	if (err)
 		return 1;
 
-	msrs->values[slot].curr = value;
-	kvm_user_return_register_notifier(msrs);
+	__kvm_set_user_return_msr(slot, value);
 	return 0;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_user_return_msr);
 
-void kvm_user_return_msr_update_cache(unsigned int slot, u64 value)
-{
-	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
-
-	msrs->values[slot].curr = value;
-	kvm_user_return_register_notifier(msrs);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_user_return_msr_update_cache);
-
 u64 kvm_get_user_return_msr(unsigned int slot)
 {
 	return this_cpu_ptr(user_return_msrs)->values[slot].curr;
-- 
2.51.0.858.gf9c4a03a3a-goog


