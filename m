Return-Path: <linux-kernel+bounces-858700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6DBEB7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0062C6E812D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5213233B951;
	Fri, 17 Oct 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McP2cB7F"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0030336EF8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731958; cv=none; b=lfM0YE02F1F3OF2uLWQ02YVhy7qRuNCSdL+bvNj5BnCIY0coyEoEIFzZTWCE5PZMtoB1XG4nrgjYORywthpD+z184nvaQOLMVjncE0UBn1HwvfwphhaRuAncZnSqRC5JfEhiHrxqsbMDrtsLPaNTRgxUxcfJfpf62UYZv+/2MD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731958; c=relaxed/simple;
	bh=Tt0+Pkd1zdjlSryJQZy+YeVqss0WVcZyPgwOd/oHmb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZc+SvPKn/SX5RVJtICN4h7ZfTGFjKGmpxr3xd1RsKshfsIBPyOqtFIxFGiIfoLzuWlQUZo9uEcpxfp3MNEhoJcO1lDQnJKV+GS7QOHTX+WUD3WbAvCQQ4xohqPnKZiq8CdGR1QTvxKypO2dViZ8InUm/4whVo/GWOpsRCoGrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McP2cB7F; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bdd0479a9so1224197a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731954; x=1761336754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEij1CupCDGyNPjfKEYxhnSr/WYW50lo3K/U1CWabEc=;
        b=McP2cB7FUaUH2DOzSlvE1xbVkMjVQyszi6PnlIc7UehMTITmX8XurYLFB2c3IrWrkQ
         M86K9D3kjUDRzEBgmTMZrt3Je9eYgYRu9FKAFmd1p6/IBoX+JsM1mpZXWMARILKOyAOl
         XO9odIQ9Ovs5v3nwfqgPo66sgxkT28SJwLV/+wSlbY64qtz8pEwTMwMtHnwBMBtnDu+w
         o5QQjxL3YJM5c60zIVp0JrepH+dHrRu9Apvhu9lJBdbCzBG0Oy81qloRSOIXO5Jl8lW1
         MvvgmjU2lX2OYk7KYFVbJsO8bMoV8gJwCpv/ziH7Nzomw6+oRcHlSu8sBhX75EhuBfT8
         ky8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731954; x=1761336754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEij1CupCDGyNPjfKEYxhnSr/WYW50lo3K/U1CWabEc=;
        b=O8yxMqct9UhyA+Akc2aa2lHhhbt05S6E5FLoPNEKDHKcsD8zgnbvjzrtuo8o7rQumq
         6QvPbRSH8r2Vw+Lv+4W26pOfqJRkQkdj2wB9sG5jLPkunZ/hA9Tg//zEukJp9Ljn/V2P
         3sEntRtipmyFJolK2lT/ZZyC6VwkyEM7kSLEkWz9+UWX4u48MDJBE1bqAWVV/biKg84b
         JiRGlvgNyEyTZkX3/oIPlu+jwTDbJS/K3MnL48BXol12RG2wqYhAxqwRXLeRWX37MOAW
         IH/aGek0xHLV7TXi7DkogPlcmWFPXCCt0iGrs/FQBE2J4RFl4WKfUSJMzziTwEwd9i1G
         /ndA==
X-Forwarded-Encrypted: i=1; AJvYcCW0brLDPQboJ5bW+3R2TVMg5mXMAQUBWZX0k/8lH5u/Ow9hbbmM5siEQ5MtW/zLnXkGwH12rPlSX39ztkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgNoznIZ1uJZ0VW9fPgdOirdtuZ5WP/YLvYkcMbYWQLlKbq+f
	Uq8av6QdWooWBQlTHD7HQBqZTnmCx/EfroqGSYeojrgZvR97MAsuv1B16Ww11IgLVuq2sorG3Ea
	AsvQaFyZY8c8jhlxh7vkBaqHZcQ==
X-Google-Smtp-Source: AGHT+IGB3FEZBVXofYnV/2OlFnNwgrJDt0eUkK+vRXpIJeJOVHDG0MgXbSCylMyEgGvaFtRNgbmZV92cuc0fSiwxCA==
X-Received: from pjvp17.prod.google.com ([2002:a17:90a:df91:b0:329:7261:93b6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5623:b0:33b:d371:1131 with SMTP id 98e67ed59e1d1-33bd3711391mr5701672a91.34.1760731953647;
 Fri, 17 Oct 2025 13:12:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:44 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <405686bacd68ce6c76aa5e6ef40f0a5324983c5b.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 03/37] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
on kvm_arch_has_private_mem being #defined in anticipation of decoupling
kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
guest_memfd support for memory attributes will be unconditional to avoid
yet more macros (all architectures that support guest_memfd are expect to
user per-gmem attributes at some point), at which point enumerating support
KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
supported _somewhere_ would result in KVM over-reporting support on arm64.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fddb373fcbaaf..21bf30e8d3cc1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -721,7 +721,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f73047ea4333e..591795a3fa124 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2428,8 +2428,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+#ifdef kvm_arch_has_private_mem
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
 
 	return 0;
 }
-- 
2.51.0.858.gf9c4a03a3a-goog


