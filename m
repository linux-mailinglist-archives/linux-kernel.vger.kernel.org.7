Return-Path: <linux-kernel+bounces-746416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF12FB1267B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC2F541207
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F3263889;
	Fri, 25 Jul 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xefJQAMM"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD3261591
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481250; cv=none; b=qG/RkI/7SnxH7ke9CeiJjcsLLl7RZ3XwPK3yRLwz++z0ucloCSv7z1hc7GjyklSqUTd3T4BL9iW1zUKDa3DlM77qIugm0Ef+HsjGxd9bkVMtsXC/JTm44KzI0biZz7x7ozqHTTN6lV+2WOKcZ2OajGhgnarOUID8ef5DzyTZL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481250; c=relaxed/simple;
	bh=WW0CPobFKPKKFowOGKB20x9PGbl9U9qdV93bltr20mE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=idw5VNoXPmNPG4/0mx6pLqylOPWkUmVLU8E1+TuwncjkWBXvzmd8/Z5wt6clpI2n/enDfEvYjlwvlZ1bIosKv63+IjxkUYV3wKhjbA3WFWVNKZJ1eyuSSbNRKOootrG7iSE92EL0EPMdeArKKGByXr2k9cLOFNR5P+youtLBEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xefJQAMM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36951518so2926918a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753481248; x=1754086048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8j/hFPuge5KpGKM7Z6Z8NdL5vgVmo6tZrIZIEVn/Aec=;
        b=xefJQAMMAsNPgiRXD/Wmc9ERPm4eTOw1rVeQ+ubUVQ93OcmUOjXtPY2UrBdlWnocZj
         zDr8h8N7dTo0n2Of0OZHmURCmQbfiYsjJVhPaMah1UFRBo4IlB7MigLTkMvpfnpR6RNV
         DZVfzVoAFlkEjT4pNtb0pp/l5OF/c+oUJrfB3SMKCUX6AoJc9vRfmukQzHkf1PdloAwH
         XfHMB07DjW3/B6kDz59SkWbD/iZgeqSorTzTIF0iq83WF90f3kfH+sc1xvdCZFBHde/C
         qjZQMPdZPMUqgrcnKG4o03fz9q56PHMqhCE0ECP6DFphAB4H8u+YoPfd2VRfsV+4IPuz
         vpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753481248; x=1754086048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j/hFPuge5KpGKM7Z6Z8NdL5vgVmo6tZrIZIEVn/Aec=;
        b=mq6vO1bBiVjybDzCWtCBoBMiGQ2sWJyyf+DdDrp0/ELvDcV70t4EGsiTDgzCyqPmM7
         zIbJnApaQoQv2SSMWioLzlMU55guZWfCZiY1KBdsv6WViycTyqpKuX3A7UBf5Pr844h5
         u/sscvDy2HjDKDG8jUlbgL8XnLd9IEIa5P6mPug7mdBoik9i86/0iCCHp6E5NaO2xWjY
         SbDYTXKWuF0lU7jMnGgyDcwe1V7F/04MRMjh4A0SjnbBl+SRHzgUGd8Ie2vn0/AKMNlb
         VaXGv3gA1XQevxAdQ67cMfs2x87X7XDt9gkJsClDyGCsWOYieqz/D5kyPHQQnV5UO1HN
         +4sg==
X-Forwarded-Encrypted: i=1; AJvYcCXqGjVf5HiRAgdnhjuz6EySiqcteMhzhc90P5r5Qq888rWcy79fd9bymopQSKQQuUPxaO7fqNIsnuW3TVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMhjHsFxF3+MEg8z/FcXxVnOgJDDkTLMffBj5yLn4ENGKtwAT
	9Z/wj2xGbaSMPPG8C3qJZ4efOk8M3Caa5rTtDndhRRj+FnbhQUfUAzghiBfinlOz045XCAR8PF1
	ZsXdLaA==
X-Google-Smtp-Source: AGHT+IFAboWw2/BOR/wRCxEdR+bb1CH4oPn7JnWHbasz79mqqVXFyZTEHFOKsrapSEfkqh6cip3P5D07OC4=
X-Received: from pjbsl3.prod.google.com ([2002:a17:90b:2e03:b0:312:1e70:e233])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5868:b0:311:fde5:e224
 with SMTP id 98e67ed59e1d1-31e77730540mr5598498a91.6.1753481248395; Fri, 25
 Jul 2025 15:07:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Jul 2025 15:07:07 -0700
In-Reply-To: <20250725220713.264711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725220713.264711-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 6.17
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Dynamically allocate the shadow MMU's hashed page list, as it's a whopping
32KiB and isn't needed when using the TDP MMU without nested VMs.  The TDX
change is quite out of place, but it's in here as "KVM: x86: Use kvzalloc()
to allocate VM struct" depends on both the TDX change and on dynamically
allocating the hashed list (KVM uses kvzalloc() purely because the 32KiB
for the list blows up the size of struct kvm).

The following changes since commit 28224ef02b56fceee2c161fe2a49a0bb197e44f5:

  KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities (2025-06-20 14:20:20 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.17

for you to fetch changes up to 9c4fe6d1509b386ab78f27dfaa2d128be77dc2d2:

  KVM: x86/mmu: Defer allocation of shadow MMU's hashed page list (2025-06-24 12:51:07 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 6.17

 - Exempt nested EPT from the the !USER + CR0.WP logic, as EPT doesn't interact
   with CR0.WP.

 - Move the TDX hardware setup code to tdx.c to better co-locate TDX code
   and eliminate a few global symbols.

 - Dynamically allocation the shadow MMU's hashed page list, and defer
   allocating the hashed list until it's actually needed (the TDP MMU doesn't
   use the list).

----------------------------------------------------------------
Sean Christopherson (5):
      KVM: x86/mmu: Exempt nested EPT page tables from !USER, CR0.WP=0 logic
      KVM: TDX: Move TDX hardware setup from main.c to tdx.c
      KVM: x86/mmu: Dynamically allocate shadow MMU's hashed page list
      KVM: x86: Use kvzalloc() to allocate VM struct
      KVM: x86/mmu: Defer allocation of shadow MMU's hashed page list

 arch/x86/include/asm/kvm_host.h |  6 ++--
 arch/x86/kvm/mmu/mmu.c          | 75 +++++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h  |  8 +++--
 arch/x86/kvm/svm/svm.c          |  2 ++
 arch/x86/kvm/vmx/main.c         | 36 ++------------------
 arch/x86/kvm/vmx/tdx.c          | 47 +++++++++++++++++++-------
 arch/x86/kvm/vmx/tdx.h          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 arch/x86/kvm/vmx/x86_ops.h      | 10 ------
 arch/x86/kvm/x86.c              |  5 ++-
 arch/x86/kvm/x86.h              | 22 ++++++++++++
 11 files changed, 145 insertions(+), 69 deletions(-)

