Return-Path: <linux-kernel+bounces-737679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EAB0AF49
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AC1AA40A4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8252356CB;
	Sat, 19 Jul 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l5s0HJ70"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366DE23182B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752920037; cv=none; b=bUN1xN0wpwO9NcMoxhYPcYby3N4L4wonddzs1/W/y2lArIVcM0xz8+Vi0ChqGxsoSCZRj/iRsfERR8z76zBN4xFdInrAbCC3iXF1oCrJZ1iwoG5makFRof7rwTjZxHnFucywZBTKAbixVyj4kZQrwslubsS0/T5uKFo/9Ev/1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752920037; c=relaxed/simple;
	bh=qiUKtwKLIS/AC6oCNR0gEj3Z1+ztmrRs6OEIMuyBY9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0QBfMXhrp7Ym5+jATi+PEdtev2yvrxcJfpyEUjvfcN7+ZAKWcmjnDjryzULxyQgujAcCnPStGrEjOCJdQSX/sjKLQ9IZ6MzMconu5vaUqOWKrwJFw2srunW1xygnCTkjUI78qMKL0aFL6ElLX1s/gtgNDA8ooaf+lOHb0oVZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l5s0HJ70; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J9t0hf003850
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S4AgzYpEl0AWxTCqNntXuKJ4
	kl5adod/iZySnBe6YVU=; b=l5s0HJ70cuilqnLgJTMRluwq/gFGa4gxSWV9FXFI
	bap0nl1Fh/v8cQwGmQMYoIBaRq59BhP54AogMmD3mmoWQ8hy02440CLCHyqCQ4rD
	Of6cK2IqOoVF2TtKde+BZiWCxhjGGsbzQxccKTb0QijFHbDnJixswcIiMkQ0fakq
	8iOi8n1UgVXFs6x2nbJfaWv5ks8tEm0RoGuIH6KqaMsuYUkC0mh4jB6I3D8VRB3L
	izpwPuwSSSQ+YdXZSeaWLubq/9YgR+WHA9p4F0IVN4PKNj1HuXwWjryWuYJxHWZf
	37MQAE2NkS/BtUG5yf7igYsjHSGjbEYm5Ljc3X1A2GCB6w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045h8fq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:13:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e32df3ace0so242346785a.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752920034; x=1753524834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4AgzYpEl0AWxTCqNntXuKJ4kl5adod/iZySnBe6YVU=;
        b=ljTrGIraiybGZtwZivBgb7khY44S8kcF6+dNXGkbpjCZ3mXc/c4y/Qsn80LeIn/FgD
         s9n2+osVP6a3vQeIN0cx8BXRIyUox8Ehj3j5x8x64Be+CnPz1m40VAO1Xw6eGl9DobBN
         hODs6lT4zvFeoLPA8JrqGa0+c1W3J5IRFtgQIpIdUDjasn768bvcbuVab/7s15gAZStm
         AYo7g5y79LQbDcc+SLqWq/3cP8H98UEQBveN56+bPQAhn6wuDzfMFu6+kedL++GZtvNg
         JEax78srWzbJUHpBVj8rou/g41qDbewXM6t0o9ZzpfqM9srUhahRTq31mKtfTEvAEW/F
         z0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVrC/85cAEcQmC0MsxOHoni574Xs6Nd2KprGgKpVSfp+35xCNG7R8dEK1Oj4UqtiGqPxsRLpW67ieFXQY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPC9wFivUQkGXRQI3fc246j83QmKLoFYJLW567li6md9XcQov
	1EhFslyk2/QG6V6ac4NEDUd+oboynHcRGxYQ7tjOdxCilJCWG0s0SbKQt2lviekfM0oeKmqRrxZ
	T1khd64mvA8t2pho/2jph9disbiqPbc/SXuHtCLvi6XJEgFO/u+rr4cyZCe6oYXk8m2U=
X-Gm-Gg: ASbGncthW7t55MPaLtlCEz0Mx3D2ZTvRwwp0a85U8vBIScLtsqNVeSb6R0Cfwq3srKV
	KeDlzv3y+SZ7dCIbHTGQzfhLVdF7a9IgeGR9ULDUP0gW9dOowXI6WgehIl/vbdArbwaI1a7qUpB
	X0WofnEGXYk8D8pO4s8RFvY1Va2PwXo9TvfTCSdUHmOdN4v4ybMdzr/edZ0apa7hSukCwndwygv
	6zS5YSSiVO+1FsYUZLXhfrD8ZruzSLHecPwoTZdhGBR+hBVsFV4lRF7V3bet1jXNMQC+srOB+s7
	XDKQpcoz0JUwLsvpCVV+ukqEyK+A5xYTUlJuHjvEVoFIMSriGDwyNzljI4z0TW6DVvAgxB6Vd+V
	/IOi1Bg7B/72sRmCQtaey/v8uWGzYhZBFvYjuWj8k57wT/LXU7zyH
X-Received: by 2002:a05:620a:40d2:b0:7e1:3ef4:8f3f with SMTP id af79cd13be357-7e34356d80cmr2062275285a.13.1752920034009;
        Sat, 19 Jul 2025 03:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1EUzMDuu/9hxGLGzLUhkSlnBNBYEs5KIbjaoIgvnK+bEoH4cV/3yg9HAxQUy3UD49tFm1zQ==
X-Received: by 2002:a05:620a:40d2:b0:7e1:3ef4:8f3f with SMTP id af79cd13be357-7e34356d80cmr2062272585a.13.1752920033633;
        Sat, 19 Jul 2025 03:13:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac7absm657229e87.75.2025.07.19.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:13:52 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:13:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs615-ride: add WiFi/BT nodes
Message-ID: <smnw6whsw5todddsoveeanohcaesfip27udzkbw5wk5dwlztzz@ic3xemwrbjwg>
References: <20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com>
 <20250707-615-v4-2-1a2f74d167d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-615-v4-2-1a2f74d167d7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZtDtK87G c=1 sm=1 tr=0 ts=687b6fe2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=S0F6pwWdbPyMd8weovAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwMSBTYWx0ZWRfX951dRxELAWXe
 mqUTmYk4pYxYP+/9Y5trdzfluXeGnV0mpx55F3JEWs/eWEvGdWbh8sGEG8rCASMGUjNszwmwGGX
 WCIZqxckYazLtWlNkvgI2V4ol8RIV6DhWX5HkW7O73PaIz6/aUhbmEOMmD0dBVYEwTznIhHU/GI
 Sg/l2lKFrkt/zxBLO90raaw9JN3fXKrt7rIfOtjCL98Tg3U+C37lRXe3dL0zUT23xuNC0gCSQ5O
 IgnOTFb3CqSwnvNA726H9lR+EEWmGEwQYolwDm2WHzKqyOisO2OsnymY4qdYUPBSGR2Ac2hJRCa
 JXsEtZ7efoXOhr+adE8Pe58zYld5FkyyZSYv9lwObhVzl5whOSmmO3ckL+G98ygVEUxFdB3LEVS
 D/zrdqHxHOhk00tBo1/fZNGAPhmh6BeQTLqMmO8m06tXNG8o8WiObmQS1Jc0gUF1NbQDfhRK
X-Proofpoint-GUID: fmC13YMRWXgWw-9qM39fDmx4zNuKI86f
X-Proofpoint-ORIG-GUID: fmC13YMRWXgWw-9qM39fDmx4zNuKI86f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190101

On Mon, Jul 07, 2025 at 10:51:06AM +0800, Yu Zhang(Yuriy) wrote:
> Add a node for the PMU module of the WCN6855 present on the qcs615 ride
> board. Assign its LDO power outputs to the existing WiFi/BT module.


What is "existing WiFI/BT module"? There is no module in the DT. Not to
mention that PMU is a part of the WCN6855.

> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index 011f8ae077c256f079ce1b07720374a9bf721488..2df8e7e3c1d3b6d6353a6753b8387c7411edd927 100644
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
> +	vreg_conn_1p8: vreg_conn_1p8 {

No improvement. Please try again.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_conn_1p8";
> +		startup-delay-us = <4000>;
> +		enable-active-high;
> +		gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vreg_conn_pa: vreg_conn_pa {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_conn_pa";
> +		startup-delay-us = <4000>;
> +		enable-active-high;
> +		gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
> +	};
> +

-- 
With best wishes
Dmitry

