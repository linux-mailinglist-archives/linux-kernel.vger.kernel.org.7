Return-Path: <linux-kernel+bounces-743198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E7B0FBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DC21C265BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DD722B8BE;
	Wed, 23 Jul 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vnt8ubY+"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD452E3719
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303475; cv=none; b=SFm/xcUqbn7n6/Lju49WPEbI3HqU6VLmchCV5p4Yj9/hko1pGstiSTGF08D//oMIORT/ZmnkL2mJmsfeQoUXCzuVjesuECEkOjQdVOvbE9+072s54YlRhKqr+kXOYbzIDTr+oNV4kCFGVLBd4cCZ2pTf9ML91qdJBrtp6rygIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303475; c=relaxed/simple;
	bh=lNNzNnEQaIAibD96dk3AqwFlfgMHlcvq1eJJsHRiKAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J5khlcvwrp/HMZTqt02rcLCrrQtvFbf5bh5L65MrGK0JP9Cp25EQRjLou3OmaxniHmkQb/rwEtw6lyfYFzjoxHcZLwL9tzgCShpCNDOHTGVJdLqYhwstVAeM2k29U07vL7NZLWOMdWQPFkn+L5RH5slbahZpeDWWOUdP3ZnQip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vnt8ubY+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so228961a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753303474; x=1753908274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EulshNrvV1py+eBqD1w3s7WQKqFPO8/zm/4h+Qzztr4=;
        b=Vnt8ubY+nJfEZgf9qP3+hOVy0jdnwSH4a4vDDslsvQ+uBexlMt8+QnTmoq79qW84UN
         fUeEldjKc+ghwG+2wDKjiorUi3lCKJdj9/5apQBj4uVy97z0a+ptliUaGB/veV6Rm37j
         98vO1+M/6cMVmm63SSwVQNDbd5qrR0h5Mh/ho5Rg/1Idf9fESMbQ5NLGtcWqnslm29EZ
         w0ct0SIYu59YB2GnOOKPMfu338sgkzthSwl6N90apnSeK+ouh3AjWj8YHpMTcmfJeE46
         ZHXrQo+FflO/D0+R0uZmfc9v0hor7xsvL76vIEhYP+2ptD14RC+S51cFGafIdKAnoAbH
         KMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753303474; x=1753908274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EulshNrvV1py+eBqD1w3s7WQKqFPO8/zm/4h+Qzztr4=;
        b=qTmGx/Sc5i7w7K+2sl8DKkKg2IB+NHxJZEvezLuUWPcAuFw+OR+M90BBn5cjb1XsUm
         Y0xCEwql1ebEasSvPnsxq0QVERpWuwptPwcqrMwORufkT2DcLO5xcbB6NcjyOFaxtoeI
         Q/Mqq2iQ97OHPR02F/7z6Gyhza4r2eAx0ZNR+ti7BQ2P4xLRcJd67CmOwaLDi/DUp78l
         PqGfQKSbNPvBDbyXyBpcujvpDSKxP3Qul1QvTLOYm0g7a8VGKFID9nR9zdMi7Txl3w0/
         CFpezqJiwjnJrt5PGh6c4nMX/cBFb1A+mRmdmdtoFDXQWLhKWpC8zFT/AXUO7GdeDtHJ
         lcqw==
X-Forwarded-Encrypted: i=1; AJvYcCWblHvZ3sFlo0pFmBMvEAIMidgqemkT0QlQD/Spp7teurdJh1MYXbzN0f7COB2bG+F0qzyR+Ss2NDQzFJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2u7MNgiHHWd1gEVxcV7V5EL0XmSFbP6w4F+PMJK2Lfq9uAN0A
	KahQYNIfu18RSQafS5tPWlpBwdekKl+JebEiWxwYLRLfagl3V3UFpPdukm0myohkjCtilqIJp9F
	lg9blLQ==
X-Google-Smtp-Source: AGHT+IEdfsVNIkzfaXrM5ULBiujsbhZiIAIlg4AOA4DGSLcSfkO7jtSls6y2nD57ngnLPPXa+VOtThQnGoo=
X-Received: from pgbfq28.prod.google.com ([2002:a05:6a02:299c:b0:b31:c9e0:b48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3944:b0:21d:1fbf:c71a
 with SMTP id adf61e73a8af0-23d48fe3845mr7492290637.4.1753303473831; Wed, 23
 Jul 2025 13:44:33 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:44:32 -0700
In-Reply-To: <20250707224720.4016504-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
Message-ID: <aIFJsLFjyngleQ7S@google.com>
Subject: Re: [PATCH v5 0/7] KVM: x86/mmu: Run TDP MMU NX huge page recovery
 under MMU read lock
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 07, 2025, James Houghton wrote:
> David Matlack (1):
>   KVM: selftests: Introduce a selftest to measure execution performance
> 
> James Houghton (3):
>   KVM: x86/mmu: Only grab RCU lock for nx hugepage recovery for TDP MMU
>   KVM: selftests: Provide extra mmap flags in vm_mem_add()
>   KVM: selftests: Add an NX huge pages jitter test
> 
> Vipin Sharma (3):
>   KVM: x86/mmu: Track TDP MMU NX huge pages separately
>   KVM: x86/mmu: Rename kvm_tdp_mmu_zap_sp() to better indicate its
>     purpose
>   KVM: x86/mmu: Recover TDP MMU NX huge pages using MMU read lock

The KVM changes look good, no need for a v5 on that front (I'll do minor fixup
when applying, which will be a few weeks from now, after 6.17-rc1) .  Still
working through the selftests.

