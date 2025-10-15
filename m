Return-Path: <linux-kernel+bounces-855072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B8BE0288
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9E03B0445
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F9320CD6;
	Wed, 15 Oct 2025 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4Aedjg+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2130146E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552428; cv=none; b=DTEasZbXp5qEV3rBW01xypW2XRmzam/QrBOORDxOFfm32UWJPXm/BaEzrbkqxsjZYV0ZMmMM/msCYi9FbCE2/ho86Sg8lEmLK40sQKDdGm+5klbqzNptZSPkcNYufkXPX1iU2j/r9nNaW6Dm0wrSWMK06XLfmC8LdQ+Y0TuJSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552428; c=relaxed/simple;
	bh=ZTRP9aidWgr1XQsPeu9rQxOAW1CPWm5zWDm0NCuiGcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9GB0wf20KZ59ot0Z1Km2Xyrfw/Gr+SE3/Y+Le/Sa70Lyv9zMBB/RNrcslwKhK+BI3fztBRk9hi+is+pNNB1+bExfVERj6WPahxq26nez3nbIGlah7zJUcp47KViGFOGS5CY6tx2JMiMqPlc5fYinoBq+65083WnEIMFvqEIaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4Aedjg+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26e4fcc744dso70452495ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760552426; x=1761157226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm2q3p/G/86TMJQ0UXhWohiyyo84AMOuAmIGH7SevLc=;
        b=g4Aedjg+CVCwYycLzaGpTsy313vFPLL/vx5AD2SZkwkaVPH5x4sMCq+7CussWeQEJx
         nRs7Ond4C/0flgXU2g4Yr1rIl90gauiH3gnLm9crqTiwD9y2ww2pAnUrnjDNcTy7Z0m/
         qCD60Z1dm+/gYw0TsEb/OdAqv3J+OM4dJBy3TGiwcgUMBdHY8EQtt4j8NSPDrc61u6gc
         djitZHM01PzrY9ziri2JWacbHxYB+Cw+CWAHxtXBZhWTflhA03iIslFRBcWQS6z7ZkLi
         Qcyh1ak6Ra9y0sFsEEEbOcb8iKedVZIYfkcLpJgJahD6wLlC5JT2o1JWzKPXES1Q5lRt
         uG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552426; x=1761157226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm2q3p/G/86TMJQ0UXhWohiyyo84AMOuAmIGH7SevLc=;
        b=gGPta1E15lX0bFboI63HdT204F4RA4v2iQFNnMVp6DFp+aiFO6ip0oHv38iRpzxuse
         M3QUm4T99YWEnot4fUd8Yn0M1NBHMXvS/GvJNWIXAaATO/BPUF2Ks179bGtULgI6v7fp
         JoGPUcgl1/anTDzVgUfAHD4+Y14eupK44qR4h1d5DfrzCyRp0SBzGnG7dHhW1tb7sXBX
         kSWy7Rd3GdMO+LAXm00wYqhVd+2PQM9WmPhQB5crEEqs7XgaKY1lXWePwcgYHF8w2EGL
         zdqVhVjrL71NTJVUcby8h/g0rFyKnQPhtH+9+Pwl76voYzrYNxrkBYlfzY5okTFY13eJ
         V7AA==
X-Forwarded-Encrypted: i=1; AJvYcCWJJLqE8ooSgR/A84xaUevXKNDQS/cpgjxGbyz8peKIvDsZVMqD1xt2dYrxusn1KP1xg5Vhz4kP9XHpmKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+p+ONpvWxPs5zK3n93HM4W3AyMAByPoOQvZqAcZT+JKmikZw
	CIN7rZ4Ggi+WVu0WYMTZxO4wklwQs60kWBwUBhqo8k4vf0CC6F65zOkGFnbirX6B/vZyL61XZwt
	ftI04uQ==
X-Google-Smtp-Source: AGHT+IFuFSk4cvbHdrDx28qaVvce7wGZr15IJJsxRgFqTzm4tTCvYyw49lkSfjVTyJerehUI3lHDmVOvZ10=
X-Received: from pjre17.prod.google.com ([2002:a17:90a:b391:b0:33b:51fe:1a89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae3:b0:28e:756c:707e
 with SMTP id d9443c01a7336-290272b5610mr329240465ad.33.1760552425994; Wed, 15
 Oct 2025 11:20:25 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:20:21 -0700
In-Reply-To: <zfhwufkxrv4uqibspjstsqruuz5mgd4t765c3cobh374bmfqwy@welriubpwp6t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev>
 <20251001145816.1414855-9-yosry.ahmed@linux.dev> <aO1yJHcKC85mo0PQ@google.com>
 <ivkoh7hdl7fcp5fmehmf3kv6ebqitozunbricyed5tkt7z3ngr@qvmaytpzrskw>
 <aO2EFiOHSuvmHvq_@google.com> <zfhwufkxrv4uqibspjstsqruuz5mgd4t765c3cobh374bmfqwy@welriubpwp6t>
Message-ID: <aO_l5TwbOv2F5E7n@google.com>
Subject: Re: [PATCH 08/12] KVM: selftests: Use 'leaf' instead of hugepage to
 describe EPT entries
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Yosry Ahmed wrote:
> On Mon, Oct 13, 2025 at 03:58:30PM -0700, Sean Christopherson wrote:
> > Ah, right, current_level can never be less than target_level because the first
> > assert will fail on iteration-1.
> > 
> > > the assertion here is when we try to override a leaf page table IIUC.
> > >
> > > > Instead of hacking on the nested code, can we instead tweak __virt_pg_map() to
> > > > work with nested TDP?  At a glance, it's already quite close, e.g. "just" needs
> > > > to be taught about EPT RWX bits and allow the call to pass in the root pointer.
> > > 
> > > That would be ideal, I'll take a look. In case I don't have time for
> > > that unification, can this be a follow-up change?
> > 
> > Part of me wants to be nice and say "yes", but most of me wants to say "no".
> 
> So.. which part won?
> 
> > 
> > Struct overlays for PTEs suck.  At best, they generate poor code and obfuscate
> > simple logic (e.g. vm->page_size vs pte->page_size is a confusion that simply
> > should not be possible).  At worst, they lead to hard-to-debug issues like the
> > one that led to commit f18b4aebe107 ("kvm: selftests: do not use bitfields larger
> > than 32-bits for PTEs").
> > 
> > eptPageTableEntry obviously isn't your fault, but nptPageTableEntry is. :-D
> > And I suspect the hardest part of unificiation will be adding the globals to
> > deal with variable bit positions that are currently being handled by the struct
> > overlays.
> 
> I have no problem getting rid of eptPageTableEntry and using bitmasks
> and whatnot on a uint64_t PTE (assuming that's what you are asking for
> here).
> 
> But I think tweaking __virt_pg_map() will involve more than that, or
> maybe I just didn't look close enough yet.

For posterity, Yosry and I chatted off-list.  The plan is to try and convert
__virt_pg_map() to work with variable "mmu", using an approach similar to KVM,
where the bit positions of variable flags, e.g. NX vs. X, are stored in an mmu
structure.  If for whatever reason converting __virt_pg_map() is meaningfully
harder than getting nEPT and nNPT to play nice, then we'll revisit all of this.

