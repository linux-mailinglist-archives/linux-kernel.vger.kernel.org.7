Return-Path: <linux-kernel+bounces-771617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DDB2898A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AA05E6264
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339F92A1CF;
	Sat, 16 Aug 2025 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DtwVebt2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1292904;
	Sat, 16 Aug 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306178; cv=none; b=Ryh+Bs6Gli4VSKWSvNS5+NBMNE6sdzL3NPwe3/vrtmkMVnJN0u/FtlyabV8xsZEKB1NKmteiCARFHv7U7vocItDO2WlxUNOBFAhKzEl70UhmHVtu78nHumY1Xt7z9212ya13ka9mPZ6KoST8ndUR+G9s7zQxygUrzpqMYhq0rx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306178; c=relaxed/simple;
	bh=bdP6nxC1n1U4Koq+jqMh2c4Dcv9Pe823ljba5HI8hTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVTHDjlCUTjTYrPYwKM7pelLJCBSYB3f5s34x98KWS9xDhjriiKL7tYH4usrFuycxpgFS6iyu1LfZZPXWiFIXpBXWp45dNZc+bhD5dCGW+79xj12Alfl4/qA6hTN0v5/bghoXYypyZWOiV4SZvNO0rbGebQIrSjyWt9q/2ZRsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DtwVebt2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uL1GIBvtGp9qBxNEgGd9zVR3Ww4bteJizXBxx4LVKvs=; b=DtwVebt2cPukDWsmBxLRl1g78u
	DqhE4zATJgulz++m6XYvVtziVYvIva8IqXNIVL6e6nusqUoAoBwIoj/VEzHq9WN2Rva18nFtm3oTj
	n3MCpOlxE4z5lVZVRqcm/Y0gGM8bsjyo9Yr5/AbOcelka9ZkhUb1JFNC7PxJywNOKj44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un5Jf-004sU0-Qg; Sat, 16 Aug 2025 03:02:39 +0200
Date: Sat, 16 Aug 2025 03:02:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add device tree for mgx4u BMC
Message-ID: <21ee5045-632f-486c-962e-9e2963f60ed4@lunn.ch>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
 <20250815-mgx4u_devicetree-v1-3-66db6fa5a7e4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-mgx4u_devicetree-v1-3-66db6fa5a7e4@nvidia.com>

> +&mac3 {
> +	phy-mode = "rgmii";

Does the PCB have extra long clock lines to impose the 2ns delay?

	Andrew

