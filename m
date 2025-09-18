Return-Path: <linux-kernel+bounces-823411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC876B8658B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0CC581B13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129128A3EF;
	Thu, 18 Sep 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xW4saHmP"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABC26561E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218531; cv=none; b=a7QjQXVZDETtpfyOeX7Cnc1NzKmTSoq8tPJknuUroUFy51Xoc3vgQh/KEcv3pjk7/T29M8ClG0CCqAZhGotJ4xILdE5NkK5L0vAjdguzB5uMT+DHpeXhVZu4iZlhnOOUNaHqY9dp8k8UTWOr+MjzCUg/wspgBwE76wu5ONBmF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218531; c=relaxed/simple;
	bh=ZGciZ+l/QtdGz24re+p9zScgO4arIzo1SOq4dRyNJ9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNvneC/Mv8uliqSs6Hgh0Xyoe/rC+O6pj/9pkm2D3yTCcd6Psq3yedj5F3PwExMaBV1vkE49PdEFGmessM/6MMQEFfNKwcBBy/eQh+azkxOzzBCQxHZ/3RedLfn/c7rqf+bEwNHjZIG5DU6sy6l6XF29vchrZAqasYOaRujMV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xW4saHmP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54d6a67b5fso986762a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758218530; x=1758823330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBtoHOheMhSmhxBi9V5MzvKfJ/0TEvhIvdd+37FBzLA=;
        b=xW4saHmP9X70QaeflUzGWIxJo8Yp9u9N7COx3ytj+ddnITRFo4YtEf/qQQx0NOKwfb
         /LZRHDWcqtA2r7rlUnSFmAy3cbE0MDaZ1vF/q3zU1X0DWSOy+O/Sj7MhCtNg3uMPLNi3
         XveDxeqc20j5bGy1FoVMpE8xIdSLy6tJgtOoReXmCgvaNpDrt0zZOgz+40XIiuPlqR7O
         SQXSn3Gpao+o/JRpPJ3QnlnGE/yTEiIuyFw6C2qOXO4clt6SP1vwOPfrJoRQMxp3lBXL
         lZZrvXqMIh8Slz5rTEU9sIhb9AIrtXNg6g0kjEHPjKpv8TMJPa9HYdehDkclr3GWy3eu
         22RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218530; x=1758823330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBtoHOheMhSmhxBi9V5MzvKfJ/0TEvhIvdd+37FBzLA=;
        b=NgGdfFVmHmuXWWhHbzDjdfoSMBnyfbGaou1yrIfBh17aQ6peijZwH0m1enHxnyQdiZ
         yauj6m1SBVsOtu/vEsr/G/SwASbhC68fyWJaV/5UK+UDGcWD7jNwVxugSJHT+Iaf503L
         NLiNYZBvUQWHmIQ18csC/UEEs0S+eif0mpB4LmK9hiYHmCusnYA0O9KppxkAWsfMqVVH
         br6mn8O63rKSbTJI2m4/ylDtP5oSgPqMnIwQmW/RWxD5xOVKlpC+dh1y0IH+FF1i28U+
         mpr0OMeDRFdI62uIpcBt9GdVPk4yeaquApUFURkmnvlcK+psAl2Y3HWDLXhPJPJuiD+T
         sI5A==
X-Forwarded-Encrypted: i=1; AJvYcCX8KW8CJ//Cyplsd7lSKWtqzVXYQIW1ldCtRalKCVy7a3cZH1lDzX02hAdbqf76MgjQSg07CZMcr0iK/sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX39FIxkp5K7d47dTQEEEqUDC4Zm9nCaH1C9lfYQtZm/IpH8Ch
	6CqbQjuHVq/fd0aYAAXxuBcaFo/YF6f4YMPN3YJZol4Ofik8XKWcVuy287F4QQkcVGheh022sDe
	u+jplZg==
X-Google-Smtp-Source: AGHT+IFxs6MLvqTu9oPFf3IVDb5RN5uGurmGNk5fdp1jbay9WUlTOC6aYgKe6oFaXMDqKMHHDagQfSb5d9k=
X-Received: from pjbqi4.prod.google.com ([2002:a17:90b:2744:b0:327:50fa:eff9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54d0:b0:32e:3837:284e
 with SMTP id 98e67ed59e1d1-33097ff70ebmr345054a91.10.1758218529651; Thu, 18
 Sep 2025 11:02:09 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:02:08 -0700
In-Reply-To: <aMwdNTCYak/1wwS0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-19-seanjc@google.com>
 <aMpuaVeaVQr3ajvB@intel.com> <aMsk43I7UkGbmL88@google.com> <aMwdNTCYak/1wwS0@intel.com>
Message-ID: <aMxJIBcow64ES5ca@google.com>
Subject: Re: [PATCH v15 18/41] KVM: x86: Don't emulate instructions affected
 by CET features
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Chao Gao wrote:
> >> --- a/arch/x86/kvm/emulate.c
> >> +++ b/arch/x86/kvm/emulate.c
> >> @@ -4326,8 +4326,8 @@ static const struct opcode opcode_table[256] = {
> >> 	X8(I(DstReg | SrcImm64 | Mov, em_mov)),
> >> 	/* 0xC0 - 0xC7 */
> >> 	G(ByteOp | Src2ImmByte, group2), G(Src2ImmByte, group2),
> >> -	I(ImplicitOps | NearBranch | SrcImmU16 | IsBranch, em_ret_near_imm),
> >> -	I(ImplicitOps | NearBranch | IsBranch, em_ret),
> >> +	I(ImplicitOps | NearBranch | SrcImmU16 | IsBranch | ShadowStack, em_ret_near_imm),
> >> +	I(ImplicitOps | NearBranch | IsBranch | ShadowStack, em_ret),
> >
> >Tangentially directly related to this bug, I think we should manual annotation
> >where possible.  I don't see an easy way to do that for ShadowStack, but for IBT
> >we can use IsBranch, NearBranch and the SrcXXX operance to detect IBT-affected
> >instructions.  It's obviously more complex, but programmatically detecting
> >indirect branches should be less error prone.  I'll do so in the next version.
> >
> >> 	I(DstReg | SrcMemFAddr | ModRM | No64 | Src2ES, em_lseg),
> >> 	I(DstReg | SrcMemFAddr | ModRM | No64 | Src2DS, em_lseg),
> >> 	G(ByteOp, group11), G(0, group11),
> >> 
> >> 
> >> And for reference, below are the changes I made to KUT's cet.c
> >
> >I now have a more comprehensive set of testcases, and it can be upstreamed
> >(relies on KVM's default behavior of injecting #UD at CPL==3 on failed emulation).
> 
> IIUC, for KVM_FEP-prefixed instructions, the emulation type is set to
> EMULTYPE_TRAP_UD_FORCED. Regardless of the CPL and
> KVM_CAP_EXIT_ON_EMULATION_FAILURE, KVM will always inject #UD on failed
> emulation.
> 
> 		r = x86_decode_emulated_instruction(vcpu, emulation_type,
> 						    insn, insn_len);
> 		if (r != EMULATION_OK)  {
> 			if ((emulation_type & EMULTYPE_TRAP_UD) ||
> 			    (emulation_type & EMULTYPE_TRAP_UD_FORCED)) {
> 				kvm_queue_exception(vcpu, UD_VECTOR);
> 				return 1;
> 			}

Oh, right.  Nice, that makes the KUT testcase much less hacky :-)

