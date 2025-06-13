Return-Path: <linux-kernel+bounces-686254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5962AD951B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 21:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AA71BC33F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DB275B12;
	Fri, 13 Jun 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kez1Vmlu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88D239E79
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842063; cv=none; b=ii/UL2wDSBUIsq1h4OiI2KFRi1CJfqITcskWdquuMD66HUSffzXVIusSjl+Z4fXfgoL0UBxA9vKGriHLPHeS6EJYLzsi1i7DcSibxlsx9ChjHxR91dFmyMl2mkI0Wvb685sJ4ucQfzg0eWTrSR9E91khIaLEhDtH+6AaehBEkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842063; c=relaxed/simple;
	bh=WuNQeIEjxP0MpZ43wQJ8QH7/E4ptzd6ZC4ALnAIRTio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZooaQ+h/6efCwoSRNnlJuGsng6m756Lvt4K154+gv9dJION+pBLIjcmCf4lKbCj1Eb2OWAvMcDuXFPBqTAZArxTKQ9Vo4BA6BhrMgk+Rc2iMn8tx8zBaPKtyH8mXoqyawIRJgD8AUPrCR53OqpA0heeWpfOLPM3T5BSX0qSayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kez1Vmlu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso2104833a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842060; x=1750446860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK8PSoEGI5Kbvnp6kPiiz7QOvkRIGce991kbDt0U/HU=;
        b=Kez1VmluuKC4Hhsc58tcbMt3SFtDCOg+rO6quYIdNFPBDKxRK7EZosIZPiS1gDxSsJ
         QibalauIbXzcL5Txt8fcW+4jUO2ow9riW9GGrV6/sUZL21K5Mqio9AHha+KVA17/8YYq
         gDvRcXkEn1hizdrXuH922dysA5e6Wy5U5/gJq6F9rMC+CsCRagNAfcilGCdg2fVaBjXu
         W+1AG4CuQRAs4mLvjhMeuYqqgvIoLtHhFTJdw3QOPujfA5sNa/cgnqtLaUGLUdL4zIAT
         KLFarg9edTW1f6bmMr1VN2dRJHBKdP5gJKBilHYDxvannRyFV1XJNgO1pycjyxKTc6he
         K+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842060; x=1750446860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK8PSoEGI5Kbvnp6kPiiz7QOvkRIGce991kbDt0U/HU=;
        b=YXQBoWvLY21Xoy/V+wMWd4dNxvorVqLAKnS2zhZykIYhYQAs4wDjjZm9LNiKMReyzP
         zo/DlfqXUBHGBRgrnqbxVlQVak0Y3lasTky8D19fOg5h6vrIRXTjb+DSKFZzX5oF92Av
         UdLHfIJs73LickKhRpdfRASYiyG9tHImbHNDy2nO7mcu3uIdkLlFeVMmeRNF3t4hX7gu
         HKLxPocwjwNgw02jFl4DfHDZT1ejoLlRSOSy42FI4iMNTq9ulBxQTiRF1rt7Lk4g/HhO
         dDupEZa//A8g9pMMn9xyP4wsquTRqLVQ+awJqRCdgIyE179ukIKNrg0+5e2n/8qQ78z5
         fS5w==
X-Gm-Message-State: AOJu0YxQvSECTrbb5GBlfD2oU4l6olRJeI10+tIDNOhQ4dryTZFL0l9c
	MIrhyJxuFS2zd9/dcMv1HDQ6/T9CXjs9HGmmfk0j9rxZcePuLTGiSy2FVUXunKeaLWLbcqzlsi0
	ADw==
X-Google-Smtp-Source: AGHT+IG2rnq08o1rOOulMjf3/xAjuyKFVtU58bEMOUg+186GSEJdawuT9DZLEd/V6esV4Z1DRz0RGaOAmQ==
X-Received: from pjbsm7.prod.google.com ([2002:a17:90b:2e47:b0:312:f650:c7aa])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dcd:b0:311:a314:c2e0
 with SMTP id 98e67ed59e1d1-313f1cae3b7mr1173552a91.20.1749842059954; Fri, 13
 Jun 2025 12:14:19 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:32 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-6-sagis@google.com>
Subject: [PATCH v7 05/30] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
similar to SEV.

Set shared bit position based on guest maximum physical address width
instead of maximum physical address width, because that is what KVM
uses, refer to setup_tdparams_eptp_controls(), and because maximum physical
address width can be different.

In the case of SRF, guest maximum physical address width is 48 because SRF
does not support 5-level EPT, even though the maximum physical address
width is 52.

Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d082d429e127..d9f4ecd6ffbc 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
+	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR)
+
 	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
+	} else if (vm->type == KVM_X86_TDX_VM) {
+		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
+			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
+		vm->arch.sev_fd = -1;
+		vm->arch.s_bit = 1ULL << (gpa_bits - 1);
+		vm->arch.c_bit = 0;
+		vm->gpa_tag_mask = vm->arch.s_bit;
 	} else {
 		vm->arch.sev_fd = -1;
 	}
-- 
2.50.0.rc2.692.g299adb8693-goog


