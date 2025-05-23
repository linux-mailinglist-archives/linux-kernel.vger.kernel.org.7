Return-Path: <linux-kernel+bounces-661175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3EAC278D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02783B3706
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4D12980B0;
	Fri, 23 May 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pbeXk8z"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E0297A5A
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017511; cv=none; b=DEQNOiJk9MQvDJFaOQ8eo/DH0YYIR/LLaboS6Kl3Kr7NtLJeO0U0foTWAP9fWtezCvjyCxLY4X0rrz3jArxBasoxdyXueuRb3pt1H0Le+1abTUeeg/cF33mhEfkvIgdg6ublLEaVb55YCy5o4Ldh/lh40crsbPE5w23U02EI6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017511; c=relaxed/simple;
	bh=x6jih6XATSb1TJ+DjNPTVCHK2DQSo/2Sw+u6I/fV2g8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SRO7ue0SQk4Y+URYDFfX2WDE36o6GrDEI42iyg8Lb0LRuJv0NYFocIRKEk7gZbmu2ACBzZrcYznZ0n1+m0z7FuVQ+1+kzMBatdjE2D7zJXXaO6czBVOtzudeAwIYA0yd+PRQhFpt38tnNuAsCiGyNvfBOktCZ6PvHlOKQ5VA0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pbeXk8z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so149240a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748017510; x=1748622310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vLD2BxtL+oRSlLgncs8WwoIRI1KgiBZ5QnZjhCDIEHA=;
        b=0pbeXk8z8ZyUxxgcsYcae3+xD1OxwAASJFalnANd4+84v0HgrTzLZda1E6ZLK81RPn
         aI6dEfvpNKngWLMYgo3OxEmYNgAeR2PLP5QGvZ+7nrj+D1AdSG9rC9Cs4j5WzP0a1omH
         l5yUoyZOgFytHc/RAjr7aAqZ5e+YdCUDlIkjq3YDj+E5W1+fM8lULWGyIrnc91uJ6Ds8
         ZcYOXuABM+WxgfKuFwjnoxwxWPfLI3p2q9mi1L7alGcjbxPYhtCw7zUNVbwxHP5hU+pr
         rCC9mAmTcuRt2iY66wC3GzcVjAD8n5SanJprW2Bz1C8ei7L+tKyv7xSSEph4+7y/68Fn
         LnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748017510; x=1748622310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLD2BxtL+oRSlLgncs8WwoIRI1KgiBZ5QnZjhCDIEHA=;
        b=DpZAlercdc/FfeeRZNqwd3Z9d2kpoKYdx+hBpXq0jgvm6jetK+7qUnuYJqIkWMlpYE
         lE0daH+ETj+Wngdjl4KKeFHKPFr2/CqLZFZomP20GX5Swd1Qkli4+ssWWMRzPIHB97UJ
         K+Wee3f32aefd5BTE3l+J34fm4WUTiARTky2f0POnUVciBN3jOJjkCxV4LK25I+buwgX
         6zYZkIKgi+QR05lY8z1r25wlofGTzXlE/cLNcYAyJH26Kc1ALAQZXoLmKtB/tuxRvkH3
         CAlwBdR6E0pqYmSkeYr4IpjmF8BSD/jL6PvxP6CHzuzddpKDrr3IwhQLuHRDpoyxNcWY
         TjbA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZMfqyHhR1Ikvi5PTIPW8LqY14gKMrGhQHF1Hd9UMyFscu1HepIRdH+19L7Uhc4UNFXBBSCCf8eZL8SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgVGODh+xnTNgOjBw+hn9LrVE/DMVL//XWPfdcKdccAcqo6x/
	ttUNAAqO6s37HX4NSniFS2a2g1lEEgVDE/RLeIO2I7lTioMvYz7jngiS0M6nsiCfNtQzvduUVrk
	zzpZ4hw==
X-Google-Smtp-Source: AGHT+IH4TZCMGLjx70ZzhLpT3MqCF42IbUw9jJEnFG7Gzr+Sx7zjmflvZNd7O29c7zvdubJdcna1HLJhIV8=
X-Received: from pjbmf7.prod.google.com ([2002:a17:90b:1847:b0:30e:7b26:f68b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2882:b0:310:7485:e3ba
 with SMTP id 98e67ed59e1d1-3107485e4ccmr21039402a91.28.1748017509728; Fri, 23
 May 2025 09:25:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 May 2025 09:24:59 -0700
In-Reply-To: <20250523162504.3281680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523162504.3281680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523162504.3281680-3-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 6.16
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Spurious fault cleanups, and minor fixup for S-EPT.

The following changes since commit 45eb29140e68ffe8e93a5471006858a018480a45:

  Merge branch 'kvm-fixes-6.15-rc4' into HEAD (2025-04-24 13:39:34 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.16

for you to fetch changes up to 6a3d704959bd04ab37fc588aff70b3078f3c90e8:

  KVM: x86/mmu: Use kvm_x86_call() instead of manual static_call() (2025-05-16 13:13:58 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 6.16:

 - Refine and harden handling of spurious faults.

 - Use kvm_x86_call() instead of open coding static_call().

----------------------------------------------------------------
Sean Christopherson (1):
      KVM: x86/mmu: Use kvm_x86_call() instead of manual static_call()

Yan Zhao (4):
      KVM: x86/mmu: Further check old SPTE is leaf for spurious prefetch fault
      KVM: x86/tdp_mmu: Merge prefetch and access checks for spurious faults
      KVM: x86/tdp_mmu: WARN if PFN changes for spurious faults
      KVM: x86/mmu: Warn if PFN changes on shadow-present SPTE in shadow MMU

 arch/x86/kvm/mmu/mmu.c     |  5 +++--
 arch/x86/kvm/mmu/tdp_mmu.c | 19 +++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

