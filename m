Return-Path: <linux-kernel+bounces-787404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFBFB375CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978FB1B675E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8AEACE;
	Wed, 27 Aug 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGCWWbUP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0B186A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253126; cv=none; b=dXE1wkLjBtMI9ESjPkoNYTqxXKJiQE06JvzddO5E4FU26xh07yMqtBEY5DbWxyBWoJ1Z6kV+TN9mpNMgIQ3LYHBHVhxvQpK34ixULutQ2DhIQOnjjVbECpWlNSQ74NI10LH83ttQue2BjJ8puRZSUYR72a1QV6FQRY5z/U8OzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253126; c=relaxed/simple;
	bh=LUjrmV9vYD0d7Y3rNbO+CnOuXhd9CQmqt/2LRdyxFp0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q8j82qORm429AkVSLSkDZKyQpDP04g6FtwJ4Md5nnFAqzjizba1wR9ebl8Av03PhriogMmflXl9m6jh/RdSRPQPdrA0CAmWKGZ8NIXEmpXMnHiBo3nShemxQuiD2b1RWJp9SjDPOViirudHe0BYZuv79ENpCmAKFNyTSaYdhe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGCWWbUP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b49da0156bdso4754297a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253124; x=1756857924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAYQ9sHs09UDF7cW5USTEYfEkZ4TWUXmBvuJzFsHR7g=;
        b=bGCWWbUPz7tR8OEL1tL56RoaZhlBEu1xYiF/ct1v9RlioMJPUQ1JyLLBvtO0uMvlna
         9l1uXvrK0sxRkkGxmluY4WvsnAmbN+hT1e3WzWEoBiOJ8zSuxcCYslozGvCnEiujomxS
         qjBbvL1pyZLC3DkOyN+/AZt/TOj/nkr42/eR4zoKBcRH84YZZqiO4+TMnlefi3W42RgM
         T/wihHfZX8hwxOrnXQS/fhHJxsw4Yc65Yrk1BHDUWRidY6VwBokcVgfdImjwClh3De5f
         7FBU61jWoK23S3wtgV8/JqeT36KN9/qWgg8cI9kWeRrawL11ExUMR4SJSlXLdpI4+rOz
         n2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253124; x=1756857924;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAYQ9sHs09UDF7cW5USTEYfEkZ4TWUXmBvuJzFsHR7g=;
        b=pVCurXatqWTkRP2ZbjS59TkaxMHu6sWSg6wRIs9gB2DSaZEJjVG/ozN0vZbQNb3fWr
         RRPLO1n0EAW2zzduMZazRZ8tU80jGMF6SDPjDqbEDHIOQw0MH1P5NvusRtOc+5iynba1
         2CnD1LzRPXy8se/ywS/UKlVpTEcL/Sd0urPffyGBZBtxNA/DOIbyP6Hp1bnhfaFFcVOi
         KFOdvQcdwajj0qjo5R7u9wzE8NuTOlFswAkrGBHvW2wucZHRHGJDzTgrlT9AyYyOCR/+
         Bp8sj9hJeLY2534ajdgCP597g3hkVzKvp1otLAxjYYgLIweE2XiM6AEl/gKS2g5UJpao
         bviA==
X-Forwarded-Encrypted: i=1; AJvYcCXWEbAzBlGGLIOoR48wA3UGcsSAYu6nX870MLQZ6np1UacX/R6RafAee+xoLTRksPx8j2kRll5yNOGm45Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/gK+hZnTnMLakeMHogPfvXjsNF/dBe+OQZfb4lms2S2Bxeqo
	tQdF5nWnFHTsZL3cgeF608Bjv+BzpVkSYFtItFhmTSkk8hzPRxq7frcx5kZmaPpmb+oc8CAfs0Y
	2PAfJ3A==
X-Google-Smtp-Source: AGHT+IHKQp4PwjlFYw8IbTPHyvClCOZw3IRzGWvQ2el3OizC3xRx3IpRFT9ogu4Za5Lx/cDpzEDVM4/rKA0=
X-Received: from pgh13.prod.google.com ([2002:a05:6a02:4e0d:b0:b4c:46df:36a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f97:b0:243:15b9:765b
 with SMTP id adf61e73a8af0-24340d6dc1cmr22725815637.53.1756253124220; Tue, 26
 Aug 2025 17:05:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 Aug 2025 17:05:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827000522.4022426-1-seanjc@google.com>
Subject: [RFC PATCH 00/12] KVM: x86/mmu: TDX post-populate cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

This is a largely untested series to do most of what was discussed in the
thread regarding locking issues between gmem and TDX's post-populate hook[*],
with more than a few side quests thrown in as I was navigating through the
code to try to figure out how best to eliminate the copy_from_user() from
sev_gmem_post_populate(), which has the same locking problem (copying from
a userspace address can fault and in theory trigger the same problematic
path, I think).

Notably absent is the extraction of copy_from_user() from
sev_gmem_post_populate() to kvm_gmem_populate().  I've had this on my todo
list for a few weeks now, and haven't been able to focus on it for long
enough to get something hammered out, and with KVM Forum on the horizon, I
don't anticipate getting 'round to it within the next month (if not much
longer).

The thing that stymied me is what to do if snp_launch_update() is passed in
a huge batch of pages.  I waffled between doing a slow one-at-a-time approach
and a batched approached, and got especially stuck when trying to remember
and/or figure out how that handling would interact with hugepage support in
SNP in particular.

If anyone wants to tackle that project, the one thing change I definitely
think we should do is change the post_populate() callback to operate on
exactly one page.  KVM_SEV_SNP_LAUNCH_UPDATE allows for partial progress,
i.e. KVM's ABI doesn't require it to unwind a batch if adding a page fails.
If we take advantage of that, then sev_gmem_post_populate() will be a bit
simpler (though I wouldn't go so far as to call it "simple").

RFC as this is compile tested only (mostly due to lack of access to a TDX
capable system, but also due to lack of cycles).

[*] http://lore.kernel.org/all/aG_pLUlHdYIZ2luh@google.com

Sean Christopherson (12):
  KVM: TDX: Drop PROVE_MMU=y sanity check on to-be-populated mappings
  KVM: x86/mmu: Add dedicated API to map guest_memfd pfn into TDP MMU
  Revert "KVM: x86/tdp_mmu: Add a helper function to walk down the TDP
    MMU"
  KVM: x86/mmu: Rename kvm_tdp_map_page() to kvm_tdp_prefault_page()
  KVM: TDX: Drop superfluous page pinning in S-EPT management
  KVM: TDX: Return -EIO, not -EINVAL, on a KVM_BUG_ON() condition
  KVM: TDX: Avoid a double-KVM_BUG_ON() in tdx_sept_zap_private_spte()
  KVM: TDX: Use atomic64_dec_return() instead of a poor equivalent
  KVM: TDX: Fold tdx_mem_page_record_premap_cnt() into its sole caller
  KVM: TDX: Assert that slots_lock is held when nr_premapped is accessed
  KVM: TDX: Track nr_premapped as an "unsigned long", not an
    "atomic64_t"
  KVM: TDX: Rename nr_premapped to nr_pending_tdh_mem_page_adds

 arch/x86/kvm/mmu.h         |   3 +-
 arch/x86/kvm/mmu/mmu.c     |  66 ++++++++++++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c |  37 ++---------
 arch/x86/kvm/vmx/tdx.c     | 123 +++++++++++++------------------------
 arch/x86/kvm/vmx/tdx.h     |   9 ++-
 5 files changed, 117 insertions(+), 121 deletions(-)


base-commit: 196d9e72c4b0bd68b74a4ec7f52d248f37d0f030
-- 
2.51.0.268.g9569e192d0-goog


