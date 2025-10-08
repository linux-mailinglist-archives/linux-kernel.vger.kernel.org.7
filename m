Return-Path: <linux-kernel+bounces-845514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E445BC536E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F0654F7693
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CED2857F2;
	Wed,  8 Oct 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUCQ58Iw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E74279DCC;
	Wed,  8 Oct 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930222; cv=none; b=j47S4yb5azdlcVWzMQSKYZhjf+gMQLPKHTEM8F9dDNRa6oPCn8q3OOqummGvhELKZfahY7hnky2YySSBIs4eOlVt3CJGeD9PrQI+/hJYn7ouxdiAg5P48fwlazhRvIRd0h6RHHf+YrWWHCu5MnOIRSsjcbhZ8KTGpl09nXtjPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930222; c=relaxed/simple;
	bh=AbD6CeI+IohAVWdvqjGiRL4xzywGL+fRCinbs7ki4wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owT3TZ2EmRpfwR4qYA3Z0lxl6ZbeRYbqM3Z7cTR8TAF+VVmP92lb0ohZ1KBxh+lwmy5G28cO2s8PdzN3xoZCXEyZYJ3gDZNZ373Wgr+be7roALwFz0jJhvcYGNuwZtw+ivw6llQC2qIJsV3M+JtxfLyELCks4whjSVFnArNcPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUCQ58Iw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759930221; x=1791466221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AbD6CeI+IohAVWdvqjGiRL4xzywGL+fRCinbs7ki4wY=;
  b=DUCQ58Iw4zrDu6r2Mznr8bOJ5Ni3ocrMwTy3uLtefsfx+Uqh20JqTHkm
   yOsB2OLXSjm0H6VOosM4fdTJ9RxZI8/wl4mkdFjiyaC+emICceYYlc9on
   SInq/BPH7KwmvZgugYaC7NC7IL4JS38Z6M0Z3X2uhsIYRbbFmQbWXTJKx
   c9cyOm5p0dd9BjF10D1GeCZTzhBkwZehaRfgBhkUhdOQgu364nd79b6k3
   ivZ9x7e34glQHUm6HE/S/Hy0c4qC9TvbEB0M7N3obkRuz4GCFRlCLDQEG
   5uYTvrJEcxpUAxRTwffm4b+WxIVMZiKlIjlX7A8n4lZBaPfsAXMMa87OM
   A==;
X-CSE-ConnectionGUID: 2VN1Iur0T06z1aRPfC/WLw==
X-CSE-MsgGUID: 0tJVP1L8SGi91XolnFpyqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62153553"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="62153553"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:30:20 -0700
X-CSE-ConnectionGUID: 064oChppTei4D6J5WPCPmA==
X-CSE-MsgGUID: nzSs3uPbSYWTSkDxIv+WDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="184807997"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa005.fm.intel.com with SMTP; 08 Oct 2025 06:30:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 16:30:14 +0300
Date: Wed, 8 Oct 2025 16:30:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
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
Message-ID: <aOZnZqb1ohI7z2HU@kuha.fi.intel.com>
References: <20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com>
 <20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com>
 <aOZGgZc1F968uoR6@kuha.fi.intel.com>
 <1a428b7f-5d20-4d55-aa3a-e4feb580b82e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a428b7f-5d20-4d55-aa3a-e4feb580b82e@oss.qualcomm.com>

On Wed, Oct 08, 2025 at 04:45:06PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/8/2025 4:39 PM, Heikki Krogerus wrote:
> > On Thu, Oct 02, 2025 at 10:55:39PM +0530, Krishna Kurapati wrote:
> > > Enable VBUS on HD3SS3220 when the ID pin is low, as required by the Type-C
> > > specification.
> > 
> > There is not ID pin on Type-C connector.
> 
> There is an ID pin coming out from HD3SS3220 controller to SoC that is being
> referred to here.

So please fix the statement. The Type-C specification does not place
any requirements on the ID pin.

> > > The ID pin stays high when VBUS is not at VSafe0V, and goes
> > > low when VBUS is at VSafe0V.
> > > 
> > > Add support to read the ID pin state and enable VBUS accordingly.
> > 
> > I'm a bit confused about this... Why can't you just check the attached
> > state, and if it's DFP, then you drive VBUS?
> > 
> 
> We could, but checking for DFP doesn't ensure VBUS is at VSafe0V as per the
> datasheet. So using the ID pin to enable vbus.

Fair enough.

thanks,

> > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > ---
> > >   drivers/usb/typec/hd3ss3220.c | 58 +++++++++++++++++++++++++++++++++++
> > >   1 file changed, 58 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> > > index 3ecc688dda82..44ee0be27644 100644
> > > --- a/drivers/usb/typec/hd3ss3220.c
> > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > @@ -54,6 +54,11 @@ struct hd3ss3220 {
> > >   	struct delayed_work output_poll_work;
> > >   	enum usb_role role_state;
> > >   	bool poll;
> > > +
> > > +	struct gpio_desc *id_gpiod;
> > > +	int id_irq;
> > > +
> > > +	struct regulator *vbus;
> > >   };
> > >   static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
> > > @@ -319,6 +324,28 @@ static const struct regmap_config config = {
> > >   	.max_register = 0x0A,
> > >   };
> > > +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
> > > +{
> > > +	struct hd3ss3220 *hd3ss3220 = dev_id;
> > > +	int ret;
> > > +	int id;
> > > +
> > > +	if (IS_ERR_OR_NULL(hd3ss3220->vbus))
> > > +		return IRQ_HANDLED;
> > > +
> > > +	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
> > > +
> > > +	if (!id) {
> > > +		ret = regulator_enable(hd3ss3220->vbus);
> > > +		if (ret)
> > > +			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
> > > +	} else {
> > > +		regulator_disable(hd3ss3220->vbus);
> > > +	}
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > >   static int hd3ss3220_probe(struct i2c_client *client)
> > >   {
> > >   	struct typec_capability typec_cap = { };
> > > @@ -354,6 +381,37 @@ static int hd3ss3220_probe(struct i2c_client *client)
> > >   		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
> > >   	}
> > > +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
> > > +	if (IS_ERR(hd3ss3220->id_gpiod))
> > > +		return PTR_ERR(hd3ss3220->id_gpiod);
> > > +
> > > +	if (hd3ss3220->id_gpiod) {
> > > +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
> > > +		if (hd3ss3220->id_irq < 0) {
> > > +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
> > > +			return hd3ss3220->id_irq;
> > > +		}
> > > +
> > > +		ret = devm_request_threaded_irq(hd3ss3220->dev,
> > > +						hd3ss3220->id_irq, NULL,
> > > +						hd3ss3220_id_isr,
> > > +						IRQF_TRIGGER_RISING |
> > > +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > +						dev_name(hd3ss3220->dev), hd3ss3220);
> > > +		if (ret < 0) {
> > > +			dev_err(hd3ss3220->dev, "failed to get id irq\n");
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");
> > > +	if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
> > > +		hd3ss3220->vbus = NULL;
> > > +
> > > +	if (IS_ERR(hd3ss3220->vbus))
> > > +		return dev_err_probe(hd3ss3220->dev,
> > > +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
> > > +
> > >   	if (IS_ERR(hd3ss3220->role_sw)) {
> > >   		ret = PTR_ERR(hd3ss3220->role_sw);
> > >   		goto err_put_fwnode;
> > > -- 
> > > 2.34.1
> > 

-- 
heikki

