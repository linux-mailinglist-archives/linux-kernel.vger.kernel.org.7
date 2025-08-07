Return-Path: <linux-kernel+bounces-759106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF8B1D88A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDBC7AD1EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7102594B9;
	Thu,  7 Aug 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTIiN6OK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559521CA0D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571969; cv=none; b=d37K2KiTjRe2eXQjmULfwNQkMc7lE0Vo464tVulsfE2y/usnT/a/1QdjxoW5SCR0Khj6twFvUDygWAVvc1/LjPhVf/nSTwSTkQhTTOSt244lEtmHpqFZrmTC66P72XTWRKUAI6MxEVe+MhaAACUnIuoj1yPe4nxcveqeQbVdo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571969; c=relaxed/simple;
	bh=YhkaZWRCFgO5FeHJ2OKKrnXnUc1X6v1ryYXb+OKrIJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Od3qI9H31fAq8x0kFX1Irvj0BzYnvDE/ZLFSaLBNhfI9HB6WDdO/U8QhXKClfZS/fS/VREp474VeLPXAbdlUSXsLNQzMdJRydaj21Z4TR9DhobbkoUW076FpA/NCcbb+DmDK/gP2vvGA7RAyxhwbrTBUa0PaQJ7CqWjVGb2MaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTIiN6OK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DCqp001947
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 13:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FBcHHZfiUOp++mqWXUPK8pryPqtEB0VS2HuB1/078ss=; b=DTIiN6OKDoIjOaO4
	OC8rpTbQGvguholN17OtKg2iqya2D/ELG3j6EOXCe7rwcyImk7mx5OvoPnJCTB1W
	jYG06ZuobdmqDG3RUdRuuFa8Aa4azYMIrYM6WkOR2SlVpibF1gSZ44bC70csptE8
	i1X4/msKGunDC/4xb78WafOpfYasd/80ViVJGd/R52Cn3KswxwECiTBuph2/+Zrd
	EdsivZD166b58WKRT9lbjT1bUeNZJuiAhjZkBocVo9P8B4GZgFR8ksoklSmGLu1P
	Rp7y+DjzgOSwzsyq7lgiiS+1NQtALd8iElw2Jn1qoX+YYdnypwyzkPZ8i9GtG1HA
	MiWfoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw36ah3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:06:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af23052fb8so1540581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754571966; x=1755176766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBcHHZfiUOp++mqWXUPK8pryPqtEB0VS2HuB1/078ss=;
        b=I2kZgrqxbcLCObTzfBmsireHUX7vATO/MSor3hYvVUdVtSbCddX4qrpUT27HaObjho
         VR6qjc8EWFLX6dls/Mvi+/S5Y3osclOr2sdWszOKCGyEjNtRnFAEbtf3PlGyxOh+TP57
         AivFHdIpmSVsBANQqWaOcTnoI68cw58tW4s/GvNjAeDeFchAzffW97wwtCgkWy8qqDak
         51LH2mIExd4loAwsaefi5I/s02kA3QnQhENdgwuVmnXE3XZZgre4xJiDAqDUcnmzrFRA
         8VJXjD8smpQadbbd0v7ZgTNEhtRIAu6+q3C4qzDyi/9KWE5hoRgeZQRmYNHW6MBvdDip
         Mm5w==
X-Forwarded-Encrypted: i=1; AJvYcCU62jJYWc8uDk3GZnk3aluKma3G2A+mtRJ661byPe0afLUQc1xFqHDG/k8i2ynJI/tCanYbNcSiyt1Ot1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2+ALHumasgpg3JJR0EYu8Nbc8SfvbLsjWR1H5FsYUiFjyb0q
	7Wg2Ov/9FAxlFHvR5QB3AJngLlQNsWtK1n83UiwlxXod6uH0Q5QJvZ9O5ofXFb6WzyxQYgt0wic
	8ctdl61Zv10qW89kcNiy5xeE3sEVLgCtXbvDRmQG2hekyZFGf5aLpVIJxu0RUgD313JrjzSCXpg
	Q=
X-Gm-Gg: ASbGncs2n5y4gPz7ShZfbqNL4/CFgZIl8RxsdnCU9WCaawvx0QzokHaC5t/4Tc+moLQ
	2M2ndHSUnAyWMSevX+IEaqUyatVAtOnWi0fNLE+l/I9Oypl5vmeMpnVIKcd+kx2+vIXJZlWmhRC
	mjo2Zsj5/fRMe/fvHtt26Mgv16yLFctMSzip8cRc3ugbyDzr8BHtak/hyfnMnU/jLfWQXZZmPGQ
	RekALrNvv+w3zZk/0zYuuvRnUHQQTjLEXgvprjZL0+O6/njRDI1UA6JJDufo3azQAtOJe9rT0fs
	pEWWROpHxO7A4EqTEVYplKrUVJsVHa6rUvg7vXWVjcpVtsNZKW20e5Cr6/ewE2Cczm3qv2pn56D
	OkdqA15hYqt5WVUST/w==
X-Received: by 2002:a05:622a:1482:b0:4a9:e46d:ca65 with SMTP id d75a77b69052e-4b0912cb849mr59963641cf.3.1754571965601;
        Thu, 07 Aug 2025 06:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ8LROlrHhAO/nx3LuVhJ4aWIUOSeMqQnvYxszMmFd8ZNXQqKXcDSu0gnMVTLJH/zAcvVbmg==
X-Received: by 2002:a05:622a:1482:b0:4a9:e46d:ca65 with SMTP id d75a77b69052e-4b0912cb849mr59963051cf.3.1754571964966;
        Thu, 07 Aug 2025 06:06:04 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21b115sm1282528466b.103.2025.08.07.06.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:06:04 -0700 (PDT)
Message-ID: <aed1de56-fafe-4ccc-b542-69400b574def@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 15:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] phy: qcom-qmp-ufs: read max-microamp values from
 device tree
To: Mark Brown <broonie@kernel.org>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, mani@kernel.org, conor+dt@kernel.org,
        bvanassche@acm.org, andersson@kernel.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250806154340.20122-1-quic_nitirawa@quicinc.com>
 <20250806154340.20122-5-quic_nitirawa@quicinc.com>
 <f368b6da-1aa3-4b8e-9106-3c29d4ab5c5e@oss.qualcomm.com>
 <fe2bc07c-8fe9-47fd-bcd7-c2f0ebbd596f@sirena.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fe2bc07c-8fe9-47fd-bcd7-c2f0ebbd596f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX5xlEHZ/N6+2O
 tc4HonfmEDR+FAq5ITzJ3eePZt28pOvSTgspJemY+mUZXTTDlF4e6f107Ip94Taff7mB3EwO2EE
 wyHIHuOllRKLLIWs5b8ebXRmMK06Nki21KiwK8YXNkHuDNAqHHEvfDTNHiLvbX4Se5hDNGfcgSq
 UTiwrtqKTVaccHBoNenecrDgmk3TNX5YBvcG+F5/GkCmtkb4cQulX4fEY7RTgUEz/JYjq0ooi6b
 GOVE3BSNVpKjZE27xKd6+BOcPE9D6hTDqjGimzzpEcNpRlOYHF4HOY1/0qbKwOssNwMT7YFv3eS
 sBFvm9Ln1Xk7aqWxo5PP6F0aL/EWU1zuCosoPh4dfdOB8+wmjJY98UoRnKiUsFig7fxRGyUB2tC
 QOBzaJwv
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=6894a4bf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=kfhvm8o0YWoXJs5BtVMA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: JP1Nywljx-1JXQMSCA9kXtVfgGzctz3S
X-Proofpoint-ORIG-GUID: JP1Nywljx-1JXQMSCA9kXtVfgGzctz3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 8/6/25 6:51 PM, Mark Brown wrote:
> On Wed, Aug 06, 2025 at 05:58:30PM +0200, Konrad Dybcio wrote:
>> On 8/6/25 5:43 PM, Nitin Rawat wrote:
> 
>>> Add support in QMP PHY driver to read optional vdda-phy-max-microamp
>>> and vdda-pll-max-microamp properties from the device tree.
> 
>>> These properties define the expected maximum current (in microamps) for
>>> each supply. The driver uses this information to configure regulators
>>> more accurately and ensure they operate in the correct mode based on
>>> client load requirements.
> 
>>> If the property is not present, the driver defaults load to
>>> `QMP_VREG_UNUSED`.
> 
>> do you think having this in regulator core would make sense?
> 
> I'm not clear why the driver is trying to do this at all, the driver is
> AFAICT making no other effort to manage the load at all.  We already
> impose any constraints that are defined for a regulator while initially
> parsing them so it's not clear to me what this is supposed to
> accomplish, and it'll be broken if the supply is ever shared since it'll
> set the load from this individual consumer to the maximum that's
> permitted for the regulator as a whole.

Qualcomm regulators feature a low- and a high-power mode. As one may
imagine, low- is preferred, and high- needs to be engaged if we go
over a current threshold.

The specific regulator instances in question are often shared between
a couple PHYs (UFS, PCIe, USB..) and we need to convey to the
framework how much each consumer requires (and consumers can of course
go on/off at runtime). The current value varies between platforms, so
we want to read from DT.
The intended use is to set the load requirement and then only en/disable
the consumer, so that the current load is updated in core (like in the
kerneldoc of _regulator_handle_consumer_enable())

My question was about moving the custom parsing of
$supplyname-max-micromap introduced in this patch into the regulator
core, as this seems like a rather common problem.

Unless you meant to object to the "QMP_VREG_UNUSED" part specifically?

Konrad

