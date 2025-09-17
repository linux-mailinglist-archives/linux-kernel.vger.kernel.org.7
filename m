Return-Path: <linux-kernel+bounces-821580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DEDB81AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF84D4A3FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90A233149;
	Wed, 17 Sep 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nB8MtTh8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB018D656
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138455; cv=none; b=jC+fOohqC8i++J9ckSDITb2JYhlBJ8mxQ3IP66IbEvDXkzaVxOlM1UBeRO4wdvp76wgW0O3MxQD8aLra4vWV/SXIncTJADRmWqm6+gcXpqx6xyCkH7T04xU08NuOZMr/biTTpLE5XCDSBMphl9EH/S9GDzZzt+zuDmzbfD+3TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138455; c=relaxed/simple;
	bh=eCc3DvwwOCzNRdsPiK+c2P8cgXzJw5kUNDcvbfkn/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs0L5hbSLbn6doEEtsZ+EqIdRL0dRGfATGy3Wq+tdD1n+FvhM2HDdoo53FjRA13Ft0lreYPHmYoLh/+6ltUBP4AgT/Qm+cClMHRSkrlNd8Goau3jpeZ3Uyys7+YqDhIkbZ1sr490GdgZgkNAw8xQC34ifGfi8lqSppD6bVfJu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nB8MtTh8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGMN2f010757
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGOPpw3iuumSmHxje5vaDZCPavdx4WY1HpZ7Jmti/9A=; b=nB8MtTh8RSzbgZcm
	bqBFCcYv78eXzm9cR2KffIDxHEvRgL74+UwlbZmH1pURqJ7CJb6VT2Z+9/FM7GL+
	zAVqqY7I2Ad/xXWyoM7M61JCHyE26hHNa6ETqLWlF69pvas0bh1WAhMMJFwgaoPP
	gsUnSCzFToar+jGc7Dw3hfbHkBoxjlWQ4unbU8F2DvGnviHXLBbawDwwx9/yzB6C
	CIGHxVd9jPJCbR3gpWGhJVK/b8rf8k87/+Brx3bAyKjWVqk77mkfgWZl7GAmfpEP
	itIslCrFZ0eonyvd89OPxGsQg3/QcZr07INd+Nupj9xO3ImsEt2gH2EG8T8OkRIt
	7BZIIw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxunhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77260b29516so330098b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138452; x=1758743252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGOPpw3iuumSmHxje5vaDZCPavdx4WY1HpZ7Jmti/9A=;
        b=nwtkgYSu+2rS/VcUgId5i1aFhkgwFyB5Ee1wqVWqhuuVpARLLaNHLAtCJT3J01OSuz
         672JKTbt5+fKitV+mOexTMjMmrIZmmLBwiLCzh6o21zN8RqegOGojiL6KOPAYOJ6J4TX
         y0he69VlQOfxrjrj4K5uam8ncIWQOW4f5+UtFW05/iW1Abo76fuVRQ1aC8FVzUUzcJ3a
         PLduO+cZDJAPy3epMMypiLGPaBWsaLY6sJP3P8GfnpS6tYsbw/YAL/c4qzngMC9o0I0M
         yQcaDOgXy6gviqjwXzZSGdwAvbE9gMWDGR7hCmVfzMqFuchW2lRyil/GaoWgm/hdp2ca
         LjIw==
X-Forwarded-Encrypted: i=1; AJvYcCWgWKufpIEIJLnnr4zp8VtphruDIIDevyrA+BIoir79P4lI03/0zDqkRLIZzC/Cuft3f2mD30yH7odsqfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFrn1DE4e8WxKO1cX0iQbpSfZYfF4Ro3G56qGw4p+9KHCd9w1
	OJoUF9qGjUaRCyH6nh4Hccs2DiPREozDEuT5K0rzURSQHvbv0npmjrOtCxrbIrgS9GnCO5SQ+Fk
	jeCnmv+7CceWI+T/4uUibJZDo4k9QQ4Wn4+sFHHB/l4acf9yXl8UN8fBpq4Ecj42TUfM=
X-Gm-Gg: ASbGncvutNIfTS0oYBOyEpVhOq9a7GYjLBigjKNyDxpAeEV8VHDX+2fG4iTR+5KSF+Z
	lPE741dzJ3Zo7pksu3chv6DEQj3d9lG3dhrcoNHHw6Kwd1/Ec23auYDrnBWpCu7ChHqZTA9enFU
	dvVspEhhZVfUJ8ABFyEj++E8DGSkGnzIjavdtsvH1TtmIyHAi72rvnKIXhDxCstYVb1IOEGxoVG
	F94eqDJcPXEnpX0cVb/wnv4pA5RgQyha835muU5izm5Y8Pup9psyc5859Bav2XhUSC/kXS49Zz+
	l5/eFc99MHHloetB0Ol5JhlwfSAGHVL0Y4oW3fcAzhAVr9DBZ3ydgpuV1Lb6XdddBNx1gW4=
X-Received: by 2002:a05:6a00:2405:b0:772:934:3e75 with SMTP id d2e1a72fcca58-77bf72cb228mr4006541b3a.11.1758138452399;
        Wed, 17 Sep 2025 12:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1hWyfo8vXPdXPEvd94MNzd2+BYNOV1vlcuwDNTBjCR38g8b9XRkJWcMjCwmG6wxBK4HRxrQ==
X-Received: by 2002:a05:6a00:2405:b0:772:934:3e75 with SMTP id d2e1a72fcca58-77bf72cb228mr4006514b3a.11.1758138451980;
        Wed, 17 Sep 2025 12:47:31 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24b4f6sm215021b3a.37.2025.09.17.12.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:47:31 -0700 (PDT)
Message-ID: <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/xrsnE3whgzV
 S9nNeRPL/SR18XvRDOLC4W2BJi0wcUDmNBQkp7DLxfvAEtREiLONLK2iZ5G12OphsAq2JeADdSn
 BJOBHhkegWDoa/szI62xleOy1eBLYApKBM1NZsiaBT+gKLotSe8lN87OSA4t19quQsOUnblkHiL
 bD2K5g6czjGyTgxwtgfQ0/jEw3WOHAA34lCPlhXTlNx6Sx08PupG72WxQuc3vD/2t1jJWHvaNJU
 ISP3D7ag1tX+B2jfMIY4rVj/BMgV6BpW2H6oiuTD1lvFoGRbzCmzomFFhVFmkP2DjlLbfDrLkKu
 kPQQeIrrjeO8qjSOe7yXuLTBbwqdJWiiolKHGrBS9iDAlN4LSMaN9VtUxSYJYW0fP0upm6brd3u
 cJInuH2k
X-Proofpoint-ORIG-GUID: ZNfwFae6mB2jdzqiRqHD-buNNdnAK0Iz
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cb1055 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=9_5l9IA32bTo_oBAx1EA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: ZNfwFae6mB2jdzqiRqHD-buNNdnAK0Iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Krzysztof,

On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>> You cannot have empty spaces in ID constants. These are abstract
>>> numbers.
>>>
>>> Otherwise please point me to driver using this constant.
>>
>> These constants are for ADC channel numbers, which are fixed in HW.
>>
>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>> which is added in patch 4 of this series.
>>
>> They can be found in the array named adc5_gen3_chans_pmic[].
> 
> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
> 

We may not be using all of these channels right now - we can add them
later based on requirements coming up. For now, I'll remove the channels
not used in adc5_gen3_chans_pmic[].

Thanks,
Jishnu

> You responded three weeks after review, this patch goes nowhere and way
> you handle upstream work makes it difficult for us and probably for you.
> 
> NAK
> 
>>
>> Thanks,
>> Jishnu
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 
> 
> Best regards,
> Krzysztof


