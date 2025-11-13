Return-Path: <linux-kernel+bounces-898985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93CC5684B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDDA64F2AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8EC334C28;
	Thu, 13 Nov 2025 08:57:04 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215D332EDE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024224; cv=none; b=SQyu/NBdO+aOsZVjqbHMBsFiNnBQtpH3te51eN8nwHvjJuQqCz1P/VSmVKrXp3TwH9nr79TSFiFNvD0LCwuv3MttRQxfuxgO9lRSvOLiIVWhs+wVaVjKFe8wCQ4F7s/LFtNJQccLh5GfzgeW1Rl/lxecY0BPixAVMiueEC4BCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024224; c=relaxed/simple;
	bh=as2Wl3WHy5m/K3oRgwuzwjXnWFg0R2hmfkUngFuxVnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxU7/RAb+x9aLrNvx5AnpsOOmf2I10R1xPF+qq51vJ8/cD/hGxQZMpyYy6c9G0RktTii7BMUvuxqH6hrHNEoWzOIuJb8gm73XA7x2+rWJKpU2FqcGV1Xv2CvfTGb3HoAZYiwW67RkTfb0IhZeAhd5UXhlKgc1fSIVrsWQ96t9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5597a426807so364243e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024221; x=1763629021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNPad0IM0QP877Z/XWUvdL3MC286xcTm4p5JIGRP0vI=;
        b=uPr6EqC969WEepU7i1Z4OhfFFbhAvlOXzUuEHWD2vTNoEduskMfj3Wnbta4eCrZl8w
         Tg1DFaL4KwPt9Vy78R8ExqrdmevLu3ZVgH//x1mvLZkkHxQNjWlw/NNUeG5dKr8vx9Ss
         8AYhrY2lR8WFBx6eXKwki+j2Up0tr/SxtwS5w4tnoc8vEt5SRdHuvR9goQg+6gv7/fOf
         x4jeymk5xHtYJZgO6PY6g1VPChYGLmgDsrfdhYM5igNDg+GvxP4LLiWqM4vL3NFtOesG
         C7ohMBzOoTvkjzY/lsnxQ/lS2u7Om+/2lJYPMwM/ugxOvSbSu0tEEIeqcTK/FKkj417a
         L1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBPri+WMdU78lEiqQb6Jn9TGiWgLdo265sgMWeD9BZl7l7R7koZqCtHjYhDdyAAKAsupVHJrpZMFCgxew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVSOIjiMOEBSlM3vQynzOKdzRdvEAMNmEy2sbuzfAMsG7TYP3
	Af09Epyug9LumQ/Z0sYLB2fEsBLgr0Efn9FBcmkNsJSeuMC2iud01diMKY+phOnc738=
X-Gm-Gg: ASbGncvEUOrwZPfaL6V0q7NxwDXpi+BEWJvW3Rm3ZIBhpiPOxPoEreo621CAdagmPnH
	Nsk1KztGhCb0TJwA0zOP3LUCF5QkEItefdencSxETBfiUKwqHJEJxy4CWrC3G3FFaDLBAf08mCE
	0A0gs+Qltt5Dx6LeFz/HHblsxmkxDZP51Ch/b1yr1oCforiFrz36c5X+896j8djVu1/1ITtc71p
	Ym8M7rQvh6qwkBvYZr8MG2FNsypq478N0yEeVY4S2xKrCGNlJYLPHgjh0FSqAGRPvVRTEeyJsZp
	+BICiBRVs60BE7cTom66CXaPb1wbE93eMnIK7cE1uiggo7nqiUcoI8Qa5UFQNXM6ntAssFOtVtJ
	WSHd/2EhHrY2hTZEhJjUjnJ2U2iViZjdYVqRdP69HMMZkVVJ+nc20+lLmifA2GMiQ9FgZa8BHgs
	Sl6M8a8K0z/vzYx+ATbqO3bFEYP94QS+8v5KN6Ijzrlg==
X-Google-Smtp-Source: AGHT+IHKCpMCJDtfKr/D+z5i9I7SzPHrPZ34dFYkJHlXpESpUNyaGq3/KE+a4/nRgHbwm4KRG7Bovw==
X-Received: by 2002:a05:6122:1d86:b0:559:6092:936c with SMTP id 71dfb90a1353d-559e7d499a9mr2223851e0c.12.1763024221264;
        Thu, 13 Nov 2025 00:57:01 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f441c79sm501197e0c.14.2025.11.13.00.56.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:57:00 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-559836d04f6so401213e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWR84g5WhUdhGIYYoNFxMTR3/V5Ya4rFe4X+ivKGCtdFe9naZHvzedt7jYWc9t2U1+OTn7+1YFEsfjPsQ=@vger.kernel.org
X-Received: by 2002:a05:6102:374e:b0:5d5:f766:75f1 with SMTP id
 ada2fe7eead31-5de07d598c3mr2559230137.11.1763024219221; Thu, 13 Nov 2025
 00:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <aRULf65eNaRIVEHN@ziepe.ca>
In-Reply-To: <aRULf65eNaRIVEHN@ziepe.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 09:56:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3rY8iyxJWdNFA0whOFv6WV-AgndnoA-QPjNLrLOjw2A@mail.gmail.com>
X-Gm-Features: AWmQ_bkeganA7aM_P2ei0wcLl7_i_OWoRrr5SIFHNN0iTfxFCurm_-NlINuIdn0
Message-ID: <CAMuHMdU3rY8iyxJWdNFA0whOFv6WV-AgndnoA-QPjNLrLOjw2A@mail.gmail.com>
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Wed, 12 Nov 2025 at 23:34, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > There is no point in asking the user about the Generic Radix Page
> > Table API:
> >   - All IOMMU drivers that use this API already select GENERIC_PT when
> >     needed,
> >   - Most users probably do not know what to answer anyway.
> >
> > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/iommu/generic_pt/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I can't check this right now but I do recall trying to do this from
> the start and it was not working out, it ended up not being
> automatically turned on?
>
> Did you test something like menuconfig and the IOMMU drivers are still
> presented starting from an allnoconfig?

Yes, that still works.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

