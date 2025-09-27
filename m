Return-Path: <linux-kernel+bounces-835066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986DBA62CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D493B1F54
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9622D4C8;
	Sat, 27 Sep 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmXL504U"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEE22FDE8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759000830; cv=none; b=X1U8BlNjWzHdx1F3nSO2VjNe+RyNenCkxI5/wq5mlz2JoOaV09LI9UougKCmhIr1FiucWPV43au/Y0yVeMR24oA+9e2UvQc/bI8rsj/UEp2ZQLyQvZgulN8Rx1zCFyqSTbEo3WKAvQV8slCCq2S/eWkYlA11Tk6VDzK61RlSvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759000830; c=relaxed/simple;
	bh=yoeBWfsz0Rxzfbgk6BToAOC/vOnboIpPuqC1fyVrHZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWtWuK690bAWFh8DOIVPUcK8Gqs7Ysdv/Onm+ufl2QAVy+UkFGnQzSgqqWkwkfQ8DNbTxefKHjiShfkMxDmYkMsM3/xuxDM40kA5T+XqfMtt5XOjen0wDsxl2FyaamJb0hUPpDGdiPPtwosZ1SuJGMhFo9ADk+16aF0REhe7WOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmXL504U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso1579658a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759000827; x=1759605627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpNpqT8E7PV/s4bEDWlZ98/qvJvoxkZccIvsTmWeJBY=;
        b=LmXL504U0c1QG2jy3KW+WIDtc8+FAs3E23849eS0e2Vkfl6p7fq4KCBQzcNYUmMMIn
         bO0wPHikSYdv/aQEZohRb1KS8AH0g5iWXW18Pok5gfQIfrLPlXE8xgPLz0wMe6Et9dqY
         1UF4yCh+HhhIWiJYUyYS+Rt26rLu5/8v+kDBoYFTm3wwiU3GCB42340BcFn7AfOte65Z
         sSHHLLPoaIcQhBGE0YW7htO5AiI2qeQIqcYmyE67vPfGJi6ZVV23XOcsazphMjXG7MCS
         HjtXRnd2nZGBgrVo6mX9eSs5xkZiwhHmhjUSkhNFCoZk4zaIwt9nZJcW+BgI1CKJcZzn
         QWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759000827; x=1759605627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpNpqT8E7PV/s4bEDWlZ98/qvJvoxkZccIvsTmWeJBY=;
        b=pUsFH0M4BjyE/mCbRZkuogvTUR0hVb4W4uVnyr29pf1Lx8HswmqE2Xpi7SqjzWzJWI
         SlGniyNoHpBvRBN4nG6mfZHT10n6IOF8t6u9AxuHhCg1Cj7rBjM6YK05JndyG5HTRIh9
         X0XnDQ1b9cnfc9DH60kWOZ4qpWMCwjRtVyeTv3JgAYFv2ozZ36mn2eChOdi1kvcL2LpU
         okAoDpTdzPeJIap9rxvBzGi6jQ5GGJlENxAugvVYGC+4X/qzq5QwUuCa6pNQVfnV7+RB
         KQcTGh0Rs3jEWG9zxwZYlH/KdcpFHbHlgkRA+jsyJz6peEQK5Cc1KVEOt32KRt3CDcEg
         S60w==
X-Forwarded-Encrypted: i=1; AJvYcCXkuPFouuB9Dwm3YrmAnM+isN1mTe6bkID0s7MElfDY1uvfdTOQs2kcGqKi67wo1NWrn5ng7HRIQhTj5dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2Mkkw/KPxhS9S7wkqDHVkmjPCq8xymYGjkVi4w5PiAZYOrW/
	SyrZXfYki5cB9QE9bosTrmsXah2oCjCqJpOU4UkBraGNGwB4o2spNexetQdXdTI+lCQQNjPBIqw
	iqdG+osIk8KTgVcnaYKnSbULEijG/xrk=
X-Gm-Gg: ASbGncugbRLgqmrrLe2/9ok8FJTdQQTJM0Pocj9hbr/Z0i7awYDfai/Btww0Fq4Wu1T
	JzmYHhf9xYMd8EKU/fJblR0+u/xnZ1xLNDJiinr7IZoDh2W0jBMsl2eKpOOHAB9Wnvwf57WOagE
	sAPpOHIlej2NMJYcJJwEHHfU2tnnzYUGxeAKE7DO+umOYJre37Wg+nZF6I4C3trwI4fHfrpGF83
	2wN/YxEXhehQe+8Hk8=
X-Google-Smtp-Source: AGHT+IE6MMpG/TRiFXxnrxz1Vvo3fuH5ytNgtdVEgpXL0NxXawEVfUDFtb+tMcdRPN344hi95Su67MTI32H6Ub9xTJM=
X-Received: by 2002:a17:907:7b8b:b0:b3c:5f99:dac7 with SMTP id
 a640c23a62f3a-b3c5fa9674amr74488566b.21.1759000826450; Sat, 27 Sep 2025
 12:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
In-Reply-To: <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 27 Sep 2025 21:20:15 +0200
X-Gm-Features: AS18NWCUkmopfgQP7FxvlAuimXjc1tmQlQb-89CTajXeb-5Nlye2dR2BnBQqzEg
Message-ID: <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

> > Suggest testing the same branch with the alpha patch reverted just to
> > rule out any issue in the core code. If it reproduces suggest to
> > bisect Leon's branch.

Hi again, I've booted up the ES40 again with the kernel build from Leons
branch, it boots up but message log is full off messages like
"EXT4-fs error (device sda4): ext4_find_extent:939: inode
#16257327: comm init: pblk 65114257 bad header/extent:
invalid magic"

The filesystem is broken after just booting with the kernel.
This time fsck did not fix it, I needed to re-install gentoo stage3.
So it's for sure reproducible as well as destructive.  It's not possible to
revert all the commits individually, since this will leave the source tree
in a state where the kernel doesn't build. I've started off by reverting
the following commits:

e78a9d72517a88faa6f16dab4d1c6f966ed378ae
(dma-mapping: remove unused map_page callback)

d459e3b80ad1c81bf596d63d2e3347cf8c7bb0d9
(alpha: Convert mapping routine to rely on physical address)

3cd47242d513050d7a81ac6e7020fd3ef5462ad4
(block-dma: properly take MMIO path)

7950995bef32aa7e5f74699c7d0fdac41d2dad14
 (block-dma: migrate to dma_map_phys instead of map_page)


After reverting the above commits, I'm able to build a working kernel,
that is, no filesystem corruption occurs. I'll take a closer look at this
after the weekend.

Regards

Magnus

