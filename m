Return-Path: <linux-kernel+bounces-739921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF576B0CD21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF763188865A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A21ADC7E;
	Mon, 21 Jul 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0LYCWhDM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4MZo/me"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEF27462
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135349; cv=none; b=smcGPDv/bT+2a6qTX3ooNRsm2hr/NPqkiY56teUVg1cnaXnLkrFxlPFId57AGEoarSR6f1j0quzfrYXZzZqe2XnOuB7FybLdPJf/0pbTyvzgMHMz3PbyB+ceN8VxAEZLcyqGOj6KMtG8yhFbro9aORSCTQXLtGaDSYl4tPk2CcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135349; c=relaxed/simple;
	bh=YMeIkZmer4+3xJmTVnvVyKd6SXR0u2ueUV8eAL2AV3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSPrFuGXTLeNF5IfOQ5G9tvgrKGg9+onxaehP06UPa0XeFAB+t139aW7P4erxugrVZ7gDFkG9bDDsNo9+5eRXJg/742dpyjgBD3JSuIBdbG3cih6iwW78gpgukaOaOP/7nUmRo5zXhA1XqN6GZAHhs3DwdzDh4ZPcPmmAcnnjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0LYCWhDM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4MZo/me; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753135346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lecH/DHbdf10xPfkU6n90c4mfKD+9ymrvYnxqi2BMvU=;
	b=0LYCWhDMM0+Od5R5MVhi08i8mvzlU9uOnU/ICXwQo4kb7UmdzgO412ph3m9Tt8UpQlPEaT
	Es7sE1npO3H+4NN2t2/Nf/536XDZKiKKPGtUJUn60xO+/AieWeE1HELOZLILPAj9dDDP+V
	Mrbo7sdh06pVYGYaTxU7xV4VoCfiWez0j3qSDgq2A025gDWu05GXOfl/OATdFDaQf9Tx6J
	EEV7slxChu5cpY+BhyAPhLlXyzzxDkDfuSSh92vpyRdgW76IuHlRiRZ+52zKUYbgSzBXPD
	144gTdgj0yvss/AlaE83ASlltXip3eR65YH17daQJQyRFX9AA8IIQ38AwcACGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753135346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lecH/DHbdf10xPfkU6n90c4mfKD+9ymrvYnxqi2BMvU=;
	b=m4MZo/medcdM+9AjDUSuGb/oLbJwuUIoPwJGAcFiHlPvvU6XvNSIJ8vLMy3voYF7WHXDsf
	71ausWLwa8eyzEAA==
To: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Address fixups in arch/x86/entry/vdso/vma.c
In-Reply-To: <5a2667c8-bad4-4079-90a2-e387b4472164@zytor.com>
References: <5a2667c8-bad4-4079-90a2-e387b4472164@zytor.com>
Date: Tue, 22 Jul 2025 00:02:25 +0200
Message-ID: <878qkhtd72.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17 2025 at 10:34, H. Peter Anvin wrote:
> One of the thing that my mind flagged was this:
>
> static void vdso_fix_landing(const struct vdso_image *image,
>                 struct vm_area_struct *new_vma)
> {
>         if (in_ia32_syscall() && image == &vdso_image_32) {
>                 struct pt_regs *regs = current_pt_regs();
>                 unsigned long vdso_land = image->sym_int80_landing_pad;
>                 unsigned long old_land_addr = vdso_land +
>                         (unsigned long)current->mm->context.vdso;
>
>                 /* Fixing userspace landing - look at do_fast_syscall_32 */
>                 if (regs->ip == old_land_addr)
>                         regs->ip = new_vma->vm_start + vdso_land;
>         }
> }
>
> static int vdso_mremap(const struct vm_special_mapping *sm,
>                 struct vm_area_struct *new_vma)
> {
>         const struct vdso_image *image =
> 		current->mm->context.vdso_image;
>
>         vdso_fix_landing(image, new_vma);
>         current->mm->context.vdso = (void __user *)new_vma->vm_start;
>
>         return 0;
> }
>
>
> --- ---
>
> This feels *way* more complicated than it should need to be.  It seems
> to me that if the ip is inside the vdso at all, it would need to be
> adjusted, regardless of if it in an ia32 system call or not, and if it
> is at the specific landing spot or not.

In practice the only situation where ret->ip can be inside the VDSO is
when the remap syscall was invoked as IA32 syscall and the VDSO image is
a 32-bit image. So this check is pretty much paranoia.

> It is possible that it doesn't *matter*, but that's not really a good
> reason to make the code more complex.
>
> I came up with the following version as an alternative; I would be
> interesting to hear what you think.
>
> (Also, (unsigned long)current->mm->context.vdso occurs *all over the
> place*, but there is also a macro defined for it (VDSO_CURRENT_BASE, in
> <asm/elf.h>. My personal preference would be to replace both with an
> inline function.)

No objections, but in a seperate patch.

> If you don't think I'm missing something, I would like to do something
> like this:
>
>
> static inline void
> vdso_fix_address(unsigned long *ptr, const struct vdso_image *image,
>                  unsigned long from, unsigned long to)
> {
>         if (!image)		/* For potential uses elsewhere */

Aside of tail comments being horrible, this comment is just useless
gunk.

>                 return;
>
>         unsigned long offset = *ptr - from;

Why on earth do you need to hand in the pt_regs->ip pointer instead of
using pt_regs->ip here at the usage side? Just to make the code even
less understandable than the original one?

>         if (offset < image->size)
>                 *ptr = offset + to;
> }
>
> static int vdso_mremap(const struct vm_special_mapping *sm,
>                 struct vm_area_struct *new_vma)
> {
>         vdso_fix_address(&current_pt_regs()->ip,
>                          current->mm->context.vdso_image,
>                          vdso_current_base(),
>                          new_vma->vm_start);

TBH, this is incomprehensible garbage. If you want to simplify the whole
thing, then why not doing the obvious:

static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
{
	const struct vdso_image *image = current->mm->context.vdso_image;

        if (image) {
		struct pt_regs *regs = current_pt_regs();
        	unsigned long offset = regs->ip - vdso_current_base();

                /* Add a useful comment */
                if (offset < image->size)
                	regs->ip = new_vma->vm_start + offset;
        }

	current->mm->context.vdso = (void __user *)new_vma->vm_start;
}

Thanks,

        tglx

