Return-Path: <linux-kernel+bounces-865578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF459BFD85B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970A73BCD05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B6233707;
	Wed, 22 Oct 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obU51Yg0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532C26ED29
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152416; cv=none; b=TJAFU16FbPI1etsK+wU3OCC6XBJjpNMi7+I07IHP+QayYCiX4tiC5YjTvWA5zakAEqbp7OX2dg3ri9h8z+I4l9Ro3S/opYju3OLdnjnhCrjQ7xTaNVDuwNr/4JGhS7cR5ZFIg01tKHEPC5lf0NhkPaBNpZKaZ3wpNDsGKfKnFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152416; c=relaxed/simple;
	bh=d0FaEugcyz+mcWUvpZbnDCiAz5LX94+BqS7F+b67vYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfQ8MIsYaZZG7FN/vUdGGb07AKXahzsY8+NC8y+vPkrD0/rNrwu/0aIs+5VwTTx+1GXZ5L5xoJQOOolQr2dDWZ0dFehxQ5bQiXNjmBq0oAb2rRuQkxfm0gA7/Lhi8NQocWV4LU1CBAOCHya3/Peg9W2lbmCmQK6W/w7udvV+Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obU51Yg0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAt33n026973
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZrnnrZ55Fby43d0eVBtuLjCArdYalb05Hj84nL88vGA=; b=obU51Yg00K2aEXnl
	p09wDX5p1u/ITgB0b+RUbklyfcC8WbxvM0vVBIJUTDtERKDgjfcCqdf+PosOumkE
	47KBTMbVibalqqmyJeG9Cxu8XiOCplIiZXg1+xOGGKliRf4oYIjDVarj0gZ5QNf8
	0g1jKJQL6Mmg9LrPEvdQb95YOH5KzI1aVssPWpap+8u0+54k3UIO5rqQQ0f4f0F7
	X81B/gF4Lq+dLILVxE1OnuAtA3cs8uT9z462hARIgCr6VUYselAwH/oN4L61mP7f
	2gaqxVx4gas9r+UZScw1kmx86hno0QIzybdapm9KnJxFPjl7ogEfCPeioBlzS0vn
	TrPDSg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pnp7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:00:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e886630291so4153251cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152411; x=1761757211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrnnrZ55Fby43d0eVBtuLjCArdYalb05Hj84nL88vGA=;
        b=t1lfqJlAAAJ6UeaUhE8e6R6uyabz+zHtFZ+bVXJsy+BCOd+F3mjJpNbtZbpSLJKh59
         eno4qfKhfA6aqGfyeyqlUBPdTHRT9d3a6l3cPs6iTTxaFuGAozWHOSNrtF7W39uNbUWn
         j5eBbz6JRN3oOEQR1Hh3Q2KQCVCrOkPx+qp3yne7ZbR8WUlYoCcPcFKjdxmalz61WpUt
         IWS2q+MsJeDsad4umsp5mh1IRW/r2eQzohcWwsYy8Y2aLEz7sdp6HO+TwOAUdZAO9GSf
         jB/ssDQ8hOgzojSOEOrvcdx7CIfxP3RnQoRzQSzJBfLjqZySetbhxvv/y4Jg/h85kSCC
         QM6g==
X-Forwarded-Encrypted: i=1; AJvYcCWByuI8bjwl8K1xzv60D6ng5WSaOCFfTxYKZaoUL92m3sjAQ0gtN7HqB8XIftcVEwuk8nyOBjWT84a5JsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXyX/gXE6bvyRHYB/KFrtL322fgWuflBQJVTLxWEeM8Twmfyb
	1xXaBsSmE4MhhoUdu846lbr3+IPybdMjSeykmC0W1IuvjtypdR17dqih1wMksXq5VhWja5ozq0n
	S5B0ifhsrTnhSdI26aODVcQ6a/z+kRVN9V7LzK2l7sueVil2sHUlqulG/fpwBMh7sbYk=
X-Gm-Gg: ASbGncvaK35LNpRKv3UpGpv/xtji7NzkStu5pLMs9QTfCx5xxyD5miIrTKTQ5Mc/iBs
	MJsqI31hAiKRuywhiHA3sUuOU/FyVva8x24oUWEm6/gQWQVpvtvjjakugo18XFbQ5cwvtJIh92m
	f/dSYQIpjjV422SpuPg4AIRCGpbz9NLyqoy0Fu9RV0a0V5RmjXfh+z1JAGkGAtMNGL7Tjg69PPP
	2eEoRYIeKvGr6hUQQBfYU8gqj6H0L3Ws87yYNxk/iP0C1tbmNDcv2o+hdP7Rbg/5r5yNZYMDPfz
	GwagY54qoCdcZyZeodDSQzQvIjKtehXtTJVH3lkaY3TC0pwbjjlWP32MXbjQzRTOaUZm/r85wRH
	MNyXXdicvE//HcTmNnLtyyZQZbjpTNOLmnAlzZSMGCxrr0Pu+F07eH1/V
X-Received: by 2002:ac8:5f92:0:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ea116854c9mr64095391cf.2.1761152409544;
        Wed, 22 Oct 2025 10:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQUFwRLBSU0Bj9Ad35drvIBT7nnB7O8zLCAvqfWRt+7y0Y2eQF1SsS1fQrrvvKF+FtFsKFpw==
X-Received: by 2002:ac8:5f92:0:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ea116854c9mr64094571cf.2.1761152408650;
        Wed, 22 Oct 2025 10:00:08 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb52621csm1379069566b.59.2025.10.22.10.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:00:08 -0700 (PDT)
Message-ID: <be816a6d-c4e6-4cf1-b5dd-fd59515a42ef@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: monaco-evk: Add firmware-name to
 QUPv3 nodes
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
 <9b887bc5-eaa4-4271-8770-3458efb528bf@oss.qualcomm.com>
 <f016d47f-919c-2944-ab8f-68e450e5836a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f016d47f-919c-2944-ab8f-68e450e5836a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX1U9ezCwZ5YLM
 jIqwK4sDxJwMoPSvLTYUUouQ7vFpvbpJYmVW2Pvoc029Mn+ZKErae+/UILW2mFH+tZei3UKkQre
 GqjJPt1C95qoRitTQ4rlAqwuXEHFEFAK4hpQU5IhdmeabacpupSejePrHgty3/bILNor1ylUHYg
 JiES16QhgOvZ03TMMG5UDOvkxf0kkdgTj2yjnjgzfCsXWaXUaL1vV2m2EtuFjOVpy11w+vTeitE
 Wi9Ll4SGIkVmi9CHPRuJtFaJkaUlcBZj87B8IIUkPM3YEi0ydNfjDBlnSacQLe2hSd5puyGr8Xs
 UO/hN0C3HHazZrkb6axCGdWfc9lCb3IfK85yoGGyESO0htCwWfk6x0r2XFX6gTFppjMW4+o1Rnd
 iLPgVU1+l/+jIh2dDKF39kecWAaouQ==
X-Proofpoint-GUID: l4Iva37SJJeaBpZAXldKJP--f_s2aW_4
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f90d9c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=jWXY1GJHB-k3Q3zv3vIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: l4Iva37SJJeaBpZAXldKJP--f_s2aW_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On 9/26/25 8:43 AM, Viken Dadhaniya wrote:
> 
> 
> On 9/25/2025 2:22 PM, Konrad Dybcio wrote:
>> On 9/25/25 6:26 AM, Viken Dadhaniya wrote:
>>> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
>>> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
>>> ensures secure SE assignment and access control, it limits flexibility for
>>> developers who need to enable various protocols on different SEs.
>>>
>>> Add the firmware-name property to QUPv3 nodes in the device tree to enable
>>> firmware loading from the Linux environment. Handle SE assignments and
>>> access control permissions directly within Linux, removing the dependency
>>> on TrustZone.
>>>
>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>> ---
>>
>> Viken, you've posted a lot of patches like these lately for
>> specific boards.
>>
>> Should we instead push this to the SoC DTSI, to limit the boilerplate?
> 
> The firmware load from Linux feature is applicable only to devkit boards
> (RB3 Gen2 and EVK), and therefore, it is being added exclusively to the
> board-specific device tree files.

Do we expect GENI_SE_INVALID_PROTO to ever show up on hardware that
can't make use of fw loading though?

>> If I recall correctly, you said these ELFs are not vendor-signed, so
>> it should be OK to have them be assigned globally
>>
> 
> This feature is intended solely for use with the development kit and is not
> intended for commercialization. Therefore, vendor sign-off is currently not
> applicable.

Well you conveniently never really mentioned this in the driver patchset..

Konrad

