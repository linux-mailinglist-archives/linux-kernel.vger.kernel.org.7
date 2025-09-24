Return-Path: <linux-kernel+bounces-831305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5073B9C50F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDDB1BC31F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334328C847;
	Wed, 24 Sep 2025 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="nQlQYnLD"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82691287253;
	Wed, 24 Sep 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751133; cv=none; b=DHOzDrV7Zqka0Ypf+QEaJuJD8KW/EvYIjLeoVhm5Do+8mGKRgyOI9dYC4XNTEu3e5GoDVBpmkUey/XbLBh983DLUyAgDbNxDA5nkt18rbV1l8+yUd06/1T0eAD593O0EpIaKzqTCDN2aTSyyv+Ihfj+afn0TgyzRqA5J/UVl6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751133; c=relaxed/simple;
	bh=ol6y78eJgRTXudp9ADHxFEvDtMC49G+EHcqYJbvUsyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKyW2DfLqdiYJ2NutCDSVfLukDxRln/tzKcD2B5WqvZjUAyrjlqlQsTpE9BgISVsCFNNzL7d33VZsW7iEhHqFADcklXXj1eNggcEDXlIOYh8l+QlijlMPm/rvvFYRkxPh4EDMmqueRWP4PSy4dyOpgU5idO2/yIWKiztDa4Zn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=nQlQYnLD; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QNyru36LPKmzgiXSAQ8LQLTBm3PBhuFV7yl3tzqSyHU=; b=nQlQYnLDCj0yo1+Nrzb6Aowtes
	2tUTEftJsIWHEukCNz8C0HELZvIzmFJV6eez2KJESaWupAkzcukZTehUeHzh0zIla4kTo7BfTLR07
	a8tx95d9IIEIiVMHws092Yjbwwp4JFe0KcgzlTLX2HOTR2AgVNO+3nDzMzfKxeSGRSuIrJC2NTkzw
	OXgmf8DY7uWp5OzWOsKuRjtBwxvBKfowmIJrC/RkaYOQ8IySbbYln/JC0H4GGDugbWJ8RyYavk6UG
	I8+Tt8oaOZ4RxrtuUZfOYi2TaeL85uAQqL6ONLcEYR56Up4X3mRbCdy9QNw2Rn8nekO0pdxy4+068
	YfqwxE7Q==;
Date: Wed, 24 Sep 2025 23:58:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH 2/2] hwmon: (sy7636a) enable regulator only if needed
Message-ID: <20250924235844.79193fd9@kemnade.info>
In-Reply-To: <00685721-8f34-4ad2-9452-5447eafb23b8@roeck-us.net>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-3-andreas@kemnade.info>
	<25ef8eef-a4e6-436b-87cd-c77506b4b215@roeck-us.net>
	<20250924224035.2b20459a@kemnade.info>
	<00685721-8f34-4ad2-9452-5447eafb23b8@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 14:06:57 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/24/25 13:40, Andreas Kemnade wrote:
> > On Wed, 24 Sep 2025 09:06:15 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> >> On Sat, Sep 20, 2025 at 01:43:11PM +0200, Andreas Kemnade wrote:  
> >>> Avoid having all the regulators in the SY7636A enabled all the time
> >>> to significantly reduce current consumption. In pratical scenarios,
> >>> the regulators are only needed when a refresh is done on the epaper
> >>> display powered by the SY7636A. This is can save around 10mA which
> >>> is much for this kind of devices.
> >>> Also fixes the asymmetrical single enable call.
> >>>
> >>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>> ---
> >>>   drivers/hwmon/sy7636a-hwmon.c | 34 ++++++++++++++++++++++++----------
> >>>   1 file changed, 24 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> >>> index e83d0e50c735..0fda69bea3b4 100644
> >>> --- a/drivers/hwmon/sy7636a-hwmon.c
> >>> +++ b/drivers/hwmon/sy7636a-hwmon.c
> >>> @@ -18,14 +18,26 @@
> >>>   
> >>>   #include <linux/mfd/sy7636a.h>
> >>>   
> >>> +struct sy7636a_hwmon_data {
> >>> +	struct regmap *regmap;
> >>> +	struct regulator *regulator;
> >>> +};
> >>> +
> >>> +
> >>>   static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
> >>>   			u32 attr, int channel, long *temp)
> >>>   {
> >>> -	struct regmap *regmap = dev_get_drvdata(dev);
> >>> +	struct sy7636a_hwmon_data *drvdata = dev_get_drvdata(dev);
> >>>   	int ret, reg_val;
> >>>   
> >>> -	ret = regmap_read(regmap,
> >>> +	ret = regulator_enable(drvdata->regulator);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	ret = regmap_read(drvdata->regmap,
> >>>   			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);  
> >>
> >> Does that really work without delay ? Usually it takes some time for a chip
> >> to return useful data after its power supply has been enabled. calls
> >>  
> > Hmm, enabling the onoff bit behind the regulator is just needed to turn
> > ADC on here. But there is also the power good wait which should usually be enough.
> > Usually... But there is no guarantee. So yes, better wait for one adc aquisition.
> >   
> 
> Would that be the power good timeout (50ms) ? The conversion time on top if that
> is not much, but the power good wait is a long time. That strongly suggests that
> this should be made optional. Not everyone might like the additional delay for
> each temperature reading.
> 
Yes, that is the mechanism. Well, the regulator can be marked as always
enabled via regulator-aways-on flag in devicetree so that is optional, that
would have the side effect of having temperature conversion always
working, no delay needed. The power good stuff is about the stepup
regulators, so I think (will verify that in experiments) waiting for the
conversation time (around 0.5 ms) after the on bit is set is probably enough.

And I have seen, the power good stuff is not really implemented yet,
had another incarnation of this driver in my head while writing this,
where regulator_enable waits for power good.

Regards,
Andreas

