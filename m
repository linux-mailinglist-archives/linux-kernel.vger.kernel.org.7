Return-Path: <linux-kernel+bounces-817082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F0B57DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A933AE178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A931AF27;
	Mon, 15 Sep 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YweElsmi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65B321F4A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943771; cv=none; b=QCup0skNoXuPiuJpV9dTJgIObAcWNei0uWshr8G8eOQ9iwr0k/BqgM4yu/EMQQJHg1SZxyTJHiY8yLIUGdI4Ptk0AGw0oB3OlfmCKl7AqpiCrP8qIwhPOrIZDqE1kEpUxIJpyeEFANKsgbjeWIT2K6U+4eSQD68zqDpUAEgaeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943771; c=relaxed/simple;
	bh=M5RHgPucAavaK9i2L+zRCxXrGX3r4X2NxswK9RXwFek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbARsrNkafe/s8kfqBcbY8ch4QvAc8884qvcrk+XrZ41DMkBzc+iYwhk5CHhYwzWIVysYwtRELxICNOKqID1K7XcpViaHaKZ8kytiPuri+ZRlFSG3XOBaio7Jacxav1U6c+YsGEcEw9p2jSgMFeoEtzE+2ipBOC/ezj1Fm0KPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YweElsmi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Fg4Z020553
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4/3kWKrV7ZPI5tWosvI/mMuCkZRCGDU56/gZl94qUbk=; b=YweElsmiqvOCE4Ni
	nqZ4oW6FGkm4nsI2jNh9icg8U6Qc/VZY/dcRplP1q/5YUuKPsOjZWc8JhC2miLFW
	U6WGDUjbVkISHnlVP1p1p1BsLtCl3zq5TnE5lVqHUphviFxspWixYItDpbK8cMZN
	e3nSrQIpQohZwUcJdKbukM1YozRq1i0BiAkAq/U+ap0IKTvEdGOfYu4n18GchX8G
	fGuL6Y2hS2I+WHE2Ps/I4HNxlGCnNH+9Zkp48jC26G278M3DDFO8gNkA7HR3FkMX
	O2JH360P6sTCK3oYRFeZv2IPB5i+tzy+FrssYuuNLpebW8rTi8psec81UdPky4A7
	kTz7rA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv57ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:42:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-77c0a919a51so5761366d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943768; x=1758548568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/3kWKrV7ZPI5tWosvI/mMuCkZRCGDU56/gZl94qUbk=;
        b=de5wObBHp0e/iObsg3Lb7Nojh8LNfd6dt63nRUeNWZtf0ud/KrUsl2TCZgnKrLIOGd
         M1Vv1hpEY+Z5x5itN8Ro9RDkyLKG+UAa9amujOlgtRQiitUYDY1fmfoUyauaMA8dlO60
         1kP4SusuyFTG9R8A0k5MwD0jyaqgyHne8jbYo/knqDu5KzWUWC2yC2jdDaSizhsYZw3K
         lvptA9MPLHTx3McF22oybjDtJziKw38SF+ZIP6pHIrd2GVQS9Cr6HG/PZ/777NM4VGnV
         QwuS6L8hEMWpzh5B53/pjcQPxxbeyikKOmDyLqgRy+Qgj78UD9AHRmPlSWPHvviVjTNc
         wNKg==
X-Forwarded-Encrypted: i=1; AJvYcCWErRS/54t3YJwwIOTHhRBVEjUm8s49pXWeTfh7/WrDPTyKiOvwsPrvYRl5qcUR+wV6WfvsHoZfYbir+1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGBWTby4x7h9bMJvaQT/emE7NJpM23OvciNRHGw5jrxCpM6gK
	DR7JJmH2CfRP/LnwhnVlmNIAi1zomEDU2zdNCKBJnMf/DVWZpitO1FcFu6ADm/dj5KdDsntBiqG
	HMBbSwcc9pBq80EDo9tqcGgcOaFzUS+xTUJ4u+nprTwn5KXscEUkVhq0tgXjW/LhE+WI=
X-Gm-Gg: ASbGncvVBS9hUK3GAIfYwLECaS08ZWhVaF0aisDYAnYQdZfEsa/w/AABQIwsYBYzGsp
	2FTgqlqopIFDafi8ygdVlsvOdB25tEy88eAt6vJhe3NC2zgUxGtRtlqnMHF53XbbWpTjcPLZuxH
	hzaRyzeN++Xq9/buztOIWbAsF0wMjKfLTkIDZDb+TW+zz18UUqurvIjTG4etZ4D5yCPqCItdVkI
	9EaSMJD8sz8CFYqGWhXQaf6pmgKl9HSmj5zokLR9S7PiMwFqFmXC6imngVqgXYdkvJRhNa8u+n4
	inIB9VLTNMOJ6Me6FefEe2pcbliZg824xuecl/9K9a1nzBfcQwB5AFcLW3hNIwyMzUyaQYxr2pX
	RhiEiDTn88iYR++pAh11d6w==
X-Received: by 2002:ac8:5953:0:b0:4b5:f4c0:60b with SMTP id d75a77b69052e-4b77d087e8dmr103184521cf.11.1757943767875;
        Mon, 15 Sep 2025 06:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGqsH+rP410sg5iFE/J6ASYV/Uui6s8GeSdgdfcTItelaC5HbIEhMT5aYL8jp5pYysXYPv6A==
X-Received: by 2002:ac8:5953:0:b0:4b5:f4c0:60b with SMTP id d75a77b69052e-4b77d087e8dmr103184061cf.11.1757943767274;
        Mon, 15 Sep 2025 06:42:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ddf93sm940209866b.69.2025.09.15.06.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:42:46 -0700 (PDT)
Message-ID: <d10424b3-b70f-4166-adca-f81fcb214e04@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 15:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: msm8939: Add missing MDSS reset
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
 <20250915-msm8916-resets-v1-2-a5c705df0c45@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250915-msm8916-resets-v1-2-a5c705df0c45@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6kK_S3GefmgXvrfYYXBbizSHBLOIa7Y_
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c817d8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=M_eXORl3-W3UjsCHqzwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6kK_S3GefmgXvrfYYXBbizSHBLOIa7Y_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfXwDlw1C/cbQq1
 spXVfcY4SS7K5vGStX5Ru/pecQhJZFjB49hNG4bbUCemOQ8vjaFkcuL0y84uZm8n/DtUwmVApMX
 1kQC6/ZXbaKd5a/bxUG+XeN5hbw60/9bqlTSYl1FiweLSM+CA3uDTH/A3at5pkN2Qv088OAI9PH
 lIXUZhh/SP/OdUNUtWA9ygyK51ua9q7whSqQz/TbVtG4Da4hpOiSViza7OEcoU6Ars5pBUz/nGe
 o+lLpE7+g2BV9eZQAxaZqN1Dv11m8Mec7lrg3umCcp0nHqKKh0X08Z+VzMv7DuQhi7Evc60XfMh
 GpU6rjVQoULLAM9mJtgNCUM3WzM/36z79x6ul8d++WHAjuXGmnPgpIaUDSjXEUDtymo6FN2GyNv
 +lSfABXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029

On 9/15/25 3:28 PM, Stephan Gerhold wrote:
> On most MSM8939 devices, the bootloader already initializes the display to
> show the boot splash screen. In this situation, MDSS is already configured
> and left running when starting Linux. To avoid side effects from the
> bootloader configuration, the MDSS reset can be specified in the device
> tree to start again with a clean hardware state.
> 
> The reset for MDSS is currently missing in msm8939.dtsi, which causes
> errors when the MDSS driver tries to re-initialize the registers:
> 
>  dsi_err_worker: status=6
>  dsi_err_worker: status=6
>  dsi_err_worker: status=6
>  ...
> 
> It turns out that we have always indirectly worked around this by building
> the MDSS driver as a module. Before v6.17, the power domain was temporarily
> turned off until the module was loaded, long enough to clear the register
> contents. In v6.17, power domains are not turned off during boot until
> sync_state() happens, so this is no longer working. Even before v6.17 this
> resulted in broken behavior, but notably only when the MDSS driver was
> built-in instead of a module.
> 
> Cc: stable@vger.kernel.org
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

