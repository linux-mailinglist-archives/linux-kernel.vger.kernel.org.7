Return-Path: <linux-kernel+bounces-724512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F320AFF3DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D234F1C4173B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F123E344;
	Wed,  9 Jul 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OmQDiZ2I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3E230BC9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096258; cv=none; b=jk4WBB30zq3dNXaNQhjpJE4s6FYd4ubZ1qL341mt/4KWu3An5TR+d5g4J/wcEk1ySPlxnzPBSOVTUzUPLFHcHePzxMtfyiTfUFz11AM2kM0BHXsYjcd8ZO1NRDiIsmWE9av46DQyhadmcUi07+MJ7WhxmRcCwqoqaq2pH+wUGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096258; c=relaxed/simple;
	bh=jSICepuquIIBUP/pWAxw5nOYXdR5Jqdd95TDlojz4+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T65OQe0Valxby4vpadYKpRQRW31S6hl4V3hYZeAIyKCr4LSxQ/19JlbaSB7TGlLHWBZ5jKsHdmS2pu0KO71LqLHfPV3NHkniJDCPyPMqckd8BzYWW2vSN5j+aJbXLLf8tP/ax4mqDo4Z4J8D1Uu03riGrfs0cGIcXqRqnn8761c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OmQDiZ2I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CoixV011308
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 21:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6HcxkBYYWDEqMWfHnTGrSHdSzsR+TXGlGZHdAYOSSuo=; b=OmQDiZ2I2jlLM/oT
	P2JXDaunWvaQKWgAj2iNaUoqOQLyF0UjFFHTFx9cnftBzJ3loDRiJZE6ceYD7rUt
	XKMF3Frb3uHaRUxjcwg2TfHOiPebw5fjps1xXJz3ux91+lqdEdpKHo3+0OrfLR9u
	yGpmuxRZ89Lazq1usdXNqt2xQvF8n+rK95gV8o4C/CtaqoeA7Cl+rxGkqYsH+KFC
	NV/HOtI7vtZ+L5kh1PzhZ/WMKwuA0+qKSKSAwDE/oukEmGp6NyYVkENO2QHI05H9
	i/HqXiBUS+7EBnobucRnktN7GjH0oo/XspaNthV+z/WoXFq5UwRJMPrQuty9jcKP
	yGzlXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smafjhjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 21:24:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3ea727700so4078185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752096254; x=1752701054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HcxkBYYWDEqMWfHnTGrSHdSzsR+TXGlGZHdAYOSSuo=;
        b=JJoGs/ZYz5StsTnfA9HAdL7HwqtqnB7TT9H3jZCjlj9cqNxSkh6AyjnE1xcj54v5vL
         aKpIlQ1Bk2XlPl+LApoVuJNbHnNIwxIMu6qxWf7M70GkbAOUM2iT8MX5rj7WSwttZwNs
         LiEGTKrPWukN6k5Rjv5QVz7chhCPxsP6a3BobNnWUMUJ8rIPxKed1lXson0PLUR5rIEA
         ZjXn7VRC73U2Az67xO4iZcG7djF1HkYb3Tx2gAJrRqYHIcJ3bmEmfVXdMiVcSHecaMI4
         7wCX/dnQOQyK5+oKfivfQysKCT/YmP3j+0sV/+rz0DzekAZR+AN+Fk8kp31EFHKgEFSJ
         9/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWEvYWMoNMAfwchNXtI9O70CRxthktzGT6nywzm6GC7WpZEJYHTYxGzeD3r3RjhdiIEapjQ88hCXoMS6FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5AWntGPkhvJo6hNWrVKArZq7MmcPn5lGCOIvcG/aA3PeDsML
	vdEWOzJj3dJwCcEag02oW3N5xB/a+XRhLLR5gPPqUgn+GQP++HSPR0yJT5W0i078Fa0qsxn77nZ
	HoyrTGPgBBNN+8oMsWz7WfGhjVpKSnFHtvnSrIZ7dKJod267euDOg/3LSsnT7VA5yP8U=
X-Gm-Gg: ASbGncsYrAPCh3gjv63VEdon4paVAWhyWGCZTbNFAz5ynnHwFkg4jcu+vfpm4VP/ono
	r32tRtdvtZyHT9IQm5yRJW1m+EXHC9hMyOTNCutDG/1yWyE+56Eda7DDJf/CcSiVu3gWndGCaE9
	EoIlsmbJ2coiLBaQgiJk9f2GVKt4/dtxYlJJe3d2NVUYWgMHmF1Y6jLu+XZXR1G0iH/J4JKEuan
	ey0FdZ2x8TrJ3/9b0NWmU/+jc5rzxFoolfuRrGo/5l8WUsGX8hdq09AXUQ9D9zIcdtCvuHBenvf
	a4S/ZfYfAxFmWBEg5vTzBp/M+l+clmvvRvgPHDJdgKuA54JBGHEJ8qCZjzs/ttMKvw29rVP96Vz
	2fFE=
X-Received: by 2002:a05:620a:31a2:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7db883e18a6mr244908685a.5.1752096254140;
        Wed, 09 Jul 2025 14:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzJcPMmv5NNecx70SGRZjn6b+nC0byiwhyGmzcrnBa2xtGN06eE3paUMlHuOJ7hA18cs0w3w==
X-Received: by 2002:a05:620a:31a2:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7db883e18a6mr244906185a.5.1752096253663;
        Wed, 09 Jul 2025 14:24:13 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c9236sm9444279a12.46.2025.07.09.14.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 14:24:11 -0700 (PDT)
Message-ID: <90d21fe5-97f6-40e6-98e5-378a7809e8dc@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 23:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] ufs: ufs-qcom: Enable QUnipro Internal Clock
 Gating
To: Nitin Rawat <quic_nitirawa@quicinc.com>,
        Avri Altman <Avri.Altman@sandisk.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20250708212534.20910-1-quic_nitirawa@quicinc.com>
 <20250708212534.20910-4-quic_nitirawa@quicinc.com>
 <PH7PR16MB6196F9B8C676FA18AAC10F3FE549A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <f4654034-a94b-473b-907a-2687acf11af4@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f4654034-a94b-473b-907a-2687acf11af4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJ/XmW7b c=1 sm=1 tr=0 ts=686eddff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NCvSw6eEAai3H5U51bMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: clw4v-MbEvBpAZp4ruhkMAzalO96ztDg
X-Proofpoint-GUID: clw4v-MbEvBpAZp4ruhkMAzalO96ztDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE5MiBTYWx0ZWRfX21OwrKAgnNS+
 T+Pkl6yIn6J9GQXblUi0KtYr3xpcul/APWt0aaXRbk8o1yBX7xdKZALj47KlvyY3n+/SQiHoeyR
 87tqxBMOuwyvGly4oTguLdEoUon2JYdeK/vv72cH0fS/aX/1n+0uw44gjm3S6aI3Ks0dwBFz9hY
 kJs5D2ZCBbbZisZm+5P227MY5nkIU4M8UGh4E2xYNdSs3l4mcZtZaLrhFlMnxV2VEM+2RJLS8Ec
 3m/+N96lWH2b/y2JYZU4UhbjFyWBgB29mC25ggzefaRPx9BwqUWjp9w7Ls2QZHBnChaXJM0mSBh
 wpcmDHrLqZXVDJT3Wgd/IiJ9hd5MMnVn7m8O7HUDiyQMHd7rs42yK+vbPvVsCuafw0eupPrh6JQ
 fulTvl8lLJz/q3eTHXm0oxiNCPMNvFuiPUZzXB7DRnaiEB2g5JaBZ8UpC9RUhISnU27Y9N42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=758 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090192

On 7/9/25 11:13 PM, Nitin Rawat wrote:
> 
> 
> On 7/9/2025 10:46 AM, Avri Altman wrote:
>>> Enable internal clock gating for QUnipro by setting the following attributes to 1
>>> during host controller initialization:
>>> - DL_VS_CLK_CFG
>>> - PA_VS_CLK_CFG_REG
>>> - DME_VS_CORE_CLK_CTRL.DME_HW_CGC_EN
>>>
>>> This change is necessary to support the internal clock gating mechanism in
>>> Qualcomm UFS host controller. This is power saving feature and hence driver
>>> can continue to function correctly despite any error in enabling these feature.
>> Does this change offloads clock gating?
>> i.e. no need to set UFSHCD_CAP_CLK_GATING ?
> No , this change does not offload sw based UFS clock gating. Host controller has its own internal clock gating mechanism

Does QUnipro == "the UFS controller found on Qualcomm platforms"?

If so, please use some version of the latter name to make it more
easily discernible 

Konrad

