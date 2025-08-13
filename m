Return-Path: <linux-kernel+bounces-766267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C3DB2447A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD97A1899C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8072D781B;
	Wed, 13 Aug 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxXDoQFz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985C2D8377
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074197; cv=none; b=GST9IhpkxzkXTTn9fV9tnI6i7AOuQScujqta72kjFrriIIbdn9+Q1qWfsQAho7K+ZYUiLjizJP6d02OsYZir2+fJESD3/DBFTT0fVdxEbWEOAxdKqNpeE0qmAxXEW/NjxPs3Rw/6gUTfKEuUga0Rh+QjCMQvUBbKRHcEWPvmkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074197; c=relaxed/simple;
	bh=2CKVRdemxHDDhnWNqTaAtbQxtL/RQiETHYNOnHMt6xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch+kCLreU+1Djn4oPPjF/ud6xyvg7fWddwlZeqF7g5OLeX3SjUGyaLnGwn0H5S9mBSLZQ2vavqq9LzjGKDU/SEV0gepmt4pXhXxQGBj34sL/Wr2S0M7E7yy6bSxawlw51S/18B0m/HmXyrCdi+9HefjE+cfHkHEbVgn8jPwFzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxXDoQFz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mKOk020490
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQKOqPn4stGn50V72VGH4by1OgDoWiB79n0LyosLssI=; b=dxXDoQFzbFYp95Gb
	7qvXPwnhepfea9s8H93Y5p0XfFFhnMysJa9yr5WU246qe1w2Gj3bdE795JYujXJy
	4bzSvDFoqFGAkZnSqsyWq6+Xb14qDe0jasm7hCTRKI60JseHri5xCSUbYNJzGObp
	VfFXEYuv675HFiIBTWN8LmQkEwMOWjdmPxlmP+jWAd7EeyAskFSTeRs2pixW3szA
	ea2xWCjTrJ2wYKWCg6TZhzV4ylkTYmjL2PTcvTbIXWVaKife16pyhcuyBjesurdP
	ks6xEI9N/on5jX9Fqpu0E+I4GDHGgML/V56zFRpCxgD9ourObH8gqLCQDLuFPhZt
	LWUO/w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx986x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:36:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bf73032abso6388319b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074193; x=1755678993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQKOqPn4stGn50V72VGH4by1OgDoWiB79n0LyosLssI=;
        b=jXTa0XM3yfrGWd3Ky9G6s7bSwp6ASsjurl81FyVZepRzBpashYSS7J5h28NJmqSITM
         l69At5Xh3l11Y2PelJmPkDBPhJ6RsnYf6S6eslCH51cALKjYl106UcnKXTaPWf1asFjf
         uoGjyf53E+8djibOg2QZMUseUjEiZ9AiRBi+d7rEKjbTv88422+WqWRpERo7lNwSMcLi
         2Br4mavpD63dbZ3xTHYXn0iEXVkaH1bGvqwRV8Z+duIEsqbtv7vyyyUCYmdhGgnhO6r0
         GzHXQT9N8W7/y0yTDISoA+MilbC2DdQ9GmX4HLyGk7otJFt83bbhDALF0dEZkzRrPUDU
         xuSA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkm5ey7XGuS8On0Dz1dV7E4gq3Cd+BAZ6fzSdifqP30XYcEPoL2sE5GNmIDWgB95VXZxVAPK8jqmBtfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXq9JpNARQmWClbJhD8RGfkXAx6oHecminVVn4ndtyO8ZDksZ
	fOlgdEz55ul2H1mxWObbZqr+0y78Ka+gDMdgODbqNkUPrF2JFDMdZW3VK+smugVrOIm/5KPI59y
	ir+cDDMLKcx6Iqnfz5ZVhe7Kgw3XErCGVZ2LBaltpFQQZmRO3laWL1iAnXMCLJQKOnRo=
X-Gm-Gg: ASbGnctG7DZsYzN0YfvzsU9ylrxJLjkaN9nnQLCAx5GzRKh4xbPjOJz618eLEjjqDSb
	Y9pwcCMFmH7iOAYXJ5eijCdJxMCJ5Hkjqt+bSHAZP5Df+UTWtwdJS7ucPs8kCtq2AYhfvlx+w4U
	BavIU37lc7KGO7q3qp21Y6NAP5gJkBENpMN7/K7BvtYM6WfTno1k3QwqgpUR1GdEs0+ngobDMDy
	EU2wbhKYEGAyILcsF2iCFNNgymTEIDoWIqxCIkh56IWkvxbvLxasnHjcP5m2PSIobIh2LEhlhhN
	4f3FuMuOG8vFsyeRrS8hIuFXC2xEjDEfmNTyBEJOI66FyxZKjd3Ob3Zt3sqygqS8q5jP6qc=
X-Received: by 2002:a05:6a21:32aa:b0:23f:fbe2:c212 with SMTP id adf61e73a8af0-240a8b0c473mr3889568637.23.1755074192936;
        Wed, 13 Aug 2025 01:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEICpPeEcX9FHh2K8fbGGrwZV61Cc8VFekfAlP5BaQVSsk3pjIElUOwyc5IKvo9ORk6/74N9g==
X-Received: by 2002:a05:6a21:32aa:b0:23f:fbe2:c212 with SMTP id adf61e73a8af0-240a8b0c473mr3889527637.23.1755074192453;
        Wed, 13 Aug 2025 01:36:32 -0700 (PDT)
Received: from [10.92.180.108] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdf61d182sm28438065b3a.119.2025.08.13.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:36:32 -0700 (PDT)
Message-ID: <32f60af9-7475-48b1-98ef-82962485acb9@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 14:06:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Fix address for usb controller
 node
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20250813063840.2158792-1-krishna.kurapati@oss.qualcomm.com>
 <b98f8d3b-e45b-4889-b498-adeeb4a3e058@kernel.org>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <b98f8d3b-e45b-4889-b498-adeeb4a3e058@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXzB4pkbp/Dow0
 /TzqEhEdhqQGR1CsMj1I9LX1ktRi9eJPQfH0en0ueMyoVTfGLjdVbKpbtRccYirETF3jZ9gcpHM
 RtcROi4sDH1JsRYeXcIhdUXP3lrZI771TjX4GK7zves0OdTDl2kt/blhER8y5sw7NSi7Z2i4e2Y
 GolO3ji+izUWb1DW7S3Q4/UqXN0gQbTVmQvgKzbKdM3GACW+vRVKzzks+NYR8IlXxH1IloUjqux
 0Ks9ssrD/IxsrzvABi+AQQt9azE0BbwEtW8hI8KEB8UVf0hT4GF+ftOQqIXO83IgK0KRSyY9zNj
 XBcMluejm+AvoEbg/FuqyW4VSz0YRvA3ymrTyMq4EvFQPwsvEcqH1iovcv1CiAFYj18GoUgc7ag
 9yjDppd6
X-Proofpoint-GUID: 1AcD7VgF1noPkRebc0tgmedUwPdOwrdt
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689c4e92 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=-uJ0XW9AK0pjk_nks4cA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 1AcD7VgF1noPkRebc0tgmedUwPdOwrdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 8/13/2025 12:56 PM, Krzysztof Kozlowski wrote:
> On 13/08/2025 08:38, Krishna Kurapati wrote:
>> Correct the address in usb controller node to fix the following warning:
>>
>> Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
>> format error, expected "a600000"
>>
>> Fixes: c015f76c23ac ("arm64: dts: qcom: sm8450: Fix address for usb controller node")
> 
> There is no such commit in recent next... And how is that you fix commit
> WITH THE SAME title?
> 

I sent it on top of latest linux next.

My bad. Will send a v2. I mentioned wrong title, but the correct SHA.

Thanks for pointing it out.

Regards,
Krishna,

>> Cc: stable@vger.kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202508121834.953Mvah2-lkp@intel.com/
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 2baef6869ed7..38c91c3ec787 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -5417,7 +5417,7 @@ opp-202000000 {
>>   			};
>>   		};
>>   
>> -		usb_1: usb@a6f8800 {
>> +		usb_1: usb@a600000 {
> 
> There is no such code either...
> 
>>   			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
>>   			reg = <0 0x0a600000 0 0xfc100>;
>>   			status = "disabled";
> 
> 
> Best regards,
> Krzysztof

