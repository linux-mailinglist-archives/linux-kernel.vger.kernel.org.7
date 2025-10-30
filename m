Return-Path: <linux-kernel+bounces-878953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B40C21D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF190402BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DF36E351;
	Thu, 30 Oct 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GC2ax02"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192C20013A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850687; cv=none; b=Z2aLvD1z9EVuIHGl6j/rQKxmMBCL8Sjm/srJHwIdwOG7vlJ4BF5ar4/2mKepVRSR4Ab++b1KFO8+VuA9G600qMPXTYBqxvm5WieycKM0a8wCMRWihQE61BLmlqm7B29AHQgKiWnNtALVaC7oCqQb8ybODbIoPEa32k76gBZj23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850687; c=relaxed/simple;
	bh=1ldPacxy7lpN2FFTvlH5HJr3OKosyTZU7xugA7xY/74=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R/2JOXmaVC/+Cs162E6ZtYaIXoWCWBAzafD8fU6oGcBV+i4Imf5TCcIiMtkk4feZXvBpNUq6DinjEfHE3sYJcQ8PXPf+WQRZ2dWsIbGkP8OfF04aVgznUiRMFfRBgj3pekFCGGFkvflx/THUQOBAcVEAAD7/Wq63X5op3jacV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GC2ax02; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-792722e4ebeso1398764b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761850684; x=1762455484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mffRtvPyK2ohMcs5gOIENlcL3RR2rGSXli0PgTsR1yM=;
        b=0GC2ax02v3M4qQvpLmh0KAm1JoJRm8NlYM8oNMFl8191LUSe9sEQk9YvRqcdpMva1m
         Q4Gj0wmPu/Npe+xQ0iG70xYGAD5H1ZaORsuFh2xFEMNnG6ytucLaKZW4xl0/yaDiOs+F
         GeJIICH68zaGhztO1oRGwFy2b6PNq+h7zIDpS3mTxPd/rgU+yjLQp+zXTpfmUx6tvnWE
         l++BA1A3B6W/3fj3NgJXbrG4Nv6CeHDLohjZ1G43nS77WAPiQPbyT6guLdNqab5YJtiA
         cg1lLB5GkjlN6kVU8M+x8krbekn9P6GcJ7KqfnEYswd1UlkaWvB0QVt6/00hn+7n9r8m
         gg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761850684; x=1762455484;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mffRtvPyK2ohMcs5gOIENlcL3RR2rGSXli0PgTsR1yM=;
        b=XKVdj6fkica6OzcTinIenKd3/NQcr2x/o8GipTznwswdB2IUh93sR05OPkesWrCrV+
         gt4h460ZGG7K/7Qe+bQ/jEtEyCzkjzbvG1I5HJLKXml4lxxApeJvg0ggHV6uSCXOMVyO
         93ya/n/73IDmY7PJCUpbZzjHCOJVCM50tBbspOKufJWGwVIkyjsP8GP0TCvjQN5bpbMJ
         fv5NaYuFY4RedhS1W804HwVgqMMIawmreQApNgD1X4jcHpfWNhMafv7imtIiVsGG7xgW
         AoKJgYBAgQAkf33cTZ1+Dw0xfmcVG12Ej90gCmYGElPH+Y/+EiEF7lWcJlEraB+a6IVL
         3AIg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1k8posrU17ZAZNJ/4BaK9w+zyBjiu0ViT0OskI2S7OEIIg4XD72sAL4OkhMAQ5Ui27Kuak4O+qcpTeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tqgsCGKftFxIAzZHvDSCw57iE/xtpgkGbOakHRDQX8ncN681
	VJKLNkyTnVERqoaRwTwKqAnstDeMvFI2CO0gJK2aGR9xHstiyJeCX/Qexl3rx/Jk4a42jLaetLs
	TdXJODw==
X-Google-Smtp-Source: AGHT+IETfkGG2l69qUNqrmL0Zk9TdfHjZDfxqQmlHM933IQU/Cfltl9oAz1PMF0AfqGsmZ1sTDPLnFtBXEU=
X-Received: from pfbfm1.prod.google.com ([2002:a05:6a00:2f81:b0:77f:efc:1431])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1815:b0:780:f6db:b1af
 with SMTP id d2e1a72fcca58-7a7792c5703mr558199b3a.16.1761850683901; Thu, 30
 Oct 2025 11:58:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 11:58:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030185802.3375059-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Fix an FPU+CET splat
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a explosion found via syzkaller+KASAN where KVM attempts to "put" an
FPU without first having loading the FPU.  The underlying problem is the
ugly hack for dealing with INIT being processed during MP_STATE.

KVM needs to ensure the FPU state is resident in memory in order to clear
MPX and CET state.  In most cases, INIT is emulated during KVM_RUN, and so
KVM needs to put the FPU.  But for MP_STATE, the FPU doesn't need to be
loaded, and so isn't.  Except when KVM predicts that the FPU will be
unloaded.  CET enabling updated the "put" path but missed the prediction
logic in MP_STATE.

Rip out the ugly hack and instead do the obvious-in-hindsight thing of
checking if the FPU is loaded (or not).  To retain a sanity check, e.g.
that the FPU is loaded as expected during KVM_RUN, WARN if the FPU being
loaded and the vCPU wanting to run aren't equal.

Sean Christopherson (2):
  KVM: x86: Unload "FPU" state on INIT if and only if its currently
    in-use
  KVM: x86: Harden KVM against imbalanced load/put of guest FPU state

 arch/x86/kvm/x86.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)


base-commit: 4361f5aa8bfcecbab3fc8db987482b9e08115a6a
-- 
2.51.1.930.gacf6e81ea2-goog


