Return-Path: <linux-kernel+bounces-887513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB21C38673
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AB93B4EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F35299959;
	Wed,  5 Nov 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqsbypnA"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999834CDD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386504; cv=none; b=sgXheyWKyHAQCNtuxLueweFFBrbZB1R+aCajfa1EBapFgOm4qW3WNXOs64cZxf+6ha8h01zVmOJmGKOId47jPP42aL3f5xEhK53ju3w8QGBmVVnkx4BBraq9hExReQyO+eiXfwlPeiZzeHZB6NzP112nh4ADTZf3k4PUbHsr4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386504; c=relaxed/simple;
	bh=IerwUs4b8vCvMYT/DUMBbNciSzk/60E524tHHpgwBL4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IbEbtiGOEgf79+XLgZIS/geI+gxXLTjo0nEiOJhcooeY6+f2ZhQw4Rcl1AXFULbShuz8QAiQkh730QSEAwflpjMZzcIuu6aEvO+OJvAAUuV4K2mi8kXUxGE5Mf1kBc/ebfJkCMU8JEwF1PPYfqYLPV5tDj5LukgsCblNOy3ljJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqsbypnA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 28DB41D001A0;
	Wed,  5 Nov 2025 18:48:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 18:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762386500; x=1762472900; bh=iL1AwDM7kx6YHcSejLAreDgPqBEkWAdgZYG
	eamSbBxQ=; b=BqsbypnAjKiIAbMMn/CdDYr/lUyu81RJ3J6tvYW0CfUD7UFK8wi
	WFfHyjl7ndYYJ0yJfWKvFzw9T7i22Y2Ps7pOZyL7eQZm1GXLOGWLde6fqDMMAFO2
	9jq+PUC0dr5G8ghwevqkLK8Aa4OuOXMAeLu6vR0U7wmlw71/WJAsNQeBi0YtjeH/
	gfyXe+jWrqjMk+YgNS7h/kUNpjB4S65oFtunTGXXqw/rTdgn8DhWXyubXUlCmd06
	dAqmrydecHr2hfJcV+TlkoVtDoTqQHVUdVqm4Yi76OrN3CBt0jLto+nw0CF9xo4x
	KbsTg9JUvsL3A1VeQLg7zzVOqk0/DIQWbaA==
X-ME-Sender: <xms:QOILaXHDnKUFbN5gRMkkY1gFF1iqRSTg5OkgULU1Yo_M86Rvr0d-8w>
    <xme:QOILaQIotELrML6VX3biXMNLM_FiLuhuXQvtwevB_alpDlpIUqxJSUj4H2gok7BLT
    uxxeGmjkYfTj5VyJAXXOHcHP9fwPL3qbzpKwKcXFi_A4rKrVkMMjeA>
X-ME-Received: <xmr:QOILaUgO0Kh3EHeCMiy6AfoFGLxycJEj8sHXlDHlQH7zw9jfcqZx-IYLe66vd5DGyrpujQ5r8mFeZBS2F8YmltOmm4XtfAMPBJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghu
    pdhrtghpthhtohepuhhsvghrmhehjeeshigrhhhoohdrtghomhdprhgtphhtthhopehmph
    gvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshgrmhesrhgrvhhnsghorhhgrdhorhhgpdhrtghpth
    htohepsggvnhhhsehkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtohep
    lhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QOILaekBeZqQ34ee6nqZKo8TihAZVfcf41875ffwpDjtg7h2-IR3Ew>
    <xmx:QOILabW8k5RXAufkjwiA2hhYLAoccfcdTmRyAqbnaKivt58wEWHa-w>
    <xmx:QOILabvITBYGXTFuPsrsayWcM-DIhhkt3bwKXDALhISFoACLGyPO0g>
    <xmx:QOILaW6HBnsgeo6MfgEDnOq4hDesmwC59UVkndb4Hb-10c0acM2w8A>
    <xmx:Q-ILaVkizhPhNiiYGMXZnL8T9JiM8izl-rAv8Ayl5scQjEpHWPd5I_n9>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 18:48:13 -0500 (EST)
Date: Thu, 6 Nov 2025 10:48:25 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com, 
    sam@ravnborg.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, 
    linux-kernel@vger.kernel.org, rdunlap@infradead.org, 
    Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
Message-ID: <6c805c35-a23d-569e-42ef-f3d875997048@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey> <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org> <aQgJ95Y3pA-8GdbP@gallifrey>
 <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 5 Nov 2025, Christophe Leroy wrote:

> > I wonder if bodging those in lib/fonts/Makefile for 
> > lib/fonts/font_sun8x16.c fixes it?
> > But... this is data - there's no code is there - are any of those 
> > flags relevant for data only?
> 
> I think -fPIC is relevant for data-only here because font_sun_8x16 
> contains a pointer to fontdata_sun8x16 in font_sun_8x16.data
> 
> I see two things to try:
> 
> 1/ Either build font_sun8x16.o with -fPIC
> 
> diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
> index e16f68492174a..844306d7b15e9 100644
> --- a/lib/fonts/Makefile
> +++ b/lib/fonts/Makefile
> @@ -20,3 +20,5 @@ font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
>  font-objs += $(font-objs-y)
> 
>  obj-$(CONFIG_FONT_SUPPORT)         += font.o
> +
> +CFLAGS_font_sun8x16.o             += -fPIC
> 
> 2/ Or add a PTRRELOC:
> 
> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
> index 7f63f1cdc6c39..fc461cfaf4a34 100644
> --- a/arch/powerpc/kernel/btext.c
> +++ b/arch/powerpc/kernel/btext.c
> @@ -20,6 +20,7 @@
>  #include <asm/io.h>
>  #include <asm/processor.h>
>  #include <asm/udbg.h>
> +#include <asm/setup.h>
> 
>  #define NO_SCROLL
> 
> @@ -463,7 +464,7 @@ static noinline void draw_byte(unsigned char c, long locX,
> long locY)
>  {
>  	unsigned char *base	= calc_base(locX << 3, locY << 4);
>  	unsigned int font_index = c * 16;
> -	const unsigned char *font	= font_sun_8x16.data + font_index;
> +	const unsigned char *font	= PTRRELOC(font_sun_8x16.data) +
> font_index;
>  	int rb			= dispDeviceRowBytes;
> 
>  	rmci_maybe_on();
> 

Patch 2 has the virtue that it only needs to be tested on powerpc.
Patch 1 has the virtue that other architectures might benefit.

Commit 0ebc7feae79a ("powerpc: Use shared font data"), which caused the 
regression, has a sparc equivalent in commit 0f1991949d9b ("sparc: Use 
shared font data"). So I wonder whether CONFIG_EARLYFB has also regressed 
(for CONFIG_SPARC64). Maybe QEMU could help answer that question.

