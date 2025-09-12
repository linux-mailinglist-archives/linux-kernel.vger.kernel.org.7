Return-Path: <linux-kernel+bounces-814364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B16B552F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E711D631B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654CA31691E;
	Fri, 12 Sep 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqWRkA2f"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F93074B2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689906; cv=none; b=u83Viy4dPTEAlVLc77E/+a/Lpsjfus+N39delnmC3ivld4lXYV+A7DkBnQMiR/6Bwt4tGxRhmwGZxie7N1ZaxaZKFOBT3Qn8gcLLO8PchCfD+VqE1kirLoJ99uyDoi/BOk+lzbAEKkV30MMg/7bVMbcvSaTIiCO2xLzDFrXLJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689906; c=relaxed/simple;
	bh=/3gCpeZvyALXyb49v+t2MCuGLdInV16VACCDc9ueEPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ed/pdhU4SFVI6PMO2t2a+KcTpkePhk56AloH9xWQKOqqswVklJpZsLQVbsu0zeDlagpU1iOHfkQ8eFYoD8lPqosNmlIAXutxHceVVSqwWI9sx/8OUeMosgdXnYKi2/cS5dS2kEQgxA5mFm/VCkrb5qF8mIdSMu3ALCeyFxdEsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqWRkA2f; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7725c995dd0so2033800b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757689904; x=1758294704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtAEJvpBzH3IL6bBPgbi4ME1ppTlvu2vLcH5yGtgfeQ=;
        b=pqWRkA2ftY+XBkUmSqg+C4UFBW47bh/dym+qyI66SR8njh5zfkdzEK+k3D1HBr2QzH
         zLlmI/NZ2E4m6tC/LmJ4RXZQaQloGUFdkV2fJVs2cSvux7h4gVcjL3KbZ+2OgU8CAJ85
         DWQBeI48iT2KFTM3ySRgjoG0F22W5Yw3LuSGmRpsY8ToEkf89fKMoeb6ukNq7ZsEVwt6
         W/leRM9YCvKGdsdOqSVs5MhKLPRh1gWjmZQQB56Wl4C2CyV0q8U2IiP0SAOpzKLNMt3d
         /S7qivEbK4EbcpPqXrdsCvLt/IeiRe20NmYqfT+XtmMSVKTrkO/QCMBOpMBwrGuB1KVN
         lWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689904; x=1758294704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtAEJvpBzH3IL6bBPgbi4ME1ppTlvu2vLcH5yGtgfeQ=;
        b=bIubQuaiXgTddqg8GC4QWBHn+Qs0GZUtsKt3DY5e/tcFkiRRRmd+Ku5Li6beD31E6c
         5amgMHsQYNAtjTVPfgZ9ZahEqg22OfAZE1JI9VSS+EhS8Lvxos/i5D/zR5BUo/mciDOX
         UmIOTiicXHlt5IaW5Ebr/adD2aHFTBWii6HRG9Er6Xi5c7M2vpZsBsR++wXqmkw8PK2y
         qsy8N+tA3kgVA+luyE5RSivG3bcS83UCFfeVshcxjBnMeHNFGusY73HATNRY7J/Vwipr
         NAOSvsUfpHsDcYC0PzzE3E7AGq1rIcd+WHuZC0mExmDldcVQ9W6hhYs5+FKhsEOE+c4C
         1ciQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrxt1n5Y7E1qyeOJaFUp6f9WhYWJcERkT60+17xmy9RhDfwjY/mDyLzwV7b9owNP4YmeYJWLesggScb8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrxGha0AZoa3eZouKh3fKMHHxouc4RfzW6zSQmwZ3ieW2fwm9
	+LqLk4T0jMBk5YnepmJ7cFYW3Jg8iyopXC/NClYqGSrk9hTAaLY1ZPuiEE4ues9vFonMzx0d2vW
	cTOBcSw==
X-Google-Smtp-Source: AGHT+IExDf4Hm9e+gxmVeEBhOJXsTG3yJdXK2jK1LeL/ndvbJnwidrzCmKrD8PIcD3SV+UxYRZYOyP/z7IY=
X-Received: from pfbky2.prod.google.com ([2002:a05:6a00:6f42:b0:772:4ff1:1e21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1586:b0:24c:af7e:e55
 with SMTP id adf61e73a8af0-2602a593825mr3869382637.10.1757689904299; Fri, 12
 Sep 2025 08:11:44 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:11:43 -0700
In-Reply-To: <aMQwH8UZQoU90LBr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-16-chao.gao@intel.com>
 <8121026d-aede-4f78-a081-b81186b96e9b@intel.com> <aMKniY+GguBPe8tK@intel.com>
 <ac7eb055-a3a2-479c-8d21-4ebc262be93b@intel.com> <aMQwH8UZQoU90LBr@google.com>
Message-ID: <aMQ4L8id7f1fK16J@google.com>
Subject: Re: [PATCH v14 15/22] KVM: x86: Don't emulate instructions guarded by CET
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acme@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	john.allen@amd.com, mingo@kernel.org, mingo@redhat.com, 
	minipli@grsecurity.net, mlevitsk@redhat.com, namhyung@kernel.org, 
	pbonzini@redhat.com, prsampat@amd.com, rick.p.edgecombe@intel.com, 
	shuah@kernel.org, tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, 
	xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 12, 2025, Sean Christopherson wrote:
> On Fri, Sep 12, 2025, Xiaoyao Li wrote:
> > On 9/11/2025 6:42 PM, Chao Gao wrote:
> > > (and thus complex). The reason is that no one had a strong opinion on whether
> > > to do the CPL check or not. I asked the same question before [*], but I don't
> > > have a strong opinion on this either.
> > 
> > I'm OK with it.
> 
> I have a strong opinion.  :-)
> 
> KVM must NOT check CPL, because inter-privilege level transfers could trigger
> CET emulation and both levels.  E.g. a FAR CALL will be affected by both shadow
> stacks and IBT at the target privilege level.
> 
> So this need more than just a changelog blurb, it needs a comment.  The code
> can also be cleaned up and optimized.  Reading CR4 and two MSRs (via indirect
> calls, i.e. potential retpolines) is wasteful for the vast majority of instructions,
> and gathering "stop emulation" into a local variable when a positive test is fatal
> is pointless.
> 
> 	/*
> 	 * Reject emulation if KVM might need to emulate shadow stack updates
> 	 * and/or indirect branch tracking enforcement, which the emulator
> 	 * doesn't support.  Deliberately don't check CPL as inter-privilege
> 	 * level transfers can trigger emulation at both privilege levels, and
> 	 * the expectation is that the guest will not require emulation of any
> 	 * CET-affected instructions at any privilege level.
> 	 */
> 	if (opcode.flags & (ShadowStack | IndirBrnTrk) &&
> 	    ctxt->ops->get_cr(ctxt, 4) & X86_CR4_CET) {
> 		u64 u_cet, s_cet;
> 
> 		if (ctxt->ops->get_msr(ctxt, MSR_IA32_U_CET, &u_cet) ||
> 		    ctxt->ops->get_msr(ctxt, MSR_IA32_S_CET, &s_cet))
> 			return EMULATION_FAILED;
> 
> 		if ((u_cet | s_cet) & CET_SHSTK_EN && opcode.flags & ShadowStack)
> 			  return EMULATION_FAILED;
> 
> 		if ((u_cet | s_cet) & CET_ENDBR_EN && opcode.flags & IndirBrnTrk)
> 			  return EMULATION_FAILED;
> 	}

On second thought, I think it's worth doing the CPL checks.  Explaining why KVM
doesn't bother with checking privilege level is more work than just writing the
code.

	/*
	 * Reject emulation if KVM might need to emulate shadow stack updates
	 * and/or indirect branch tracking enforcement, which the emulator
	 * doesn't support.
	 */
	if (opcode.flags & (ShadowStack | IndirBrnTrk) &&
	    ctxt->ops->get_cr(ctxt, 4) & X86_CR4_CET) {
		u64 u_cet = 0, s_cet = 0;

		/*
		 * Check both User and Supervisor on far transfers as inter-
		 * privilege level transfers are impacted by CET at the target
		 * privilege levels, and that is not known at this time.  The
	 	 * the expectation is that the guest will not require emulation
		 * of any CET-affected instructions at any privilege level.
		 */
		if (!(opcode.flags & NearBranch)) {
			u_cet = s_cet = CET_SHSTK_EN | CET_ENDBR_EN;
		} else if (ctxt->ops->cpl(ctxt) == 3) {
			u_cet = CET_SHSTK_EN | CET_ENDBR_EN;
		} else {
			s_cet = CET_SHSTK_EN | CET_ENDBR_EN;
		}

		if ((u_cet && ctxt->ops->get_msr(ctxt, MSR_IA32_U_CET, &u_cet)) ||
		    (s_cet && ctxt->ops->get_msr(ctxt, MSR_IA32_S_CET, &s_cet)))
			return EMULATION_FAILED;

		if ((u_cet | s_cet) & CET_SHSTK_EN && opcode.flags & ShadowStack)
			  return EMULATION_FAILED;

		if ((u_cet | s_cet) & CET_ENDBR_EN && opcode.flags & IndirBrnTrk)
			  return EMULATION_FAILED;
	}

Side topic, has anyone actually tested that this works?  I.e. that attempts to
emulate CET-affected instructions result in emulation failure?  I'd love to have
a selftest for this (hint, hint), but presumably writing one is non-trivial due
to the need to get the selftest compiled with the necessary annotations, setup,
and whatnot.

