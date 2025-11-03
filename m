Return-Path: <linux-kernel+bounces-883337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A79C2D1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FD194EA590
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD13164B4;
	Mon,  3 Nov 2025 16:24:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D61314B66;
	Mon,  3 Nov 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187059; cv=none; b=SPeHa6RPlXWsHuRhAa8wfHk7TFki0cDDO/UqirFYk2UarXkr7a9Lbp1Tkt6y4MMM+RdKHDMVBRlrVY7HGHZnErH6KR/U7L9UHg3vb2tjZygQqxnGt68Mro6sK9bLSdhiz+zon9EC87t6iKGBYncw4WDozjWtI1yzzsdthHSIJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187059; c=relaxed/simple;
	bh=hXs+xAyEZF81W8cTRopgPmrYNWCpMOoEma/6SFBEXZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0CewrNHRsRGBm9Dj1S+i7EoUxKZ9iXXVfT7IDuJ947yqjCvxqK5VdrFL2A1F9Y7jLYRfpiJnTUo7odaaTJ4qK2nILQH1hYw0LHfSx1wYQLBgieuNt0QvOLLav5g74RsmFlKNhF2ZXoBid0qzVAWPGmklOf0k6D/MQvEKjT1DK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538361D14;
	Mon,  3 Nov 2025 08:24:09 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9593F694;
	Mon,  3 Nov 2025 08:24:15 -0800 (PST)
Date: Mon, 3 Nov 2025 16:24:12 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
Message-ID: <aQjXLOHQevfQDhL0@e133380.arm.com>
References: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
 <aP9a9ZtigAWCWSWk@e133380.arm.com>
 <7776eb1c-418a-444b-aa24-0dfb23f05a2a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7776eb1c-418a-444b-aa24-0dfb23f05a2a@wanadoo.fr>

Hi,

On Sat, Nov 01, 2025 at 02:40:58PM +0100, Christophe JAILLET wrote:
> Le 27/10/2025 à 12:43, Dave Martin a écrit :
> > Hi,
> > 
> > [Tony, I have a side question on min_cbm_bits -- see below.]
> > 
> > On Sun, Oct 26, 2025 at 08:39:52AM +0100, Christophe JAILLET wrote:
> > > 'first_bit' is known to be 1, so it can be skipped when searching for the
> > > next 0 bit. Doing so mimics bitmap_next_set_region() and can save a few
> > > cycles.
> > 
> > This seems reasonable, although:
> > 
> > Nit: missing statement of what the patch does.  (Your paragraph
> > describes only something that _could_ be done and gives rationale for
> > it.)
> 
> Will add it in v2.

Thanks

[...]

> > > For the records, on x86, the diff of the asm code is:
> > > --- fs/resctrl/ctrlmondata.s.old        2025-10-26 08:21:46.928920563 +0100
> > > +++ fs/resctrl/ctrlmondata.s    2025-10-26 08:21:40.864024143 +0100
> > > @@ -1603,11 +1603,12 @@
> > >          call    _find_first_bit
> > >   # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
> > >          movq    %r12, %rsi
> > > -       leaq    48(%rsp), %rdi
> > > -       movq    %rax, %rdx
> > > +# fs/resctrl/ctrlmondata.c:133:        zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
> > > +       leaq    1(%rax), %rdx
> > >   # ./include/linux/find.h:214:  return _find_first_bit(addr, size);
> > >          movq    %rax, 8(%rsp)
> > >   # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
> > > +       leaq    48(%rsp), %rdi
> > 
> > (This is really only showing that the compiler works.  The real
> > question is whether the logic is still sound after this change to the
> > arguments of _find_first_bit()...)
> 
> Will remove in v2, if not useful.

It's harmless, but a bit of a distraction...

> > >          call    _find_next_zero_bit
> > >   # fs/resctrl/ctrlmondata.c:136:        if (!r->cache.arch_has_sparse_bitmasks &&
> > >          leaq    28(%rbx), %rdi
> > > ---
> > >   fs/resctrl/ctrlmondata.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> > > index 0d0ef54fc4de..1ff479a2dbbc 100644
> > > --- a/fs/resctrl/ctrlmondata.c
> > > +++ b/fs/resctrl/ctrlmondata.c
> > > @@ -130,7 +130,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> > >   	}
> > >   	first_bit = find_first_bit(&val, cbm_len);
> > > -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> > > +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
> > 
> > Does this definitely do the right thing if val was zero?
> 
> Yes, IMHO, it does.
> 
> If val is zero, first_bit will be assigned to cbm_len (see [1]).
> Then, find_next_zero_bit() will do the same because 'first_bit + 1' will
> overflow the size of the bitmap. (see [2] and [3])

Right, I think that works.

> The only case were we could have trouble would be to have 'first_bit + 1'
> overflow and be equal to 0. I don't think that such a case is possible.

I looks impossible to me: first_bit comes from
find_first_bit(..., cbm_len), so I don't think it can be greater than
cbm_len.

> > >   	/* Are non-contiguous bitmasks allowed? */
> > >   	if (!r->cache.arch_has_sparse_bitmasks &&
> > 
> > Also, what about the find_first_bit() below?
> 
> Should be updated as well.
> Will send a v2.

OK, sounds fair.

Cheers
---Dave

[...]

> [1]:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/find.h#L203
> [2]:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/find.h#L185
> [3]: https://elixir.bootlin.com/linux/v6.18-rc3/source/lib/find_bit.c#L55

