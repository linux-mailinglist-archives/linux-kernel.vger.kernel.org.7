Return-Path: <linux-kernel+bounces-810231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A44B51787
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EC8545F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA91A9F92;
	Wed, 10 Sep 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgC4HxJd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73321684A4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509266; cv=none; b=syuTJNj881W5XIiNVn8j9A/1tPQ67z+tMR/dD6SVBZfUojPCJWxblkEtQXLvkQpciJrMy2cCTe/1tv0Xwf3B3drea7fhAfLCfZsJC9StVVxfiK9syDH51UK6xVzbyDF5xyVyoxhrkNWVrETCMvtYus64ugqTyoYTzgVMATrHe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509266; c=relaxed/simple;
	bh=2T/8Ztsxi4AWL1kpHNyrAMiLhaqvXC5D9zLHqmODIVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxKslfcZHxk1tB17vdZ8UevH15E1GPok+Zkwtz1VsgIU7as2FiCo4J6O8XDN/arok6JyKl+YRZ4fpEgSCwlcuS7SowkORulq/Vm37kJWGANrLcIXfDvvXeQaqVAvgOIWDWD3/na9W1UFQNCkYLaGI5NGeo0fYUuy/Wvu8tK7NNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgC4HxJd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgXWc022262
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJorFgWZxPg65RyVPLB0lRHsqzbMwIYmxp3OdkMcOE4=; b=LgC4HxJdACiZFbyG
	MBQAE+rnW0NKD3ZlQlnjLhAtpjtWzKyCQKgB16OaR3RarZ+ncbEHTVFvnRLLVKJJ
	R8AbzTAt/vAdmrElde1j/5a//MibhbGMe4jArQtKJhuAUAJ7M+IkQjqTdPGIfyCP
	Gi80tlSOMTtiKgUhmtcu7SyU19FMZQA8Xa9rMkhiX6l0kTkDXU1fv+iWI5O5IPVP
	99L1KLgmulpc6UszGIetpXr2N7UA7bwC5UIyf8Ibdaq1ULK54GB6YGKiyppeGQOr
	MOxCDBaxkf6vUBtQObYlZVhDPWQIffz6RDZJ8KJaDvKiSRwysIqiYIjhHaKkTcSW
	lnWaDQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t380b2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:01:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dca587837so9999386d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509261; x=1758114061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJorFgWZxPg65RyVPLB0lRHsqzbMwIYmxp3OdkMcOE4=;
        b=rj7IB4V6G6G11uBEk7ImcIdJbC3pEdN0YfRwI88pv6/x9AjIK3JZ60fTYeSUDPlhWn
         IoUCZaEGfkQeDqQzv1m6lg1lgkvd6v6dFXaaFLude+MOTSmH7mwJc9ZFkh0cPkygwRBK
         YrOtKdhQxtdhzCWz1y0YAgyLrcKMJc0XhV5aopdeJeH20CrV18vATQQSONXG0zkhg8c3
         qkAK6jYphKtQs3h7XrBdQubBgE3y05l79QS9J7P4LvIVj/ZuP9wGkeEQpwR4vthtPJJZ
         tuYrz2+Tg98ieNn+THHvx02Rh3W0uGkiLUa9lLhqfgBXpUc1UOfGT3SOtjR+/OD9FnUq
         s1pw==
X-Forwarded-Encrypted: i=1; AJvYcCXRC0qpBUlvGRqAE7rFkmS80tZuy9CH4GvWdG+tDuyqlOTwg3EuoaIMiHZSRTMfJ3UAtpdhwyvgrUBrgEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+MraeyvkW4ZDHFj8G1pvF64nh/K3EfjWWw9Jua1XTjRH1Efn
	kXQDdmOXLBIA77ZRTZixQFtEF8I+3SoTiG+KQXdrqydftRTpXfhiZcskop7r7urWXMab/5t98Y6
	bNJpsVaMeoQz225HZHJZ9Q1M7l3kVYjCczPyHOfhL3OqhbFTuUe8fOMYUObJ3J7jKxQQ=
X-Gm-Gg: ASbGnctb6R+amvNxh4cfrm6icmrblXH/c4ruAOwt+lVPuI4cU9wydL9Te4zqd+lWFem
	ID6iQrDEaWrC/pcAh03NVovQ4jFwqIHk7XwW7pZwVqa/tQa3u8kGWmGv/iOqPDOmdPjBskrV5qq
	yifnjXTPsusW93DLjx08UCJfNlGkHvGthBNhXitWqRK5pn+FUUwxqmXavvOrTsCJNdlJLz3VHCD
	gfws3dt13Hv5XzLht9IGXCZ6VK9ab1HlS9xMyIRjIb7oJNEbOc2aTBrU6KwSSc0a5Xv8+sXogka
	PM/4FEeuD5oFGbookvIRR5vQV23UhHbeaDt8OwdTWazq2PKyj6+oxP+QVveRD6IPiKuU4lbmSAI
	vL6AGg2c78tGgEbObpB5cuA==
X-Received: by 2002:a05:6214:411a:b0:75a:9c0b:6b7d with SMTP id 6a1803df08f44-75a9c0b6dc2mr32858246d6.2.1757509259865;
        Wed, 10 Sep 2025 06:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGyPmSFM50615M6RHwW4JfpvtlFW1/WulsS/UQRD9mfp3W+5WGHHqGDBmhseR7J3icQ11+sA==
X-Received: by 2002:a05:6214:411a:b0:75a:9c0b:6b7d with SMTP id 6a1803df08f44-75a9c0b6dc2mr32856966d6.2.1757509258861;
        Wed, 10 Sep 2025 06:00:58 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f6a7esm3289951a12.42.2025.09.10.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:00:58 -0700 (PDT)
Message-ID: <634ae260-3a7b-475d-b40f-47401a70a53b@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 15:00:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] leds: led-class: Add devicetree support to
 led_get()
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus
 <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Thompson
 <danielt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, threeway@gmail.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20250910-leds-v5-0-bb90a0f897d5@vinarskis.com>
 <20250910-leds-v5-3-bb90a0f897d5@vinarskis.com>
 <b9017909-1643-4cef-bfff-5b672dd73960@oss.qualcomm.com>
 <jsLJqyPfjA2iFNHMvAxgz-zO1WecVgleSahWgW_B5BshbYat4X1UqUuKpexfxlRxnD3oWlAnHqeLGpne8JebFV-ICVxvr5g-5nI8P2Q6dY8=@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <jsLJqyPfjA2iFNHMvAxgz-zO1WecVgleSahWgW_B5BshbYat4X1UqUuKpexfxlRxnD3oWlAnHqeLGpne8JebFV-ICVxvr5g-5nI8P2Q6dY8=@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cXXAEFJXF6o8xBqGlRyVcu3Rl-QGuPuJ
X-Proofpoint-GUID: cXXAEFJXF6o8xBqGlRyVcu3Rl-QGuPuJ
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c1768e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=I76Qk8w-AAAA:8 a=vFEzn3JI1hsOnF_rj58A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXzI/YCkuwM2WW
 CaSMCeFWarQ3+hOQJbxZyNG77JEa62f9HqlMvJ/NBHjmUOgWwOJFp/quNUVrENHR3zO2Dsp5QHC
 GTwd3hVA3yn8dsp2k6bsgaHt4f162liAsM1HHF2c5l180rkJdyBcmuUKTmgaO211IPzFS7ml3os
 w9zPcvM+4M2BESTNJonxXlOQ5kAqwThfP+FbOXAay/sXPXVDpBpmiUN2TsppANt2wH5lvJA5eA+
 TWjZ+q1KxeVr0ipCqTCremuNk4JQ29zsYkTMS8S//kB/aq/HAYogh70zEVV4k+lImJY98L2VNnF
 BZ76jo5cjdPvX8VhHwPciXxYLLpayZ+kFhPbyJUsfivukQFx7ZPlMqnQOg/7EWGb9KBNagO2n41
 Ni1WPBpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On 9/10/25 2:54 PM, Aleksandrs Vinarskis wrote:
> 
> 
> 
> 
> 
> On Wednesday, September 10th, 2025 at 14:22, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>>
>>
>> On 9/10/25 2:01 PM, Aleksandrs Vinarskis wrote:
>>
>>> From: Hans de Goede hansg@kernel.org
>>>
>>> Add 'name' argument to of_led_get() such that it can lookup LEDs in
>>> devicetree by either name or index.
>>>
>>> And use this modified function to add devicetree support to the generic
>>> (non devicetree specific) [devm_]led_get() function.
>>>
>>> This uses the standard devicetree pattern of adding a -names string array
>>> to map names to the indexes for an array of resources.
>>>
>>> Reviewed-by: Andy Shevchenko andy.shevchenko@gmail.com
>>> Reviewed-by: Lee Jones lee@kernel.org
>>> Reviewed-by: Linus Walleij linus.walleij@linaro.org
>>> Signed-off-by: Hans de Goede hansg@kernel.org
>>> Signed-off-by: Aleksandrs Vinarskis alex@vinarskis.com
>>> ---
>>
>>
>> I was thinking, perhaps we should introduce some sort of an exclusive
>> access mechanism, so that the e.g. user (or malware) can't listen to
>> uevents and immediately shut down the LED over sysfs
> 
> It is already done by the original series from Hans (linked in cover),
> which was merged few years back. It is also the reason why this
> approach is used instead of typically used trigger-source - that
> would've indeed allowed anyone with access to sysfs to disable the
> indicator.
> 
> As per Hans [1], v4l2-core would disable sysfs of privacy indicator:
> 
>     sd->privacy_led = led_get(sd->dev, "privacy-led")
>     led_sysfs_disable(sd->privacy_led);
> 
> 
> Of course, this security only holds if one has secure boot enforced,
> kernel, modules, _and_ device-tree blobs are signed.

Great, thank you for this context

Konrad

