Return-Path: <linux-kernel+bounces-806722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B9B49AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017A94E10C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11E2DD5EF;
	Mon,  8 Sep 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g2t1wIju"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694302DCF63
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362779; cv=none; b=uD5VMzNHorwK9Pv2nEOVDM+3Y2Vv9FznHdTDEWRiGKeLS2UUfJg5ZdabbPD+/ar3kt2yP5UevAaB068wfNCdXm6dQIito26pdySyBgam8tzlj8XXjqyH/XYIh9bK6nvtZ3IwbVdj27A40uUIueey1Xkg+SCRxIm8LA5YHQalZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362779; c=relaxed/simple;
	bh=sunc1sBZHjtxiFsevsskggwKFDeZ5rB1V5mXDaDKnN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rf2dhlAOY5D6viA9o89/MoTe5KgBrTQGURikCi0ZzFhP1f0gRyFDypdg9pE/H8dNWh3Oehl1LzZ0Gz3JP1UH1YdjCUAkYhDjaZfT3L+RLpBnPLlNFfP+xDcMlVr/rpvbggintotDQ5zpvYi/ERLhyGDpZHbu8umTmXIsfhAY+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g2t1wIju; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588KJQSI128506;
	Mon, 8 Sep 2025 15:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757362766;
	bh=VY5vW/TBFhiKiObWKD3QATMgCx/mPhcn8MxelvsDWwI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g2t1wIjuysolhs1oTACUr4ABdO8JNL4Ls3LkXTVH6pAQfFJd8GouZrCDpJZfdTNKh
	 ZiBhoo9b0aUXHR5JN2S48VpEkQLcwKCUqRChzz9hiK+DKCLaBFhdXoSHEG4B6un+i+
	 HdcsVjuRjVmDUZNRNs+njbtaVtctvpGj0sLSURu0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588KJQqO4016603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 15:19:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 15:19:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 15:19:26 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588KJQlq1163717;
	Mon, 8 Sep 2025 15:19:26 -0500
Message-ID: <48ad21a2-6562-4568-aace-68d163116ddd@ti.com>
Date: Mon, 8 Sep 2025 15:19:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: ti_sci: Handle wakeup constraint if device has
 pinctrl wakeup state
To: Dhruva Gole <d-gole@ti.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>
References: <20250904211607.3725897-1-k-willis@ti.com>
 <20250905183931.qfqnnvmwqqvo3emy@lcpd911>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250905183931.qfqnnvmwqqvo3emy@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dhruva,

On 9/5/25 13:39, Dhruva Gole wrote:
> On Sep 04, 2025 at 16:16:07 -0500, Kendall Willis wrote:
>> In TI K3 SoCs the PM co-processor (device manager or DM) will decide
>> which low power state to suspend into based off of constraints given by
>> Linux. If a device is marked as a wakeup source in Linux, Linux will add
>> a constraint that the wakeup source has to be on. The DM will enter the
>> deepest low power state based off of the constraint.
>>
>> In cases like UARTs, IO daisy-chaining can be used to wakeup the system,
>> however if the UART is marked as a wakeup source, the system is not able
>> to enter any low power mode.
>>
>> IO daisy-chain wakeup can use the pinctrl wakeup state instead of using
>> wake IRQs. For example, the serial driver on K3 platforms uses a wakeup
> 
> I think this statement will only make sense to someone who's worked on
> io daisychain and wake IRQs on our SoCs.
> I don't think it's coming out very clearly why wake IRQs are needed for
> IO Daisychain in the first place.
> 
> You could probably just reference commit b06bc47279919 ("pmdomain:
> ti_sci: handle wake IRQs for IO daisy chain wakeups") from Kevin where
> we explain whats io daisychain and need for wake IRQ. Talk in this patch
> with relation to that patch - what you're doing that the other one
> missed.
> 
>> pinctrl state to be able to resume from suspend.
> 
> Perhaps I am missing the order in which the patches are being applied.
> But if it's like the 1 -> 2 -> 3 order you mentioned below then this
> reference to serial drv won't really make sense right?
> 
> If we're going in the order of applying the series that you
> specified, there's no guarantee that the UART patch makes it in
> along with this patch, so I'd say let's skip mentioning the serial
> driver to avoid sending people in search for how the serial driver is
> doing this atall.
> 
> In Kevin's earlier commit it made sense, because he was talking about
> daisychaining, here we're not. So the 8250 driver doesn't actually have
> the changes we're talking about in this patch.

In v2, I will add references to commit b06bc47279919 ("pmdomain: ti_sci: 
handle wake IRQs for IO daisy chain wakeups") and I will remove the 
reference to the UART driver.

Thanks,
Kendall

> 
>>
>> Devices that are marked as a wakeup source and use pinctrl wakeup state
>> should not set wakeup constraints since these can happen even from deepest
>> low power state, so the DM should not be prevented from picking deep power
>> states.
>>
>> Detect the pinctrl wakeup state in the suspend path, and if it exists,
>> skip sending the constraint.
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>> This series is intended to be implemented along with the following
>> series:
>>
>> 1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
>>     wakeup state": (this patch) skips setting constraints for wakeup
>>     sources that use pinctrl state 'wakeup'.
>>
>> 2. "serial: 8250: omap: Add wakeup support": Implements wakeup from
>>     the UARTs for TI K3 SoCs
>>
>> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>>     functionality to wakeup the system from the Main UART
>>
>> Testing
>> -------
>> Tested on a SK-AM62B-P1 board with all series and dependencies
>> implemented. Suspend/resume verified with the Main UART wakeup source
>> by entering a keypress on the console.
>>
>> ---
>>   drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 82df7e44250bb..884905fd0686c 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/err.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_qos.h>
>> @@ -84,9 +85,24 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>>   	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>>   	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>>   	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> +	struct pinctrl *pinctrl = devm_pinctrl_get(dev);
>> +	struct pinctrl_state *pinctrl_state_wakeup;
>>   	int ret;
>>   
>>   	if (device_may_wakeup(dev)) {
>> +		/*
>> +		 * If device can wakeup using pinctrl wakeup state,
>> +		 * we do not want to set a constraint
>> +		 */
>> +		if (!IS_ERR_OR_NULL(pinctrl)) {
>> +			pinctrl_state_wakeup = pinctrl_lookup_state(pinctrl, "wakeup");
>> +			if (!IS_ERR_OR_NULL(pinctrl_state_wakeup)) {
>> +				dev_dbg(dev, "%s: has wake pinctrl wakeup state, not setting " \
>> +						"constraints\n", __func__);
>> +				return;
>> +			}
>> +		}
>> +
> 
> Not much objections to the code itself, as it makes sense that we want
> to ignore the constraint for wakeup pinctrl similar to how we did for the
> wake IRQ one.
> 


