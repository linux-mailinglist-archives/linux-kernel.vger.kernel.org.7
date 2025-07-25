Return-Path: <linux-kernel+bounces-745420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45225B119AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F641CC8497
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477E2BEC57;
	Fri, 25 Jul 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFgQGoXV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DE1E5213
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431438; cv=none; b=GJfW7pekXgjWyiM31xPn0SGgrKrQYAvrZ6dC9bX4+yDvs/RF3M14X1KzqOJsygqntF0w3fMyWx/nQbkYa50YPUKPPr1YPCdMQTdoZyBb5gqBVuXZcSyP1nZik152q4KQgEIrjkCYQ4X8fb6VnayiQ5z/3h4YOuXuh/yl+KcvuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431438; c=relaxed/simple;
	bh=GUt9tz6QhKbEM20TY59EPhfaQ3CjaqtAklTBxesc4Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hla9edMoYOB4n9dTFERVyELaNt5i8BRjb1Zbm2mBx4e6GYWkY/KzSk3OFjUGd5a7KOGPIK62fMXQrnx00BLZ/HeDkF268/hkGsssKC09Dl9WvSwFMWeJq28NtG6/E97JJnRNR6mIG1JMT57EoT7HuyBgZO01obG3WRiw3+BIc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFgQGoXV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLrVZn004800
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G2gAp22n0LVqwKU2EKsAkb8mxd9ndCHkEqEltv8yGrA=; b=iFgQGoXV0uN7DDu9
	rZKGekjHt51J194Femx/2/Jkn1FbiI+PSbTQvn3lEaSVWtCGH/mlJ2snM333lZcq
	MvGQwRZvnn5BL/F857Qf0ygn1fUSjlZNID6yf72vlTa4Qx//SQj0RQYsir63f04/
	4E0NA2o+nSpEc0xCXdQ1DCLFuYzxsbO0dtfnt9j4wtpk/G/jr+lKQ/kbRlsSyLl0
	9DZWfe8HtUNIhAFXskmMxfZlk7aWyFFNyJp4AjvoQQuOpsUYbMj4eI5MnVTZJSyV
	7o7tfSvJiCKeIy12KDWu4SF2QNPZreaEfaxSIulfzrwMMrgo344sXvrQJr/03fXX
	29WkAg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w539bb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:17:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f3613e6aso1138794b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431434; x=1754036234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2gAp22n0LVqwKU2EKsAkb8mxd9ndCHkEqEltv8yGrA=;
        b=FGXLYk3dL1BXxyjDTgGd+JTwSINcFvUPFTnv8if8EBBonetAB/keIWhyKB86PwOdl4
         Bc7pcsDrMt/UbEIA1cFSJRHR7RIJPdjupUYMWFg9d1uOmTtuKCR7Xl1lE4fPetL/OJtD
         8sXAydtvPMG5C87DxD/yIrjUh4MlJjKp5t5ziQEJMhsmkyqQ+lHqsoK4AaFKSTSJOHUH
         u6kTutpkhLh8GiNi27jXCOs6dKKU0TqYVs2ZmRn2aRRPeXgCDt5RxTjLBB8qJbIruD5U
         TNteHChfZHXvIQ80vuTD/3dpT5YfJS8SSGYvnA0719LA/a/qhFp3RzZJ5lpnek+eoWCi
         xnQw==
X-Forwarded-Encrypted: i=1; AJvYcCVD/cq59CPzlHfTc0fNuvkxtVNRFOF7SuacI1sRgadgk2yBLfb7L2QramaIKRURDPL+/Fqm0L/uHkdPe04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+XcgMst2cd7mmZLeIYhX4yRd+SKbUaykYTgPGFtvVhlhIBGu
	9ALWtA4yCZrgRjwWaouXW7DTenGGA1XmBCFMH5wtwAqc0fdhD6a4+n7SjgBBascD3x8405KtEp+
	J2aLxw/J+AQ8sMyBb6ARM02qY8Tz7PFFwp8pDivvFy+7BA3wHc2iwG+aoe2VF1b1RE9hRraDQGw
	M=
X-Gm-Gg: ASbGncsLCpfQo7L1lUPaAgChO8V0zAnfnUEFjsL7SGjVKlAkH9/obp550V29N4ryH3G
	kZW1YFllj/FvVc82y2IXO2g/uyd1yFUqok7nYDy7h7Ke2RejeIMVJzq4sebrRnZJ+OFQ0yW36cn
	DUXckqAxTATkKppNFnX7LvAYuWzl0KY9BTY2kvyM70dkL52CmXsKnmpJZyTeSFt5D8i+cpYNpHT
	dtAm99PcrGQ95Hj6vhietPlTWwbNtJk3ZyQj+lbiCtE4/1S6+6orzHCMxxSeVL/XgM0gRFlISF4
	OcuEb/lBAY54nfKUTigqHUTHcPA6ICCRnGL2qewZAcbE6l9DQX+yYAAf6aGNm7kJqczTimACMKR
	ttEfS9DjMZPZwuvbe6/pb+3w2JCo=
X-Received: by 2002:a05:6a21:9989:b0:22c:a165:3664 with SMTP id adf61e73a8af0-23d701db921mr1436115637.26.1753431433686;
        Fri, 25 Jul 2025 01:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd2mTB0BmD98J6BIrb5zukkTqEkg9rlDr+yDIHUMb/P94c38M867StKboWi+F5J7N2YvdZ8w==
X-Received: by 2002:a05:6a21:9989:b0:22c:a165:3664 with SMTP id adf61e73a8af0-23d701db921mr1436058637.26.1753431433198;
        Fri, 25 Jul 2025 01:17:13 -0700 (PDT)
Received: from [10.133.33.78] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae1584bfsm3128624b3a.38.2025.07.25.01.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:17:12 -0700 (PDT)
Message-ID: <d34ff09d-5a55-4c7a-9eb6-fc0a0f4adcfb@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 16:17:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] power: supply: core: Add state_of_health power
 supply property
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-2-9e377193a656@oss.qualcomm.com>
 <6oixvnhihgjucqaovkayzm6cpi35jfmtwmm67wa6h4nlmhr6w5@ggb7auvjzos2>
 <cd2964b0-e28e-4ddb-b319-9b65fb78b73c@oss.qualcomm.com>
 <p5nxjuexggzxttislcaum7vomawnq5fncos7itfib6ysvy6a4k@d5ywmfpqyk3s>
 <994cb636-50b3-40f8-baaf-0b1afa2e7f53@oss.qualcomm.com>
 <3ldf7w5cpv4wt63kvewl2a32abx4uohvir7zgefpqly5rytkcn@p5fslnvpnjn3>
 <4pxg7acm4nuwo7bhiwrtpxdey7v2hanw2tw6vbgp6i6md4q2zx@pxjuymr6ykwr>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <4pxg7acm4nuwo7bhiwrtpxdey7v2hanw2tw6vbgp6i6md4q2zx@pxjuymr6ykwr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AfKxH2XG c=1 sm=1 tr=0 ts=68833d8b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Oh2cFVv5AAAA:8 a=VwQbUJbxAAAA:8
 a=7KI_h5JtWn8X269DZ4AA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA2OSBTYWx0ZWRfXxGq4Ncd+BPtu
 grPS/dtUCK0hr1AwZ4cozi3nuO/reSIn3eKDSTCvukzJsD0JrtG5U3VzhO0B5HXc7NVcsIBNJwo
 t4HTn9+mAyEZmomFMDJXh6NuPUB5rTchxNtOONzgNR/WuMormuYKNO2kT4Gea8eJjkWBk4MEtuO
 +DacW7Cl0RyBLtVnGuZv35y8UqrWUMh1rFoNhk2cntXQRb+lQlLhJHRK9sruOuFB7ikOIgQr7ee
 CquN//MFXMeuNMuQggTu4FfTGcaraDZL2/EkADlL7xx3fzMOSMOS/EcQndSghb4077oZtc6SLqi
 +oDkz0UkavrRQu36D4KqWRSXF0FmbzCx+gCTJX2/LbmZwQzldb2nLuv7W8EwKYL5JLWeHouSskN
 R3RA6f+9zFM8bWHeI/MUciMZKkeFO/3COAZip1p+SHkDZ+CRWRRVnWyCGztRejrdwMkPDsrV
X-Proofpoint-GUID: 0wFuPkPfOJG9wlwUd7P9iQRdXlCM1XOh
X-Proofpoint-ORIG-GUID: 0wFuPkPfOJG9wlwUd7P9iQRdXlCM1XOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250069


On 6/22/2025 9:17 AM, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Jun 05, 2025 at 09:34:14AM +0300, Dmitry Baryshkov wrote:
>> On Thu, Jun 05, 2025 at 02:08:30PM +0800, Fenglin Wu wrote:
>>> On 6/3/2025 6:35 PM, Dmitry Baryshkov wrote:
>>>>>>> +What:		/sys/class/power_supply/<supply_name>/state_of_health
>>>>>>> +Date:		May 2025
>>>>>>> +Contact:	linux-arm-msm@vger.kernel.org
>>>>>>> +Description:
>>>>>>> +		Reports battery power supply state of health in percentage.
>>>>>>> +
>>>>>>> +		Access: Read
>>>>>>> +
>>>>>>> +		Valid values: 0 - 100 (percent)
>>>>>> What does it mean that battery has 77% of health?
>>>>> I will update this to explain it better:
>>>>>
>>>>> Reports battery power supply state of health in percentage, indicating that the maximum charge capacity has degraded to that percentage of its original designed capacity.
>>>> Which basically means that we don't need it in the first place, as we
>>>> can read capacity_full and capacity_full_design (or energy_full /
>>>> energy_full_design) and divide one onto another.
>>> Hmm, it is true in general to quantify how the battery performance has
>>> degraded over time. However, estimating and calculating for battery state of
>>> health is much more complicated I think. I am not an expert, but as far as I
>>> know, different battery management systems might have different algorithms
>>> to calculate the battery health and report it in as percentage. For example,
>>> in Qcom battery management firmware, a "soh" parameter is provided as the
>>> battery health percentage based on the real-time calculations from learning
>>> capacity, resistance estimation, etc.
>> Ack, this is more than just full / full_design. Please consider
>> expanding ABI description (though in the vendor-neutral way).
> No, Dmitry was right. It is exactly the same.
>
> Estimating the battery state of health information is indeed tricky
> and complicated. The reason for that is that estimating and
> calculating POWER_SUPPLY_PROP_CHARGE_FULL/POWER_SUPPLY_PROP_ENERGY_FULL
> (i.e. not the *_FULL_DESIGN) is complicated :)
>
> Greetings,
>
> -- Sebastian
Hi Sebastian,

Thanks for the comment.

In the qcom_battmgr driver, both POWER_SUPPLY_PROP_CHARGE_FULL and 
POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN properties are already supported, 
and CHARGE_FULL is used to represent the learned battery capacity 
calculated in Qcom BMS. Additionally, the Qcom BMS calculates a 
comprehensive battery SOH parameter by considering multiple factors, 
such as changes in battery impedance, learned capacity over time, and 
charging/discharging cycles. Such as, for the battery impedance change, 
it is specially important for calculating SOH in scenarios with high 
load or low temperatures, as only part of the CHARGE_FULL capacity may 
be usable due to significant voltage drops, especially in aged batteries.

Hence, we proposed adding "state_of_health" support in power supply ABI 
to expose this parameter provided in Qcom BMS which is different from 
the calculation of charge_full / charge_full_design.

Also, Android battery management code [1] is expecting "state_of_health" 
power supply property and it can use it if it's available.

[1] 
https://android.googlesource.com/platform/system/core/+/refs/heads/main/healthd/BatteryMonitor.cpp#927

Thanks

Fenglin


