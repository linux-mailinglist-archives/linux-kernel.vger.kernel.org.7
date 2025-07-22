Return-Path: <linux-kernel+bounces-740260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E5B0D1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AF51C20F13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9628B3F9;
	Tue, 22 Jul 2025 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jg6WO/Ty"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451E28B7CC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166339; cv=none; b=G5oTt1zYdswB+Smt6w4jjBAMpsm9TU96ntXvT69u6dZB/ZBTIxCe33ecw39jmiz5pxK2KGsNVekaOXc/sRsoc6mGkAuyni6XE61Vso5N5TYaniOhS1qvLX3Ox0bfiqsPVMLjsgnLWu/CtwdbiWnvgB1HlWT8i80eug1ZbOf4hAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166339; c=relaxed/simple;
	bh=nv5BKzMmeYS+0BXgDRxTOk3LBVpA0pyOQkii3cTST84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGvucfqXNMloyNVluX2ufCv5daCWFN0ekfFe7G3m0nazc9M56AcUWM8VXttdH83CnMkCNqLOV+oKxWgJCj9u++urlkU0UfNWBy/g61R9x1S9tWzF4PxxwcIbDdBG3aR9wvriNoQmNFQRjpajzW/yXFSXq/G2CdR2Dj0zZPWgNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jg6WO/Ty; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M4djGg016432
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/kicygk8G+o72KNhMNo4zmHA
	GE5DDAi0EuNll8s2Q6s=; b=Jg6WO/Tyg2KEvvMGE/UJpTDms/fv4JM6NV9XWaNI
	VaAH0jpwTWaLRmyQH+Fsekhhhb4KZgyf5q62+rgWZ/ZlBOBOnjisJauLkiJLBZb8
	ouqwQFVltc+SL7EWq0NL1ng6+4AMs/0p07ttFZH8gKuNaFZOJLqCI9SIL8n/2TXL
	lCxollu7u9dMckiG7BBIoonmeX6zRXhfHQUQJTErI9rL0D5vFeM8BFGMg+x+Yxf0
	sJQu3vaEp6W2o1zMT8WrFNo3lyQHD9rtoTpbc5yXXE2qawbf+SUCdoa+VBZy3sJ5
	8XWjgSC1OqvFudx2qE/rR/Jdj8YFxbeRq7Gnp6XzS8K8AQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451g6j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:38:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e1b84c9a3dso706411585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753166335; x=1753771135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kicygk8G+o72KNhMNo4zmHAGE5DDAi0EuNll8s2Q6s=;
        b=wVrnThxAJPXL+IApN8MJd08hXZpix1xIoHKSr2ser8LYeYS0s91+e7TC1AKtQ5xTL3
         pwmiaCn4BI4brg2hmFQJMnK/JKTf7CfJWjsJktfl7LhvJVmpnlAF8R3euiZo1onjt2E4
         AIbj4nitm3FYelpUpBHNMjtjLDEHJ+5qyvJ3CGQPeYOpY1eV4sn/qAWwCAXvExozQljm
         F4kPshq9o17Qkn7c8Y489/vKc+r5/OwspFhhwxrs+v2LPksMZAiaFFx+zOZ/6mF9bpYv
         t8t73rDr/vTPOh041HbmqsfQBWYaDIzIkd8pk76DuITrMvsYnub594EljGBLzh40pjEO
         0h5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSUUzcB5DX61E2Pv3Gr7ATnTc2GER8lDcR8t3Atiz0Zs6zfpt/bLxpQ8W4q05NIXj4qUGZUnjBMK6yF1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zHI9rLyQjt4OoigKVQKnc8Xr5M8dX3v46OxPo+AHemD43hEA
	c1h2HaAZgDhZATJy1RHzf/g/1R2lYFmdOYcYB5B4NOdwkiHzUuJxkbpKegMQr98aCCRne+ANT48
	SjCyEIp3p2/VxEqsgSqqabKsi9KJhYDMayUi29dJu/qFD1xTZvHNu6eFlJ5V1Gm32jow=
X-Gm-Gg: ASbGncub9HaKvL/70F6l+toz69iF/Wq+l9IV0ZmdutBIxzSZTLluGv+jvSTNG9DP2YP
	Hs954XOR5kC+FcIyR98bVXwjTXGWyO94Jj26vg1Gs1TQ+Yiuy2aLcm2bkt9COgZDKzO0TBL9m5v
	ydVEI1Tdu7/t1tOl21rgYXcoHUrlWlQa7aGZWY68ovKx5ICSn5ozuasDIw79Cy8A2LKAzmI+jdy
	GonjoCCXCMIv5wRSfMX4PQ+jUaqu/mAvaDggHhvGLOD45sAIK9Hyk7dN52Pe9vC3wa13SyJTecK
	UJftHUtaynpaIrHmom3ZN6AdFm26rj4ipT1hNS/lqhXSd3jVcQTGaYMEMxW8XE9aIHZtqgvWFsf
	Z6tIQEvbZZJaYkha7LVqb/nWQza79YcKN6nS40I7TQRM9sLwRldPp
X-Received: by 2002:a05:620a:2943:b0:7e3:3ce3:aa3b with SMTP id af79cd13be357-7e3436146d9mr2995286485a.47.1753166334537;
        Mon, 21 Jul 2025 23:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+MyPilAzTwiXG6RCCwG1+kBPaTSqsi6NwSEYBQbTso6ft4Xw86uogd9kxCGqOLTbwSZaEjg==
X-Received: by 2002:a05:620a:2943:b0:7e3:3ce3:aa3b with SMTP id af79cd13be357-7e3436146d9mr2995284885a.47.1753166334064;
        Mon, 21 Jul 2025 23:38:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b1bdsm1847924e87.19.2025.07.21.23.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 23:38:53 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:38:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: andersson@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Subject: Re: [PATCH] pinctrl: qcom: Fix logic error when TLMM reg-names
 property is missing
Message-ID: <ximweq3tsedvocc2k2agl7gmckcvttsyiwcer4wjfenni7t62b@7bkvchfxm6a2>
References: <20250722054446.3432-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722054446.3432-1-yuanjie.yang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687f31ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EcN-t1bWbtBV2Qjh4l0A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: t-sWooZBsutH5FaWC1_y6q_T-bXkPFCB
X-Proofpoint-GUID: t-sWooZBsutH5FaWC1_y6q_T-bXkPFCB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1MyBTYWx0ZWRfXzEXMxlRS8H4W
 0Y7m9lDVzmF7shECkeFbQbqZNCRDkQLbAqpt7kyEeVzf4nw4V4Quv/sQSxTFDCWZrc/2lSBA97P
 cm8p0n5MqsqZonkwlG6DAt0xRKrOfca6r42lM9d8pKtKiUaXuNZGGnPR1WA5atmvejZLvkyVvrA
 99gg71vP11pqIaANV4RdkCVuWDfydgz8vaB/BDp1lbVmDjAHEj2d2181sVGlliqWzpA1zb3IzQq
 SJtzCZthwd5nN30STpJ1X4CyJPbTqSjUubjlCsi/kbQ4v0yASAK8mhbFyMb8Ari3AM2DSD/Zr/V
 meLHPLgx2PAa5xlrkxeEtLptidXJXKcO77jmgdIEu9TaN8eZB+4iSLaBSHEpBtGvDsmffM9jzHR
 z8E9g4FRaZcWzOm7QZM1HmgWr5lwgLiB8zhI8aLQhNOKI9dTorYk/ljIEeF2lBm8rbsvp4lf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220053

On Tue, Jul 22, 2025 at 01:44:46PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Some Qualcomm platforms, such as sm8750.dtsi, define a single TLMM
> region without the reg-names property. This is a valid and expected
> configuration. However, the current code incorrectly treats the absence
> of reg-names as an error, resulting in unintended behavior.
> 
> Refactoring the logic to handle both cases correctly:

s/Refactoring/Refactor/g

> If only the gpio parameter is provided, default to TLMM region 0.
> If both gpio and name are provided, compare the reg-names entries in the
> TLMM node with the given name to select the appropriate region.
> 
> This ensures proper handling of platforms with either single or multiple
> TLMM regions.

Drop this sentence.

> 
> Fixes: 56ffb63749f4 ("pinctrl: qcom: add multi TLMM region option parameter")
> 
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

No empty lines between the tags.

> ---
>  drivers/pinctrl/qcom/tlmm-test.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/tlmm-test.c b/drivers/pinctrl/qcom/tlmm-test.c
> index 7d7fff538755..6de8cf23f9f0 100644
> --- a/drivers/pinctrl/qcom/tlmm-test.c
> +++ b/drivers/pinctrl/qcom/tlmm-test.c
> @@ -581,25 +581,25 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
>  	int ret;
>  	int i;
>  
> -	count = of_property_count_strings(tlmm, "reg-names");
> -	if (count <= 0) {
> -		pr_err("failed to find tlmm reg name\n");
> -		return count;
> -	}
> -
> -	reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
> -	if (!reg_names)
> -		return -ENOMEM;
> -
> -	ret = of_property_read_string_array(tlmm, "reg-names", reg_names, count);
> -	if (ret != count) {
> -		kfree(reg_names);
> -		return -EINVAL;
> -	}
> -
>  	if (!strcmp(tlmm_reg_name, "default_region")) {
>  		ret = of_address_to_resource(tlmm, 0, res);

return here and remove braces around the else clause. It's strange that
you didn't get the warning about calling kfree on the uninitialized
variable.

>  	} else {
> +		count = of_property_count_strings(tlmm, "reg-names");
> +		if (count <= 0) {
> +			pr_err("failed to find tlmm reg name\n");
> +			return -EINVAL;
> +		}
> +
> +		reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
> +		if (!reg_names)
> +			return -ENOMEM;
> +
> +		ret = of_property_read_string_array(tlmm, "reg-names", reg_names, count);
> +		if (ret != count) {
> +			kfree(reg_names);
> +			return -EINVAL;
> +		}
> +
>  		for (i = 0; i < count; i++) {
>  			if (!strcmp(reg_names[i], tlmm_reg_name)) {
>  				ret = of_address_to_resource(tlmm, i, res);
> 
> base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

