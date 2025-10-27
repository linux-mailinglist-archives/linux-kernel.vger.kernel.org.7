Return-Path: <linux-kernel+bounces-871252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1628C0CBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E826B4EEEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A02F3C23;
	Mon, 27 Oct 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjKodgkv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021A21C9EA;
	Mon, 27 Oct 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558440; cv=none; b=J2wotItIyGlmoCbo16Nc+j0SwGtM7mSjszDFYvg0Hv0BZAsfwC/sznJ7FSl/SskKT9ikEhXsWwSWVMEI+E1/3VwD+B9D8y32qDe9/EzELVPeQwGYi6E4rVvzTBrm9YezPslNXufXj/3toP2GFSqMPoffaSw96rEPS3VY25zrCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558440; c=relaxed/simple;
	bh=faa2cQcfLf6hpl8zKtuxUCBPMHs3+hOE11+oivyBG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6aAgsASOK//Xgnj7Sazzv9vVc3KHgXt/4s9BKrD/PortUywwYxeGZwQK2suhn6LQjC0TJZt7F7bQAMETMyULyRTsspzbk4XETpvDToGps6I9xc0uyHE/Jgzuqrxfj2lOlO60yZsEJ3l2U4jq4n5ySNXOTqDjoE2GCs+nz2mAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjKodgkv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761558439; x=1793094439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=faa2cQcfLf6hpl8zKtuxUCBPMHs3+hOE11+oivyBG6k=;
  b=hjKodgkvVqFYTQjhyikn0TOBeY4x51kzHbdh7fyJowaIfezZZP09rFX6
   QIs6Qs0rGIe3EqxAho+5QtE9Fdx4uCl5v/SoVmsU5/iMftTcPMEkJ6TVE
   DKWTpNYmmC8lklhme4z45Cf+LQE3L0T7WjHNxZ01MLMDgsXjmp/iO6Kli
   IL2vlmZXCyjLttSe0E0r8eD/2K2YGAOO5Tc7tBSaP2Ere1rUGaoFR7ief
   8QeONQEKtnRaGTsy1R5frduzEcMVtvzPfCTsyYj5ZdT846w3pvV2+Q+/5
   9oLkuIfoIyHU0J8TyAv915fnaWPfCszm6/xn0Y8mVPeaCIhY7LmZ2Ld1g
   w==;
X-CSE-ConnectionGUID: N0/7vDdgTz+1wdS+oWZ7ug==
X-CSE-MsgGUID: WRSvJdtCTMi2QN5dRMPKog==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51209448"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="51209448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:47:18 -0700
X-CSE-ConnectionGUID: AxDkbqphShuXwU+IDePHqA==
X-CSE-MsgGUID: MiHi4nbWSpuCoUAcpwV1aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185350911"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.222.172])
  by fmviesa008.fm.intel.com with SMTP; 27 Oct 2025 02:47:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 Oct 2025 11:47:13 +0200
Date: Mon, 27 Oct 2025 11:47:13 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID
 pin state
Message-ID: <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>

Hi Krishna,

> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
> +{
> +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
> +	struct device_node *np;
> +
> +	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
> +	if (!np) {
> +		dev_err(hd3ss3220->dev, "failed to get device node");
> +		return -ENODEV;
> +	}

So I guess that's the connector node. Why can't you just place the
regulator reference to the hd3ss3220 controller node instead of the
connector like the port controllers do?

That would allow us to do a simple devm_regulator_get_optional() call
that's not tied to DT only.

> +	hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, np, "vbus");
> +	if (IS_ERR(hd3ss3220->vbus))
> +		hd3ss3220->vbus = NULL;
> +
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +
>  static int hd3ss3220_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };

<snip>

> +	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
> +	if (ret)
> +		return dev_err_probe(hd3ss3220->dev, ret, "failed to get vbus\n");

I think you have resource leaks here. I'm pretty sure you need to do
regulator_put() somewhere. You are also leaking the connector fwnode
that was acquired just before this point..

>  	if (IS_ERR(hd3ss3220->role_sw)) {
>  		ret = PTR_ERR(hd3ss3220->role_sw);
>  		goto err_put_fwnode;

Get the regulator here after the above condition. Then add a label for
the regulator_put(). And you already have the handle to the connector
fwnode so use that one instead of getting it again:

        hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, to_of_node(connector), "vbus");

But do it like that only if you really can't place the vbus regulator
reference to the controller node. I would really prefer that we could
do a simple:

        hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");

thanks,

-- 
heikki

