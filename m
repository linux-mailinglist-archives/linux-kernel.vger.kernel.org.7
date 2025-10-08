Return-Path: <linux-kernel+bounces-845338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E57BC4831
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E015A19E0FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CC2F619F;
	Wed,  8 Oct 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItsNtXB0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C82F6168;
	Wed,  8 Oct 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921801; cv=none; b=cBktaFT9d7R3XVG1QYdLCpy+5wPQqiMVD+xuD2fR1BbwFQ6zp/3nctO7poLPa7UNuoqIUrRs1DhQ3y8g5vr2pUe34PwCXXA05jTqsZBr1banoZmUj/og+P3g6noZwhHKX3CFXl5/wQj71QGNSZZzsBfSTVvhe5i0L1oF+FEuoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921801; c=relaxed/simple;
	bh=n5/diNwZRoFuwCO4P1Hp5ug4Zt0q4zG2ojtKzRbe3UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6KhzrdEv91vvz5KtVS8F0Ro6QCZJpxb8dicH7HwkVTyPybGet9ExzVxjZlpCSYhXSczpOWaDLz4VYRRXee7vIAWC9IR0czxM++e+PaIfqMqRMSMJe1LDeMPN5Ii5dwZnxnvX8FFAfy8yvNbd+V2Cb/qkMJspI72RRfpIAmQqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItsNtXB0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759921799; x=1791457799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n5/diNwZRoFuwCO4P1Hp5ug4Zt0q4zG2ojtKzRbe3UQ=;
  b=ItsNtXB0lRMdwcw3s+HTPPDksNaGZXn7OZnoUJZCxSf+3SPibg2uOuk9
   NG4BT2g+da+ZABrOF7EywvQYU+QmijT1qC3H/OQ/JZ0tBRB/uBoZ4jrsL
   9joLP/ZUKbYZLOUmjSm86TnsEFHNQfuYp6rdlBYKC1KSe6jVpWYz1Jl7P
   /tC6XH8skbAthGRDY5ahbdXHmIchhn6nyDCd6FzzbzWoarc6vsg9m3XB7
   O7BfglLVDCzZ2A06tpwstY9A4EXL7l6s+nOdWfT2BBe5sCq5XmDkfXTyy
   TFe1//d00oYTm7dl2QneSZwRWXFmnjhBW0+csqmdXyv/qheSc+jjD2+iK
   A==;
X-CSE-ConnectionGUID: TkEVDk9JTYmrw6+xYZhb2g==
X-CSE-MsgGUID: 9F5tyfziTqqwGSDAogtwrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62154348"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="62154348"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 04:09:58 -0700
X-CSE-ConnectionGUID: LWQRulO9RpGWy0jNTtSnQg==
X-CSE-MsgGUID: zK1Hcg2SR1S24IFwYh5k+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="211063918"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa002.jf.intel.com with SMTP; 08 Oct 2025 04:09:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 14:09:53 +0300
Date: Wed, 8 Oct 2025 14:09:53 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
Message-ID: <aOZGgZc1F968uoR6@kuha.fi.intel.com>
References: <20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com>
 <20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com>

On Thu, Oct 02, 2025 at 10:55:39PM +0530, Krishna Kurapati wrote:
> Enable VBUS on HD3SS3220 when the ID pin is low, as required by the Type-C
> specification.

There is not ID pin on Type-C connector.

> The ID pin stays high when VBUS is not at VSafe0V, and goes
> low when VBUS is at VSafe0V.
> 
> Add support to read the ID pin state and enable VBUS accordingly.

I'm a bit confused about this... Why can't you just check the attached
state, and if it's DFP, then you drive VBUS?

thanks,

> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  drivers/usb/typec/hd3ss3220.c | 58 +++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 3ecc688dda82..44ee0be27644 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -54,6 +54,11 @@ struct hd3ss3220 {
>  	struct delayed_work output_poll_work;
>  	enum usb_role role_state;
>  	bool poll;
> +
> +	struct gpio_desc *id_gpiod;
> +	int id_irq;
> +
> +	struct regulator *vbus;
>  };
>  
>  static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
> @@ -319,6 +324,28 @@ static const struct regmap_config config = {
>  	.max_register = 0x0A,
>  };
>  
> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
> +{
> +	struct hd3ss3220 *hd3ss3220 = dev_id;
> +	int ret;
> +	int id;
> +
> +	if (IS_ERR_OR_NULL(hd3ss3220->vbus))
> +		return IRQ_HANDLED;
> +
> +	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
> +
> +	if (!id) {
> +		ret = regulator_enable(hd3ss3220->vbus);
> +		if (ret)
> +			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
> +	} else {
> +		regulator_disable(hd3ss3220->vbus);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int hd3ss3220_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };
> @@ -354,6 +381,37 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>  	}
>  
> +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
> +	if (IS_ERR(hd3ss3220->id_gpiod))
> +		return PTR_ERR(hd3ss3220->id_gpiod);
> +
> +	if (hd3ss3220->id_gpiod) {
> +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
> +		if (hd3ss3220->id_irq < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
> +			return hd3ss3220->id_irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(hd3ss3220->dev,
> +						hd3ss3220->id_irq, NULL,
> +						hd3ss3220_id_isr,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						dev_name(hd3ss3220->dev), hd3ss3220);
> +		if (ret < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get id irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");
> +	if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
> +		hd3ss3220->vbus = NULL;
> +
> +	if (IS_ERR(hd3ss3220->vbus))
> +		return dev_err_probe(hd3ss3220->dev,
> +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
> +
>  	if (IS_ERR(hd3ss3220->role_sw)) {
>  		ret = PTR_ERR(hd3ss3220->role_sw);
>  		goto err_put_fwnode;
> -- 
> 2.34.1

-- 
heikki

