Return-Path: <linux-kernel+bounces-890825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D2C410CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D17E3AC6AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E021335561;
	Fri,  7 Nov 2025 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UctZZkL5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2098331A79;
	Fri,  7 Nov 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536757; cv=none; b=osgJ7sDjY5K4HHd+SqowX39OXTjsAQuV5DKSGyLJuDCMjlUdsxhgFPhFiyoLm807CKSSQlPZjDSShK4sg0Mfd9LnXk7O5ZwBOz6EcNeGwI1i5pyVWKztfkaFsI6peI6qv3T45rkEVC24axQw0vuqS3dW8Q47ypk+NSOCbC0xCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536757; c=relaxed/simple;
	bh=br/yoQcXazpIhba0JM9br+2Xu+ekNSGhpyy+fjDbUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnu6utkrpKfKtglZQySYvTrrjsse25X2C1J712qOK5ldmULGS/xLDRMJj2dkbgFlVrDMFwuk4EEYunUfLlJezhtA/6/UZ3raJpUbb3YTrcxfVXAKpGlHkVrhLXk91lZSyvSTq791bzApHrHfqETL/F6Oz4R0GHT6RkV09EMaqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UctZZkL5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762536756; x=1794072756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=br/yoQcXazpIhba0JM9br+2Xu+ekNSGhpyy+fjDbUQs=;
  b=UctZZkL5koKMojkM5bfVDVrOHTThROa/jxDccYX45TiHiq22QvoFrtIu
   MzKauQ3A0Tr7N4dmYMq6aauDUEJXAcapnywnzNSNb4LjLQkykpuBvXkCQ
   0FQHY7nKzyhuLmk3A+Mxwdr1C4QQxwiC9KLx7eFh+cf9d55Fdj6IcPzni
   /fHD35ekTFitl8N1CpVespRvcc2kAUaExs7FCmV6b+nYEBmVc2uXdBUR2
   6/zrGbfXReWcORw7cpxSSNSTcOywWPeIAx0vVGVq/7y7g33LX/i6kkxU/
   0WvffRev8Solm01k9OX2F9SMUxoFKqis4VjSoYm05aTozRKM+M/yb1ynU
   g==;
X-CSE-ConnectionGUID: LolPIA3qQ6SrEyh14arZtA==
X-CSE-MsgGUID: puYFi6/cQCOHLqRxIjSOeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64729508"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64729508"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:32:35 -0800
X-CSE-ConnectionGUID: olbkBok6TgOZIIyj+YRicw==
X-CSE-MsgGUID: fEjkLyDgQ8C+BXPOdvpQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="192185843"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.117])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:32:26 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D3FDF11FC72;
	Fri, 07 Nov 2025 19:32:22 +0200 (EET)
Date: Fri, 7 Nov 2025 19:32:22 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: michael.riesch@collabora.com
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <aQ4tJg8r_j4NyKhv@kekkonen.localdomain>
References: <20240220-rk3568-vicap-v14-0-b38b6da0fc80@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-rk3568-vicap-v14-0-b38b6da0fc80@collabora.com>

Hi Michael,

On Fri, Oct 24, 2025 at 02:51:29PM +0200, Michael Riesch via B4 Relay wrote:
> Habidere,
> 
> This series introduces support for the Rockchip Camera Interface (CIF),
> which is featured in many Rockchip SoCs in different variations.
> For example, the PX30 Video Input Processor (VIP) is able to receive
> video data via the Digital Video Port (DVP, a parallel data interface)
> and transfer it into system memory using a double-buffering mechanism
> called ping-pong mode.
> The RK3568 Video Capture (VICAP) unit, on the other hand, features a
> DVP and a MIPI CSI-2 receiver that can receive video data independently
> (both using the ping-pong scheme).
> The different variants may have additional features, such as scaling
> and/or cropping.
> Finally, the RK3588 VICAP unit constitutes an essential piece of the
> camera interface with one DVP, six MIPI CSI-2 receivers, scale/crop
> units, and a data path multiplexer (to scaler units, to ISP, ...).

I understand both RK3568 and RK3588 include an ISP. Do you have insight on
how would this work, should the support for the ISP be added later on?

-- 
Kind regards,

Sakari Ailus

