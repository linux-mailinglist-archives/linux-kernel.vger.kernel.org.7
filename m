Return-Path: <linux-kernel+bounces-720050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB026AFB644
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23720189A4B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE42D97AF;
	Mon,  7 Jul 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm7GOlYa"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F32D8DA0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899341; cv=none; b=ViGxoVN9/LrQg5dRxN/I8m7LvMAo3ok7yl9TO4rvx0DHRubYNdsgfKweLELqOwRXH4w2cRD2loI3pR2dMZtuEjv2u0KLFQUtD0aifIbvBxpL+y/AFKYl3Q3ziqFM+xqXKEoxmwOibGyp5E4QgsiQCC+hblV3y3cGYw3EZgMybro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899341; c=relaxed/simple;
	bh=WdArDEtLe89Q6g7L4LligwAlwWkbQ5MDMZfw7t5oEXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahiTJvxHINocLsj3djxOrhUobeiJCBl+Rx9kmg0oPjuP8JmGR7VkmB5J7iykYais1bmPh2f8T1g+D4cQvDwgXHBrT2Tbi+pFgxCpWHJmHnaTNxk8SQ4pUJGrNwYtvXDCxYsR5CF5vWOl8s12QxmL7I8zqokIVvSPOcW7w4w6pFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gm7GOlYa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2417541f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751899336; x=1752504136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG8mV4pDhYymeozzS82ZZcM9xZV+pEOeW3uE1qROtU0=;
        b=gm7GOlYapgAzIhHWkI9PQZFa/3JYUN7jYeN7v9dgRIDXhT9JPSIZQKhYHHOYEJ/I9F
         xVMxX5vhx1Zixu95kLwJcnYkUvtM9vKTBTa24j73pR0VdQxVSy0pg2+Jhi+gKBMQD3Sg
         iyT7duN/l0rL1wKkdeD+u8vc0d+YpA7kUeNfAzHCIGKhzG1deGPKYANhbRdWsWZYhJjq
         zN/c4ZJGaDvjQGKDxJuHe4Kg89KydPzCUYTZiDARUGVPYFmVRYqV7Yu3CbRNBpmS227l
         akRAwE6vdKJX1sfIhmHb9Ts+o3GKGpJIwhwCyll3554vDzJEp9OO2b+891+7mklueidY
         Ua0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751899336; x=1752504136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PG8mV4pDhYymeozzS82ZZcM9xZV+pEOeW3uE1qROtU0=;
        b=LsCiCaBwjzmRjcV4UqaVH7b/hI5eZCcNaWnTTaNc07JjoGwnGhHOPX5JKNZmBMi5O2
         7WmipSilIgbQqhjpo61hkGgDXKR5965cZ+qP087yd0sNIcDelyLb9KsqpvQZfttdrXJf
         yMFUDKbeGdJLVHPTzgA0CtzUluQxybywpv41u4aKwTBRRzXyOXMou6Pem+By7gHtwvrP
         lXeVDcBcX/67icFjWNchl3Ao/JWVr31E28jT0nK/ZQLF/jNg/rucmuk5rPSWSmWiyzBZ
         67qIpEq6WQ202zoHPPoe7iKzS99xA/ZZ9HnY6ZIzere++bpLm+hPmCJ+SMlExJKwyxqr
         cnYg==
X-Forwarded-Encrypted: i=1; AJvYcCUbaGoDFe3ajsJvVHbTXbamcXxIH+Z35GKsY7lcxyj1+67PfKLtQMbcPLVfPp4L2q51OyzsAGASjM2VuZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtez4gQd7RNaffaETTqfyQncRE+SxyZEdwSF92/a5bE1QJWBJl
	6SyPp9Sq1JkNbjWppJjUuZQYDKYw+bjyllleBiWOVxez4Vas1wCcTUem9NdLyqXEt2t8Mb0h/4c
	V7T6A
X-Gm-Gg: ASbGncsgF6np/WYMLokwUXLD00QL+ZpTRh4ldKntUL2BqgdLRNEB4WCvAQpkhEC+FTF
	u+Po+yq1APJJq5nzbu842A2Bk9cReTj2brjHp2OEQ5PZzHnhekEkb4tzBqARqqBUxU38G0wcYYF
	w2SlMLc230/iEBV6mAj8uIRnHx1yDCfH0i0ciFv2PqMqo9sMySHGZxmptiEed1fz5b5jUCAFM6p
	y51GUFn8SzsBJztXOsGK6Ny9SwezhWvfnTh+DVtJM/Sxv9Uk5GXgAlunGaeIWBjC4u1ZNNBDqSV
	rDc9IfoZuMmTzVdzGVNJn7Dp6XSqCZVq1OBe3uTke+fDnoyqoBWrJqLJDSK/j/H6BEYvTzyfvTY
	C5CW8DKGtZU1TzenvQJozgoliDWQGyl8=
X-Google-Smtp-Source: AGHT+IGyYoZy50qjmAjoyeY/+RRpyL9VdrWvFAUJlbX9qLSoaWQqvRrm9Uhn/ZI8f2iL8dQXzws9/w==
X-Received: by 2002:a5d:6f0a:0:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b49703dd84mr10413739f8f.55.1751899335190;
        Mon, 07 Jul 2025 07:42:15 -0700 (PDT)
Received: from [192.168.1.159] (p4fc3d4fa.dip0.t-ipconnect.de. [79.195.212.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b968ebsm10252375f8f.47.2025.07.07.07.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 07:42:14 -0700 (PDT)
Message-ID: <fe454257-aa21-4304-868f-aefbea9963c4@linaro.org>
Date: Mon, 7 Jul 2025 16:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Milos power domains
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
 <06760125-4800-4068-8936-dddf27c28d17@linaro.org>
 <DB5VDDKCAQQG.LDCMHXAZN17S@fairphone.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <DB5VDDKCAQQG.LDCMHXAZN17S@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/7/25 15:49, Luca Weiss wrote:
> Hi Casey,
> 
> On Mon Jul 7, 2025 at 3:23 PM CEST, Casey Connolly wrote:
>>
>>
>> On 7/7/25 12:18, Luca Weiss wrote:
>>> Add the power domains exposed by RPMH in the Qualcomm Milos platform.
>>
>> \o/ codenames!
>>
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>    drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
>>> index 078323b85b5648e33dd89e08cf31bdc5ab76d553..e09552a469264f28952fc46c3ab8c125e87310da 100644
>>> --- a/drivers/pmdomain/qcom/rpmhpd.c
>>> +++ b/drivers/pmdomain/qcom/rpmhpd.c
>>> @@ -217,6 +217,24 @@ static struct rpmhpd gmxc = {
>>>    	.res_name = "gmxc.lvl",
>>>    };
>>>    
>>> +/* Milos RPMH powerdomains */
>>
>> I can't find any public docs telling us which SoC is Milos (the only
>> relevant result is Bjorn's email asking you to use that name instead of
>> SM7635). So for the sake of future generations could you reference both
>> names in a comment somewhere? Or even the commit message would be enough
>> tbh.
> 
> I don't know the full list of model numbers for Milos. I assume it's
> SM7635, SM6650, SM6650P, QCM6690 and QCS6690 based on the info I could
> fine, but such info is hard to get. So this is not a definite list that
> all those are actually Milos, or that this is the full list of Milos
> chipsets.

oof, I see... that complicates things. It sure would be good if this 
list was documented in the kernel though imo.

> 
>> Off-topic here, but maybe it would be a good idea to add some Qualcomm
>> platform docs to the kernel with a table of all the publicly known names
>> for each SoC? This would also be really helpful even ignoring codenames
>> just to know that SM8550 is Snapdragon 8 Gen 2 for example.
> 
> So far my source for this has been the postmarketOS wiki, and this
> Google Doc, but the latter hasn't been updated for new chips since a
> year or so, and is also probably not very complete:
> https://docs.google.com/spreadsheets/d/1WrKHLj_oSoiykhSc6xqXAkT3nlD2hq-fzUPSGiq3Kbc/edit?gid=1270863184#gid=1270863184
> 
> And I've got some notes locally for a couple that I regularly need.
> 
> But I'd love a more central place that isn't specific to postmarketOS
> for example. Not sure where though?

kernel docs seem sensible to me? Maybe a wiki on gh/linux-msm?

> 
> Regards
> Luca
> 
>>
>> Kind regards,
>> Casey (she/they)
>>
>>> +static struct rpmhpd *milos_rpmhpds[] = {
>>> +	[RPMHPD_CX] = &cx,
>>> +	[RPMHPD_CX_AO] = &cx_ao,
>>> +	[RPMHPD_EBI] = &ebi,
>>> +	[RPMHPD_GFX] = &gfx,
>>> +	[RPMHPD_LCX] = &lcx,
>>> +	[RPMHPD_LMX] = &lmx,
>>> +	[RPMHPD_MSS] = &mss,
>>> +	[RPMHPD_MX] = &mx,
>>> +	[RPMHPD_MX_AO] = &mx_ao,
>>> +};
>>> +
>>> +static const struct rpmhpd_desc milos_desc = {
>>> +	.rpmhpds = milos_rpmhpds,
>>> +	.num_pds = ARRAY_SIZE(milos_rpmhpds),
>>> +};
>>> +
>>>    /* SA8540P RPMH powerdomains */
>>>    static struct rpmhpd *sa8540p_rpmhpds[] = {
>>>    	[SC8280XP_CX] = &cx,
>>> @@ -723,6 +741,7 @@ static const struct rpmhpd_desc qcs615_desc = {
>>>    };
>>>    
>>>    static const struct of_device_id rpmhpd_match_table[] = {
>>> +	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
>>>    	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
>>>    	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
>>>    	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
>>>
> 


