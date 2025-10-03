Return-Path: <linux-kernel+bounces-841129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BCBBB6535
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C893A823F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA92882D3;
	Fri,  3 Oct 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mf1ynVAR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867282882B8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482607; cv=none; b=ViBIVY71K+RjaAF8v35D+jUPklRaqLTAZqP8x0Dy9dTkeAvUH0txZeinLwjG5U3/VDMfkB3gCZwyUvZ34+no3lj+M2bMfWrbKE2JPMLSFHh5QijhqLGWMpDQZwSvXKaKrp6W+vSup/YB3mejv1U9ssaZnheROIaHdR1t0469Qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482607; c=relaxed/simple;
	bh=g+UyabP7D/WYt51zePGNa1iOGkEPveNswKAW4d9GM9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGJ261qBrwSO6lCiUX5OG+XVjGnK4E/mlruTy6m7UuJn+Xrlu3XBCud3ZJaHJWXlB6YDSnrDEIBrpczJ/xr3I8C7Q0izmr1wP5It3w8AwSjmqXnCnr3TfXbrdRA0hsiQQDz7UWzZC1gG7p3DZ5KtxFP2HkxcrISB0KHQ2ds8KlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mf1ynVAR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592MwoHG023326
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 09:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9G+ZsHAD1n3qGPEQOvfOjFGqmrOTP8PC0DMNouciob8=; b=Mf1ynVARGjaPpLa1
	RcUrlPuW2pYAkB77JOlTBVI9k6BXS1qOrKy1Y5TB3Knh8jptEB8tDfRq9QlMWwXp
	NQtyc7ek0v8IbWI+ew3enhe5Z0f0zrhIbrSZCLpaN2SQVXpKzlXzRuy6iASBIxCg
	WnYBCd1zFAwGwzx6e/zGcE00q915QzeJugs6NsmMJiCi6s24s6Io/AR6P8/7Ovlc
	PAvQbwKOzHUL+afjaCNa3y1AWQtnjCI8IhSz+coyCD8gntboN0F090Yl9YEheXPf
	e8F7KfcbTIDmtz7B9NO1cLMwfw+kdyBE3kqIy0/W1uqogE8j3kyHGP8zvmGwaOH5
	qnbmRA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a6ac41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:10:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b554fdd710bso1352068a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482603; x=1760087403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9G+ZsHAD1n3qGPEQOvfOjFGqmrOTP8PC0DMNouciob8=;
        b=qCAN/IYgUw8t6DNGEtDlLBEOACKUlVxyYdmBZkhr0lqLQ1SX+xcp3UDe3o9kN/SWjt
         EvJEmw7MigN9giJzCz+eTwSUp4pmx91ybjuMWiw7+HboiwQ8+OZZjfhxxdAkrqqjYikG
         crBE0Q1L+GrwrP7bgNq2G8scVnqTyWDg6CpQvVTDu/2lAzNWtPL5xSQzRLuk/3KPYIZE
         vewcCozB7n+5muTQp/0oXkmgE28td61Q0ESQCuCk0mX7lC9SVhZgwXeKxIDZj7TatQww
         7ClHoW0eb/nX2B/lv8kRofvhBefRbYUfGVtEQ/7MsDkAdPiT9nTjGc+3B/ew3IwigmrV
         3+5w==
X-Forwarded-Encrypted: i=1; AJvYcCW4EFm8PjPWXfVsJvkIZt4YvjhHm+ZoquDWlI1EXzjPnsDpwI3LMY8IwsJstK9136c00BXif2DMwkSYiZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqDPtrYReT4gqwrUdf+lS7WP2tCfSB3lSmBa6uMj898tN5gJs
	/5imHWYFoCffWXPqTKBHJaM8j9rba13drsmSe5qpptv9dZK8TdZ5qQosjbhErpcgliWuOXPbxBQ
	1Pd+bwqsvg2MFs2teNhgMkU9ci2gZvR0UMzYWJIbzaFoszhST9VzzZ0dGqDiOIYHYjs0=
X-Gm-Gg: ASbGncscgM7xzzi3qzCBOHZ7CE1PxHW0GO608YVh/9lSxqoXr4C6zDpGKNPtpBE+gy+
	CnlaUus2iuzHr2BiLjZo9rOxejKnaKziNGxB8CUphVv5CKRtYvoXJQpFPg5Dgxma6XCuIAE08oL
	o54G6p+kPfQT9faabTbJlCCPe5dYvv30lVK8Jn9rCd2NHYueOt2BvNynQNrLMcJcQUkLmH8FCl1
	mTZO8FtWWjlG4hgLKo3P9QxXOA8sBRsqfhedAeOT5leT4+3yjPgPrSJI1gyjPMe8WIkmu73S1is
	XABdxms9Ce7LD4qfudvrp2yo2AgxqhgtZLmpgReo7Yvb2gabINTxqwgnk39pHoaq8699YPPsKuA
	3QXY=
X-Received: by 2002:a17:903:3c70:b0:269:ae5a:e32b with SMTP id d9443c01a7336-28e9a5668e1mr30170475ad.13.1759482602885;
        Fri, 03 Oct 2025 02:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED/ngo+VR5SYkELB9gRDWFieCrqK8UHsEA2FB7sm98eH67+OUnQaYh4ScjWZbBPm9CWIZQ8w==
X-Received: by 2002:a17:903:3c70:b0:269:ae5a:e32b with SMTP id d9443c01a7336-28e9a5668e1mr30170065ad.13.1759482602391;
        Fri, 03 Oct 2025 02:10:02 -0700 (PDT)
Received: from [10.219.49.214] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1dc168sm44215525ad.120.2025.10.03.02.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:10:01 -0700 (PDT)
Message-ID: <58a69bdd-f26e-4cc2-bbe2-6e9d5bb69aa0@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 14:39:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] arm64: dts: qcom: Introduce Kaanapali platform
 device tree
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manish Pandey <manish.pandey@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <DD6BOLBXKBYP.2NVXRXGJ9W3IG@linaro.org>
Content-Language: en-US
From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
In-Reply-To: <DD6BOLBXKBYP.2NVXRXGJ9W3IG@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68df92ec cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=k2UVWlRvf9iVtZTx9S8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 1T3zg2YPUoeIoSMiHHsUWdYT2IyfvWAP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX2pyJ1Ei8WVOe
 eY11suK8PPwJ36ZL+BIgABToKxc9r+Fm3/QxW0Z6R0nOqkhezDMF8DcEznLXCaOKiLkoDMih2q+
 mULWiIjkPrOWDT/JiO+H8Nsz6gqUs32yqyG5AJOXTMwfGwMuAniKPZ5q+afs/pEUyXDhrCPo/jN
 Y59DWEWCEGZ+LJcT1wfeAgkTTNAkg7Us73nHj19UtP+Axt7cje5jk1eJ3AEksA5RpXn7IVraJ/N
 NlI5FOb7QLXKPslupd1pULwGSGLEsBHiJ5zh2quq1Br8e8PoaK2rasswX3E867Le4eWH7KMFoQY
 ApCAtYMVy40WDOCa6sOJYuwnZ5IdY/xwza0XHo/xoviWSq8TpKC4Al1vUff6Q/3zVPZpVxh/iZ/
 eaEWHVrkAJnsfjW9hDqT3Tn5BL16Zw==
X-Proofpoint-ORIG-GUID: 1T3zg2YPUoeIoSMiHHsUWdYT2IyfvWAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033


On 9/30/2025 11:18 PM, Alexey Klimov wrote:
> On Thu Sep 25, 2025 at 1:17 AM BST, Jingyi Wang wrote:
>> Introduce the Device Tree for the recently announced Snapdragon SoC from Qualcomm:
>> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
>>
>> Bindings and base Device Tree for the Kaanapali SoC, MTP (Mobile Test Platform)
>> and QRD (Qualcommm Reference Device) are splited in three:
>>
>> - 1-3: MTP board boot-to-shell with basic function.
>> - 4-16: More feature including PCIE, sdcard, usb, DSPs, PMIC related, tsense, bus, crypto etc. Add QRD board support.
>> - 17-20: Multimedia features including audio, video and camss.
>>
>> Features added and enabled:
>> - CPUs with PSCI idle states and cpufreq
>> - Interrupt-controller with PDC wakeup support
>> - Timers, TCSR Clock Controllers
>> - Reserved Shared memory
>> - GCC and RPMHCC
>> - TLMM
>> - Interconnect with CPU BWMONs
>> - QuP with uart
>> - SMMU
>> - RPMHPD and regulator
>> - UFS with inline crypto engine (ICE)
>> - LLCC
>> - Watchdog
>> - cDSP, aDSP with SMP2P and fastrpc
>> - BUS with I2C and SPI
>> - USB2/USB3
>> - Modem(see crash after bring up)
>> - SoCCP
>> - SDHCI
>> - random number generator (RNG) and Qcrypto
>> - tsens
>> - PCIE
>> - coresight
>> - Bluetooth
>> - WLAN
>> - Audio
> Were everything described as audio enabled and tested? As far as I was aware
> some devices required some soundwire rework to support soundwire microphones.
> Is it finished? I don't see this linked here, but you state that audio
> features "added and enabled".
>
> Do we understand this correctly that, I presume, everthing that is more-or-less compatible
> with previous platforms were added and enabled (with renames) but not _all_ ?
>
> Probably some rewording is required.

No, As outlined in the commit message, validation was performed on the 
Kaanapali-MTP platform having
WSA8845 and On board Microphones(Mic Bias supply from WCD939x) , and 
there is no SoundWire
microphones support on this MTP platform.

Thanks,
Prasad

>
> Best regards,
> Alexey
>

