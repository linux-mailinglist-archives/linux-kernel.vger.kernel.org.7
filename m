Return-Path: <linux-kernel+bounces-827770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EBB92BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6918619055B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7931A573;
	Mon, 22 Sep 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcWiGJof"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A41FF7C5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567969; cv=none; b=Jz1g/BDT7eAaSKTcozPWZNs9QPRF/eY7VHyE831S5QCPd8VuEkAq/ao2SrAVO8/OhO2Ee9+inExm3KjHKIG8+2oXG5wmmGEIQtvrlZ4Vdz3SB9LpXcpZK1Sv37b9F2SKA4gKqxBH2SKNr5QzY0tRzcFgda26xvYXHGG5Ipu8yHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567969; c=relaxed/simple;
	bh=aFWXLiivJ4YUzHUPxpWbeSvezEsm51bwTeklbJQIcYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUhyWMQKiX6/UvqB6hFyMmvhpi/cuOJuxqRPy9eJo31eZeWOOtsJsCDkrUidwMmFOetry8NUa7tDrjZjH/wbLf4lq8YO1eJBV2ZJABZJspqR++/KQsLI0Ldz5KnUcH1OK7/gudn+m1lvDX17if++tc4Y9fo2zDlR4aqiSjdMCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcWiGJof; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e1bc8ffa1so3730285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758567965; x=1759172765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xfkY5AXvD0ZvDWTOWzvtBozCzcTw2ZSBgWbw8Ju3dcg=;
        b=LcWiGJofrtnq5/bRmWEFYgOAdl+fpACZajYlNS/jGSXsWm+7fq5cbf3BDdaTPSqfaM
         f6JK8EwPcP7zMz4wfGAo0xnhi5KlBwG/VIErv6DuV2fIDak5Zu9uR8nGyi2N1h8A+/d1
         +eliyOHNpVNUq1uDsvgZ9OVBt7ZKwx6obHNWyrwr16CI1lL4amEF+Rxq9WnyDKXGOnXf
         Gvtnj7xXKfmXwCAysl3xxw2ThmZISVm75HXGV8AEHL1tkXjmKEU1O6XoQe6quWFTgwc4
         cef+ou5O2eXdmn4laYUu1vhQRMvwJGj9OhDajlJNNLof/nR87M//y/Ob8FEa7GLKoDxo
         CyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758567965; x=1759172765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfkY5AXvD0ZvDWTOWzvtBozCzcTw2ZSBgWbw8Ju3dcg=;
        b=n4LbBX4CCUehCOujz4mZGIZPX19qET1gYk1dwTwrklPvep05h4oXWlYM4yjhnu3jHY
         tz662vJnkTezJ0YUkE2dFjetXyvAh3oolzxigWt5KtZqJgJ8eiuhWfY2n0RQ4xis7cjn
         PSxSJ1NjNjt8ZmFN/62YF2B60XdNKcWRVUxXn118N4a910c7brnSSKBVCoaWIgHgxuSs
         CglKssM+oQJx8W+HbSKAU8KjD7Xuy/uQHAUeqnj6KMPXCYjWMRyMy9J/VegNyLjFuZNF
         rGB7CSgFnHFMJd+1hzWa+qwM70+IeY3MDoGjvE9LWD8/pYq2PWwJtf7sh/OK7kYaYI/V
         +MBg==
X-Gm-Message-State: AOJu0YzfTF6cd5u02FAWU7uXUWsvDZnvdRu43vTaj+fOD3AhrfwHlHFy
	BeIge7Py5iF1vPpqwbMui6dIsPeGnlJQc1ouhrVVwIu2fN4yap2ieGU0
X-Gm-Gg: ASbGncte0uzi/BDIinvnz5rb8sZLVO+h/QQ2JWBMAz6SY6ZZ1uiV20FU3ec6bO0wQ1s
	AHnwr2kU4+YlvVEjcKpjNZ3ynjo1oc8WqA+QB4r4HHVzcF3f5qRcd6M68xJQtqRYI2WWrnt1/+U
	KrdxmK5SjIBgNQcPcjOxBSf0KJS1EWgM19Up12V0laj+Z4LnvimpDGa7GYkElq0KnH2Xylxn3Jk
	oxlrlG+faEAEzre8PBUtM1OZAM2DnuBmognR2MxJKenuxe2kVQj7Yv7MRkXYXd/ORkUh88cA+92
	2hjfQIVVbe8OFfyPNDQ7P4mcXlR4Yn2l5S/o0TF24gSiJDEMWzXaWRo+i3BrU6OxF/E1nVfZ1N1
	Kw2F6tLU7888xoVx3GtTG91djv5u4Pk+GScdrjA5NrX+UpSkdJVrGcGQM43pjDaVoGE4=
X-Google-Smtp-Source: AGHT+IHiYtsZgQnnhYurpBqcCwqkq3VPjSs12XfFd0dBTlEzJMi+R4rGhaLrT5UZpoVZwHHVfGt4pA==
X-Received: by 2002:a05:600c:6288:b0:46d:996b:8293 with SMTP id 5b1f17b1804b1-46e1dab26ccmr133545e9.22.1758567964495;
        Mon, 22 Sep 2025 12:06:04 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([37.163.188.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d1c97a87csm58186295e9.20.2025.09.22.12.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:06:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:05:49 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com, naresh.solanki@9elements.com,
	michal.simek@amd.com, grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH 2/3] iio: mpl3115: add support for DRDY interrupt
Message-ID: <20250922190549.22ly3ekwuflgbga7@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
 <20250921133327.123726-3-apokusinski01@gmail.com>
 <073de1da8b8f04c037f267765235b3334941844f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <073de1da8b8f04c037f267765235b3334941844f.camel@gmail.com>

On Mon, Sep 22, 2025 at 10:15:19AM +0100, Nuno Sá wrote:
> On Sun, 2025-09-21 at 15:33 +0200, Antoni Pokusinski wrote:
> > MPL3115 sensor features a "data ready" interrupt which indicates the
> > presence of new measurements.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  drivers/iio/pressure/mpl3115.c | 167 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 162 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> > index 579da60ef441..cf34de8f0d7e 100644
> > --- a/drivers/iio/pressure/mpl3115.c
> > +++ b/drivers/iio/pressure/mpl3115.c
> > @@ -7,7 +7,7 @@
> >   * (7-bit I2C slave address 0x60)
> >   *
> >   * TODO: FIFO buffer, altimeter mode, oversampling, continuous mode,
> > - * interrupts, user offset correction, raw mode
> > + * user offset correction, raw mode
> >   */
> >  
> >  #include <linux/module.h>
> > @@ -17,26 +17,45 @@
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger.h>
> >  #include <linux/delay.h>
> > +#include <linux/property.h>
> >  
> >  #define MPL3115_STATUS 0x00
> >  #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
> >  #define MPL3115_OUT_TEMP 0x04 /* MSB first, 12 bit */
> >  #define MPL3115_WHO_AM_I 0x0c
> > +#define MPL3115_INT_SOURCE 0x12
> > +#define MPL3115_PT_DATA_CFG 0x13
> >  #define MPL3115_CTRL_REG1 0x26
> > +#define MPL3115_CTRL_REG3 0x28
> > +#define MPL3115_CTRL_REG4 0x29
> > +#define MPL3115_CTRL_REG5 0x2a
> >  
> >  #define MPL3115_DEVICE_ID 0xc4
> >  
> >  #define MPL3115_STATUS_PRESS_RDY BIT(2)
> >  #define MPL3115_STATUS_TEMP_RDY BIT(1)
> >  
> > +#define MPL3115_CTRL_INT_SRC_DRDY BIT(7)
> > +
> > +#define MPL3115_PT_DATA_EVENT_ALL (BIT(2) | BIT(1) | BIT(0))
> > +
> >  #define MPL3115_CTRL_RESET BIT(2) /* software reset */
> >  #define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
> >  #define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
> >  #define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
> >  
> > +#define MPL3115_CTRL_IPOL1 BIT(5)
> > +#define MPL3115_CTRL_IPOL2 BIT(1)
> > +
> > +#define MPL3115_CTRL_INT_EN_DRDY BIT(7)
> > +
> > +#define MPL3115_CTRL_INT_CFG_DRDY BIT(7)
> > +
> >  struct mpl3115_data {
> >  	struct i2c_client *client;
> > +	struct iio_trigger *drdy_trig;
> >  	struct mutex lock;
> >  	u8 ctrl_reg1;
> >  };
> > @@ -164,10 +183,12 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void
> > *p)
> >  	int ret, pos = 0;
> >  
> >  	mutex_lock(&data->lock);
> > -	ret = mpl3115_request(data);
> > -	if (ret < 0) {
> > -		mutex_unlock(&data->lock);
> > -		goto done;
> > +	if (!(data->ctrl_reg1 & MPL3115_CTRL_ACTIVE)) {
> > +		ret = mpl3115_request(data);
> > +		if (ret < 0) {
> > +			mutex_unlock(&data->lock);
> > +			goto done;
> > +		}
> >  	}
> >  
> >  	if (test_bit(0, indio_dev->active_scan_mask)) {
> > @@ -228,10 +249,142 @@ static const struct iio_chan_spec mpl3115_channels[] =
> > {
> >  	IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >  
> > +static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
> > +	if (ret < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	if (!(ret & MPL3115_CTRL_INT_SRC_DRDY))
> > +		return IRQ_NONE;
> > +
> > +	iio_trigger_poll_nested(data->drdy_trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
> > +{
> > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +	u8 ctrl_reg1 = data->ctrl_reg1;
> > +
> > +	if (state)
> > +		ctrl_reg1 |= MPL3115_CTRL_ACTIVE;
> > +	else
> > +		ctrl_reg1 &= ~MPL3115_CTRL_ACTIVE;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> 
> As Andy pointed out, you should have a precursor patch converting the complete
> driver to use the cleanup logic.
> 
> Another nice cleanup you could do (if you want of course) would be to get rid of
> mpl3115_remove().
> 
Will add the precursor patch in v2
> > +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +					ctrl_reg1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> > +					state ? MPL3115_CTRL_INT_EN_DRDY :
> > 0);
> > +	if (ret < 0)
> > +		goto reg1_cleanup;
> > +
> > +	data->ctrl_reg1 = ctrl_reg1;
> > +
> > +	return 0;
> > +
> > +reg1_cleanup:
> > +	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +				  data->ctrl_reg1);
> > +	return ret;
> > +}
> > +
> > +static const struct iio_trigger_ops mpl3115_trigger_ops = {
> > +	.set_trigger_state = mpl3115_set_trigger_state,
> > +};
> > +
> >  static const struct iio_info mpl3115_info = {
> >  	.read_raw = &mpl3115_read_raw,
> >  };
> >  
> > +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> > +				 struct iio_dev *indio_dev)
> > +{
> > +	struct fwnode_handle *fwnode;
> > +	int ret, irq, irq_type;
> > +	bool act_high, is_int2 = false;
> > +
> > +	fwnode = dev_fwnode(&data->client->dev);
> > +	if (!fwnode)
> > +		return -ENODEV;
> > +
> 
> And to add to Andy's review, fwnode_irq_get_byname() will give you an error
> anyways if !fwnode.
> 
> > +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> > +	if (irq < 0) {
> > +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> > +		if (irq < 0)
> > +			return 0;
> > +
> > +		is_int2 = true;
> > +	}
> > +
> > +	irq_type = irq_get_trigger_type(irq);
> > +	switch (irq_type) {
> > +	case IRQF_TRIGGER_RISING:
> > +		act_high = true;
> > +		break;
> > +	case IRQF_TRIGGER_FALLING:
> > +		act_high = false;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
> > +					MPL3115_PT_DATA_EVENT_ALL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!is_int2) {
> > +		ret = i2c_smbus_write_byte_data(data->client,
> > +						MPL3115_CTRL_REG5,
> > +						MPL3115_CTRL_INT_CFG_DRDY);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	if (act_high) {
> > +		ret = i2c_smbus_write_byte_data(data->client,
> > +						MPL3115_CTRL_REG3,
> > +						is_int2 ? MPL3115_CTRL_IPOL2
> > :
> > +							 
> > MPL3115_CTRL_IPOL1);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
> > +						 "%s-dev%d",
> > +						 indio_dev->name,
> > +						 iio_device_id(indio_dev));
> > +	if (!data->drdy_trig)
> > +		return -ENOMEM;
> > +
> > +	data->drdy_trig->ops = &mpl3115_trigger_ops;
> > +	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> > +	ret = iio_trigger_register(data->drdy_trig);
> 
> devm_iio_trigger_register()
> 
> - Nuno Sá
>
Will fix in v2
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->trig = iio_trigger_get(data->drdy_trig);
> > +
> > +	return devm_request_threaded_irq(&data->client->dev, irq,
> > +					 NULL,
> > +					 mpl3115_interrupt_handler,
> > +					 IRQF_ONESHOT,
> > +					 "mpl3115_irq",
> > +					 indio_dev);
> > +}
> > +
> >  static int mpl3115_probe(struct i2c_client *client)
> >  {
> >  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> > @@ -271,6 +424,10 @@ static int mpl3115_probe(struct i2c_client *client)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	ret = mpl3115_trigger_probe(data, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> >  		mpl3115_trigger_handler, NULL);
> >  	if (ret < 0)

