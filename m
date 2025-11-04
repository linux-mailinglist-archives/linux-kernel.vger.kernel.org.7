Return-Path: <linux-kernel+bounces-885289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBDC327E4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151C73B2E90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0523933B95C;
	Tue,  4 Nov 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="FR7PPXiR"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EF2D7DC0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279157; cv=none; b=WtNPDuavfFc94UWd/X4YgAog2p70iFn9wlaTv4yOrfQh8YfMghQOv1+Nz2sKtFfwtDOZz0vwG/1LXCjB+DMQrv9kH6UTlCdrf/r+9Dc2pCd4wAlpe4mN6+pLafQ2tez8PcGh8/PIkVE34jfGbFdm1X25HUbYSPq1+FvN0Uz9nRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279157; c=relaxed/simple;
	bh=vlobM313B1VdZJBATZK2pcRUJ2dE6lyciVzZaQ1W3TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJf8I5ub2oyW8mSrdkWAV5crT05TZUaFs4sBTQOFGKjpeiOgvSnVEb06H32odFzPU2/dYgubx46y8js1xz+47KoIr/RskfSp8T0TLuI2ksY0rhHbXCRB8QkMC/1mnObkHqWnPiVRpi9WeApcQJTT+bf0lDa4nLvVIWTYYNBIee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=FR7PPXiR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=J2T93GZ4iRg/mXaOUM2wPtUcrFT6Ce80fUC5fly//tg=; b=FR7PPXiR6QTPHE7f
	JNYRc8Pv8zmiwEXXZZiML1cGSQ/67sPPxC66c5986choXJCJQo2Ts6kk7lb3rrYmlCaIiOPc5tdyY
	rVA8BmEjDqmB3Gkxkwyd8DUVarGegVTrbeqf2d9QgYSTM9swAM/yh5ORVzF+6AbkLCwM0PN7vBG4p
	bz1WV6OvaTJwt9BrRtr0MLWSqRH76f+MelLBCGGDq2pMw9XVY5EmJx2w+M4UEK15Q1gqH1EduPO7J
	ZZjgdX1ul6cXtnbc4nPt9CosEDsAXm+8DZsV1yyYgQtlYe3TXN/Ttte/H5O8dG6R2r4zYpYcdkKdq
	59PqQ6+C8O/NfqOByw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vGLJ7-000000020YW-49uU;
	Tue, 04 Nov 2025 17:59:02 +0000
Date: Tue, 4 Nov 2025 17:59:01 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, sam@ravnborg.org,
	benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rdunlap@infradead.org,
	Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
Message-ID: <aQo-5T8z2nwtNe2p@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
 <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
 <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 17:58:36 up 8 days, 17:34,  2 users,  load average: 0.02, 0.02, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Finn Thain (fthain@linux-m68k.org) wrote:
> 
> On Mon, 3 Nov 2025, Dr. David Alan Gilbert wrote:
> 
> > 
> > > Anyway, I imagine that the problem with your patch was that it relies 
> > > on font data from a different (read only) section, which is 
> > > unavailable for some reason (MMU not fully configured yet?)
> > > 
> > > So I've asked Stan to test a patch that simply removes the relevant 
> > > 'const' keywords. It's not a solution, but might narrow-down the 
> > > search.
> > 
> 
> Stan tested my patch to remove 'const' from the font_desc and font_data 
> structs but it did not help. (There goes that theory.)
> 
> > I wonder if this is a compiler-flag-ism;  I see 
> > arch/powerpc/kernel/Makefile has a pile of special flags, and for 
> > btext.o it has a -fPIC (as well as turning off some other flags). I 
> > wonder if bodging those in lib/fonts/Makefile for 
> > lib/fonts/font_sun8x16.c fixes it? But... this is data - there's no code 
> > is there - are any of those flags relevant for data only?
> > 
> 
> I don't know. But I'm sure Stan would be willing to test a patch for you.

Can one of you point me at the config you're testing with so I can
try some builds with it.

Dave

> > > 
> > > The BootX bootloader doesn't work on New World systems, which is 
> > > probably why we don't see this regression on anything newer than a 
> > > Wallstreet.
> > > 
> > > It's likely that other Old World systems are also affected, if they 
> > > are using BootX. We don't yet know whether the regression also affects 
> > > Old World systems using the iQUIK bootloader instead of BootX.
> > 
> > OK, remember I don't think I've ever tried PPC via MacOS booting, so not 
> > familiar with it.
> > 
> 
> I will try to set up a MacOS guest in QEMU, to see if the hang can be 
> reproduced that way.
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

