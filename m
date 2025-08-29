Return-Path: <linux-kernel+bounces-790888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E686B3AEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2CD5830EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A2235358;
	Fri, 29 Aug 2025 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osvxEVSf"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FA223311
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426004; cv=none; b=rj0cbdED42PvrNT+zeMpPgDlEADTNosea8vly7iTQ0qdqvX5VxfZ0LvcW78vtu3qrLdrIO6/QbTGP/K2UmIqVJfEWApNP1oZCk8oazKc2gUPlAz4XmhduddvqjIaYgbAHRnCr7bcejcHi5VnESyivrwMwvYF4SW4kG1X3ixsLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426004; c=relaxed/simple;
	bh=902UVUZmCSPpi8X+dDv5xOlcB4XyEnFTmnxe/BF6V3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qo3nReOA4AICu+d0Wzhhjn9WA0Ime7aaSxXMpsCr0isGXQN33HfGPVCJytpdyM8pf2xXQpZVDsCvscF9uTImvqMyOK6qmYwfNqrNctuXS/WzwQjXl29h9wjGzd4oRirHy7ec6Sau2C3kFyXGSf51JRXL1ZOq0Sc+ERExQriEL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osvxEVSf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e60221fso2378488b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756426002; x=1757030802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I8qRi06qGVaXga/Xlpn8ZvFudxvmpq5UoDX0cKOu9ig=;
        b=osvxEVSf/PKfE62dS8D7rWg+JomvMX7Tm8vM17OIhVXLOCegJ3FO0HxNK1kqgyBtoP
         JwN10rBUrHhWs1jtXMkzpLMwE/3xCrytbv5JGcNhggUOGkONzmvCbJScMIudkBq3QNfG
         gwozla2eWgr18PmeZfCxGG/yTlcZ44l6EHD4qPvhKVIGcaD7Ln1kOZUXkAt0FWtoI30Y
         Gx334suTFe9lcHSscY+06VjYKnvwqemXpvhBSI8Fm+UGnNQfHyGFaffEZdSn8pNfXuq6
         SQW30xbvud0OjH25urGpS6b+Dsz+MJ1+W5KKaBZ/w5dWoyu7Xbh9NIcvHkFqgPdlcymL
         Lfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426002; x=1757030802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8qRi06qGVaXga/Xlpn8ZvFudxvmpq5UoDX0cKOu9ig=;
        b=r4L9dETnT4wKfaMCjviH3InQl2FaSK0DtTm4ItlAPmYRe9IQ951IoZEe75wxTVZ4MV
         YmlKgjNooooCET+T7+jK+CvFGJm2IRFiSmbRYWrWR7EJaA6G6+Y++exQ2V4weqTKeHsV
         0ayHK1hsGtCDZCx7ycyFrlviP3K+aHTdAFIgkMtRMzeRpcG39RKrbOOqtiTlxUdSAGhY
         JgO7eCeyTMm70dyoKY5+EVsa3T9vT83+0U5ydRH7d5x4JVqNXZ4H3eRxrNj0pTwCbWlo
         ainfQ3bGWb8BLA73nUj+giXYTmW9bPgJAZkKXjdYXzYXJHrA1KsephfmwJuJGFJZ+mVx
         O2nA==
X-Forwarded-Encrypted: i=1; AJvYcCVgluziJ2N+BnNEvprvGIYXUMTAg2C/xqjpV722mfeKsb7zOlL2e6ZVwJxBqyvUywg/xLn5SkYPm8Dx0Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPHpOMVrWJ6YFEyqBtUGVLcaG6/TyFpsa/eJayQMm2RTpzyQJ
	Q6SYzUpoSPH+s07RktaCXBjvRNNj62j/H43cRj6OcDo2Cv6RJfSq28YXnV6uo5jckS2Q69EAnQU
	2fm3Gcw==
X-Google-Smtp-Source: AGHT+IFg+0Lyt/ONHma24rkTg8rYgWVOQSWd8hCU5VIhmhLogULJMsRMy1cHwlhM00wbNXuZW4pEW5RvOgc=
X-Received: from pfbhg14.prod.google.com ([2002:a05:6a00:860e:b0:771:e396:a7fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a94:b0:771:e8be:8390
 with SMTP id d2e1a72fcca58-771e8be87b2mr21526977b3a.14.1756426002390; Thu, 28
 Aug 2025 17:06:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:12 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-13-seanjc@google.com>
Subject: [RFC PATCH v2 12/18] KVM: TDX: Bug the VM if extended the initial
 measurement fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN and terminate the VM if TDH_MR_EXTEND fails, as extending the
measurement should fail if and only if there is a KVM bug, or if the S-EPT
mapping is invalid, and it should be impossibe for the S-EPT mappings to
be removed between kvm_tdp_mmu_map_private_pfn() and tdh_mr_extend().

Holding slots_lock prevents zaps due to memslot updates,
filemap_invalidate_lock() prevents zaps due to guest_memfd PUNCH_HOLE,
and all usage of kvm_zap_gfn_range() is mutually exclusive with S-EPT
entries that can be used for the initial image.  The call from sev.c is
obviously mutually exclusive, TDX disallows KVM_X86_QUIRK_IGNORE_GUEST_PAT
so same goes for kvm_noncoherent_dma_assignment_start_or_stop, and while
__kvm_set_or_clear_apicv_inhibit() can likely be tripped while building the
image, the APIC page has its own non-guest_memfd memslot and so can't be
used for the initial image, which means that too is mutually exclusive.

Opportunistically switch to "goto" to jump around the measurement code,
partly to make it clear that KVM needs to bail entirely if extending the
measurement fails, partly in anticipation of reworking how and when
TDH_MEM_PAGE_ADD is done.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 06dd2861eba7..bc92e87a1dbb 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3145,14 +3145,22 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 	KVM_BUG_ON(atomic64_dec_return(&kvm_tdx->nr_premapped) < 0, kvm);
 
-	if (arg->flags & KVM_TDX_MEASURE_MEMORY_REGION) {
-		for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
-			err = tdh_mr_extend(&kvm_tdx->td, gpa + i, &entry,
-					    &level_state);
-			if (err) {
-				ret = -EIO;
-				break;
-			}
+	if (!(arg->flags & KVM_TDX_MEASURE_MEMORY_REGION))
+		goto out;
+
+	/*
+	 * Note, MR.EXTEND can fail if the S-EPT mapping is somehow removed
+	 * between mapping the pfn and now, but slots_lock prevents memslot
+	 * updates, filemap_invalidate_lock() prevents guest_memfd updates,
+	 * mmu_notifier events can't reach S-EPT entries, and KVM's internal
+	 * zapping flows are mutually exclusive with S-EPT mappings.
+	 */
+	for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
+		err = tdh_mr_extend(&kvm_tdx->td, gpa + i, &entry, &level_state);
+		if (KVM_BUG_ON(err, kvm)) {
+			pr_tdx_error_2(TDH_MR_EXTEND, err, entry, level_state);
+			ret = -EIO;
+			goto out;
 		}
 	}
 
-- 
2.51.0.318.gd7df087d1a-goog


