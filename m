Return-Path: <linux-kernel+bounces-888219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE5C3A3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D0864FEA12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5494272E41;
	Thu,  6 Nov 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Swp4aVch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X3Rx4NCt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FB1EDA02
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424151; cv=none; b=JDZI2r6BveCaZgWzSCKmWi0dmKPaPK0scZMeTiQJbiM5Slh77BRuKfPskeDTVT/AXYUsDw2yaK7Lput4VhjjMjUKF7EoC1j/pSHmgFjokCkvZxoprrFMFcyovE4/Nq/fnn4YX26CwXmZrviDZMupiB38ShouLDs5u7X39l3Pbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424151; c=relaxed/simple;
	bh=sW/06KO7x9YVvqvYyRC11xa8mKgzDgn0IN+/JBGDhEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O35ivxnkWwfaxNqV1u+W/B7GA2nFaIT1O2JJAHS6MvA7IZE753bWcrld9GB4cZCcPC5QR9TyA0FkEuwQWrBEeiWgbA0LQrN+tUAMQz0h5bMZ84wUTgjU8/OrlSyIaYc6yjqwNFrMOmvQ0mnpUuoqmkPMLBp1EwY/ZeWylPvDeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Swp4aVch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X3Rx4NCt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68c3112389043
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sW/06KO7x9YVvqvYyRC11xa8mKgzDgn0IN+/JBGDhEI=; b=Swp4aVchSAtCKZsq
	0OOqPrZHUDKTQk2eTYaFN/WH7JkW9lYasmvbUY1CDozJiFOcjoQAvnJcMn8gJXQT
	0AICSy1Nd85iKKp8JMgCkcGbHRdLAWXvhLQtJOjglE/ghgKSu82X2chqnPTXnyuU
	65ZAirVp9PvKl47k8zkG7/S/wnrvsgtAO0ttHnLoWP26UukOaEw6/o7dcPiElAIE
	W8+WmeQ44s7ikm0TDlU+RzA33XPEfpqnXIke0MdtNGiOX6xJ0e9v3Xh+1XW4+33k
	XnCaZ/vYq3guQ6eUfspB6mAMDJ/F1xST4uyxoQ3xVDlG1NSmTuhMUNZua2kBssqQ
	/eHNrA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9usg6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:15:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a35e1923so678141cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762424148; x=1763028948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sW/06KO7x9YVvqvYyRC11xa8mKgzDgn0IN+/JBGDhEI=;
        b=X3Rx4NCtQ2Zy4qeXyZ2apSNpJq4dS+cDJzmAh0Vxjaeia1C0l2Vg2fkR4j4LBvRMYd
         ABYLcqbiVormWo/Y09Kwy8MmWKqIkjRYZSzEUZ+Ju+zBT18RfYLyD80XaKXH3nBRTUto
         TcYHx1Zt02VdZOvHuqINX3UqxTnCyem2Rhw44Aayp1NE1VCnYYMDMJiHDfJUHMDcdWV3
         xMi9GcUReWiS/owVORC05eJeMPxc0QLLa7j239VU709dooaIAinfnj0YLj1gG8vTA2In
         rDWzRrYL8KH+dfjHv7677YTIdTtjfLt48O2+brKo9xum0akcAxZ30KO4Jh2EjU93hj78
         dgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424148; x=1763028948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sW/06KO7x9YVvqvYyRC11xa8mKgzDgn0IN+/JBGDhEI=;
        b=Mf+G08+eZJSV+9ols844CVKp5K/no9J69xC9h7VCz1JWuafhSKHLb4IeDHetqI4vYA
         AjomLdD4tYDKDP1rjyj3AfQCKBXJgRUZ3ahPXsSYnniahYSAhirJPSydfDO2GTXtbX/L
         DDCktb+GSmRsabPTbGGr81+28hpeYBGkzHQxQsnyFykuIga6MskO5Y9lqrHe8SQZAzGX
         wEMJNPmCM9gMtg/38kbJVlBacw1dDUPBdIhe87LsDX1PVzcpdKZIXYiMiG7QEw1L0biS
         1Fs5EaYPWwafxOT0yGVR7VweA6RyZ0saNnxseSUTci1UtkDZKDuzB0qLf3CcqZFglbhO
         YP0g==
X-Forwarded-Encrypted: i=1; AJvYcCVL/LjWrdSjAktfBSfrUBkgUtfVPz84l/kV47Z/hHwgH+DQ8ZPmiPBA66Qi7eoyxrOaz/O8lv+mNWuvAUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3XbtKCrBk6Bufa2Ov87qU9619G8qeT6NhplsnUOaz5xW4GA7
	/KYnLBbFx05mszadwTXfDRnR3Wf2DeKX/INFOqEja0sDrtV1GDEtWNAXrhlClq8tBIOhm0C/JbS
	vm6D8IXoTxNB2WQTakLDCVY8bQ8jjpQvTGHqgL5qWD3OCkrEX9kTVeIVixbUkp4XBCok=
X-Gm-Gg: ASbGncuQESZ8Rlknd1wud42cBEQVfWHzuqDHt3Kn+yusDigp7FD69WCvQLqRkLHv9ZR
	2M7x+pVlJFkvkNEQ7KsCVA4FY535926BUvQXoBfaPpE7ob00bjOjlwfEKQS4t5bm/26SOEZ6TXy
	Yw+jORIEVcx8ZwRFsaN9hlACuT3e6y8F4kVfLZ9Pn6lYGIH5NRHxGPfcJ3NNenSZnxpPcuGkAXO
	+OQP+O95p/EsxGgHRxVcPvlq/WrjulSR417TbNkfSIUA5RhCfG/Agi+cnq4AYmDTm85I7YAc16x
	eA8103DMWAvS9gZ6rBea6LAIkRqZFCyGPklfFTkfaqcQjlxNdZ4iJoRs2XKnETnNGJW46NSoMjX
	MRl10JEfzL6l4Mc4miZHESbf5iJ5C2G07COEIMhrBS9aNFzpXoHot+4Sr
X-Received: by 2002:a05:622a:6bcd:b0:4ed:7f85:225c with SMTP id d75a77b69052e-4ed7f85259dmr20669951cf.10.1762424148508;
        Thu, 06 Nov 2025 02:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvO7NovlZmVexkCrJ/x1iqSlqkoHta3xpjkhCpmmF9whGLqj96UH50RkqjdDSUCAvBN887/A==
X-Received: by 2002:a05:622a:6bcd:b0:4ed:7f85:225c with SMTP id d75a77b69052e-4ed7f85259dmr20669751cf.10.1762424148021;
        Thu, 06 Nov 2025 02:15:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289682128sm177009466b.50.2025.11.06.02.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:15:47 -0800 (PST)
Message-ID: <29ef2def-4073-4a77-8437-41cdfac2fa9d@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 11:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: hamoa-iot-evk: Add backlight support
 for eDP panel
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251106-hamoa_dvt_backlight-v2-1-9f844c8f8110@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106-hamoa_dvt_backlight-v2-1-9f844c8f8110@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c7555 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=nQNFA-VO8Zg1hjSIiBcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: r5T1qYJ6uWzwjKFJrV3sJCN0Vtl4Vf_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3OSBTYWx0ZWRfXwnw8SogMa33c
 DRB6YlO+tiXVox2PkMA85+FSywRL5OZh3E7WeBfOvEzoXgHAQQzZt5BidNtQw3LT4Q3TgXonIsi
 nrsshO/u/oW1DkuCDXBHsx9wwnHXJ8YS+sAMVH3wtEHZ1FIrtctir52OE3xYqjBIMm3n38JmcV5
 Yf4fc/R4Lqd6yiRDy+4zC2p0GHNexfY3AaNNIuI3zuq/Y469xgRooX0dMmL692+aCMyHVMMJDRT
 4ft20tCZWK/nA9V4tcXcNV/K+Zm3UFK/anKbjsrpDuAR7gdPr/jSSHWTsyvxZ2TnWoRe1TFZeW/
 euo9x+2iaCDWnAFgcQUJs/WlAfJhwaFBYyBoiEF6LJlgVtOyufd5cEY4B8JD5iJeF63leG8bDjf
 aHB2abQn8KBJqwYouu5cbBbUvc7OUA==
X-Proofpoint-GUID: r5T1qYJ6uWzwjKFJrV3sJCN0Vtl4Vf_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060079

On 11/6/25 8:12 AM, Yongxing Mou wrote:
> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
> control node in kernel DTS due to some meta may not enable the backlight.

Adding the hardware description to the DT with the reason that some prior
boot stage might not have taken care of it is not great

How about:

The backlight on the Hamoa IoT EVK is controlled through a PWM signal.
Aligned with other x1e80100-based platforms: the PWM signal is controlled
by PMK8550, and the backlight enable signal is handled by PMC8380.

Describe the backlight device and connect it to the eDP panel to allow
for brightness control

Konrad


