Return-Path: <linux-kernel+bounces-831239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6EB9C2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CA71888B74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59B328960;
	Wed, 24 Sep 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="8EouNj5t"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B928F4;
	Wed, 24 Sep 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746445; cv=none; b=XvVHt9yWUaw9UlcuDNNmcwyAevCyBHnrsU87zrwMyxG1rfS1xTEtI6QTX7E44PKBOFU8tTX/IzKfMI+hxWebqUIDTUn1oIkwDE2a3A5ETAusqjUIX4STP+MIGMewKD7NhDXppI4lgoTgFi5eVkJVeXV9QtI5hYfzrxrr+hf5QW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746445; c=relaxed/simple;
	bh=QTIQkpV/ciuM/sLyZDPrsBTzQxcBE89VDpwEWGscX4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/u5s1H3G4lNMbMhhWRxGtGeCZkpu/yjUX8ZT8WCPkB4GkjTJYjIih8DnHCMcojuRfdhC0uV3kjCl/pbDWqN6n4dFvBXQQRVxwh+hz7Q4lMEhOok7KjlIj8S+cGJfumx3I4ePHOcvdLS1E34U6gCwt5fo5YW6dC0MpXEx87Dbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=8EouNj5t; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ITB1rCZb/1p8Dc/cYBEMMSkfLogfsT+JzDlWdMz+ne4=; b=8EouNj5t5a/wVV06FrfHRkcTwE
	3fCUlq29rCQLw3onGQP+cEJYbeShna8XxxtQOCfAEsQHrl+04HQONofxi2851Jf4kpmPpR9ye/aqK
	xFGE2sExRGKAJJ7us7Y/61S9Tmrqmk21X2e0jRzmwvu8hDgkGgmAN+Blcjhbz1apYQ3en17X+fNwJ
	Zy1/7zDI5qu6VF9ElRhahDa8edqWa3G8AriQ6WCbWSnmtV+yU4knF5wwLl7mCVK5Uk7WDnYc5SP3Y
	nY7QSPOSIGDsIu0ZpaLFeGLLEUncYMM5gz4qwJ4Gh/8uxtIFNpw6G+Meg4j7OefoM5Cq6RncsETd+
	rRHkFUKg==;
Date: Wed, 24 Sep 2025 22:40:35 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH 2/2] hwmon: (sy7636a) enable regulator only if needed
Message-ID: <20250924224035.2b20459a@kemnade.info>
In-Reply-To: <25ef8eef-a4e6-436b-87cd-c77506b4b215@roeck-us.net>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-3-andreas@kemnade.info>
	<25ef8eef-a4e6-436b-87cd-c77506b4b215@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:06:15 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Sat, Sep 20, 2025 at 01:43:11PM +0200, Andreas Kemnade wrote:
> > Avoid having all the regulators in the SY7636A enabled all the time
> > to significantly reduce current consumption. In pratical scenarios,
> > the regulators are only needed when a refresh is done on the epaper
> > display powered by the SY7636A. This is can save around 10mA which
> > is much for this kind of devices.
> > Also fixes the asymmetrical single enable call.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/hwmon/sy7636a-hwmon.c | 34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> > index e83d0e50c735..0fda69bea3b4 100644
> > --- a/drivers/hwmon/sy7636a-hwmon.c
> > +++ b/drivers/hwmon/sy7636a-hwmon.c
> > @@ -18,14 +18,26 @@
> >  
> >  #include <linux/mfd/sy7636a.h>
> >  
> > +struct sy7636a_hwmon_data {
> > +	struct regmap *regmap;
> > +	struct regulator *regulator;
> > +};
> > +
> > +
> >  static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
> >  			u32 attr, int channel, long *temp)
> >  {
> > -	struct regmap *regmap = dev_get_drvdata(dev);
> > +	struct sy7636a_hwmon_data *drvdata = dev_get_drvdata(dev);
> >  	int ret, reg_val;
> >  
> > -	ret = regmap_read(regmap,
> > +	ret = regulator_enable(drvdata->regulator);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(drvdata->regmap,
> >  			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);  
> 
> Does that really work without delay ? Usually it takes some time for a chip
> to return useful data after its power supply has been enabled. calls
> 
Hmm, enabling the onoff bit behind the regulator is just needed to turn
ADC on here. But there is also the power good wait which should usually be enough.
Usually... But there is no guarantee. So yes, better wait for one adc aquisition.

Regards,
Andreas

