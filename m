Return-Path: <linux-kernel+bounces-685622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A9AD8C60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C591E17AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7358472;
	Fri, 13 Jun 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cliDQcz+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAE4C92
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818691; cv=none; b=rZWZNbUyLnOb3TqofEv4FgcjisEL/FqV67hPp1n9ak+My+amu373+rIi7X31ql27Yj13T2krScn+4kaEpbnnKjfGrWPdCBzoaCvE+XdvDIAyCw3cswwiF986lObCvMCFkc3cs4seEPBBQ6mFg4PIWmD9bfcW9IM04faIfGOk+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818691; c=relaxed/simple;
	bh=VweSG6fdUtHODRk9Mn4GQFkswmVd6nP2SUPa54kMECE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7vXF/o/Fo2cecRXvULKjJfF1ozxuW4kOWDYCEYYlC+Htq5U0orBty5/5ggg/BBQVrjlrXrR6/Ohp27R5Q6HwBmFnfbZLurtWdZ1nNFLO/2AqxjoY144cLNUoa/RMq9TnWX+wW7eL0CWsgy1a4WEvwbbnIRMqfxNAKhqGn96/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cliDQcz+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so5640638a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749818687; x=1750423487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPoL5EqHG6bXenIrDxuxxRFrFkbnUI2271AFY3JaR4M=;
        b=cliDQcz+YeiAh3r84L5a1Gof9DmXkkuzRrvxMBr9wuH8GlRqvnO0BgxWq1GoCjif5I
         1+7ZSQyK6r8gxHNtd1gcpRz/lWSIN0D1npqUCsLozwEIUR3DZFToIBitw+kOt0KnRzp/
         h/TAKB4MopMT9qQeLPwnt8A+c19FmmIdQB7UCpIEdG5BH6UhxYxVAcmxUuzSswtfGr28
         uCgqOhqDCV44r5XzIcUlINOeGmDtOZLYfX6P5vJPRDg6/32OUGfCJobbq4GmePDM+xQZ
         0G1hxTpitnn9GmHNH4JbZJSpxp2tODOlMSpoDW/iOtT2oN8SJShcYXS0dT5OecygHtSi
         TAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749818687; x=1750423487;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPoL5EqHG6bXenIrDxuxxRFrFkbnUI2271AFY3JaR4M=;
        b=EeZHsCjfiVTpiyTKWvRAdt0WuDwftu3En9UgNP9QhN1CLSY8VSQPLeWKcny1i4KRuq
         NiVZ/zkU+XaY61m31LfZN4SqUXDBH5GIMmbK0gm6DcsLwjyPUaV8kgsHPcMAHpM90i9J
         xZ7k9BZXT6XCE86IKBxglRH62/HsfVTWkDFBnNSIQQAgpHZgpDrXXRbU2QX+NRDtKZOR
         4Xh1kZ1usKabzM0mQ0yef7FO+ZtBRGrlvAJvrD1qcrdyEcTITorTqOG4LzXruJBBnlA5
         mxDqvgF2OakHHZ7ZH/MQHS6iA3EAxt6U9S++p6uL9DBaIXfQ/wNYLJ1pejNm0sKL3BAt
         yYDA==
X-Forwarded-Encrypted: i=1; AJvYcCUHuQRORttGA9wzqhyp2PNSRGgbmS9qwKm/WznnLCX1SkaE7MJCu54uSYzZ/+vQlW9LGQiN87U4TFWAd0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1tT6qdJnBRW0Qw+eehWfYUCjEIG+/avpR1FU0dI87jNxoHBY
	uhNwS2DfLMiyObUuzcADzdzhDtjmp1yDAwfrdPNb+4NKAlWv84MgCw+NSzJzIEEdyM0=
X-Gm-Gg: ASbGncvAnhDcmSsXi4gGOUACisStyQZ8rPI6U1Qypl3b0cWEImnnHsIIrgaBsUV+x1A
	Iu3VPztI1HIynyeu0Ma6UTL52DPZWh7XIc+ZhZcSKG6r7woATDSNoG6Er84H1FrqM+l0F0CiQJL
	irSfY2sSEfuTxZ5s/q3fz8FGOkW9Rf4evBcDjsT6zQklZF/F6xi4M0kfk7LQUYkYVB0Uts2FPgr
	x/NMBSLDKTplyWz2JR4ihS5ZesBrOiKcyTFvF7mCQX+Cfcc+MCEWZGHkbMdwVZVvqeiAhaPlGXj
	dMMN+FkyGrBVlqQjHN+yeTUGSXErXzq//DJVGwwMXzBLHH2s70uSPEZ5YD7qoev3uhYi2ds=
X-Google-Smtp-Source: AGHT+IEiOZ0oxH8aXFWS+MvfSPyWsV0mO2uHgvxgbLa+Cyk0b3UYBQ8VV7zStzG6pYcuXbm734Rh7w==
X-Received: by 2002:a17:907:6eab:b0:aca:d29e:53f1 with SMTP id a640c23a62f3a-adf54522af0mr59623666b.12.1749818687155;
        Fri, 13 Jun 2025 05:44:47 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c1f04sm124000366b.54.2025.06.13.05.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 05:44:46 -0700 (PDT)
Message-ID: <cd049cfa-60da-4607-ad5f-6565d3d0fb8e@tuxon.dev>
Date: Fri, 13 Jun 2025 15:44:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org,
 dakr@kernel.org, len.brown@intel.com, pavel@kernel.org,
 ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com,
 geert@linux-m68k.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
 <20250607140600.76e87ea5@jic23-huawei>
 <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
 <486a1110-5336-42fd-82b8-a7b1452bad65@tuxon.dev>
 <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Rafael,

On 13.06.2025 13:02, Rafael J. Wysocki wrote:
> On Fri, Jun 13, 2025 at 9:39 AM Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>> Hi, Rafael,
>>
>> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
>>> On Sat, Jun 7, 2025 at 3:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>>>
>>>> On Fri, 6 Jun 2025 22:01:52 +0200
>>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>>> On Fri, Jun 6, 2025 at 8:55 PM Dmitry Torokhov
>>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
>>>>>>> On Fri, Jun 6, 2025 at 1:18 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>>>>
>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>
>>>>>>>> The dev_pm_domain_attach() function is typically used in bus code alongside
>>>>>>>> dev_pm_domain_detach(), often following patterns like:
>>>>>>>>
>>>>>>>> static int bus_probe(struct device *_dev)
>>>>>>>> {
>>>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>>>     int ret;
>>>>>>>>
>>>>>>>>     // ...
>>>>>>>>
>>>>>>>>     ret = dev_pm_domain_attach(_dev, true);
>>>>>>>>     if (ret)
>>>>>>>>         return ret;
>>>>>>>>
>>>>>>>>     if (drv->probe)
>>>>>>>>         ret = drv->probe(dev);
>>>>>>>>
>>>>>>>>     // ...
>>>>>>>> }
>>>>>>>>
>>>>>>>> static void bus_remove(struct device *_dev)
>>>>>>>> {
>>>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>>>
>>>>>>>>     if (drv->remove)
>>>>>>>>         drv->remove(dev);
>>>>>>>>     dev_pm_domain_detach(_dev);
>>>>>>>> }
>>>>>>>>
>>>>>>>> When the driver's probe function uses devres-managed resources that depend
>>>>>>>> on the power domain state, those resources are released later during
>>>>>>>> device_unbind_cleanup().
>>>>>>>>
>>>>>>>> Releasing devres-managed resources that depend on the power domain state
>>>>>>>> after detaching the device from its PM domain can cause failures.
>>>>>>>>
>>>>>>>> For example, if the driver uses devm_pm_runtime_enable() in its probe
>>>>>>>> function, and the device's clocks are managed by the PM domain, then
>>>>>>>> during removal the runtime PM is disabled in device_unbind_cleanup() after
>>>>>>>> the clocks have been removed from the PM domain. It may happen that the
>>>>>>>> devm_pm_runtime_enable() action causes the device to be runtime-resumed.
>>>>>>>
>>>>>>> Don't use devm_pm_runtime_enable() then.
>>>>>>
>>>>>> What about other devm_ APIs? Are you suggesting that platform drivers
>>>>>> should not be using devm_clk*(), devm_regulator_*(),
>>>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
>>>>>> dev_pm_domain_detach() that is called by platform bus_remove() may shut
>>>>>> off the device too early, before cleanup code has a chance to execute
>>>>>> proper cleanup.
>>>>>>
>>>>>> The issue is not limited to runtime PM.
>>>>>>
>>>>>>>
>>>>>>>> If the driver specific runtime PM APIs access registers directly, this
>>>>>>>> will lead to accessing device registers without clocks being enabled.
>>>>>>>> Similar issues may occur with other devres actions that access device
>>>>>>>> registers.
>>>>>>>>
>>>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
>>>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
>>>>>>>> device is detached from its PM domain in device_unbind_cleanup(), only
>>>>>>>> after all driver's devres-managed resources have been release.
>>>>>>>>
>>>>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2 state
>>>>>>>> arguments, one for the domain state on attach, one for the domain state on
>>>>>>>> detach.
>>>>>>>
>>>>>>> dev_pm_domain_attach() is not part driver API and I'm not convinced at
>>>>>>
>>>>>> Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?
>>>>>
>>>>> Yes, among other things.
>>>>
>>>> Maybe naming could make abuse at least obvious to spot? e.g.
>>>> pm_domain_attach_with_devm_release()
>>>
>>> If I'm not mistaken, it is not even necessary to use devres for this.
>>>
>>> You might as well add a dev_pm_domain_detach() call to
>>> device_unbind_cleanup() after devres_release_all().  There is a slight
>>> complication related to the second argument of it, but I suppose that
>>> this can be determined at the attach time and stored in a new device
>>> PM flag, or similar.
>>>
>>
>> I looked into this solution. I've tested it for all my failure cases and
>> went good.
> 
> OK
> 
>>> Note that dev->pm_domain is expected to be cleared by ->detach(), so
>>> this should not cause the domain to be detached twice in a row from
>>> the same device, but that needs to be double-checked.
>>
>> The genpd_dev_pm_detach() calls genpd_remove_device() ->
>> dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain = NULL. I can't
>> find any other detach function in the current code base.
> 
> There is also acpi_dev_pm_detach() which can be somewhat hard to find,
> but it calls dev_pm_domain_set(dev, NULL) either.

Thank you for the pointer.

> 
>> The code I've tested for this solution is this one:
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index b526e0e0f52d..5e9750d007b4 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/wait.h>
>>  #include <linux/async.h>
>> +#include <linux/pm_domain.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pinctrl/devinfo.h>
>>  #include <linux/slab.h>
>> @@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct device *dev)
>>         dev->dma_range_map = NULL;
>>         device_set_driver(dev, NULL);
>>         dev_set_drvdata(dev, NULL);
>> -       if (dev->pm_domain && dev->pm_domain->dismiss)
>> -               dev->pm_domain->dismiss(dev);
>> +       if (dev->pm_domain) {
>> +               if (dev->pm_domain->dismiss)
>> +                       dev->pm_domain->dismiss(dev);
>> +               dev_pm_domain_detach(dev, dev->pm_domain->detach_power_off);
> 
> I would do the "detach" before the "dismiss" to retain the current ordering.

OK.

> 
> Also it is interesting that you ended up calling them both in one
> place.  It kind of indicates that the PM domains attached via
> dev_pm_domain_attach() should be attached earlier and just use the
> ->activate() and ->dismiss() callbacks.
> 
>> +       }
>>         pm_runtime_reinit(dev);
>>         dev_pm_set_driver_flags(dev, 0);
>>  }
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 075ec1d1b73a..2459be6aecf4 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -1400,11 +1400,8 @@ static int platform_probe(struct device *_dev)
>>         if (ret)
>>                 goto out;
>>
>> -       if (drv->probe) {
>> +       if (drv->probe)
>>                 ret = drv->probe(dev);
>> -               if (ret)
>> -                       dev_pm_domain_detach(_dev, true);
>> -       }
>>
>>  out:
>>         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>> @@ -1422,7 +1419,6 @@ static void platform_remove(struct device *_dev)
>>
>>         if (drv->remove)
>>                 drv->remove(dev);
>> -       dev_pm_domain_detach(_dev, true);
>>  }
>>
>>  static void platform_shutdown(struct device *_dev)
>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> index 781968a128ff..4bd1e3c7f401 100644
>> --- a/drivers/base/power/common.c
>> +++ b/drivers/base/power/common.c
>> @@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
>>         if (!ret)
>>                 ret = genpd_dev_pm_attach(dev);
>>
>> +       if (dev->pm_domain)
>> +               dev->pm_domain->detach_power_off = power_on;
> 
> This will not work for acpi_general_pm_domain because it is shared by
> all of its users.
> 
> It is likely to not work for shared PM domains in general.
> 
> I would put the new flag into struct dev_pm_info.

OK, I'll do it.

Thank you for your input,
Claudiu

> 
>> +
>>         return ret < 0 ? ret : 0;
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index f0bd8fbae4f2..12e97e09e85c 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -748,6 +748,7 @@ struct dev_pm_domain {
>>         void (*sync)(struct device *dev);
>>         void (*dismiss)(struct device *dev);
>>         int (*set_performance_state)(struct device *dev, unsigned int state);
>> +       bool detach_power_off;
>>  };
>>
>> Rafael, Ulf, Dmitry, Jonathan, all,
>>
>> Could you please let me know how do you consider this approach?
> 
> Please see my comments above.
> 
> Thanks!


