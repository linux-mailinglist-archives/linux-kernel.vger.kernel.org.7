Return-Path: <linux-kernel+bounces-890189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002DC3F6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A71AA4ED824
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155A3054F7;
	Fri,  7 Nov 2025 10:29:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78030302153
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511368; cv=none; b=TPPIQInYva1pfzDsHXLkDLV12Owbq8jAcXp4WNFJg0fiqap/x7d20cUgacZh9/qjG+weJcej3luNCHc8yp7BsViQ61o51u7wjR0aQ8oYdTAVblQ/OusnUs0YWdFc5YGFRGLdiHC0jofnwqFndHYO3WhgyBVDq3f5G25yODF1aiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511368; c=relaxed/simple;
	bh=un5jB38nNfcxcQCZhGvBHLmnuv1wxPpeWfZ8V/nLx9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY3tAGniRE8uyI6zPh3S8QAyhfXve3Q5BVligReKVFSnAobt5O5jIzYfrHB9w2sy4Qyt1SJAyiqhzIGYoBCwLXgmQzlstgIojRXGHJRvzq6yuH4EnrAgZHjEYdsokEGfVLIRwLRkO1Vqd2tgPizLySU2qkROH2VbTnI+x5L27To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vHJiZ-0005vM-Kg; Fri, 07 Nov 2025 11:29:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vHJiY-007Vqn-2Q;
	Fri, 07 Nov 2025 11:29:18 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vHJiY-006lnh-24;
	Fri, 07 Nov 2025 11:29:18 +0100
Date: Fri, 7 Nov 2025 11:29:18 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <aQ3J_rJV-hB2nh91@pengutronix.de>
References: <20251105143814.1807444-1-o.rempel@pengutronix.de>
 <20251105143814.1807444-3-o.rempel@pengutronix.de>
 <5c618c00-f7f1-4260-8970-7c493d50315e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c618c00-f7f1-4260-8970-7c493d50315e@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi David,

On Thu, Nov 06, 2025 at 10:57:26AM -0600, David Lechner wrote:
> ...
> 
> > +/**
> > + * ads131m_rmw_reg - Reads, modifies, and writes a single register.
> 
> Any reason we couldn't turn the read/write into a regmap and avoid
> implementing extras like this?

I thought about regmap, but it is a poor fit for this chip.

The problem is the device protocol. It is not a simple register-based device;
it is a frame-based protocol that uses opcodes.

-  Hot Path (Data Read): The main data read (in read_raw) does not access
registers. It sends a NULL opcode frame to read all channel data at once.

-  Cold Path (Setup): Register access (RREG/WREG) is a complex, stateful
3-cycle operation. It is only used in probe for setup.

This leaves two (bad?) options for regmap:

- Mixed Access: Use regmap only for the cold path (probe) and use raw
for the hot path (read_raw). This is messy because we mix two access methods.

- Virtual Registers: Try to model all opcodes (NULL, RREG, WREG) as virtual
registers. This is a very unnatural abstraction for this chip.

Using the regmap dependency just to replace one rmw function that runs only
once at probe seemed like the overkill.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

