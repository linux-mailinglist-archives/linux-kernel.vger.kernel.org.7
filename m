Return-Path: <linux-kernel+bounces-849854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A6BD119A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A34E4BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031AA2367DF;
	Mon, 13 Oct 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oeZsKP7a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987D2566
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760319318; cv=none; b=OHV1YC5UT62uagEsLTPuNKNhIJu6SjEehi29mJ2afB8/DNwet5Z8H0kET8bL+ikcvmA5MSYLg74/O2x3fdHGXKXzJfQboK+y2C68xCV/tG5DPKcwbIl2bYnec9pYgHxx5AfglGt6Dw3SNqJLGfTMdLzNvJCKLjDq+fpmiF3/Fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760319318; c=relaxed/simple;
	bh=TLIifmYXZsoUZDQIMzAr9TVJTrPPzSLPCVver0Z+1XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifOkjdrmXQkeAlvaq/M3Sl2L5d/eVjSPcNHAUZvsGsW9u87S11r5gFlRMGZFA4QcVx2dHAGhRG2w4/9/aJPF+wjqR3OH2J1uatWVPvQVvlbtETaqYtEL2pheXM6+m7XM7K5cHakhWtJ4vUcw8ULA3WSZtqg28vwN+m4A8DecjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oeZsKP7a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CLAbZI021821
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvRZtGa1EAqu/s2cU1tyWSgB4EnX39XSZObMDz+e5Ig=; b=oeZsKP7aV7qBxP6N
	7BXiJMdcvYgsw5degXI71w8R1X2FFb/0EDYMkCjMXjUNwxhgQH0/Q8tcxBmjJc2n
	BDyiXpmtHZucJpK+ysWtMN9q1PRWseYCuwyYBj9ZfXWpmz9a8vb5B4OwQpqw6JrV
	YbLYQAE/UNvfw/9h5S5s9rimPRBaJMO3p51X6hXmYyFEeiL3xw1IHwpQ1Cv0TxSQ
	RRdlKaIRA1AIcz5lzvZHXZY63YmaLZnpan0NG7QNjC6Skuuwjq6lNMFTrEnFeZ18
	RfXvAaQEuj8u9T23Qtew2FaKEAyfksNmviKFjqrCyYbh26qJX8gatk+YlnU1aNMp
	jM9fBQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh62srd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:35:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso5946674b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760319315; x=1760924115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvRZtGa1EAqu/s2cU1tyWSgB4EnX39XSZObMDz+e5Ig=;
        b=YpTZsD5qCdaUx5tModZmYqd7mD0OTpk24sN7v5GYJr0VAEQRjL5EMispMYGpInTCsn
         YHwmqhpRSG++rMPp/g4A+3vbazlRNiyJrO4fC92qGvIqMSJcN4I9gexunSi3kgxkIcSH
         Q+O2fFCNpJIzsj9k85bpa8aThgIkslD4CrEGme8yGlaFiNpGw5YZtIon0ERqbFXBHZOn
         Dxp4UbPa0SmjbZOLpcy3hn0nlG6ewJuEai/VTKsczqH0wIFtU1y3y/sjjQCXrHsUGLbK
         +Wlm+Z16io3YspHdd14RzVTYPbEvdSIoDOYgpMLDrp6d5CZ7MIPYJjXMJkpH1rRk8wel
         IlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhhGa8uK5q7ACmyZTdwIfWuKggsRhwOphwE66O7ehOIkGbjjZ8faCR8+2WEHXJJPnMp7tj891afN4JlGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizXg/qOsiA+mHVuQrmw16x6yCb8vwYv9B4sAE4II/OCRCHqEa
	kPsM4Dz9OL7JROKOn/RTXVhhZJb47z+jUCIgq3wPmBDHtnISld7ZHA7gMveMR3tQ4U8WjslQFSy
	WTRqahc+EMUUPQxXDabB8Y10kjxCGlFSJnUGIDkAAl4EfMgKipyH6nbJczCVq9i5nj+jAmmEaZe
	I=
X-Gm-Gg: ASbGncu3IrskOg5Etmv+/Lz+o3okcxytnAOkHhSxXfwDA/gZ+KDZQeuIhx/vr9+P+LL
	STmbWfMePOnA2mukiavaOZ9xwJSZJyAKHt+ocWrRRC/yJbAJ4tED6lG9e0PqDlSqjZpcgHzo/vQ
	RT/dcuwrlYiTK/zxtkKxzI8q0vMlcZlq9xZbYTVObwVeWbSaMEtfSqBl8UbAfG+zafATgqjt+6Y
	WeafY3HSQjZEFcguRpC/IqFlL6oQ+3hit573SohTi1CXdgAABbpi0viwoUKf7LZXTzfThFbH5Bo
	px/1G68e8bLbScJ98z8rOK5bN+mC2yKnmzcCj8UN8D+iKa0FvDgVFrOa6PdTiQRxPyXG98TfzeF
	F
X-Received: by 2002:a05:6a00:3998:b0:770:4753:b984 with SMTP id d2e1a72fcca58-793998483b7mr24733196b3a.16.1760319315159;
        Sun, 12 Oct 2025 18:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH9hfoH8Q4uLbRfuw74qI/5V0wKxXaXaZlksargHLpNt/wRLK8+zJYUZKvoOuGl9lpjVTwsA==
X-Received: by 2002:a05:6a00:3998:b0:770:4753:b984 with SMTP id d2e1a72fcca58-793998483b7mr24733171b3a.16.1760319314749;
        Sun, 12 Oct 2025 18:35:14 -0700 (PDT)
Received: from [192.168.1.3] ([122.164.228.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9932edsm9522670b3a.73.2025.10.12.18.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 18:35:14 -0700 (PDT)
Message-ID: <f1b5caae-8544-4027-9669-7c92a33f7c61@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 07:05:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: qcom,snps-dwc3: Fix bindings for
 X1E80100
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20251013011357.732151-1-krishna.kurapati@oss.qualcomm.com>
 <b9befe47-b0c8-4536-83c0-311dd16f2e83@kernel.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <b9befe47-b0c8-4536-83c0-311dd16f2e83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ec5754 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=8YinarrYfdS0Dhyguhy4yQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=snNKEbK5PTu-mnxKcGYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX9LMNE6Y1cGFH
 9efJbNUdoiRhVPvnOjPmwP27J+JE8L4F5cPRCViE+sSyXfUMtTOu5fkeFp7L+cGF37kmNQX/Xcs
 4KWJ0CTeJfFIQBdcHWxgn8Gha1EwahjnMb2snBTjxPeCSPbhrkLD08EPWOdoO2VZB2QWWHWdjdh
 o1sieca0Lz+UsEwNoMRTlLHe2vndC9nJMaxVZsllisxEFlUvKnl8TC0dRO/ejDRMkMbE6bBoiPg
 O0NA/XTCh31kiqSMwdA0YeRsboArguUHCs7sEhe1O1BRff5kZV8j0nZ0ixDBWXv6e6g9BAdEjiw
 8ueqygI+0QSiGbWkm2Kt+dsJbhGVAZujZIHTND0KzYamyer8YH2Zsd00byjnO9EMNLuEFeMk4NF
 AnValmTxECGF7uAMGmsrvfxHE2fe1g==
X-Proofpoint-ORIG-GUID: DBzvCdGC8sdlQxO2WAmaJJTRO07ZQqW_
X-Proofpoint-GUID: DBzvCdGC8sdlQxO2WAmaJJTRO07ZQqW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026



On 10/13/2025 6:49 AM, Krzysztof Kozlowski wrote:
> On 13/10/2025 03:13, Krishna Kurapati wrote:
>> Add the missing multiport controller binding to target list.
>>
>> Fix minItems for interrupt-names to avoid the following error on High
>> Speed controller:
>>
>> usb@a200000: interrupt-names: ['dwc_usb3', 'pwr_event',
>> 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
> 
> Don't wrap error messages.
> 
>>
> 
> Missing Fixes tag.
> 
> 

Thanks for the review Krzysztof. Will update and send v2.

Regards,
Krishna,

