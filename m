Return-Path: <linux-kernel+bounces-825658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7AB8C712
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564A04E0F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA12FC009;
	Sat, 20 Sep 2025 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaVGOGOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CE18BBB9;
	Sat, 20 Sep 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368900; cv=none; b=WsXCgvTfGn5vTPknBA/FX8ZQLajbIBwRR+blviU0/ppWcCSyE/a/57pFfObbSbqqG2eZ7wEYIuJ6XtsU6RCoSLSjFMwzu3hvjmqWpFkZv/3+VXeZ9RbISOt/PDPJ7aNBP0cR55huUXj6WZVjS48WulQqNI+WVYFCKRXx6WqEKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368900; c=relaxed/simple;
	bh=S4lEmGoMz/EYlXIdqoTKwelfO4ALXROy7V1e0MeAQH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9UyqQ7MCoxZ4xaIPVHnmjZQBoIwKWaiiTXyig+TfnwPsWhjyUF/XS6jj/8iNJoNTsReAoRH+rr9xdo3Xc+rY5i/1mG309ILeOZ4npWpNbb6JNDHuKh77VHa6euJnIhiTIhkpMdAP71Isf40vY7RKrp1PHBFzEDHUZU/L34eaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaVGOGOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E848FC4CEEB;
	Sat, 20 Sep 2025 11:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758368899;
	bh=S4lEmGoMz/EYlXIdqoTKwelfO4ALXROy7V1e0MeAQH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iaVGOGORuQwMrNSIa4PH+D4hqQ1EzqYfhpFDlKS6GxoHvE2G07cydmcNxbH7JiSaF
	 VB//OvZ/NIyqtXTiQdgNIaJR1yOOt0GN5wvED71XbHWGfJQ8MXAbSmRKzOP0oGzxUo
	 eI0dRZofOuo2tWVbhmOha+R9iPLZBhlAq6PxjOe1O36YWhAikhcfQDESIsNAQ7q3jU
	 7Gd+ryQWi2LOvjIBn6+lHG+z8ITQPLWMenRTdeRpW6AWLUHFqDx4XBMKA2WVWqmMZP
	 P+Fxg09E+3mx9SdSTdOU9opMn20sKOks4qBu7Z2VV23wsoQOCrm3HqCHZtnhcHSmN+
	 St34XJ6vkjrEw==
Message-ID: <5bae4ebe-dd42-4e84-9ee6-c9f6a88f7db5@kernel.org>
Date: Sat, 20 Sep 2025 13:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] usb: dwc3: glue: Allow more fine grained control
 over mode switches
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-3-52c348623ef6@kernel.org>
 <20250919214013.gtbaknjrgd375hm6@synopsys.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250919214013.gtbaknjrgd375hm6@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 19.09.25 23:40, Thinh Nguyen wrote:
> On Sat, Sep 06, 2025, Sven Peter wrote:
>> We need fine grained control over mode switched on the DWC3 controller
>> present on Apple Silicon. Export core, host and gadget init and exit,
>> ptrcap and susphy control functions. Also introduce an additional
>> parameter to probe_data that allows to skip the final initialization
>> step that would bring up host or gadget mode.
>>
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   drivers/usb/dwc3/core.c   | 16 +++++++++++-----
>>   drivers/usb/dwc3/gadget.c |  2 ++
>>   drivers/usb/dwc3/glue.h   | 14 ++++++++++++++
>>   drivers/usb/dwc3/host.c   |  2 ++
>>   4 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 8002c23a5a02acb8f3e87b2662a53998a4cf4f5c..18056fac44c8732278a650ac2be8b493892c92dd 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -132,6 +132,7 @@ void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
>>   		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
>>   	}
>>   }
>> +EXPORT_SYMBOL_GPL(dwc3_enable_susphy);
>>   
>>   void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
>>   {
>> @@ -157,6 +158,7 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
>>   
>>   	dwc->current_dr_role = mode;
>>   }
>> +EXPORT_SYMBOL_GPL(dwc3_set_prtcap);
> 
> I'm hesitant to export this as is. This function may change the susphy
> bits and expect them to be restored later. It's not meant to be a
> standalone use. At least, we should document how it should be used along
> with the other newly added interfaces.


Sure, I can otherwise also open-code the susphy change inside 
dwc3_apple_phy_set_mode anyway if you prefer to keep this private to the 
dwc3 core. I should restore it there to the original value anyway I 
guess after phy_set_mode.



>>   
>>   static void __dwc3_set_mode(struct work_struct *work)

[...]

>>   int dwc3_gadget_suspend(struct dwc3 *dwc)
>>   {
>> diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
>> index 2efd00e763be4fc51911f32d43054059e61fb43a..633268c76fe4c7fdc312c9705dfa7cf7ccf3544c 100644
>> --- a/drivers/usb/dwc3/glue.h
>> +++ b/drivers/usb/dwc3/glue.h
>> @@ -15,16 +15,30 @@
>>    * @res: resource for the DWC3 core mmio region
>>    * @ignore_clocks_and_resets: clocks and resets defined for the device should
>>    *		be ignored by the DWC3 core, as they are managed by the glue
>> + * @skip_core_init_mode: skip the finial initialization of the target mode, as
> 
> finial -> final?

Whoops, yes, I thought I ran a spell checker over this because I usually 
add a lot of typos but must've forgotten :-)


> 
>> + *		it must be managed by the glue
>>    */

[...]

>>   
>> +int dwc3_core_init(struct dwc3 *dwc);
>> +void dwc3_core_exit(struct dwc3 *dwc);
>> +
>> +int dwc3_host_init(struct dwc3 *dwc);
>> +void dwc3_host_exit(struct dwc3 *dwc);
>> +int dwc3_gadget_init(struct dwc3 *dwc);
>> +void dwc3_gadget_exit(struct dwc3 *dwc);
>> +
>> +void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
>> +void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
>> +
> 
> We should document these interfaces. The dwc3_core_probe() does all of
> the above in the proper order. It's not obvious why these are needed and
> how they should be used.

Very good point, I'll add documentation for all of these!


Thanks for the review,


Sven



