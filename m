Return-Path: <linux-kernel+bounces-877545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D1C1E655
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9B4E45C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923213191BE;
	Thu, 30 Oct 2025 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bdfmGWB6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4mR7mpQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA71E834E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801074; cv=none; b=a3icnBTfg6N/GJUGt954ewMgO5ggH2HlBYlY5Yk/6pDF181osC+XRwZtfaiMWSnwFykVw0bsRacFbXikrs7JAN90j4oon13HQqDSiP668YTRj3gaUHL8HeFpXORITTlvyGWaP2P/c+nMyRZ4W/eHa0/FxlkCt6Clt0hiM06Rviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801074; c=relaxed/simple;
	bh=1T9DzFH8TcRTBEq1NqL0NiluRosAlRgQuZJTG5kXqQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcBoJ/hBS9WEcbF8D4E4KxsWCwih2D8kosw5TzC9/2NZRbGgBa4japREURSD57bBPANJHW1JDmXOG5EeGcLeD8Pv8YaeepHf8Ia76WLJuaMEzISxUmaL422GmPxhrBDu1RRbDcMJYSTp6L9BGpYfbT+su2Stszlot+mtq+neLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdfmGWB6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4mR7mpQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U0iMlG1994533
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dz97qmPEtZlBnjSlEq+ub83q4pyVP1o5qZayu0WtJSM=; b=bdfmGWB68X0vZ1Hm
	gSTdRg1N0J2QRMizAxG9wul1LU+QSZ2v3Zj1lZFDfDhirDf6OBvQ9JioApyz9FBQ
	Cnb2KcoeGIMB0pdwfhdyK0k24wYKT8CSwcj0BmRWIMzm4CHwK+UWUzeGp+MFFGC7
	MyHaCEV/e4ZzDhV4Xvz8WLs8rjPmAyxfQGrw28tZd9IukUbvBv6rkijFE3qO1krc
	RpzZkSxCayD/Edrbwydooa7KEpd7G20hDCiJMWjHwM42U6OVFBYQEadDwcX/FZAg
	DQT0H5cVhMuAwHTZpOiCs1jPPks6/81s2AxkRB+3E3RXliJH0Z+5VagQzJ0kw7pa
	XoKDnw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr70k2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:11:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290da17197eso9647455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761801069; x=1762405869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dz97qmPEtZlBnjSlEq+ub83q4pyVP1o5qZayu0WtJSM=;
        b=P4mR7mpQ6e2j+DKxQuyNhOtou37iqYDtimyvaYBn3CimcRbjgKJxshHIebfWvdnl37
         mQy7UxD2sAnXvdqO5Bsw24St620hJPDAI1WWBFpahn8rJwsdCSLlpDDk3DWXZQAmthIq
         9oGxJSm7NTkSIe6jNBfF6MqnwM1cDXzbPZBvwGqQ1x8RxMbXXOxMwpGKEwmWylMQZHhZ
         Gjdhcl0CmnuKe6gVxi6Wu+AO7fxjgz87XkXpbNqqXVVHi8INFPg+YTjhcqoOaK96gyPC
         6Rm2pceJ8kLgvGyETERenlsr4LAnrXWXKYtci2cU1wtAEicshPeCQgtzE8wSxHDFA4pD
         hO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761801069; x=1762405869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz97qmPEtZlBnjSlEq+ub83q4pyVP1o5qZayu0WtJSM=;
        b=cD3UM4IhT7zPJQTPzyIbDDiAK+9VQToJwA5i7PX00F6BOURq40RDvFvOLWXY5Et4Tu
         DURYpLcPRSD6XIza8RUAVNcWUiE9UY9xZHKqmS9SIMKRWDDvmxeUa1y+H6lFpMgR3myN
         23puPYtchVsli3ilXf3hyQTAumXTd/xPvPWPZnRuRaSpw6juYTh16MITSRXag6bDuUv4
         a9U3MnBT2xrn6hmPDvG2Eo49jSxe4dy1ARdWlLIafWsZUfjbAOxxG8zqIWQnvukzkppj
         Sk2YNTR8ZDjxj5/6ypF6k1ig2NI3DjED7RtHoox5F42NXrwr10vwFRvZQmg6CmaDCHhJ
         vftQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hX59N0n+JZKDxYCvIvWqWH60z2zaf0QB7zgpdxjXC4GWOxTyToXRoBRKt6KYRA4GVezMlv9nRXnEksY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rLJtt6G6MhbiJbGwM1kFgvVITnICCSlPKL6LNm0iLIA+NskG
	WqAJU6+lCjQSx9nRLFDj9KeigZfT3xzpOjrURt2d2SuRIhl5ktmZeQIqCU5xZl2FvZL4zlPxqQO
	0nQ59MVmU4PjtvjMLkYQJO4cSfLZVpM17zPdVEqgnE6tIX7iulUCeczhFz00B2ujG154=
X-Gm-Gg: ASbGncsfTIIT8CCF7tdvw40yt6GXRcgboLRQGHeJFknPYf1CDnuXKCZSfukuizJGSTd
	Lyuu9Lh0pGJMycyGnM7LnP6X6AnyKZOwQbwuAZpO7U+TTf2IrUK9PlWVns6258KOKZhcWFHcOL0
	s/0tb7i9plCbXs2jLGp5aHhuRN5j7E/9aQicK9a7YUEpNHCBJSBap9zxqEDzkVgN7vOiUgcWYYJ
	t5PqCKUbgnXN8GkJZx0DtrIyhhL1wa0I7J5q/J2RD5uw6pSTw7GuKBTeSOgpj2cSg8hYAdgHoG3
	vTNC5xNjeiGZ6QZeA6M6iMEqDYU0GzKpuOyAceh81lWgpn7eR/5voDDQuCVDpdlgdwNf1UvrvV+
	luKY3fnCVnJg1pvvfbQBGWqVsNA==
X-Received: by 2002:a17:902:c402:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-294dedf47c0mr64600985ad.19.1761801068582;
        Wed, 29 Oct 2025 22:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWf+LYmioEmyCION9Ee0tDIT3Yf6FXfD3nRGRS3qxj6ckA+rt8QYQXeU/X3EEPUqAgx84PLg==
X-Received: by 2002:a17:902:c402:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-294dedf47c0mr64600705ad.19.1761801067708;
        Wed, 29 Oct 2025 22:11:07 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm169603175ad.110.2025.10.29.22.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 22:11:07 -0700 (PDT)
Message-ID: <a6e66c58-6148-431a-afef-b8839929f9f6@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:40:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: qcom: gcc-qcs615: Update the SDCC clock to use
 shared_floor_ops
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20251029-sdcc_rcg2_shared_ops-v3-1-ecf47d9601d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAzOSBTYWx0ZWRfX8T1uHJFBjYBg
 dBcMH2o1GQfvH2aCOOHJjAAehn9Tp8p9+tM8VsTbQFpdWw54BMmwgc+c/hR47hHQ7OMh3aED+gW
 cDAgj4tI3nYjaC6ZFaZDa0b134QqFHBunTotsCBwruN3eZPzktpCDqZsW5c6axxg8WjM4sxrHjW
 PeauiI0EfwaCAEnBUkT4MK9HerfsPRTcYfbwutBkNF/NSOBB7L73FlfiEOqN0W8R+H7VNq7O8hC
 C1s9+QYps1QRSh0e3iZTV27TZHE9r6eyCbDshYlhvrPwaZjWpE6tMJvAWVsloADUpMn54+fZ7eT
 iYp8L4mwNZgBOe6k1LbVNE9SvqwlqZHZdzXxszZmwR+WodmnXyJaG0zsBJyxDK8SwPRgKAxY/86
 vviBddhiNg7ryC4Q4oMQWLdCZfBC+w==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=6902f36d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=vXefXszyV5ShXWUBbugA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RnNt0a2AX2_hnGMun9kTA4g4nleE8LOP
X-Proofpoint-GUID: RnNt0a2AX2_hnGMun9kTA4g4nleE8LOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300039



On 10/29/2025 3:07 PM, Taniya Das wrote:
> Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> boot. This happens due to the floor_ops tries to update the rcg
> configuration even if the clock is not enabled.
> The shared_floor_ops ensures that the RCG is safely parked and the new
> parent configuration is cached in the parked_cfg when the clock is off.
> 
> Ensure to use the ops for the other SDCC clock instances as well.
> 
> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
> Changes in v3:
> - Update commit subject gcc->gcc-qcs615 [Konrad]
> - Add RB-by from [Abel]
> - Link to v2: https://lore.kernel.org/r/20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com
> 
> Changes in v2:
> - Update the commit message as per comment [Dmitry, Konrad]
> - Link to v1: https://lore.kernel.org/r/20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com
> ---
>  drivers/clk/qcom/gcc-qcs615.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

Thanks,
Imran

