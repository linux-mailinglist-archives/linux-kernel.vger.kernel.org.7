Return-Path: <linux-kernel+bounces-811642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58790B52BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507DF168D49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7C2E54BF;
	Thu, 11 Sep 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK57PNrI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD12580E4;
	Thu, 11 Sep 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580083; cv=none; b=SeQPNEeg8r//2ZKWf+hh+PkRthzBGzJABXJV04MendWvgPhV9ynmpBrvU6LL1ihvx/P4DL24ModfckRUZwvpz7LUGZb0G+9x7QjwwdDDLCC5NexN9ADq03AWF6Upaii2XL0Iio8QFrfTjZOj1J9uVVM8fa7lKQTxcuJjsUEiWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580083; c=relaxed/simple;
	bh=njNtH9FhW2DlFoODAUIyk2oz+HJWD6+ZLPh16fXR9Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDUw3Uykxe+QJGJPa/wT2iiyntTAcJj7AezIyTUEgRYx1CKaVbsFWMsizcDrxWSoG6Q5li9wgOc6sUa4mKNtFltL6EUt+l5+cTCX27oKGq9SWeaTg08pPq8tG7RbFT67Q68P8512BIvjb86TO+XiN7pNb7CMyqxulkiBySNuLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK57PNrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5B7C4CEF1;
	Thu, 11 Sep 2025 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757580083;
	bh=njNtH9FhW2DlFoODAUIyk2oz+HJWD6+ZLPh16fXR9Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HK57PNrIXzvvTfQ8/mtZgky6ZFIjKFWEOSNIYn9ZcUATwXcnY29BV/XFaW3Q9jvYw
	 aruvnuIWZzoovnYcM9+UF9uwji+aOmaCrEzVfmeyawPf6B17F45zgikOpMu6ZaPATB
	 8t6o/WnsjPisypWrXcKnnD+p03DlaLaVuFliO4wyPKy6pTiCHgZDIzEWuXwvBZKVe3
	 29r4ZR+zfez7QjaRbdOMPayAQgFze6YGig0SVVCDdRH1cWHiSJdCf6I5LH6thfG2zg
	 GDBTkQ8n/glZ9rPFx8aV4joLXtxkBPa3mMCvjmi9POo3y6q6Q3eKKIOMlqvWWeJCTC
	 rLOnHUdgGR6UQ==
Date: Thu, 11 Sep 2025 09:41:19 +0100
From: Lee Jones <lee@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: add driver for the eeprom in qnap-mcu
 controllers
Message-ID: <20250911084119.GF9224@google.com>
References: <20250730172248.1875122-1-heiko@sntech.de>
 <20250730172248.1875122-3-heiko@sntech.de>
 <8721df1d-d8db-4b05-b450-107d936d8715@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8721df1d-d8db-4b05-b450-107d936d8715@kernel.org>

On Tue, 09 Sep 2025, Srinivas Kandagatla wrote:

> 
> 
> On 7/30/25 6:22 PM, Heiko Stuebner wrote:
> > The qnap-mcu also has an eeprom connected to it, that contains some
> > specific product-information like the mac addresses for the network
> > interfaces.
> > 
> > Add a nvmem driver for it.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/mfd/qnap-mcu.c          |   1 +
> >  drivers/nvmem/Kconfig           |   9 +++
> >  drivers/nvmem/Makefile          |   2 +
> >  drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++++
> >  4 files changed, 122 insertions(+)
> >  create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c
> > 
> In case Lee you want to take this via MFD,
> 
> Acked-by: Srinivas Kandagatla <srini@kernel.org>

Actually this patch should be split up.

I'll take the MFD part, you can take the NVMEM part.

-- 
Lee Jones [李琼斯]

