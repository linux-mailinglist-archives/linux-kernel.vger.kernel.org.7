Return-Path: <linux-kernel+bounces-729326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2EB034FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509543B06EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82A1F37A1;
	Mon, 14 Jul 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9tB4nOY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C5CA6B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464233; cv=none; b=GloqpYQOn77rVeeFYeH4EZuweS7V0V88uEb59vxUTCWnHWsjW3OHxET1W1NN0zCjOnTmiHTwmRDWDUU5EWpYGeLM7H16Z5QTArAeNFyo6KZKE7y4xMaqtiga2LCYfdiNmFCtBQO5s39jRGU5FQ06L1h38c3usjtGO28OMFw1wBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464233; c=relaxed/simple;
	bh=OfpS65Wq2l4GZk7q+sltE7YIrOp6kC70YtIkuTw8Aj4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=PEbENxn2YVZ9mbnaKXR+CXFXtZ0bVij2/IjXJJgi7HxOSTTXAXHIvm1bCCGetPfldZ3XEOAck4HqNCSlQ5ZD56pu+mhJzTZcwVS63X0OIrofCHGBkW1mHisJHrwgQFEqoERguMzBRIqQuowr/ySh6/YyDsuhQcxlSQTXZOjUHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9tB4nOY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-714078014b8so60477437b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752464231; x=1753069031; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=su7BCsoBhxlfoX9vtVyWNsaDnFW5ssEpsTKkRCgbFY4=;
        b=Q9tB4nOYAW8TgKr3ktqgqNLOt3pEtK1Ynq2Qqmj8lzM1UO+ivZZNWRZOQJJbDOV6Ni
         QvmL/rDUfYwklEAqHp1NfBCUPA3r+9JEcTS8oaeVEJ6omRq0+tEaVREENK92EAP158z5
         ZQgk6kK2DO2ggVqn5/BwZfQtkYuxmO+5OYwX3Kuqa9naUI+7WCkBkcwSdKxKVDmY+SGp
         Vi6TLVmL1TGtFoxKPINCofCglDNZFpGYB1YAQRrOQAMihVZ0DbJlPPKoAzSDs06vPQ55
         JFjd8Xlg3wyYXPTCS34D42Xr28BPailkq7YUvcgdZAmT22uowMzH7kUzlN+D0gWXm8iD
         e6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752464231; x=1753069031;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=su7BCsoBhxlfoX9vtVyWNsaDnFW5ssEpsTKkRCgbFY4=;
        b=JlnFvM5PbxVBibcY3Fm3QIUN0BAqvpg1VD/XnIIXS/C5MM0Toh5ri28vsqiALlITtL
         xwJTedgWJyB/nS7FsXfpJH6lb1pHogId8JXkj9r2qvWDIYgmJDCbZNUrbwPuX7I9J9/t
         mDK8DAGiB6/C0q1QSUCkkvTzFid8eTfKbBXjNLphtvaYUp8NX5OlnAsNdauW+J8AFflb
         xsqhz1/kToOX74sQee4rT17AaMuFiLUiaxNpX746WkS6S+T9zpfqgQwTcLJw/52Ei4hL
         Q7cVLhAfl8sWJqoo8hIlkdV1Ui/aVqmaB9TWHZ7lSqPhfXuYRrx0k1rQu8YzmrL8G0KD
         +2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa1ifzSLNBxp7Y06Ac0Y/9L8NTP4MXFsseONk/+qOZOKwqsUq9QO8KsYSkPXxNzJ5DAcq3BVkYOQU/VhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3DJ6TEj/PMUNtx56xI20rfSO5Zb1gKJcJbyQ+vssjQZG0XQq
	zNk/OeW9vDvJlsMLfTbjvGndN7pk1ZM+Mpny58Ttwo2sJBxWKMFDoQmln+iCdGFbUqTdnEdZvY1
	J2PB5eYpFTx5XDg==
X-Google-Smtp-Source: AGHT+IGnQksW0zPWdjhkjwOREfIiyIqVZ2bVZfTEIzZnRt/TAh/MLlgY8SmTZvmAkNa4/iIaySpxP5ExwXSsmw==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:4f90:1ee3:198b:1fe4])
 (user=suleiman job=sendgmr) by 2002:a05:690c:8682:20b0:712:c55c:4e6e with
 SMTP id 00721157ae682-717d5925b6bmr20447b3.0.1752464230093; Sun, 13 Jul 2025
 20:37:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:36:46 +0900
Message-Id: <20250714033649.4024311-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Subject: [PATCH v7 0/3] KVM: x86: Include host suspended time in steal time
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

v7:
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
 Documentation/virt/kvm/x86/msr.rst            |  14 +++
 arch/x86/include/asm/kvm_host.h               |   6 +
 arch/x86/include/uapi/asm/kvm_para.h          |   2 +
 arch/x86/kernel/kvm.c                         |  15 +++
 arch/x86/kvm/cpuid.c                          |   4 +-
 arch/x86/kvm/x86.c                            | 112 +++++++++++++++++-
 8 files changed, 156 insertions(+), 6 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


