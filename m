Return-Path: <linux-kernel+bounces-819517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF58DB5A1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A1E4817FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1B2E1F10;
	Tue, 16 Sep 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="ckISlrv+"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BE284B29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053348; cv=none; b=Bg7dvdOs1NTB3RHy5zh2jLmB5JVtH8jly4QsVolqWG8aNwlavzFPslTzrwGpFt8fFLoVSIPkU3NqIUxN8HDuVrowAIdX138/Daiyvl4qMFfdXZ3/3EdhJLms01DNbQweQedkvp6wz9DxLHWbuJbNu+yCSE6OhO2IdTKwQOyLkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053348; c=relaxed/simple;
	bh=CV94P1G6PAbXUYBZXtbDVt4H7gF8ZfJUS0/eyqgvHFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc5M6DJ/zTK13RZIwG/Y8F2oT0T9L7jNQqD9/75eBVZl/bk+NXZUIeMXOBkuqV3zYw//ORZKxCPfvxrBfTzoKqurrKFte86USt1OCZCOaHTEPIm8LBZHrhktpzC9G68jxpmAsB11ove+n9eWKMRe5bstm/XovpqcXaLVxRgdTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=ckISlrv+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <fad5cb33-0e7c-499b-bad7-bbdacca8076a@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1758053331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHtwMr5+ZMiaqfj6m6kVuvNj2Y2evNdPg6uV1F0bJNA=;
	b=ckISlrv+FoQ3Emync9HM87QOztyL5MLDKkY9+yDg5rpd1E6Ww3PwuRJm35Ehia4bkKowAd
	RN0gXd09gfVm7wC+5FpJgFB+HgT28UfsW3g75d1QknnRK8+uns/q/PGJYyHQLmfKPq1vkq
	87mSGmNshUirOiW4awpGJ+a/q5DVsBBqyiJMROJo1ksT0v8QHUPId4nzqd/V3UyLZh5u3p
	5+E0wGCmSFFhfDIEltrosZZz+EQqVhAnDxVBLTWHpJu1hochZ4wlZDQ2MF1Y8KBnx2CGQf
	TMZ5S6k0dNsy0MBDpEu2GcEMwxuV2wQpqtRzNNENGSA3HAy4PPma1btuMNbVVg==
Date: Tue, 16 Sep 2025 17:08:44 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] media: i2c: dw9719: Fix power on/off sequence
To: =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250817-dw9719-v1-0-426f46c69a5a@apitzsch.eu>
 <20250817-dw9719-v1-7-426f46c69a5a@apitzsch.eu>
 <aKLZ39IzI_azrDIu@kekkonen.localdomain>
 <550f28a9aa82a28beb35fd3490dbe08928ba9eed.camel@apitzsch.eu>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <550f28a9aa82a28beb35fd3490dbe08928ba9eed.camel@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/15/25 5:48 PM, André Apitzsch wrote:
> Hi Sakari,
>
> @Val, please see below.
>
> Am Montag, dem 18.08.2025 um 07:44 +0000 schrieb Sakari Ailus:
>> Hi André,
>>
>> On Sun, Aug 17, 2025 at 07:09:26PM +0200, André Apitzsch via B4 Relay
>> wrote:
>>>   	u64 val;
>>>   	int ret;
>>>   	int err;
>>> @@ -109,13 +116,15 @@ static int dw9719_power_up(struct
>>> dw9719_device *dw9719, bool detect)
>>>   	if (ret)
>>>   		return ret;
>>>   
>>> -	/* Jiggle SCL pin to wake up device */
>>> -	reg_pwr = (dw9719->model == DW9718S) ? DW9718S_PD :
>>> DW9719_CONTROL;
>>> -	cci_write(dw9719->regmap, reg_pwr, DW9719_SHUTDOWN, &ret);
>>> -	fsleep(100);
>>> +	/*
>>> +	 * Need 100us to transition from SHUTDOWN to STANDBY.
>>> +	 * Jiggle the SCL pin to wake up the device (even when the
>>> regulator
>>> +	 * is shared) and wait double the time to be sure, then
>>> retry the write.
>> Why double? Isn't the datasheet correct when it comes to the power-on
>> sequence?
>>
> I haven't noticed any problems during power-up of DW9761. However,
> according to the commit message, there seems be an issue with DW9718S.
> But I don't own the device and cannot test it.
>
> Maybe Val can provided some additional information.

I haven't had access to the datasheet for the DW9718S, so this was all 
deduced experimentally. By "to be sure" I meant that I literally raised 
the timeout "just in case", not based on actual issues.

The actually important change was expecting the failure on the write and 
not erroring out.

Thanks,
~val


