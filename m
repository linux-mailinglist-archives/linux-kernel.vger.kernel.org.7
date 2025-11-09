Return-Path: <linux-kernel+bounces-891940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDFC43DE3
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8305C1886C55
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA82ECEAE;
	Sun,  9 Nov 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNryNons"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27742D3A96
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692166; cv=none; b=lo8Oz/wXNMnvJu6nD4IsEwUuHBT/+ruQQQ0sOvvBqQmFbbKLPWteHPOhdjxyy6nZQWSMidNDbau1/qY9FBPsNIla2ViwE+VoadY66koLE/9ykrALhgfWgSsz9Ffvm3xCTdhLLRVw1CQcLzPQNIYrlk/0QXKDw2QJIrYGHLpMVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692166; c=relaxed/simple;
	bh=6TOHpgpqHJ5WgnknUzBZQ+Cb+5OFiDU38P5bXDVOJnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyoTUptV1jseSPkbA8AIyrMHIckIZyTF0RwUQe3NuVWRQvqpOgxi4BUkBZ9nI6rPvl4rUxq4pBIp0gOBRCmR1MceU3k+Zl8QPy3VIaQLxt2vP1Hs55xPP3cLx4vaGmJ7/zSXmMGm+kx62Eym614cIMLIwP0Mgk/I6ShwOsBpalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNryNons; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso960406a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762692161; x=1763296961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXaxtSEsQGvchBbil4q1XD2yo5gxFEG8Hu3hgTDWe1I=;
        b=vNryNonsftE4jxNo0F1H7ZDzVR2tKZIJan+FzQLQhasqwpJmkGZPpW3VPMZB8gIMV/
         BxRRrRIwWCYxwTVo9zpNaPcXxhOeTsn3LM55+b2cI9w/QwXr4TFFlOuGGytpnIO7B2kt
         HkWKgyzkjwmsvuTcisz7aezSaY9mVdWA1O1rNQlQ8Hareby7TMqd8fHbXuvQWFiCyfVq
         pa8HV328a9oz2glV95iI7M/MvLXlxFAV8bKyijbYQ0/eBjIYEyjo+HCkYqAGPGORUhak
         Ia++lRvQiFQWZxVu9KYEddSTY+Kb2WcP3xPe+vNLViI0bqn3Eye+m/98Rzkgn8XsKS+4
         FC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692161; x=1763296961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXaxtSEsQGvchBbil4q1XD2yo5gxFEG8Hu3hgTDWe1I=;
        b=GKk3BgCFrWaBen2iW92H2GYOpne6uWfS41e2O6a3bO+L/Naza5LEQh3s8fuRTU1MsX
         hJtLGf55UKdFzN7ohB2xiXCRKf3Bwcni6boTvBO9Z/BqOIazt6xRCOAlRTMyLnSXdgjh
         xQraEID3murr1sYEhxFrtwCpneyyutuGpAv0ECIEQlDVbLFw3WIczrGxqbMwcM6yG6CC
         24KW0Ym6nUx9pbOW13ATCI2wXXbAk+alwUVcMaP+9bqRH7HFRB2ETCCN+sVXy2JfqBpP
         wT4OttNSu6txZNwU9phhee39BVhSxdQw4KGKCVYjUIeCDci3WgSTNd/MSFNEbHx38ifY
         TwTw==
X-Forwarded-Encrypted: i=1; AJvYcCWDdrryFP0CxvYbZTpxVj9lBIpVsI4S3TfJjbOy5pqGqRWSu9GEiX/5VGAp7l7shgDlfzECEj70lw59/Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0o2KCO8jzyyJrYmvF2Kmaprsi2No+1Cz3Ww7jRAL+DutsLKCB
	zkpQaFFftFVwudl3IeFMQU3ntO9Psx53FvVZ2XG0FAVoxQ+YYLv02bdmemtwl+NLArU=
X-Gm-Gg: ASbGncvSaca2ZYy89CkxY3xG+7XijFKAMF5lRQZlQZCkiZXUXs2qb5tRpX9AU8n/GmL
	Ggcqbf+cwMlPUkarYKmSPgYi0pr146045wb6EnLiOXfIHqWkUEczWoaa4yYZJ8VdNJCPGrBnMSK
	3zVR0hfDB8BHg/k39Kq2T46RdwkXEJo0OrgoNU7dBi26aQOs0r7fjbFjPkmaOIuasqgk2fRK/wW
	gJI9HVtUZ9TPdO25zQfX97Duv7yS487dE4OczWu4d4vUmqQyvwINotTfU145VOnSbCImf6+vvDx
	uraKHrSj4CC5/dAnUBPs5qecDzE0tULAX+v+O0jOaqJaO8+sxoeEHld+xmi7DNYhWIwXUfB5/oP
	olqg2pBM/mjFjWdDqZoW4gGsbrDFRBL6ZoGCoI7FlY9wMp95DjHag+1c8q0XuHhXM4af8Lv4ZSv
	VKHHi0WdwyXAbgk4PhuQzgTlVXMPMA6fnNyZ2Z+tx9OTpr1mh41Vg5VDParuf/SUS4j79vy4ntZ
	vx7/tYARgO+JYv0lSr/SWLZx31Uyp4+B3IGRghrtWvjAvOU1On53U/Fquks7II32g==
X-Google-Smtp-Source: AGHT+IENKoAaMYCpquqLORFICuxP93xzbU3KBb6gWvvqfSpI7tXUE7Swy7LtzA/UFFK4KqGX4Fsd5A==
X-Received: by 2002:a17:906:f58e:b0:b70:fede:1b58 with SMTP id a640c23a62f3a-b72e028b9b0mr497726566b.2.1762692161300;
        Sun, 09 Nov 2025 04:42:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bcd59sm784848566b.53.2025.11.09.04.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:42:40 -0800 (PST)
Message-ID: <fd0a3ac1-1a6a-486f-ab0f-e5cd69f8127e@linaro.org>
Date: Sun, 9 Nov 2025 13:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 7/8] media: qcom: camss: Account for C-PHY when
 calculating link frequency
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-7-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-7-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Ensure that the link frequency divider correctly accounts for C-PHY
> operation. The divider differs between D-PHY and C-PHY, as described
> in the MIPI CSI-2 specification.
> 
> For more details, see:
> https://docs.kernel.org/driver-api/media/tx-rx.html#pixel-rate
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csid.c   | 2 +-
>   drivers/media/platform/qcom/camss/camss-csiphy.c | 6 ++++--
>   drivers/media/platform/qcom/camss/camss.c        | 7 ++++---
>   drivers/media/platform/qcom/camss/camss.h        | 2 +-
>   4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 68adea33cc719..9fb5834b28e2b 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -545,7 +545,7 @@ static int csid_set_clock_rates(struct csid_device *csid)
>   	fmt = csid_get_fmt_entry(csid->res->formats->formats, csid->res->formats->nformats,
>   				 csid->fmt[MSM_CSIPHY_PAD_SINK].code);
>   	link_freq = camss_get_link_freq(&csid->subdev.entity, fmt->bpp,
> -					csid->phy.lane_cnt);
> +					csid->phy.lane_cnt, csid->phy.cphy);
>   	if (link_freq < 0)
>   		link_freq = 0;
>   
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index a734fb7dde0a4..61f2b2ac3f159 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -144,8 +144,9 @@ static int csiphy_set_clock_rates(struct csiphy_device *csiphy)
>   	u8 bpp = csiphy_get_bpp(csiphy->res->formats->formats, csiphy->res->formats->nformats,
>   				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
>   	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
> +	bool cphy = csiphy->cfg.csi2->lane_cfg.cphy;
>   
> -	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes);
> +	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes, cphy);
>   	if (link_freq < 0)
>   		link_freq  = 0;
>   
> @@ -270,9 +271,10 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
>   	u8 bpp = csiphy_get_bpp(csiphy->res->formats->formats, csiphy->res->formats->nformats,
>   				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
>   	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
> +	bool cphy = csiphy->cfg.csi2->lane_cfg.cphy;
>   	u8 val;
>   
> -	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes);
> +	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes, cphy);
>   
>   	if (link_freq < 0) {
>   		dev_err(csiphy->camss->dev,
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 549780f3f948b..248aa6b21b5ad 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -3912,20 +3912,21 @@ struct media_pad *camss_find_sensor_pad(struct media_entity *entity)
>    * camss_get_link_freq - Get link frequency from sensor
>    * @entity: Media entity in the current pipeline
>    * @bpp: Number of bits per pixel for the current format
> - * @lanes: Number of lanes in the link to the sensor
> + * @nr_of_lanes: Number of lanes in the link to the sensor

Missing cphy doc comment.>    *
>    * Return link frequency on success or a negative error code otherwise
>    */
>   s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
> -			unsigned int lanes)
> +			unsigned int nr_of_lanes, bool cphy)
>   {
>   	struct media_pad *sensor_pad;
> +	unsigned int div = nr_of_lanes * 2 * (cphy ? 7 : 16);

What do the magic numbers 7 and 16 mean? It would be nice to describe these.

Kind regards,
Casey (she/they)

>   
>   	sensor_pad = camss_find_sensor_pad(entity);
>   	if (!sensor_pad)
>   		return -ENODEV;
>   
> -	return v4l2_get_link_freq(sensor_pad, bpp, 2 * lanes);
> +	return v4l2_get_link_freq(sensor_pad, 16 * bpp, div);
>   }
>   
>   /*
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 9d9a62640e25d..0ab908b0c037f 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -162,7 +162,7 @@ int camss_enable_clocks(int nclocks, struct camss_clock *clock,
>   void camss_disable_clocks(int nclocks, struct camss_clock *clock);
>   struct media_pad *camss_find_sensor_pad(struct media_entity *entity);
>   s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
> -			unsigned int lanes);
> +			unsigned int lanes, bool cphy);
>   int camss_get_pixel_clock(struct media_entity *entity, u64 *pixel_clock);
>   int camss_pm_domain_on(struct camss *camss, int id);
>   void camss_pm_domain_off(struct camss *camss, int id);
> 


