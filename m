Return-Path: <linux-kernel+bounces-867181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C44C01CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF93D3A34D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCCB32C336;
	Thu, 23 Oct 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbPv22rD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991B32B996
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229704; cv=none; b=VgJWnV99+hb5n9KR/CEpMFzuY6v1MysTmiaPsUP9l2NgnkxkSqFF8ZanznpjzuqgkMsb9eVBp813OW/YuNeWAAXaKkH1/0Agj7kOEUvWjCn6nikA/vCN6cJ4tr5hhmpcZ3GQgp72e0XE3qNrQFvlUoDZjJ/i5Ed3o3TO5Q1iLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229704; c=relaxed/simple;
	bh=ktjU2yXCJgq2bB7I9SbX6Ro6Bzsh2cM+rlZxZ8BLoUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k96Z9ux8n/f3DW4G+wRDA/oE68gJMwfI6cRjMrVTfebqVgok1FRD2zqa5/fSw3RD+yLvlTMSfSw6aAMHKPJWLT8QQr6IiOJfrfvzulZurH8q+bIJ+8DmLGTlygnEUSqRFFsLcU++b7R39L/KCqhAieG47cvmRRYTs6Jyhzn1xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbPv22rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D27CC113D0;
	Thu, 23 Oct 2025 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229703;
	bh=ktjU2yXCJgq2bB7I9SbX6Ro6Bzsh2cM+rlZxZ8BLoUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbPv22rDJ+3HBD+yUrUyBNTl/Rm6IxXQwdUtzY+JO0kAfOaYYt5TgPaMI0PmcLBuM
	 yx3fi6+AOEAlXqh1q6Q8q9asTgkQg018QhdW4TczT3PLaNg2YqzMPRwtOZpCYof0r/
	 xVW2e1/Yxw3P00RynFoOuJsrO+pxGA3te7jgOgNi5AODQcNs9vz5pKfA1QfdzB3hLn
	 EuUZaKHudWO0fpd+GVKgzDlHSfEVn5ih794A63ouOiXcRxOa4tVxCeLvW0FJj5a7hp
	 wuXQ7yQ6Sn5IDmGWhR3O4Vqx5eQiBujQYjR1mWbKebTxr0gbnJjcTiuRYtDV98mJ16
	 hM2X1Jg5hROGg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id AC9ADF40066;
	Thu, 23 Oct 2025 10:28:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 10:28:22 -0400
X-ME-Sender: <xms:hjv6aGOi0mrMuKXJJ15dg6zBxYd4OdEBbhNvJlMtOwT1UMwmQTHVMA>
    <xme:hjv6aPoKuhsat5yBXqVEKWfPSqiackNjcH0g632uqEd3yOlu1VD5dmwqk1wSTm4XH
    bpgjq08QwMehToRfXUIp6XFP24iaGvuIlDiAnUN-NNhWKhEhxpfnKs>
X-ME-Received: <xmr:hjv6aBTLVYC1qR7zilHNAX8SLVBftK8ZvDPeGn_wrcpKTbC7hBToY9oUVgzArg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhsrghmrggrrhhifh
    eigedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepugifmhifsegrmhgriihonhdrtgho
    rdhukhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtth
    hopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhek
    rdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hjv6aHa7B4Rcj9GdVNw1UP_OxKt8J0nxVT5AEwIy6vY7JfIlIPlV4g>
    <xmx:hjv6aNM6n_KjHP_w-GsznfEvTzu9V6Ieldd2-kW12GiqFAgIkxgN0g>
    <xmx:hjv6aC40t26fpQMlt_iDn2DEQrqcoV4oBuLHmCsHh1P04-Erj_ipdQ>
    <xmx:hjv6aAdXTNPjWHRoVpFkdsGPoNO0WmTRZIwFuMzMGDHd1J4HtzXPsQ>
    <xmx:hjv6aG7b1fnaT7pBD1qCZp1RS1P-5u-1JAkM87nE0-rVNvhqjjQ3zukH>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 10:28:21 -0400 (EDT)
Date: Thu, 23 Oct 2025 15:28:19 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, x86@kernel.org, apopple@nvidia.com, thuth@redhat.com, 
	nik.borisov@suse.com, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>, 
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH 2/3] efi/libstub: Fix page table access in 5-level to
 4-level paging transition
Message-ID: <lbkjggisugaccdowww6zlux6w6jpf2izm54myfrla2lgvcomb7@52kd6ferku5r>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-3-usamaarif642@gmail.com>
 <CAMj1kXEYYSc8=qMmDW6E2kRFawK34okGvq=rTuhvv5hVPsd-iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEYYSc8=qMmDW6E2kRFawK34okGvq=rTuhvv5hVPsd-iw@mail.gmail.com>

On Thu, Oct 23, 2025 at 04:13:26PM +0200, Ard Biesheuvel wrote:
> On Thu, 23 Oct 2025 at 00:08, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> > When transitioning from 5-level to 4-level paging, the existing code
> > incorrectly accesses page table entries by directly dereferencing CR3
> > and applying PAGE_MASK. This approach has several issues:
> >
> > - __native_read_cr3() returns the raw CR3 register value, which on
> >   x86_64 includes not just the physical address but also flags Bits
> >   above the physical address width of the system (i.e. above
> >   __PHYSICAL_MASK_SHIFT) are also not masked.
> > - The pgd value is masked by PAGE_SIZE which doesn't take into account
> >   the higher bits such as _PAGE_BIT_NOPTISHADOW.
> >
> > Replace this with proper accessor functions:
> > - read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption bit
> >   and extracting only the physical address portion.
> > - mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
> >   flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).
> >
> > Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
> > Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > Reported-by: Michael van der Westhuizen <rmikey@meta.com>
> > Reported-by: Tobias Fleig <tfleig@meta.com>
> > ---
> >  drivers/firmware/efi/libstub/x86-5lvl.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
> > index f1c5fb45d5f7c..34b72da457487 100644
> > --- a/drivers/firmware/efi/libstub/x86-5lvl.c
> > +++ b/drivers/firmware/efi/libstub/x86-5lvl.c
> > @@ -81,8 +81,11 @@ void efi_5level_switch(void)
> >                 new_cr3 = memset(pgt, 0, PAGE_SIZE);
> >                 new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
> >         } else {
> > +               pgd_t *pgdp;
> > +
> > +               pgdp = (pgd_t *)read_cr3_pa();
> 
> Shouldn't this be using native_read_cr3_pa()?

Perhaps. But I don't think it makes a difference.

We don't have paravirt in stub/decompressor, do we?

> And is there any reason
> to re-read CR3 here, rather than update the code that populates the
> cr3 variable? The preceding other branch of the if() should probably
> use the same sanitised value of CR3, no?

Good point.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

