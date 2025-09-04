Return-Path: <linux-kernel+bounces-800661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9BFB43A35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3332E1C2852B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FBE2FD7A5;
	Thu,  4 Sep 2025 11:32:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996C2EB84B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985528; cv=none; b=XaxqG3Sb5lb15xYn34+isqhXtiZoauy2aFHZF+cXOGysTg58I0IHvZj4EJgROa8F9FVfyxwhjqUwLlazEc62b2bFlWiww3YtnU6PqMyR5Nan4nu219wj0E0XwuxaLbWONVGX40npi+2pBkp1G2mmoBpMpdGjmBkIvht9lCIlh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985528; c=relaxed/simple;
	bh=Q2qBJPDf2nMSdqr38T/UuOwrbPDS9xsdvLR7qAJBjW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O87mUPL9Z/T2lbLEayaLAAoWNNnRH0/vDNWox0BMUBXIqVruEWCiqsttwTFybDAPLe5X46xTFxy6eFxYK/XBIYx4VIsfCfyNp8/RgPVCEqiUOfTmGFkRov2J5KX/Pa0zQ3hsyrQ1C1TlQ/eQycWifn7vzqtkAsRNpACHpi5lwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1uu8Bz-0005GV-Pu; Thu, 04 Sep 2025 13:31:51 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uu8Bz-003iZT-1g;
	Thu, 04 Sep 2025 13:31:51 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uu8Bz-0029s9-1E;
	Thu, 04 Sep 2025 13:31:51 +0200
Date: Thu, 4 Sep 2025 13:31:51 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Alvin =?iso-8859-15?Q?=A6ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH v6 1/2] dt-bindings: clock: add TI CDCE6214 binding
Message-ID: <aLl4p9hFp7l9dy1c@pengutronix.de>
References: <20250903-clk-cdce6214-v6-0-b2cc0a6f282b@pengutronix.de>
 <20250903-clk-cdce6214-v6-1-b2cc0a6f282b@pengutronix.de>
 <20250904-arboreal-upbeat-iguana-aebba6@kuoka>
 <aLlBAuYoHIJZLfiE@pengutronix.de>
 <2c7fefb2-9a0c-451f-84f6-dc5a19707699@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7fefb2-9a0c-451f-84f6-dc5a19707699@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2025 at 11:43:53AM +0200, Krzysztof Kozlowski wrote:
> On 04/09/2025 09:34, Sascha Hauer wrote:
> > On Thu, Sep 04, 2025 at 09:18:13AM +0200, Krzysztof Kozlowski wrote:
> >> On Wed, Sep 03, 2025 at 03:55:45PM +0200, Sascha Hauer wrote:
> >>> Add device tree binding for the CDCE6214, an Ultra-Low Power Clock
> >>> Generator With One PLL, Four Differential Outputs, Two Inputs, and
> >>> Internal EEPROM.
> >>>
> >>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >>> ---
> >>>  .../devicetree/bindings/clock/ti,cdce6214.yaml     | 198 +++++++++++++++++++++
> >>>  include/dt-bindings/clock/ti,cdce6214.h            |  24 +++
> >>>  2 files changed, 222 insertions(+)
> >>>
> >>
> >> I don't understand what is happening here.
> >>
> >> Patch changed in weird and unexplained way - nothing in the changelog
> >> explains dropping SPDX - and does not pass even checkpatch.
> > 
> > I removed the SPDX by accident, will add it back of course.
> > 
> > Other than that, what's weird? Changelog says I now use the pinctrl
> > subsystem to configure pins. OK, that also changes the binding, I could
> > have mentioned that explicitly, sorry for that.
> 
> There were four patches before, now there are two and changelog says
> only about pinctrl to configure pins. That's very vague and you expect
> me to decipher what changed in the bindings.

In v5 I tried splitting the driver/bindings up into a basic part which
and a part which added the pin config stuff in the hope that the first
two patches could be applied first. This was not very well received, so
I merged it back.

I am aware that the binding looks quite different now, but this really
goes down to using the pinctrl bindings now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

