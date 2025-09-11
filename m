Return-Path: <linux-kernel+bounces-812310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7EB53611
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C896563FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CF134321C;
	Thu, 11 Sep 2025 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJm2WOiw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45A3431E4;
	Thu, 11 Sep 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601873; cv=none; b=PVzUlloGyB5a7aC1Skr8gxsy2BaRRj+x4pY3lzXaUbReumabNpRb8kzsoD+pNuf6Zit67g+deubS/Aylw5SirfNp7b9aGrqqCEprdbZ91G7B0ClHWg0b3Kl1PPWQadFu8B1xifkkb8pzWsT8VRnpTvRiv5g8RA06zn6FWYGYIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601873; c=relaxed/simple;
	bh=lmmtnK8fJFLpac/RpjkQ9F3NKtL5pl6Ms4pIay15Owg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUhLBpSHoRqCw8R/R6C9Iuq2ODLn3Pm2vmpf5f8H+maWoJiayVdTbX3Ocqz8xQYZuRyynohssovnUeXjcK+tx7WT5d2badN2slSoAzgbflsH9kplu6Mx9P5q5YiJXi7+0h9zXVaT8ro8FhI14NO9PSsXR2A2L/u2ZqRNQy8+1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJm2WOiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4749EC4CEF1;
	Thu, 11 Sep 2025 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757601872;
	bh=lmmtnK8fJFLpac/RpjkQ9F3NKtL5pl6Ms4pIay15Owg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJm2WOiwIll1IOIO859Q8G3JU7MYIs/uUjDeOZ0SLERwPXoldqPhX/jvkbsFm/r9m
	 cHu1Jz7esykQZSginWKI8v4E/vaTZaEUdPfXf9R7I8SGalTBLoIaaFviP82NB9C0Ro
	 NJAbKhyUD/cKyY7ChvmSCLkD8ksi8wUDDbuCVjOzHrb3e33T5dQgJw2vc1LZixY7Fz
	 wyuYwDQGjVxm1uD8dErSh2p8lex8NUFpMbj7XbHYIEdOfJLahMatp6nOGHOaQRsI+7
	 v6tvmuLIWUyZfOcuaEJ4GCrOvToaIq7nRiMi6Pmup7SZ2iSmZZvAzfNpQ7y71TGLtp
	 /CCr2grOyk8eQ==
Date: Thu, 11 Sep 2025 15:44:28 +0100
From: Lee Jones <lee@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Srinivas Kandagatla <srini@kernel.org>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: add driver for the eeprom in qnap-mcu
 controllers
Message-ID: <20250911144428.GN9224@google.com>
References: <20250730172248.1875122-1-heiko@sntech.de>
 <8721df1d-d8db-4b05-b450-107d936d8715@kernel.org>
 <20250911084119.GF9224@google.com>
 <2273730.1BCLMh4Saa@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2273730.1BCLMh4Saa@diego>

On Thu, 11 Sep 2025, Heiko Stübner wrote:

> Hi Lee,
> 
> Am Donnerstag, 11. September 2025, 10:41:19 Mitteleuropäische Sommerzeit schrieb Lee Jones:
> > On Tue, 09 Sep 2025, Srinivas Kandagatla wrote:
> > > On 7/30/25 6:22 PM, Heiko Stuebner wrote:
> > > > The qnap-mcu also has an eeprom connected to it, that contains some
> > > > specific product-information like the mac addresses for the network
> > > > interfaces.
> > > > 
> > > > Add a nvmem driver for it.
> > > > 
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > >  drivers/mfd/qnap-mcu.c          |   1 +
> > > >  drivers/nvmem/Kconfig           |   9 +++
> > > >  drivers/nvmem/Makefile          |   2 +
> > > >  drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++++
> > > >  4 files changed, 122 insertions(+)
> > > >  create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c
> > > > 
> > > In case Lee you want to take this via MFD,
> > > 
> > > Acked-by: Srinivas Kandagatla <srini@kernel.org>
> > 
> > Actually this patch should be split up.
> > 
> > I'll take the MFD part, you can take the NVMEM part.
> 
> (1) the original problem was, that this patch essentially requires
>   "mfd: qnap-mcu: Include linux/types.h in qnap-mcu.h shared header" [0]
> to not break builds, hence was "supposed" go into the mfd tree after [0]
> got applied.
> 
> But as we're close to -rc6 anyway, we can also just move things after the
> next merge-window if that is better.
> 
> (2) For the splitting part, just to make sure I understand correctly, you'd
> like the part of
> 
> @@ -346,6 +346,7 @@ static const struct qnap_mcu_variant qnap_ts433_mcu = {
>  };
>  
>  static struct mfd_cell qnap_mcu_cells[] = {
> +       { .name = "qnap-mcu-eeprom", },
>         { .name = "qnap-mcu-input", },
>         { .name = "qnap-mcu-leds", },
>         { .name = "qnap-mcu-hwmon", }
> 
> to be its own patch for the mfd subsystem?

Correct.

-- 
Lee Jones [李琼斯]

