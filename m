Return-Path: <linux-kernel+bounces-759467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725BB1DDDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76992A00A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9721ADAE;
	Thu,  7 Aug 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODLv0IeJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E12741D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597807; cv=none; b=ulgU0SzlO/PFQ+3bZ3uw80s3Va5p3+HHAbMM0AJLGUzsJD1UakIB1ljfgnEhZrkNHA05DVMkbp2MuKrKuz9Y3IpgiMjC9uzuvCgwo36fg5zYMgqCAReaNld0giXZTIV2mByrPoAf2F3bwUtnDBj7ir/a1lDhVQRfs2K+UX/yBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597807; c=relaxed/simple;
	bh=PjccjVZAkRo3Xaj2t4Gs6E0VQOqy8N8IPb4hRIjeToc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UG/FrFvhPBOb87k/Mbm07D/67XBv6IEbSEJ3RjlYomT54EhKIOL026v7fWez1frRyAiPkePnOG8Wjy8aXwETdnZoABb4yfTt0UYkDgOKAsaGywXTpENdTOGYqtROkZNtJpWXBeeUxEqAQUODHclFB5ZRbvKXtb0rZwBXfbpt9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODLv0IeJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso1755909a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597805; x=1755202605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CCwqPAnoUPSp9AFnzO+u9qSxg+vLNhYcEQUdXsIl0A=;
        b=ODLv0IeJlzv+ykKM2JlI8sgCvpsyEBU82LrrYCfgJtoWLd5JjXMCp8vrHtHzwMSwRQ
         pHPdEdujWdMidBsByJsMCEqIx5MJq60mv3Wwxf1ri2+oqmPYC7kZpWBicRANEvLx0E60
         dp50QgElcCAB1Z8ub2INLLhBPuxR/EIlwwJ6JXREti9DUYDuSjdShmo9NJLfrohwZ3DC
         br1f78L1n7L3Jlq8wAZykqZOiijZnO5Y+iOUi9w/9wRJ/jZWvYYsCNNL2+UfGhf73Bzv
         xduGF+s9BO7GG7ZQkJCHo91zpGJPIJ7QKT476GhAxy0LsW7XntBGlUQM8RtaKpmkCYSU
         uwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597805; x=1755202605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CCwqPAnoUPSp9AFnzO+u9qSxg+vLNhYcEQUdXsIl0A=;
        b=EDXglbt38mZR47yjmrmFiMK5dRWNjcG7wN+onEiA5hR1Zew/Rx7mSMh3edn3C4nX2i
         /Vhw67b5YQYjhQEo/0z/TKqLW3SxlC3lrIPdYy9bAScboiATcM3MDqhD3CYpa+1vCIIY
         c5uWrQWkQPSAvfzFrdvNWf7xV3lNg/nC5ZCqfweCvB0AVV0LxjHgGCGciocmP0Hd5lTp
         LPfkOXymp4xE9CbZMo0eepYgwR2yiE3N2p5JZyNS0YMt5Uw49k+NtMA3ldMJOdKcra+C
         Agenj4ct2CBy/wnkufUCuNW/39ETmeD2y04iT7db6R6Opdxi7ANTKpoV/Elr2XSEYGWu
         rEdQ==
X-Gm-Message-State: AOJu0YwvtjjSdpXabgL8nJ5WBrIMGFT0h9TxXcRSgGCsCbgvVxArJH/R
	tSfi6dnK9OPKYzHl3faiTMmbzgYy4QOtArQAJNKAT5TrUqpy9Byth/1uJICr0mGqkDmZwBpbha8
	00g==
X-Google-Smtp-Source: AGHT+IFrTj53N5DZXacA6l1rqtKAvbn+AVo773jcURpzGEwI4lTM8ssPebkro7Dg+daTfE66YB9jLp4D9w==
X-Received: from pjpo16.prod.google.com ([2002:a17:90a:9f90:b0:311:ff32:a85d])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc3:b0:31f:1757:f9f8
 with SMTP id 98e67ed59e1d1-32183b3f0d7mr395879a91.22.1754597804855; Thu, 07
 Aug 2025 13:16:44 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:01 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-6-sagis@google.com>
Subject: [PATCH v8 05/30] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
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
index d082d429e127..5718b5911b0a 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
+	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
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
2.51.0.rc0.155.g4a0f42376b-goog


