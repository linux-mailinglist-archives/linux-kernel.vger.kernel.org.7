Return-Path: <linux-kernel+bounces-823841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD53B878D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EBD1CC1498
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF7257459;
	Fri, 19 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPCkW+R5"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC01EDA0E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243604; cv=none; b=lmuah0m03yx1CMB1Haeof/MafA45YjwFqqgFyDyZZ0UQNpJ/gahkfgf++APshSX9F0ABQcb9ySNb6nLxNi+DiDiIYFEa0xqgxD0cDi1VcAz57+yyjjW1CkiPuit+WNB/I21bArcU1EsdINCrcuGPsCGvCYu9EcOOffrrf0Eprl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243604; c=relaxed/simple;
	bh=YmO5ZhLn3vGz8lgRuFa6XK7iRPoUAovIdCgjt6bcB3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PR+MwWcD7yWoZRRDxTv/uC3TiSKxaidrN24YyhKx425YsR1CT8LPL3mAZuLOVK74XdKfD0qsxMlqIrkpwDdhzTM8ubgPRBQ7hFVJq+m+ECIz2sQqOUJFPEnaVT6mjBgAOW9um5I3rRS/Q/aMVpfaFfYX00A5J7FUYDOa1wSoURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPCkW+R5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445805d386so17720345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758243602; x=1758848402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lH98c26oi0iG7hKKc9Hul2ePNiDjTOk5eR1Ays5VvX8=;
        b=aPCkW+R5esZpJH+em8tEcdjH1VdXpzHoc2g9Bhn9Z3jrCP8L80e5BqFb/ZrTsi8jB2
         bSDxCTpfU0XzTjvIXggX83SostRHoktEwdLdhXJK52LjyVMBojilv2xkPmuRbc/7L7NO
         E1yWJ7gPq161V9rmiLfCYghdtOasTK3noYcI5bBLog9gI2fjalu9Y60UWhNAmOZI3gRu
         xmMgR9mkCzFg4MbVwHFwTwzvvN18h4F9DMPSVLum65Y5QIxHAodMrMhx1Cs752RaS6bJ
         oUsZFE0cmSs55zAtAvCmC4DNg5v6/Ntwn5JjgAUlqUMdEQ42KeHBRAVk6dmCp9SjElSj
         BuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243602; x=1758848402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH98c26oi0iG7hKKc9Hul2ePNiDjTOk5eR1Ays5VvX8=;
        b=PTD+R+xi/TFgiTeoWzoU6FY5P2pmhxHobbJDJxzSrqG6iBW+/FsOWPndHNbeVuPo3Q
         1guSSiivu5++q4PYmJ2mnWk9dxtkTR+bw/tLHYFrwOH0JHUUPL8UsGSbPS2UQQ+P30Ij
         llvmCwvCk/cJvOD/Vq5zbCLU7L88HV5R27JtqlaWzewBKHdc3m63mhs+xVj1Gf55Ujru
         hYaCl2XdNK5J26pMkAyG5mAEF1n1QmihDnaXu2y6qLolwx5lh8kxpWYCltW2yFWbeYmU
         9N3X8nP05bwttG5zcEjUDG1hrffRaDwJZQ+wBWd1MJLuiC1uH91cViQbhi+IajD+X4D6
         FnaA==
X-Forwarded-Encrypted: i=1; AJvYcCWFepOaWztbNXuiwWhSssk3fIyM7Xgm1GUu6kKPzcdoJlntUyI/q5uMU+ldmoQjNQ4MlKbf/+Csz07a9hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DQSlEeMTNCu2WmX2hc4z4wn/GZd9VI55YRV2GzAXbhCmWWtR
	D9GfbqxWAgoBEVgzP3OnkpMJs+9dvfwPsixTnk52v2lHhClOFX94p/l5BIuIYzndUImpm6jY63N
	5E2qP1Q==
X-Google-Smtp-Source: AGHT+IEVhfZo+VuCff+zD2U0D2h648aLSOlkoBvlJxDLxKHMbodux6YoSgiIo14EdAHAY8tP2J5+PU7+TcY=
X-Received: from pjac15.prod.google.com ([2002:a17:90a:108f:b0:32e:e4e6:ecfe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b07:b0:264:f3ed:ee2d
 with SMTP id d9443c01a7336-269ba48383cmr16975795ad.27.1758243602373; Thu, 18
 Sep 2025 18:00:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:59:49 -0700
In-Reply-To: <20250919005955.1366256-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919005955.1366256-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919005955.1366256-4-seanjc@google.com>
Subject: [PATCH 3/9] KVM: x86/mmu: Move "dummy root" helpers to spte.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the helpers to get/query a dummy root from mmu_internal.h to spte.h
so that VMX can detect and handle dummy roots when constructing EPTPs.
This will allow using the root's role to build the EPTP instead of pulling
equivalent information out of the vCPU structure.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu_internal.h | 10 ----------
 arch/x86/kvm/mmu/spte.h         | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ed5c01df21ba..73cdcbccc89e 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -39,16 +39,6 @@
 #define INVALID_PAE_ROOT	0
 #define IS_VALID_PAE_ROOT(x)	(!!(x))
 
-static inline hpa_t kvm_mmu_get_dummy_root(void)
-{
-	return my_zero_pfn(0) << PAGE_SHIFT;
-}
-
-static inline bool kvm_mmu_is_dummy_root(hpa_t shadow_page)
-{
-	return is_zero_pfn(shadow_page >> PAGE_SHIFT);
-}
-
 typedef u64 __rcu *tdp_ptep_t;
 
 struct kvm_mmu_page {
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 3133f066927e..91ce29fd6f1b 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -246,6 +246,16 @@ static inline int spte_index(u64 *sptep)
  */
 extern u64 __read_mostly shadow_nonpresent_or_rsvd_lower_gfn_mask;
 
+static inline hpa_t kvm_mmu_get_dummy_root(void)
+{
+	return my_zero_pfn(0) << PAGE_SHIFT;
+}
+
+static inline bool kvm_mmu_is_dummy_root(hpa_t shadow_page)
+{
+	return is_zero_pfn(shadow_page >> PAGE_SHIFT);
+}
+
 static inline struct kvm_mmu_page *to_shadow_page(hpa_t shadow_page)
 {
 	struct page *page = pfn_to_page((shadow_page) >> PAGE_SHIFT);
-- 
2.51.0.470.ga7dc726c21-goog


