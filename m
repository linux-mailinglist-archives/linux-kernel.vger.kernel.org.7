Return-Path: <linux-kernel+bounces-874702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F15C16E47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076AE3AE7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E32DCF4C;
	Tue, 28 Oct 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxRg1590";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bsrab/L+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869A26FD9A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686051; cv=none; b=ZDW66l9wzF8dgWWHHsBzpGn6OeWXcnNmeE36J6g/0OLdgU6D+mLWM0z7wfmpoExFoncwam1VagppVSTJu0PeCSMvW2uBZtN2IJB3xhmm4KCjKlX5uOezIIydgsmp3D6z+CwVSBdTNqNkj9DAVikC9lnhC8SDs9y/zkFedmrY4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686051; c=relaxed/simple;
	bh=Hdrhvu34OFmzRVJk5JtCHMiW1j+sCWTKLvaq4pLg8S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IukesRptnc+dj8OrY12WVhAslLRO6Eg8G4mDQnOSUzTyjhw6fsdFk2zPg3FGuzzd3NkRC8CON5o6vkB2riIePmuqG19SKlkL+Ph/xOkQWCSu5W0YiFpjQbJUCFNcXaK0O9GhxKwLUwI+Q8kAfVv9hIXEK8goMcrIxWwU4i1b6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oxRg1590; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bsrab/L+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJqiep2511249
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xTWwykbZ6R6D9hl0dhVafxlJ
	u6iTqU6PDg27OWKqzjw=; b=oxRg1590clFM+wxULx8FbKJMZ07H5Aj9b+yUNN9o
	fvgNE5Sqsizp8qfPQKPM/V9nCCFUoPxrl4kk6Kj+MwkcjPgiBtxTidKuVZTMUOrk
	EASvtgnaAW7JMEr1TLjnF69Tc55AW/9T98NbAlbIaDMUXTG4BKyjdy9a8KW6iX26
	boHHht+jwDCKcCJYTp7CqCdlk82r2Wfqct3fePmTL7YfUJV0IYSrJbqdPtwxeDQs
	5lHWMOUDe2epNny9z4/mR1JPY/rxvVuR+9s98jMesYdt9omEQOisggGgJodfxKhc
	cAQNnIJf0GyfcHO5z79LWuUwENb2tJ5Ub08XfT9IBhvaqQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34cd862k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:14:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso161769221cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686048; x=1762290848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTWwykbZ6R6D9hl0dhVafxlJu6iTqU6PDg27OWKqzjw=;
        b=bsrab/L+OQ04h25MqQc9xb9314rfAq0+I9dIzsRf0hW8+BDGtHvpHV3dCihmx/V9ok
         pzpgoF/pMlaNSARJvVGW6epkb0YPGSLF/qeuIDkHKEM2w+jxhx37S6jTchK9K9rJKkZz
         QFmU1pBtr24YLxjxkn03cvwnXHNYv3B8xmbecjLvpdMn0A4Wp0k/QM3ifBGmV3MWHDyn
         MRL4N5lER841goSm09nfSMpjIACYIaOf55g6haPa3KkHHmjkm3UHIZUf3EyfBdb7kUES
         s5d9egLv+DNKynf2HAVygzJFF5KbCBMoqCURIhZI3zUcHvEoyqFPQbt9N0BwwSGxUtBK
         QoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686048; x=1762290848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTWwykbZ6R6D9hl0dhVafxlJu6iTqU6PDg27OWKqzjw=;
        b=XLEule3/mJyEu7BH5v3lQQjazN051Avvoza7/hJi1XNNLAYE9MsmgiJ6E0W+4FMmgK
         YGYxR4TUEGMUrtUQ+7g9tv97pLDpCd3xFyjY73nV90NG8ti25cnsfvy4u/9eKgbn3c6I
         nAW7WIS0oUqa9pU3TGTlMQC2lAEgIJHmSecl2JyAX4wbt6YLLPGVmZnuqDVZN1tB0Unh
         G8kgopQF7B3av8uHBF9V8EA4EK28poaA96YcD2fA4ZEUT6oplZlDgHJ/NcUL91XGYLWL
         1SnkTsJvUfBBnaUssxigymMh4BHOhEkWlVVSD22IFG9Y8RKFJolsQld/od/WvWwwmhY+
         AQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUmhZngoaNKDg4B2sxPyZBgitHv7n2bNkxFxevhyIl6hD3WwMw0JZQEFlZrZKtnFV9nm3oGN95BGybPwkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpJ2ALR0Lb1egleVPZNdxX5wbb81PUgpxBQjyBiFXE2eC+7hv
	IfjWx+XyYOuqOhB7FLtVU/W9K3Uaf/Jc82lIFMbO7iFcuENPpvB9rDJYh7T5+AwXKWKQ0Iw2Byf
	OWqSh88qCdTskx9r0OGUpr5oxEntmsHIBGN/2OT4euNt65kZ9Hgdce4pIbM4d8dAKElQ=
X-Gm-Gg: ASbGncvsJjLSH5eM4h1PPiekwxPcyLpqWxoLw1jDBSv2GUUzqQJVHftqL5tJfgc1RL5
	hHNndc3SFugnqQJg3CoZD3rfTCyDHAr7IbSd7l8aB88GzctPWmFJ6cCNz8uGcsR2LNS+grJpN01
	quThjkmChpK0BFpULzmKAOrf393xC9SkUWoK3Z6Q2IW51brJk9SCvBVasZK9ZvBgOrcj8TL3fvt
	k7v35gUm2gqlBZsPAOuxvBFopADJFZicBxn9uBCXS3vh2hlHHsBcKXyQSYadFNpSI3XA5LbtiEI
	qhCxay8XX64k53GP7TSemt2rgFH/5JRGoINOTiiG01IAKO/zFkRCi2yJWr4sPxmr4+Ty8HEt1PM
	4UISohCyIHZ+t8jn0aaCfxKIievj0R38E1LMxNm/KYwyTJ0DlzG3Nmy7w5Dm+sL2gUgE/aVChO1
	C8X9QII4Prt9L/
X-Received: by 2002:ac8:6f0f:0:b0:4eb:d841:e5fa with SMTP id d75a77b69052e-4ed15c96c40mr10033461cf.55.1761686047855;
        Tue, 28 Oct 2025 14:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4jNVFQa5Ml7nGusPIXo01lvYQ4sYR0uLu/776uyIYfy89z02I3sSL0gA2ygG1inHEftMOcQ==
X-Received: by 2002:ac8:6f0f:0:b0:4eb:d841:e5fa with SMTP id d75a77b69052e-4ed15c96c40mr10033121cf.55.1761686047410;
        Tue, 28 Oct 2025 14:14:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41d1fsm3319357e87.19.2025.10.28.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:14:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:14:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 1/3] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
Message-ID: <eczsb4xsrfowfalgjaoy7azkrriitaietkjjkl2smceeasie3j@uc5ynursx3ot>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-2-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024151521.2365845-2-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JbqlabfpzKhVY2_2dReyXOZcV41gWNWK
X-Proofpoint-GUID: JbqlabfpzKhVY2_2dReyXOZcV41gWNWK
X-Authority-Analysis: v=2.4 cv=avi/yCZV c=1 sm=1 tr=0 ts=69013220 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=c0kVAxtEfwLV-oNa8WoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3OSBTYWx0ZWRfX3oJwGJaHTD6c
 EiPy4EMk+S1uNBj6m6zoRGcRjoLykAtk2l/Gd51nnriuisIrECE0MIaAgh8kiofKDImGawMjbwG
 3THO7yviAfGDWEzWBMp8bihPPgwTw4iOm9Z9XWawKAgrLuIcZpXQWGBVNZawdQqFMvlqR3P2AtE
 J3+amAuKXWNPVS+OT//zOGuWxcqMXd0zkgj3Q5OHuC1970XFg3crwz1NMrOt1FhF4OoklRBopsg
 m20L0ZefEYweCYAo7VTO4FDNJd2Je+FSp5n/KMYmyW5H3moMdgDsWxKonWh9tCBEvX/D5rJTL5O
 +HmHd3QZolJJM2ToBe2vVaM0k62K/Nn1NX5V44wIGcVURBgQdx6P5JT+fUuyx1l6TsjS5DpoEYy
 WnjTz0W5CQn7ie2MLIt7vaj+QTra6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280179

On Fri, Oct 24, 2025 at 08:45:19PM +0530, Krishna Kurapati wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> SM8750 chipset contains a single DWC3 USB3 controller (rev. 200a), SS
> QMP PHY (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is
> the transition to using the M31 eUSB2 PHY compared to previous SoCs.
> 
> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> [Konrad: Provided diff to flattened USB node]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 158 +++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> +
> +		usb_dp_qmpphy: phy@88e8000 {

You also need to update gcc clocks properties.

> +			compatible = "qcom,sm8750-qmp-usb3-dp-phy";
> +			reg = <0x0 0x088e8000 0x0 0x4000>;
> +

-- 
With best wishes
Dmitry

