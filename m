Return-Path: <linux-kernel+bounces-893008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C374C46513
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ADB3B6CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4F3081CD;
	Mon, 10 Nov 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJaSqtLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4296309EF9;
	Mon, 10 Nov 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774733; cv=none; b=B25m6qX86xDtccCrRbmFD7qv1EIRkiz3jTJnNmWO9ijJ1UapZHb3xuHafxoOYUbVav/vMlQdhUh6UeQqHRM1QaY4jifdOTAlgMUYcjYLLbOYkJovIAwqlTjXyhNIJ9nzsGSmhgqyOzdpN0VLhODg0gXphEt4b9GgZqN+7zHeKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774733; c=relaxed/simple;
	bh=AgqRNHlM28QFo1a1gtxVwTp0nGA/pHQtS0abwMu9VOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHRu4JSUlicgqFKEJamTL/kuU9su4ljDZuM2gnq2C9y9N7hKpXd7HUvnRzXrNZ+p5yTkz+1cFwgxrBQIa1ZUFtwNl1ppEyfwjV+v4jT5P7mN68I5HTdCEUgVp0Ir/3K0YeZIfo1Kw+73W87jW79C0dGUsUVz/dXDm6QnCmJeDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJaSqtLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01475C116D0;
	Mon, 10 Nov 2025 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762774732;
	bh=AgqRNHlM28QFo1a1gtxVwTp0nGA/pHQtS0abwMu9VOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EJaSqtLgJoBnUagiGNQVs62D7nvbF1c6hPdzeseRRY0g4NowPmn0yP2ilFRqTGqUW
	 sPzkkTwJN5cjPQUratvqSN/q4oUc88lzC+xgup0xuMr47TNPr85oYO4t0K8e79SH5D
	 ruSwgoiq59BcaR0tj0vsS65NNiWAPw1gwHLyExzon9keUMMA8f+r7l7qifUYC2Gi+d
	 mF3mBDe4tSInlDj1+LN0ADjIht/yti36STMl1jUDDEq6SDnTJNUFZbx59UwbDrMoig
	 jdDJS0HlpPJS0ysSAD9mfFsm9LvUEmrRe1v7u9afR9zdxlTsvSINT1gbgQewAVAa26
	 Shp8A7TPwDztQ==
Message-ID: <6a57032b-3726-4074-9212-f0f16269f11c@kernel.org>
Date: Mon, 10 Nov 2025 12:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggMi8zXSBSZXNldDogY2l4?=
 =?UTF-8?Q?=3A_add_support_for_cix_sky1_resets?=
To: Gary Yang <gary.yang@cixtech.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
 <20251107033819.587712-3-gary.yang@cixtech.com>
 <69efdb9a-c03a-42f4-a78e-18c8a2b29322@kernel.org>
 <PUZPR06MB58875805D441AF3213189979EFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <38e8e068-d06b-41f0-9cae-5dfdf0fcce6f@kernel.org>
 <PUZPR06MB588726F24E6193ADD6CF224CEFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <PUZPR06MB588726F24E6193ADD6CF224CEFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/2025 12:32, Gary Yang wrote:
> Hi krzysztof:
> 
>> -----邮件原件-----
>> 发件人: Krzysztof Kozlowski <krzk@kernel.org>
>> 发送时间: 2025年11月10日 19:22
>> 收件人: Gary Yang <gary.yang@cixtech.com>; p.zabel@pengutronix.de;
>> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org
>> 抄送: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; cix-kernel-upstream
>> <cix-kernel-upstream@cixtech.com>
>> 主题: Re: 回复: [PATCH 2/3] Reset: cix: add support for cix sky1 resets
>>
>> EXTERNAL EMAIL
>>
>> On 10/11/2025 12:18, Gary Yang wrote:
>>>>
>>>>> +static struct platform_driver sky1_reset_driver = {
>>>>> +     .probe  = sky1_reset_probe,
>>>>> +     .driver = {
>>>>> +             .name           = KBUILD_MODNAME,
>>>>> +             .of_match_table = sky1_reset_dt_ids,
>>>>> +     },
>>>>> +};
>>>>> +static int __init reset_sky1_init(void) {
>>>>> +     return platform_driver_register(&sky1_reset_driver);
>>>>> +}
>>>>> +subsys_initcall(reset_sky1_init);
>>>>
>>>> This should be rather just module_platform_driver. Does not look like
>>>> part of subsystem, but looks like regular driver.
>>>>
>>>
>>> Some modules depend reset module. When boot system, these modules
>> can't probe before register reset.
>>
>> Which modules? You statement is so imprecise that my only answer is:
>> sorry, deferred probe is old thing now and everyone should use it.
>>
>>> To make these modules probe earlier, we use subsys_initcall() to
>>> instead of module_platform_driver(). Do you have better suggestions?
>>
>> Look how deferred probe works.
>>
> 
> Yes, you're right. But deferred probe needs to take more time on booting.
> To make the boot faster, better experiences, we have to use subsys_initcall()

Again, imprecise statement. How faster? With such arguments - twice
(first list of unspecified modules and now of unspecified boot faster)
the answer is the same. And I will not wait for third imprecise
argument, because this is not a ping pong game.

Anyway, manual core ordering is not the solution.

Best regards,
Krzysztof

