Return-Path: <linux-kernel+bounces-725458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B768AFFF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EDB56208D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D332D8778;
	Thu, 10 Jul 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJnlh27k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B219CC28;
	Thu, 10 Jul 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143680; cv=none; b=hSIwnsw5t3mFG2rzosHN6GJ2tGG/TYUki6vfaGpPSPEE667BhtZDGN4fUFsM5h2xMNlePNCkIficsoSpAO8RRgVeJrgzDV8yR6RgnE29SMmNMc6I2HZGD0lzu9gIpygaKRq+uJWhdm4KLpqlwGW9GbuFszO4W2B+54r9Tp6TUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143680; c=relaxed/simple;
	bh=qDuxNYZrcLuS5OsHxaF8sdrwSmQbHr+wqAD9aSemGkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5ySQ3TB88fWG7IFkpaIpti+XhBRC/8GXD4EWG51xTvCM1GuwO+jq2W65DjgR3XC716Cl0efA6prZ1BFr/N0WdXIeZXSyi5OoXtOSo06NXRZH1GiuS7fQ+o0TGi/xOunIa6PSqu58leB48Aa0LA6zCd/bqzLrkINi3RfR5TraZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJnlh27k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A06C4CEF1;
	Thu, 10 Jul 2025 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752143680;
	bh=qDuxNYZrcLuS5OsHxaF8sdrwSmQbHr+wqAD9aSemGkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJnlh27ke1OuipZoJTDs9vRnN4ZbcF0sZFYk74llWBunHsBKu43rjc8vshla6rLtN
	 TkpE6xo3BEFwt5Gmmi5Qkyt8iL0mYE2ixuVaRMZlCT3DRveUbdwV84FLULwxBhO5BV
	 JObNPiuwc5pZxteU4SpOCjenOcyPJsnY1vWEnHOZI/xrm+5qKkrG1MYuAasqI2Ieaf
	 DSdNA8fclilLohdqPhqMdCcYSNAjwJQPZNFhe731SbEEpu5ps6lZ9yRwxyZMqKcV4a
	 mJTvituubiSCyhVqOPfmSGHRSWsK5dqT1pDIvCxmMHUOTPj0e/sGBiMZZKposfbqRG
	 6KUpk4iCjkAYA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZobp-000000008C2-08Dx;
	Thu, 10 Jul 2025 12:34:33 +0200
Date: Thu, 10 Jul 2025 12:34:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Ryan Mann <rmann@ndigital.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] NDI FTDI USB driver support
Message-ID: <aG-XOXPcT3kFxKQg@hovoldconsulting.com>
References: <YQXPR01MB498735732651163477C995B9DF49A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQXPR01MB498735732651163477C995B9DF49A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>

On Wed, Jul 09, 2025 at 01:50:15PM +0000, Ryan Mann wrote:
> From: Ryan Mann (NDI) <rmann@ndigital.com>
> 
> NDI (Northern Digital Inc.) is introducing a new product called the 
> EMGUIDE GEMINI that will use an FTDI chip for USB serial communications.
> Add the NDI EMGUIDE GEMINI product ID that uses the NDI Vendor ID
> rather than the FTDI Vendor ID, unlike older products.
> 
> Signed-off-by: Ryan Mann <rmann@ndigital.com>
> ---
> V1 -> V2: Email-to issues fixed
> V2 -> V3: Email formatting issues fixed, removed future devices
> V3 -> V4: Email formatting issues fixed, removed extra comments
> V4 -> V5:	Diff whitespace issues fixed,
> 			Restored the Aurora SCU device mapping that was removed

> +	{ USB_DEVICE(NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
> +		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },

I was going to apply this, but turns out it does not even compile.

Sending completely untested patches like this is really not acceptable.

> +#define FTDI_NDI_VID			0x23F2

Also change your Subject to use the common prefix ("USB: serial:
ftdi_sio: ..." when respinning.

Johan

