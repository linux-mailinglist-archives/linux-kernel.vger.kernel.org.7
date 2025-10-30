Return-Path: <linux-kernel+bounces-878750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CEAC2167A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7BB4072D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04485368382;
	Thu, 30 Oct 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IWcG3iNL"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDC3678DD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844176; cv=none; b=Fg6MZqyhOk4EIQpI8J0XbtTCUGnf/+Od9hfwb6B0eEY/ocHYlfkCsfoXzEqR1NA+YUgYVZOnFjxNEOgyaOHisVLGVax/f2Z5H3+v2570ioww3b17upLnLyHiWq/t1+4mRH601mN8rgQ7o/LCB2sVmi12XqdBtZwPWPIfmESBSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844176; c=relaxed/simple;
	bh=6GHkFzyH1BADD3T7810o90spaD/Gqv8X6dakMukIAXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrR/3WgMlucdlw+h2b7PpvHdH0sQhBNKNR3JXuCG5RT86YJjPrcEdM+3/iwNz0hHAooOrNdmJOu6R5klUqr7rehK8II0MaxBuzPexl69sBUUl/fl9v1RZbEe30wztz06aqOYWWRgea1y7a2C+rjuBRFTVoqmvl/4QFmCculXE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IWcG3iNL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9E24AC0DABA;
	Thu, 30 Oct 2025 17:09:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0928460331;
	Thu, 30 Oct 2025 17:09:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF1D411808CCF;
	Thu, 30 Oct 2025 18:09:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761844171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ueUINSeERYMDlNo5jcT9YJikDS5HY4Egk6Xzi3ktbrk=;
	b=IWcG3iNLJg3miWAgUI4OIZJ0PqYFi7ScAgZyYXfaXb0VCfSv4wMA7gGuc6+YRIW6f0a4LW
	DWRjdNBGs99ci1NOHdaM945YZ+qONx6YUTI0/eOzljDj64x4x2N4IOf1guClxCF/3jZ55m
	hQIF+StGUWU5zgjyFVVn695K4JpUUDyzhYesax/JIR0mwQRu1dLIjrhZssGFA1xt1x3Qs4
	dEaPmPAzPiU8YHKA0gwVEnn3ukq/7Yfzn+KXuZTkUH8Eqc3g94qvbGVTrxnTjg6CahDX6g
	JNl7VOrmKQkDpYSfPpzOvFBXctQWvxbJLRt0fKEmT8CZnBWSw25vl36B2WEObQ==
Date: Thu, 30 Oct 2025 18:09:29 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: adrianhoyin.ng@altera.com, dinguyen@kernel.org, Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] i3c: dw: add option to disable runtime PM for
 DesignWare I3C controller
Message-ID: <20251030170929b5991b7d@mail.local>
References: <22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com>
 <20251016071051c3f647ce@mail.local>
 <aPCg0bFm4-DnmhAp@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPCg0bFm4-DnmhAp@shikoro>
X-Last-TLS-Session-Version: TLSv1.3

On 16/10/2025 09:37:53+0200, Wolfram Sang wrote:
> 
> > > Add a new Kconfig option, DW_I3C_DISABLE_RUNTIME_PM, that allows
> > > disabling all runtime power management (PM) operations for the
> > > Synopsys DesignWare I3C controller. When this option is selected,
> > > the driver skips all runtime PM calls such as pm_runtime_enable(),
> > > pm_runtime_get(), and pm_runtime_put(), keeping the controller
> > > permanently active.
> > 
> > While the quirk may make sense, it definitively can't be activated by a
> > Kconfig option. This should rather be tied to a new compatible string or
> > a property.
> 
> I wondered why this is a quirk, at all, and not default behaviour. Is it
> because it works with some RPM implementations and not with others,
> depending on the platform?
> 
> But even if that is the case, it might be worth to opt-in for power
> management instead of opting-out for buggy behaviour. Because I would
> not assume that IBI have been thoroughly tested when a new platform
> using this driver gets upstream. So, the buggy behaviour may only be
> recognized later. Or?
> 

I guess it depends on how the IP has been integrated on the SoC, hence
my suggestion to tie this to a compatible string. opt-in or opt-out, I
don't care too much but seeing this seems to work for AMD, we need to
keep the existing behaviour for them.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

