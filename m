Return-Path: <linux-kernel+bounces-746741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C1B12AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832C47A34F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C081253F03;
	Sat, 26 Jul 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GG95piGR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C075253B66
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535974; cv=none; b=piQky7tU7ChWhDvMlfw0i6JM6fzJYeZZ/XolOsoxJ/cTvtXnnAni7jkZ7ts/GxXbPuLZMIgAe1CeFJQUHNpx/EHdowu2rsRAXmdcL+PuZm6JTAgrVe64dABFVSh6Th0xxgnUTiNVkOecdWvP3jiMt2wE5Vt38SOLzy83dz6nMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535974; c=relaxed/simple;
	bh=kS9mTNecFI8kxGYFVb6bjLud3Ye7vR+V9xS9j4LHP6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJReG4Y3x8DjlIloMjuIgp19Zt0i8ppTnd5o5jqA9cESXoehb40diaWa1Z34oLWUi1iG/2qPATLjNiuVxjeKoiW4U2zWw2oRyxmeXrlCHvkqg5v1hEHsWwIzdlGGwYJ+B7jUtcusYtWD5qM2GsldOcZCAGxfuslcAm87Sx8OLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GG95piGR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q9M2Fp003942
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wKlRx43bg26GnzmWCYPgxvkf
	BptJ5iTMD+pzuCHYoZo=; b=GG95piGR1Nr7fWfwhZdOyz5BftydJKVBeLiAIod/
	4uwit/XW9Mj5nkVIjJACv0PpfxgeN9cyPGmBjeKD+Lo9jae8QNdq6Tv1mPcVT82c
	PRv8wiKsULpFc/rcaMBiVVeryA3Zbn3ePxJi4b6ORtQ5fX1wPrkoWpzcDy9/3t4R
	NRdX+1EICayksXj2pTwys76gL/AiaOAtQ9YMKN2snnz3Z39xFrKu+zPILzglJ/3U
	YokN/pZbaQCjkyQ7n1BxTa8RwDBieUyd5Ni1zZBY/Wt5G3GGFKR1c31CY9AnUqVP
	7oISdv2xTJMn3bEX21ErP/MxO/FZv/KRKNiFr+7U+aBLOQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1a8qn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:19:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70739adfaceso2218586d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535971; x=1754140771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKlRx43bg26GnzmWCYPgxvkfBptJ5iTMD+pzuCHYoZo=;
        b=wiTRMQkAKoMrBeQoW8/nx+oPnW7ChvnOT+PeEQpEHTm58Po8xJt6KoR6qUsnwxKIl/
         jYxSICZqb3SHD1Yg1V8q9q4bdsZNrbkQjCfF929eYSBW5784UScnI0v3SkGr9iDlkYpN
         lgG797qlN07RxxTrc3S5ONQnKGNWsfS9FQYEw8MC3sVydypS8k91F50QizxB2a0Xo+XB
         8F8psFiKj+852UJ8djAWfarkFzkP08u/TXWRut3uSW40ZT3RhOBiU6gTwBau0zFpUn5E
         BafPRVk818J7KM4dN97s9KeS6dAAXhB+Uq9c4QPzYAtPwUChZLaW3ozE8F2nTu8Gfavw
         2p0g==
X-Forwarded-Encrypted: i=1; AJvYcCWa4ZFxDTGhs3peUOWn/Sjvmbg8UD0BbX2C8JqnWLrZFWRTBRRGHhehadgo7WH1Y593sAm5KZGEfQS0hhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxakSxw/pr03rC9usTjh7ryW3Wmd2gKTfrl8eM5s95nQVa7Y1rk
	hdUb0SMuNF7k3zhpMiSuYsqVvOevT7MVYFqX0lul3COM3uId+M4N4MBau2ZY3UphuBY0M005Pbb
	V8gfc1+qKNMETz8ZTVpeG3IX+q+SGfLQaniPWWqcPVht7cmzpMU4HN9wE3Qw+dmWh9t0=
X-Gm-Gg: ASbGncvS0tgQ7Ku4hccwseHk5/7QF+0ZtzxSH/mincTeA6xu7yPjV49XeLQCoRpJWFt
	LmoWi+Xi9kjXg9ebMkpXZPBsMelyeh4lSc7BkyQQggyoMBjejG7VDejKGoXnE29Fc3W7YjDlwIH
	OolfgC2Y82WU4lX+b2/0zXJmzLpUGqst9rVS+laD6QSFDd8e+zj/xOHai5nnuGce3nxdgaOG/lz
	gOQPKBkbIitsyIJTz/Fd8z40Oa4EJtsZPNTDQp96I4/xQTgr+ACJzG3MMIvl1hwMt7+1Wsi27LJ
	CwH457UiQe/uuOa/rovavIFxQoH8VnWcDN9eBZg6Qia3+O0i8CHLyvLnbKOeDVxzPX7iZJZ/AOl
	Sg//cbzczUAwAXWpVla968JnEteht0/SwL6gJ453tkXsHQalGJb35
X-Received: by 2002:a05:6214:c64:b0:6fb:265:a2c5 with SMTP id 6a1803df08f44-70713d6d5d8mr105345646d6.17.1753535970987;
        Sat, 26 Jul 2025 06:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYWwkI5Fe219W83PqY4wtTeraw4eW8iJd8EByOKtLD5K1fGPdGZVddIcafeBoh4bciCapvXQ==
X-Received: by 2002:a05:6214:c64:b0:6fb:265:a2c5 with SMTP id 6a1803df08f44-70713d6d5d8mr105345346d6.17.1753535970543;
        Sat, 26 Jul 2025 06:19:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f407e39csm4495121fa.1.2025.07.26.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:19:29 -0700 (PDT)
Date: Sat, 26 Jul 2025 16:19:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: qcs615-ride: Enable WiFi/BT
 nodes
Message-ID: <ad5d7zx3ztuouvqediihpj6ukmy7dvl4eampuirp5r6ftr4lh2@6fkebmfj25yj>
References: <20250726-615-v6-0-42b8150bcdd6@oss.qualcomm.com>
 <20250726-615-v6-2-42b8150bcdd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-615-v6-2-42b8150bcdd6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: RTC6gNOCQIwqMeJPEaGYr2ZOx7fp1IOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDExNSBTYWx0ZWRfXxsWSYnpogJKy
 sgtrP5dN0x/NKESikFCHirYOGRp7utepwqOPSdXhG2T0u6ws3AcqogitEqJq5FxNuixwUWt02/V
 VvgXWMrVDwBFH8NhasAbRY+2CtH8dyUbyPAsUh/fmmMPDiNWVJ8MknX9kHFxpwsSELw1ISSy5q7
 05PLxaNUeYluvufXF0JseZp1VcunL05NSo9gNUw6jT+VRkpuqmHMmYI9k/FzevxCIubNihQxmwY
 XFOvCYdkuXKWG8nEetWvxGZIEUd2/uILf/8sSeBqy0ytMYKGdGg9qWfPZqUCoQC4zhWbUQeWplN
 CaPupQlGm9HhROpE9DxfDdABioNQAt2DGD5RWOi5vdfj5O1GUqFmxMlnFZ3f+rOJKxk7pK/k3sx
 10JjywhSBQB7Fl/kXPmj8rDCn0zmpX7eGhAMY/0NQOEQksz9ab5OccXmtXwPzvXfcAfr+5DI
X-Proofpoint-GUID: RTC6gNOCQIwqMeJPEaGYr2ZOx7fp1IOY
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6884d5e3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=15mc5X2mdMWtrc8z2E8A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=951 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507260115

On Sat, Jul 26, 2025 at 11:31:31AM +0800, Yu Zhang(Yuriy) wrote:
> Enable WiFi/BT on qcs615-ride by adding a node for the PMU module of the
> WCN6855 and assigning its LDO power outputs to the existing WiFi/BT
> module.
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index 011f8ae077c256f079ce1b07720374a9bf721488..f6df6a88adc8cdc416a57d38b8eaabd53fbe3fcd 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -18,6 +18,7 @@ aliases {
>  		mmc0 = &sdhc_1;
>  		mmc1 = &sdhc_2;
>  		serial0 = &uart0;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -47,6 +48,85 @@ regulator-usb2-vbus {
>  		enable-active-high;
>  		regulator-always-on;
>  	};
> +
> +	vreg_conn_1p8: regulator-conn-1p8 {

regulator-conn-1p8 < regulator-usb2-vbus

Please keep DT sorted

> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_conn_1p8";
> +		startup-delay-us = <4000>;
> +		enable-active-high;
> +		gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
> +	};
> +

-- 
With best wishes
Dmitry

