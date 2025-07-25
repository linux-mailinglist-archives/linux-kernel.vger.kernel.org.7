Return-Path: <linux-kernel+bounces-746421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D96FAB12686
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D768D189F254
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE326772D;
	Fri, 25 Jul 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcJPAOPg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3E266B67
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481261; cv=none; b=sQGka64YyrgC0Lq8sWDEMN/TSJMnBEfXk9lVY8gF/hbRZvDB5IPgtqOaJD9gklsqR6VWNngWvC1vfUwqNSH7pxfFDWNMklAcVz7xmTlEX+GCI5KkbIxdwu99V5Rr7kQsoL10VkgNvXdbIqeAoyZ4y4IAHv8Lh+NN3CANBEAhvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481261; c=relaxed/simple;
	bh=QtBtvfBTP18jdVYP+tT+BRRVQKRMwScoLI9bYcDp9f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T4iQ7fNAsilUptdBIJ2NINgbGwqs8Pgdeu6Pr1U4+92tJx//rHS9UVGS8k6Q6t35/83qts5HIlbH8qazQ4ZNuUczNAELCxQFBmNO3a2lh/wFRTtTs3tZOYKqYum+PLWdsxW+4EUFXc3GIOEGZMdMPxlH1XY1TmA6POeAcRRiTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcJPAOPg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso2570256a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753481259; x=1754086059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hGNamb6eDhMq0KBZSgWG51/tD3CsLO6bWw7B4/nq10Q=;
        b=CcJPAOPgzgOX23cmVe8oWwxeV2hZGC69f25S1l1A0FRyQk8wFQfrG74X3kAj3NNs0N
         VO5ArHq30wfRH6Ef+3lKu+htEE0oTlUhaXMXwvrJ8NsoT66guDoxaMRReqI4Dd0VQNtu
         +iV42M47rKJi89DFe4ry/2zuCw5c1sWELL/IJI8yArgkUDmFZd94egytfbKUgcyHC3ZP
         B+ZqVsrmq0pp3xOIWFQzbjAXmGfIJ/nfsj6mE+Z0IakU+XeKjG56D0qHCFpAqc9ay7ip
         7HZPLgA9r3phz+ggw3GpROFSYpgzsJi1+7j6vBTG4jy6j/qUIW9VdG7fx63/Wnn9hveh
         gzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753481259; x=1754086059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGNamb6eDhMq0KBZSgWG51/tD3CsLO6bWw7B4/nq10Q=;
        b=CloXKwKPJZ/X/nlZL3v+6ERYwVCqaHEfz3bWSN9DnQZkXyDgMTF9xz6Kd5il9israR
         mg9WiLozaDPVfysNdh8mbX37GtHAPZ3cZcCzKRfApHjfCQgTYpJT7Jhm/dyQRblfaKAc
         4xDgkDyNgcU2XZ5Mo7Q7nYGRMFk+kq7criNgqZgAGvBIBqN1zOZVqHxaIitMchi0zLXu
         /Qot+U1w5/zNnuIhG7h7Z9JWk4DEIDZKt9mJAsxXtwkayv+yu/9bp47eAKfq8cPiZW5G
         ZjkjjX2Rw/8hhH1kOXnxbJVpIkLIbDeml/dH3bej9VUs1zlgSL/VPMIc129+rhPZj736
         jlXA==
X-Forwarded-Encrypted: i=1; AJvYcCVXEwmRm3YXpZAk76XHwiNIkOCgFeS+L+FS4ahge0bB1xFOlt2Qon46dq5wCiG7uRFRzaawUMiEQ2Npwh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtS3zwEjF6R80LTXjgqYGzvT3scllHSIlkmkJ6BZVPRLbSr1nJ
	9REZNlw6J1XNjffsJhubSMyvxEmUSaMLk9TPpkdEcDxhE4aecSONl8uZaopVO0pN9UwKzjtcQkx
	no9p/eQ==
X-Google-Smtp-Source: AGHT+IHh3rxuOFbb/W2x7iN5AS6/7XibK86+B4gsoJfk3ZeWbvZFhv2qUZK5Njbmn7ovGNC1uVRrGDYTZjY=
X-Received: from pjbok13.prod.google.com ([2002:a17:90b:1d4d:b0:312:1900:72e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f49:b0:31c:15b4:8e22
 with SMTP id 98e67ed59e1d1-31e7786e68emr4264830a91.7.1753481258823; Fri, 25
 Jul 2025 15:07:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Jul 2025 15:07:12 -0700
In-Reply-To: <20250725220713.264711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725220713.264711-13-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 6.17
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a sub-ioctl to allow getting TDX VMs into TEARDOWN before the last reference
to the VM is put, so that reclaiming the VM's memory doesn't have to jump
through all the hoops needed to reclaim memory from a live TD, which are quite
costly, especially for large VMs.

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.17

for you to fetch changes up to dcab95e533642d8f733e2562b8bfa5715541e0cf:

  KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM (2025-07-21 16:23:02 -0700)

----------------------------------------------------------------
KVM VMX changes for 6.17

Add a TDX sub-ioctl, KVM_TDX_TERMINATE_VM, to let userspace mark a VM as dead,
and most importantly release its HKID, prior to dropping the last reference to
the VM.  Releasing the HKID moves the VM to TDX's TEARDOWN state, which allows
pages to be reclaimed directly and ultimately reduces total reclaim time by a
factor of 10x or more.

----------------------------------------------------------------
Sean Christopherson (1):
      KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM

 Documentation/virt/kvm/x86/intel-tdx.rst | 22 ++++++++++++++++++-
 arch/x86/include/uapi/asm/kvm.h          |  7 ++++++-
 arch/x86/kvm/vmx/tdx.c                   | 36 +++++++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 10 deletions(-)

