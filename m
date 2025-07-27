Return-Path: <linux-kernel+bounces-747176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FCB130B3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012F83A1ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136D21CA02;
	Sun, 27 Jul 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHsn4DjW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ACE5661
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634299; cv=none; b=Q2Yx7NcFmSpY+0S7467t1Fd6wGbIr5XpqCxvlWKp/1cpvIrr6ScE6Q2Gg141+swQORbUTXRQTYyO/phpwfMITTU1StBwf5Sz5kkRfQJ7HfYB8JEFUs7xV4SkkWOMf+krqTiGwET51Gd9lcysiNnOmNaLKZiXFPq14EwnRFmvGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634299; c=relaxed/simple;
	bh=SbQN6/gxL6ryBJIJPghxBq7pmkT53NiI07RDIHXLrWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6z9sz5gUvp/N7kIxOPTg/thKfL/uswWDw3+LGX29pBO4WgyFfOAmQJEWx9Ggd+9rPgnBpgSCJQlLmBZG7YKukBo0xKxh/x7++cvAe4Xzohkxov9M112v7CVPuBA7Q03D7bZa/pySKOB3MiYQAxCG8eES4OZYFKrl/BJUAIK324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHsn4DjW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RFGJqf031342
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8CPqWy085vO5YMl3J65GS5HS
	Q4F1909nZKI8lDdr2tU=; b=jHsn4DjWuxDfu0b9/M6Bv+x/MbgkKnNhwclXEBy0
	rFcnwZqlB0JbpAFh95IpmeDioV7wnjBh/mflwYb93hgp2V+YfFUunNIjKc2jzhrN
	Sf1u0ePk1VNFCxNXRhLVaZVExziYAGI+sPVZtO39U+dB3Y6R2vjl3r0KNkdxiYNT
	7iGGp1ByVTjbe+zcG+O9EgcXXup50X8qh7jdQgPaQG4HeY4UwivfsB4yagnStAp+
	xuy4DNhB7MTnRJ3fsF9nuQV4J/ldz7NAP0kXNy74Qz91dQg0fr4uzabrg/MCbSLx
	DK8CEJx72l4YFt6GmEicNDT+0JS6nNhEABQST6vEXroM5w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr2k71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:38:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073834cda0so16761506d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634296; x=1754239096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CPqWy085vO5YMl3J65GS5HSQ4F1909nZKI8lDdr2tU=;
        b=KAEeGmaDwfgT/gwJBT0Y+ZfiXWGvKVjzzW/QUwh+AVFnjCr55vmRZoAQ/Z1VZzXB+E
         hkB0jAcc3k7ufopD8aSVIxCCHb5gVu0UQRHijCeifORif4Yf07XVrigXtlddutniOcYB
         PE+JNHRDcMisoFlf3R4D0onFgJIKwC7VcPzGhYPr7DNfou4KD2lUsD1WaXwXl07zuXHE
         O6bFm4BzYmYZ3248kkF24PTEibvAbZE2KfrCO5OzmNisiLtpkdXpSZWd06LvO20N6E9Y
         k4PhOplFFx1Rrlnmek+TfmUacirF7tDCKQy7D3uihWnEC22UFalhK6ZxNMqjsk6iI8IW
         Y6CA==
X-Forwarded-Encrypted: i=1; AJvYcCWFPkg0xH/kpCreGgyYKi70M6222IJ9YmIpeLOKfePqBJ/Mbko+vq3CcCpg79U9TXKSJ2WciLmfgvN4r5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwe974iDvJDAOFkbXclSpOAWop186k155r1zZ8Dw4G3t+ZNks
	xONI5vX6UDXk5U/4LGaYBcM2LfS+2/NkK4ji5TwWugLLiieJRBv9iPVPXf/86kbtpwegr2AV1eq
	PTpVjdRRJK6FnFhMJEqqCZsp/MU8EeyAIGx+DW05AR5xPmeg4kpoVAPBlYuUuSZY46Ns=
X-Gm-Gg: ASbGncu/mX78GXfL8bdsn+ICJjdRD67v0q88P9hF1MFMh6n47P//GSW8f37rcPRmFq/
	vQ2SYkkj3xoGB6blkERgMi3ObP7HN2MNsQlgqE07buEYzPIPnlka+hVgJ5zSjuAPhSPcuR2fIxP
	C7gDCP1HFSTuo6yxG7YdXyu6gyCoi9PF3uP4seqLvfyVIhUJuJ9rAVP/jyut4ymTM9OS3Du4vN+
	0T7pAw3rMpzBq+VefE13FFJ7EQRYko1BTTYxIITKmgJCGgVkegs4QbXyS7I+p4DtiDyu2n1uP7H
	5hxTekXGegP4qmkItFqM92wUO+4YeYTfUqKVvU+p7guhrMcXrU+YNAAhOJJHfBLYT024/DHGogD
	Hm9M84u2o4aEHqYDSegxJJwvUgOGGvHrk3dX7/dYEA0TW9gVaHqN4
X-Received: by 2002:a05:6214:2688:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-7072051a1f7mr122236576d6.2.1753634295504;
        Sun, 27 Jul 2025 09:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfTJn1vhErN8vQII0dL2PBrMXA9vXoTP4b+ejzxx/zw0K1BvXLsKAiCyK3uSGd5H4OalWKoQ==
X-Received: by 2002:a05:6214:2688:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-7072051a1f7mr122236246d6.2.1753634294947;
        Sun, 27 Jul 2025 09:38:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f427e0a2sm8710101fa.83.2025.07.27.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:38:14 -0700 (PDT)
Date: Sun, 27 Jul 2025 19:38:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/bridge: sii9234: use dev_err_probe where
 applicable
Message-ID: <opsrp4mlhwzoldthsna5wx32b755wl3uxrbqvocvnl5ssduf3k@76a7fycatbho>
References: <20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se>
 <20250724-exynos4-sii9234-driver-v2-2-faee244f1d40@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-exynos4-sii9234-driver-v2-2-faee244f1d40@grimler.se>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NyBTYWx0ZWRfX//auqi8U+cdF
 b5HQZ5tVptR7DQRDbcpRzT/egk7lsgu1cnEGDFLgKCdWB+HOyEJkbgaRA9F1v7jp9OrLMtYZSuN
 q/880Fw/r6fuCohM+UV5qfcGnPV7PQNhe63fSAf/TPb6bNaG7fFDOuhH2/Hp2aOKHJkFMRz2eCM
 2SgaA8B4O9NrCpEf8bunUd7IC5XeXZPOFH45GEFAsP2FwmO1ELDw7dxWormLEyASPBdui/4dxJn
 U93uTpNLG4QwlO1GorNTWKXdEQ6yufTWzFX/rK3+BA5X4LUTv0OSPC0Yk7BskI4C8bjgGw+AZcI
 Ph/VmursiT3MyINOW/4iOBC5xp7UpxPMMD6PFQN1icGuGjJqJWzRlKs7oiqx80BzovAaybh3Iil
 FiTNEdxjwCuydTpcZOB5zfIst3HZ7357IJS0Re3T/N7yJ2xiG9f5Y2Num0YPjmP6XxzKuT5F
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688655f8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EIN_TQxVNm9RAPmfLKYA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: FsSmTv52WAfu-QhgRnJ4Uit_YF0feLeW
X-Proofpoint-ORIG-GUID: FsSmTv52WAfu-QhgRnJ4Uit_YF0feLeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270147

On Thu, Jul 24, 2025 at 08:50:52PM +0200, Henrik Grimler wrote:
> In case of error during resource acquisition the driver should print
> an error message only if it is not deferred probe. Use dev_err_probe
> helper to handle this, which will also record defer probe reason for
> debugging.
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> v2: no changes
> ---
>  drivers/gpu/drm/bridge/sii9234.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
> index 930117bbba87285e62107389606897740516eb0a..0e0bb1bf71fdcef788715cfd6fa158a6992def33 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
> @@ -825,10 +825,9 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>  	}
>  
>  	ctx->gpio_reset = devm_gpiod_get(ctx->dev, "reset", GPIOD_OUT_LOW);
> -	if (IS_ERR(ctx->gpio_reset)) {
> -		dev_err(ctx->dev, "failed to get reset gpio from DT\n");
> -		return PTR_ERR(ctx->gpio_reset);
> -	}
> +	if (IS_ERR(ctx->gpio_reset))
> +		return dev_err_probe(ctx->dev, PTR_ERR(ctx->gpio_reset),
> +				     "failed to get reset gpio from DT\n");
>  
>  	ctx->supplies[0].supply = "avcc12";
>  	ctx->supplies[1].supply = "avcc33";
> @@ -836,9 +835,7 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>  	ctx->supplies[3].supply = "cvcc12";
>  	ret = devm_regulator_bulk_get(ctx->dev, 4, ctx->supplies);
>  	if (ret) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(ctx->dev, "regulator_bulk failed\n");
> -		return ret;
> +		dev_err_probe(ctx->dev, ret, "regulator_bulk failed\n");

Drop the braces, use 'return dev_err_probe(...)'

>  	}
>  
>  	ctx->client[I2C_MHL] = client;
> @@ -911,10 +908,9 @@ static int sii9234_probe(struct i2c_client *client)
>  					sii9234_irq_thread,
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>  					"sii9234", ctx);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to install IRQ handler\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to install IRQ handler\n");
>  
>  	ret = sii9234_init_resources(ctx, client);
>  	if (ret < 0)
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

