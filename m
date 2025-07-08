Return-Path: <linux-kernel+bounces-720623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CE6AFBE5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3060518878F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025592E7F3E;
	Mon,  7 Jul 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qfKmOiM"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75328C2DC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928514; cv=none; b=agM6YDj70teSPoPQNumHr8djSp/1OU/OGgBVUy9c3F6ldO4FnP7Gr12cNVUBa2L5Qtr3kJ9sQd5dJEWsBnQlWirAOM7LQYv959u8/MUyqT7zuM92EplATplmWWiSitrqewia6SFrZzaVdOoDK/yChVS+BqGI5yqktwWcOLH8cqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928514; c=relaxed/simple;
	bh=pfTbcdZSSLLL5oaShJwPnizP77bbCKnSgy4AHooKMXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GnuLCkY+7sNNhBi3a5DftSOB7WQFmhleSMGrjBpta9dR8uuGkSvIqQMpOuxwCyUvaxXEBCz9CgXUarK/GMI0hEEOxTVXAd9PBItxBVcAjr4tMOCr/NWaFuOPNl2vNgN8pH4LI7PloY9waE8Q75mEbBsx2vPEGH1J9APQSYbgviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qfKmOiM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2237606a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751928512; x=1752533312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XRp6vH5YCO0vNmv7C5suxuZF5x6t8xgiOL3MRTM9E0=;
        b=3qfKmOiMkBVsRMaycUR9uyhbT0BNP1dXEbPwwRtCCvkfAF5T/r1PqvXdO4FX15CS1S
         xKJ/8njqztT9nqAlmW6AUoxKFRFSyxL6vqBRFoLxqSCPDmeRYbRSmhKue8b+85RFuNNA
         HswpxEOMA6WpVc2vuDEvHQjjDR0xJNESMjEVKuFeCx/FCH5mCGEO0OxD3LQ519AZfueG
         UqgIavf4DCuU5iSsufa6T/Z6LC8/LJsPJnCTK5e6h7kZwTgpF3pCMoTMm2B0hrr//Ztz
         e7nhpmZsNskWfdsHDYmt5bgano1DkKRI8PHN/jnlKI40PSaz0bRjKw6P4dlQk0xgu1pd
         T7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751928512; x=1752533312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XRp6vH5YCO0vNmv7C5suxuZF5x6t8xgiOL3MRTM9E0=;
        b=mQVGKF23Fyo1267QINGU96onGx1q7V6TPZumuJhTPtlhor9seoikmeDzjbI6goiM2K
         32cZqWZFv/xGWNy2HDgGWYYWkBPLrX3AMHN6voY2E7eLAoHbetYaxm9HFSFK2tKTuRfX
         7CnjbWLUtbwUPB2bRJVFHRoS8XOHAZmJa/DosbY+qrZBkTfaM9dtgZv3R/y05AIHOAB5
         N/KdQd9VYA0b5MbVUlv3Ye/UZpdyinZsxRjAgnoomjXla1ZJlLEPhNK9RNf26Rx4kVCA
         oDSADsXFV7m3zKk0m52EieLNHHCTONb3RuPp4ThJ6AhUZOwLaOmzrZAVluU7MKXBXFCS
         VkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3QdUkU6XJLBSqDbIHxUI/65Ck8DOai5fS85+zRICExJvZYPuZ/QLqc9OGDVZg2EpFMDZ9NFypcbjRFrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FS97ey1Zjsa/zh0FNZDouErpgsMs0NMOL0gT1Urvt8Qgs+Av
	c1dcSswr5EwFw9P+PQHuxiQW4vz21NSbSLt0hB/4zcsO+ETpe+i60eeZ3Gp27zSDQNXj9H/h2AS
	dQu9TMq6/t5VDIkoNycr0Dw==
X-Google-Smtp-Source: AGHT+IEQGLj1y5VPablO5Se2AW+glk11ncXO8Xt55xsvLAKmnnmI6ZkgDZYUUigN/e/HEzDXWEdb3qi16gZ1EFuY
X-Received: from pjbqa14.prod.google.com ([2002:a17:90b:4fce:b0:312:14e5:174b])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:548b:b0:313:14b5:2538 with SMTP id 98e67ed59e1d1-31aaddfb84bmr21087259a91.35.1751928512116;
 Mon, 07 Jul 2025 15:48:32 -0700 (PDT)
Date: Mon,  7 Jul 2025 22:47:17 +0000
In-Reply-To: <20250707224720.4016504-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707224720.4016504-5-jthoughton@google.com>
Subject: [PATCH v5 4/7] KVM: x86/mmu: Only grab RCU lock for nx hugepage
 recovery for TDP MMU
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that we have separate paths for the TDP MMU, it is trivial to only
grab rcu_read_lock() for the TDP MMU case. We do not need to grab it
for the shadow MMU, as pages are not RCU-freed in that case.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7df1b4ead705b..c8f7dd747d524 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7577,17 +7577,18 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 	nx_huge_pages = &kvm->arch.possible_nx_huge_pages[mmu_type].pages;
 
 	rcu_idx = srcu_read_lock(&kvm->srcu);
-	if (is_tdp_mmu)
+	if (is_tdp_mmu) {
 		read_lock(&kvm->mmu_lock);
-	else
+		/*
+		 * Zapping TDP MMU shadow pages, including the remote TLB flush,
+		 * must be done under RCU protection, because the pages are
+		 * freed via RCU callback.
+		 */
+		rcu_read_lock();
+	} else {
 		write_lock(&kvm->mmu_lock);
+	}
 
-	/*
-	 * Zapping TDP MMU shadow pages, including the remote TLB flush, must
-	 * be done under RCU protection, because the pages are freed via RCU
-	 * callback.
-	 */
-	rcu_read_lock();
 
 	for ( ; to_zap; --to_zap) {
 #ifdef CONFIG_X86_64
@@ -7641,25 +7642,27 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 
 		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
 			kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
-			rcu_read_unlock();
 
-			if (is_tdp_mmu)
+			if (is_tdp_mmu) {
+				rcu_read_unlock();
 				cond_resched_rwlock_read(&kvm->mmu_lock);
-			else
+				rcu_read_lock();
+			} else {
 				cond_resched_rwlock_write(&kvm->mmu_lock);
+			}
 
 			flush = false;
-			rcu_read_lock();
 		}
 	}
 	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 
-	rcu_read_unlock();
 
-	if (is_tdp_mmu)
+	if (is_tdp_mmu) {
+		rcu_read_unlock();
 		read_unlock(&kvm->mmu_lock);
-	else
+	} else {
 		write_unlock(&kvm->mmu_lock);
+	}
 	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


