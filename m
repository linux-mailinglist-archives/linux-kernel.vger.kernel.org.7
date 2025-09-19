Return-Path: <linux-kernel+bounces-825297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F7B8B8BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848687BD136
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F62FBE0D;
	Fri, 19 Sep 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOK0S79l"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987082FB09F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321233; cv=none; b=d3dceOxWLSnLgHyNghG2QiueSTaNqIcDj3pZ/gmp9D4rLqjaRRdTjTqAkrllVL5x3r6IoMrad8ACeh0N/yqJVKpttWPOHQpaNEYXjF7+5If5IMApsduHr92hl8/zcc8WwjdQObc5I3vh55uVlJXT7IpG5+7FI6kSMXqQJWNpg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321233; c=relaxed/simple;
	bh=/tqPBTeDuMrFe1AL4FE5D/cKrgiWfqZL6tyxrCfO6SU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m9fnw8b55Ba7CMtE5OATsKq4FdWX8FvRu8ZBBH324gQ+0VRmnG1Qt3Qrg+y5ZyFt7Afa3DNNmehY1qF4C4iGnvMs5wx/wwJLfJ5M9HIi0NllSJgkJzvN509fkN2j6v0jhLESYTqwEdFo7nGINX1+BJtKYr5+Voyx9QNVB2QC4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOK0S79l; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24456ebed7bso32555345ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321231; x=1758926031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HedB0vqjCe4vRRpTggbdQsycmWfrhYSfaZmK+vmSq88=;
        b=fOK0S79l7H4WA0EbcTcovTJcXBa49hpS1Wv3uL0TCmgk9opC+S0z8AEMnaCnhFRppp
         onmPslFCJ0MLZDZ9Whpoxw8/gZ3iHL4hFEhYFKW/9pIGj/ruq10gNIYXrk24Vr+u32z0
         MRVuMlX/IKx80+nhdLmd/v5gces8fbRgZJinAXVpzzRzGtsQmYRJcklirdgh8wDH4eWn
         ViWdW+hx0OqzqGw9nmWtK6pQn4//unZNqsl02pLgB/aT4PUguupPQosgBhuAbaSUqEL1
         NdvkPTz3im3ProQD4aNTnokbiLzL53+k3Yo/zr7mTuYe5ti1tYUh8fKTM2f4nnqJ+C3u
         MqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321231; x=1758926031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HedB0vqjCe4vRRpTggbdQsycmWfrhYSfaZmK+vmSq88=;
        b=NbicgFNqkYHABp1xcHa0IXNnJKCw874j+y+XW1sW9OIidG5UPTHiuUJPNmcF1mE94a
         jw+T7wbDD7c21+GIvpg/c5b/QjAN4c5l06YFM1DIYYz/fZuVQCKTUDZEa6Rz/hr3rYGn
         ruTMxGt/5OM4WC8rhstG35t16E2mopzJPJNWqpWTwUDEhdbcmIiLgZDPgtRBBGZlJUN4
         e8poLF5CHNrOX6ztFEwDWDPfT7ro1VUeIenKnLP7+srBl+icC4A8Fl1ZjtTZwgQXDQsh
         2we6tpuqGBRBg4fhywe1tjxoroR83WQzCnC+WNAJTdX+ddAD9FjMithtYPVU9M6HI4lT
         GHiA==
X-Forwarded-Encrypted: i=1; AJvYcCXS6Ln62j5mLgUYtHPH5S1jY+kk8n7RYGgs6iQZwa+xcSPkxcVfLNI/BJ5rRRo3b5ArJaqo932//0myhrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTo8g461PCeU7zbPCCurzqNBNa4PBF9v63hxpsTEoaLLqAxVCs
	Xgkw92ejNPSmiC6fdc622856wKRlYh9qhXqFcPvr1fS35w0VvxvRowk+xBxSapzrnsdtzoRsrPc
	m28U8jA==
X-Google-Smtp-Source: AGHT+IEljnIzRoy1UyE5BtCbUU4Z9ZtjJtcURZf7n7UmCN9hEURvx8fd1jTPH7oZwx5u199EJlJyB4GvKnY=
X-Received: from pjbsw8.prod.google.com ([2002:a17:90b:2c88:b0:32e:e155:ee48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec8:b0:267:99be:628e
 with SMTP id d9443c01a7336-2697c7ea3c2mr109901915ad.2.1758321231052; Fri, 19
 Sep 2025 15:33:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:33 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-27-seanjc@google.com>
Subject: [PATCH v16 26/51] KVM: x86: Disable support for Shadow Stacks if TDP
 is disabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Make TDP a hard requirement for Shadow Stacks, as there are no plans to
add Shadow Stack support to the Shadow MMU.  E.g. KVM hasn't been taught
to understand the magic Writable=0,Dirty=0 combination that is required
for Shadow Stack accesses, and so enabling Shadow Stacks when using
shadow paging will put the guest into an infinite #PF loop (KVM thinks the
shadow page tables have a valid mapping, hardware says otherwise).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 32fde9e80c28..499c86bd457e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -955,6 +955,14 @@ void kvm_set_cpu_caps(void)
 	if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
 		kvm_cpu_cap_clear(X86_FEATURE_PKU);
 
+	/*
+	 * Shadow Stacks aren't implemented in the Shadow MMU.  Shadow Stack
+	 * accesses require "magic" Writable=0,Dirty=1 protection, which KVM
+	 * doesn't know how to emulate or map.
+	 */
+	if (!tdp_enabled)
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
+
 	kvm_cpu_cap_init(CPUID_7_EDX,
 		F(AVX512_4VNNIW),
 		F(AVX512_4FMAPS),
-- 
2.51.0.470.ga7dc726c21-goog


