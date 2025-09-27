Return-Path: <linux-kernel+bounces-834822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703DBA598A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8BD4E023D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309425A34F;
	Sat, 27 Sep 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TatIHFNp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC77257458
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953355; cv=none; b=FvehGgTjZIcd1H6xjNGFnbJDZfzDGwMz/t6n1R7zwd6KQB2UUt5PDayaX4xKYbvR/LWfcVwV7pJBrkMZdH+n+myNhCtrNCGZyzGmko7atlrYFnFQh1RaPps5K3X/8R5DtIayq2Y/2kEcjstkEQsCTlBWX2JdQsFjL7ziasBIZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953355; c=relaxed/simple;
	bh=zFZZW33htcf5UO6Mrz72UPNHmVA9TaoJaUbdYKIngUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lgPFNx+Tkp19RbLBtAp0t2FYTopqk9/CI+0GzAyLx8eP6cFwSBtWLgF5GgFJV6tJteIWzEOy28Vkbz3dJT3ayyQNoFiLbzzzdVsPdufYPGjdSl4yZZiZuaEgTdTho+EfxvIjr0gtDdF1r/KsLFiVAxQmzRyNE5Gx8bKkQ8Nlo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TatIHFNp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-272ed8c106eso18967995ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758953353; x=1759558153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=p1VKINsN5HdpVD8DQoiw6pP6UM2GuhLbwew+VRahngI=;
        b=TatIHFNpkTD42qdVKlSVNQILjeDP9zz6f3RGJQBHaMIZTzvQTBltuyfbE5/yUKBf0y
         9AoY5NBZFaZX8tupQT4LuGIZhvXuhTJY7CpY4r+4OSReTWUH+1v0nq4pEe6/nTiu4feh
         h37Z3i/QCWgl5dn325NfnslgqzSsGqVE+7go9PeJkHAgC6VNDJaLCcujb/RHdQU1ICia
         4M1MZhU5Wf4sNyqBoK1oooCwueT1eaUKamYxuMSfUYBK+Ba05fNR3+uN60qeU5+Ck6tI
         d0sNJfOvmFy4xM1QEFXIDi6Cuc179+c6cPbu3lAOo0iIi06/YdG7JaPSa9Bumwf+WsNx
         lKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953353; x=1759558153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1VKINsN5HdpVD8DQoiw6pP6UM2GuhLbwew+VRahngI=;
        b=KM7w/1Mc1tGBSi3cPOG0KnuZQVd2u9j1Jd9/BpE8H5SXBOxVfrrkHSKNH4P2dZcWzj
         kbVkwCosDW3FlC9iJhS5xuL2DRAFgXOVjAEkHYzc74nXpMi9smMfwj7LIuHza71VjJCB
         wqkB42W06OQo5omQuvO3qySlwUUX9umKa5rCnjYq8pAJOY5VEgidSlPbuuhVKdoX343y
         hhyLi7vxnsS2jx1+nN0RDiJ6HbdJa+SFsYBavele/cZst9b8YxPEeBNsd+D+EMfxZ9kQ
         g8qkvZupXFaUV74U7socAnZSYm0YHR3/eGH57ehHJvZi54MP/Pw+PKLgB2i1TAbr5Lyl
         9jDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtU2+V/XSC9RTCmlsN3KGJum9veRg+RkjTt6Wsuxh1TA1j6yHL0O7IXfiSAtebsASt9kCJXrzCB/r9jUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeCbR3Uw6M1dCa/hdCRrYv83zHDL7IH1++6jUN1dYZIPIZDV6
	PxXgLF8xG52GY/nkqf0PHPc9TkYGRbb2EmwIq5HeYTj3Fpyal5MiX3pNKdo7wSodCilVfzJJzH9
	iaywVIQ==
X-Google-Smtp-Source: AGHT+IFjypYhD8XDl1Ui/uJ0XaCoET+BAfqYVM++duQSDQOb++3O+6CiSdjvZercKWf5F3Z+MQbOsDUmaFs=
X-Received: from pjzj6.prod.google.com ([2002:a17:90a:eb06:b0:330:7dd8:2dc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:a90:b0:251:5900:9803
 with SMTP id d9443c01a7336-27ed4a16c4dmr122756245ad.21.1758953353309; Fri, 26
 Sep 2025 23:09:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 23:09:01 -0700
In-Reply-To: <20250927060910.2933942-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927060910.2933942-2-seanjc@google.com>
Subject: [GIT PULL] x86/kvm: Guest side changes for 6.18
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A few smallish guest-side changes.

The following changes since commit a6ad54137af92535cfe32e19e5f3bc1bb7dbd383:

  Merge branch 'guest-memfd-mmap' into HEAD (2025-08-27 04:41:35 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-guest-6.18

for you to fetch changes up to 960550503965094b0babd7e8c83ec66c8a763b0b:

  x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV_UNHALT (2025-09-11 08:58:37 -0700)

----------------------------------------------------------------
x86/kvm guest side changes for 6.18

 - For the legacy PCI hole (memory between TOLUD and 4GiB) to UC when
   overriding guest MTRR for TDX/SNP to fix an issue where ACPI auto-mapping
   could map devices as WB and prevent the device drivers from mapping their
   devices with UC/UC-.

 - Make kvm_async_pf_task_wake() a local static helper and remove its
   export.

 - Use native qspinlocks when running in a VM with dedicated vCPU=>pCPU
   bindings even when PV_UNHALT is unsupported.

----------------------------------------------------------------
Li RongQing (1):
      x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV_UNHALT

Sean Christopherson (2):
      x86/kvm: Force legacy PCI hole to UC when overriding MTRRs for TDX/SNP
      x86/kvm: Make kvm_async_pf_task_wake() a local static helper

 arch/x86/include/asm/kvm_para.h |  2 --
 arch/x86/kernel/kvm.c           | 44 ++++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 16 deletions(-)

