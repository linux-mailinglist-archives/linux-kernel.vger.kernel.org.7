Return-Path: <linux-kernel+bounces-871428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E6C0D3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F85404A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB12FD1B9;
	Mon, 27 Oct 2025 11:44:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93CD2FC88C;
	Mon, 27 Oct 2025 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565444; cv=none; b=BXR3okCo6ndLCVRRkc/ozYaSv5HeBAhE3p854iVqBRlvmjZfwkU2VAjxmF4TsG3SkfY0ljuHRdtTkYPhqU4Eq+1Ir2MpXL+WSa3peGZ467W6PpugPYgrHFPf248lliFyxOGfCIZQW9p3HSPQ8UMdooSP/7O5/tmSLEymI1fUpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565444; c=relaxed/simple;
	bh=8SGdPTxUHSUvdkvomZFHBaqkm2RreBRK43eClYZlDO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khjN0Mc4tvAFdHIi7+dfxUeaGBpH5RIIhoZrt3XH1R8rQoeO3JjGAVxoWtcbByaY9K9G6bRwom5JBt3iFjeAcYS9fYdHbTex9WWeV/TzbgdLhVDhaPgJpCoYQ5MMp5obnmY4L4tjD49lcNAwkiS6GEbZcGj3fk5ztNIxR31yj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43CDD169E;
	Mon, 27 Oct 2025 04:43:53 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC9E3F673;
	Mon, 27 Oct 2025 04:43:59 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:43:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Tony Luck <tony.luck@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
Message-ID: <aP9a9ZtigAWCWSWk@e133380.arm.com>
References: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>

Hi,

[Tony, I have a side question on min_cbm_bits -- see below.]

On Sun, Oct 26, 2025 at 08:39:52AM +0100, Christophe JAILLET wrote:
> 'first_bit' is known to be 1, so it can be skipped when searching for the
> next 0 bit. Doing so mimics bitmap_next_set_region() and can save a few
> cycles.

This seems reasonable, although:

Nit: missing statement of what the patch does.  (Your paragraph
describes only something that _could_ be done and gives rationale for
it.)

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> For the records, on x86, the diff of the asm code is:
> --- fs/resctrl/ctrlmondata.s.old        2025-10-26 08:21:46.928920563 +0100
> +++ fs/resctrl/ctrlmondata.s    2025-10-26 08:21:40.864024143 +0100
> @@ -1603,11 +1603,12 @@
>         call    _find_first_bit
>  # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
>         movq    %r12, %rsi
> -       leaq    48(%rsp), %rdi
> -       movq    %rax, %rdx
> +# fs/resctrl/ctrlmondata.c:133:        zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
> +       leaq    1(%rax), %rdx
>  # ./include/linux/find.h:214:  return _find_first_bit(addr, size);
>         movq    %rax, 8(%rsp)
>  # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
> +       leaq    48(%rsp), %rdi

(This is really only showing that the compiler works.  The real
question is whether the logic is still sound after this change to the
arguments of _find_first_bit()...)

>         call    _find_next_zero_bit
>  # fs/resctrl/ctrlmondata.c:136:        if (!r->cache.arch_has_sparse_bitmasks &&
>         leaq    28(%rbx), %rdi
> ---
>  fs/resctrl/ctrlmondata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index 0d0ef54fc4de..1ff479a2dbbc 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -130,7 +130,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  	}
>  
>  	first_bit = find_first_bit(&val, cbm_len);
> -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);

Does this definitely do the right thing if val was zero?

>  
>  	/* Are non-contiguous bitmasks allowed? */
>  	if (!r->cache.arch_has_sparse_bitmasks &&

Also, what about the find_first_bit() below?


[...]

<aside>

Also, not directly related to this patch, but, looking at the final if
statement:

	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
	        rdt_last_cmd_printf("Need at least %d bits in the mask\n",
	                            r->cache.min_cbm_bits);
	        return false;
	}

If min_cbm_bits is two or greater, this can fail if the bitmap has
enough contiguous set bits but not in the first block of set bits,
and it can succeed if there are blocks of set bits beyond the first
block, that have fewer than min_cbm_bits.

Is that intended?  Do we ever expect arch_has_sparse_bitmasks alongside
min_cbm_bits > 1, or should these be mutually exclusive?

</aside>

Cheers
---Dave

