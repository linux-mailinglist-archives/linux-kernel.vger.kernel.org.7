Return-Path: <linux-kernel+bounces-871659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F81C0DFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98681891D65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674429AB02;
	Mon, 27 Oct 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEEp38Gj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732528727B;
	Mon, 27 Oct 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571492; cv=none; b=oVKc1sg6KpijGI4iGKX+3+pmI5tFSE+T+igDtbAMDthPr/eNCdUb38F+pEq2T11+7eU8M5G98yZJb7gx9zqUN1Z2iuvBAhKfQahwlBtPR3/WaSUvsuUD4uG0qjj2EDahaYLT6pmHes04aKoGXjPrKDGykWTK8o/2vovC1QvMSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571492; c=relaxed/simple;
	bh=W9/MQBoV9l8yb26yTYT5WoQtZ832sVzXBDGoSSTXZOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyjqxFTdeDgP3Ybu5Lc2Ch6tItjsknr/soJ6Ml5fBhYTwgysyrxZTGx1LuO3fMfq/OIrxLXNWG7h1jZQS3UW+a/2iGIuOWK0s5GcCN+eRN5J3KKz0KCDUEUlc9ocxtAU8MkkHdPuN2nR3W9DMg0nUSJ6oleIYyPc0KwzlblAoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEEp38Gj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761571491; x=1793107491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9/MQBoV9l8yb26yTYT5WoQtZ832sVzXBDGoSSTXZOE=;
  b=jEEp38Gjxex4CIE6gNZt0BfcZgnwif04cNYcdCbd7jmWmReiUoWqGVrE
   wzl310O4fkWpm00IdCYtmGMiqnwSaWSu/aw6wTClhZJs/aQcvMABTSc6w
   AoxhsEvVnrnXYP9+GKCwnFC71kMCsX3BADWrw+wsRUvH/2B45VeXm5fAM
   aPQAm6j9v9TwTa5YGqJDU/6pmYruUbfQwmytYeT0aGMYbsOGljtOAjSEd
   0WjaYYE6aH0TsgUavsqDKK6+Cq4ExQ7oBEolVi5yoFmOXrILf5L1a/WuS
   hCrZNItwuHTrGS40OFQEuPbq0LzC/+bI3NYgO4LzxpyW4oB0mf14Vm3+U
   w==;
X-CSE-ConnectionGUID: UII35A/ZTvqDKjskaypyrQ==
X-CSE-MsgGUID: e+KuxH58Q7GK2AALkE5o1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67483467"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67483467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:24:51 -0700
X-CSE-ConnectionGUID: OzzNk+a6QXSe4LjLGkV3KQ==
X-CSE-MsgGUID: FO5tyBiIQWiPJ4sDAXL9IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="222253344"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.222.172])
  by orviesa001.jf.intel.com with SMTP; 27 Oct 2025 06:24:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 Oct 2025 15:24:45 +0200
Date: Mon, 27 Oct 2025 15:24:45 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID
 pin state
Message-ID: <aP9ynU8tDho5PBAx@kuha.fi.intel.com>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>
 <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
 <34atfkavrxtv5xdekrlhhkxx4rxs3ueclxrmou5pquym5fsycv@i7mv7ssdlm2v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34atfkavrxtv5xdekrlhhkxx4rxs3ueclxrmou5pquym5fsycv@i7mv7ssdlm2v>

On Mon, Oct 27, 2025 at 03:19:04PM +0200, Dmitry Baryshkov wrote:
> On Mon, Oct 27, 2025 at 11:47:13AM +0200, Heikki Krogerus wrote:
> > Hi Krishna,
> > 
> > > +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
> > > +{
> > > +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
> > > +	struct device_node *np;
> > > +
> > > +	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
> > > +	if (!np) {
> > > +		dev_err(hd3ss3220->dev, "failed to get device node");
> > > +		return -ENODEV;
> > > +	}
> > 
> > So I guess that's the connector node. Why can't you just place the
> > regulator reference to the hd3ss3220 controller node instead of the
> > connector like the port controllers do?
> > 
> > That would allow us to do a simple devm_regulator_get_optional() call
> > that's not tied to DT only.
> 
> But we have devm_of_regulator_get_optional(), it was mentioned in the
> previous email if I'm not mistaken. If we need, we should add
> devm_fwnode_regulator_get(_optional).
> 
> vbus supply is described as a part of the usb-c-connector schema, so
> it is not that logical to describe it as a part of the Type-C
> controller.

Okay, got it. This is OK by me then.

Thanks Dmitry,

-- 
heikki

