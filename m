Return-Path: <linux-kernel+bounces-863879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2AEBF9682
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6BE8508D63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1412749D6;
	Tue, 21 Oct 2025 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9gW+0r+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A6D515;
	Tue, 21 Oct 2025 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090720; cv=none; b=nDqQwCcrJ6I8l4tHiUszV3MFsuMpCTtitZI56zWrN3jkAz+8WNlYPGI0QTAhhMN6Wc3uEqH577qy14fIRRt5vYgfB61BEynHUMJzWz1dAQsEJURB9mugSgZGf99hwpVrxytvfG4evRmv2kEEmVAj9+8USRSYFMOLtrQYq9joRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090720; c=relaxed/simple;
	bh=s5b8JsPws/6buYmUD3YxYk879o+RIT+ObwFiZmy82Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qquhhpWFDjObY/lKb2TdzP5Zr25Cn7+44Wx3SY3naU2/6Rv96MlDkzfZoxwRLSnt2E1AfsTj1HSbYBtgdZt0p9XNjSdCwDuLBV0oKL5A0qZIG79GNbuGIE8Z7s4dsQ4SjcIc2K/oTvAc4Mm5IlTACDS9+g84Id9DzejtFculqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9gW+0r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA62C4CEF1;
	Tue, 21 Oct 2025 23:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761090720;
	bh=s5b8JsPws/6buYmUD3YxYk879o+RIT+ObwFiZmy82Os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9gW+0r+rbbLOsTDz/v9BsWaWaJR1tTj+cJCune9NLo0Qu1SY6hjmpF2tHSzW/O+w
	 NvZ7nozEVaUsnYjvOeQ4gLz2p1C6LZecwtFtadpjsjpoHqgDfPwXPco22qEppx4e+7
	 q3uF+XCKQHj1vW0AZpJ3T/doonQmx+lasdfa54GBP5hKQZR6LKwpWBfrUd9rSVvXYL
	 7CCxyOSFVfg66dIoLyO2Y+RgxwMqadf29/AQrRgtR7n6OpHs1ZY5LFEUS7zm6EueE2
	 zr59BGec8s9SjAVbzIk4LUHngELr3A6AzCtZ7+GSdjMBaumRgM3jCtgmS0O2+zN3Ek
	 PJ5kbt7JHMXUw==
Date: Tue, 21 Oct 2025 16:51:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
 <vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
 <christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
 <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 1/2] phy: mscc: Use PHY_ID_MATCH_MODEL for
 VSC8584, VSC8582, VSC8575, VSC856X
Message-ID: <20251021165158.5cb0bd94@kernel.org>
In-Reply-To: <20251017064819.3048793-2-horatiu.vultur@microchip.com>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
	<20251017064819.3048793-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 08:48:18 +0200 Horatiu Vultur wrote:
> -	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {

I think MSCC_DEV_REV_MASK is no longer used after this patch?

