Return-Path: <linux-kernel+bounces-842006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E93BB8C31
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DF54E7787
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67289226863;
	Sat,  4 Oct 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISvKLycM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA5157A6B
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759571240; cv=none; b=XB3Q8QvQKYZvCQfjy1mLHWa+5elUUe7Jc5W17koAZ5W8G5XGLGJJMaN7mj6roM1zr0YCU96r4Vg961hjb2h6l5qTVWF6I5Jid95xtpcG7dSVFLa0qDwcivOG/4X1WyiXaURFC78Hmd6vZOPTXj6SR1m97Ta38eIXAqISssUuAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759571240; c=relaxed/simple;
	bh=rENxmg/Su5nou7KjTwC8IAwpqJbVkm3I/Y5tIcKcEN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhyL53aZGfhdoV0qJsWA1rczUifDJRNq2TbmqI226XpKTaq9mihO9bVUR+3Xw/r0psfdWy4IrGzCy1qj3ZQ1wntXjz8U8HCZqtT+fG9Jg2ShWotCTdh8YjmgftaHiWmIyL0q7bvtn+Pl7TFDkF5fZ51kRkUWwnrQuMXZRYjm+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISvKLycM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5944ppoU002598
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 09:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JyJUqoq9hNFWEpkGuYsnzzOl
	rgkS1VzZQ9NH0b/ALic=; b=ISvKLycMDh7Y7wxdJh4i9yYpIOXUD4ZAK1GWCR8K
	96pawdlJTaEiVBbn46J6hh5tCb4LPQ9uqe/olea1DTvEYzbCq8PHkCkdRiuS8u+i
	oy6z/FerSl0Fk+NK7/UhEOFalilaXjUddB6zHmX+uTNBuxzB/ag0n63/dTOCyMEJ
	GRZEYp7f4XXLmAVkK6v8Rny4E77JCx/7dlaaYCnLQc70Vub98JEoDIVRfVjGDM1q
	tE1ZVg1rhQNZ33ISuRqoomD0mrdxGpNn+3F5d3NUFdf77XpwL3fkYiYJ3/0D+YCi
	ZnzgkaobacKI8tVUho9NnPdKyvoWcB59OVo83tDikcckBA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthprjfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:47:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4db75c7fa8dso76110311cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 02:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759571236; x=1760176036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyJUqoq9hNFWEpkGuYsnzzOlrgkS1VzZQ9NH0b/ALic=;
        b=lhZuVpMj7Hu6F0mVbvULhOZ0o3yfaf8zFiFOdKQ9hkb746oe3hPxTO55MAFdBDQjBk
         FHWsAPTju59VFvViaCGf/XBC+f4ggP30JMGl+9BerfAInntZU/yX07G0SpVQfkISaGhn
         8jqQjrqfy9u9zagJ02X7j4DMnr5kYqlWj7tNTLymXcNtObc6qLHYGJ42nqN3XtthItNw
         0xDgi8HOdVU1pAb5M1B0DmBd9uHo88PfaOyHnMnXMjsgXjA8/1cxFi3V1hmbYYbgUvpW
         pnD4bXyqrxnjteyVnJ6aFFHnG2XST3cXqXtJh8njJ1vWKd5T6ruN0+DwazolSPPMxinL
         qofQ==
X-Forwarded-Encrypted: i=1; AJvYcCW39wwfrtqkhLXwy2tArv30CwJfjAFLBKYuBmjvWHnc4/BHblUrDRMiPm/RZ7sLl0gp/IM9N9WWdYle6Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDK3mBxaAc5jv5o8y50C8s40uLnWt6UDpWV2LubmU1NrZrjj/
	2WdQEZCjo/yDDS8pMmWY8IC2dfvBxqwuh1Ds2OyYj3cSIpbxa3rQ1/xDdPRjnVjFwr9EXkFXj3n
	0zfMxqr8Q68LW0vi8LaUzBnqzjykOzsrwKbm4DiUyhzndSafdXTbZLixB18Zi3ElTNCQ=
X-Gm-Gg: ASbGnctZrQhm5PTcybAOC0PRSCv3eCCZo51Ja5OYCueoYsz0IYfATNmyOdcqUOA5jLA
	9T3P53CLA4+oIopdXTiDdYAwr2UDaFtH/q7vyI/YCiP9SElDKpNWxMRNBSn90eQb1+QuQbxwy1D
	rDFzd64jpfTHCkElKzXjGrJnUJ4CXdPFIPufeE2TKQbxMX82wluHAEDaVgXWUyxeKXn14fYGKEZ
	iekq0rpvqOmnKdNf4kmMb3oQj2/2kTOR/84cydLMqk5PzClLwIV9OAYyx7UU1eTZ2VzCa5HWMxi
	0z/NtUPXJlG8zYUUYaEODD1tdc2ZWvbt3LuW6r1PMTEAB1AT8XAdY621OIuvGvQ8MLamFE6+DJY
	rtQYdkCTwvmWOcOrauCP3xgKZ1PGrgatcV7owaSIeOuH3GFWaLs96zpwxLw==
X-Received: by 2002:ac8:5796:0:b0:4d9:f384:76a3 with SMTP id d75a77b69052e-4e576a2b23emr79564211cf.1.1759571236332;
        Sat, 04 Oct 2025 02:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGynVz3EPA0ykwKTN7pQT6siayEYYAGehr4shsq6/DGHHpjk3iwkY69IuP8QMQLOHlDY8wdAA==
X-Received: by 2002:ac8:5796:0:b0:4d9:f384:76a3 with SMTP id d75a77b69052e-4e576a2b23emr79563971cf.1.1759571235845;
        Sat, 04 Oct 2025 02:47:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e86dsm2686516e87.97.2025.10.04.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 02:47:14 -0700 (PDT)
Date: Sat, 4 Oct 2025 12:47:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hui Pu <Hui.Pu@gehealthcare.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] drm/encoder: add mutex to protect the bridge chain
Message-ID: <2ksmq6ytj3zabxuexzjuqovalik6memy33vrba2aihfld7b7so@lhqhmaargucp>
References: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
 <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-1-78bf61580a06@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-1-78bf61580a06@bootlin.com>
X-Proofpoint-GUID: Sx0tN-n6RoPTyYwvcoP4_iuAyALrgNsC
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e0ed25 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=P-IC7800AAAA:8 a=KD47DfvlZnWFAtPs4N0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfXwCQsfBBYsb3B
 +bjTMMr49IJdDZqvHvTZRX2imtXseq4iZ2SBa3yXEcFrYeopR5LtQCHGBk1o1jEALjKZ4TT1Tw6
 hMJxiLTW+udmduB+arbKOT57IxWpLeT9VdgVd5iA58T7O9b2zp+Xvm9Vsa5H+XzroTzg5gWYjS7
 bhBeONwBklq16v8aDwIwk8AUcKmxrHZbSAu2qrNLwt//wrCbBFljee2ZmmkYt+OpfkIHS1ELENs
 +Ul/8jmerQd2WQUuOF4He4rLg+U+izhgZQX8PCEErQqtDO9il5ExLN2B+FnMtCd82V1raLrdoFI
 1D/VlmCNELtjFHrC6y44uKwiB2nfv2ycPS5qWrv4JA2DNHUBYkfshlXBEwrZUukiOkJ3sJPko+u
 Mk10ipt4ysNPpnhIZ494xTJl9FyHHw==
X-Proofpoint-ORIG-GUID: Sx0tN-n6RoPTyYwvcoP4_iuAyALrgNsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

On Fri, Oct 03, 2025 at 12:39:23PM +0200, Luca Ceresoli wrote:
> The per-encoder bridge chain is currently assumed to be static once it is
> fully initialized. Work is in progress to add hot-pluggable bridges,
> breaking that assumption.
> 
> With bridge removal, the encoder chain can change without notice, removing
> tail bridges. This can be problematic while iterating over the chain.
> 
> Add a mutex to be taken whenever looping or changing the encoder chain.
> 
> Also add two APIs to lock/unlock the mutex without the need to manipulate
> internal struct drm_encoder fields.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
> - Added documentation to new APIs
> ---
>  drivers/gpu/drm/drm_encoder.c |  2 ++
>  include/drm/drm_encoder.h     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> index 8f2bc6a28482229fd0b030a1958f87753ad7885f..3261f142baea30c516499d23dbf8d0acf5952cd6 100644
> --- a/drivers/gpu/drm/drm_encoder.c
> +++ b/drivers/gpu/drm/drm_encoder.c
> @@ -129,6 +129,7 @@ static int __drm_encoder_init(struct drm_device *dev,
>  	}
>  
>  	INIT_LIST_HEAD(&encoder->bridge_chain);
> +	mutex_init(&encoder->bridge_chain_mutex);
>  	list_add_tail(&encoder->head, &dev->mode_config.encoder_list);
>  	encoder->index = dev->mode_config.num_encoder++;
>  
> @@ -202,6 +203,7 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
>  	kfree(encoder->name);
>  	list_del(&encoder->head);
>  	dev->mode_config.num_encoder--;
> +	mutex_destroy(&encoder->bridge_chain_mutex);
>  
>  	memset(encoder, 0, sizeof(*encoder));
>  }
> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> index 977a9381c8ba943b4d3e021635ea14856df8a17d..449281c37e39f67a0037603762f347f5086df983 100644
> --- a/include/drm/drm_encoder.h
> +++ b/include/drm/drm_encoder.h
> @@ -25,6 +25,7 @@
>  
>  #include <linux/list.h>
>  #include <linux/ctype.h>
> +#include <linux/mutex.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_mode.h>
>  #include <drm/drm_mode_object.h>
> @@ -189,6 +190,9 @@ struct drm_encoder {
>  	 */
>  	struct list_head bridge_chain;
>  
> +	/** @bridge_chain_mutex: protect bridge_chain from changes while iterating */
> +	struct mutex bridge_chain_mutex;
> +
>  	const struct drm_encoder_funcs *funcs;
>  	const struct drm_encoder_helper_funcs *helper_private;
>  
> @@ -319,6 +323,41 @@ static inline struct drm_encoder *drm_encoder_find(struct drm_device *dev,
>  	return mo ? obj_to_encoder(mo) : NULL;
>  }
>  
> +/**
> + * drm_encoder_chain_lock - lock the encoder bridge chain
> + * @encoder: encoder whose bridge chain must be locked
> + *
> + * Locks the mutex protecting the bridge chain from concurrent access.
> + * To be called by code modifying ot iterating over the bridge chain to
> + * prevent the list from changing while iterating over it.
> + * Call drm_encoder_chain_unlock() when done to unlock the mutex.
> + *
> + * Returns:
> + * Pointer to @encoder. Useful to lock the chain and then operate on the
> + * in the same statement, e.g.:
> + * list_first_entry_or_null(&drm_encoder_chain_lock(encoder)->bridge_chain)
> + */
> +static inline struct drm_encoder *drm_encoder_chain_lock(struct drm_encoder *encoder)

What is the use case for these wrappers? I'm asking especially since
you almost never use the return value of the _lock() one. I think with
scoped_guard you can get the same kind of code without needing extra API
or extra wrappers.

> +{
> +	if (!WARN_ON_ONCE(!encoder))
> +		mutex_lock(&encoder->bridge_chain_mutex);
> +
> +	return encoder;
> +}
> +
> +/**
> + * drm_encoder_chain_unlock - unlock the encoder bridge chain
> + * @encoder: encoder whose bridge chain must be unlocked
> + *
> + * Unlocks the mutex protecting the bridge chain from concurrent access,
> + * matching drm_encoder_chain_lock().
> + */
> +static inline void drm_encoder_chain_unlock(struct drm_encoder *encoder)
> +{
> +	if (!WARN_ON_ONCE(!encoder))
> +		mutex_unlock(&encoder->bridge_chain_mutex);
> +}
> +
>  void drm_encoder_cleanup(struct drm_encoder *encoder);
>  
>  /**
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

