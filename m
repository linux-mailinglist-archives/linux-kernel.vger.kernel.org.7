Return-Path: <linux-kernel+bounces-725869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817BB004E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529411751D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73B271457;
	Thu, 10 Jul 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq/6skdK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA226E6FE;
	Thu, 10 Jul 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156758; cv=none; b=BQbg76+BlSkGzhiPBmYcQhPeaMvoG3WS6tAxysnf2zWm2UxCl1RAnal7XAvsC9SmCSdudBtfgr+wqNEg166SKs8Lj/Zu3uBGYG90YAVBsJTpP7C+tf8I0Y2AY9ufvnLjV9hou+ZomDVLJis2a7/BDUCAEHEZjMEDiUwdD7GByQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156758; c=relaxed/simple;
	bh=hRWA1stgEiaWzaJsDcQ+3AAkGxZ6m6AFgudodXL95AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCOC7sLnpKCfcsKprZVScA2g16yx+UdMEapEn0Y4eexNjofvwyP+l0nGqDEfHXUaZRx2RgR5DzKtaEBTrC/Qmgt21+83yPhpW8GpO9UjCqS+9MqVOyazW1TkUyyugJ+fFbVXBdVvyb3CpmNq34R5dOVBSkzdYqlYRoFKRchoRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq/6skdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873FCC4CEED;
	Thu, 10 Jul 2025 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156755;
	bh=hRWA1stgEiaWzaJsDcQ+3AAkGxZ6m6AFgudodXL95AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lq/6skdKxGeNS1yMR5UPRCs4cqMObSF8GkHRbcDhPLu7Df98rjITLI9Tj+ihHawgp
	 RSKvJKxwDDRrClcsXDhSrZ6rXwrvdfAkBi39nTJy0HOXWZs1UxeM8xNptEJaD+fr8m
	 tfa0mqP/GMgm2uy/CT1YBVxyk9E7mITbWfRu8QYbAGMBC0JBLBfbfCd2D7wurpwie6
	 lfDm906yuuRauaA9FT4rdMOqw8dsjNV09IsQZILWNvjVnokS9ckFTc83P+vXxoWFHw
	 CPc/CCdRcfpbEcsnPFOLB3Nte6Y4j/VWT4ls+6wPnvBvzza8jB4HbgASVVxOpMy5y+
	 5CBcUjgSqI4Dg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZs0j-000000004bb-1dVH;
	Thu, 10 Jul 2025 16:12:29 +0200
Date: Thu, 10 Jul 2025 16:12:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Ryan Mann <rmann@ndigital.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] usb: serial: ftdi_sio: add support for NDI EMGUIDE
 GEMINI device
Message-ID: <aG_KTRH0XfykZfKX@hovoldconsulting.com>
References: <YQXPR01MB4987F1E0DA41E689779E6958DF48A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQXPR01MB4987F1E0DA41E689779E6958DF48A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>

On Thu, Jul 10, 2025 at 01:08:00PM +0000, Ryan Mann wrote:
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
> V5 -> V6: Fixed typo in the VID caught by compiler

Now applied, thanks.

Johan

