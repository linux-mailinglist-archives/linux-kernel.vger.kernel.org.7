Return-Path: <linux-kernel+bounces-882173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F7C29CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 168274E9F27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE8E27A46A;
	Mon,  3 Nov 2025 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XmbgW3S6"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7927A135
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134527; cv=none; b=A0VC2uXWDYs4L/TonZU0q/Iha+kFOIZOWumEOUKwKxNz0gRmxwzl3HUdXabdrpT9p3yUupfW99QkZHIaDzC4+JgyAXql4OIoDM7lKfQ0XMMMZA8nYQy3RFbkr1tsPpSAKmMeOxKVrEYLs7j+8WDINFyJ/2aNUxIF71N3ZQt0yLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134527; c=relaxed/simple;
	bh=VNjifc4beAKhf95qBl71+1nj8WFLRt5F42DJlTYYoKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ50FTBTH1VbuGfyCDfCURgFRCVDzQZGO3iqE7XpDyfAZTv/jGRnBhiznlQujPHHFc+izHwYYOp4kNTxZfqIvZ/cYMaZAbK6RZk+6WXuTaJOHJwXvgti43kjbag0h8x5ITrbA7a6bY1gtdo3v19lkdLNcdKFRkxiIGuDmVJ0UeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XmbgW3S6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=l4/ObVuIt7UOD/QW6630dekGZj3RSJD8DWfo2+YTWOk=; b=XmbgW3S6VCsRsm46
	1LTsab+aVcjrj1ts/Y3mnJOlWtNz6hHwWGQLpRBXWYAKAfQ1EqEhN139HehE19dhw8tFXRrsa8JKB
	l8SapWvl2IQcscJFHyOwbW6L9LrrGIOEzPmh8+S6VRgRi4UAiK448c+3ihAd9DeecaPV6F0sudqp9
	NEgrWmmeg5u9PIJSXmfZpzCQVWCCHl+XYqUTtn8Qjzuad710o8matxi2MFlw0vNOWRi1rdOBEKAJp
	0WW9p0LSHfvIoc0I66uZ8GJC2E9v+a83rSYbFSTAhikuk6TCHmComVdd0rSB4bYVjf7Rmg9dFkkwo
	mPj/FrCR90qp1lvTqg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vFjgV-00000001ajA-1fNO;
	Mon, 03 Nov 2025 01:48:39 +0000
Date: Mon, 3 Nov 2025 01:48:39 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, sam@ravnborg.org,
	benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rdunlap@infradead.org,
	Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
Message-ID: <aQgJ95Y3pA-8GdbP@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
 <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 01:43:41 up 7 days,  1:19,  2 users,  load average: 0.02, 0.04, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Finn Thain (fthain@linux-m68k.org) wrote:
> 
> On Sun, 2 Nov 2025, Dr. David Alan Gilbert wrote:
> 
> > 
> > So I'm not a PPC person specifically; so lets see if the PPC people have 
> > any suggestions, but:
> > 
> >    a) Do you know if there's any way to recreate the same hang/works 
> > combination in qemu; I know it has a g3beige model but I don't know how 
> > to get something similar to your failing combo.
> > 
> 
> I guess we could probably reproduce this in QEMU if the BootX bootloader 
> could be made to work there. In theory, 'qemu-system-ppc -M g3beige' might 
> work.
> 
> >    b) Can you get any diagnostics out of the prom on the mac?  Like a PC 
> > or anything to have some idea where it hung?
> > 
> 
> Well, that's the problem: if you enable the CONFIG_BOOTX_TEXT diagnostics, 
> the system hangs instead of printing stuff. If you disable the 
> CONFIG_BOOTX_TEXT diagnostics (in favour of serial diagnostics) the hang 
> goes away.

Ah, a bug that doesn't like to be seen :-)

> Anyway, I imagine that the problem with your patch was that it relies on 
> font data from a different (read only) section, which is unavailable for 
> some reason (MMU not fully configured yet?)
> 
> So I've asked Stan to test a patch that simply removes the relevant 
> 'const' keywords. It's not a solution, but might narrow-down the search.

I wonder if this is a compiler-flag-ism; I see arch/powerpc/kernel/Makefile
has a pile of special flags, and for btext.o it has a -fPIC
(as well as turning off some other flags).
I wonder if bodging those in lib/fonts/Makefile for lib/fonts/font_sun8x16.c
fixes it?
But... this is data - there's no code is there - are any of those flags
relevant for data only?

> >    c) Is this only the Powerbooks that are unhappy - are other Macs OK 
> > with this - if so, wth is the difference with a powerbook?  Is it a 
> > different debian config or something?
> > 
> 
> The BootX bootloader doesn't work on New World systems, which is probably 
> why we don't see this regression on anything newer than a Wallstreet. 
> 
> It's likely that other Old World systems are also affected, if they are 
> using BootX. We don't yet know whether the regression also affects Old 
> World systems using the iQUIK bootloader instead of BootX.

OK, remember I don't think I've ever tried PPC via MacOS booting, so not
familiar with it.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

