Return-Path: <linux-kernel+bounces-726693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC7B01013
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DD2648285
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7138A55;
	Fri, 11 Jul 2025 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRKMoM63"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DE2907
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192567; cv=none; b=P3tmZHBEFNxaWOyhI41nruxaM1z0Q46GIprbGvr9375WukH1Q7QwyzQshF6Y/9ZK3TrFEQuV0OMtjXv+iyvpdbVRE1qPjSzDy730SxqcVX0F32siWWkoFA0rmJjqjfEdcRXOE7NRT0xBcWcgAirsT0I9l2VbDK0d0QvxNrlEgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192567; c=relaxed/simple;
	bh=rEWPBTaP2SnUs7I8c1ezuB9fgds2C7P/BinjZrwZjoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=stn7o+F7s2gpaix4pSr+YvWxgVTvtOXYxZ7Us+QMCdmJTmA5GjDdRFyjwJQwTnNbIEQ+n3yGHc0n3KzSNdWQCLTTe1nhFVz3e/i/awaN30KNiO8rr7AyC8gh0YpcnGY0BQEZ6jYW+BaKfEWt/5OXTd1fNJJhJIstcN/gxDkqrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nRKMoM63; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B099QC1903778;
	Thu, 10 Jul 2025 19:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752192549;
	bh=EKp5sp1aDzZ+dHuvVFBxVSX5oTjMSpEkqJx+sm0IIOs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nRKMoM63Hy4NdulPtu6CJn/uC/vY7Hu6jp/RzXls9SeOB37jDT4DwCqx05FtW0vtC
	 i4R/nE0c8cKKxhq2MeCCUOu3/TC1rsyNpIG5HyNMEspGCBUXMKCaTPw2QqziEvfJ6k
	 I2lflO/taLX/yLRvp7zuiC1aOBC/h7uAg5pwyGnU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B09953620268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 19:09:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 19:09:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 19:09:09 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B099Ud2511915;
	Thu, 10 Jul 2025 19:09:09 -0500
Message-ID: <c2c56a48-9d0e-4a0e-acd8-94af5d80460f@ti.com>
Date: Thu, 10 Jul 2025 19:09:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] firmware: ti_sci: Enable abort handling of entry to
 LPM
To: Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <vigneshr@ti.com>, <d-gole@ti.com>,
        <vishalm@ti.com>, <sebin.francis@ti.com>, <msp@baylibre.com>,
        <khilman@baylibre.com>
References: <20250709221619.2237699-1-k-willis@ti.com>
 <20250710054401.5hmhsdtyulcskwug@zodiac>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250710054401.5hmhsdtyulcskwug@zodiac>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 7/10/25 00:44, Nishanth Menon wrote:
> On 17:16-20250709, Kendall Willis wrote:
>> The PM co-processor (device manager or DM) adds the ability to abort
>> entry to a low power mode by clearing the mode selection in the
>> latest version of its firmware (11.x). The following power management
>> operation defined in the TISCI Low Power Mode API [1] is implemented to
>> enable aborting entry to LPM:
>>
>> TISCI_MSG_LPM_ABORT
>> Abort the current low power mode entry by clearing the current mode
>> selection.
>>
>> Introduce LPM abort call that enables the ti_sci driver to support abort
>> by clearing the low power mode selection of the DM. This fixes behavior
>> from the DM where if system suspend failed, the next time system suspend
>> is entered, it will fail because DM did not have the low power mode
>> selection cleared. Instead of this behavior, the low power mode selection
>> will be cleared after Linux resume which will allow subsequent system
>> suspends to work correctly.
>>
>> When Linux suspends, the TI SCI ->suspend() call will send a prepare_sleep
>> message to the DM. The DM will choose what low power mode to enter once
>> Linux is suspended based on constraints given by devices in the TI SCI PM
>> domain. After system suspend completes, regardless of if system suspend
>> succeeds or fails, the ->complete() hook in TI SCI will be called. In the
>> ->complete() hook, a message will be sent to the DM to clear the current
>> low power mode selection. This is necessary because if suspend fails, the
>> low power mode selection in the DM is not cleared and the next system
>> suspend will fail due to the low power mode not having been cleared from
>> the previous failed system suspend.
>>
>> Clearing the mode selection unconditionally acts as a cleanup from sending
>> the prepare_sleep message in ->suspend(). The DM already clears the low
>> power selection automatically when resuming from system suspend. If
>> suspend/resume executed without failure, clearing the low power mode
>> selection will not cause an error in the DM.
>>
>> The flow for the abort sequence is the following:
>>     1. User sends a command to enter sleep
>>     2. Linux starts to suspend drivers
>>     3. TI SCI suspends and sends prepare_sleep message to DM
>>     4. A driver fails to suspend
>>     5. Linux resumes the drivers that have already suspended
>>     6. Linux sends DM to clear the current low power mode selection from
>>        TI SCI ->complete() hook
>>     7. DM aborts LPM entry by clearing the current mode selection
>>     8. Linux works as normal
> 
> Could we trim the message a bit down? it is informative, thanks.. but I
> think a bit repetitive.

Will fix in v4.

> 
>>
>> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>> Series has been tested on an SK-AM62B-P1 board. Normal suspend/resume
>> has been verified. Abort was tested by adding an error into the TI SCI
>> suspend hook.
> 
> btw, does this handle the noirq case as well? I have'nt looked closely
> at the sequence to be sure.

It does. I tested adding an error into the TI SCI suspend_noirq hook 
using this patch on top of latest TI SDK [1]. Abort worked. I was not 
able to test with kernel v6.16 next because when I added an error into 
TI SCI suspend_noirq hook, Linux would not resume.

[1] 
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-6.12.y-cicd

> 
>>
>> Link to v2:
>> https://lore.kernel.org/all/20250709205332.2235072-1-k-willis@ti.com/
>> Link to v1:
>> https://lore.kernel.org/all/20250627204821.1150459-1-k-willis@ti.com/
>>
>> Changes from v2 to v3:
>>    - added links to previous series and the changes between them
> 
> Thanks, but in the future, I'd rather not want a v3, but just reply
> with the missing info and better still, add to your pre-send checklist
> to ensure you don't miss it in the future ;).
> 
> 

Noted, will definitely add to my own checklist.

>>
>> Changes from v1 to v2:
>>     - rebase on linux-next
>>     - drop the following patch:
>>       pmdomain: ti_sci: Add LPM abort sequence to suspend path
>>     - remove lpm_abort from ti_sci_pm_ops
>>     - add ->complete() hook with ti_sci_cmd_lpm_abort to be called
>>       unconditionally within it
>>     - remove ti_sci_cmd_lpm_abort from the ->suspend() and
>>       ->suspend_noirq() hooks
>>     - reword commit message
>> ---
>>   drivers/firmware/ti_sci.c | 61 +++++++++++++++++++++++++++++++++++++++
>>   drivers/firmware/ti_sci.h |  3 +-
>>   2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index ae5fd1936ad32..63c405f7037f0 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -2015,6 +2015,58 @@ static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
>>   	return ret;
>>   }
>>   
>> +/**
>> + * ti_sci_cmd_lpm_abort() - Abort entry to LPM by clearing selection of LPM to enter
>> + * @handle:     pointer to TI SCI handle
>> + *
>> + * Return: 0 if all went well, else returns appropriate error value.
>> + */
>> +static int ti_sci_cmd_lpm_abort(const struct ti_sci_handle *handle)
>> +{
>> +	struct ti_sci_info *info;
>> +	struct ti_sci_msg_hdr *req;
>> +	struct ti_sci_msg_hdr *resp;
>> +	struct ti_sci_xfer *xfer;
>> +	struct device *dev;
>> +	int ret = 0;
>> +
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>> +	if (!handle)
>> +		return -EINVAL;
>> +
>> +	info = handle_to_ti_sci_info(handle);
>> +	dev = info->dev;
> 
> -ECONFUSED. ti_sci_complete already gets dev and info and this API is
> not exposed to other users. So why do we need to flip back and forth
> with info->handle and then get info from handle and dev again??

I had the parameter as 'const struct ti_sci_handle *handle' since all 
other functions that send a message to DM have that as the parameter, so 
I followed the convention. However, since the API is not exposed, I can 
change the parameter to be 'struct device *dev' in the next version.

>> +
>> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_ABORT,
>> +				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
>> +				   sizeof(*req), sizeof(*resp));
>> +	if (IS_ERR(xfer)) {
>> +		ret = PTR_ERR(xfer);
>> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
>> +		return ret;
>> +	}
>> +	req = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
>> +
>> +	ret = ti_sci_do_xfer(info, xfer);
>> +	if (ret) {
>> +		dev_err(dev, "Mbox send fail %d\n", ret);
>> +		goto fail;
>> +	}
>> +
>> +	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
>> +
>> +	if (!ti_sci_is_response_ack(resp))
>> +		ret = -ENODEV;
>> +	else
>> +		ret = 0;
> is'nt ret already 0?
> 
> OR you could go with ? like rest of code.. ;)

Good catch, will remove the else section there.

> 
>> +
>> +fail:
>> +	ti_sci_put_one_xfer(&info->minfo, xfer);
>> +
>> +	return ret;
>> +}
>> +
>>   static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
>>   {
>>   	struct ti_sci_info *info;
>> @@ -3739,11 +3791,20 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
>>   	return 0;
>>   }
>>   
>> +static void __maybe_unused ti_sci_complete(struct device *dev)
> 
> ti_sci_pm_complete or something like that?

Will change to this in v4.

> 
>> +{
>> +	struct ti_sci_info *info = dev_get_drvdata(dev);
>> +
>> +	if (ti_sci_cmd_lpm_abort(&info->handle))
> 
> I see from the documentation of .complete that it is invoked in
> multitude of scenarios, including resume as well. While I think it is
> probably fine to clear the state, have you had a chance to look at
> possible side effects in other flows (thaw etc..?)

Based on the documentation in the other flows I don't think it would 
cause any side effects. Both ->restore() and ->thaw() hooks in 
hibernation act similarly to ->resume(). Therefore, clearing the LPM 
selection should work fine after those hooks.

> 
> Additionally, do we want to check info->fw_caps &
> MSG_FLAG_CAPS_LPM_DM_MANAGED before sending it over to DM?

Yes, a check for MSG_FLAG_CAPS_LPM_DM_MANAGED should be added before 
sending to DM. I'll add that in next version.

> 
>> +		dev_err(dev, "LPM clear selection failed.\n");
>> +}
>> +
>>   static const struct dev_pm_ops ti_sci_pm_ops = {
>>   #ifdef CONFIG_PM_SLEEP
>>   	.suspend = ti_sci_suspend,
>>   	.suspend_noirq = ti_sci_suspend_noirq,
>>   	.resume_noirq = ti_sci_resume_noirq,
>> +	.complete = ti_sci_complete,
> 
> Another question - when is .complete called as part of rewind? does DM
> behave sane while other drivers are resuming back up before .complete is
> invoked?

.complete is called after all drivers are resumed. DM does behave 
normally during this. Adding the .complete makes it so that if a driver 
failed during the first suspend cycle, DM won't have a stale LPM 
selected. The stale LPM selection in DM would cause the DM to NACK 
prepare_sleep on the next suspend cycle.

> 
>>   #endif
>>   };
>>   
>> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
>> index 053387d7baa06..51d77f90a32cc 100644
>> --- a/drivers/firmware/ti_sci.h
>> +++ b/drivers/firmware/ti_sci.h
>> @@ -6,7 +6,7 @@
>>    * The system works in a message response protocol
>>    * See: https://software-dl.ti.com/tisci/esd/latest/index.html for details
>>    *
>> - * Copyright (C)  2015-2024 Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C)  2015-2025 Texas Instruments Incorporated - https://www.ti.com/
> 
> please dont keep shifting license year for trivial changes :)
>>    */
>>   
>>   #ifndef __TI_SCI_H
>> @@ -42,6 +42,7 @@
>>   #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
>>   #define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
>>   #define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
>> +#define TI_SCI_MSG_LPM_ABORT	0x0311
> 
> NOTE: all the LPM stuff is enabled with MSG_FLAG_CAPS_LPM_DM_MANAGED.
> Is this supported from the very beginning version of firmware that
> has this? else will we see issues in the field with a mix of firmware
> versions.. some just crashing out when the message is not supported?

This is newly supported in firmware 11.0, whereas the other LPM features 
were supported in firmware 10.0. I will have to check if there is any 
way for abort to be not called if firmware doesn't support it.

> 
>>   
>>   /* Resource Management Requests */
>>   #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
>>
>> base-commit: 835244aba90de290b4b0b1fa92b6734f3ee7b3d9
>> -- 
>> 2.34.1
>>
> 

Thanks for taking the time review at this patch :)

---
Best,
Kendall Willis

