Return-Path: <linux-kernel+bounces-892593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BADC45681
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE59C3A307B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315A2FCC12;
	Mon, 10 Nov 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtUO7Ng1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B872727EB;
	Mon, 10 Nov 2025 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764231; cv=none; b=GUkO0rckjkr9QUHrYW00QWpRmNaKR3eq7ZeCr7gR5w+YHWr+W/VuAB67MUUN71LfzhHoE5/Gd7HblRe99IgFDRUFSnV7jii8H7GZEqXilE0TUzbuXDTYGFS+/L4uzdrI1WvsKvrZxiXuxXLYG5/j/wl8NfMTviP0P8E7+FIIU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764231; c=relaxed/simple;
	bh=BZIz3Z5lFEoz3mPVfqf21yTcEuTnJH/qD2n8KFXgBnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFmey80+mQz1yuU9l3fDW1t+DDANrF48jQ6wDY9w/yGFKj+BvYx8m40arUK9pwebrbvcEwjlDhMbvF1XmCpHGv54cTLPCa9lPSb24pPw2VJlhLKP03E01vmtpYTc1KTMyBrkYrZNrN65QNYc57Wr5zFXMQpLuv+chZr3Nhn3iYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtUO7Ng1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762764230; x=1794300230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZIz3Z5lFEoz3mPVfqf21yTcEuTnJH/qD2n8KFXgBnw=;
  b=ZtUO7Ng10cizJ0IG+ALYwMt5uV6KezW/m0tSzdisz5ophl6z7C1MDeaB
   Om3A7c0VnqbAd96I/aUyhi45mJ5hcOr109l9XcEhO2pAY5CXDffdv0v+Y
   qGhVCT6mwAQOsEkw2d68OMdDjgyp9RsvG69s6IsmRbjAJ/hR6xTJ1BAl1
   dHCrJrPKBTre4ijBo81fNhsvjzG5YCnrrq0syxGJ7bAnsms8JmwkM7l3V
   HVKPWtFdKXL7fyNQsCiCcvvABzvTzN0Sj+g2eYikxE4Ew2ZSzt0X9BbGv
   ofmWuqsto15YfJGG/5NArCn389H6Fo0TCzmC7Xe29ce2SUTIqxomGKnAt
   Q==;
X-CSE-ConnectionGUID: FPaPhBe+RgmFqy57RWM24Q==
X-CSE-MsgGUID: nLjgBoflSHa3848cDQSamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75421180"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75421180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:43:48 -0800
X-CSE-ConnectionGUID: sNsYiFy4T+uyIn2RzpR7ZQ==
X-CSE-MsgGUID: maDAue3fSwqWlY0B6+ZFow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188455479"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.238])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:43:42 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A55521205FC;
	Mon, 10 Nov 2025 10:43:41 +0200 (EET)
Date: Mon, 10 Nov 2025 10:43:41 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
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
Message-ID: <aRGlvQRVoQs0WjyA@kekkonen.localdomain>
References: <20240220-rk3568-vicap-v14-0-b38b6da0fc80@collabora.com>
 <aQ4tJg8r_j4NyKhv@kekkonen.localdomain>
 <074cd08e-0412-49f9-8dd9-b1f96eb11717@collabora.com>
 <20251107185441.GG5558@pendragon.ideasonboard.com>
 <13c43edb-9592-4779-a39a-7856bb0f964d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c43edb-9592-4779-a39a-7856bb0f964d@collabora.com>

Hi Michael, Laurent,

On Fri, Nov 07, 2025 at 09:51:37PM +0100, Michael Riesch wrote:
> Hi Laurent,
> 
> On 11/7/25 19:54, Laurent Pinchart wrote:
> > On Fri, Nov 07, 2025 at 07:41:59PM +0100, Michael Riesch wrote:
> >> On 11/7/25 18:32, Sakari Ailus wrote:
> >>> On Fri, Oct 24, 2025 at 02:51:29PM +0200, Michael Riesch via B4 Relay wrote:
> >>>> Habidere,
> >>>>
> >>>> This series introduces support for the Rockchip Camera Interface (CIF),
> >>>> which is featured in many Rockchip SoCs in different variations.
> >>>> For example, the PX30 Video Input Processor (VIP) is able to receive
> >>>> video data via the Digital Video Port (DVP, a parallel data interface)
> >>>> and transfer it into system memory using a double-buffering mechanism
> >>>> called ping-pong mode.
> >>>> The RK3568 Video Capture (VICAP) unit, on the other hand, features a
> >>>> DVP and a MIPI CSI-2 receiver that can receive video data independently
> >>>> (both using the ping-pong scheme).
> >>>> The different variants may have additional features, such as scaling
> >>>> and/or cropping.
> >>>> Finally, the RK3588 VICAP unit constitutes an essential piece of the
> >>>> camera interface with one DVP, six MIPI CSI-2 receivers, scale/crop
> >>>> units, and a data path multiplexer (to scaler units, to ISP, ...).
> >>>
> >>> I understand both RK3568 and RK3588 include an ISP. Do you have insight on
> >>> how would this work, should the support for the ISP be added later on?
> >>
> >> Short answer: Yes and yes.
> >>
> >> Long answer:
> >>
> >> The patch series at hand adds support for the PX30 VIP and the RK3568
> >> VICAP. I cannot really say something about the PX30, but on the RK3568
> >> VICAP and ISP are orthogonal (the ISP features its own MIPI CSI-2
> >> receiver, different from that introduced in this series). Thus, ISP
> >> support can be introduced anytime (whenever someone is motivated ;-)).
> > 
> > Won't they both be connected to the same sensor though, and probably the
> > same D-PHY in the SoC ? They don't seem entirely separate to me.
> 
> The MIPI CSI-2 DPHY is shared, indeed. Thus, they *maybe technically
> could be* connected to the same sensor, but I don't know whether that
> works and fail to see why anyone would to such a thing (if it is about
> raw capture, the MIPI CSI-2 receiver in the ISP can do that on its own).
> 
> The DPHY can be operated in split mode, with two lanes for VICAP and two
> lanes for ISP. This is not implemented yet, but can be done at a later
> stage on PHY level (not media related). In this case, ISP and VICAP can
> receive data from different subdevices via CSI-2.

The two would be part of the same media graph in that case and as there are
two CSI-2 receivers and a single PHY, the PHY would probably need to have a
sub-device as well, to allow link configuration to be used to select where
the PHY is connected.

I don't think we have such a setup elsewhere, and supporting this would
require changes in the MC framework.

How does the media graph look like for the device at the moment?

> 
> BTW the ISP is able to process the data captured by VICAP, but
> apparently this includes a RAM round trip (VICAP captures to memory, ISP
> operates in mem2mem mode).
> 
> > A block diagram that shows connections between the CSI-2 pins, D-PHY,
> > CSI-2 receivers, VICAP and ISP could help.
> > 
> >> Once this patch series is merged, I'll push out changes that introduce
> >> support for the RK3588 VICAP. We can discuss the integration of any
> >> RK3588 ISP in this scope then -- and there may be some things to discuss
> >> as there the VICAP and the ISP(s) are directly connected by means of a
> >> MUX unit in the VICAP.
> >>
> >> Alright?
> > 

-- 
Kind regards,

Sakari Ailus

