Return-Path: <linux-kernel+bounces-804785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004CBB47CF2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA21177D48
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310929B77E;
	Sun,  7 Sep 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAwo5v06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54F1DA23;
	Sun,  7 Sep 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757271576; cv=none; b=VDVKdMXM0Ohh1QSDw84Aa7yi5bAKsNKhJRU2McVuyDuGFA0ZYC2iCZ4b19ikgxGPK5zvn9OX03rrA1uMAxJ7S767QiBVaQtWEgUNMU5zPoDo9o7+Ajwm1g5q/riJFMC+Nxtoh2863iYaiTlxltKopP5TPhezvN0PqZ4NFaXI4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757271576; c=relaxed/simple;
	bh=oSyvOvb8j8bP0Da0GGBZQb4BblALsQU6B8rsXjZ9ZOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+zeTp0enF04AfCN5iLiDsORkycHkEt2ZqcJlPCw46oS/XKB0Eojzdq5r5Nr1GvI0aq7LLj5bWzO4dFGvhdHBSVDDveqoRnG89Yyn4378bQDfZEw54NQGjr+AL0qDnW5jIHW0DORcLl6arA/EgEfnGa7F6bSBqUivxNaGWSbEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAwo5v06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF0EC4CEF0;
	Sun,  7 Sep 2025 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757271576;
	bh=oSyvOvb8j8bP0Da0GGBZQb4BblALsQU6B8rsXjZ9ZOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fAwo5v06UzD/wkFaAA+sllvIyMHV8S3qNHNwdSeVpWHGfy2RpVm+6Kd9l6b6Q/dRS
	 SF8X3894mISPfqI2DBYAIMmAevspWYGQb4CtZQ02x9zEYFfhulS/iyC/x3SejmHAfb
	 v7SqEBug+4sD4BtzUZKV6uGEnb+CLZlqmT4LQfUKIg1KYv67YzUwasm51fE4fFTMJO
	 xI7UKG3ZKvrpX3qTVcwbat6AtWWAmXO0iw4IQY35ZPI+zmIbcdOPHVwEoNPKd5eK+8
	 iI0SUyyF8DiQs94voJ0N4XQi1wvtw1CAtv80NHi2d1UWkE/FVBtWYfUIwEJMmUjZVQ
	 zFrEZh+o0uJUA==
Message-ID: <e0659b64-eb6b-4990-b3c8-71195f143c85@kernel.org>
Date: Sun, 7 Sep 2025 20:59:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] usb: typec: tipd: Update partner identity when
 power status was updated
To: Sergey Shtylyov <sergei.shtylyov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 Hector Martin <marcan@marcan.st>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-12-52c348623ef6@kernel.org>
 <f09dedfc-1f1b-4416-b854-9c4059ba264a@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <f09dedfc-1f1b-4416-b854-9c4059ba264a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.09.25 10:54, Sergey Shtylyov wrote:
> On 9/6/25 6:43 PM, Sven Peter wrote:
> 
>> From: Hector Martin <marcan@marcan.st>
>>
>> Whenever the power status is changed make sure to also update the
>> partner identity to be able to detect changes once de-bouncing and mode
>> changes are added for CD321x.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   drivers/usb/typec/tipd/core.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index c7cf936e5a61a331271c05b68ff1b77b89c0f643..cd427eecd8a594b7e609a20de27a9722055307d8 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -635,9 +635,16 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>>   	if (!tps6598x_read_status(tps, &status))
>>   		goto err_unlock;
>>   
>> -	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
>> +	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE) {
>>   		if (!tps6598x_read_power_status(tps))
>>   			goto err_unlock;
>> +		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) {
>> +			if (tps6598x_read_partner_identity(tps)) {
>> +				dev_err(tps->dev, "failed to partner identity\n");
> 
>      Perhaps "failed to read partner identity\n"?

Yup, good catch!


Thanks,

Sven


