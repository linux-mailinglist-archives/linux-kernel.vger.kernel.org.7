Return-Path: <linux-kernel+bounces-871379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A757C0D12B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 846DD4F22E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBB2F99A6;
	Mon, 27 Oct 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpVB3hnW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AA2F60CD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563382; cv=none; b=huVIah95o3pHheLW4zLong3iJQWboRZsYC7OHBB1GziFwr0uBRmOUIfsSnNmOaVlOA63tcMPAOb2MuwHJuYNZthuPdTJEj0oKdvaakMv2Hj6QilLY14QOVA8QqymoGB6c3raFoMXbel02U7ELkQqhs5Ry339g2Vodrot2wXTOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563382; c=relaxed/simple;
	bh=/xUmcq1ujeoPIHjdvxt3xLv676PUcYJOdGzgL+X0leg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKWhjixvucHnzScPx83ZgAHUi5bDBaH3kodw38gePJv9LfeWIbM7k4j7mi8DLklU2+WVvC8L4xzG0DGMw17Jph1L6kDmiWcVgeS+uaaYYcAq7GY801S/I0WlRzzMcTK7eloPttdOLckSCP1eWlzjbop8sBn6pjPfxY4hSO/h3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpVB3hnW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R84foL2232100
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1OKEOWHV2jDS8HuQ9OUVVQMf5EtunRWIyG+g+gcxrpY=; b=SpVB3hnWbAeoJ9wZ
	tFc7is5UpBTRfm16Nn1oq21eEX04VqEEkDkbTT3Iyf/r80XbsiykH2sAcPctUP27
	VgrmhKqOTxq8rACgwt29XMf3a4W73v/7RYSNzUrS4lThnQDUm0pS6kHXe77Ge7Yq
	OpidUmIXwu/mlLWrbMWHLy0yXiOqEuG20gD7t5K4Z0dvAlE5Aohb7GoyY7UucXPW
	L3y1f3OF49Qn20vfa7tBw4fofqlCgcCf+OMPggbVnQmCDIcyAkDkmlOerjXetucz
	YNjc1waY60MCzdPjLb/480MCIYB4v5hP2hwqARkeB6yg1d22dehJq8G0gxYhYFrV
	EobTmA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wn8hjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:09:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so3857980a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761563379; x=1762168179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OKEOWHV2jDS8HuQ9OUVVQMf5EtunRWIyG+g+gcxrpY=;
        b=tahsS3X5BWZ5K9HcaBPSVX0chqcr1Ni3S5pImKN8jSQ0yF8T+GpknumZKufz95GBOK
         9phkJhYX/qCKnUEW3uynIY3JPd71z2eHod/4x/0YlvPz64L1DL8PKNQyFOQpNoPQc+eD
         lSQSxrX84sxAVXOXbIrLRmig6anqvuD2mRBHxAuStj0t9oqRRyqESFMAVcIo8Y3lUBK/
         kuWmOp6BHXeHYPWyPf9y3HQAkafip6qe0Ymd4tcLbnqOjGBZQHbcYKMRjmJP4E2agdvt
         ZT852OllA1Nsu0Yq9V5J7LWTJsE8erC7ZDo541+AIUFddgCadw07bN4FhHTwc4B+k7wC
         8O1w==
X-Forwarded-Encrypted: i=1; AJvYcCXb/4MYuqTV2zG59TawpSr7z6PyZuWtlq4YI9skWgNaDpx/DNI4+nlXhgZT+pV28qNHUbpyzU8RFvzh2EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxork2Q8i0ZJSo1lmcv0XuF065iIcRrYLRQCqqNWmVP2nOeo2pQ
	Yxe80YrA5FfTPh0+gUZ+cyOjK/CdGNhWXF3y25Vvj1+qcwadSI9y+R8lxZgZzuUvdFig6e91I34
	I+BPkizwylARBqFaYxMfUlHm8Sd/BhEzVthPn877Weszzv81oPAhU6bHr169nzPp0rZ0=
X-Gm-Gg: ASbGncsg5V3Fza9bBhl8YI24W+CRgphUWk5LLa+rlNyGG4SltR9Y3GelOJK+vsZbtsQ
	nOplfO3sldKuntMvSoOwfvTDcJY9sb0re72tjVrAfY49T4AUE0Qn6lOpAdMEu5TLlOQrDqGvaSp
	L+Z25Kblt+TM0vcpyIM8nJzM3zUE0PfOtWPio0LWKG5vhaBW8ODrLy0BrwthIgpcydNjE/QIPuq
	jkd7VMFODLKkrH3nA6XJTMl8oWmNMNboy7O1HDWD4iqMiOgN62taxXPccLZiSxjZq6SiFtQ63cc
	kZpxF56QUj0jAWbLQ177BF9nsklShHaTFb7+gy4S/yK0e0lH43wn9XqGwcHuyrZHseji4vfy7sw
	w+oeGZvgz/AcdMpcN/RYzebIRmQU=
X-Received: by 2002:a17:90b:2686:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33bcf919f1fmr50010247a91.35.1761563379213;
        Mon, 27 Oct 2025 04:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkUlEj8/wHcKODqSO/BOEax5NmnIZ4PQBlUjqIzNj2WYmI0MzR8y/WOp5byH5DLvoMAjzatw==
X-Received: by 2002:a17:90b:2686:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33bcf919f1fmr50010210a91.35.1761563378756;
        Mon, 27 Oct 2025 04:09:38 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f3aeesm8092563a91.14.2025.10.27.04.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:09:38 -0700 (PDT)
Message-ID: <1c52e759-15fd-462b-a9fd-ad620da099f5@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 16:39:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: m31-eusb2: Add runtime pm ops
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251027062458.1411096-1-prashanth.k@oss.qualcomm.com>
 <daf0055b-7caf-4ace-8a06-071468273a37@oss.qualcomm.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <daf0055b-7caf-4ace-8a06-071468273a37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=68ff52f4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1dOfxVL-wUTtPdxvxmkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: li2VGA1KQI47OLgE-QdOlTsymft_UYkQ
X-Proofpoint-ORIG-GUID: li2VGA1KQI47OLgE-QdOlTsymft_UYkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwNCBTYWx0ZWRfXyUiJcnFGokyp
 rwPEEKISPYw2fZfUDUI75uOuxmEdZz8f2kjhPYzVD7jPImLZOIZSSl4WTOWHrMEMIZUIa1XR+cQ
 aaVN5T7dlvSF9cAMXFW0PK3gkP4PLK3P9iUADgoau2eC6Iy2jCqvINwWgh+TxWIJRi14pzG9rr1
 pfdCU41N5BRmrDu1l3701tzwRCUMLhXmrkfEHVaGnH2HcJGa0yDCSvKmDm6iAZk0b91hwyOd4GR
 Y0Qr2vLTLu6VOgFwBl8k4KizpUrZLsqy2hTF3VrI06c3TB5kCd1cmvkK5liDCSEgrX48r7YA65m
 h/ht6yZmY8mj4wo/QwvqlG93PfWQ4NYTOeTw/PoFCzsg3uF2suvw82iuEMvX9+QIhFnFymLcZ1a
 TN6GhWO9SNo6pX02fztobUdLuWZ8Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270104



On 10/27/2025 1:55 PM, Konrad Dybcio wrote:
> On 10/27/25 7:24 AM, Prashanth K wrote:
>> Add runtime power management operation callbacks for M31 EUSB2 PHY.
>> Enable/disable the clocks based on the runtime suspend/resume calls.
>>
>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>  static int m31eusb2_phy_probe(struct platform_device *pdev)
>>  {
>>  	struct phy_provider *phy_provider;
>> @@ -270,6 +298,17 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
>>  		return dev_err_probe(dev, PTR_ERR(phy->clk),
>>  				     "failed to get clk\n");
>>  
>> +	dev_set_drvdata(dev, phy);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	/*
>> +	 * Prevent runtime pm from being ON by default. Users can enable
>> +	 * it using power/control in sysfs.
>> +	 */
>> +	pm_runtime_forbid(dev);
> 
> This screams "this patch is broken" or "there are bad issues" which
> you did not describe at all.
> 
> Konrad

Hi Konrad, I was followed the same sequence from other phy drivers
containing pm_ops. I assume the runtime_forbid is added to control
runtime pm from userspace.

Regards,
Prashanth K

