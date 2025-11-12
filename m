Return-Path: <linux-kernel+bounces-896910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E3C5184E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F408E42313C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF3530505C;
	Wed, 12 Nov 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tri/oO1Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYyU5yWA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3E30277A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940951; cv=none; b=I3xkuIjvDer3rhBsxHGZHcnitg6DKGmVyTkvUDCLIG3i0knpeJdQSADC9Y+jTnynbQmnx+9BjTT+eCVn6MBRjz8lkA6gCO3B3BsgeJ976OH2Thi8PBeXk5S31zp7OwqepgqHzASphfF1tIx9eVDUalkZwEJa9tI1WTkCeJ42Cqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940951; c=relaxed/simple;
	bh=wTui7CYgiy+K6A4DwIyIpanabpofRNM0sn205OFN0K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVZV1uITCXm8/Z1xEjveaCEq4IRet53gd/W80QVbZLdtnMuk33aVhAjk8HtUzjPcpgAXwoIGagrzNHQ3hSrlaOJFew5toWqf9yV8E3B24rbVHNCmkIhJfDe+F7y9FFNuhDwOW9/6w14JXe7iN7ePMi2nv20W7oj486hMSThmaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tri/oO1Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BYyU5yWA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9hUZh907408
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+dPJ4QZdBUlMpVPRyGvKtHV7b42+J5SfL4CezhrPsEM=; b=Tri/oO1ZEG/NXnXj
	LZ7eUv/Z4t5Xpb9bTEJ/YzsUOMgVtx55KaPtO6P1rg/gKKagVqtARxR66yqlMfXF
	Ba4NWIJ6sfBdpgI8Ci98+8p48bSh3al5LCHotjlL25X5gcmdgIh3Rq7Og1k+/kZk
	iwc3j8n/K+ztzRkkV/l4P8IVQfN1uSos8ObPgx8IA1b2epBcan8o5MBRhVb2wOhK
	nyROZc6CCrMkjRSi8+ZT/jQlxIWRS2smP8pgiut+sgB1SgR7Jm+Nxn0W0DSxjift
	76jWYAICf9fX95WAvBfZMrTQiNqq0mzoIBKG+FKdvb7yv7DCh+zAZzcqBdTA++3y
	d67QyQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqur80y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:49:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edace8bc76so2172761cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762940947; x=1763545747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dPJ4QZdBUlMpVPRyGvKtHV7b42+J5SfL4CezhrPsEM=;
        b=BYyU5yWAzNjmSjF0db+II+H5IL4CxtRMmKrta2O86LW9BoVRVca50EOlyJ1Csws1na
         VXIjg+0QOC3IYyRve5/R25xPOvBjiaKNnO9Mmcbz9J3VAoIQcmLRQ0Rqan5q82teMrhd
         KrmjkW4cs361zLjk0HgqlC05Utg4est/0lE+cK0QH8NtjpXMFk8R6qvSqDOkWFJZJvVl
         cECr9wkDrU7eUnZuiTeBE5YQsv1i8GtB18FuJkDfGY0FjUFdiiDzHEimoDgjJ77Iy21m
         YdZ2lc7SkYLhNwDBN385SlQpwt5jtfNhLp/l2naZJ+mqitQuyePdI6VqFpdiQCs0nR7e
         Vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940947; x=1763545747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dPJ4QZdBUlMpVPRyGvKtHV7b42+J5SfL4CezhrPsEM=;
        b=SGoU0kwt2Q1i/qKQjUOspk2OB7kCJvX5xHc/Th4s4M4q/F5Kea4G/UeU3hXgFQItdF
         7VEQ28XBrjhyXrVkGLnkdmwEr4ldIdFQ7NKLI70P7xq9iFLAlw3KbMooYlN9B1jrMUfY
         7zZN6j4PNHq7bnkvULFxG2RDASmarPr9UN94T8w7xbIrbzv3GWxjAxpDUrozxtzdoIGI
         TIOlSXg+Fafndiwk8dSGHivaWSzQp779zLtdh8t0nJIkvnUnuaw3bOG3BBGogfSXCepL
         Iral0L+my2hqpirX7VtaLXKCaQnsTmODooHZ/ZAqXnPnJuJ8vC5mCcow7AEcL7GwUj4f
         V5mg==
X-Forwarded-Encrypted: i=1; AJvYcCVCpHzQf1AF9obXwWUGD+0RnDtlmdLLjH0qOgPVKP+0pHjw+8eiujEa8r8R6ySXsotkzCCzemq6N70MoxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaPydyGxrPHnwlWAbYnbesZUKhg0s6PHha17gQpuEnTWgUY1N
	fj/MwaSKfFlIqYAv76HzCzB5gVleL5lpnHtqwSb9pqjLkxtxNVVI1wyy8fnU2skuXpRGnO5wPx8
	P/6NonU6CW4CWghgi9N8EVWBB8o5p4tf64n/Ju7iA4alHP2laEUb/WYJpQ2K4xggY75Y=
X-Gm-Gg: ASbGncs3WOs8f00Acg2ztjre7dSky+c4wUWDyCqG6O7d71s6eZhm2aZl10PqwbasimT
	cnb//xVJOw2gfmk4GNa7Oa6PMBIxCUbZOweriJ2wdHSMZwLe40Ri+R+C6BX611SqugOuSTZoTfU
	QY1Gq4ZsPeckF+852g+wfRSORh6pfz1r9UgNeabWNXJKc5aD7leQATxwFWZZWwR5QH8lYm/kTiD
	+1vvMUW8xe4nvIw0WHVOVKW/nSGmR5idMB1pD4hAw6RRRuam1i9sS2kZWMZ9wzyI1SUVGBphwZf
	RGDw++LPPDAeieto/oRxJaPdLZ2rXaBShSYN1OkLWyljINAmmcREyCRMdAmWdow2rXanm3ZvtTi
	zqSe3mE5jx+gCtph/4M6XINDzKUquRSQMGhdBeXbrFQdKHbS/Y7IPAzI4
X-Received: by 2002:a05:622a:11c4:b0:4ed:b0fe:54af with SMTP id d75a77b69052e-4eddbdc11d9mr20202611cf.13.1762940947371;
        Wed, 12 Nov 2025 01:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPqrzdXmGbyKJf1zyUJ/6/lZ60CvdT07rxfc/WOc785KhcfTTcn2HopItZGmkx92ctB3AEQw==
X-Received: by 2002:a05:622a:11c4:b0:4ed:b0fe:54af with SMTP id d75a77b69052e-4eddbdc11d9mr20202511cf.13.1762940946968;
        Wed, 12 Nov 2025 01:49:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbc9656sm1568734666b.7.2025.11.12.01.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:49:06 -0800 (PST)
Message-ID: <2bde5922-6519-4b6d-9edf-94fd0e7dbc9d@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
 <28ffece5-29b7-4d6f-a6cf-5fdf3b8259ef@oss.qualcomm.com>
 <ee04e03a-ffd0-43c0-ba77-c7ee20aaac43@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ee04e03a-ffd0-43c0-ba77-c7ee20aaac43@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3OCBTYWx0ZWRfX36f/0erD+f5J
 2vuAOOvyikDGvzmD39aU+OxeiDP0tI4Lk6Gnl+h6oGFr80Dp4fYLJtOnMOkhk73M8aDUJNC0U3r
 R2zcNkJ4DbPdYoMf1iuyh7TXu+XT5/6xwgU4iYc8yiGioD28Lted3bXvFxZPxS/QK2nZWFPUmJI
 X3QafzIak6KcjhdO9Bgrnq7TU3ngXKZ/KMdo+ddLA/jczrwF9qtpe/S6I4nPs/T9aBJ453hqsz9
 ABT5+r68LrExvTdk5aV9ql3VRkhcNO7Pk60N2PO6Q8zVqRDtm/Yqfiwkr1GEPqmGENIx5V4LrQo
 GlSqrv9RM67aD6zY6pnoEEuou6oj40VCK1MgS47iNeRgq5HtQuOuV0zh6drHMj5zImdhwezMtsU
 rN0GryJ8J4Ni/kiAj9OKbx67ATFgfA==
X-Proofpoint-GUID: 2kXsLc3hou2e46T8ZsJe_QHM931K6epe
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69145814 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iyyYdLundppeB2c9LQAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 2kXsLc3hou2e46T8ZsJe_QHM931K6epe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120078

On 11/11/25 1:24 PM, Wei Deng wrote:
> Hi Konrad,
> 
> Thanks for your comments.
> 
> On 11/10/2025 7:49 PM, Konrad Dybcio wrote:
>> On 11/10/25 6:57 AM, Wei Deng wrote:
>>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>>> Bluetooth work, we need to define the necessary device tree nodes,
>>> including UART configuration and power supplies.
>>>
>>> Since there is no standard M.2 binding in the device tree at present,
>>> the PMU is described using dedicated PMU nodes to represent the
>>> internal regulators required by the module.
>>>
>>> The 3.3V supply for the module is assumed to come directly from the
>>> main board supply, which is 12V. To model this in the device tree, we
>>> add a fixed 12V regulator node as the DC-IN source and connect it to
>>> the 3.3V regulator node.
>>>
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>>  &apps_rsc {
>>> @@ -627,6 +708,22 @@ &qupv3_id_2 {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&qup_uart17_cts {
>>> +	bias-disable;
>>> +};
>>> +
>>> +&qup_uart17_rts {
>>> +	bias-pull-down;
>>> +};
>>> +
>>> +&qup_uart17_tx {
>>> +	bias-pull-up;
>>> +};
>>> +
>>> +&qup_uart17_rx {
>>> +	bias-pull-down;
>>> +};
>>
>> This is notably different than all other platforms' bluetooth pin
>> settings - for example pulling down RX sounds odd, since UART signal
>> is supposed to be high at idle
>>
>> see hamoa.dtsi : qup_uart14_default as an example
>>
> 
> I followed the qup_uart17 settings from lemans-ride-common.dtsi. Since these configurations are not required for Bluetooth functionality. I will remove this configuration in the next patch.

This feels like you're essentially saying you don't know/care why you
did this before and don't know why you're changing it again. This
doesn't give me a lot of confidence. Are you testing your changes on
real hw, running an upstream kernel with some distro userland?

Konrad

