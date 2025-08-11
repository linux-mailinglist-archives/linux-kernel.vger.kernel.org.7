Return-Path: <linux-kernel+bounces-763524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF5B215FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E45A1A2351C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60392D949D;
	Mon, 11 Aug 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0X5jfK9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6929BDA7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942128; cv=none; b=COoTTtBNyRBCaFejiKrcuAmF7BWNuuUPkpOaL1gpKNwm2hCMLDm0qgLS1WDJGbYQFRVwxVbww3rwUxCE/UJhJaNTLoe0l8OOGj8jrqyh1lwU/szU3K/jD2IoZ+HQk+8W44eNnQ2GN0YLbyMM0CIihHuOUV+1oJ4oPwGfmLDg4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942128; c=relaxed/simple;
	bh=T+GB+I4OfLAbw7FJdc0ZrPxn+zmusdPSRN2RBW1r/IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjhlufF8CEDWqLJcYqUZ+M94+CIQ14Y0uqwpAIyi6OGi+UZoNGLIP2/JLIOB5ztlK7m8eZ0AWRCgAIZlA+kjLEARQOOwwwyESYChb8+x9KZoAIQslCTv3wJhFDQ4AkNg59AGbLbPONoHfEGvWzsWfYarfhH57qU5St3AbfilFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0X5jfK9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BHf3tw024342
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0LyObyJu5M8r8WD3EJOUXcSgt7esHUFIRa8rhjMc6H8=; b=C0X5jfK9p5DHUYm2
	jERnPVuiMH8ir+xFmkZAalINrfa0PH+uP7P+Xj5n9d2mTZ+TFG4NvXTQHfoQ0S6t
	lcNpvo3VpmOOUxIri+LPgWjgkBfgIHckjLXw8f1A2Y+hgoXBU7X1y3HpQa6monZJ
	IUg57JIhZx0bfmD686tRAO7OTqPOjUrtJYoaeUMdlyvjjcES+BeKPA7fe4DPTUed
	m+Bb62BcByoyeOLGWtQAC7xj7p6MrmXgtDfPXl06muu15wLsKSTK8Pg5rznLZxdy
	5e70ce2+E0nW7UsecUOMjHxK+T2khM39RNsdT48aYeQg4efG07dOkFt8lk1thnMA
	P8fb4g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem49q0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:55:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4274f5e065so4132170a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942123; x=1755546923;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LyObyJu5M8r8WD3EJOUXcSgt7esHUFIRa8rhjMc6H8=;
        b=j8YziYrVBRPuBPSzlbgb/GKHwpX79MYJSaUeYcRGijRmZrSThUS389gE877Cjo3Wli
         25ploLuwaQUeZWfyUPT9oz2ilO9hTJXyq00Hpu6qUomFb2Y6+AtA5f7qbFMcWvK0LlVP
         hb96/FaoNElmBCL4KGgN/+mGMkRiZlZyUJaMO9SB+rGaHnmc7aOZ7BvhJKA1Qp0S8wyc
         MOu7rLBCsYhzZJ5wQTB3fj56hu1+cEF+8UcB7KCw3haUlCMHK7M2XXNhO12QOwheaQz6
         T+EKJqF/l5K9SjtBiEqm92AeRsNMOrkLV/2UhS9eCCc+tkIsTWi1H1GOM5ndj0WXaHCz
         0U/w==
X-Forwarded-Encrypted: i=1; AJvYcCUqTq1n/QPoBza4QhAZz+HAUUbRNuDc97pRO2hG3MGv2Ihjq8UTPrsQzqyyueTz4nsa6+/BOmgkUwBEeaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5hF7dB4fNA+HEp/S+fDIv7G5ZeTXylr2lPITptwwZQ0UjlLb
	crp2kZcQ1N/Ah4CotAdKxhojejQnOL5PJbX9SY1rz6Xzihu1X9Ei6d8jxViwwDP8cYwPDoVXvpP
	VU7BAGUIZ8dclpJDsqwjiqpY/Sti3Rn0gY3Ox802lHbsG58qgBHU7x0Y5y9uqfLq36Lo=
X-Gm-Gg: ASbGncu9+Knzul5XtPAPtZNyzMaAHdMyweGxlROHELB3JkVfKNYwHiGjn1Wa6RB5SCA
	EKVSLUAGw8T/MQiYArlpQozxtKZHdeILgNH+1VZTSIPrwPSQXYHdsdm99+jYKJyDfFrxlNrqgRG
	M7+qgUJQto3cDZS2EHi288jczCijZOjS6Fznm7w7cli/bYRRloLGjMH1DERaUC+mqiBDX2BQodp
	Zn6IsFG2d5Ud1zPMtaA/hzLl+XireGoIpYpR57pMfBOar1NCdUKSbLHWM+ofGlp0gsm4LkW7Cf+
	GhknZwcDltrSzN/B1y15mYisTGmAStHHo4ZqmLCMPBKEmAoaApKhSyVQq+5TsGavZchdnQYQFCj
	7lSZCugx6aMb0yLsWd94ZEyA+iLFoWVVp
X-Received: by 2002:a17:902:ec91:b0:240:4d5b:29b4 with SMTP id d9443c01a7336-242fc1063f7mr12498815ad.0.1754942122710;
        Mon, 11 Aug 2025 12:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Qx8bYK+rncQZ56MU1IG7eUy3lnzmit6zpPxPUFBpmw94BfCZtlGwBUH68DnPgSdEAGBLeQ==
X-Received: by 2002:a17:902:ec91:b0:240:4d5b:29b4 with SMTP id d9443c01a7336-242fc1063f7mr12498525ad.0.1754942122260;
        Mon, 11 Aug 2025 12:55:22 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac12d4sm23720118a12.32.2025.08.11.12.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:55:21 -0700 (PDT)
Message-ID: <adf6d126-1f80-4590-a9f6-171b7feaf656@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:55:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: switch to of_get_mac_address
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER"
 <ath10k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250809031517.5535-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250809031517.5535-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LxQHY9XKSW57ay7fIe_-VpziqMSzep8h
X-Proofpoint-ORIG-GUID: LxQHY9XKSW57ay7fIe_-VpziqMSzep8h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXx5D5GpU08aK3
 ftF2n9sIXkSBo90Ww7ixmCF5yVyCEyS8Dh9Ux7z1DVUIMIHxUOMdjmv8azVBS5ndFbWK4bbqvUJ
 4WnVbDzzBw4jp3Fm++V54nrh5I2JrABPrFWYniprY0f3bzb7o+LXCLkcK/WyZnVFM+X2GOwACJg
 2fk9OflBGloXuFqWqNt1BZzVb1gBtGCB8WRymifydRuRg3Bzn/WBOd12i8N6WDIk6DBhOTZSx+P
 USOmOOb5qcCzbxTDZqG0HJm7PPH3dgOwGM6co9hhFodRJ/nPDxy8hBGxSRaX0OhpM3f2Nafv1bf
 GrUsMvr6QgzyORpDiFsp2ugSlk/BjjdP4IeRp97mN5pMhkFXLc2EkjMXd9inu9TB2xWBnRfFAV7
 GKB95c1s
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689a4aac cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=3-rGAEJhA9dDIXXEWvYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10 a=xa8LZTUigIcA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/8/2025 8:15 PM, Rosen Penev wrote:
> In 9d5804662ce1f9bdde0a14c3c40940acbbf09538 , device_get_mac_address was

see
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

specifically: If you want to refer to a specific commit, don’t just refer to
the SHA-1 ID of the commit. Please also include the oneline summary of the
commit, to make it easier for reviewers to know what it is about.

So in this case:
9d5804662ce1 ("ath10k: retrieve MAC address from system firmware if provided")

> introduced as a generic way to get MAC addresses from anywhere.
> Unfortunately since then, the landscape has changed and the OF version

when did the landscape change? if using device_get_mac_address() is breaking
folks, it would be nice to know which versions of the kernel have the bad
behavior so that the patch can be backported to any broken LTS kernels.

> is required for NVMEM support. The second problem is that with NVMEM
> it's possible that it loads after ath10k. For that reason, check for
> deferred errors and exit out of probe in such a case.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 6f78f1752cd6..76747eb0925b 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/firmware.h>
>  #include <linux/of.h>
> +#include <linux/of_net.h>
>  #include <linux/property.h>
>  #include <linux/dmi.h>
>  #include <linux/ctype.h>
> @@ -3456,7 +3457,9 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
>  		ath10k_debug_print_board_info(ar);
>  	}
>  
> -	device_get_mac_address(ar->dev, ar->mac_addr);
> +	ret = of_get_mac_address(ar->dev->of_node, ar->mac_addr);
> +	if (ret == -EPROBE_DEFER)
> +		goto err_free_firmware_files;

Note a similar proposal for ath11k was deferred since it seems to break x86
attachment when there isn't a device tree node:
https://msgid.link/ec974dc0-962b-f611-7bbb-c07a3872f70f@oss.qualcomm.com

I'd have the same concerns here.
(but I didn't dig into how the fwnode items are set if there isn't a DT)

>  
>  	ret = ath10k_core_init_firmware_features(ar);
>  	if (ret) {


