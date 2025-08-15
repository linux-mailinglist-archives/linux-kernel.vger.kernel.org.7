Return-Path: <linux-kernel+bounces-771208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C38B2842E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE85F620D16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C730E0EC;
	Fri, 15 Aug 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="RlpDpQfH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzao0zTI"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FD30E0DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276195; cv=none; b=PyzXgqqxxqTPfSjPd5tvPMD00Mu5chQVTPhGJ7fU11WMmOaARNvJuVxRMteV7y0BcGlxoBtPiS65Tijb+XIamEbiVoD+zSp/hDUe2+CM0LGqEm/MwXWiagE/lgViF6x6Nm+EByFeGDSmK75AFb/9JJstOay4vdffTd9zu8BayH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276195; c=relaxed/simple;
	bh=+FlQG/DjIKUOkKdcfEq45/ooGCmI5NprdmTHEjpyt+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUFbqp+9gPmKwOOWk4/nJSsRFj1t2cPXhuoE9BrmiPg5pha92+XPGdro42h3ngxQxhL5vNqyfYJPc32r3MU8XLFj0OeBbaSwPA5XMbJlqt9HkCIdRdhVYNgWZZjOhDGg9Lq8MGK3rS03FnDyKnUr/LPwdUYoeVuncQILB4M2GEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=RlpDpQfH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bzao0zTI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DEC32140005A;
	Fri, 15 Aug 2025 12:43:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Aug 2025 12:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1755276192; x=
	1755362592; bh=93jxO6hkXxhXRNYS0TAjxURrekS8HQ7iFocClvyhMK8=; b=R
	lpDpQfHrYOR3d6Z2XMjx/7r2cNAVHJ6HXwZFUk4G3s/bAt9/snbujhcMHe4Dfc4C
	BebS5VmyXW/0lyQmXVL9r+kZl1f9tWvceNL0z/LdbwJl4q89EaF3YkLvTGsSVBle
	YTlpsvYYUylwJN1nkNY6kkfoRsbm6h1NxLH61g7uZSv2VeE54yj0GVs5CGecENtc
	F/mi7+htfB8eyU3vXutthLeNcye7ZZ2f8lEn+XNbZnFGFfitHn+Y1Vk1p8lnGm8x
	BRsWOQNpeZhaSn/Y6T98T4fnzjgDSppUncm1HUqphYY7B+nLGpfz1JFdbN8K8S2D
	jvNWoSs7VAmUV0G+K++GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755276192; x=1755362592; bh=93jxO6hkXxhXRNYS0TAjxURrekS8HQ7iFoc
	ClvyhMK8=; b=bzao0zTITYu2LPq3hW9I2x+oJybYCyBPc0s1wHq2EIBI6TvWN7T
	4dax9UlatqVpXnZhg8GxxEIb3sAmHGg/r7vyx5daCyy25s6+YaYoQTh7a0vzvv+Z
	qZcpWd1vdctzLIggr2t5/bqG2ZzK469AJ58qOBcXn9MQ7XQiIVfxTZ7Y130jQ9zI
	V5zttNp3wl4x4gqAh9ww40I1eKEZzk0SP0yKvnPxHD/k+0gR+U7CbFsiyK2tgIIb
	4ivFRuhANylCHyAcXUSr73J1Vy2k99eq0095IQU5dVJm7STfpMOra5cnp8flfuxJ
	kmeO3/xBs+k0V70EqYHv82Vry1LdsE2IC+Q==
X-ME-Sender: <xms:n2OfaBB40LuAl31DQQ9A_BTsHkK8Q6FWGC8dbuDqYBtaPReG5EvwNQ>
    <xme:n2OfaKiPPUQFx8o4salKdXstSmCLpLEJf303RDfHm0DqiXTZS2MsUcPXkGEbIXe3k
    hTLyJ2DMpaMPkpyCIw>
X-ME-Received: <xmr:n2OfaDNt70qjb0Rsvsaxdnia3DQE4ouETo2qEidqj8dYHi0a2-VwOxyM-etf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhihiguhgrnhdriihhrghose
    hhohhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnhdr
    khhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkh
    hirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpth
    htohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdr
    tghomh
X-ME-Proxy: <xmx:n2OfaJZiWujIfqqU0mlYVzj3q01T3GW0fso9A0jdXXIsEru2-gcQrg>
    <xmx:n2OfaA_kR2m5o-yvhZbsrf_FKX4qjQnOXEz8f35GYrh6a09RNPXteg>
    <xmx:n2OfaE3D9wILjCNHbp8ne-D0f9uJhDx5aaKdXalRa0NawL3uhJDV6g>
    <xmx:n2OfaB2iO9ZBQs24VqW_b4im5VErWS8mUAFhGTBO5TAFmsLm5gpaJg>
    <xmx:oGOfaMCP18kHZ1eGA15VOD-EoFeGTI7XikzGfkXdmCnWjYC6uWUoCeaA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 12:43:10 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:43:07 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Shixuan Zhao <shixuan.zhao@hotmail.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: support VM area addresses for
 tdx_enc_status_changed
Message-ID: <enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva>
References: <OS9PR01MB15202A41CF04F0BBF8CE244B48D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS9PR01MB15202A41CF04F0BBF8CE244B48D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>

On Thu, Aug 14, 2025 at 10:34:02PM -0400, Shixuan Zhao wrote:
> Currently tdx_enc_status_changed uses __pa which will only accept
> addresses within the linear mapping. This patch allows memory allocated
> in the VM area to be used.
> 
> For VM area addresses, we do it page-by-page since there's no guarantee
> that the physical pages are contiguous. If, however, the entire range
> falls within the linear mapping, we provide a fast path that do the
> entire range just like the current version so that the performance
> would remain roughly the same as current.
> 
> Signed-off-by: Shixuan Zhao <shixuan.zhao@hotmail.com>
> ---
> Hi,
> 
> I recently ran into a problem where tdx_enc_status_changed was not
> implemented to handle memory mapped in the kernel VM area (e.g., ioremap
> or vmalloc). I have created a patch that tries to fix this problem. The
> overall idea is to keep a fast path for the current __pa-based routine
> if the range falls within the linear mapping, otherwise fall to a page-by-
> page page table walk for those in the VM area.

Could you tell more about use-case?

I am not sure we ever want to convert vmalloc()ed memory to shared as it
will result in fracturing direct mapping.

And it seems to the wrong layer to make it. If we really need to go
this pass (I am not convinced) it has to be done in set_memory.c

Sathya, I remember you did something similar for REPORT, right?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

