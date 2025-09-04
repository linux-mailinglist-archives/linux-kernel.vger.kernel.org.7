Return-Path: <linux-kernel+bounces-800183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7EB4344F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186D9188A1E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244F2BE7B8;
	Thu,  4 Sep 2025 07:34:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F129E113
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971282; cv=none; b=cC5rYMwqO3fYugW5bDjN0QWhjeTCtqzm+obmwMYm1Kv6qBITfZiijFxzjHcv8Xudc4d1ZE7YQtGgD9/kBeCz1L5QKKryLn1w1HZzLVkPhHZLLbBhr7b7AuBqm8yW0GekvHT+T9pjUi0txpv+DzIpqF0g3r74LuSPcBVh/rqYSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971282; c=relaxed/simple;
	bh=9Lfs7x06aYUGDh170BRagUu5k+P060o70Hk6IG+sLGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4OzsS/ijb6EPe3wfmxLnzbIAauQQCjZBz3Of+rzWA883d7r+KFgANFQZeBHGrXmnNS817TGbr8Tk70IgMFr5JAyNuAAob27bwP4C+4/8KV9P/IKwM4Al0oo64qjfWOqe4oXRRkqTKe5A/wUWt6RL2s+8dXtsXSRmlqRpA9NUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1uu4UF-0006Gq-DD; Thu, 04 Sep 2025 09:34:27 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uu4UE-003gug-3D;
	Thu, 04 Sep 2025 09:34:27 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uu4UE-0025QG-2n;
	Thu, 04 Sep 2025 09:34:26 +0200
Date: Thu, 4 Sep 2025 09:34:26 +0200
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
Message-ID: <aLlBAuYoHIJZLfiE@pengutronix.de>
References: <20250903-clk-cdce6214-v6-0-b2cc0a6f282b@pengutronix.de>
 <20250903-clk-cdce6214-v6-1-b2cc0a6f282b@pengutronix.de>
 <20250904-arboreal-upbeat-iguana-aebba6@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-arboreal-upbeat-iguana-aebba6@kuoka>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2025 at 09:18:13AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 03, 2025 at 03:55:45PM +0200, Sascha Hauer wrote:
> > Add device tree binding for the CDCE6214, an Ultra-Low Power Clock
> > Generator With One PLL, Four Differential Outputs, Two Inputs, and
> > Internal EEPROM.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/clock/ti,cdce6214.yaml     | 198 +++++++++++++++++++++
> >  include/dt-bindings/clock/ti,cdce6214.h            |  24 +++
> >  2 files changed, 222 insertions(+)
> > 
> 
> I don't understand what is happening here.
> 
> Patch changed in weird and unexplained way - nothing in the changelog
> explains dropping SPDX - and does not pass even checkpatch.

I removed the SPDX by accident, will add it back of course.

Other than that, what's weird? Changelog says I now use the pinctrl
subsystem to configure pins. OK, that also changes the binding, I could
have mentioned that explicitly, sorry for that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

