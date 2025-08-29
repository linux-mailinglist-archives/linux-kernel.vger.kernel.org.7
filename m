Return-Path: <linux-kernel+bounces-790876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49EB3AEC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D64175225
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A712FCA52;
	Fri, 29 Aug 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCjheMlr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640A10F1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425984; cv=none; b=MoTpNCzFKi8cEOIWdjMVkuhDQ72te19BpfnLBubZYql6iNbmB9KhBWYsTk7a4XKxcU8FTtrA2hk5xvvROnIA0RCtqDT9Z/Doavu7zqXwPBswIE6uiLWYU9lYvHvWfhokMmLcm2mK6Kpc9en/oOUc5zWH7KAear4g64Sh0aTifiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425984; c=relaxed/simple;
	bh=uDNBH2xhnZoqUDBPucOt7ZoGpYPMRPVyVM+gqwnXrhk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WYs/HG4n3j0L62OcMDo+iliTPnO5r/k8Pb+nxo9A36RZVhAYljAjYfDHv0QXfheFViwt8rfFDasSFcRRiUo3+x5RUAitfEZlSnpRsNBqKx7BEpVrUvwQTdCFYW6dI1fkn5Fp+4TQ9gNDNLGKIxLIGQEp3/PJUDcbOudOu6f7YOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCjheMlr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32769224506so1463218a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756425982; x=1757030782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3jX1KFz6KSmVJMt2O//pKvhD8N+NUcgwkAqGh7CBXE=;
        b=DCjheMlrFboXp2pAb2ickjx19qXJmheFq7FmEtMEHaKVdnjh4BSaviGGqV4agNUFsn
         YE+VlQ4sqokuSno9g85yqWl98jltTX6pvMhHIjxPEVT+JtSvf8Hji38JNafiSxu5feMy
         GbDPxosyiAtU+gfD9qARTc45VAgJMw52+qRv08sJkJkmu9y5sYIN8H6hN5Pai3X53yqO
         f5qCfdkrb15qcF/c6Yskrp/Qt/5FvvViIF2XHG8hxzAdMfrBnk9aWNvaaj1u4kXWEIQu
         uKXxspJk59OGZYxsVseTnO+uHC7w8rVldgQN0NJ3LTGbWyQzdLBVNVBBiaktsJemRu70
         s2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756425982; x=1757030782;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3jX1KFz6KSmVJMt2O//pKvhD8N+NUcgwkAqGh7CBXE=;
        b=gKRfKMhpo42+VidtBLTwam7qhqgVrgAGbFMGdlKgdvJGMY4HARxwE3n/DL6daCw5+S
         yTTCuq24aFBi6cOjjW0i9zYyiG4liP81DxQDDEA3c809swXeX6v5UxBKyow1ZHzhAJyY
         aQnqNJgxbACnPAcypyXmwCeqPn1VM4y1VBCOZRSQwQd3Fk3cnG8M2neD0Yk+np8A3i0P
         FEENwnfjbeTO6qrltl6iIv5s8/+uoH88a2kUsl72xfCMstEwm/787l+tWIsgJbPHhuBu
         diOk7nFPmXv01msRPCkIbTctXuS/9DA3XzA7VqyKr9WHFqRsUE+spbbB0UciJ2Y0HQg4
         XjbA==
X-Forwarded-Encrypted: i=1; AJvYcCUk8ZFBI49t6dl0asQtHsd68sRymWSKOEQriEKE4LHDuhHQrFdw0wcI+NitcFVwezM6xYL9SGBTiQWS7qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf61GNFPJjfEf67cH4/O5oJgC+o0VAS2FW7ooqtI+ZgIppy4Ff
	0L6uesDh3JeMtET55SadeZLzI6ubbL9oCxFL1LY+eF7Sfo9eo2J1aPu3omqpBPAQa6vUOxvfLrl
	NClEkEA==
X-Google-Smtp-Source: AGHT+IG0Eg+KqHeR0ZACYtXSX+W0A04Kwpg24nLlSvOhLEkRdmaEJ1s9l+7+N0QKpi52POGN7ckIUwVOxn0=
X-Received: from pjyp11.prod.google.com ([2002:a17:90a:e70b:b0:31e:3c57:ffc8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5443:b0:311:f99e:7f57
 with SMTP id 98e67ed59e1d1-3251774b90fmr33170734a91.23.1756425981839; Thu, 28
 Aug 2025 17:06:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-1-seanjc@google.com>
Subject: [RFC PATCH v2 00/18] KVM: x86/mmu: TDX post-populate cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

New (still largely untested) version of the TDX post-populate cleanup series
to address locking issues between gmem and TDX's post-populate hook[*], with
a pile of related cleanups throw in to (hopefully) simplify future development,
e.g. for hugepage and in-place conversion.

RFC as this is compile tested only again, and there are substantial differences
relative to v1.

P.S. I wasn't intending this to be 6.18 material (at all), but with the change
     in how TDH_MEM_PAGE_ADD is handled, I'm tempted to make a push to get this
     in sooner than later so that in-flight development can benefit.  Thoughts?

[*] http://lore.kernel.org/all/aG_pLUlHdYIZ2luh@google.com

v2:
 - Collect a few reviews (and ignore some because the patches went away).
   [Rick, Kai, Ira]
 - Move TDH_MEM_PAGE_ADD under mmu_lock and drop nr_premapped. [Yan, Rick]
 - Force max_level = PG_LEVEL_4K straightaway. [Yan]
 - s/kvm_tdp_prefault_page/kvm_tdp_page_prefault. [Rick]
 - Use Yan's version of "Say no to pinning!".  [Yan, Rick]
 - Tidy up helpers and macros to reduce boilerplate and copy+pate code, and
   to eliminate redundant/dead code (e.g. KVM_BUG_ON() the same error
   multiple times).
 - KVM_BUG_ON() if TDH_MR_EXTEND fails (I convinced myself it can't).

v1: https://lore.kernel.org/all/20250827000522.4022426-1-seanjc@google.com

Sean Christopherson (17):
  KVM: TDX: Drop PROVE_MMU=y sanity check on to-be-populated mappings
  KVM: x86/mmu: Add dedicated API to map guest_memfd pfn into TDP MMU
  Revert "KVM: x86/tdp_mmu: Add a helper function to walk down the TDP
    MMU"
  KVM: x86/mmu: Rename kvm_tdp_map_page() to kvm_tdp_page_prefault()
  KVM: TDX: Return -EIO, not -EINVAL, on a KVM_BUG_ON() condition
  KVM: TDX: Fold tdx_sept_drop_private_spte() into
    tdx_sept_remove_private_spte()
  KVM: x86/mmu: Drop the return code from
    kvm_x86_ops.remove_external_spte()
  KVM: TDX: Avoid a double-KVM_BUG_ON() in tdx_sept_zap_private_spte()
  KVM: TDX: Use atomic64_dec_return() instead of a poor equivalent
  KVM: TDX: Fold tdx_mem_page_record_premap_cnt() into its sole caller
  KVM: TDX: Bug the VM if extended the initial measurement fails
  KVM: TDX: ADD pages to the TD image while populating mirror EPT
    entries
  KVM: TDX: Fold tdx_sept_zap_private_spte() into
    tdx_sept_remove_private_spte()
  KVM: TDX: Combine KVM_BUG_ON + pr_tdx_error() into TDX_BUG_ON()
  KVM: TDX: Derive error argument names from the local variable names
  KVM: TDX: Assert that mmu_lock is held for write when removing S-EPT
    entries
  KVM: TDX: Add macro to retry SEAMCALLs when forcing vCPUs out of guest

Yan Zhao (1):
  KVM: TDX: Drop superfluous page pinning in S-EPT management

 arch/x86/include/asm/kvm_host.h |   4 +-
 arch/x86/kvm/mmu.h              |   3 +-
 arch/x86/kvm/mmu/mmu.c          |  66 ++++-
 arch/x86/kvm/mmu/tdp_mmu.c      |  45 +---
 arch/x86/kvm/vmx/tdx.c          | 460 +++++++++++---------------------
 arch/x86/kvm/vmx/tdx.h          |   8 +-
 6 files changed, 234 insertions(+), 352 deletions(-)


base-commit: ecbcc2461839e848970468b44db32282e5059925
-- 
2.51.0.318.gd7df087d1a-goog


