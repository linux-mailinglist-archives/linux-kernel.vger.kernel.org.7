Return-Path: <linux-kernel+bounces-749478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4029B14ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88D17A30CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B491A4F12;
	Tue, 29 Jul 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JCYskDSC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554C259C;
	Tue, 29 Jul 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797368; cv=none; b=NOO7QoviCTspbI4zntZ6KlDfdaeaB5jZsT/AXDd+5W2qsofTNGfPrghMVJxcR/WiVz0WBHMUFPBHMUBFHQJmVuseBuwH4Flfhds1O+PfcDgjxCWpheRbw3QorlyfF6XNOibo52RQLs8KoWcHA4/6L6SZtUrymnW0yJhYxQQjJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797368; c=relaxed/simple;
	bh=BETeNN46Ajzeu2NTK/WCecO1X5HEYVNEksT8795g6/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT7+N9E/tFRz9X3UkABxP4NcDcVhXaCUu2RXuhKU8LRCHkXbmnua8sYaRaoIHIyP4Rw606VOZVkWSw+Rv1ah5GLs6T7ilBrhuGRlUXPr5IYoCcZhwA3q4TwihpcMuqzpH3KZM+rTBIMCUqn4IbufeCfPSAddrSvfWlDS+fHhZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JCYskDSC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TQdxKKVZ1GM7fhQqDu7S5KrsXU0ul66dbGYdSM5AmB8=; b=JCYskDSCGBuSczNjpjsQY5I19S
	KpaMTZOPRKIXZthIe0Ra+XbS+f14yNgQyF8RpCcM5UssF9/mKrNKvv3Fb3Yyv+m+qDKbiJsklw8zE
	eSBvljolvU6qo5fWYda0ckU8D4odrrnb81PLnQ48bG2eMZqCjwGD/vxbOl+vXSTo2Qq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugko2-003CMb-PD; Tue, 29 Jul 2025 15:55:50 +0200
Date: Tue, 29 Jul 2025 15:55:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fred Chen <fredchen.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] ARM: dts: aspeed: santabarbara: Adjust LED
 configuration
Message-ID: <bc6b2174-e7b9-44c2-8232-51a3accff2d0@lunn.ch>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
 <20250729091351.3964939-4-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729091351.3964939-4-fredchen.openbmc@gmail.com>

On Tue, Jul 29, 2025 at 05:13:45PM +0800, Fred Chen wrote:
> Add a new power fault LED on GPIOB5 and relocate the ID LED to GPIOQ4.
> The ID LED is now driven by the CPLD, allowing it to reflect multiple
> system states depending on CPLD logic.

It would be good to add a comment about why this is not an ABI
breaking change.

	Andrew

