Return-Path: <linux-kernel+bounces-767925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA0B25A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C7B884933
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DB1F152D;
	Thu, 14 Aug 2025 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KKNuHuLB"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F31A288
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755147229; cv=none; b=slVp8BiHy6r2X4WtVDodQYoZu/gaSokfgGaGqJub4RPkqun/8dkHcu53ETAAjqeHG3veB8m4U142qaWmPP9EgMOv/0uF3Ze6BkyWwgu6zK1pOL3NNsRnypRUn1/4MADJP3BkQzQuTgN2UZhTGBBH8OmHKWFcdl4mjEbJmZf+Tm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755147229; c=relaxed/simple;
	bh=TQjt6KghIVeGBBwYSaTyXILHNRq60cPOOTfYiH+YmhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YlKYY4lCB8Km9Eid55MqrIFb90blb0qkdXtEzOuFQUvBWL6B1Haj/PzVIPwm2vLCH9hdpsBnHivVqUGW/h2j/+qZ71PFxiqIm4SGDpFhmoRxmUONFq2O+kom0DDI8cHNsBJzaLgVU/RuXcqQ2eF4OwWCq8wweGwFdJ7F72qwI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KKNuHuLB; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250814045344epoutp01d520daae6514b0199af371632c4602c6~biRoPbvwT1953419534epoutp01S
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250814045344epoutp01d520daae6514b0199af371632c4602c6~biRoPbvwT1953419534epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755147224;
	bh=76T/Q5T0tvZ2S/M2Jp2M4hZqaDAmgtYrsJIQ7ZUdqic=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KKNuHuLBn6T/LA4Irq4BB85culkdISTU7DyK0EJuP+fbKEoJinloTpqFXPevUzh5s
	 yf9dDSdn6NtJdY3pFCT7PRSaPHEKBZq2GVY4YcNz9RT6kPzxaltXIZrDMyt5xTGa+7
	 y3mmVQkn2zc2+6NVMIAjJHN5OGx2NxWgl8cQgmw4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250814045343epcas5p465537cbdf7d337f2d45a2cbc7fd99395~biRnSD6-30813708137epcas5p47;
	Thu, 14 Aug 2025 04:53:43 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c2XvB5rTHz6B9mC; Thu, 14 Aug
	2025 04:53:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250814045341epcas5p2183399af3a7f4f98247cbe8a09644197~biRlg5bSK1638616386epcas5p2w;
	Thu, 14 Aug 2025 04:53:41 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814045339epsmtip2457de483e72434b5ba5436798d6423b2~biRjOLqXa0057500575epsmtip2Y;
	Thu, 14 Aug 2025 04:53:39 +0000 (GMT)
Message-ID: <f9120ba5-e22b-498f-88b3-817893af22be@samsung.com>
Date: Thu, 14 Aug 2025 10:23:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: Remove WARN_ON for device endpoint
 command timeouts
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, m.grzeschik@pengutronix.de, balbi@ti.com,
	bigeasy@linutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, akash.m5@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, alim.akhtar@samsung.com,
	muhammed.ali@samsung.com, thiagu.r@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2025081348-depict-lapel-2e9e@gregkh>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814045341epcas5p2183399af3a7f4f98247cbe8a09644197
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250808125457epcas5p111426353bf9a15dacfa217a9abff6374
References: <CGME20250808125457epcas5p111426353bf9a15dacfa217a9abff6374@epcas5p1.samsung.com>
	<20250808125315.1607-1-selvarasu.g@samsung.com>
	<2025081348-depict-lapel-2e9e@gregkh>


On 8/13/2025 8:03 PM, Greg KH wrote:
> On Fri, Aug 08, 2025 at 06:23:05PM +0530, Selvarasu Ganesan wrote:
>> This commit addresses a rarely observed endpoint command timeout
>> which causes kernel panic due to warn when 'panic_on_warn' is enabled
>> and unnecessary call trace prints when 'panic_on_warn' is disabled.
>> It is seen during fast software-controlled connect/disconnect testcases.
>> The following is one such endpoint command timeout that we observed:
>>
>> 1. Connect
>>     =======
>> ->dwc3_thread_interrupt
>>   ->dwc3_ep0_interrupt
>>    ->configfs_composite_setup
>>     ->composite_setup
>>      ->usb_ep_queue
>>       ->dwc3_gadget_ep0_queue
>>        ->__dwc3_gadget_ep0_queue
>>         ->__dwc3_ep0_do_control_data
>>          ->dwc3_send_gadget_ep_cmd
>>
>> 2. Disconnect
>>     ==========
>> ->dwc3_thread_interrupt
>>   ->dwc3_gadget_disconnect_interrupt
>>    ->dwc3_ep0_reset_state
>>     ->dwc3_ep0_end_control_data
>>      ->dwc3_send_gadget_ep_cmd
>>
>> In the issue scenario, in Exynos platforms, we observed that control
>> transfers for the previous connect have not yet been completed and end
>> transfer command sent as a part of the disconnect sequence and
>> processing of USB_ENDPOINT_HALT feature request from the host timeout.
>> This maybe an expected scenario since the controller is processing EP
>> commands sent as a part of the previous connect. It maybe better to
>> remove WARN_ON in all places where device endpoint commands are sent to
>> avoid unnecessary kernel panic due to warn.
>>
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Akash M <akash.m5@samsung.com>
>> Signed-off-by: Akash M <akash.m5@samsung.com>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> ---
>>
>> Changes in v3:
>> - Added Co-developed-by tags to reflect the correct authorship.
>> - And Added Acked-by tag as well.
>> Link to v2: https://lore.kernel.org/all/20250807014639.1596-1-selvarasu.g@samsung.com/
>>
>> Changes in v2:
>> - Removed the 'Fixes' tag from the commit message, as this patch does
>>    not contain a fix.
>> - And Retained the 'stable' tag, as these changes are intended to be
>>    applied across all stable kernels.
>> - Additionally, replaced 'dev_warn*' with 'dev_err*'."
>> Link to v1: https://lore.kernel.org/all/20250807005638.thhsgjn73aaov2af@synopsys.com/
>> ---
>>   drivers/usb/dwc3/ep0.c    | 20 ++++++++++++++++----
>>   drivers/usb/dwc3/gadget.c | 10 ++++++++--
>>   2 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 666ac432f52d..b4229aa13f37 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>   	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
>>   			DWC3_TRBCTL_CONTROL_SETUP, false);
>>   	ret = dwc3_ep0_start_trans(dep);
>> -	WARN_ON(ret < 0);
>> +	if (ret < 0)
>> +		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
>> +
> If this fails, why aren't you returning the error and handling it
> properly?  Just throwing an error message feels like it's not going to
> do much overall.

Hi Greg,

Thanks for your review comments.

The trigger EP command is followed by an error message in case of 
failure, but no corrective action is required from the driver's 
perspective. In this context, returning an error code is not necessary, 
as the driver's operation can continue uninterrupted.

This approach is consistent with how WARN_ON is handled, as it also does 
not return a value. Furthermore, This approach aligns with how handled 
similar situations elsewhere in the code, where added error messages 
instead of using WARN_ON.

Thanks,
Selva

>
>>   	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
>>   		struct dwc3_ep *dwc3_ep;
>>   
>> @@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>>   		ret = dwc3_ep0_start_trans(dep);
>>   	}
>>   
>> -	WARN_ON(ret < 0);
>> +	if (ret < 0)
>> +		dev_err(dwc->dev,
>> +			"ep0 data phase start transfer failed: %d\n", ret);
> Same here, why not return the error and propagate it up the call stack?
>
>>   }
>>   
>>   static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
>> @@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
>>   
>>   static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
>>   {
>> -	WARN_ON(dwc3_ep0_start_control_status(dep));
>> +	int	ret;
>> +
>> +	ret = dwc3_ep0_start_control_status(dep);
>> +	if (ret)
>> +		dev_err(dwc->dev,
>> +			"ep0 status phase start transfer failed: %d\n", ret);
> Same here.  Don't "swallow" errors that you find, that's a sure way to
> paper over real problems.
>
> Same for all other changes here.
>
> thanks,
>
> greg k-h
>

