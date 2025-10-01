Return-Path: <linux-kernel+bounces-838599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8CBAFB53
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6816F649
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C727D771;
	Wed,  1 Oct 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmemrJcc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8D23ABB0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308169; cv=none; b=KyCnJPJM3Yxh7AhDnwkMMC3WdKJnPE8mPl0M8RVUhBdjKoNSsxzHlA2QAfdapbqIXHF0DIUcM6fVf7SuswCprlFP0gY/TRsXWcQ07S7wtmBKurWY6vylhKrC3E0kl6w+srafLQbwznE9OiEbYmIj/svCAX9p+yxAE29NaM3XiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308169; c=relaxed/simple;
	bh=ywB4TRn64dL9GrZgeL+rxfSwyjMN1NqbuW1p5qkBoSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbqUwPWypAWvTxVu5R9Ah3cQLNq9sY5CStTFujlNzLLd2mB14PdFgVjOYtQPZC1L3XOPDfxN7qI7hcze3O4XFzXsStUP4FPGFsW1efAUgxV5k0aRiXf8gW4LUi2fhnoSnOeXqWm0Q9kOov57JMNmcq9T/Gih5vwgsHGo1enJRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmemrJcc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918Ud7j012446
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2AXkv0SchroDbDxwaQLmJ1jgS5WU7BUYEQwWO7JzI/8=; b=CmemrJccsjcf9w2W
	ft3zshGdTa4c/8c5KvQhipDcKIj0a2W0olYc8q1clyW3OI9hAvVWxemvlsZpZlNZ
	3L/IMBt5/wLBdBvCgNNftmuVEXI6AIDpKESLqJyaIQTtB9uPUqevEjPqlJGkDyiD
	MtGDTyAZzzLRisAWp2csE/uDkua7ZIzphkaztaWd9CqaUDHP/f7iDyWstnZgNeZW
	5ig2wjtshRZ6O+DFLawLDDRhrY2jENZPRBdfZ4WFB3jU4Lv7PH3ao6RlHRKyNFPG
	qXGLSQCFuFz+JMV9mjG5R6Tl221ZdBlE7s62xJEE+XHuqOzVO4d3TQZ13zjVVLll
	7CG3tA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a63xq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:42:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e231785cc3so7154351cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308166; x=1759912966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AXkv0SchroDbDxwaQLmJ1jgS5WU7BUYEQwWO7JzI/8=;
        b=hlEVIxItkTeb0Eb+h+eTbtckmNyt5VyGvVBJE4LES2L3vnYG5egkfry1lQ9CT+6zZz
         RpvNFkxPQrXAxVFZHOfwJNyeirFDFdBNwrxnsCaWJEi+S9Rp9d91fJdZFtBA+rn1zijU
         /oL/zCX5peK+w4TOUq9LIs7bPWYrjPbfYYsGuzyJf+L09kYudnhW+59RGQrXcSYPpvFF
         HPtnvo7F3PqOV07uicX/ph0xV8VpOW0GugtDIQlkOK4b4dOBKrLbpN8f0XtI7E0ryk4l
         CkzXS1B/MmNLTIitPhwr1dEKsciuosfWsI7PpdUyvymhwP55HWAnLly4akeyFVlJCTFc
         w+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+CAquYP8EaqGwFf/XTzMpVc4rdKIVjPNE21wxSYqyaadj0kSuaybn+g7Z91wh7mAiqY4fYrkvfkAxUVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQq98mHRZWNh81yIqwU9PZmqyNeS9tykHG23NM76/BdOIjWMv4
	hv4065t6HMV1b6Q2dKF9kxDIOUixeKahgfLVhJTdXtORYk/WJAJsyAxv20DtD9z8iiZnKATBtf4
	0vqGjWja/+o9GY1Ly6+mBELm2dGHgeg96rExI+mg6BgPh3bRvi08YctRqR6+Yg8v5BUU=
X-Gm-Gg: ASbGncuqEV1RTzGA2uafbyZEhjXkfitokP9gmmn3VItrobSRf49XZaihZp7qWTEhxpE
	OgTQ4BrZqbgf44NNa0oz50E8shKCGFdQbj8rTY5e5894O81g38zpQ1ulcfSTVVhmDnuISvlTsZh
	DmvEuXw77HV/W4FZS/qJoEZWPIl8JPE/9iLmHffsZV8f/X8WYK/uPB6VCdbGEcS8nih80jvutNm
	j9HRVmdMDQW4CSxjF06/F8XxIQlkXCq5tzAfRgvgd1z7JJnkgxiZUiuIgYzSzkDKdxWb/KFKUqs
	LSpvy7qtNQbeqvtciZw+2o5VHkX4Oa7aTz7T5gSR8Pum+yVaOf8cMfI32OLPKU2gXMDzLAc0UQv
	xxcXUA1JQ1OgJASa3vTDwvq4AHQs=
X-Received: by 2002:a05:622a:1790:b0:4b6:2efe:2f73 with SMTP id d75a77b69052e-4e41bf6f1c8mr24267611cf.1.1759308165747;
        Wed, 01 Oct 2025 01:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7/tCqSURz5SUFulF00TbJ80vijd1LGyEq3ySw1CXLtSkpP/xK1BzE6sjcisbfNg6/ZFRKVA==
X-Received: by 2002:a05:622a:1790:b0:4b6:2efe:2f73 with SMTP id d75a77b69052e-4e41bf6f1c8mr24267411cf.1.1759308165166;
        Wed, 01 Oct 2025 01:42:45 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634c065a67csm9320710a12.36.2025.10.01.01.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:42:44 -0700 (PDT)
Message-ID: <26eafedd-a3e2-4234-9237-4cf7282c0d19@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:42:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/24] arm64: dts: qcom: glymur: Add USB support
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-23-8e1533a58d2d@oss.qualcomm.com>
 <dzjj344c6zlkg4rvi455xoedhd4d2kjvodi6yftv7svhvvmxbz@kwq7rkq45tms>
 <66a5084e-3f7a-452d-ad5b-5867528f57a5@oss.qualcomm.com>
 <2c576766-bff2-27ab-2805-298a9d743b09@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2c576766-bff2-27ab-2805-298a9d743b09@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dce986 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=l2iTe4CMrS6P3tszQeoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: R7JYQ7oe2P3e1V1Z7_-XJYMz4ZZoiY3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX/Zjp+3jqkNQ0
 Spz0/g7GfWtPMAZI2Fvhn3Sh7N+2bPvs0ybi1kdxoBuJDOsfzQlzgkwaty/eOLzpjygOnPw4AOh
 yLyrCCi+D/WzV4xOhdmpBTSz4J65FTvHU2ZaR1s2ZkVl81MisLeetAjLVsw0BvKuRzf10Jqita4
 WXJt8pmlYBOs1CZ/QUOVBMWCXM/Kih49iSr+AjL9+i8DUGbAlOyXH31mODB52o5xB7J5E/oZp7D
 z5svegg+n57a0NBbsF5s6wx33ZPv9XAq/DIHppIZNh7V4Xx8qaOB1rY43rpG3hOvKQvS+DVIwAX
 RNgYqsLvOvBuP+2k5BBnEPUmdYCiaK/9kywLJtUquykkE/LWCznDhA3P0kjuCc/hc0TYqtqGBwp
 PxNvY0x592zYKR56VQPOSe9k4lJtOg==
X-Proofpoint-ORIG-GUID: R7JYQ7oe2P3e1V1Z7_-XJYMz4ZZoiY3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On 9/26/25 3:09 AM, Wesley Cheng wrote:
> 
> 
> On 9/25/2025 3:59 AM, Konrad Dybcio wrote:
>> On 9/25/25 12:54 PM, Abel Vesa wrote:
>>> On 25-09-25 11:58:29, Pankaj Patil wrote:
>>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>>
>>>> The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
>>>> controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
>>>> M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
>>>> flattened DWC3 QCOM design.
>>>>
>>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>> ---
>>
>> [...]
>>
>>>> +
>>>> +        usb_1_ss0: usb@a600000 {
>>>
>>> This is usb_1_ss0, but then you have usb1_ss1 ?
>>
>> I'm in favor of just calling it USB0/1/2/MP/HS because that's what it is..
>>
> 
> I never really understood why we have:
> usb_1_ss0_hsphy
> usb_1_ss0_qmpphy
> 
> usb_1_ss1_hsphy
> usb_1_ss1_qmpphy
> ...
> 
> Not sure why we have the usb_1* tag for the primary and secondary PHYs. I think it'd be simpler to just do what Konrad mentioned:
> 
> usb0_hsphy0
> usb0_qmpphy0
> usb1_hsphy0
> usb1_qmpphy0
> usb2_hsphy0
> usb2_qmpphy0
> usb_mp_hsphy0
> usb_mp_hsphy1
> usb_mp_qmpphy0
> usb_mp_qmphy1
> 
> then controllers can be
> 
> usb_0_ss
> usb_1_ss
> usb_2_ss

I'd get rid of the _ss suffix too, we don't need to be super specific
(plus they support ss+ /or whatever the official naming is/ on some
platforms and not others and uniformity is good)

Konrad


