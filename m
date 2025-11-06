Return-Path: <linux-kernel+bounces-888204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC1C3A2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0596542516C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23E30F819;
	Thu,  6 Nov 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrnOchfJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2D30E848;
	Thu,  6 Nov 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423519; cv=none; b=VwUriHR074Lb01Rithzsm6XEwujiUAwPPbFhOi0J1w4tTM4CCfwyGuVOdJC59iq5FnU6nOKlBjuwMpPYlaGeyp+uOljDjMVpMJvYqhGVHoAUe1HDi3KBYmOwJTWvBmfJWqho6NzYkkks9EWKZ8n5lNFq3/Sfbhldb6HeIxrg6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423519; c=relaxed/simple;
	bh=YWfPD6ERS7CRZ4S7egpNwL4TQ7anww/3U8sL9Mazjg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWulj9bjvnLjY48ZkGoj7lpafW1apHh+1qxhOuMkZcVqb8MFB4ifGo6bS84HbCJRPSnlI2vn2I/sC044ct1UCAYw3y0m9YwoUtViYZYfOOnuuNAGC6FJc8qchWxcA2YppxNyIK2GqnqVL02yS/Jvh4J2ZbZ5i1FdqX10tZJ+sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrnOchfJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762423518; x=1793959518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWfPD6ERS7CRZ4S7egpNwL4TQ7anww/3U8sL9Mazjg8=;
  b=IrnOchfJsuEBdiJI+3Qp8Z/fuW6T4i1EZKq99ORFsC4xHQbEQzdNvrwo
   F+ffjufiGcmoA5tDCB4WM283hJ4U80C6sGdNCb6DI4MrRJtotglk5QJ7L
   AxXsuCzYdJLRAVIvd9tACWTsql+3bTFR/4yqYFQqQGqSOg1Nsu/GhuwG5
   uyck8BhP299738oS6sOh1ndM4g+r6nCDIJg36rJqWv1WiGtzSHnrdxP7b
   NRzSo6s9GR2a20M/2RIDD1potNWMhAuyE6sHPq7papQqc0o3UQHPwhc1L
   mrNMX276/5D3+oMvfckjkYqcmBe5CagGp75q7IqJy6XyUgnFwxRzwCycS
   Q==;
X-CSE-ConnectionGUID: CM0SWtTlTJW2kvSH9Tf83g==
X-CSE-MsgGUID: jelJfvwkTo+CFxJ6hD4zIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67168873"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="67168873"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:05:17 -0800
X-CSE-ConnectionGUID: YX33hdY5TbmcTJAfU86JYA==
X-CSE-MsgGUID: A/A8oXilRGq1wZ0TAEdPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187383441"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.236])
  by fmviesa007.fm.intel.com with SMTP; 06 Nov 2025 02:05:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Nov 2025 12:05:12 +0200
Date: Thu, 6 Nov 2025 12:05:12 +0200
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
Subject: Re: [PATCH v6 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID
 pin state
Message-ID: <aQxyfjYosVd_kPKC@kuha.fi.intel.com>
References: <20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com>
 <20251102164819.2798754-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102164819.2798754-3-krishna.kurapati@oss.qualcomm.com>

Hi Krishna,

Sun, Nov 02, 2025 at 10:18:19PM +0530, Krishna Kurapati kirjoitti:
> There is a ID pin present on HD3SS3220 controller that can be routed
> to SoC. As per the datasheet:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
> low. This is done to enforce Type-C requirement that VBUS must be at
> VSafe0V before re-enabling VBUS"
> 
> Add support to read the ID pin state and enable VBUS accordingly.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  drivers/usb/typec/hd3ss3220.c | 72 +++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 3ecc688dda82..75fbda42eaf4 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -15,6 +15,9 @@
>  #include <linux/usb/typec.h>
>  #include <linux/delay.h>
>  #include <linux/workqueue.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_graph.h>
>  
>  #define HD3SS3220_REG_CN_STAT		0x08
>  #define HD3SS3220_REG_CN_STAT_CTRL	0x09
> @@ -54,6 +57,11 @@ struct hd3ss3220 {
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
> @@ -319,6 +327,44 @@ static const struct regmap_config config = {
>  	.max_register = 0x0A,
>  };
>  
> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
> +{
> +	struct hd3ss3220 *hd3ss3220 = dev_id;
> +	int ret;
> +	int id;
> +
> +	if (!hd3ss3220->vbus)
> +		return IRQ_HANDLED;

If you don't need this routine unless there is a vbus regulator, then
don't register it at all if there is no vbus regulator.

> +	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;

You still don't need to check for hd3ss3220->id_gpiod - this function
will not get called unless it's there.

        if (gpiod_get_value_cansleep(hd3ss3220->id_gpiod))
                ret = regulator_disable(hd3ss3220->vbus);
        else
                ret = regulator_enable(hd3ss3220->vbus);

Note:

If you are concerned that the reference to the id_gpiod may be
released before this routine is unregistered, then that condition will
not help. The hd3ss3220->id_gpiod member is _not_ NULL after the
reference is released.

If you need a specific order in which the references are released,
then you can't use the resource management (devm_*) to automate things
for you.

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
> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220,
> +				     struct fwnode_handle *connector)
> +{
> +	int ret  = 0;
> +
> +	hd3ss3220->vbus = devm_of_regulator_get_optional(hd3ss3220->dev,
> +							 to_of_node(connector),
> +							 "vbus");
> +	if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
> +		hd3ss3220->vbus = NULL;
> +	else if (IS_ERR(hd3ss3220->vbus))
> +		ret = PTR_ERR(hd3ss3220->vbus);

So the regulator API's optional functions return -ENODEV instead of NULL :(
In any case, don't double assign the member. Use local variable.

        struct regulator *vbus;

        vbus = devm_of_regulator_get_optional(...
        if (IS_ERR(vbus) && vbus != ERR_PTR(-ENODEV))
                return PTR_ERR(vbus);

        hd3ss3220->vbus = vbus;
        return 0;

I don't think you need this function - just do that in the probe function.

> +	return ret;
> +}
> +
>  static int hd3ss3220_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };
> @@ -354,11 +400,37 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>  	}
>  
> +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
> +	if (IS_ERR(hd3ss3220->id_gpiod))
> +		return PTR_ERR(hd3ss3220->id_gpiod);
> +
> +	if (hd3ss3220->id_gpiod) {
> +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
> +		if (hd3ss3220->id_irq < 0)
> +			return dev_err_probe(hd3ss3220->dev, hd3ss3220->id_irq,
> +					     "failed to get ID gpio\n");
> +
> +		ret = devm_request_threaded_irq(hd3ss3220->dev,
> +						hd3ss3220->id_irq, NULL,
> +						hd3ss3220_id_isr,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						dev_name(hd3ss3220->dev), hd3ss3220);
> +		if (ret < 0)
> +			return dev_err_probe(hd3ss3220->dev, ret, "failed to get ID irq\n");
> +	}
> +
>  	if (IS_ERR(hd3ss3220->role_sw)) {
>  		ret = PTR_ERR(hd3ss3220->role_sw);
>  		goto err_put_fwnode;
>  	}
>  
> +	ret = hd3ss3220_get_vbus_supply(hd3ss3220, connector);
> +	if (ret) {
> +		dev_err(hd3ss3220->dev, "failed to get vbus: %d\n", ret);
> +		goto err_put_fwnode;
> +	}
> +
>  	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
>  	typec_cap.driver_data = hd3ss3220;
>  	typec_cap.type = TYPEC_PORT_DRP;
> -- 
> 2.34.1

thanks,

-- 
heikki

