Return-Path: <linux-kernel+bounces-815954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A724B56D66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D413BB286
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36531B87EB;
	Mon, 15 Sep 2025 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQNPID3Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B614AD0D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896331; cv=none; b=udDpP8LAvRR2cOvSYCjB9pFYWoVRg0o8j3TqhMpQZHbzdoxEWisOVD55ULPbrovxM2+0uf6XGA5nmko28GxbswINRy9LAU1xwKGBFZb1g5KGl+zoJa2PPuO1puuWBsNYr6zcvMGW3sTjtoboqOVEcY0KlaEKQdQnnI6SvjuJKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896331; c=relaxed/simple;
	bh=fVwiNBmoQdzu12TPo+tBaLZwp7T2wl/KVuYlPKdvW28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGPtxIdz3dJwzKqMIsC2Aw7dvGvFXIivcqQR5YUaieLFVoyz20MWxZ50ahZzLhg2dS+laCsnXnvqZtUifSDdeAOqrI42ImAkOtlguqRwVKPwcEwi3Sr78T+E3hrhwmMCPS0Nt3JfRUjE/4Sx0f+arlvdUYkWm4peoPlPz7oIznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQNPID3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ENcNY6001428
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X6INT4dFh36gD5CkZ/5tXn9K
	DSDRdeyRZoyjm8V/Qek=; b=EQNPID3Yu0SAMp/ZbVlqVnzQMfFgsPdHp3Rmpj93
	Vp/lCC9qXrYgY/dqjngrtqeTqw6U/7Vf81wIYI+Fbk/2DV5CdBdQyNS59lyf/i/2
	CzruxkRUUZIpQ3wLkKKvnlxvDh/ip+TGaVYvIxry0Kye0ipJbrP7A4XeAlZd4+Ql
	0cOLzHfIpDIvXrE6H8/FS+Pjrp1m+yZpgkP/6ZZNGGLs4QtYHzTJSoSCNRUEEeL1
	VF+t+FPuZcuyAU57jM1aBs7SvlFWRN+bU0z1eHKYzy7p2SNqVTh+pmN7514K1/91
	s/tIfd/KcJhm5B9hW1aHzOKLKmoA2rRvBgPu7us54lwQOg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr36sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:32:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7814871b57dso8867266d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757896328; x=1758501128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6INT4dFh36gD5CkZ/5tXn9KDSDRdeyRZoyjm8V/Qek=;
        b=N0UeusuuFQJdsgJMdsdL9pRm9cwLXCVlrnUPQAWEN3PwYzq/D5M6T+rG+mXl1yfyQi
         piWh4TK15l01pi636ogB3t18a6EICeKn8YeXhsbfN7nutgPWJkGm8ZkKQhHFyS6s7pva
         PeIBEqV+eY/BC7sI9omGq4VEVKDpFNT61UpJIZFJeVlI3CUg7L82e1wBXlQmTKgu75MC
         4mC7fpI85kXU9kvEEnRBTlOyFDC4O05bPaiu0ZgOg8tGRzocX61hyAc1P7b9hUstOZKN
         zsOjOYliRITCu+l1K7KaLz7VkxK5NtDSDg7c2VVeb5DBkyCOuslBQwyWjptaSmVQ/IIu
         6tMg==
X-Forwarded-Encrypted: i=1; AJvYcCVHj5BqOtBqoS3JH2XW468+H+BGVao42jOvmzE3K31K1O+s9IDR/ITBpt4LGRDetBoo70wtm/1OzlUanm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95fRCF0hdMR+ydgzr6Coog6UBpyURiDzP0PT18U1iEemiYlEL
	Q5aML638t/XJlC5wQvwixZZ7TOqgkC+MLavqx8IEDbIgSUB6uDAHN9+Ey27Ngl5wPmeP7l8ybDx
	krOPBYzu1gkcDnVma6DhBlFD2I6PFH930vDXLPZTcAMJhCw6Pe9crMA9fWTraU3HPJCA=
X-Gm-Gg: ASbGncsRxmKPEDCDClPjWfJR88ggAHE8FV1cMmptj8PZ7wp71xLu0dNlEJNE5SGpBAQ
	loAZFHs9haXcRxfZ+lcqsJagResGBV0H91u0fiNcNSX5wT5KFIq2oUYSiyrXGrxzvyuo+uEgoeh
	2XfZr+IH+trKXkhAxYYwVtXOWhbRKMSoWp6U2U7DgPT+i1nmjZCNda5FdjqwGjdBjMJeBlsywN6
	qc8zJ6bY10S3lRewt2sDDt4WfgwkxnJx8K3mB77j62Y/BLhwRZslR9fDzInjV6IbpZwm5N6va8a
	wdYA8y55NDgdFUsFfjZe2ecfwQp+POKmo+dYr92Y7yS7C5VcEKJMKIYIt7qOG8pyxCpZ20FRx2Y
	5xO7Zsx77ubJWUnaLXgknytMm02Yo4BMNJDjKzNsA04t+LXRYj0vy
X-Received: by 2002:ad4:4ea3:0:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-7621c32efaemr167236856d6.1.1757896327661;
        Sun, 14 Sep 2025 17:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1qZzfHrBrw83QUogwWdZ6sXq0A8mz8+e0aG3fK2moYD3Os+D+QtmmTb729sL9JHULQgtuww==
X-Received: by 2002:ad4:4ea3:0:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-7621c32efaemr167236656d6.1.1757896327191;
        Sun, 14 Sep 2025 17:32:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65564951sm3159160e87.130.2025.09.14.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:32:06 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:32:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 06/11] arm64: dts: qcom: sdm845-lg-common: Add wifi node
Message-ID: <rfp5oukqbnrzva6ewg4ehilpt4cm2xybmo2adtcbpqsliwfe5q@d5ayeglq7vz5>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-6-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-6-23b4b7790dce@postmarketos.org>
X-Proofpoint-ORIG-GUID: 4FHJxICsQxfFK9RlWnHWiBcfnA43xWED
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c75e88 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=H0H2Q2WVq0cUEFHX9e0A:9
 a=CjuIK1q_8ugA:10 a=dK5gKXOJidcA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX+ATOQUyLf0ND
 X4bgbSjQg14xCXeNEyYETwJDL0zG+5L074n7S2r3yrv+jVF5QgwUJbWOuXJnKm3HbtKlfMNbGaE
 fWJPZhMe8MgZu+u1eJgtXUQjUEW1GLhSR44IRmaotffi8WGrRaYWjxu4bU1dvVPsfZaaFs68hog
 /+ShdLv9tT+FNE1FU9/SsScW2W176yKScNZTjKcmlEaiOR6V7kMcz/ENjoVAbI1TgdU18FWaRps
 I4fB6KJP8Vf536ci7Ia+5lXYPgN00dOqINet9oJAL+ILF6V3A2c1bEVWVnvERBsbtR/Je2CrAJv
 oS5hLVcuKbNWF0tNu2mCUGcCGfJTDT70gq8S685cekLsrdDIG3irfzpF7z/xyqsocyss3rOTz3L
 NH37y4yd
X-Proofpoint-GUID: 4FHJxICsQxfFK9RlWnHWiBcfnA43xWED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Sat, Sep 13, 2025 at 04:56:39PM -0700, Paul Sajna wrote:
> Wi-Fi now works with this patch and relevant firmware
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 1bf2f2b0e85de174959ec2467076a95f471a59d4..585582ff4e0bbe8c994328278d5e5dd3a280ddb6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -682,3 +682,16 @@ &uart9 {
>  
>  	status = "okay";
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> +	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
> +
> +	qcom,snoc-host-cap-skip-quirk;
> +	qcom,ath10k-calibration-variant = "lg_judy";

Was it submitted for inclusion? Please follow the process described at
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html

> +
> +	status = "okay";
> +};
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

