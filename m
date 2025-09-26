Return-Path: <linux-kernel+bounces-833494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F9BA226B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6393324482
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3278F39;
	Fri, 26 Sep 2025 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1BswlI4"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CE1373
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758850363; cv=none; b=H4kvvAmMigfX1q9dmqhUplFvqPTi/YDK883gnMitLfS4FNb3kqvOjhnsB50e4wWzoaiZdMuFNMcDv6j0pT6vG9Cn5luUQh3LHKU6Auiqkbd66wkRyn/i5Jzsa/AGpo09os1iY2CTwClA/RlH6Z6nWqWwnpB1I1ZemXDCqC7BRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758850363; c=relaxed/simple;
	bh=qFkERAHyVGhIRL3zgOew7fVgHjabZ/3dZCmh8z1jTTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXI5eriwXagAZ3GFmSj+xutjUfCP/V9YxFAfvMiwJfUic3t4Up4Nqm5NUS8ToVePKnMM8+IyeCg0PZdOa8MPLXSu6XTdKZR/i3PUR+B3LiIBb/rgQnYQId7YOQmC178JelM5Tmqfi/DVgv5bUtlQO/gUXE/zuy5FcJlVU7/9y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1BswlI4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Sep 2025 09:32:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758850349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pONYo0zNaUmX1MVp8RQxboPg/HRCxoiwz4Qz3wNMDzs=;
	b=B1BswlI4ypZA0k6YMVmu1q0JTgeR6iqMYiqalR1HewOrcet8fMX0JsFAQkRTytWlQ1Svua
	hyEcjk8Dx1WoptiAW/XVwrCsRaCKLBlKzhn8Dz9dxyOMLhxU+t1NbIeMm2YuYRJ8HqHan7
	QFK8eNFgGtfr0j5IyJ3YndC6DnTWPlY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Guenter Roeck <linux@roeck-us.net>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (ctf2301) Add support for CTF2301
Message-ID: <aNXtJ0S5SAMsUwnD@kernel.org>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-3-97e7c84f2c47@linux.dev>
 <53f1d5d2-c871-4823-ab13-8c3dfd86dbfe@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f1d5d2-c871-4823-ab13-8c3dfd86dbfe@roeck-us.net>
X-Migadu-Flow: FLOW_OUT

Hi Guenter, Thanks for your review.
There are many things to improve in this driver.

On Wed, Sep 24, 2025 at 08:43:35AM -0700, Guenter Roeck wrote:
> On Tue, Sep 16, 2025 at 12:46:46PM +0800, Troy Mitchell wrote:
[...]
> > diff --git a/drivers/hwmon/ctf2301.c b/drivers/hwmon/ctf2301.c
[...]
> > +
> > +#define CTF2301_LOCAL_TEMP_MSB			0x00
> 	LM90_REG_LOCAL_TEMP
> > +#define CTF2301_RMT_TEMP_MSB			0x01
> 	LM90_REG_REMOTE_TEMPH
> > +#define CTF2301_ALERT_STATUS			0x02
> 	LM90_REG_STATUS
> > +#define CTF2301_GLOBAL_CFG			0x03
> 	LM90_REG_CONFIG1
> > +#define CTF2301_RMT_TEMP_LSB			0x10
> 	LM90_REG_REMOTE_TEMPL
> > +#define CTF2301_LOCAL_TEMP_LSB			0x15
> 	TMP451_REG_LOCAL_TEMPL
> > +#define CTF2301_ALERT_MASK			0x16
> 	TMP461_REG_CHEN
> 
> So far this looks like a chip based on LM90 or TMP451/TMP461
> with an added fan controller. I can not immediatey determine
> if it would be better to add the pwm/tach support to the lm90
> driver. Given that the chip (based on registers) does support
> limits, which is not implemented here but essential for a chip
> like this, I would very much prefer adding support for it to the
> lm90 driver if possible.
> 
> The public datasheet does not provide register details, making it
> all but impossible to do a real evaluation. Any idea how to get
> a complete datasheet ?
Yeah, more register info at [1].
I've checked the detailed review below,
but I'll hold off on sending v2 until you decide if we really need a new driver.

Is this chip more like the LM63, by the way?

                - Troy

Link:
https://github.com/TroyMitchell911/ctf2301-datasheet
> 
> > +#define	CTF2301_ENHANCED_CFG			0x45
> > +#define CTF2301_TACH_COUNT_LSB			0x46
> > +#define CTF2301_TACH_COUNT_MSB			0x47
> > +#define CTF2301_PWM_AND_TACH_CFG		0x4a
> > +#define CTF2301_PWM_VALUE			0x4c
> > +#define CTF2301_PWM_FREQ			0x4d
> > +#define CTF2301_RMT_DIODE_TEMP_FILTER		0xbf
> > +
> > +/* remote diode fault alarm */
> > +#define ALERT_STATUS_RDFA			BIT(2)
> > +
> > +/* alert interrupts enable  */
> > +#define GLOBAL_CFG_ALERT_MASK			BIT(7)
> > +/* tach input enable  */
> > +#define GLOBAL_CFG_TACH_SEL			BIT(2)
> > +
> > +/* local high temperature alarm mask */
> > +#define ALERT_MASK_LHAM				BIT(6)
> > +/* remote high temperature alarm mask */
> > +#define ALERT_MASK_RHAM				BIT(4)
> > +/* remote low temperature alarm mask */
> > +#define ALERT_MASK_RLAM				BIT(3)
> > +/* remote t_crit alarm mask */
> > +#define ALERT_MASK_RCAM				BIT(1)
> > +/* tachometer alarm mask */
> > +#define ALERT_MASK_TCHAM			BIT(0)
> > +
> > +#define ALERT_MASK_ALL				(ALERT_MASK_LHAM | ALERT_MASK_RHAM | \
> > +						ALERT_MASK_RLAM | ALERT_MASK_RCAM | \
> > +						ALERT_MASK_TCHAM)
> > +
> > +/* enables signed format for high and t_crit setpoints */
> > +#define ENHANGCED_CFG_USF			BIT(3)
> > +
> > +/* PWM Programming enable */
> > +#define PWM_AND_TACH_CFG_PWPGM			BIT(5)
> > +
> > +#define PWM_DEFAULT_FREQ_CODE			0x17
> > +
> > +
> 
> No mode than one empty line. checkpatch --strict would tell.
> And, indeed, it reports:
> 
> total: 0 errors, 4 warnings, 3 checks, 350 lines checked
> 
> where
> 
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> CHECK: Please don't use multiple blank lines
> CHECK: Alignment should match open parenthesis
> 
> are relevant and need to be fixed.
> 
> > +struct ctf2301 {
> > +	struct i2c_client *client;
> 
> Not used anywhere.
> 
> > +
> > +	struct regmap *regmap;
> > +
> > +	unsigned int pwm_freq_code;
> 
> Unnecessary empty lines.
> 
> > +};
> > +
> > +static int ctf2301_read_temp(struct device *dev, u32 attr, int channel, long *val)
> > +{
> > +	int regval[2], raw, err, flag = 1, shift = 4, scale = 625;
> > +	struct ctf2301 *ctf2301 = dev_get_drvdata(dev);
> > +	unsigned int reg_msb = CTF2301_LOCAL_TEMP_MSB,
> > +		     reg_lsb = CTF2301_LOCAL_TEMP_LSB;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		if (channel != 0 && channel != 1)
> > +			return -EOPNOTSUPP;
> 
> Should have been handled in is_visible function. It is, therefore
> this check is unnecessary.
> 
> > +
> > +		if (channel == 1) {
> > +			err = regmap_read(ctf2301->regmap, CTF2301_ALERT_STATUS, regval);
> > +			if (err)
> > +				return err;
> > +
> > +			if (regval[0] & ALERT_STATUS_RDFA)
> > +				return -ENODEV;
> 
> Wrong return value. The device does obviously exist. This should return
> -ENODATA.
> 
> > +
> > +			shift = 5;
> > +			scale = 1250;
> > +			reg_msb = CTF2301_RMT_TEMP_MSB;
> > +			reg_lsb = CTF2301_RMT_TEMP_LSB;
> > +		}
> > +
> > +		err = regmap_read(ctf2301->regmap, reg_msb, regval);
> > +		if (err)
> > +			return err;
> > +
> > +		err = regmap_read(ctf2301->regmap, reg_lsb, regval + 1);
> > +		if (err)
> > +			return err;
> 
> Consider using regmap_multi_reg_read() instead.
> 
> > +
> > +		dev_err(dev, "local temp: lsb->0x%x, msb->0x%x", regval[1], regval[0]);
> 
> Really ?
> 
> Stopping complete review here. The driver is obviously not ready
> for submission. Some more obvious comments below.
> 
> 
> > +
> > +		raw = (s16)((regval[0] << 8) | regval[1]);
> > +
> > +		raw >>= shift;
> > +
> > +		*val = raw * scale * flag;
> > +
> > +		break;
> 
> Drop empty lines.
> 
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ctf2301_read_fan(struct device *dev, u32 attr, long *val)
> 
> There is only a single supported attribute, so passing its vbalue
> to this function and checking it adds unnecessary complexity.
> Just drop the parameter and all its complexity.
> 
> > +{
> > +	struct ctf2301 *ctf2301 = dev_get_drvdata(dev);
> > +	int regval[2], err, speed;
> > +
> > +	switch (attr) {
> > +	case hwmon_fan_input:
> > +		err = regmap_read(ctf2301->regmap, CTF2301_TACH_COUNT_MSB, regval);
> > +		if (err)
> > +			return err;
> > +
> > +		err = regmap_read(ctf2301->regmap, CTF2301_TACH_COUNT_LSB, regval + 1);
> > +		if (err)
> > +			return err;
> 
> CTF2301_TACH_COUNT_LSB and CTF2301_TACH_COUNT_MSB are consecutive registers,
> so it should be possible to use regmap_bulk_read(). If not, consider using
> regmap_multi_reg_read() and explain why regmap_bulk_read() does not work.
> 
> > +
> > +		speed = (regval[0] << 8) | regval[1];
> > +
> 
> speed can be 0.
> 
> > +		*val = (unsigned int)(1 * (5400000 / speed));
> 				      ^^^^ what is this for ?
> 
> The typecast is unnecessary, and speed needs to be checked to
> ensure that there is no divide by zero error.
> 
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ctf2301_write_pwm(struct device *dev, u32 attr, long val)
> > +{
> > +	struct ctf2301 *ctf2301 = dev_get_drvdata(dev);
> > +	int err, map_val;
> > +
> > +	dev_err(dev, "write pwm: %d", attr);
> 
> Not commmenting on those any further.
> 
> > +
> > +	switch (attr) {
> > +	case hwmon_pwm_input:
> > +		map_val = (val * ctf2301->pwm_freq_code * 2) / 255;
> 
> val needs to be range checked, and the function needs to return
> -EINVAL if it is out of range. Also consider using DIV_ROUND_CLOSEST().
> 
> > +		dev_err(dev, "val:%ld, map_val: %d", val, map_val);
> > +		err = regmap_write(ctf2301->regmap, CTF2301_PWM_VALUE, map_val);
> > +		if (err)
> > +			return err;
> > +		break;
> > +	case hwmon_pwm_freq:
> > +		ctf2301->pwm_freq_code = DIV_ROUND_UP(PWM_PARENT_CLOCK, val) / 2;
> 
> val needs to be clamped to its valid range.
> 
> > +		dev_err(dev, "pwm_freq_code: %d", ctf2301->pwm_freq_code);
> > +		err = regmap_write(ctf2301->regmap, CTF2301_PWM_FREQ, ctf2301->pwm_freq_code);
> > +		if (err)
> > +			return err;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static umode_t ctf2301_is_visible(const void *drvdata,
> > +				 enum hwmon_sensor_types type,
> > +				 u32 attr, int channel)
> > +{
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			return 0444;
> > +		default:
> > +			return 0;
> > +		}
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_input:
> > +			return 0444;
> > +		default:
> > +			return 0;
> > +		}
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +		case hwmon_pwm_freq:
> > +			return 0644;
> > +		default:
> > +			return 0;
> > +		}
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int ctf2301_read(struct device *dev, enum hwmon_sensor_types type,
> > +		       u32 attr, int channel, long *val)
> > +{
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		return ctf2301_read_temp(dev, attr, channel, val);
> > +	case hwmon_fan:
> > +		return ctf2301_read_fan(dev, attr, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int ctf2301_write(struct device *dev, enum hwmon_sensor_types type,
> > +			 u32 attr, int channel, long val)
> > +{
> > +	switch (type) {
> > +	case hwmon_pwm:
> > +		return ctf2301_write_pwm(dev, attr, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_channel_info * const ctf2301_info[] = {
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT),
> > +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_FREQ),
> > +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_ops ctf2301_hwmon_ops = {
> > +	.is_visible = ctf2301_is_visible,
> > +	.read = ctf2301_read,
> > +	.write = ctf2301_write
> > +};
> > +
> > +static const struct hwmon_chip_info ctf2301_chip_info = {
> > +	.ops = &ctf2301_hwmon_ops,
> > +	.info = ctf2301_info,
> > +};
> > +
> > +static const struct regmap_config ctf2301_regmap_config = {
> > +	.max_register = CTF2301_RMT_DIODE_TEMP_FILTER,
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +};
> > +
> > +static int ctf2301_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct device *hwmon_dev;
> > +	struct ctf2301 *ctf2301;
> > +	int err;
> > +
> > +	ctf2301 = devm_kzalloc(dev, sizeof(*ctf2301), GFP_KERNEL);
> > +	if (!ctf2301)
> > +		return -ENOMEM;
> > +	ctf2301->client = client;
> > +
> > +	ctf2301->regmap = devm_regmap_init_i2c(client, &ctf2301_regmap_config);
> > +	if (IS_ERR(ctf2301->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(ctf2301->regmap),
> > +				     "failed to allocate register map");
> > +
> > +	err = regmap_write(ctf2301->regmap, CTF2301_GLOBAL_CFG,
> > +			   GLOBAL_CFG_ALERT_MASK | GLOBAL_CFG_TACH_SEL);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "failed to write CTF2301_GLOBAL_CFG register");
> > +
> > +	/*err = regmap_write(ctf2301->regmap, CTF2301_ALERT_MASK, ALERT_MASK_ALL);*/
> > +	/*if (err)*/
> > +		/*return dev_err_probe(dev, err,*/
> > +				     /*"failed to write CTF2301_ALERT_MASK");*/
> > +
> > +	err = regmap_write(ctf2301->regmap, CTF2301_ENHANCED_CFG, ENHANGCED_CFG_USF);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "failed to write CTF2301_ENHANCED_CFG");
> > +
> > +	err = regmap_write(ctf2301->regmap, CTF2301_PWM_AND_TACH_CFG, PWM_AND_TACH_CFG_PWPGM);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "failed to write CTF2301_PWM_AND_TACH_CFG");
> > +
> > +	ctf2301->pwm_freq_code = PWM_DEFAULT_FREQ_CODE;
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ctf2301,
> > +							 &ctf2301_chip_info,
> > +							 NULL);
> > +	if (IS_ERR(hwmon_dev))
> > +		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
> > +				     "failed to register hwmon device");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ctf2301_of_match[] = {
> > +	{ .compatible = "sensylink,ctf2301", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ctf2301_of_match);
> > +
> > +static struct i2c_driver ctf2301_driver = {
> > +	.driver = {
> > +		.name	= "ctf2301",
> > +		.of_match_table = of_match_ptr(ctf2301_of_match),
> > +	},
> > +	.probe		= ctf2301_probe,
> > +};
> > +module_i2c_driver(ctf2301_driver);
> > +
> > +MODULE_AUTHOR("Troy Mitchell <troy.mitchell@linux.dev>");
> > +MODULE_DESCRIPTION("ctf2301 driver");
> > +MODULE_LICENSE("GPL");

