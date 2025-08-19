Return-Path: <linux-kernel+bounces-774646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45308B2B583
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320B73AEEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EE16D9BF;
	Tue, 19 Aug 2025 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVSLpQFI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990FC120
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564133; cv=none; b=AEmfYZngJLRGhvhp6IqY8sydmbHhVosaIN+ivHMJ14fh2rN3fTq03nUI8RdELc2DN3N5kBrvFlCuMjw/HehaTEbJpUypheWOyJTDez0KKb8oKH/GFoH1w6v+nmEfFbDI/FirGy2OgulbQ/cjF2TR5N3fg/4IBXPAO7YaOXEU+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564133; c=relaxed/simple;
	bh=E6ucyaG5lhvJ3EQJ+nG1y8pA3mjJ1P2JUKznaepr9cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLmeNxVaA0Ow1b+FKQ8oEu7Jw+b9OA/FLX9Hu7eZeKr54QeFfGrkfEc7UELio66uSInjj3orr+OlRWZHFq+J3Bxm/MqW9hnx83K/v1mkLwjMdEVRAKSdzohSCRjafh/5fJAAkSDlxxQX0nNeJ+V6vAlcSNi75PxQEs/rCG1cQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVSLpQFI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILPdFT006647
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OBbn273P8/f9yxcLk4nZc3A83z2zO0Iuz9NA/0alo3o=; b=CVSLpQFIqL2ri/kW
	j3XH9eOVJXfBRJyXZv5o3bkzw/gumYdiq6/AyhS37XxIdOPTUWYjlfjVV7Cb8Rhe
	xQbrHHpqWGwzowE6684jOZ1WAwq26Prr/ojNpbaOMYIE9/Z9DlKBL94w7zBboOmY
	qG85j3YubU5x9rZOzd7z9MSo+yBwYEwOLqa8CwsxmNBbXKfhDLASmNbtE53jTnJX
	DEY8AAOXfEuLGvk5+Uz9NHkMogsDaohynyfcuBNGf15hnC7Rmemke+AxPfSlVXPA
	DfYhMyVkYrquUw2nhEE75BbwVF3T1Akgb5wK1UxUYCX4If+csARnnNJmcfkOqkKZ
	FV00Cw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2uep2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:42:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a92827a70so106668366d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755564128; x=1756168928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBbn273P8/f9yxcLk4nZc3A83z2zO0Iuz9NA/0alo3o=;
        b=AGzy6kh4TkCpSepEGFsFawodsPJJRciyXCi7+/Mkq+/VLZ7ySgZoggI3vOOeqNKEno
         6OVc68O8aFBqudTRgpPqhZ1LcYcuaKLO4X8TXr4jTipWcOBBPNaM7AgMcHaz/cFB91qj
         xjyzTecNXYpGbDxulNrZY6b04qeO89el3Vr+bTqe8qobdYdvbP4YlX8JUmUOBDtLSlvT
         E/yzqDq5mktn78Z88RhRFF8o81epze/kBzC3QEd+y2QOKmvo2DzeOVij9XPHoYck/AB6
         TCdxYc/iW7rVlDdkusp+a/WtrjAibtkGnLNT3rCCKVmVoH2iagfTp9rQjA9TXt0BMYPB
         S+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnevr7vBmOe9poCRF6CF4jBz4/B5Wlpk/aEMNi/9SxG3wtZJRmkcy4Jx3x4M5hLMlJOFW3u/cZhyDVYJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SxlJabMtph4R6rNZLSdpIqR1QsOqqqNnXA7fS14d0O/guzfZ
	5tyhS0zieHU2ZOGiTSt6UEuzzZ4wGMxceGBdns9agorJLUr3/mxGR6Hb989xBMmAMK0K39nuJrG
	OoMukqQyAqWApfuYPekUwVeeQ5aILOFZacX8jZZGDAmydEJXKjyDrgenGuSUTg3GyoOg=
X-Gm-Gg: ASbGncue29ke+zwHymW8W/PN+orPazKzmuqYjqPO1qplhGoASdIjcjMn11zLvytdNDY
	VznSObgFC1gkOcZk0uv5cBaEnucpGZPJvhNMNrh469kmoWeE9bIsUSzxENGjjTemTDdpHBy94Pm
	O8EkGkzsbcmtrAtbdWi/1Hr5nU78s6EoUwHe26s5Cf1x6nyiADR7sO6fO4iJBvdneFeohVyPicS
	xMSKxC5UOLbqeuclG2RGkjkKKtTW/CbRJPs0jba3ha6G6EB12pI4ZSnJ+0mCvwMJLfxvVrs/bnq
	7oCQ96DbYof+nez7qaofcYCrS2+19f/7OZigzlIeM6MYQTdVYfrUEWP7DH0wRUG8eMfB492GXJC
	zR1cCngZK/+17bMporND+943YC0jvoIczgkFpWPOq
X-Received: by 2002:a05:6214:e8b:b0:704:a0cd:f597 with SMTP id 6a1803df08f44-70c35b8b5a0mr9282166d6.21.1755564128325;
        Mon, 18 Aug 2025 17:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYUQOO9C5theUsgHuQ7WuHIc+c5d31s4BRQUPisTdCBR05/M1rf3y3WoAQasBUktoz06m8MA==
X-Received: by 2002:a05:6214:e8b:b0:704:a0cd:f597 with SMTP id 6a1803df08f44-70c35b8b5a0mr9281776d6.21.1755564127778;
        Mon, 18 Aug 2025 17:42:07 -0700 (PDT)
Received: from [192.168.10.39] (91-154-146-251.elisa-laajakaista.fi. [91.154.146.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351545sm1861560e87.21.2025.08.18.17.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 17:42:05 -0700 (PDT)
Message-ID: <3f857197-1cd1-4c18-88e9-e8c00d95af82@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 03:42:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] phy: hdmi: Add HDMI 2.1 FRL configuration
 options
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
 <20250818-phy-hdptx-frl-v3-1-c79997d8bb2b@collabora.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250818-phy-hdptx-frl-v3-1-c79997d8bb2b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a3c861 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CKk/IlMN6Gw3Dq31eR3Dfg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=QX4gbG5DAAAA:8 a=bbK825GtWpsu-Oi3XvwA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: C1hGZTccIGCcUu8jAAolFsntaNAj5icE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX2F2Cbl8THIin
 E0mwrV4qW5BdXVwnpJwO3GbtwBqRdboFIepIw9t6djl3Mv0RtKDU+hsi6u5+7Tjwhcr2qzVku2G
 DFaRJYVvmafJGLd1wMDas1dFlkAe6F5A2ECiOvJbugru4dyluT+T0DtKAvo2m925EEgCffX+4Fi
 uH8h7ArohRFcaRrcdTACfhvNakEjyT07WlKW9u/7y6Psjz9pxmTa3ybWYoNWxI/07NCoPn0iUs+
 WOVwmIgmusNlx9hoxInfyZ2Pt87QakvjmQgZZHpHAEM3UPSy9IBRoLFR+mhXCzQPUED4lXM6k9P
 E73PXM4ZNpKCJD/PlHmnfBnZZLZpOtyBnEu3jhBZ92xfLdrBDX/6s2ZR7RGm6nHBH1rkXRbDerx
 G7WLacRY
X-Proofpoint-GUID: C1hGZTccIGCcUu8jAAolFsntaNAj5icE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031



On 18/08/2025 21:59, Cristian Ciocaltea wrote:
> The HDMI 2.1 specification introduced the Fixed Rate Link (FRL) mode,
> aiming to replace the older Transition-Minimized Differential Signaling
> (TMDS) mode used in previous HDMI versions to support much higher
> bandwidths (up to 48 Gbps) for modern video and audio formats.
> 
> FRL has been designed to support ultra high resolution formats at high
> refresh rates like 8K@60Hz or 4K@120Hz, and eliminates the need for
> dynamic bandwidth adjustments, which reduces latency.  It operates with
> 3 or 4 lanes at different link rates: 3Gbps, 6Gbps, 8Gbps, 10Gbps or
> 12Gbps.
> 
> Add support for configuring the FRL mode for HDMI PHYs.

Could you please point out corresponding DRM patches? They might be WIP 
or incomplete. I'd like to see how this works on the consumer side.

> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   include/linux/phy/phy-hdmi.h | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
> index f0ec963c6e84f1b7728acafc824dff191c6b873d..83330d359e3ae345554f20429519da14506b8ab5 100644
> --- a/include/linux/phy/phy-hdmi.h
> +++ b/include/linux/phy/phy-hdmi.h
> @@ -6,16 +6,31 @@
>   #ifndef __PHY_HDMI_H_
>   #define __PHY_HDMI_H_
>   
> +#include <linux/types.h>
> +
> +enum phy_mode_hdmi {
> +	PHY_MODE_HDMI_TMDS,
> +	PHY_MODE_HDMI_FRL,

There is no unified approach for PHY submode names. Nevertheless I'd 
suggest something like PHY_HDMI_MODE_TMDS / _FRL. It follows more 
closely the networking / USB submodes. An alternative might be to use 
PHY_SUBMODE_HDMI_TMDS / _FRL.

But it's really a nit and/or bikeschedding.

> +};
> +
>   /**
>    * struct phy_configure_opts_hdmi - HDMI configuration set
> - * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
>    * @bpc: Bits per color channel.
> + * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
> + * @frl.rate_per_lane: HDMI FRL Rate per Lane in Gbps.

This works nicely until HDMI Forum adds an rate not being even Gbps. Is 
there a reason for not using ULL and bps following the tmds_char_rate 
design?

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
> 

-- 
With best wishes
Dmitry


