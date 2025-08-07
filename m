Return-Path: <linux-kernel+bounces-759487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A0B1DE1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448DF58242C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04027FD52;
	Thu,  7 Aug 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEYHgR5I"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B3280339
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597837; cv=none; b=h2WwJUCzlfG3HYY3oytjYroiQXNyMd4tPj6prrsNuzDjFut7FsSs6lqChngLdjyNW+n1lx/ntShmvlHjKORTTdTYOOib4Gj3B9g8gifoxadJpgqddypoHaEkbp6xga/py1pZY3NspoxUhWqr1+3S/3glaJox+YTnKDkvnSg4YeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597837; c=relaxed/simple;
	bh=nf0EzG5NgSXKa/TrkEawzdB34B3daS0Giz+DgYxepKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lwv2U1JhiV/bWdvvx7GpyBzuJzE4EtLPVO48XTPxV3rTvSlu46U9LqSM23IA8RV1LsjjB1MNIzAoLLeklTXn/hy3F7ztYLyyqoqm4XK1GlD+MluMMOTyzpHp1O80fDuAyXE2RQ2/pP1wkVqDn22sWBNb96+Uf5Yz5lPY2Bvc0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEYHgR5I; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31eb41391f3so1433629a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597836; x=1755202636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iq172XdXxDqkESP8AaCKlxAjIACVlq1lEydY7qNJG/k=;
        b=eEYHgR5Ig2P560wuONsaZ/RZZ+sv1mUM1WNVm94Ajo5W9FVpE382KJWbsD1sEQMPM5
         7O/9SVcsEe1c4j4xpLPNHUgy0aJKjlooNNC4vcGU7Mgk64yfamNSxXjH6VJNcs4PsDg8
         uc+ztRONLyFPy9XDoQOzyxbLn1twHgBc1lVLWGVesqF6ZAJcUwGRHBhFT0FP5Fj9GcWB
         afETwl2vYRZa96rIZySdHxveUw6ARX//WJVnIIXLgI5xm0IpGDCHcsOuNbVQ/GdwLHwh
         vTp1ZjIGTrVzkkEdBZoSyRqD5BxqMdevBziqeSyyWqCV2TRSQ0yvLsfiyjR6Wj45vdI0
         m92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597836; x=1755202636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq172XdXxDqkESP8AaCKlxAjIACVlq1lEydY7qNJG/k=;
        b=c+BZj8nJ69cwKxX+RVKSyV4xF3W29twOXfIqbCXVT6UHIZ3yiAq/jUJkd7jYzXHFkg
         43b5CmTK/s3KhAccPmdPIWWvUpLtwmYoBvT4/4bWdBf6KCYvPOO2yiPwPAcyymu7fcYi
         SdmjOXTDk3Np8GFl559D+OiZW/QAL+4M3VZZ/DcuvjFIduGtK5YmamhPVjbwVtIvW/Ll
         XWVxDDPgON5DesJJPBbdH6g9uhevdzVBLKQuA2TDQpPqS/xBA2yMi03pTQ7WqF/ir8Kz
         tLzwgaCZ1QUTW8WW5wPPBV3AlbSRHj0r6dyiiqQ0He8GBGXPcmQYDzKUiEtD+7cjpJVo
         T52w==
X-Gm-Message-State: AOJu0YzrtT+8KTv9WIm0XV4yUqWwNl/iYa3v6nMDjtpNbxTcr3OfixXz
	qQYzJdMgjuiw01hdTyUQyAtdOuz/u0R5i1ifDzSbOYXhQdJwbLXGdH7TzuUfAzMZzcij16fZLR/
	KSw==
X-Google-Smtp-Source: AGHT+IF9GDKYO/YboaNdsTUnSP/4IoWgR2B49CtjJAmqyOJRj3Eemq3TkQ+JtNffql2w5H+tGl/Z0AxnOA==
X-Received: from pjvb4.prod.google.com ([2002:a17:90a:d884:b0:314:29b4:453])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc3:b0:311:fde5:c4c2
 with SMTP id 98e67ed59e1d1-321839c8a75mr496473a91.1.1754597835694; Thu, 07
 Aug 2025 13:17:15 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:21 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-26-sagis@google.com>
Subject: [PATCH v8 25/30] KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

vm_vaddr_alloc_private allow specifying both the virtual and physical
addresses for the allocation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2e444c172261..add0b91ebce0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -652,6 +652,9 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type);
+vm_vaddr_t vm_vaddr_alloc_private(struct kvm_vm *vm, size_t sz,
+				  vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+				  enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_identity_alloc(struct kvm_vm *vm, size_t sz,
 				   vm_vaddr_t vaddr_min,
 				   enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 14edb1de5434..2b442639ee2d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1503,6 +1503,13 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 	return ____vm_vaddr_alloc(vm, sz, vaddr_min, KVM_UTIL_MIN_PFN * vm->page_size, type, false);
 }
 
+vm_vaddr_t vm_vaddr_alloc_private(struct kvm_vm *vm, size_t sz,
+				  vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+				  enum kvm_mem_region_type type)
+{
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, paddr_min, type, true);
+}
+
 /*
  * Allocate memory in @vm of size @sz beginning with the desired virtual address
  * of @vaddr_min and backed by physical address equal to returned virtual
-- 
2.51.0.rc0.155.g4a0f42376b-goog


