Return-Path: <linux-kernel+bounces-740209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D49B0D16A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D2544B62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D228CF6A;
	Tue, 22 Jul 2025 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIp9jdrN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA328C87A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163442; cv=none; b=VxtVmTY22eGQlPu2UTps2r42nvSpScPgsCARtIUEB/gVwhMBGc2eGhQJf2Llm6nuD8mrDV51SluVfr9HAWoz5PQA9+6wVhNZg6p/yJU4F0yyZTuer5M7ulXGmBzXXIhwPyfTxInE+bVhFf2bA+XZdsy3RDTvcotEjBT6HBtjMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163442; c=relaxed/simple;
	bh=V8kIzO+Cji3KXx6YnbEezb8ctyYCWKwQM1CMkoRJPnw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=ZkMMANnz3RJ8rY/viTzNiYCKh7P2GSS0exyHFjRDkUML2n2+USXGaiBiBMBV3XE4410OOjdOdE8Obzc9xgkgRVuXjXnRHfi3ckELmbkNGX1T1Ub1556vo3rcdqTR98shLB5mErReYLSwcej7KUsiFw9nEFJW/0O93EcZF+PJg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lIp9jdrN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e8d893927e7so3562024276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753163440; x=1753768240; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/C66G9GRTVz7ajskOiW6gfk3y7DY6w9aPdodLwORZqE=;
        b=lIp9jdrN8clw5wNa/nCU2HgS7McezyHD0UwXg3CwM5GfHZ6lM90IPhmQfQzZYlfCks
         ZsCmnqkqLZ6b/2WAWVYxerncusnhRFdzPqa+nHaLjzuJiA1hfghnx48W99RVPJlKp/RA
         v6c4J64Em7NHigbR+xaos8PmFeFt7acIDJr7nmqEHF8XJLWrCQC/4+3XVNfBsNTXerfV
         MgtCR0aomUxrr3uDgb8S0D5T4FH7T9D781sqTepnMc57C9Wo4xmATmAO5gjQtylWfEvG
         Rn+5XOuwu0dJZ0PmN/T6CC+D8MYG6qcAq7nNwGw08uCKDLa+dvjHdJ1+caSlOGKN9WdX
         LX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753163440; x=1753768240;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C66G9GRTVz7ajskOiW6gfk3y7DY6w9aPdodLwORZqE=;
        b=Jp2wHtY6LOCVCVgSLsck5YaUz+w/7VWdKZR8N3dNiKA9v0xerWqfbIp3aMo8zcLIyo
         QyTiGpl6+DTBMXeh82tQR5fcnbJpjx0sgNbfSGTBi3iiLvFDlxpZQ60Lr4e/puz3rbNe
         NfQb+ltAzP8cZFVVQ0D6D8YEXOxUdr/KgxRVnPnlPTRpRmlAavrvz02esSZrpllPE2A+
         7SqL0tFSe4zgQU49qk/NqxTivk30j10l6sNFXoPd6QH3t9xm43XocMXCUp1OUVb5buik
         XqEAxWCkgStUz2PuDGPoJ5cSgPy+ny1alOwZuKccXs1o4a6HTIhbh4aZuXeiDetbd3mY
         ayUw==
X-Forwarded-Encrypted: i=1; AJvYcCUt1MKHe/kbIEl/y+vfc5nHBc+dMO2VlY+kUctHpLnGg9d4YKKkgr2FzxIAOaoS/OmHKZqulElPTMbJ9rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1c3UKoC/kA3Zm7Ixr2YSDjnbPVmTZZ7OMY5zI2PVl0FMImpyQ
	yKQwtT2FLGWsdsAOheLUhzqIR4PpH87tUtzHnC4vldjWj2hdIqUP58K8t9pqQGTMzDidHqFtIe/
	IjcPx28AjYvHiBA==
X-Google-Smtp-Source: AGHT+IH8dnFqafeRqJkcg//9CKtbnV4BhHQlsWwaIUqI8uYR/5bHX7xE3QdLZBEiYI1mb0RznXRfE036jXET7w==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:eafa:b5d9:dc1:d7b1])
 (user=suleiman job=sendgmr) by 2002:a25:7c4:0:b0:e8b:bb01:55c with SMTP id
 3f1490d57ef6-e8daef370d6mr756276.4.1753163439418; Mon, 21 Jul 2025 22:50:39
 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:50:27 +0900
Message-Id: <20250722055030.3126772-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Subject: [PATCH v8 0/3] KVM: x86: Include host suspended time in steal time
From: Suleiman Souhlal <suleiman@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	John Stultz <jstultz@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssouhlal@freebsd.org, Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"

This series makes it so that the time that the host is suspended is
included in guests' steal time.

When the host resumes from a suspend, the guest thinks any task
that was running during the suspend ran for a long time, even though
the effective run time was much shorter, which can end up having
negative effects with scheduling.

To mitigate this issue, include the time that the host was
suspended in steal time, if the guest requests it, which lets the
guest subtract the duration from the tasks' runtime. Add new ABI 
to make this behavior opt-in per-guest.

In addition, make the guest TSC behavior consistent whether the
host TSC went backwards or not.

v8:
- Avoid #ifdef in function body.

v7: https://lore.kernel.org/lkml/20250714033649.4024311-1-suleiman@google.com/
- Fix build.
- Make advancing TSC dependent on X86_64.

v6: https://lore.kernel.org/kvm/20250709070450.473297-1-suleiman@google.com/
- Use true/false for bools.
- Indentation.
- Remove superfluous flag. 
- Use atomic operations for accumulating suspend duration.
- Reuse generic vcpu block/kick infrastructure instead of rolling our own.
- Add ABI to make the behavior opt-in per-guest.
- Add command line parameter to make guest use this.
- Reword commit messages in imperative mood.

v5: https://lore.kernel.org/kvm/20250325041350.1728373-1-suleiman@google.com/
- Fix grammar mistakes in commit message.

v4: https://lore.kernel.org/kvm/20250221053927.486476-1-suleiman@google.com/
- Advance guest TSC on suspends where host TSC goes backwards.
- Block vCPUs from running until resume notifier.
- Move suspend duration accounting out of machine-independent kvm to
  x86.
- Merge code and documentation patches.
- Reworded documentation.

v3: https://lore.kernel.org/kvm/20250107042202.2554063-1-suleiman@google.com/
- Use PM notifier instead of syscore ops (kvm_suspend()/kvm_resume()),
  because the latter doesn't get called on shallow suspend.
- Don't call function under UACCESS.
- Whitespace.

v2: https://lore.kernel.org/kvm/20240820043543.837914-1-suleiman@google.com/
- Accumulate suspend time at machine-independent kvm layer and track per-VCPU
  instead of per-VM.
- Document changes.

v1: https://lore.kernel.org/kvm/20240710074410.770409-1-suleiman@google.com/

Suleiman Souhlal (3):
  KVM: x86: Advance guest TSC after deep suspend.
  KVM: x86: Include host suspended duration in steal time
  KVM: x86: Add "suspendsteal" cmdline to request host to add suspend
    duration in steal time

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/virt/kvm/x86/cpuid.rst          |   4 +
 Documentation/virt/kvm/x86/msr.rst            |  14 ++
 arch/x86/include/asm/kvm_host.h               |   6 +
 arch/x86/include/uapi/asm/kvm_para.h          |   2 +
 arch/x86/kernel/kvm.c                         |  15 ++
 arch/x86/kvm/cpuid.c                          |   4 +-
 arch/x86/kvm/x86.c                            | 129 +++++++++++++++++-
 8 files changed, 172 insertions(+), 7 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


