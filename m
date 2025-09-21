Return-Path: <linux-kernel+bounces-826149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6CB8DA68
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E5189E810
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54542C0F60;
	Sun, 21 Sep 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nimsq3Nc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1E2C0F8A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758455034; cv=none; b=fCl88yNYJvgjbVYikwntrJn/Np17PYG6Iq/bQz++e0E0qHDAcFuwq0zImlRU+GBJ0qdAyLTUhKnKsHE0HA6KaWj09PjbGNbY1qc/CjXFXecNZ+OU8zFLPwO6iR2e3nW1p/OMitttt948AqBVFeYrwHOPrEw+dOLPVc8f71ND6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758455034; c=relaxed/simple;
	bh=+Pn/OVfTwdSSSOXNeOm06iGQ/roCwDtZwhhSb17LvI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFlaIDXsT4u0KMefqzfYudbrRzZrrOw0uuKWPpuddNh4N7S7HSDTh2ppWzoYjTBsDMeuUgngELibDzd9nl/6ytVNT602E68jZOmONq6u1FRclHW9R8TPBcI2kDaU0gv6kzkVDC85FuRFGflR9mSg/awfzI3MAqj8P8qodoLU9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nimsq3Nc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LBRJdb020603
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2tz38OrlUOeLMiW/V6pVbFqi
	MiAYEhH1+bQDPLCltYU=; b=Nimsq3NcjCR1Np9YlKps0K9TPHI6pZtKpJKVIutE
	AfHwOLN0/u/XjtyWYsHtAFIf+lEBdJnDX4pjqBrjW1cch+9U+ldIxOkJTLFLuOzT
	KO9B4GljHXJnEbhyJnc+fImVzdzktygSlkTfGyqBqRQA3jQ+tkfi4NSL8TXiBYeh
	KNayi9ZX3m53EEqwfUVLebk/3o8jFkcYvnSR7Dk/hObwqZtsbLASek3AvVlnC13d
	z4zpcb3Ks8ZwRgBYpn/UR6pEaD3gJixdL60gQunqKbpR1X/yDh9jeTr5roCFhzg0
	3LMe//iuWciUS+hDqeuVah4M3L+R+3xoPrYiBeBldpXIrg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499neksxkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:43:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79235f57ed2so32476696d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 04:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758455023; x=1759059823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tz38OrlUOeLMiW/V6pVbFqiMiAYEhH1+bQDPLCltYU=;
        b=BnO99eH6nURp//4HsXuVmG9iG5m3LWeIioHIGGz1Ffj6mO3Z/jQPZ7vtkTbvHBA5gQ
         6aZC3CMoUAMBal2eQiBpPn/vE2EQD8JMq7lu7QNtUUzCAblKPbF7ED7Gu87H56eBUNi5
         xFMiVQTjHsLFM3zQ2dSvgsDxe010vYXd0hQ3k9gSWqnTFMIDS6Pkh5fsnZDT0HT+waLQ
         fXPciaoKY3k7yr9TmcwaE/Nc5JwgU3uNx9xE7fLF05Euaq96eQRwd5jZNITHVfWm0/+5
         Z9PlzFyjlE7Q9QZ7ZuL0RushfkNHiaInGU2JNDefoRm5QBT2ZMUe4/eo4mTZUOQGVT6U
         cU+A==
X-Forwarded-Encrypted: i=1; AJvYcCU+OjuJpwENqdn0ycoRZbH73Fj4SqMouCb3oFX7XrBLe3dvAyP5RMSAe5cQemNZy/1MvC255m2/xXs2HgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniJhWCCVA4/b7QDrPlukS8UPn39RcxgDNP9p6fE1kwt2h5CT+
	BDbpv3OlPiXNrZzJ1+oA8awhv5v2EstW5Y7Dy8NKbNFVfpKSd5+bp8IXCmg+1Z5+x62UEoiHxak
	pTsspnWaNFzltoFG/7pGSZQoS9r4MddfuccYhL+VouARJs6H0VkGTfjkOyO3fIePO4xY=
X-Gm-Gg: ASbGnculCTEUlLygfhNLtD7KE3PwjWsvcDm1gNG+681n1lDw7qkCt9mSJQF05hduBom
	e1lnTa+0tthGkNVZOgKdBbn28OGp/rPbOfGNB3v2q4kMlWynbdYMy20aZ+roZNJ+pJjEVuVfOQp
	lANDE1VgLmBdMMrmTynuQZL7vgjPJt91lndJTsnx7n17kJQLJhiFiSqDFfnEbsdn72yIM00afoi
	2cem08SQQPOa/ngXDsgMWv9t3b/clL5baHsWZf3h2TnC4oPVGNsfCpNPu47WG76AAuy1V+y169D
	mKWiNJoTjH2CI0aI8m1/t7RS9oYYOwnpCodS0LVhmAPMUpq6AQNVp7qhKTK1clK3O0BOZ7qJS60
	Axp0kMzrdewuL1C/PyhdS1VecMVkaQowzG66Lrw7Tmxnc0wVMZDaV
X-Received: by 2002:a05:622a:289:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4c06f84409bmr97544621cf.24.1758455023252;
        Sun, 21 Sep 2025 04:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcgRW/31bOxLKwY8qsOfsclAMytFaKWAzuOnLefGy2cQabOY5f9ALQUf9IAhjpMBxBBPDADQ==
X-Received: by 2002:a05:622a:289:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4c06f84409bmr97544541cf.24.1758455022788;
        Sun, 21 Sep 2025 04:43:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57c56d47591sm659763e87.50.2025.09.21.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 04:43:42 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:43:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()
Message-ID: <lqgi66r4voh5z4p7mrjiulxvy6gky6mzn6rq2yresuhqfzsnt3@xcgvnxxd7qnq>
References: <20250921095927.28065-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921095927.28065-1-make24@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: nDMZtfDLJwaeez1eZcPlsssJWFmy5uAp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MSBTYWx0ZWRfX68IGiuxKIClW
 gKa7BXsGII++Opf8Kiz9oxDWSothEk0l8mvHP2dsML1pumGX6IkODRCdSIKbV0d7164Y6ha+ZEP
 /BSeKUnnNBWXF+qCfWAgiTZjk+itM+zdYHmOPoTHzHFGNaVkDWyPeUwhASKWCwnOUlLfXAs+r66
 PpmvTMbkPUYdVxSWpxngIy57xFJwp9YFZOqFgrbeYKsSKkcduG/CCIgQI7/VUCDsdmRCpB6WY3U
 aJRtJgLcVzzATKlz26gSRiMpWfoaclC9W1ga5OHvjy+WEpWcYtHbbvXN8WtSWPgjyRKQtI+BJVU
 gTWC1TH8fZa5iy/7QAo8h0/+rYYJOnzLX5xkiJrqRmG4VQaHSxaolvr2N/p3cvNXp4N4AKFI/f/
 8VrHGu5+
X-Authority-Analysis: v=2.4 cv=b+Oy4sGx c=1 sm=1 tr=0 ts=68cfe4f0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=YRiNdvbt-P8spsNBmjsA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: nDMZtfDLJwaeez1eZcPlsssJWFmy5uAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200041

On Sun, Sep 21, 2025 at 05:59:27PM +0800, Ma Ke wrote:
> wcd934x_codec_parse_data() contains a device reference count leak in
> of_slim_get_device() where device_find_child() increases the reference
> count of the device but this reference is not properly decreased in
> the success path. Add put_device() in wcd934x_codec_parse_data(),
> which ensures that the reference count of the device is correctly
> managed.
> 
> Calling path: of_slim_get_device() -> of_find_slim_device() ->
> device_find_child(). As comment of device_find_child() says, 'NOTE:
> you will need to drop the reference with put_device() after use.'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  sound/soc/codecs/wcd934x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 1bb7e1dc7e6b..9ffa65329934 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5849,10 +5849,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
>  	slim_get_logical_addr(wcd->sidev);
>  	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
>  				  &wcd934x_ifc_regmap_config);

regmap code doesn't increase refcount of the device, so we need to keep
the reference till the remove time. The code also leaks the memory for
regmap, so this code needs additional fixes anyway.

> -	if (IS_ERR(wcd->if_regmap))
> +	if (IS_ERR(wcd->if_regmap)) {
> +		put_device(&wcd->sidev->dev);

This call is correct

>  		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
>  				     "Failed to allocate ifc register map\n");
> +	}
>  
> +	put_device(&wcd->sidev->dev);

But this one needs to be deferred until remove time (e.g. by using
devres)

>  	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
>  			     &wcd->dmic_sample_rate);
>  
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

