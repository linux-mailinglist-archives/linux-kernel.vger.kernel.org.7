Return-Path: <linux-kernel+bounces-833483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0BBA21FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6307C7A4738
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B71527B4;
	Fri, 26 Sep 2025 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH3+g1WE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26AEEBD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758848968; cv=none; b=El3IpfZT923vb1wx5dJDyDoIcsdATUOWSBkZWbcICCcqb+Gfk37Sxj68zfslctIHEBlF0hoOtmoeB/O6mCHvsPXugtFOGqnNvjzo5WSBjhlcAZY19lMinWF4Oz/xcDycIQ5CcfET216I6vjbvZxhcTsxE3v2yX1QkSk4YE0gOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758848968; c=relaxed/simple;
	bh=r53tXrc5jgiO4gQcViEs+jKgFfCrZ/4F5Ycb2Fhnec4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYkPh4PFl3d9zD18RWxyGo38ehDQNUqEdMPHY7eQs+JQfHYJjwj7KD4u6SqMLWqsKW5Ss12bY3FpGJIi72q6uLcjA2Mu19OGSi2h1aulknzpyzMbHcrGFErcZ8dEJQptIyKt6dzmmzby9hei1SKrVBb4/zPtz6VJ7Tz0AY699fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH3+g1WE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPsZX000883
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DltWIU0EvBMC6TRw17cAj1fVJR8GrOrBTSW3UTokzk4=; b=RH3+g1WEY/nh8lDP
	oSthx3aoHtK8rR+R74tfvXFo/E8R1No8IDpYvBdPlDFWui2R0zbU3cxGy9uESJzr
	YTPWsNNXZ2Jgu/KjWH2RXsQxFNYgTOewceSBv4ai/MSsTfu/IdCrpWXjFqTaSzFW
	4Q2TMTA3uOvpo0GyEFdeG3GLIfJt4k1hrxDVHKy09TvmfHqoqr6Cdfh8v+kOS0A3
	pJOVe4UudcEaqR+y3dlAXI0SI82BUc5wbTnVsZE0nF25ayyk/IgWrswNYdnNSqp3
	ceMq6OV7yxfB5Gzhhsekc0fPLF5cFueUXJyPSpDVC94F4/pESLuLzDEY5rY103ts
	S2UPUA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0truun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:09:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2202012a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758848964; x=1759453764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DltWIU0EvBMC6TRw17cAj1fVJR8GrOrBTSW3UTokzk4=;
        b=GdK8xgPcP6fWveFC1UEHfCT/eex7VzjcwHFcxDTHezmR1D8v3jykKSxAxJgHzwRfXr
         KN6DVO99zK/9e5nwEnw9g0YB9D7LG06x4CuYKFmjS+BZKKIkvifLiNMhucJOPX9GFsfA
         2zuulAuAt/6Z3zIsrbdHjFdXWng6/oN5u92XJSmLoSnveAj2gDRRvVheekBmwotaG2ck
         1q+s9s8hx+XfHtvPulTMtOQJh1xLcbepicvDo4Rtxl/NA+DpxSDlgmJxJIAjcuqmdn62
         PKsT6Jrsvp5mrNzqBexXFXuchS5jWaRodHeWa6bHayaP1vqDVnW6OMymcgkwlEoyPwjB
         KHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmq9UEb7rj8ZYyOCJU3HS/JOWrmw9OXa5Tf2uKPebwqrhVu64yewwDyK4Edi0ElyOR9EhZd/CjXok7tpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4/T3pJZIXu+davHe8XL8cB6usqVcQv/fVTI/YnqeHKL1gwTI
	ysQCOynzfUq0SR2hnHwsUCndmxAD+RBSqCwkITNLZA6vwoAR9CzFhYx+AJzmfG27x8HVhQEhApJ
	F5oQB026YDiFBfgFmEvm9D3Bv3JgrWBtTZsImrVYDXC5rRhlU1P6cXrIN1IoT7XbOVx0=
X-Gm-Gg: ASbGncumMkRbRi1Fix4PNLxYfCj1r20QKwoO7Lt0o/kzLqEF8MTtgpiQ3FwsnXrtYUW
	qwVq2YLkTEhgBzaBV/vKSQsG5onSZ+B0JJpdFaW++kF6RrFbOqniNYyRkYoomvk8l8YZ/5R1IpV
	9nqBMDtJtdggv6z/J9LJhruovAH9rFm98HbpEORQo6wWceb67P8MLopIuvVQ1mAgw4kB8Cpv22o
	vXU5W+WY2BPM1xl5rA8CYWPDpuQtfCKXsusHOjmbmkY4O91r9u7Wta9hniChTnDEDno83D0Ob8u
	h4bVVHudbqRHY6ZiJxsyUZ1BUG+4EVLQ9ZYaAkAetIgUyQYY7vi4O+VOnUPPpNP+1tfdWuLpTzo
	vEM8Aezs=
X-Received: by 2002:a17:903:1983:b0:24e:95bb:88b1 with SMTP id d9443c01a7336-27ed4a5a871mr55646045ad.34.1758848964255;
        Thu, 25 Sep 2025 18:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECOycQ6vKg034cdLVh9hclHCCz1rE/ItIEpfU+ohxFrptWNw6FnBMNm38y7E5EAEaGlTEbwg==
X-Received: by 2002:a17:903:1983:b0:24e:95bb:88b1 with SMTP id d9443c01a7336-27ed4a5a871mr55645805ad.34.1758848963732;
        Thu, 25 Sep 2025 18:09:23 -0700 (PDT)
Received: from [10.73.53.199] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671e93asm37367225ad.57.2025.09.25.18.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 18:09:23 -0700 (PDT)
Message-ID: <2c576766-bff2-27ab-2805-298a9d743b09@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 18:09:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 23/24] arm64: dts: qcom: glymur: Add USB support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <66a5084e-3f7a-452d-ad5b-5867528f57a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d5e7c5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YnZyo49zVung00aZBBAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 1Zd7cUF5IP6fxYKLnjWygyFJjbW06KdL
X-Proofpoint-ORIG-GUID: 1Zd7cUF5IP6fxYKLnjWygyFJjbW06KdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX1rgGr3Rk+nNt
 1YSOIJGf5K5d6nwC/MiWF9YpyHMb3RvRg3Hz0hhE4hG65kL3FMUAV4jXB6exTXUqiI9elaEsDa1
 sx3Exge6slngUH9lmQd1ruo5lpl6J9v3z1cEdq8RUYuaVyQ+12VeyGRQ7SZyj3I/7+j8sVnoCnu
 ox6LfPAnaeFdVcLTDGufEt9N6Eo3dbKxI37u/AlXUPs5kRdYbBT018NfzNRLYkXYrLsZq7eq/BT
 vgtjbgP8jxJuGMcj6ZEuJMZ1MuhrQB62MxmPZiX8mpzB6rapNkLM5RC0eTZ7WAdV9BPK7lsSEnK
 Xd9Oko0SKuDd+AYbDrUene9sNqucvAdcr2WlSz0QJkxDTFJ0HL1yYDwf/8jyr6t7TJVJBCJtvZu
 70eYkbYkR8hkDRFjiKjCCrg0FXuofg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/25/2025 3:59 AM, Konrad Dybcio wrote:
> On 9/25/25 12:54 PM, Abel Vesa wrote:
>> On 25-09-25 11:58:29, Pankaj Patil wrote:
>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>
>>> The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
>>> controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
>>> M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
>>> flattened DWC3 QCOM design.
>>>
>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>> ---
> 
> [...]
> 
>>> +
>>> +		usb_1_ss0: usb@a600000 {
>>
>> This is usb_1_ss0, but then you have usb1_ss1 ?
> 
> I'm in favor of just calling it USB0/1/2/MP/HS because that's what it is..
> 

I never really understood why we have:
usb_1_ss0_hsphy
usb_1_ss0_qmpphy

usb_1_ss1_hsphy
usb_1_ss1_qmpphy
...

Not sure why we have the usb_1* tag for the primary and secondary PHYs. 
I think it'd be simpler to just do what Konrad mentioned:

usb0_hsphy0
usb0_qmpphy0
usb1_hsphy0
usb1_qmpphy0
usb2_hsphy0
usb2_qmpphy0
usb_mp_hsphy0
usb_mp_hsphy1
usb_mp_qmpphy0
usb_mp_qmphy1

then controllers can be

usb_0_ss
usb_1_ss
usb_2_ss
usb_mp

Thanks
Wesley Cheng

> [...]
> 
>>> +			dr_mode = "peripheral";
>>> +
>>> +			status = "disabled";
>>
>> So you have the glue defined above, but not the actual controller (compatible snps,dwc3) ?
>>
>> I don't see how this would work.
>>
>> Same for all other controllers.
> 
> good morning!
> 
> 6e762f7b8edc ("dt-bindings: usb: Introduce qcom,snps-dwc3")
> 
> Konrad

