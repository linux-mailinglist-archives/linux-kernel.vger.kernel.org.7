Return-Path: <linux-kernel+bounces-781747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F9B31633
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519E11BA9BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE742EA755;
	Fri, 22 Aug 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ht77CVcn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8E393DE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861543; cv=none; b=NBbCe3hQQlajEiQwXpM6mhjXbGX8e5MR0pm2xWQN9SYuif6fnVQclUhMSjBumHWThlq6dgxbhXwJn0hNdrRRNSTfUY0sBZrt8EJwhVUFZ8T271boC1SfxaDSY2CKB7aZfG81pmt4jbzLs7CxiKWbRIBLjG0BXazwWG8FHXuL4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861543; c=relaxed/simple;
	bh=gjW1E5jQcjS0ncKnacHLHtjFpc2y4txxw5PnY5/3YBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYjaDokSY8zMZK+99X1kir7NfqzcaJNrZtvePkqNex5y2F46ZMcNbogjAkSnJPCWGbKh3L9iD6H4S74gS1mceH1eIFXAcMPgdOokI1KGZjiU920xAOeHvZNnEa5pVvvIa3te0X141ImZVguPlXNDuL73BCLpGt3B7lUyl48WWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ht77CVcn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UW9g021853
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o6io8yY3zdT7abjrvvZnuU/W
	RzBlcjmfD4PXDAPO+bg=; b=Ht77CVcnLOWR25Y7V3rpkqLm6uzPZ7CC/RY+zKcA
	FLDH4uSFYPAzYSb1WwdychsdrmKTdjTo7xw5O30BpABVZeaNvzbkr42b0eEcA9vW
	Htp47sv33hyFfMIaXGzeWE7/i1AzkWVR/Hl7HlqGAJTBZ2Wr/4qcR0rmDstcAFHj
	GFx7mxf0zJ4emhsXdiGMtEKUf97GP/0A3JqzQCnG6uzdNcGcpAggkA3HCMM7k2F9
	uRv9sguJaC9GMofpUSaBoiP57jieekONlCWeI9OcoGkv4BuazOh66hHvWfk/Fb76
	JRicQIYO5mEQiIukTZCz8aiH6erb9uvJSJz+iNiHbzh92w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a91hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:19:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b10990a1f0so58632101cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755861540; x=1756466340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6io8yY3zdT7abjrvvZnuU/WRzBlcjmfD4PXDAPO+bg=;
        b=bt7kdzgb9sQcIQARFA/6T7qzVquqLkR+3uaIgxz8AkAKHGXz0AnudA9yRIvso5d4b/
         ZAwbj/t5UIZmXxDFurpKkwmbpbPJ3NzsFjiqN2xVpLn6jN+Pm1XuXQsFFDLZlGEAMCzW
         J+AwVw6R5MCJd1oYRSto3bdSqjeRDtdAF+c/i1ASd4oEN1ec3AAR44xKuXq+NSHSHuIA
         CxKYldtxAFLfPrB/60oZQt51G48hwZvRp0qEh242mq7ocCuyh7y9DV57B5JIU17UuXjj
         c86ck9iVMrD6hUaRAxbk+li7lZs8ouwmhE5W+YZot9oL05QAZYVFUNAY1JlfH+VFKeID
         JVnA==
X-Forwarded-Encrypted: i=1; AJvYcCUUw1LBhMrSbHibjdfTaRwmP9U4s1OYmHy5hCJwNr3y11Jiw0ijiI2+2z9HgcuuJfd+YmTGp4C6wE5d1YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ljUmZ/gLuO3HYKkdTfZqHWcb3gIlmhVfJlzp8bThlysNifo/
	5Nb9R/DLiANJDE4Me/5fEilGWvdEYdyXOcbqyVWqxY0r6G4T711Y9ow9XJaiadPSPTZTyvHbPfJ
	SBfZ9JTVFiQoQkRNqmOWPTnAJzt74Q9eieMJe6ofZ5NLesnJYBN7wdiwFI0WjuObkFD0=
X-Gm-Gg: ASbGnct9jqyw1kmpRCLeSeekOzqx6KOEmv4v3jhwgG/67nUo3vH53V0fTtwG2llRuK6
	DS7kHOKtVqDjt1mjNCkDK3rGjZWxKNdh/1cyDDzFA+Dd4e2Ik8ufGD89Lkz1Y2L6onesoPJCLLq
	i/X1xtCHycOAsDyHDOwiAjmcPnbOvI8Hgzw+2tJkRxnd7vFLJJqpsLYZbIQ4qE/fbSNh8w7mJfP
	yDMoH5LZIjQcy3XI9i96gOaADcuoRtwLAVWNpYbhtNG1ewHOjQODcbn+QffX9Ya9Lm1TF1FUtML
	okiQtT6ljkYNDvYMIGtOln3yJC4PcvTGAKXK3efg/fMnXWn5bQo3lsFzapcwv83sPSAjUVbj/xF
	J3tr0vam2I3AClPRUZN6qZ9wEOo1SsV1okHv2jl3EW5UGcaIJ9grM
X-Received: by 2002:a05:622a:343:b0:4b0:7021:50f with SMTP id d75a77b69052e-4b2aaa824cfmr28024841cf.33.1755861539898;
        Fri, 22 Aug 2025 04:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4ooQUwy4SsDbqUvmLri6Kkkne1Ak40MgYMIctMWFEgd8h7TTpELQ+1FzhQRj2zoHeDaDDg==
X-Received: by 2002:a05:622a:343:b0:4b0:7021:50f with SMTP id d75a77b69052e-4b2aaa824cfmr28024571cf.33.1755861539332;
        Fri, 22 Aug 2025 04:18:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef368d34sm3442811e87.58.2025.08.22.04.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:18:58 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:18:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/8] ASoC: codecs: wcd: add common helper for wcd
 codecs
Message-ID: <kmm4e5bg7uehmlsgrfhzo4agr6ga6d5gxtpxq5sg4t3wql5p6m@llwyz4kzsj7y>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-3-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822104927.2621866-3-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a85225 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=c23LMRYEHR_IeyHnjawA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: LgOkUS4kGPcKSmzPI7I1KvI4rALt6cO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX2M5zXJOgKnEE
 oFcG9rY4emQ/Pk+DYUW8M+zTjNEbjGrFgvfS+IBh7EBi1KhswiQxUbPpsirMz/0EpYu5IUYZlrG
 BGkIQbhXaj6iBRId5aRxUy043ifFnoG53CY58k9Hx7BrhM/mQmQ7JiZcENeB9MV7iuOgB18BRKi
 XApOjMsQCSrtQQsbZ1M+ZEGzY5g0CavQXvkyfDnmNmXWsT8gsSzqlL/+0VVYnytScF0WhiRWsh+
 Sosi1950eCbcyQUWzEIDoTtYvnOEFWdcgxck2HhIGa1kRjPr2XF+GSdFf7MBVwj281TfTB425b9
 KWnYCE5dVK92fy7SizTzL8YkndR2feuSIzi9WP9aRNbsU6qnJJHyShgQtIZjfjXgMs5qm0EPfdn
 mKnngBABrZZC8tVgcBvHE5hVGdELbw==
X-Proofpoint-GUID: LgOkUS4kGPcKSmzPI7I1KvI4rALt6cO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:49:21AM +0100, Srinivas Kandagatla wrote:
> All the Qualcomm WCD codecs have most of its code duplicated across all
> these 3/4 drivers. This patch is an attempt to remove those duplicate

See Documentation/process/submitting-patches.rst, "This patch"

> parts by adding a common helper library for these codecs.
> 
> To start with move all the micbias parsing and voltage settings these
> are identical in WCD934x, WCD937x, WCD938x and WCD939x codec driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/Kconfig      |  8 ++++
>  sound/soc/codecs/Makefile     |  2 +
>  sound/soc/codecs/wcd-common.c | 66 ++++++++++++++++++++++++++
>  sound/soc/codecs/wcd-common.h | 24 ++++++++++
>  sound/soc/codecs/wcd934x.c    | 82 +++++++++-----------------------
>  sound/soc/codecs/wcd937x.c    | 75 +++++++----------------------
>  sound/soc/codecs/wcd937x.h    |  6 +--
>  sound/soc/codecs/wcd938x.c    | 87 +++++++---------------------------
>  sound/soc/codecs/wcd938x.h    |  1 +
>  sound/soc/codecs/wcd939x.c    | 89 +++++++----------------------------
>  sound/soc/codecs/wcd939x.h    |  1 +
>  11 files changed, 176 insertions(+), 265 deletions(-)
>  create mode 100644 sound/soc/codecs/wcd-common.c
>  create mode 100644 sound/soc/codecs/wcd-common.h
> 
> diff --git a/sound/soc/codecs/wcd-common.h b/sound/soc/codecs/wcd-common.h
> new file mode 100644
> index 000000000000..08c8e7ce9814
> --- /dev/null
> +++ b/sound/soc/codecs/wcd-common.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.

Please use the correct copyright according to guidelines.

> + */
> +
> +#ifndef __WCD_COMMON_H__
> +#define __WCD_COMMON_H___
> +
> +#define WCD_MIN_MICBIAS_MV	1000
> +#define WCD_DEF_MICBIAS_MV	1800
> +#define WCD_MAX_MICBIAS_MV	2850

These do not belong to a public header.

> +#define WCD_MAX_MICBIAS		4
> +
> +struct wcd_common {
> +	struct device *dev;
> +	int max_bias;
> +	u32 micb_mv[WCD_MAX_MICBIAS];
> +	u32 micb_vout[WCD_MAX_MICBIAS];
> +};
> +
> +int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
> +int wcd_dt_parse_micbias_info(struct wcd_common *common);
> +
> +#endif /* __WCD_COMMON_H___  */

> diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
> index e70445b1a4bc..f587cf22f86f 100644
> --- a/sound/soc/codecs/wcd939x.h
> +++ b/sound/soc/codecs/wcd939x.h
> @@ -8,6 +8,7 @@
>  #define __WCD939X_H__
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_type.h>
> +#include "wcd-common.h"

No need to. Please include headers where they are actually used.

>  
>  #define WCD939X_BASE					   (0x3000)
>  #define WCD939X_ANA_PAGE				   (0x3000)
> -- 
> 2.50.0
> 

-- 
With best wishes
Dmitry

