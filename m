Return-Path: <linux-kernel+bounces-865281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5FBFCB15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0260F4EAB36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15534CFA4;
	Wed, 22 Oct 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="huYSaP9C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC722F616A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144632; cv=none; b=buLRPTDrq2Wf1IAzFu0UgPOpo+YQtkqI8s+wGBX6CevVaz9rOwc+cE7xVlHk4SD1Np/VKOMZosWjYV42i5qAAYFG4epaOZHPQ2k24cibQIpul5UegOZLNuny+KtsiiwqwzKkLQt8P7mYeBnC29emYYlbksNYXioqIVv3BPfy7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144632; c=relaxed/simple;
	bh=1/KjRrMsZ/XCDGwFexf3EAhWXCX98/VuB2qIhSrUi7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqyJVD1IpnDsShwVAbiYSIRcgiEl6eo7zErqLeKSJDH/1M8BY53ABS3lsrg8pkHPBS2weS6NvwIs++AFw36wskVi5cDHUruHo+w7OcF0L83wot4EYw9mJgmw6wWIHrtqAL6F+Pe0ofes9M0FtFF971E/ULj5Pu7vyG/Ao7UbMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=huYSaP9C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA88SG024515
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	INq9WPyFfBY9ghUyC/moYyME3bMMJgDJZ6a2dYdOhJE=; b=huYSaP9CnOQ1bi0l
	rgZhra3KiW+/C/yFDmnWt30f5/a+iW8a5OJNOk9Too93qN1VgXzlJAADJ/+44WzD
	9j5UX4NjYpQ36yRC9GTtKKc7Y6Df9ghIj8oaj5wWeR+9aBK1E0hchzlRnr6CI33Z
	zYzFDRKUsJ5Ktx/VninPR1qTaP8WazK1hv5yYj2Dah2Vpo6x6AUpcg3ulB+Kpdb3
	SIdkwQzr5e2pLvZgQ1fPvUgutuHIKvelZ/h8Zq73cfmgQdQiZTUT+aX2VTCA5e/L
	j9WwZsa3x8ym2ljn2LdgV4NYTovjjmxEw5gezOI2Lu/Wh+X9eDbQfqEq+Myn+LK/
	Cg0i5A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws7d4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:50:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e892b1c102so4580941cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144628; x=1761749428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INq9WPyFfBY9ghUyC/moYyME3bMMJgDJZ6a2dYdOhJE=;
        b=kVUsLpbMe7NplRUmokTtTezIWO2PDr8pBeCfkAskhXnQROTYuU862/9r4ynBHa6XMc
         ybrN0fhAOd5EP6Tk/9uGIc0m7UFIKi+GhknegvzRcv3AUo1jPNM2cARMWoNwIWuSfugc
         qXo1mS9k0SofLCD5mj77EgNy9b+DotTn0XTXqiKSJJUVVzoPRiTfGZXqBepsoWG62lna
         bsju2PO5DjlCe8vv+5FWFUtgUGrU3gfnQt9EFHWNrnPI8xKUO1ycI8isYpEFj3e3GJrT
         LvyOWeL6Nm48oKpJh95geb7w4//gu5EGR909TqF3bN2xKBwXiCeQpOqLQUqpj9CaOarH
         62/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+W8NPCXXX4DXK76k1sKa26WrTJnlvAKpGHscv7FE8v+MeOXmfxkfTcg30aJP/XlEBfCk1uTWvfvdXYtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvLGHVnXNdYuD8cp3cAhS4eTCuyxgf4IBmlJMmyixzIl7qPhT
	34G9WkhNNNakhnPZazc0v9UfUhV87YlOehIsHYMQc1DOVBHTvqptdCzxFu3BjXO2DMTiGYPMp6+
	s+cBDzHau+9tmX1Kn+DEq7zRd/VhqBkSBcPMPo1Zus0MgA65q94jiXtV54r85DU7wwo0=
X-Gm-Gg: ASbGncvBI0asVZi0di4YmeWUW+9JTxydQYgUn+jrTCxOQgC/OA83ubfr1nnkMIWemrb
	INCYHAPJ5zsC1SK8nWUAQxLZ9hZ8e0xOHyNxwnCO6zznnkz+yjU+ccGM5asoVJs2mpe8v5egFsu
	gl6lZ6BuA5Vp+d1JE2IJ8Kcxw1BoeMIV7dFZcfNmXabI+rYaDhDUtbytV4NL1EVnbAIoY4NZWBj
	lsj+TmQkJHomTQWGHkxnGZ32tP4N5+zHBsfst/Mtl8YuUhOnnujpfIg0jS/zys1DFLVhORvBLD5
	PhdKkmJa91ViNx7mvvZ44yZ/wpeAwVqxskpYrsL8olZr5heE8BIdod/Sj1jirvmCdPVK36pgcrS
	U1UWpgtEAOXeD0Mp7WWzbei+WVfn6ziEhTWzGE0MsOKBbRBBW9lr2coQi
X-Received: by 2002:ac8:5a88:0:b0:4b7:7dbf:9a81 with SMTP id d75a77b69052e-4e89d1f794cmr163149941cf.1.1761144628234;
        Wed, 22 Oct 2025 07:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyMZ9k+YL5Wi+O8wwfKKdoq08qbg6uZyT+lVQy1vWpqtzoyM414DZneAUJEWMiRHKY4+8HcA==
X-Received: by 2002:ac8:5a88:0:b0:4b7:7dbf:9a81 with SMTP id d75a77b69052e-4e89d1f794cmr163149711cf.1.1761144627733;
        Wed, 22 Oct 2025 07:50:27 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a8e4easm11883700a12.5.2025.10.22.07.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:50:27 -0700 (PDT)
Message-ID: <acf7b931-eb67-49fc-b9ec-abd56e636263@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-shift-axolotl: fix
 touchscreen properties
To: foss@joelselvaraj.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251021-shift-axolotl-fix-touchscreen-dts-v2-1-e94727f0aa7e@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-shift-axolotl-fix-touchscreen-dts-v2-1-e94727f0aa7e@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfXxeGcFZrWrnp+
 lQSNtedeYWz6UlxMbr+Hc+rFJDujP2gEVC8bSmfhmNonmHQlvLR3sbQO6QeDB05e7yELfbg+qaC
 PMapnlauwaUdYI08qbynfRmx/ywXltQJHtciB2z8UN1ak/WbBsj2v4dlluxfBvoS4W4c2pOCg6F
 YdMgAfmAFIP+wkpDkkYnAiyJTGd419yrFtALK6Jp0xHPXlBPH5OzOtt2L/v04J9CmESwDcuKA4w
 najLGPajJYS99c/33Hqkjk4GUsXiYq8XPFaGAeCdDuRFtoeAabzGt0KzCgfkrpiih1t9I8XD247
 kHzSSQJYkR4zZ6MNY01LjHAbarZj9y6LOscGi5d3pnqSSulzyP1KYFCOqC1LM8bPnQXhqrxzmPs
 H2Jga1eofQvFOR3dGkbww1vg5LwRdA==
X-Proofpoint-GUID: _BWBDutOFniLMCnzwXw9TFtUGBq-fHiN
X-Proofpoint-ORIG-GUID: _BWBDutOFniLMCnzwXw9TFtUGBq-fHiN
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f8ef35 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WFa1dZBpAAAA:8 a=EUspDBNiAAAA:8 a=HvsTOjCDc2fgz3nxQJ4A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

On 10/21/25 8:20 AM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <foss@joelselvaraj.com>
> 
> The touchscreen properties previously upstreamed was based on downstream
> touchscreen driver. We ended up adapting upstream edt_ft5x06 driver to
> support the touchscreen controller used in this device. Update the
> touchscreen properties to match with the upstream edt_ft5x06
> driver.
> 
> Also, the touchscreen controller used in this device is ft5452 and not
> fts8719. Fix the compatible string accordingly.
> 
> The wakeup-source property was removed as it prevents the touchscreen's
> regulators and irq from being disabled when the device is suspended and
> could lead to unexpected battery drain. Once low power mode and
> tap-to-wake functionality is properly implemented and tested to be
> working, we can add it back, if needed.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad



