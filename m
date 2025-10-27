Return-Path: <linux-kernel+bounces-870749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75811C0B964
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 587764E914F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9525785D;
	Mon, 27 Oct 2025 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGo1ncHI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA023BF9B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527747; cv=none; b=B9+hPSE1CZMq/tDN0nc968k656Qai0ZY8TI5QYn2uy96LfHs8MTyGj30XJ9havpGxDW4lct6S+pbtgRkUpHZ4ZnWalOBppKObOCoVLIP4ZFyp+XnLRBA38ShhkyAVSpS6SqdO2oOHdttU49TqI2V3Nwwx1FwIVCo9Cjd4mWxsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527747; c=relaxed/simple;
	bh=t93Yp8RmSB0G1hSO4EL81AtKN9KA+9xMA+XdWUMYetE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LY8OdYjUC59I/hutpVYNlbRAThQvUKDzto5J1LWWfQOrgmn0iyuca6For2CRAb5R8WPu+ohtHf+Xt3bNLV18rEgh1hEDch5AO3Gb4qYM6hGv2Ai7K6AcEt/1oCGTLKad3exguDuYgxpeVQ0Gj+/gnmlk7b+5QTgU62lNAlosssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGo1ncHI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R00FKe1135341
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q+7a7BdSUX1H4XYC5sftPvUND0oWh/62HBMHDzpCxI4=; b=iGo1ncHIQF3TKNPv
	+ru2TcdU/qQ8oHm/ajlDPxfKBc8QB9mWMKotQ1skrldzEVH+G6Mykk+HqSC6cQtp
	Kv4Mko9pN3cZduZ/jEWAQ18vkpWA2lVizoz9Hjs5fApu/DRRY5Lnsn1Xs7TFk/Uo
	DT89urDTRXH6CmBuvsLPgtPjRsrMoqi33/49LbWLhpy9EY6Xsy/cwSqYeYeH9P/H
	eu+KoYXltw0bLi9GrY9Z7+gfAYC44DgoHfsX74i5ZFBoQruwp9ErukByfsWRAKMe
	IHLws87FHva2+sTfSKgP1wto2sSZqOqwiyicsv4HzfqaTQBaxcUMg3NLrxYyd0X/
	7XMNIA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g2tku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:15:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78105c10afdso3430942b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761527744; x=1762132544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+7a7BdSUX1H4XYC5sftPvUND0oWh/62HBMHDzpCxI4=;
        b=mhJs7AfpnhRKGgfaP0ia1Fzg7k3UffQ3jURmPP0eDgcbWhge4ixe/M1pbXtECHtcok
         j0Ok/kRvPKBxqykZx73wGGch6Dvhq6oR520bzN7XnjsDYAUMnqP7biCjvN1rn8o+tsj7
         Vpt0v9qpAVdnZbXee6pmZde3wAVA8zujN6wZgTsaQydoMsjKfLj4TOkpXQrYb626XqvJ
         Lopd5nDqB95aa7aOX0gNtCdXDyaN9Z6kjgjdb+fo8bgDdInmtC33BSyfouWOwY8Gx2Ge
         vLhsI9Ant57+eMZyP2BVvXTJekX0tzpXyb0nn0nR/Gb60rz+Brr057PZ27+RoOSyroJe
         zSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW49LOdp6O9fKOqHhWnZY6nRawAe4iAMwa+eqgmxBvxrynQgIv7X4MchZM4hBCzqPSmHlBd1dRqcjh7rMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxLuVKe1EiV6oOsUA0QeNFk+EHu3vk/a759696LrZRwNzQ97P
	/8RDcH+gM+ez7NMoFq7Ga+DHmPbASNJkVMr4JhsAFb1Eh5jl4jJ7Runq9d84WZ5gdxeN2VqVRz0
	mcv1h/7vK1c+trX5ZBlzPs3EREPxdrWq9+ObFoSjvEQLDtEdzpXXO6qPmKdVxtj4Mvrs=
X-Gm-Gg: ASbGncuHOoy5KpYOk1F2hRCMAuixZdogAsgfb64xdelWJFnO4Y/bRk32Rwf+z08sg3X
	2l4xWgWeBj7ixc5E2bDyuFQGzbh4EZJ4JXyEX91hOPfxcKIhw5Ge8kewygwnRom3e6SeJoGEQhN
	W2InJj6Y8QiOwR8c5HJZYjjUXZw0mlyGVbpkK6bj/tly7SG3fngyycG53DDlQcxHcqWHjhmmEns
	KYBCWD4e5k4waFHNiA9uYuHkkkIZpZwXHSE0KZwHldPT3bWOFEFIc0LqBIoo5C8/3DvgX9T/UIm
	um92NjY6xm/7+UYVK6moe2mq9N3xPdK7f3pWVii9j3UiqwHGIZ+9IeSFxn5idqezijea/P/S7lT
	+eXUts3MbOTU/z79bfFKekZuLhl/rzyu+oynzgsvBZoR6btSHJ+WC6vA9cipkplcG
X-Received: by 2002:a05:6a20:918c:b0:334:9bbd:39c7 with SMTP id adf61e73a8af0-33deb36ec75mr12023894637.51.1761527743997;
        Sun, 26 Oct 2025 18:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvB8qqyzh0X9NyroUn58B+zjJ+gl/No1zjTrW0lEw1jH8sE1qhiGkm3tGhFUWui+5c86exCw==
X-Received: by 2002:a05:6a20:918c:b0:334:9bbd:39c7 with SMTP id adf61e73a8af0-33deb36ec75mr12023852637.51.1761527743538;
        Sun, 26 Oct 2025 18:15:43 -0700 (PDT)
Received: from [10.133.33.212] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bf4sm6220585b3a.1.2025.10.26.18.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 18:15:43 -0700 (PDT)
Message-ID: <bcaffc33-851c-4b73-add3-affe864414ed@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:15:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Enable CTCU device for QCS8300
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>
References: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BI0N6b_y2v2bqN0Bf-6mH61Ej-55bJ2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAwOSBTYWx0ZWRfX9EKTh9J9Kdk7
 MXgptZkYed2u78UN5uEqmR/1vJzgjfXG5eVGN6KQqfF6T28RYyKl0bdP7TIMWV3q+JEwnUA5Dhw
 NuEW/PJj2bleM7Duu/pSS3gh3xVgY98SCKjXUtVRoEFCZhrVeacGJGZVMFeyfqpDkVS4+duDRWS
 su1LIscNP/UV04VzMQcKJ/cyw1Pt0vOM5TCk6LA4QfNUB6+u1bqQSDcmN1U6XrUFe1k5vWBlp2c
 0PQk7YSXFE8vKaXEff91U0I8yMuNaofD1l1Vp+Fuk3uFR36l2lS1EoDvDPI5btusv9I5hI59I2l
 SgOu4O+oOyAAF07cgxZmzRMwBqh6r0qeP5gVREPbEMdeoGxdgkSC+hAvPJFN0oSlDEXMV0WsnBG
 hyIhxHrly6L69igirV9LY7lRAaxuCg==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68fec7c0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fSwdLtKwHKkDrnzOdDIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: BI0N6b_y2v2bqN0Bf-6mH61Ej-55bJ2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270009



On 10/13/2025 4:34 PM, Jie Gan wrote:
> Hi Suzuki, Mike, James, Rob
> 
> Can you please help to review the dt patches? The dt maintainer needs
> your comment before apply this patch series.
> 
> Thanks a lot
> 

Gentle reminder.

Thanks
Jie

> Enable CTCU device for QCS8300 platform. Add a fallback mechnasim in binding to utilize
> the compitable of the SA8775p platform becuase the CTCU for QCS8300 shares same
> configurations as SA8775p platform.
> 
> Changes in V3:
> 1. rebased on tag next-20251010
> Link to V2 - https://lore.kernel.org/all/20250624095905.7609-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Add Krzysztof's R-B tag for dt-binding patch.
> 2. Add Konrad's Acked-by tag for dt patch.
> 3. Rebased on tag next-20250623.
> 4. Missed email addresses for coresight's maintainers in V1, loop them.
> Link to V1 - https://lore.kernel.org/all/20250327024943.3502313-1-jie.gan@oss.qualcomm.com/
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
> Jie Gan (2):
>        dt-bindings: arm: add CTCU device for QCS8300
>        arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
> 
>   .../bindings/arm/qcom,coresight-ctcu.yaml          |   9 +-
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 153 +++++++++++++++++++++
>   2 files changed, 160 insertions(+), 2 deletions(-)
> ---
> base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
> change-id: 20251013-enable-ctcu-for-qcs8300-ec83661e5acd
> 
> Best regards,


