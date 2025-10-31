Return-Path: <linux-kernel+bounces-880737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366AC266E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94945646B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48D31BC96;
	Fri, 31 Oct 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsMSgnyf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4030DD01
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932185; cv=none; b=Ag+m2h1AtadVCLBviezIqSrB/N9MZJCtTv3gIxezjp1kdq++evvjG0fDD43pwDB2g8tY24tAOAKL4yrj3U9oE9tWFrWUumf8z6YuO+4P5HNAJMkuvnRFNvsgFkenLFIfGPlSbSh3Med0pL+3DW8Zein5QONBIFE+qd+tCnsbJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932185; c=relaxed/simple;
	bh=wUmtHEk1Kb8QxeKkuMpwMU+pOoW2GV8Wfxxk4HiDohA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NCBWtvXTDoodAG+snxuvgZ9rxeCo0xj5BCvF1oo+C87fG4aGTLVSmennKheSAj8U9sKOyBEZJ45cQTUKf94UobmR6FxRgp8WOZncvrsRYJiECWnwG7so7zoLD/rBBKnRB6Xmsp+IgUuDOtfp6UnWijS2gYKUbs4YZt4t2Hkdm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsMSgnyf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3408686190eso2411504a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761932183; x=1762536983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oS0ZpZF16YCRh48Rs9UtzBxLRJbtN+FTBVVUS4s8+a8=;
        b=qsMSgnyfRor2UE/nFoK1IhQ/pruLpfOVdRerunVFws8PttxqDYTcp4SDPCcKA6Grqi
         KTYABmb1172VlIj1cQis4lyyKHcuDUrm2P5suk4xYcVQJDkHE1sDFIduSOlqEtVcTrhY
         Dedw9M309cema+aK9fPmn0RSrM/at0j/W7eKXs+NzqywNBznl9Ou+vSJOq/39BuUMT2B
         vcUNY/GCkdKQFNAGzT/FFzyOTOPGdLdWARbPLr/9INFcsrj88AOzbHnr596jw7E+qvpZ
         a7iM5GuvhEptgidX8fgIIL0+OxjHktTTjYszAGwoSdwRR4I2YmfE62Xbde7SFU6oE7+q
         C0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932183; x=1762536983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oS0ZpZF16YCRh48Rs9UtzBxLRJbtN+FTBVVUS4s8+a8=;
        b=VZV9eJY6QLfhXd9EnuDtzrpK3rZFKiYYutgauuwnbsFn9j+osVjgnGAjUYclViX3nH
         iLdrnyt0vyQWB6pgSMSoXaL2Uo+twTHcXJoHTnQnfV3ETY6UuJJlw2QGINSfn7VKOFOe
         qhtYHpUyiJTKdMK+0qWBrHd4wbD/cwBL0wuFpKGg40gR+FLYqIHcSHOBwafean77QGSx
         LdCX07AXAuBgtb9eC5dao71Lfvn8sW4By8S3A1tH23K7GFes8FUvhWT4/l31yEpWEYD2
         n5Xpb+YUF3I52utejArjqiYoau9rCeDpih2xOBupEG2+tB9IdlNRxfwzlRNatox8wL6n
         WXjg==
X-Forwarded-Encrypted: i=1; AJvYcCVFO93HjvkflIylHuf0BIFP0uBa2PyWj0wfkkqTT+6uzZaeLQlcv4YRcWjktntyxpZQbS4C01fzdpVaRZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw697FAEDXCLuRc5P5WH9n+AB0JpeYi8CCwGrwHjcodcEsotxUr
	b2f4B26M4Kaj6KNzfE8SoW2VRl0heEI+iQP3iokkRkt0o2TLAL7kBl2y3qVOh3KCu6ilQHEw2KD
	6vkSmIw==
X-Google-Smtp-Source: AGHT+IGwWg806+ynAXsdzVM9jfhS677Oh5vXzRS9qR3coFaO6PIQH8mB/qMPv1Z4pIKbcAcNDhRMXaUHW+Q=
X-Received: from pjhu60.prod.google.com ([2002:a17:90a:51c2:b0:340:7740:281c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fd0:b0:340:6b5e:7578
 with SMTP id 98e67ed59e1d1-34082fc645amr5860376a91.4.1761932183557; Fri, 31
 Oct 2025 10:36:23 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:36:22 -0700
In-Reply-To: <DDWGVW5SJQ4S.3KBFOQPJQWLLK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <DDWGVW5SJQ4S.3KBFOQPJQWLLK@google.com>
Message-ID: <aQTzlivZDrT_tZRL@google.com>
Subject: Re: [PATCH v4 0/8] x86/bugs: KVM: L1TF and MMIO Stale Data cleanups
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Brendan Jackman wrote:
> On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
> > This is a combination of Brendan's work to unify the L1TF L1D flushing
> > mitigation, and Pawan's work to bring some sanity to the mitigations that
> > clear CPU buffers, with a bunch of glue code and some polishing from me.
> >
> > The "v4" is relative to the L1TF series.  I smushed the two series together
> > as Pawan's idea to clear CPU buffers for MMIO in vmenter.S obviated the need
> > for a separate cleanup/fix to have vmx_l1d_flush() return true/false, and
> > handling the series separately would have been a lot of work+churn for no
> > real benefit.
> >
> > TL;DR:
> >
> >  - Unify L1TF flushing under per-CPU variable
> >  - Bury L1TF L1D flushing under CONFIG_CPU_MITIGATIONS=y
> >  - Move MMIO Stale Data into asm, and do VERW at most once per VM-Enter
> >
> > To allow VMX to use ALTERNATIVE_2 to select slightly different flows for doing
> > VERW, tweak the low lever macros in nospec-branch.h to define the instruction
> > sequence, and then wrap it with __stringify() as needed.
> >
> > The non-VMX code is lightly tested (but there's far less chance for breakage
> > there).  For the VMX code, I verified it does what I want (which may or may
> > not be correct :-D) by hacking the code to force/clear various mitigations, and
> > using ud2 to confirm the right path got selected.
> 
> FWIW [0] offers a way to check end-to-end that an L1TF exploit is broken
> by the mitigation. It's a bit of a long-winded way to achieve that and I
> guess L1TF is anyway the easy case here, but I couldn't resist promoting
> it.

Yeah, it's on my radar, but it'll be a while before I have the bandwidth to dig
through something that involved (though I _am_ excited to have a way to actually
test mitigations).

