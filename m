Return-Path: <linux-kernel+bounces-827540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86039B9203D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C33616A28F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838E2EAB8C;
	Mon, 22 Sep 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="D2PlgHaS"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EA2E8B93
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555743; cv=none; b=eHdBE6F6/6n/5W86xIOzq/V4jA5KlaLhOA81+ANbhNQXiCSRAaPYFAGa+iSHUG1jOqOipd15WE7JlZjfv5ChBN9oK40Q0hs5SvOS/BFQxLX3VSqcOPJIbQT9KO2HNGqGqeAeqO66BFlVEuo0yaolccfAjtnn1rGdr53Fr0sNEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555743; c=relaxed/simple;
	bh=F5KlDyMG8eYzUZvgjPjToLpz2jT4u/0qNKcqnIzbvQ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M83sTLjV7LOxJDjgua2BDQP+aG2lUU87emY6deG3F4hn6SBiaKa9eDAFYmBgGg2TOjH8PMxgUPVOHn2GcaG6T7yrppmtr35Q57kCceWQt/lX5bAUIs/Ax3MXCfUVsEY99hYc6tjYXTb4o5rGtJq0Wfebvp+IgmVX4PYhSjVUKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=D2PlgHaS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8a72cb31fabso37947939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758555740; x=1759160540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TTk4A76Ms2H4wOn644Gvv84BCkr8Ty2d+iDX4Wsm1vg=;
        b=D2PlgHaS3y3JiIy3Di8IpcoH9kiRg/8pdKTo6L9ag3vCE++tf4iEqya33ZZjgcDjtS
         jeQNGqZN+BpSC/IkQDzvCssuU+6nKBfjTjq2h5QbGMgOy9tPHqTlDaa0UOJFAsTM8EQG
         Lkx14PkBdVHvnltmtXcuU6kIG++WHVgPgbqLoFWH/vLFku53SwgziMfZHlqW6CyI4nP0
         Qs811KptzquuPVx1DDHTJ2cepiaQWtmOJThFS0Lekop/8SfOsEAoW+QiTt0Ita29QAjq
         iaIJnPWmgYIQgbfD38i3SNe/Bh/os6Cy5Jq+Ysy3VNFpAYBzdkwDLhbeKIZzSHJrEGcu
         NPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555740; x=1759160540;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTk4A76Ms2H4wOn644Gvv84BCkr8Ty2d+iDX4Wsm1vg=;
        b=YZguM2iR766nO6JaGEyr5vFFtQTWzsrc/HX1G7V1gGgOoGS28IiJhK1ARHXc7nZFUt
         SBxavMiy6FCDA5BcaUjFrfRd60zlRBSiGSx0nwvHABj9ek2BXaBr4Zl91Bn3V4S3WsjE
         SNXwgNlhEGRUY10JKuW0W1YHI0EabXzcbFLB/ZmhE+0BFgYt1gqsxOCBbBxKHw0Hy0ax
         OJztXuIe9zefKmefIALciGHOyUPbzlJ9Cqx3SHhtg5s2Um8NnI2BYuS+/0X67MRoU65q
         lfn4mR9JTlC9/kgMK54IpnyDksplu9frIsfqkPYdQr9dqnZvzbym3Lf/9iBqQROV+ymR
         Vctw==
X-Forwarded-Encrypted: i=1; AJvYcCVknUI28wZOlTqTLkGFYv5Y6yYhdx2UFY1/GkYDGvJ7N/UF0UA3379PX6V1HcMn2WcYsLp//6jf1a8NAcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfEzue3wWeJ3S9gar8yS/cEChPWYD99zSObLevzvn1nkfLVwG
	txyEzpejPv7oLX0Lfx/j34rlWAX5CpxAe7hhN3a+jEiYpIb/i05TcMdIfff67BPC7B0=
X-Gm-Gg: ASbGncuObfT4wH9jYaJ9PP7/co30UkZ9Il73Fe94EZ8cL0Ziaq6dhlpIGP93cjJ1NbT
	faNRzOU6DEc1K/s7hkkurPNnEqARVotRO82UuZGo7FdErOLuw/v0Az3QGEnySo7/HL0wxktbTUu
	C2Yrx/H9wMrnV46u0WEbs+4ZiY94pjQtSHgkOwmmfBmfAZZWbliOeSrfd4y59DGpsu+OM+9DwZs
	Bvm+/PCpTBqgcJ+dQZpVN2IGoha2Zg2pQgrFELGTLKXG3HqShXV9vr/OZ1E+cPCRI/6DADzp9xM
	a38xeiEeP4ZvfNzwGViBWVOog1PLpVxo+yLimhDllrDGg+lb1lz6l7xDmrbIRXBXpPBgMxB+FHS
	luNZwNRw8bvfzYiWNdwvaAA5v23DhFYYqArr872DNlhxTQTk3vynELgH//BjALA==
X-Google-Smtp-Source: AGHT+IEA0zyT2ExHJFMPxt+f+L+M18kdHNHo5quB4MFBWM+Ut2sDE1jLhw5lHfQhZdm8YIzfggn8GA==
X-Received: by 2002:a05:6e02:3048:b0:425:6f30:8fff with SMTP id e9e14a558f8ab-4256f309198mr103820915ab.11.1758555740170;
        Mon, 22 Sep 2025 08:42:20 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afab539sm59790485ab.27.2025.09.22.08.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:42:19 -0700 (PDT)
Message-ID: <a183121f-3ab7-4acf-98b7-9d5367943072@riscstar.com>
Date: Mon, 22 Sep 2025 10:42:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
From: Alex Elder <elder@riscstar.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-3-elder@riscstar.com>
 <a7070f3f-8857-4834-9e9e-02068637075c@iscas.ac.cn>
 <3c9aaa62-f685-47f7-a21c-00f51550f185@riscstar.com>
Content-Language: en-US
In-Reply-To: <3c9aaa62-f685-47f7-a21c-00f51550f185@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/25 10:59 AM, Alex Elder wrote:
> On 9/19/25 10:52 PM, Vivian Wang wrote:
>> Hi Alex,
>>
>> On 9/19/25 23:59, Alex Elder wrote:
>>> [...]
>>>
>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>>> index 82fa5eb3b8684..4f6c446c6bc16 100644
>>> --- a/drivers/spi/Kconfig
>>> +++ b/drivers/spi/Kconfig
>>> @@ -1071,6 +1071,14 @@ config SPI_SG2044_NOR
>>>         also supporting 3Byte address devices and 4Byte address
>>>         devices.
>>> +config SPI_SPACEMIT_K1
>>> +    tristate "K1 SPI Controller"
>>> +    depends on ARCH_SPACEMIT || COMPILE_TEST
>>> +    depends on OF
>>> +    default ARCH_SPACEMIT
>>> +    help
>>> +      Enable support for the SpacemiT K1 SPI controller.
>>> +
>>
>> We could still add:
>>
>>     imply MMP_PDMA if ARCH_SPACEMIT
> 
> I have never used "imply", I guess it's new (as of 2016)...
> 
> This sounds like a good suggestion.  This would mean MMP_PDMA
> would by default take the same value as SPI_SPACEMIT_K1 (if
> the former's dependencies were met), while allowing it to be
> deselected for the configuration.
>   > To add a "recommended" dependency. This way, enabling SPI_SPACEMIT_K1
>> automatically enables MMP_PDMA, but if the user is willing to fiddle
>> around, they can explicitly disable it. What do you think?
> 
> I like it.
> 
>>>   config SPI_SPRD
>>>       tristate "Spreadtrum SPI controller"
>>>       depends on ARCH_SPRD || COMPILE_TEST
>>>
>>> [...]
>>>
>>> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi- 
>>> spacemit-k1.c
>>> new file mode 100644
>>> index 0000000000000..8d564fe6c4303
>>> --- /dev/null
>>> +++ b/drivers/spi/spi-spacemit-k1.c
>>> @@ -0,0 +1,968 @@
>>>
>>> [...]
>>>
>>> +static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
>>> +{
>>> +    struct k1_spi_io *rx = &drv_data->rx;
>>> +    u32 bytes = drv_data->bytes;
>>> +    u32 val;
>>> +
>>> +    val = readl(drv_data->base + SSP_DATAR);
>>> +    rx->resid -= bytes;
>>> +
>>> +    if (!rx->buf)
>>> +        return;    /* Null reader: discard the data */
>>> +
>>> +    if (bytes == 1)
>>> +        *(u8 *)rx->buf = val;
>>> +    else if (bytes == 1)
>>
>> Typo? else if (bytes == 2)
> 
> Wow.  Yes that is an error that I'll correct.
> 
>>> +        *(u16 *)rx->buf = val;
>>> +    else
>>> +        *(u32 *)rx->buf = val;
>>
>> Maybe
>>
>>     else if (bytes == 4)
>>         *(u32 *)rx->buf = val;
>>     else
>>         WARN_ON_ONCE(1);
> 
> The value of bytes will be 1, 2, or 4, which we can tell
> by inspection.  At one time I had a switch statement with
> a default, but I decided to leave out the default, which
> won't happen.
> 
>> Just to make the pattern consistent? Same for k1_spi_write_word.
> 
> Consistent with what?

FYI in updating my code I now realize that k1_spi_write()
and k1_spi_read() were done differently, and that's what
you were talking about.  (I assumed they both used the same
pattern, not checking in the case bytes == 4.)

That was the basis of my "consistent with what?" question
and I'm sorry I didn't realize I was mistaken about how
this was written.

They're both going to look roughly like this now:

         if (bytes == 1)
                 *(u8 *)rx->buf = val;
         else if (bytes == 2)
                 *(u16 *)rx->buf = val;
         else    /* bytes == 4 */
                 *(u32 *)rx->buf = val;

>>> +    rx->buf += bytes;
>>> +}
>>>
>>> [...]
>>>
>>> +static int k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
>>> +{
>>> +    struct device *dev = drv_data->dev;
>>> +    int rx_ret;
>>> +    int tx_ret;
>>> +
>>> +    /* We must get both DMA channels, or neither of them */
>>> +    rx_ret = k1_spi_dma_setup_io(drv_data, true);
>>> +    if (rx_ret == -EPROBE_DEFER)
>>> +        return -EPROBE_DEFER;
>>> +
>>> +    tx_ret = k1_spi_dma_setup_io(drv_data, false);
>>> +
>>> +    /* If neither is specified, we don't use DMA */
>>> +    if (rx_ret == -ENODEV && tx_ret == -ENODEV)
>>> +        return 0;
>>> +
>>> +    if (rx_ret || tx_ret)
>>> +        goto err_cleanup;
>>
>> This seems a bit convoluted. I'm wondering if all this explicit handling
>> really is necessary - if we get an error at probe time, can we just
>> return that error and let devres handle the rest? With the special case
>> that if we get both -ENODEV then disable DMA.
> 
> I agree it seems it should be less complex.

Your suggestion is to simplify this code by falling
back on the devres mechanism to take care of cleaning
things up when an error is returned.

But that won't work, because this function is called
by the devm_k1_spi_dma_setup() devres wrapper function.

If this function returns an error, that function assumes
failure, so it never sets up the resource, and never
calls the cleanup function.  This function must restore
everything to the previous state if it returns an error.

> I'm trying to ensure that both channels are set up, or
> that neither channel is set up, or that we try again if
> we get -EPROBE_DEFER.  And if there's something wrong
> with the configuration (only one of TX and RX is set up
> successfully), an error occurs.
> 
> RX        TX        Result
> --        --        ------
> 0        0        0    (DMA)
> -ENODEV        -ENODEV        0    (PIO)
> -EPROBE_DEFER    (anything)    -EPROBE_DEFER (try again)
> (anything)    -EPROBE_DEFER    -EPROBE_DEFER (try again)
> 0        -ENODEV        -ENODEV    (error, abort probe)
> -ENODEV        0        -ENODEV    (error, abort probe)
> error        (anything)    error    (error, abort probe)
> (anything)    error        error    (error, abort probe)
> 
> Finally, if the buffer allocation fails:
> 0        0        0    (PIO; clean up TX and RX)
> 
> Let me think about this.  I'll see if I can find a simpler way
> to achieve the above result, relying on devres to clean things
> up.  I'd have to change k1_spi_dma_cleanup(), but you might be
> right that it could be done more simply.

Version 3 of this series will keep this code similar to v2.

> 
>> k1_spi_dma_cleanup_io seems to handle unmapping and termination of DMA,
>> which we... don't need, right?

You're right.  Those cleanup activities are not necessary,
because they're meant to clean up stuff that happens *after*
setup completes--once we perform at least one DMA.

HOWEVER, because devm_k1_spi_dma_setup() assumes this
function returns everything to its previous state, the
channels need to be freed explicitly on error (which
did not occur in the v2 code).

And because devm_k1_spi_dma_setup() is already arranging
for resource-managed cleanup, I'm just going to request
the channel "directly" in k1_spi_dma_setup_io() rather
than layering another devm_*() call there.  Then I'll
explicitly release the channel in k1_spi_dma_cleanup_io().

So k1_spi_dma_setup() will basically stay the same.

The same logic applies to allocating the dummy buffer;
it will be done with kzalloc(), and will be freed in
k1_spi_dma_cleanup().

This ended up needing to be fixed, even though it wasn't
exactly what you were looking for.  So either way, I'm
glad you asked about this.

Thanks.

					-Alex

>>> +    drv_data->dummy = devm_kzalloc(dev, SZ_2K, GFP_KERNEL);
>>> +    if (drv_data->dummy)
>>> +        return 0;        /* Success! */
>>> +
>>> +    dev_warn(dev, "error allocating DMA dummy buffer; DMA disabled\n");
>>
>> Just return -ENOMEM. If we can't even allocate 2K of buffer, we're
>> doomed anyway.
> 
> You're generally right, but I don't want my code to assume that.
> 
>>> +err_cleanup:
>>> +    if (tx_ret) {
>>> +        if (tx_ret != -EPROBE_DEFER)
>>> +            dev_err(dev, "error requesting DMA TX DMA channel\n");
>>> +    } else {
>>> +        k1_spi_dma_cleanup_io(drv_data, false);
>>> +    }
>>> +
>>> +    if (rx_ret)
>>> +        dev_err(dev, "error requesting DMA RX DMA channel\n");
>>> +    else
>>> +        k1_spi_dma_cleanup_io(drv_data, true);
>>> +
>>> +    if (tx_ret == -EPROBE_DEFER)
>>> +        return -EPROBE_DEFER;
>>> +
>>> +    /* Return success if we don't get the dummy buffer; PIO will be 
>>> used */
>>> +
>>> +    return rx_ret ? : tx_ret ? : 0;
>>> +}
>>>
>>> [...]
>>>
>>> +static int devm_k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
>>> +{
>>> +    struct k1_spi_driver_data **ptr;
>>> +    int ret;
>>> +
>>> +    if (!IS_ENABLED(CONFIG_MMP_PDMA)) {
>>> +        dev_warn(drv_data->dev, "DMA not available; using PIO\n");
>>> +        return 0;
>>> +    }
>>> +
>>
>> Shouldn't be necessary if we do the "imply" thing in Kconfig.
> 
> The messages I provide are based on an assumption that using
> DMA is desirable and it will normally be used by this driver.
> So if it won't be used, I'd like to provide that information.
> 
> On the other hand, I don't issue a warning if neither of
> the channels is configured in the DTB.
> 
> I'm not going to commit either way on keeping/removing this.
> If someone else weighs in I'm open to changing it.
> 
>>> [...]
>>>
>>> +static void k1_spi_host_init(struct k1_spi_driver_data *drv_data)
>>> +{
>>>
>>> [...]
>>>
>>> +
>>> +    ret = of_property_read_u32(np, "spi-max-frequency", &max_speed_hz);
>>> +    if (!ret) {
>>> +        host->max_speed_hz = clamp(max_speed_hz, K1_SPI_MIN_SPEED_HZ,
>>> +                       K1_SPI_MAX_SPEED_HZ);
>>> +        if (host->max_speed_hz != max_speed_hz)
>>> +            dev_warn(dev, "spi-max-frequency %u out of range, using 
>>> %u\n",
>>> +                max_speed_hz, host->max_speed_hz);
>>> +    } else {
>>> +        if (ret != -EINVAL)
>>> +            dev_warn(dev, "bad spi-max-frequency, using %u\n",
>>> +                 K1_SPI_DEFAULT_MAX_SPEED_HZ);
>>> +        host->max_speed_hz = K1_SPI_DEFAULT_MAX_SPEED_HZ;
>>> +    }
>>
>> I think it makes sense to have spi-max-frequency default to
>> K1_SPI_DEFAULT_MAX_SPEED_HZ, but if the value is out of range just print
>> a message and return an error, to get whoever wrote the bad value to 
>> fix it.
> 
> These errors just shouldn't happen.  But the way I handle this,
> it allows the SPI controller to still be used, even if the
> administrator can't really update the DTB.
> 
>> This range seems to be fixed by hardware, so, it should also be
>> specified in the bindings.
> 
> I define the hardware limits here, and enforce
> them, in case the bindings specify an out-of-range
> value.  Again, this is an error that just shouldn't
> occur in practice, but the code is defensive.
> 
> Most of your comments really made me think about how
> errors are handled.  I appreciate it.
> 
>                      -Alex
> 
>>
>>> +}
>>> +
>>>
>>> [...]
>>>
>>> +
>>> +static int k1_spi_probe(struct platform_device *pdev)
>>> +{
>>> +    struct k1_spi_driver_data *drv_data;
>>> +    struct device *dev = &pdev->dev;
>>> +    struct reset_control *reset;
>>> +    struct spi_controller *host;
>>> +    struct resource *iores;
>>> +    struct clk *clk_bus;
>>> +    int ret;
>>> +
>>> +    host = devm_spi_alloc_host(dev, sizeof(*drv_data));
>>> +    if (!host)
>>> +        return -ENOMEM;
>>> +    drv_data = spi_controller_get_devdata(host);
>>> +    drv_data->controller = host;
>>> +    platform_set_drvdata(pdev, drv_data);
>>> +    drv_data->dev = dev;
>>> +    init_completion(&drv_data->completion);
>>> +
>>> +    drv_data->base = devm_platform_get_and_ioremap_resource(pdev, 0,
>>> +                                &iores);
>>
>> Maybe
>>
>>      devm_platform_ioremap_resource(pdev, 0);
>>
>>> [...]
>>>
>>> +
>>> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
>>> +MODULE_LICENSE("GPL");
>>
>> Maybe MODULE_AUTHOR()?
>>
>> Vivian "dramforever" Wang
>>
> 


