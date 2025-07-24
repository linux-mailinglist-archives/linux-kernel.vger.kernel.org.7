Return-Path: <linux-kernel+bounces-743379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F690B0FDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660411CE025D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E706FC3;
	Thu, 24 Jul 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FFjMXEE0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EC1362;
	Thu, 24 Jul 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315432; cv=none; b=T+3S1dylt1regUhPRjBr4LYi+utyHmTPm8TNOuxu589ftAu0gp0FLUwOhmnblkCIAtZ5aDVcp//8qPOvSCDwhjvxW2yc3tqCRuSsNUBVdibKuYEINoowDN2/rRypQD3Zt/66AvSvSaUKUx28xN7u7TRdNahPq3LuByrKEhbXQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315432; c=relaxed/simple;
	bh=mqCXqFAUkwR5ZJBO7H5kiZwhtz2lwVY344Ks3ls0Cek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW5q/YI64IKN6CD0snLvqXP+ItBCy8XTFMh+zCGzZV4JH8SpjF8XLMzsyRXQD9sWjDaaToZXT6hilHlQNV2wTJp9DFhFybuYYEYRIf9GODXg+r7T5d4KrdMj3gVWfPNnFf3Fzhz44Jbee8cpeFYeSeGgyppjjXNPFf00duvcNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FFjMXEE0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wdMyNpyczdlOF7zghQKC0llIb5aOLp+CiZl88HV1/CY=; b=FFjMXEE0dft5Mn5To34aMAJvr8
	FHxoLBZ+8iDP57LHB1cR5amgeViOAMJdI0zlKqag8LggouCHo55dVo9BBj3SgM/KamWMM6K2Fk0Cd
	kDuszKOEo5VSLCKafxlGKhsjfMOevUJP5Md+PFzLd5xH5RdqPMbiO++iN42cyFe19FGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uejQf-002hyY-0O; Thu, 24 Jul 2025 02:03:21 +0200
Date: Thu, 24 Jul 2025 02:03:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723233013.142337-11-rentao.bupt@gmail.com>

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";

Does the PCB have extra long clock lines to implement the 2ns delay?

	Andrew

