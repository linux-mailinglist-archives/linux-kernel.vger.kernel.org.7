Return-Path: <linux-kernel+bounces-780729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC66B3086D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195961D00058
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536B2C028F;
	Thu, 21 Aug 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVJzCfGn"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A0299954
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812150; cv=none; b=ZGZ+TMH47gyF++D3frgry0ArTlsTZ9vRxpcOMH+t7WALVgWV/DjU3u5vPDabFgaADVijvvhLVKIqbHwqUqjGA0NfjTrJcxYVMQg9g368kLLHRvMnbuI7YrmEh5oVzuv6tq2iSs1nEfDwnhjHGdAZgj3KQwt4mD8kW7tzJ00Hdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812150; c=relaxed/simple;
	bh=jP0rwMbmPY6qZ5vkuwfRvx2qcHm34gDCB6TYBB46G9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OE8jNjos3Z2fhQQPR3tjl+EaaKvnK/H6yAm/SZP6dv+bL6Z+eoKR5TBxksyXWcgJOjySQfb62YpnyIngLbhQ8t7J5yOUby/jhKD7NZxICPeZkWz51p+lBhhjbC2D5XNv8EzpxUL/0nN6kDhz6hSk91wFUvYrtdgslRQhUPtfcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVJzCfGn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e8e28e1so3684435b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755812148; x=1756416948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rBrZ4FQeFzZyw4NFPQJ6D9xmaH/Ph0zDxdsgr2vDiU=;
        b=WVJzCfGnU50XpBb3oQ7KSpEtgqGh1vBQHfxr1RTBFcb52BwMFdQvjYBuG1/15xJyBn
         hm1FCsfSbtyouEMKPBH4VpbY2kLJXA8rBrZJJ7vttqNeKcmFwzlI+IsdZC5veIfnWwTk
         BxJ3+jQ2cgQOkdI0GKzFHseRzEdtqdkPpxeh2IsnGRGmmhBoCf3ojAgzjouSf1WfHuc7
         dtmc6FxLEKI25wZnAOQ9TEUespCyTxUAsXGWjF+FXEqUZUB7mtuGDJDLVzqvjqpCWH4H
         P9GD7xHElA3uixeEa4nL1Iw4lJ0wbIwY6OjFr1S8JmGEhyI/jgJgldA3F1g1AoZZl8/8
         F/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755812148; x=1756416948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rBrZ4FQeFzZyw4NFPQJ6D9xmaH/Ph0zDxdsgr2vDiU=;
        b=FRpBUrR/X+c2bhG/XBz03owor1BsLkYDnCefM7cRYwfHYbXgMfdNoCMiFz/matCuXt
         T9MhwAgNfCY5IWCN+ANhDBp/GHJjRxWqjHHVEIJRgX4MnmQn3kn41agkAHLM+o4U4CpE
         P+ww9iZZi4J7Ro/CKdR+GoDdf621eJOPM4Wn4gtEqb5s4wXrrPVWzXJ0l6A3i04berNb
         fn67lFDIjIH95DdZAG2ieISV4G7K3NYVrlvVjQFi6iXvzfr/KqbraSXA3KucrXPWzlXY
         1IDU8f/3ffXA9kTlXlQGg24FCb0EYvB9i3AnEczbMEJxirrtOYooC+whqSchVLMu8JHp
         oO1w==
X-Forwarded-Encrypted: i=1; AJvYcCU8OLw8hV+CDjUJXvdSnStVmbeyUh99q+KS9Lc2izkikGYxHa9TLJDjMlq1XqGvTO+1u5ZGI5d57TbTUg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAU6NTVBYSWNRKtHUyiZy5pPlLxf6NGP7fb1CIlaaVQM+UFykX
	Oks/YSJ6u01C53XyaeMyuggQSLGWtfg5lGZb4Pm2IlOUdLgYLQKDIwDwTrq4uCVVB90ya3ApKeB
	ipUuLpQ==
X-Google-Smtp-Source: AGHT+IFkSGjo6AoswGsjL4FhEJep7vZYFg7axYxhkRNzb8snn9ZMqDOHbl5XVjj0GKiY1o1u2ObmOg2Dtbg=
X-Received: from pfbfc13.prod.google.com ([2002:a05:6a00:2e0d:b0:76b:cafb:f34c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1494:b0:76e:942a:bb09
 with SMTP id d2e1a72fcca58-7702fc33088mr1156973b3a.29.1755812148369; Thu, 21
 Aug 2025 14:35:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:35:08 -0700
In-Reply-To: <20250819234833.3080255-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819234833.3080255-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <175581201824.3460047.14086246675316864904.b4-ty@google.com>
Subject: Re: [PATCH v11 0/8] KVM: SVM: Enable Secure TSC for SEV-SNP
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Vaishali Thakkar <vaishali.thakkar@suse.com>, Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 19 Aug 2025 16:48:25 -0700, Sean Christopherson wrote:
> This is a combination of Nikunk's series to enable secure TSC support and to
> fix the GHCB version issues, along with some code refactorings to move SEV+
> setup code into sev.c (we've managed to grow something like 4 flows that all
> do more or less the same thing).
> 
> Note, I haven't tested SNP functionality in any way.
> 
> [...]

Applied to kvm-x86 svm.  Nikunj, can you give this one last sanity check when
you get the chance?  No rush.  I moved the "!kvm->arch.default_tsc_khz" check
up slightly so that it could use a direct return instead of a goto, just want
to make sure I didn't pull a stupid.

Thanks!

[1/8] KVM: SEV: Drop GHCB_VERSION_DEFAULT and open code it
      https://github.com/kvm-x86/linux/commit/c78af20374a1
[2/8] KVM: SEV: Enforce minimum GHCB version requirement for SEV-SNP guests
      https://github.com/kvm-x86/linux/commit/00f0b959ffb0
[3/8] x86/cpufeatures: Add SNP Secure TSC
      https://github.com/kvm-x86/linux/commit/7b59c73fd611
[4/8] KVM: SVM: Move SEV-ES VMSA allocation to a dedicated sev_vcpu_create() helper
      https://github.com/kvm-x86/linux/commit/34bd82aab15b
[5/8] KVM: SEV: Move init of SNP guest state into sev_init_vmcb()
      https://github.com/kvm-x86/linux/commit/3d4e882e3439
[6/8] KVM: SEV: Set RESET GHCB MSR value during sev_es_init_vmcb()
      https://github.com/kvm-x86/linux/commit/baf6ed177290
[7/8] KVM: SEV: Fold sev_es_vcpu_reset() into sev_vcpu_create()
      https://github.com/kvm-x86/linux/commit/f7b1f0c1620d
[8/8] KVM: SVM: Enable Secure TSC for SNP guests
      https://github.com/kvm-x86/linux/commit/a311fce2b694

--
https://github.com/kvm-x86/linux/tree/next

