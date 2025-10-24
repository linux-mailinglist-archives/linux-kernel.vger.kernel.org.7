Return-Path: <linux-kernel+bounces-868513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC2C055FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B2115019CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552D30ACFD;
	Fri, 24 Oct 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5VTkN4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA630AD1B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298553; cv=none; b=UaCLcLBP/BOw4s2ZW2wcbd3gE/NF55RUvoLnLmGPMKxHRUnH8fM/k1s8z1FcU0rPINh63/4lwmnD7oUVumDPL/z/kyINWD4m+yN126bh96bJHrXCwTz9f1KSEGGscmKETlTLD6JOFWFHsmUZxxb0VePt0zWqz6fpCBw+NeuzVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298553; c=relaxed/simple;
	bh=6TR2JjGwCIAiNQ+qBWJLgP/7XEsVHV4Gz/1uoHuX3mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0YmrEDjnc6PnH2eaud4CQqnFDSb5RV7RHUxd2MtNCP1kJxDZX0QPnFDLIsImy23dV7odyn8CHpGv7CabN2Kgy31wBIlnvYgor128WNqqxEjuZ7oBu5UDOyp0qCfwaucphEq5CiwbvKroYisFC5tTTVC+TxY9UPJ/Z40djAmTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5VTkN4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D119C4CEF1;
	Fri, 24 Oct 2025 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761298552;
	bh=6TR2JjGwCIAiNQ+qBWJLgP/7XEsVHV4Gz/1uoHuX3mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5VTkN4dtkytnjg9XcTzyEP5DczdyjJfTz3PioQTHl4syDeLOkJK2MgZEut0ycHPp
	 m1mrj58fZ7ZcMlCmsibfwI3SZEF/I3HW13K9Pzx1jwrGOhnHLFf1Bdpym1uT0mivsd
	 q33ofSUysFIVQTIdDF4WkjAnZRg5e5X99mxrZ2GAstDZcfm9lkwDtEWX/CVcXNLslM
	 nIZNUi8JDFJVWL1AeGoSqlajXwYqudiHUYR+XwPGeuwcrqpqiplV7aS1hYenYG05Av
	 KxmInt2JwD03WMngGiWEzD30P7PuDuRjAu9D1maeSrVmysPWu/2XdurImU8kW/S5HX
	 ucZSJcmAVrDsQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id A4353F40066;
	Fri, 24 Oct 2025 05:35:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 05:35:51 -0400
X-ME-Sender: <xms:d0j7aAUS67EJPntYS4oFt7elpuK3iateD2-ZZIcqnj0w_YVM3-KvpA>
    <xme:d0j7aM_CJ1B9lJEqtGZwUhCxc3ut7ZCAB6OcQia9BcqqXjo9QpRs_DLprto5s2y36
    rKhNoaExTg0PSa0GW1gZC14QlM0oV6SRedyXncId83P4_N2wB3_CGc>
X-ME-Received: <xmr:d0j7aGlEjB1nUHEuJr690zz1kAGDZXW9nluFiUdw5ZsmPTP0OwcS3JYokaGAsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhh
    grnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqtghotghosehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedr
    uggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtg
    homh
X-ME-Proxy: <xmx:d0j7aHKoWaoCe9N5ugn2ldcMI-R1Zii4eieeOCKuueiYTkD4wWFPtQ>
    <xmx:d0j7aMqNbIRGq9SpYEb3wA0BcH1dK0httZNq8bp_sT9fcqPmo1vLuw>
    <xmx:d0j7aEQ64w9z-I1pSZwpDMQF8CHyRFyI_jlHXraqOzx0daXTO3Yxvg>
    <xmx:d0j7aP6QujwH5t2CnOolZsTQBMi744qyixfu6G6hb5ceDgRl5my8FQ>
    <xmx:d0j7aMZH0x-YKLgeN92NHCeXvqPDH9KILSPEmKiHqwh41oVNGaBlS-Hd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:35:51 -0400 (EDT)
Date: Fri, 24 Oct 2025 10:35:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Message-ID: <mvwzymoykhb6symwvwcc5liws4nb5cnxbyibh25gt67kufxhy2@vnqb3npptx5z>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-2-chao.gao@intel.com>
 <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
 <aPiNy8Q3uPrlVlug@intel.com>
 <nfos7qsdendp45avmlpbftmekckewwvbb6romybh2dnbvomfee@a5lqto3xkeak>
 <aPsds5SCmmoG4IJO@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPsds5SCmmoG4IJO@intel.com>

On Fri, Oct 24, 2025 at 02:33:23PM +0800, Chao Gao wrote:
> >I don't hate it. Seems more scalable than current approach.
> >
> >See some comments below.
> >
> >> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> >> index 128e6ffba736..fa9bb6d47a87 100644
> >> --- a/arch/x86/virt/vmx/tdx/tdx.c
> >> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> >> @@ -226,22 +226,23 @@ static int build_tdx_memlist(struct list_head *tmb_list)
> >> 	return ret;
> >>  }
> >>  
> >> -static int read_sys_metadata_field(u64 field_id, u64 *data)
> >> +static int read_sys_metadata_field(u64 *field_id, void *ptr)
> >
> >Keeping the same name for completely different functionality?
> 
> how about read_sys_metadata_fields() or read_sys_metadata_all()?

Looks good.

> 
> >
> >>  {
> >> 	struct tdx_module_args args = {};
> >> 	int ret;
> >>  
> >> 	/*
> >> -	 * TDH.SYS.RD -- reads one global metadata field
> >> -	 *  - RDX (in): the field to read
> >> -	 *  - R8 (out): the field data
> >> +	 * TDH.SYS.RDALL -- reads all global metadata fields
> >> +	 *  - RDX (in): the physical address of the buffer to store
> >> +	 *  - R8 (in/out): the initial field ID to read (in) and
> >> +	 *		   the next field ID to read (out).
> >> 	 */
> >> -	args.rdx = field_id;
> >> -	ret = seamcall_prerr_ret(TDH_SYS_RD, &args);
> >> +	args.rdx = __pa(ptr);
> >
> >Maybe take virtual address (unsigned long) of the buffer as an argument
> >to the function. And use virt_to_phys() here.
> >
> >This way there's no need in cast on caller side.
> 
> Sure. Will do.
> 
> >
> >> +	args.r8  = *field_id;
> >> +	ret = seamcall_prerr_ret(TDH_SYS_RDALL, &args);
> >> 	if (ret)
> >> 		return ret;
> >> -
> >> -	*data = args.r8;
> >> +	*field_id = args.r8;
> >>  
> >> 	return 0;
> >
> >Hm. Isn't it buggy?
> >
> >Caller expects to see field_id == -1 to exit loop, but you never set it
> >in case of an error. It will result in endless loop if error happens not on
> >the first iteration.
> 
> The caller checks the return value and bails out if there was an error.

I misread it. Missed the break.

> >
> >Drop the branch and always return ret.
> 
> Setting field_id to -1 on error appears unnecessary since callers must check
> the return value anyway. And, even if args.r8 were copied to field_id
> on error, this wouldn't guarantee that field_id would be set to -1, as
> SEAMCALLs may encounter #GP/#UD exceptions where r8 remains unchanged.
> 
> Given this, I prefer to leave field_id as an undefined value on error, and
> callers should not read/use it when an error occurs.

It is not undefined. TDX module sets R8 to -1 in case of error.

> 
> What do you think?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

