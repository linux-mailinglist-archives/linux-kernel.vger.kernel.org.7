Return-Path: <linux-kernel+bounces-771518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DD4B28858
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BDBAE214B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEEB246766;
	Fri, 15 Aug 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bgjyUAi1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B1244690
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296587; cv=none; b=RNUgauoiJZznEf3H4bTvchTKNDqz6sTap57uEQBfN9BKze+CdeEVaLJ/eSRd+3Qb7o1OpfenQQhvRCe67++eSe+h+qiYqW6gVDUAHUZg9swB4YwPtQZPLZhatBTtwlWQF9HFROBJVPCwyeTWFFAjER6q5WbXAijPnOMNLVjJEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296587; c=relaxed/simple;
	bh=z5y1xrIOBWXl6IIalqIL8dvPoAZYICW3mCEt+J0KDfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcMw5Ol0SsO1+8pIxfgrV20Vc5b43h6DZSoeOHEmeWC67Hc2MnYMckGL7gEL0jK8xQr4qWYRXXxR9hiMMvQKYUO3h8PPAuSk6FSEMISX46XRwHxzZx7BAMV+VGF7+uKs8S9a/sJEiMMvi3Xw5FHmX7RZgmZwLC4VkiALCel6/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bgjyUAi1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIqMs005706
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JPoqrG76Fa+IJ69XT6fD+NUhuJLanbuSb1J5gF7obvU=; b=bgjyUAi1oWHVp/Jx
	8+Tz+gwEf2MKAx+ZsTVEKOTKcqL/MUqWcbHpC7FH1+FfXTRSWAS3BTpEzo0xOmKj
	Z741Z0P6eAoFegyjXV28v9NMfIb89usjBV57HhgYAwRKiU9Qliw66EeKPQt5uzQf
	fi4amw34pK/R2X45JyFCnbe8i55Qk1dOWYauH4Nv4tTfZhS19RW6xpYCRVYJ0OyD
	z9nvvGdd2hxsxs3bt4lmC8dsYf8ZgHpOXsgBfm2wO0yZlHawC7IX0nJXxyNbVIv4
	LCsQUc5cH3gnkvwW6S0gQ7onmwnRMuoHgxrSj2D51jtWfMzZjdEm5uTrt0UfygvT
	/yMMig==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbqhur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:23:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f55836dso53973466d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755296583; x=1755901383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPoqrG76Fa+IJ69XT6fD+NUhuJLanbuSb1J5gF7obvU=;
        b=i2A/Wl0xPUKuBoWhv483RSQV/UF8d/ZwD76XBqFTPSXT/U/4Ek0c5aBjw+VzLlytXa
         v4nLIrTYgsgqHrjCK/+3P8HxFb0nVdISUZiXPjOjEuYmwAmtwbGYzWL5uhRZARtJko4N
         LguFW4/P3jlyu606sD7SUvT+3ldlg45sFHvCtbkWZlyUYQ4sjm6dQ2lTy4BlGY2guuaO
         OPPHvmJ4dYEdiLmJXBOW0STjFpRchwHBkY9TFMN00ftFCgEuU3ejzn8RN82xNsLBjxQo
         P0sTHhlhs0LmAcpcZG0tNGPE3jv0sZ2bj/JPTFzFXZxZrhcvMQMplPhZeSq476xls3mK
         Y7VA==
X-Forwarded-Encrypted: i=1; AJvYcCXNJuP7QiRrg6CtxpwdYNuirBdKsOxn3Azy3NB80W7EM/ZiOvdlmvLOGpbEJnzjs2zgv8mlbiMMHWPKL/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzX/rYOllr27AYAwAPVGbCZLM69iasc3luJLO1cMHOl2DeE7aV
	IpormKQGTQhNxn8fyzU/kX7lmGTuaNEQFJmfhqXObOgwc8GLO2TYFRKN+hxDp16u2p3h/TaxLhD
	YIvTu7To6Bq5QuA1uca5S7TYteDC+SYU8pJ5iqK+D7CsZ4MWmxZv682Sm36aOkqsshkY=
X-Gm-Gg: ASbGncusqyKeUhv8xIDoJh/emc53v/CORMyQRd/igsE2c/2i3IdvoRvNiDbYaoIHdBc
	FBt65/DvI4JbPVLtTHLq5ZUP+vRc8rHotidHju+KSoGjrZhRXI0IpRyqemV04hNYYsqd0izWTE5
	Mlf1V2Przko257TRzLRIjXGdZi1PD0k+7sN6F3mxMgu49xS3WLwSL2kV+/xIDwvc+mo/Awcc3FP
	8y7Nw9VoSZ0eVnq35R2fnMEjgtAO/plfZWBC82hHZRXVHVM+DE5kJscdk2j7IhyY5KXB4BSMYll
	TDQ2WOM5KWKpHpg1yU98Ya1zLEUfB14odrfSRYQPbWyjEHnC985RVmMf5IqpfYRuMLCld8kDQnQ
	E6/bqshNuTq9uWbBzLQ==
X-Received: by 2002:ad4:5f0b:0:b0:707:71d9:d6de with SMTP id 6a1803df08f44-70ba7c3ad53mr53884196d6.36.1755296583121;
        Fri, 15 Aug 2025 15:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFleBuWAy5mTXP7RbCTDkEBzEH4bx4YRYK1jQyBfG2qlZcDy/NOHJR86cvYBPpQ4zK6w/3KsQ==
X-Received: by 2002:ad4:5f0b:0:b0:707:71d9:d6de with SMTP id 6a1803df08f44-70ba7c3ad53mr53883776d6.36.1755296582437;
        Fri, 15 Aug 2025 15:23:02 -0700 (PDT)
Received: from [10.178.110.229] (37-33-152-67.bb.dnainternet.fi. [37.33.152.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc6c5sm510042e87.106.2025.08.15.15.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 15:23:01 -0700 (PDT)
Message-ID: <3d796f6c-d1d0-4499-8e63-bd37bfcc7c3a@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 01:23:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] phy: hdmi: Add HDMI 2.1 FRL configuration
 options
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
 <20250805-phy-hdptx-frl-v2-1-d118bd4b6e0b@collabora.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250805-phy-hdptx-frl-v2-1-d118bd4b6e0b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689fb348 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=bUxD0lY5qGftl71vRM2jGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=QX4gbG5DAAAA:8 a=Wdy89XEDvX1HR8FnkzIA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX91noAGb3ArSH
 SO/NfYeWOOQTJougYZAdw8KnK5+ZqA0l3zVMbWzipOGWJAJXps7e7dFRgQha2U31HPZghGzOyir
 t53gBHnzCrM8Ydp8E2mhrTeDhsLPSGtpQMLbTXM/q5jG6xV6zObtdfXsy7UKzz4UYLH04e/VIWA
 tHNp3kfovi+H5gTkqNq3ua15d907bkHs+xRfSmMOE+EctdYU8Pk1Vwr8vk2I40YFJGE3gFQWImW
 Nio+LQphUxMdjBYhF+n7ya6+tZzzIQZtC348naDcEWymvMejaF3GLCk78qZ1g/Y+Jl+rvu498u7
 zZLIQm16KxeCso0JCfW6xE9Y0XNEIEX279N43+g4rYf0YuMuENHOWZNyI/PGB6oqgPfjLUQ3Vc+
 F5ZaZh6U
X-Proofpoint-ORIG-GUID: VWahGsUq7_ye_Kix7LkWTGGI76O54FKD
X-Proofpoint-GUID: VWahGsUq7_ye_Kix7LkWTGGI76O54FKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On 05/08/2025 14:56, Cristian Ciocaltea wrote:
> Add support for configuring the Fixed Rate Link (FRL) mode for HDMI
> PHYs.
> 
> For improved clarity, also rename existing HDMI mode to HDMI_TMDS.
> Since this mode is currently not being used explicitly, no further
> changes are needed.


I'd say, this need some explanation, especially for those who don't have 
access to the HDMI standard. Please mention that FRL is an alternative 
to the traditional TMDS mode, etc.

> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   include/linux/phy/phy-hdmi.h | 14 ++++++++++++--
>   include/linux/phy/phy.h      |  3 ++-
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
> index f0ec963c6e84f1b7728acafc824dff191c6b873d..0b26472d8defcc9ded142d4283e29861dc2b3746 100644
> --- a/include/linux/phy/phy-hdmi.h
> +++ b/include/linux/phy/phy-hdmi.h
> @@ -6,16 +6,26 @@
>   #ifndef __PHY_HDMI_H_
>   #define __PHY_HDMI_H_
>   
> +#include <linux/types.h>
> +
>   /**
>    * struct phy_configure_opts_hdmi - HDMI configuration set
> - * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
>    * @bpc: Bits per color channel.
> + * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
> + * @frl.rate_per_lane: HDMI FRL Rate per Lane in Gbps.
> + * @frl.lanes: HDMI FRL lanes count.
>    *
>    * This structure is used to represent the configuration state of a HDMI phy.
>    */
>   struct phy_configure_opts_hdmi {
> -	unsigned long long tmds_char_rate;
>   	unsigned int bpc;
> +	union {
> +		unsigned long long tmds_char_rate;
> +		struct {
> +			u8 rate_per_lane;
> +			u8 lanes;
> +		} frl;
> +	};
>   };
>   
>   #endif /* __PHY_HDMI_H_ */
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 13add0c2c40721fe9ca3f0350d13c035cd25af45..04c84c1dbd6dac55fd04c54203cff4f9d939d970 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -44,7 +44,8 @@ enum phy_mode {
>   	PHY_MODE_SATA,
>   	PHY_MODE_LVDS,
>   	PHY_MODE_DP,
> -	PHY_MODE_HDMI,
> +	PHY_MODE_HDMI_TMDS,
> +	PHY_MODE_HDMI_FRL,

I'd maybe suggest keeping PHY_MODE_HDMI and having two submodes: one for 
TMDS (default), one for FRL.

>   };
>   
>   enum phy_media {
> 


-- 
With best wishes
Dmitry

