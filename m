Return-Path: <linux-kernel+bounces-817081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74289B57DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2AB1A209D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC1320CD8;
	Mon, 15 Sep 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMi6KRQw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE145319872
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943765; cv=none; b=No4K7a3ixmiUtg5Bw8/zLKzL628Qlc9XRV9LoPBidhbC8gYBnHkVpTzItlWZN4wXEUg9WOWTNfLlJQVmcVEi6lB0AK4HC2ufxhfx3Avh5K03D4PKYl5jXyprTYmsD9My54H9gnPtefhd41h1mERhg6Ek0sHtaIDs1trtb19HHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943765; c=relaxed/simple;
	bh=nY+B3iWxUdqO+53Ff8OTtL2gOC9tys4ywe9XnxPl3pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2ZxKM9hgZkTxQrzPwICCLAGy2RLAXNv7hPLJKuMhFXXPAoo89U/RdK8kW4TkjybKHL6MH7bX+JgZX+cQdXEeLQe/7WcelXujJs2FRs/WWfGs4FSWH4OHPvNpXwTm10UyzcCcc4tkhlGj/8RGQj2QwyeKHcy+0WyB531iR46p+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMi6KRQw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAQOhG017523
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	umjNBqAvrgVn/Uf+D/vu8WD+62B9lRTpRfb+uTwmRE0=; b=hMi6KRQwrE4cX7fA
	71Halunw8s+xG8Cj1s4Uci+WTEijX2/p9drAYaRP2Meg+MLw2ZtumbXtU+FPx/gs
	9gHbO/3WOsY74AVoEj8WEibVOlPgO9/FKYlGhLh/NXbx68D48+3pKv4MQPyZBG4X
	xQYesM6Lvm7uw4EfYOxj/IwwQg3tGyakQnRSwCkuO0s1X2GGHA0/DMeoWDONSK81
	w0C+cgcqcpIz1ttk7DLGjGPOvvOwWLEzwOnGL20UYhB9x5M8u5GaC18k3wP8mcpH
	rJvMPxDz59Al/THOuaT4IYqPECJS1yk/bLxhX1ZDzEdECPC2Yz2GG9P1cnDXZDpH
	inXQ6w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sgke1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:42:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f5a43b6so9689906d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943762; x=1758548562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umjNBqAvrgVn/Uf+D/vu8WD+62B9lRTpRfb+uTwmRE0=;
        b=S+RejHGQWAg1u8UXTnsJzzoP/JFGePEhVFSkdNzQLFSjNJ3AHBlszcU0TNoU6j9yo3
         RADEsjZJVs5IMTRgZY1PjTAlHAHax2v+TeyByuxWI/oMIApvMX8jdz9PRYjvVa0DMQpN
         zugXWCbJupJ7ikdZoBkwc7hdzbQXKopK42bdKFcwcffRWK2jmvbPrbSoR7cOCaBt1E0x
         p6Q2yVhZ+mEzCEY8LXZt6JOcSI/kBU7IKcZfs2PsuOXHgUO2Yosh6rNNhTGICyeC3wV7
         SmeNUNnh5cm3t2i8iCodY3TKylnRea4FEigpWu2iuCnO9z1peslJe7h1IPA3i63N3u59
         Zpxg==
X-Forwarded-Encrypted: i=1; AJvYcCVctqL9KG0xQM8yi/nATlXaV8D0fjvw92BF1QFHZR6zkJXz5/Sd+YjXjsQhC5VXfbZIuxnxZhx7gU2rIpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18a+cFxRS7dhFZnT8yvnfBfm2jp2auasOmUtRgH7t8tPxm7eQ
	KafEbdMzT42886rlg/uGKD4n/2APCQbzXRngGkp7I3ej/AxA2/6rxPhVcEYVBLzSJ7oOTYDLAeq
	7bWpr+kNiEX2MD0asSR827ahNj5Jz/Jpc1DckziA7OC1t5oOYSSLEZVwtjT6fG7cjPaE=
X-Gm-Gg: ASbGnct3Fu++xiXRRSwaVne+H3wK86mhnBVLeMirKoDJ7DY6ETVRgVK2S8kQiJgZHGs
	yXkx3KTgInTgRrI4jUOEcOKiJN887flZrM7zd5pSqYndLimZ28jA9G2CAn3OWsiNk3fKLk8bA3g
	E40Cg7YPXFkwcExn50Covn5lfVUbkF1BSJDCy2GAapl8MsDm7oHcdsfBUajE4hOfJaFYMtfbY1R
	msWUjxllW0OSG4qymmjjUwZjkP6pU00Wrq68ph09lbSM6f2KqLNiTpTah2E4iDRWGCiHDBVPDhl
	KlALxrbk+sRurm0gn47YJH7yTrax6oyo5GsL0QgyBa5RgkiAptMpaX0xxcCTEzYN9jpFxAiFOiB
	cyNzI9Z901fl5KcWI0kXEOg==
X-Received: by 2002:ac8:5d50:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b77d06eb82mr107913061cf.4.1757943761871;
        Mon, 15 Sep 2025 06:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMieom0duFgTQwQgXDdaD7dzvvL/ronB0yG2Mh0a+jgIpaG3E2ChM9WS6en3jM6N1/9TNSew==
X-Received: by 2002:ac8:5d50:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b77d06eb82mr107912781cf.4.1757943761171;
        Mon, 15 Sep 2025 06:42:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ddf93sm940209866b.69.2025.09.15.06.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:42:40 -0700 (PDT)
Message-ID: <59f77780-b81e-4d09-b949-a62bf029e7c4@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 15:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8916: Add missing MDSS reset
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
 <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SQPY5Xl4J_WWG8aK3BdlnbfE5rNfyRtZ
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c817d2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=DXmGxE4PG6Zmd65NNY8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SQPY5Xl4J_WWG8aK3BdlnbfE5rNfyRtZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX7BL5fasV8jHr
 iEgirXFlI+WxVNJgQyGqviyBBsWTSsHV2E1HFImgit4iLrNwW7NhreQOBu0TF2VczyklVadw2yb
 6z7RFzJm3LQXfAWprTvTJA3BgbF3RpPdxF6aBru25mm37tdv+1R18pEn2wFTWO9NLJv3ojeinsB
 3RJA9WIVWjSTvjTtFnYA3kCGa+3HPZt84IhwZHsiQyca7T7z4mtZnKKXkF9YPSCCW2cYF2eDnS8
 +Nq5vbO6b23J+FUxJjAW1CgPKYUJXhhe9ka+utQH+zNo3MbCaENrq9KGEnYCop8jHLkNmKjOIRh
 19ZDrOhn+NhoJCqAEVcQojJPOZFyCY7Ib9NYGQ+CxPnRUewjPdBmPz+wRAPT0VMdGvybjb2mKSk
 gaIbXg4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On 9/15/25 3:28 PM, Stephan Gerhold wrote:
> On most MSM8916 devices (aside from the DragonBoard 410c), the bootloader
> already initializes the display to show the boot splash screen. In this
> situation, MDSS is already configured and left running when starting Linux.
> To avoid side effects from the bootloader configuration, the MDSS reset can
> be specified in the device tree to start again with a clean hardware state.

This is really just Linux behavior and not necessarily the effect
of specifying the reset in the DT, but w/e
> 
> The reset for MDSS is currently missing in msm8916.dtsi, which causes
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
> Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

