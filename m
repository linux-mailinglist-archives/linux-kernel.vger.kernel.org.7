Return-Path: <linux-kernel+bounces-890906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3985C415A9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9381618889B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25433BBBD;
	Fri,  7 Nov 2025 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wm+Oa9C6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9833B964;
	Fri,  7 Nov 2025 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541691; cv=none; b=jkY1xxdYjxza5rSofW9ivJh8OOZjOYA5gIf97pL06K4vtDDCEu498fMA4Z1vFFQbXF7jZSmOxCjhvtUpLk6HxVJDdNt0G5nCxbNtPfnCFZchXSvXbkxrGYO7ny9UBcve6Dx6U3KOLmg3JC1OXrMc0j71csiFgwimCzCnOCC6Dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541691; c=relaxed/simple;
	bh=T5Rw6eWbPlE27qTm/Y51A5DLe5CKLXrJE8yBA6UrFuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHeP3Q/T5KYF7iaWDDKdctcdYNC7174tqdyg67LnaLxSbDvSAkRnVZLw8jMkZfZjkBpoSj9dHpKGaesUlvIvD4PnF7YoxM4UEu6/D8BIeEhLYuxUwbSasCo2/f+yqAcIdgidmgsFetFkDXjv2aBNOR8IVwBKWKSdYuAjGKLM+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wm+Oa9C6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 5891B111F;
	Fri,  7 Nov 2025 19:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762541570;
	bh=T5Rw6eWbPlE27qTm/Y51A5DLe5CKLXrJE8yBA6UrFuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wm+Oa9C6Gi4k4YZUlAj74M3wS8m7LFsTeP8uiJemarhggDXSx0cAHpWMnLk5pFtGL
	 czvnQ4dmulBRace93soXdOvIr7hInH9xghsFxPHOY8pIwWDr0nZd5/Qd7cToxKGqmx
	 fx5nvc+2KOD5qgHhY4wmsZ0zyFgl40HA+c0fXv3o=
Date: Fri, 7 Nov 2025 20:54:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Collabora Kernel Team <kernel@collabora.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v14 00/18] media: rockchip: add a driver for the rockchip
 camera interface
Message-ID: <20251107185441.GG5558@pendragon.ideasonboard.com>
References: <20240220-rk3568-vicap-v14-0-b38b6da0fc80@collabora.com>
 <aQ4tJg8r_j4NyKhv@kekkonen.localdomain>
 <074cd08e-0412-49f9-8dd9-b1f96eb11717@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <074cd08e-0412-49f9-8dd9-b1f96eb11717@collabora.com>

On Fri, Nov 07, 2025 at 07:41:59PM +0100, Michael Riesch wrote:
> On 11/7/25 18:32, Sakari Ailus wrote:
> > On Fri, Oct 24, 2025 at 02:51:29PM +0200, Michael Riesch via B4 Relay wrote:
> >> Habidere,
> >>
> >> This series introduces support for the Rockchip Camera Interface (CIF),
> >> which is featured in many Rockchip SoCs in different variations.
> >> For example, the PX30 Video Input Processor (VIP) is able to receive
> >> video data via the Digital Video Port (DVP, a parallel data interface)
> >> and transfer it into system memory using a double-buffering mechanism
> >> called ping-pong mode.
> >> The RK3568 Video Capture (VICAP) unit, on the other hand, features a
> >> DVP and a MIPI CSI-2 receiver that can receive video data independently
> >> (both using the ping-pong scheme).
> >> The different variants may have additional features, such as scaling
> >> and/or cropping.
> >> Finally, the RK3588 VICAP unit constitutes an essential piece of the
> >> camera interface with one DVP, six MIPI CSI-2 receivers, scale/crop
> >> units, and a data path multiplexer (to scaler units, to ISP, ...).
> > 
> > I understand both RK3568 and RK3588 include an ISP. Do you have insight on
> > how would this work, should the support for the ISP be added later on?
> 
> Short answer: Yes and yes.
> 
> Long answer:
> 
> The patch series at hand adds support for the PX30 VIP and the RK3568
> VICAP. I cannot really say something about the PX30, but on the RK3568
> VICAP and ISP are orthogonal (the ISP features its own MIPI CSI-2
> receiver, different from that introduced in this series). Thus, ISP
> support can be introduced anytime (whenever someone is motivated ;-)).

Won't they both be connected to the same sensor though, and probably the
same D-PHY in the SoC ? They don't seem entirely separate to me.

A block diagram that shows connections between the CSI-2 pins, D-PHY,
CSI-2 receivers, VICAP and ISP could help.

> Once this patch series is merged, I'll push out changes that introduce
> support for the RK3588 VICAP. We can discuss the integration of any
> RK3588 ISP in this scope then -- and there may be some things to discuss
> as there the VICAP and the ISP(s) are directly connected by means of a
> MUX unit in the VICAP.
> 
> Alright?

-- 
Regards,

Laurent Pinchart

