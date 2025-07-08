Return-Path: <linux-kernel+bounces-721561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D08AFCAE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A137A4A60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A861E5B91;
	Tue,  8 Jul 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvHyUo0+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F817A2E0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978980; cv=none; b=FaQmezdKrxkyUhnjAKN/bg0Z0+0XgJTFVgKICrTgL3MMaZl4LnN3OPQ8vsPckYwdk+OEgBvP1NZmuITicd/JPiVBEH3gVZGtLkDvhRKDBf3Za2UDFGHQCvpV5FMwJHTZM4eTPzLA8dgVYvmMzjhfALpzsTgrFzCfex2mMAVTYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978980; c=relaxed/simple;
	bh=4AW6PFJFfUOodYzIiSEYhLXKdLBz08KZt5fa7t3j9Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cahyZXCvSqmLdIZfmmX7mTECF2Wruu9jEds/xKDBvBAahjwnvqQoWoeXFtzlznFUtuWVFc2pbwiW3s7DCnf4o+WniEwYvrJ74R2qKA5BSx+KOWCULp8bOMlRuKcEh7V/wlQj6iK02pghtE2Om5tHfBL+YVVkp4uFqc+Y2yh/oB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvHyUo0+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAbKU017134
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 12:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C8qpSE5Dp43vB7gI5CagfdGXu5JUEx9y9sp3Qv7cISc=; b=OvHyUo0+o9sR/S1y
	n88x2gBixdRl2x7IfHx8Ve2Ufm3krpi0Z9h++eP6r6aKf+cHxIo6JLAxKWVOUzHP
	Errn+bqQ5B39wXbkCT4RrUokbuMN9ohlEMVnwvRVOB+l31DcZ0XVxvt5OeYvwWfA
	4pif5yRvx0IJaWnRkuc6zzNhjY/1N4BNpdGAj2+4GFYWW7oiOTdSFWaQzcSWaK0b
	HZpjv172WbP3TFwAlKrF83x29lTWj79CbAWJhbnaL/ZEj04sZq5S0C2rWZSiWC8u
	fWUzv07sylGJZDnxviWlWhD73Uzro0KC6FIGn7n9l0viXWPNoP8K2W1rmJbjxtqs
	M0KvIA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkn3k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:49:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7cfb7ee97c5so23914585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978976; x=1752583776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8qpSE5Dp43vB7gI5CagfdGXu5JUEx9y9sp3Qv7cISc=;
        b=wOIrQ71O5F2+Xf497wCgdchWqcvyUTv771W6s4QBrOU+Qetqw4xIsHFtTaiRo5Gke+
         9gH5uEFXpp9PTWhLRNH+zhGyvGxszmbdfKBIwr0e7D5P2z+bLfZh0b35y1/3TLrw9HLw
         3s1ztKmyzHL01euUyZeQQF7cbzHnVdZB5nMA32H9CjhuwgPiRRZimMZ0D66EtH1GkLQf
         tiwCuUhEYytHYcSKIDWRD6f+xe+ohANZcIWaiTT1CBvTlBIPrqhanyQu+atzkD0JvRT2
         hAqqAofw6bDRHR9vPQzjzJ9Cwth0fw47He+SiIcnR2uC1VpWKJ/EHzdHv3rmHP625GRe
         ouJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCzu/ieHcWGy2BzX66RtXxjTE48oUNKIiEmGyERmYJCnKqAnhtYOlPyv/yApDkvhgvZSkJsT23HGCPA+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgslIOB6LnDo2cBVlmy91GhOKQfqiMILzngpdQKzFY8vS9L2V
	Iwga3gZZFbSRdvDbMWAMRIbUkI9v19usjFdSAe2AQOldVJ8W/LBZ2zrVkyhzDp8I0zysUrkDmyH
	h7NueGP9vhicNSQCtmDC/GX0K6EiR8Yp+FnbSUjLXP5C/TZGMAy50oSxp9t5BaLkl03Q=
X-Gm-Gg: ASbGncv+uoLnii2qxueXOJO/RgCM9oJFjEWe3bJbegq9nqK4yHs/icVv7IIKA4ohng2
	iP5CJbyTCUyqrJbsPbaI1D2MkoywlUFt8rMO9RnyUKLWz51BpxHGcO35Qp9WNHqC8TwGPlzL3Ks
	Zg04H4GIjJBOn0r3zSX38JwbA/OYlGft2jFRWC5aief7qAWIo71kYuJPkuDTcLhv5Oo4aClhL0P
	HN0Pg7By0l3+Ra2pWujnjzw4DE2bIVjJh6dq4BQLB9Pc9FaX/W7w2O+S3hqUttjt0VBpB+W7Csn
	lnr/92clw7xgbIPhMgb0TU6gH/mwzBNySsw+1lXlGXwtHiaIgCcyci+yoT5t2/EaoYM3zvaI5ar
	lj/I=
X-Received: by 2002:a05:620a:1917:b0:7c5:e283:7d0f with SMTP id af79cd13be357-7d5ddb97e46mr895461485a.8.1751978976067;
        Tue, 08 Jul 2025 05:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI6CfY3miyqntHnZERAiMI/kNZtHr4A2Levt+Sm8OKvM/VpGtLtGOUwmLsoioV5Au5XaqNhA==
X-Received: by 2002:a05:620a:1917:b0:7c5:e283:7d0f with SMTP id af79cd13be357-7d5ddb97e46mr895459885a.8.1751978975628;
        Tue, 08 Jul 2025 05:49:35 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae40eaef0a4sm684728966b.170.2025.07.08.05.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:49:35 -0700 (PDT)
Message-ID: <ffaa75f3-8b24-4e36-8632-62bcc47ed568@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 14:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
 <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
 <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>
 <DB6OK61BL9ZS.31XB5TN5YTX62@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DB6OK61BL9ZS.31XB5TN5YTX62@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwNiBTYWx0ZWRfX8zIQ9lPcRu8C
 1cmvelvjOta7O9vxQ6UP4ofHJP1eOK2Wp9c5bhHdQlOyth5xMFwD3wC3xoAJ4nGiDFEwnEF6XSJ
 DCsAfXkN58xXs8sSPXdt3YoF2CPibPu1WBW42z8QqG3FZuDZEV/lrAuobp+h8uiqZqIZh9rhgl/
 TFHSC8B4Cc8NFL0h7PWqvvNtiAKsksKMRX6+XDX2/CysjgnD4g8YJcQzFHvbqtlr+0ELHrWo9s+
 lYY1uKQHNHkNYbV9HY+FBg83HdZZbroiFLDBqzSOldWZMiTtNRk7wBCfWkM7j1dG3L1HonNVovA
 WPZ9MemTTRgQ/BxBswhjlOGgcpuagya/G9zEUsk9vl//NX/3bE24YkXdPY17tE+WOCT8fIXFSB5
 G16Cn66f+Oaln6CKqebqfVY1ltVeRYTtkihhlMqrmHcIDAOOl3af6+GqAiRg1zyRFKnuewxS
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686d13e1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=mLgVev9gNyKCqetQLd4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 1V6cqDCCRIl7h2UF85h4E5bQaz0XLybo
X-Proofpoint-GUID: 1V6cqDCCRIl7h2UF85h4E5bQaz0XLybo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080106

On 7/8/25 2:42 PM, Luca Weiss wrote:
> On Tue Jul 8, 2025 at 1:30 PM CEST, Konrad Dybcio wrote:
>> On 7/8/25 12:20 PM, Luca Weiss wrote:
>>> Add driver for the Qualcomm interconnect buses found in Milos based
>>> platforms. The topology consists of several NoCs that are controlled by
>>> a remote processor that collects the aggregated bandwidth for each
>>> master-slave pairs.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> [...]
>>
>>> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
>>> +};
>>
>> You can remove the empty bcm arrays and .(num_)bcms assignments
>> for them
> 
> Sure!
> 
>>
>> [...]
>>
>>> +static const struct of_device_id qnoc_of_match[] = {
>>> +	{ .compatible = "qcom,milos-aggre1-noc", .data = &milos_aggre1_noc},
>>> +	{ .compatible = "qcom,milos-aggre2-noc", .data = &milos_aggre2_noc},
>>> +	{ .compatible = "qcom,milos-clk-virt", .data = &milos_clk_virt},
>>> +	{ .compatible = "qcom,milos-cnoc-cfg", .data = &milos_cnoc_cfg},
>>> +	{ .compatible = "qcom,milos-cnoc-main", .data = &milos_cnoc_main},
>>> +	{ .compatible = "qcom,milos-gem-noc", .data = &milos_gem_noc},
>>> +	{ .compatible = "qcom,milos-lpass-ag-noc", .data = &milos_lpass_ag_noc},
>>> +	{ .compatible = "qcom,milos-mc-virt", .data = &milos_mc_virt},
>>> +	{ .compatible = "qcom,milos-mmss-noc", .data = &milos_mmss_noc},
>>> +	{ .compatible = "qcom,milos-nsp-noc", .data = &milos_nsp_noc},
>>> +	{ .compatible = "qcom,milos-pcie-anoc", .data = &milos_pcie_anoc},
>>> +	{ .compatible = "qcom,milos-system-noc", .data = &milos_system_noc},
>>> +	{ }
>>
>> a space before '}' would be neat
> 
> There is a space :)

Alright, before all the ones that clash with a letter ;)

> 
>>
>> Konrad
>>
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>>> +
>>> +static struct platform_driver qnoc_driver = {
>>> +	.probe = qcom_icc_rpmh_probe,
>>> +	.remove = qcom_icc_rpmh_remove,
>>> +	.driver = {
>>> +		.name = "qnoc-milos",
>>> +		.of_match_table = qnoc_of_match,
>>> +		.sync_state = icc_sync_state,
>>
>> Are there any issues with sync_state? (hopefully not)
> 
> Don't think so, I don't see any sync_state pending warnings in dmesg so
> I assume it's 'synced'? Anything I should look out for in particular?

Boot failures.. stemming from not describing resources for peripherals
that use them. But if you're not seeing any, that's fabulous.

> 
> Also since it looks like I'll anyways send a v3, I've already ported the
> QoS settings, and don't think I'm seeing any issues booting up with
> that. So I'll include it with v3.

Great, thank you

Konrad

