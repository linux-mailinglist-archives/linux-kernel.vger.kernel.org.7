Return-Path: <linux-kernel+bounces-737644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DEB0AED6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C61A1AA7C73
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DD123716B;
	Sat, 19 Jul 2025 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYluWSHX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE381D90C8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752914333; cv=none; b=Pfn3HaXPNG4qt5Px/NwkNvlEQulJ2kOXa/erM+N+bD43iZ6OIYxvVK3EEyz58+6F51y3wyXXkxAImgXKeW00I96P4gC2T3PYShUcM3e27nEU+ycdCa5HuC4BG9KqZdZQFoOuIb1iNcRDT0bJeuykPocpzYn6505IhLSyV44Ka8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752914333; c=relaxed/simple;
	bh=Ur4VPWnq3uw4FdWmt/9pK+hBwvb6OqyunFEN7NVZwmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkMz/2l6sPIZ0s7VcAnkCRf14NvY3yVP9hQaTP5E+RbRD9oafsOcB/dIY3ih4Mnv8KebmKTRrm64/UXgJFPpIiIfk5gI3MmeyLvYsH/w00Stygijn3TRt7TqvyKNka8E4X0uc+KfrXl443iJ7VFbsWxkqrUtYcqQ7MfyqcSA8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYluWSHX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4Mlal017248
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=glsksHZF4qm47GLf5Dr0eBBk
	p9qudOP0OhFzI5tDeNg=; b=iYluWSHXdy60NCiKDZwACKpvFtNJB7W1ALMHW34Q
	KWZL1uZi2Xvln8LjANXoqFM14m4qzLWEtgZqHWl4mOiPL9B8PVnVEvV8J+QMHJoP
	sadZ44Zo8vACLx3zQt52G9RB3H+1VIa3/1n55zFrEoo4kWQuMGoeCNm72HD/RUKg
	Faod/Mi9FJcnp1VS3D2wTDtmmScXmZWwwbOwC8Ryk+3Z1tnJHcBE0BU3sCCpl9WS
	kCJMjeCa3CWM+H6bInMXhNGdCNualDhnbp/suXLC9OgdHTGFCDUXV0ysQP/KPIAj
	E3IQWdDFZU8E2hsOEDUyAVJaXAqte5NIgwn2248M8yIrow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048t8b9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:38:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3c757b2bso53757821cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752914329; x=1753519129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glsksHZF4qm47GLf5Dr0eBBkp9qudOP0OhFzI5tDeNg=;
        b=JULrplPNjt3GrIw5Ms1xGEOYdxdt4kI0qev1dicmsHtA1Ih9CZtGs+5RAtGdMJENt6
         kR22eC4p7MpF2a1g96jComzm+qTQTujaxAmbhvtcJQgUN1t53akcr7oxcH/o9xjccCJv
         IDfZeZXp9mLZ7JRk2/OxCyASityTj7lMCP6TOVBeNGu7d7nh3Qi+PLY10b1lBB43egl4
         1QrWgDR4uk6l7Y09fl7VjfQql9Ia7NIqId66dCObG/7rH3l2vJBjmCYlpnbPIJ0vf88h
         SqLfnclWQp2RSWpg5iuWZu+HmdsdNL9dqynTrjEbjomAbOutu0qUp4voZ+86BPRCbZ+f
         DMiw==
X-Forwarded-Encrypted: i=1; AJvYcCUo4izPa2kJqCmLunjRrPfaT+HL40cHIziJxO8nlRVzqXlGPxJNO3cK1t4RTsTLDI4UgOao6n8orlyXSOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVK2/7QtA2WK8ueNCzEmLHl4BQIxX/3JiQ+b8w0CsPvPLpx+u7
	5D+pcuRk9d8Pck2KXfPIoL/6YCn0h3QM7peTuILNfgYgH6pMD0K92uTFWvsthcGS8vnp7epBLvw
	zKctlVNdzi+/OjFfSf8ILps8gj8Dz0j/9Su98HEy9LFgXQVEpYNnuombT4b/OssCuVoE=
X-Gm-Gg: ASbGnctXJLTxS85UkH3/zerIFh1LCavqwouwNnFrffp/H4m0m8n1wBOLKlcR/5HNxEb
	xyeLe+5qg47kvps3+Oyna9fugDiWM5g7B7PJ8HJiOW8lh6O9DN0la11aMXoPZQ7RC6b3f259BJj
	9UdmUHX5zN9YkuqTtdHdY+n+XWtIpQ5EcdimQOdDFMI18viQMXVVqY48HqHpn+/1+X98i3l5UgB
	fvHrL5evU+MEj8SD2jYyd/LjiTjTUpjWUR67SIB1K4wuhE2DFbqORWk20IaVUEJNRJ7UFZmzJb5
	eOWk1C8vnUUhVXfKItOslKggSGnsY50CYJmc+DEBZRwjceP8C2BhtRkMc8PBZygpsivXzdXMqfS
	BO3KKupaTha7ZiixEfTh+u+dukf84c11JK+xEL4YsiLSJU4O+b34k
X-Received: by 2002:a05:6214:5090:b0:704:8f24:f03d with SMTP id 6a1803df08f44-704f4825428mr238950026d6.16.1752914328910;
        Sat, 19 Jul 2025 01:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQsvNQe0y0XkePnP7jlgYK0y9weg7ronQqAfB9AOD0zuVM4AIPd7Z2x/hqwuEfSMzAV+Y4bQ==
X-Received: by 2002:a05:6214:5090:b0:704:8f24:f03d with SMTP id 6a1803df08f44-704f4825428mr238949776d6.16.1752914328437;
        Sat, 19 Jul 2025 01:38:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a911b775sm5216151fa.45.2025.07.19.01.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:38:47 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:38:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        kernel@oss.qualcomm.com,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 7/9] arm64: dts: qcom: qcs6490-rb3gen2: Add sound card
Message-ID: <iuojvg73siqfxq4ejv4g7o562k7i766bbpg36sxsljq7z7tqrs@ueqfdknfp5zw>
References: <20250715180050.3920019-1-quic_pkumpatl@quicinc.com>
 <20250715180050.3920019-8-quic_pkumpatl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715180050.3920019-8-quic_pkumpatl@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA4NSBTYWx0ZWRfX73BBwdiuGyyl
 1/x5nEZFo8qW2jCK4ffYEb+BYkbYdV2MG7dV/RWQbQiWJMlEUpcjLT7d5wicGAg29pt9UoeZ8wc
 ZIM9etNivpD4W49Af1nsMKPFro21cZdU7YRuCU9BVBLuI8VUMIZ+2H63dt+LDF5gddEF0aLim4u
 sOmKsLI7k/tZ/xYsH3BeF10AveeENvgCBZzupJP39IlkmQVNLRADKkKHCPokXWTwDDw3MBI3VI8
 Soj37ntBlEWTeGzCQgcWvuK294MCyBbdPb+2Z2qoOLtNIN3EqN+cY5sorT/wNmJs9iizxquEOog
 1RV4f6AVqBo2qOW9azqvO71CvbOOmIGUcszVDhpigcQaX8a/BS9YE2so/5pnhDuhUoUasmkOVQU
 eqjRc65VyyptMp7W6mY6LkiZpJU4pcnb5Z8Z1VghpHKCbVvRuKoEn2j7JJzcGZOTyWHe4edH
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687b5999 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=rRvH8sadIMNe52h8dg0A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JxcPot-GVsqFySI3iaXuJlMcGBCu_Xxj
X-Proofpoint-ORIG-GUID: JxcPot-GVsqFySI3iaXuJlMcGBCu_Xxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190085

On Tue, Jul 15, 2025 at 11:30:48PM +0530, Prasad Kumpatla wrote:
> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> 
> Add the sound card node with tested playback over WSA8835 speakers
> and digital on-board mics.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 45 ++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 82aa69d715d9..4ec3501eecdc 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1048,6 +1048,51 @@ &sdhc_2 {
>  	status = "okay";
>  };
>  
> +&sound {
> +	compatible = "qcom,qcs6490-rb3gen2-sndcard";
> +	model = "qcs6490-rb3gen2-snd-card";

This model name doesn't seem to match established practice. Please use
'QCS6490-RB3Gen2'.

> +

-- 
With best wishes
Dmitry

