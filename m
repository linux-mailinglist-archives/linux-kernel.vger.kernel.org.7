Return-Path: <linux-kernel+bounces-773113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F214CB29B93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7576F18851F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DE274B3D;
	Mon, 18 Aug 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PKRmjwvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFgsRTOf"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281E23E358
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504251; cv=none; b=jHTezK8MW1m/etmcg+rydy41ICiHU1l5kUXy3r5hHfvrYLRQNj3o4upNPUu20/O4aov5ZH7/nYdZ64UiH8QJoh/Q4tXGEKy4QNYd7X/e71mrlcGTY1dvDIJTEReu/+KfR6hn3tBiQGgl0MK5sFcUry8z2EnKKPZBWZyAmZ84ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504251; c=relaxed/simple;
	bh=ga8Yr8TPD5StrTcn5jOSlFuv0+fyKp1usklVDk3WmQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwIrKWOz8HYOM46MI2GrykLZjg624goxINadwTPmelISNY/yEKCOkvXBF2eonCnfJMDDrCieVy71c3K4kxeLMLOyw8CvXlif72EgRLUa2gSh/WwtkFnJ/brdQ23Sarpbcb+CmTIz02+XiRSgS/MeKP4vEb2/0Tpn+6Q8cQPzIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PKRmjwvn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFgsRTOf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CBAC1D000C5;
	Mon, 18 Aug 2025 04:04:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Aug 2025 04:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1755504248; x=
	1755590648; bh=LNvIM431twoZOupygQQzHuiZqlwtEMuo7aaUS+jvExU=; b=P
	KRmjwvn626i7UZI4aKyPHjUKwYeDNmTUnAtOQBvDC4DpYLgHmXUPf+kaqysUJFih
	EvKmZvRsurycSmShXskAAvT46uzA/MQhsKsBeM2mypxXnZWBOJauU2bGDeHFi8U9
	Zm3olYjrF/FkIjQd3quSwaRpXh3E+ZQc5kbBL9mA2Q9/276gmuAW5b3qA5XVslNf
	qr75akxuWS6IywELyhfH+HABQi4nR0oVqGuO1L0x80VDjMtq6n3IgoGyhHDtXBY2
	gjt3/AkBlkbc1TvjJSk86hTNidRt0cs6bKCKK3bYNlcPDo3ZkjnYSwb5LSly7TZD
	cBeEdBphtjjplozOet8mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755504248; x=1755590648; bh=LNvIM431twoZOupygQQzHuiZqlwtEMuo7aa
	US+jvExU=; b=XFgsRTOfqh6KPt8Uf1TpOMXnMIYB1WKP6+Bd9xhksjN7as5Rnjs
	jWvZSsQ3qGxMlDnxZzihtcZYoB44/jxKqJZAebqWsjYhDYZ8Qd8JRN7DJPVxdIEI
	e1mu3XF56VE5Xl2+urMvYFWP0EJSOsoHlnfVYcsyVnSvlsBzU9Iw7OnqF5M3Uy9C
	TC20mrh+N5wRLL5P5gQDJgvHAqgEBSaosGl/pMMiIQti0OyCMpspyCbSFl41iUxg
	7BOFfIcbESSfDlFW06Avk9JviESrHXCbLJ9Ks4b/I0/zNh+FBAdyNsw7B/XGSSks
	/TD2eNs9MfLKmdkDy5YRkZAX1q07x9OrU5g==
X-ME-Sender: <xms:d96iaGoVlQoPxfxT2cJ3rMps6f2ZCmDTOXbmWSgw87OKkDG6aKk2Hg>
    <xme:d96iaKxenrfKcwrggBWkhPenTS6NMc8BWjLQ4GBfS0F0MPhziXYxkSCMmJSswBwm-
    ZzEqcsaYH6T7z9-QM0>
X-ME-Received: <xmr:d96iaAx_yJAAEv3nCpbhVjVgJ6pppKxQk7gVgebU75-D2ReIGjaRc-l2k7tu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhihiguhgrnhdriihhrghose
    hhohhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnhdr
    khhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepug
    grvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeht
    ghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhh
    grthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopeig
    keeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:d96iaJR9uJQkWOW58lSneZUyCW_TQPHiKoe-5MW2jpbQqXRVJ6C9Xg>
    <xmx:d96iaDM3PUvwYC5yYZdQ8rggSIM_oUV3TlNScFfjgzVWW1cLH59upQ>
    <xmx:d96iaESWavow_MeYO_V32Ri3VT6WgpihO5vJDrfSivQ0veIZVMGX4w>
    <xmx:d96iaO9pS_fisH2SNs4TfgWfeHerX8VD5V8K90Kvl6jK2Uq2cwLpPA>
    <xmx:eN6iaN9aEpjUBg3yivlNcAdPedpShAsGmk7wY_GgzT9Kne9pQtvsR9G3>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 04:04:06 -0400 (EDT)
Date: Mon, 18 Aug 2025 09:04:04 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Shixuan Zhao <shixuan.zhao@hotmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: support VM area addresses for
 tdx_enc_status_changed
Message-ID: <xqi2bkulnhen2vax5msbzczlaywx3dsc7ezpn7oo5qn7u7xzap@xmaseinov7tf>
References: <enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva>
 <OS9PR01MB15202207C488796172F1F179B8D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS9PR01MB15202207C488796172F1F179B8D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>

On Fri, Aug 15, 2025 at 02:18:34PM -0400, Shixuan Zhao wrote:
> Sorry got the Message ID wrong. Resending it.
> 
> > Could you tell more about use-case?
> 
> So basically I'm writing a project involving a kernel module that
> communicates with the host which we plan to do it via a shared buffer.
> That shared buffer has to be marked as shared so that the hypervisor can
> read it. The shared buffer needs a fixed physical address in our case so
> we reserved a range and did ioremap for it.

So on the host side it is going non-contiguous. Is it going to be some
kind of scatter-gather? Seems inefficient.

What sizes are we talking about? When do you allocate it?

If it is small enough and/or allocated early enough I would rather go
with guest physically contiguous. 

> > I am not sure we ever want to convert vmalloc()ed memory to shared as it
> > will result in fracturing direct mapping.
> 
> Currently in this patch, linear mapping memory will still be handled in
> the old way so there's technically no change to existing behaviour. These
> memory ranges are still mapped in a whole chunk instead of page-by-page It
> merely added a fall back path for vmalloc'ed or ioremap'ed or whatever
> mapping that's not in the linear mapping.

You cannot leave the same GPAs mapped as private in the direct mapping
as it will cause unrecoverable SEPT violation when someone would touch
this memory. For instance, load_unaligned_zeropad()

> tdx_enc_status_changed is called by set_memory_decrypted/encrypted which
> takes vmalloc'ed addresses just fine on other platforms like SEV. It would
> be an exception for TDX to not support VM area mappings.
> 
> > And it seems to the wrong layer to make it. If we really need to go
> > this pass (I am not convinced) it has to be done in set_memory.c
> 
> set_memory_decrypted handles vmalloc'ed memory. It's just that on TDX it
> has to call the TDX-specific enc_status_change_finish which is
> tdx_enc_status_changed that does not handle vmalloc'ed memory. This
> means that when people call the set_memory_decrypted with a vmalloc'ed,
> it will fail on TDX but will succeed in other platforms (e.g., SEV).

I don't know SEV specifics, but with TDX, I don't want to add support
for vmalloc, unless it is a must. It requires fracturing direct mapping
and we need really strong reason to do this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

