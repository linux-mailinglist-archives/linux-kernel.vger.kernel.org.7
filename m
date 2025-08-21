Return-Path: <linux-kernel+bounces-780691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BFB30802
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50741893ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4783126D2;
	Thu, 21 Aug 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNucqRXA"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B153126AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810075; cv=none; b=lFUXMc9EiJTle1HzyPqKpz3cbPsBiepizMW0glV/IRQLUS0K/9BytxmelK/aBpalGS8CN6bsedORzGR3K3TgNq/LQ4BBajVbdEzaVMnLnbm8qvxBw9JXDAKPx5ZUXd76qUpKETuCQdewSGamKOJ7McudEQgXzMctQBSptKTHc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810075; c=relaxed/simple;
	bh=ztqVo6NA34foMRWPPxfCFK7i38/nXKR/2OW2xBZ5Cz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SHzrjVJORoiQw1UYYLsGP5QwHUICmJwQEsyewtPSN5VrlZ9BYAa/+0AN9AE0Q3XdA1AHZ8IUMxtvzvIpeH4+6t9v8tg0leT4WMcFaLQENgeySpOPJfUA1EzSkBouZbyxxRQsvwjZP3D/QHI/3RCUFFMZ5EiFiX3jrQKXa2ZJKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNucqRXA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e6a1a414so2224694a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810073; x=1756414873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=raIzGhW7lpJoGFirZ1c9kEw1ZuKCVqeLv2nD/b2/YKU=;
        b=WNucqRXA+D/NmIVcXqr1r4b1+BoTMlp5hocSDfx9f72/l5BzLshX3diuS60yz5eeij
         WDPm/EfFz+3gg2t/YU0brOd4Wp+uvVlLGs2hYaU70vErJDWxcJMA892TayE0lcCc6iMd
         1Zsji/Bc8bs6s5ZIhxf1Gu0zFg+HsABd9nTksN7Q40KOsIEifT8GM2Hyso+vumo5T9Fm
         djsuSlSIjTtwJbrShWqpBzKZ0kxBgV+HUajFIKh9I8nvAI5izVfPijDcGQgzUcC+KK6m
         k8zHFRl0MrzYe6xFi6WHlsFvQcFxsxA7ihfRGRxo7+YLCPaxteejfAbZW+URJGH+DtXw
         +SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810073; x=1756414873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raIzGhW7lpJoGFirZ1c9kEw1ZuKCVqeLv2nD/b2/YKU=;
        b=LQhgpGrPkIb1hKXCBYe217Np6zJu/P1sP6eoF8Tr+N9jp7eVt2nSpa32jaPMexlYww
         /aWo262/3Gk7cxAcb7gbKQUM6tdWCfpmjQ0u/Yv3twEP/Fim1mMk+gxTqzZUr9ZOrJ3j
         KAasH258OoQxCqPNIqntwZYTFi6JgDkhtvZFVBf/kOYZGi6XFS9WumXqpYQ8LehKsAIP
         Ov1WNcmgdL5v2iyE20NXnUyfSmgVn3TGgHJtjFwCJibcLERDxareqCLr3K8OAtYidf8D
         jHysnDfe4ODi9zzmY+Ph72A8P5jeUMeOknIimSYBq2jIEgmzkInXgMQGTBYk6aDgythS
         AgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIHRJwYfL8FNV+WJDwZsY1xtZBSJmpBfgTPRVyyoXNHEdXiLQ7UMWXWii9hEzNZQp+Bk9ZaEw36zrigfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5/IV7+oiQaU5FVjcDw5zvF5K1R7rKPFOdnxFGPbig4jt60rl
	aaIi/DYDLRImQgksoD0OzxtsTZtZJXV+/0u10HOXoeO7lXruKllZXi6+gkSUY1NOXQt1plp8WPc
	Jne5Adw==
X-Google-Smtp-Source: AGHT+IFblgzDSGtA8EPOlO44N2jRty+RipPpxQzb/XSsK78s9IItTWN33FoV1VAgZIXu+UmzYrewPt9GIfA=
X-Received: from pjgg5.prod.google.com ([2002:a17:90b:57c5:b0:321:76a2:947c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4e:b0:321:1348:4438
 with SMTP id 98e67ed59e1d1-324eed210damr5152464a91.7.1755810073194; Thu, 21
 Aug 2025 14:01:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:42 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-17-seanjc@google.com>
Subject: [RFC PATCH 16/16] KVM: arm64: Don't bother nullifying "vma" in mem
 abort path
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that the local "vma" in kvm_gather_fault_vma_info() will naturally go
out of scope when mmap_lock is dropped, don't bother nullifying the
variable.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ea326d66f027..435582e997ce 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1559,9 +1559,6 @@ static int kvm_gather_fault_vma_info(struct kvm_vcpu *vcpu,
 	fault->vma.vm_flags = vma->vm_flags;
 	fault->vma.is_cacheable = kvm_vma_is_cacheable(vma);
 
-	/* Don't use the VMA after the unlock -- it may have vanished */
-	vma = NULL;
-
 	/*
 	 * Read mmu_invalidate_seq so that KVM can detect if the results of
 	 * vma_lookup() or __kvm_faultin_pfn() become stale prior to
-- 
2.51.0.261.g7ce5a0a67e-goog


