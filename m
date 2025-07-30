Return-Path: <linux-kernel+bounces-750069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B92B156F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6252B189FC98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A118A93C;
	Wed, 30 Jul 2025 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="JJZ9mQju"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA47E1;
	Wed, 30 Jul 2025 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753838861; cv=none; b=Rf1UwAHhgV+2AfILkRE0jbglooteHvRWbbVAz7ZLwkz7cJlsUqZZ2bFDQsnvHbOXg6Z6wEhuRwioQLLZOP1ys6UYOXlN7n9qXk7YlA64oyC5XRWEOjRohhs1qZhhlhjnFTn646rnEwxhgqMCLqpLjGOavmL1CbMyuFEhYpKf6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753838861; c=relaxed/simple;
	bh=oMSNePl463wWBe7vKrsRnNMbO5Qy7XR+zFfOJNgFVOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HonhQ9swc1FdhTBKfmNRXZuDwIOrzrGtTEMljGaED8wcwxA5eqgeztYx9G+yo4JtLGVFwJ2Eo5jMSJk9aUe6bMCj16VLDmTCkKSbpwTqiCYlzO15I9yYE1Z9pHgTxgUWSMnQEVrldJt22/unzD8zIjr12NF1V7p7k0hmV1sHNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=JJZ9mQju; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753838820;
	bh=sh9+1hvv6UwRMngtc5TSXRZC1oxTpQsSSmadqfMNyiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JJZ9mQjup/lxrSc8T1VpHw/ZfLYtGaOnNBqS9XD49mJfosP5dpPZWrP2eEtNuER0b
	 8ZPh/gq4/6z3P5/Ev4J8Sheyuf/t7X9cgf4ta0LNcAX+gK2xFtaNfY+usgTQrpvyi7
	 +3sTDgiCsRcG4+g/j4KSxFOP806JeiKGa6VbL4x4=
X-QQ-mid: esmtpsz20t1753838814t9a57cd4b
X-QQ-Originating-IP: TJCihVAB9aallGYP7dENX5Iebrj2pvT0M2uwEcEmSfA=
Received: from [172.16.12.153] ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Jul 2025 09:26:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17714488166574995387
Message-ID: <C0B5444C2EE8051C+3877b039-f814-4f79-a9b0-44096226ce73@airkyi.com>
Date: Wed, 30 Jul 2025 09:26:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: rockchip: Add missing dp_out port for
 RK3399 CDN-DP
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250729090032.97-1-kernel@airkyi.com>
 <20250729090032.97-5-kernel@airkyi.com> <DBOSZZ7TMD2P.U0MGKUR3DXN@cknow.org>
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <DBOSZZ7TMD2P.U0MGKUR3DXN@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OccmtviHNKX2xg7lzWX0xEsyTW+gF7BuOaoG5XHn0oU0oB0X1Gu06WfY
	GbN/ve5bRGll6UYd5oHgpMo/A09clZFg2WIMCSd/0/WiGwRoD8QiQk6334lm8EZLgjD+9JJ
	L4m+qksnRFbOneVpO8ATmDRa9+6ggTL13V9DUPv5weOa5UToGKt/JS7F/Da1EeP/dN4gjwa
	8o/Ya4LAumVQKAinBEA1yvsh0l+723S6aWhqtfVnh+rzAGjI1hNws8ScckG9oZSvW6h23+n
	5MxuD7WD6luNEm2kpGk1c241YG7cpl87UkoTadtAgATtob5wPm/69hNNQ5rTaZPP6qWOJ59
	0XZ1rWws8bMYc3er2Ov7au08hv8o5r7t4E9JWxOJIEez+DcQYrygH6VCYHHyucg6m3/WgMJ
	JFWrzNo+SG+X0f5Za0AMZy8TfuRNXUGUe6PlSZKtlqxlr8cZoa2/eHz4ICcZiclbe0em1i7
	ikbZtZk+etVt2ZVFdTqDy1eHhLBAmaLQ9B6XsQVddCy6MTHohs6vWAZlRr04OV10YWIgdos
	PMv30td4yAxtsH3u9aGvv6j4yTmbqZN6nJ0kYFQKBF1nFo1l4+rDZkCTR0czAUBiADDs6a1
	H5A+EXYve+3L9C2WNpvqCL7ZWVpZ7zRgQD7j5333lnuLvcfTgAJ3HpAS1la/pjqKwsekdt4
	ZoYknPWHEJWefaUXFq1MxiWZ9y5dajTO0EhtfTxLC4GcsB4gxbZlTPf0xk+s4VCxrmDCunm
	Cf7jUN6fS9UIOQHwvYsfwcIo2q21wIktcjq+FLsxokyz0OwRfRuP4vYzZknj9zpxXn9nyef
	pPXYu8zvYQ7QtHYajwVZ4W13ThkqjkzIqc4XQ5MOqPBlHSaxGlHm3JKZeII9bST0fxuz3Iy
	8c/R2pml255wL7CpGujlYXbE/SPoKcWCTUo4Sk043FKLoUbvoAjSAQLaJiL5y48y1QdD19a
	aM3fzIK3HSzx57UV37Jwao2SVNQ+Oy048f45z8HgHf99Tcg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On 7/30/2025 3:59 AM, Diederik de Haas wrote:

> On Tue Jul 29, 2025 at 11:00 AM CEST, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Let's make the ports nodes of cdn_dp in the same style as the other
>> display interface, and match the style of ports's yaml.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
>> index 9d5f5b083e3c..edeb177bc433 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
>> @@ -618,7 +618,11 @@ cdn_dp: dp@fec00000 {
>>   		status = "disabled";
>>   
>>   		ports {
>> -			dp_in: port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			dp_in: port@0 {
>> +				reg = <0>;
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>>   
>> @@ -632,6 +636,12 @@ dp_in_vopl: endpoint@1 {
>>   					remote-endpoint = <&vopl_out_dp>;
>>   				};
>>   			};
>> +
>> +			dp_out: port@1 {
>> +				reg = <1>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +			};
> Patch 5 adds a single endpoint to dp_out (without a reg property), so it
> seems that #address/#size-cells is not needed?
> If you run ``make CHECK_DTBS=y W=1 rockchip/rk3399-evb-ind.dtb`` it
> should spit out a warning about that.
Exactly! Will remove this in v4.
>
> Cheers,
>    Diederik
>
>>   		};
>>   	};
>>   

