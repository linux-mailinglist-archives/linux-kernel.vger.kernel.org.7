Return-Path: <linux-kernel+bounces-739938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4AB0CD56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1F63B1051
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C924113A;
	Mon, 21 Jul 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ebdU1wgh"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CF2C9D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137430; cv=none; b=a0dzAdiYAyWTl6czco7iY3Wq9Eczd2RTpZrqGA5Dtk2+DN+cATbwf6RUnVO48QiFInqoG4ZGw2WKLt0Z45KjoCukemOfdfRJA2yw2POSuQBMxgZQLM0OZcEiUtOIF0hUv9m8ioW+zzkz9APtGkoKRnIZes5vygmsVaQOE2Mup/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137430; c=relaxed/simple;
	bh=y2pAD3lqO+ZEL4+lhnmB45md1QxcSJ7xJxreOCDZ7Hw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hP7+SvDf1pfYODiTr3zMNgeHKbcFNy+kcMVAYc65dyI6lT+HOEpAT28xqvvA2jh6KHPe//urE89gdEOSoJymkbY23WDyKwxt2X4lKaLh6NcMWsT7bE9WnjnZX2YY1NmhBHHSddQ9H9ELzRKiZYtv9bcR4uIo1CPbD7WpA2HNJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ebdU1wgh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56LMaDtq252904
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 21 Jul 2025 15:36:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56LMaDtq252904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753137374;
	bh=9Ghx+3CCLdDnfIRuGwEOZ9mJsUcDXrrNs+Ap4HOBnUA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ebdU1wghdpm3ftqhqKRFF3TK6DcjAbphYmlA2XFV5x7PIoTvUbfw3BWjvtZVA+0f9
	 mG9sn8GVrCEb2v8f26kOK2xgo+4IgQ79+Iyg+XviVZ+SfBQGJeOOP6FMwNG0yaflgx
	 anQYk6qOLIC5DuphsL6oycXYaiIhjoX+U/W3VrXSafbzCIVu/T4g7rWcuP1qphJ5jB
	 aDyJb78fnfmZyLcGFIWRB1oFZXq41yC58r48MNZee6LvMC8burJLMVD/IN3j6hWk6M
	 kydDmWdUxUmbY1mYptNj+O7IMazKl0whxj+RN4a7W1QkLIPAnxNNtCZcx16x54t7pZ
	 8zIReERTPfHoA==
Date: Mon, 21 Jul 2025 15:36:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Address fixups in arch/x86/entry/vdso/vma.c
User-Agent: K-9 Mail for Android
In-Reply-To: <878qkhtd72.ffs@tglx>
References: <5a2667c8-bad4-4079-90a2-e387b4472164@zytor.com> <878qkhtd72.ffs@tglx>
Message-ID: <05B2C27D-9C2F-483C-88D5-B24ADFECAA16@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 21, 2025 3:02:25 PM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wro=
te:
>On Thu, Jul 17 2025 at 10:34, H=2E Peter Anvin wrote:
>> One of the thing that my mind flagged was this:
>>
>> static void vdso_fix_landing(const struct vdso_image *image,
>>                 struct vm_area_struct *new_vma)
>> {
>>         if (in_ia32_syscall() && image =3D=3D &vdso_image_32) {
>>                 struct pt_regs *regs =3D current_pt_regs();
>>                 unsigned long vdso_land =3D image->sym_int80_landing_pa=
d;
>>                 unsigned long old_land_addr =3D vdso_land +
>>                         (unsigned long)current->mm->context=2Evdso;
>>
>>                 /* Fixing userspace landing - look at do_fast_syscall_3=
2 */
>>                 if (regs->ip =3D=3D old_land_addr)
>>                         regs->ip =3D new_vma->vm_start + vdso_land;
>>         }
>> }
>>
>> static int vdso_mremap(const struct vm_special_mapping *sm,
>>                 struct vm_area_struct *new_vma)
>> {
>>         const struct vdso_image *image =3D
>> 		current->mm->context=2Evdso_image;
>>
>>         vdso_fix_landing(image, new_vma);
>>         current->mm->context=2Evdso =3D (void __user *)new_vma->vm_star=
t;
>>
>>         return 0;
>> }
>>
>>
>> --- ---
>>
>> This feels *way* more complicated than it should need to be=2E  It seem=
s
>> to me that if the ip is inside the vdso at all, it would need to be
>> adjusted, regardless of if it in an ia32 system call or not, and if it
>> is at the specific landing spot or not=2E
>
>In practice the only situation where ret->ip can be inside the VDSO is
>when the remap syscall was invoked as IA32 syscall and the VDSO image is
>a 32-bit image=2E So this check is pretty much paranoia=2E
>
>> It is possible that it doesn't *matter*, but that's not really a good
>> reason to make the code more complex=2E
>>
>> I came up with the following version as an alternative; I would be
>> interesting to hear what you think=2E
>>
>> (Also, (unsigned long)current->mm->context=2Evdso occurs *all over the
>> place*, but there is also a macro defined for it (VDSO_CURRENT_BASE, in
>> <asm/elf=2Eh>=2E My personal preference would be to replace both with a=
n
>> inline function=2E)
>
>No objections, but in a seperate patch=2E
>
>> If you don't think I'm missing something, I would like to do something
>> like this:
>>
>>
>> static inline void
>> vdso_fix_address(unsigned long *ptr, const struct vdso_image *image,
>>                  unsigned long from, unsigned long to)
>> {
>>         if (!image)		/* For potential uses elsewhere */
>
>Aside of tail comments being horrible, this comment is just useless
>gunk=2E
>
>>                 return;
>>
>>         unsigned long offset =3D *ptr - from;
>
>Why on earth do you need to hand in the pt_regs->ip pointer instead of
>using pt_regs->ip here at the usage side? Just to make the code even
>less understandable than the original one?
>
>>         if (offset < image->size)
>>                 *ptr =3D offset + to;
>> }
>>
>> static int vdso_mremap(const struct vm_special_mapping *sm,
>>                 struct vm_area_struct *new_vma)
>> {
>>         vdso_fix_address(&current_pt_regs()->ip,
>>                          current->mm->context=2Evdso_image,
>>                          vdso_current_base(),
>>                          new_vma->vm_start);
>
>TBH, this is incomprehensible garbage=2E If you want to simplify the whol=
e
>thing, then why not doing the obvious:
>
>static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_are=
a_struct *new_vma)
>{
>	const struct vdso_image *image =3D current->mm->context=2Evdso_image;
>
>        if (image) {
>		struct pt_regs *regs =3D current_pt_regs();
>        	unsigned long offset =3D regs->ip - vdso_current_base();
>
>                /* Add a useful comment */
>                if (offset < image->size)
>                	regs->ip =3D new_vma->vm_start + offset;
>        }
>
>	current->mm->context=2Evdso =3D (void __user *)new_vma->vm_start;
>}
>
>Thanks,
>
>        tglx

Yes, it was more complicated than necessary, because at first I was lookin=
g at reusing the routine in some other places I was working on, but it does=
n't seem to be necessary, so no reason to complicate things=2E=20

Thanks for confirming what I suspected=2E


