Return-Path: <linux-kernel+bounces-735748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF2B0934A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A13B130D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23A2FD5B8;
	Thu, 17 Jul 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WfUmyHPQ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF91F95C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773738; cv=none; b=YLgxIjlJp4ButiwILBNE7H0vBkB2PaUu7pSa2+9wEM/anwM748FPRrJRlXOOQVDsLFNErzzDnQI/RbfBtIiy9X3dg7D+UbFTOaZUoiZCTH/3m7NUDF2/mm3a5iJK7OSIX4m/oehLp5TsenFhddFXy6sUNYKtjpkP5nboH7FAs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773738; c=relaxed/simple;
	bh=7f6W+dsDHOa64knot1J9CfQKxmyeaEbNq1+9+qljrk4=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=sXBWbhTXM/duWlUAZx5OhNPQbhqODAG7c2O58jBsT6srX6GZkDAGdTOvRGn0StYMkvTTf26icw11pFImIQVO9xZCvjWC2VGQxwJYMnFP4A2fnFlxLTYY0tA/uAEato37unwAx74nY5x0Enw1oFPGjq6Lj7Y/kjVQw1qV4aSlbV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WfUmyHPQ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9482:b3a6:4f6e:7587:7854] ([IPv6:2601:646:8081:9482:b3a6:4f6e:7587:7854])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56HHYak72185686
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 17 Jul 2025 10:34:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56HHYak72185686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752773679;
	bh=qARCOYQxewtF4nD446mRsruEt0q08SFanbtmYgHbVfI=;
	h=Date:To:From:Cc:Subject:From;
	b=WfUmyHPQxnRftAF/SuVPTuap5GdwcY/2tC2EJI3UcI3xUh/wegXQYp6PoK1Z7jBNW
	 hM3odq3y8EhUeoItgeWP5Z87nEtNAZ6ZC2oBQX+gDlKvBKIIBDued6Rky8WFiJuxP9
	 MJhtRkklcFzVPMy/WXxxgw4UpbFwqIiSbqv5VFPbVmR5sSm/uRuK8Aq721pK2nCL1U
	 eYV44+Aa8Zx5rzr6kCHW1NyCu1I8LsxUk7rtadN/kl5F19w55GtlrAUE3Dfj5R7Ik+
	 sXnwVBmCfF33t+qv5lwZqBeZnMO7dV+qYBpyrU19Si0eFu81k9wRjy5oGBayRX23pU
	 uHDolv2wk8UHg==
Message-ID: <5a2667c8-bad4-4079-90a2-e387b4472164@zytor.com>
Date: Thu, 17 Jul 2025 10:34:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Address fixups in arch/x86/entry/vdso/vma.c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys,

I was looking through the vdso setup code (because what I meant to be an
easy optimization turned out to be more "interesting" than expected...)

One of the thing that my mind flagged was this:


static void vdso_fix_landing(const struct vdso_image *image,
                struct vm_area_struct *new_vma)
{
        if (in_ia32_syscall() && image == &vdso_image_32) {
                struct pt_regs *regs = current_pt_regs();
                unsigned long vdso_land = image->sym_int80_landing_pad;
                unsigned long old_land_addr = vdso_land +
                        (unsigned long)current->mm->context.vdso;

                /* Fixing userspace landing - look at do_fast_syscall_32 */
                if (regs->ip == old_land_addr)
                        regs->ip = new_vma->vm_start + vdso_land;
        }
}

static int vdso_mremap(const struct vm_special_mapping *sm,
                struct vm_area_struct *new_vma)
{
        const struct vdso_image *image =
		current->mm->context.vdso_image;

        vdso_fix_landing(image, new_vma);
        current->mm->context.vdso = (void __user *)new_vma->vm_start;

        return 0;
}


--- ---

This feels *way* more complicated than it should need to be.  It seems
to me that if the ip is inside the vdso at all, it would need to be
adjusted, regardless of if it in an ia32 system call or not, and if it
is at the specific landing spot or not.

It is possible that it doesn't *matter*, but that's not really a good
reason to make the code more complex.

I came up with the following version as an alternative; I would be
interesting to hear what you think.

(Also, (unsigned long)current->mm->context.vdso occurs *all over the
place*, but there is also a macro defined for it (VDSO_CURRENT_BASE, in
<asm/elf.h>. My personal preference would be to replace both with an
inline function.)

If you don't think I'm missing something, I would like to do something
like this:


static inline void
vdso_fix_address(unsigned long *ptr, const struct vdso_image *image,
                 unsigned long from, unsigned long to)
{
        if (!image)		/* For potential uses elsewhere */
                return;

        unsigned long offset = *ptr - from;
        if (offset < image->size)
                *ptr = offset + to;
}

static int vdso_mremap(const struct vm_special_mapping *sm,
                struct vm_area_struct *new_vma)
{
        vdso_fix_address(&current_pt_regs()->ip,
                         current->mm->context.vdso_image,
                         vdso_current_base(),
                         new_vma->vm_start);

        current->mm->context.vdso = (void __user *)new_vma->vm_start;
        return 0;
}

