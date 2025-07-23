Return-Path: <linux-kernel+bounces-742422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA3B0F181
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF7118988B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BE72E499B;
	Wed, 23 Jul 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X/RBf5x7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB22E427C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270911; cv=none; b=Ms8LBVp58hV9wGzb2dDrHVgwsT93n4irC1CQaLZi4UddEL22A2roRgFYGWyPEE7gJlPRPLxExD0MvgCK6DtHVdzcrjZ2H2YnGZLId2qWYSIT1X3LnKQETHv5OLlOpfNeQtBJKOHariu4jRs2PszKeb6AskXeLyqttge+5yd8ceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270911; c=relaxed/simple;
	bh=9p4yvzcPbUOJXzzna7U2xP3Hk9ZhWbAEUJYLFo7n8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPFvefu7vmXSrDs3mSf2ifIC3Incc0Io9OpgwTLav382zmVHkykyqDWI48LqZ3qz7TpAPS8B2GrSJirBsdg7CohN1mgeW0ZFRvKvXYygMHSr3O0z8Ctpm83I/YvmmsKX3k2QuqI8unRnjasj7ovTd5W/Epo6y8Sa09fQhArawQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X/RBf5x7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8pYoP009196
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5JgycBmaJtS6jwA2vObmBGMO
	3gBaJOi2buVdHi6WlBE=; b=X/RBf5x7Zb0y5FRNHMzI70jYsu2GnthGo+/1E8fe
	aC3PYHH6dO/iNq9UDcK+tIhbS62cM/WAOniEpc/gUmlEvJYTWK89fB1AcASMJtDP
	oXO3R+B28Tsi8rRV/gmOeomtScQebzr0ZBllrSij5EdfRld2wVTGHa7DVuWPC+4H
	xj0KVxGk0nSlEcVr7h75pOqOc0K5ri/qCeiq4EpdufmoSzj2iJFI25DFFtJNAPpB
	493mRomaUovaTpXyc0wAlHHysPBGoMxjuIeiBJ1fcOJdhkjoNfqt6h8BI6dOfiJr
	QBA57Rq7gVi95k5+R0JsXbjen64XyDvqUkZI94CFKLLjgw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na3dad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:41:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-706efc88653so36847516d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270907; x=1753875707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JgycBmaJtS6jwA2vObmBGMO3gBaJOi2buVdHi6WlBE=;
        b=fL00rLH2zrUXnshT2Q8Zbve4a1NDFoJRpR523vNWuioLubxFl23vi/8n0AN7MEMkPr
         gqKR7C6bY23z8ntcBclaDFq4Yv16PjHqmYxwVmTtDjPJ2uNxR4yeoAED7a3m4WIF2lrL
         +msCH4uE3Zak9WRAdeM6eaX8EctPkikuT3omTsJ0QsRMGl1cVqq/xYc4VEP5YscXxn28
         TZYJsKI9RfIBi4t6yCTfMcOsXxksPoT4/FsrK9HEv4JNK0vUQaQPFs1YrJY3ma7c17HF
         1ifOMJG3cHrZSof972kYWIIUEkO1PIBLtp2XTJ5mLI+ooorsid5zquHlHLpkM1UTe1OA
         PNNA==
X-Gm-Message-State: AOJu0YzP+LFFiPch1tR5Zxt4qiGySdN/imXCoAP+jJaNYBduTyb6bh0E
	ZLovmB75W88JTmclyHBGX4hYt+MPgJ7Lr8C79sMlqmcz3y/8fwV0U8riDxS4S3vNmA4o4rwrTlM
	2fCesgRqha3kNv7ueeCStnhS4zEVCnDSdsYNnlWKweoDp4mr/ScsOJTLzt2AzW0bIBYc=
X-Gm-Gg: ASbGncvC6jokqkJAY0kS3LYmzml8+1ZkWhYYWVAWVYiuA2aZfoV/KULHV+bpZ7q946u
	vl/LhFIl04bloWw/O8ycUK5DNloaG+TYFMPLQ8HPFrL9sHr8FbZkL1w2GS3V7nxwQQAk3Pcvxig
	oVB1VqLiliT6fPhVLRH2m0EFLxx7RRVXPY8EWh0LyFGl9YQQnJ+PH7ASiZ5oAFdDZb6qpXCxMQ7
	/wa/AcbC9sAi4zwFcWXC4UJOiQk1lfb081qDlgA8nmy5v3aMeTorpfsMXegHE+FxYTpY9RakdgG
	dmD2kReqymMXQHY1xZa5G35wLxQ//LnvvvNGKlhJRjUkrw4YilikHK8jiIxQbGyaoHy5FybBN6v
	n5OwCX+O1K7e/Txhdsrku/iWSid6dFg5Fdr7jmxtOwxX2JHOausc9
X-Received: by 2002:a05:6214:2022:b0:705:227d:a511 with SMTP id 6a1803df08f44-707006663edmr31545986d6.32.1753270907053;
        Wed, 23 Jul 2025 04:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2d/uJDyGfd7UjhAFgz6WbKdA/P9xAYFLyZl/3beSYNXfadb2NkoYb+5O8+3feDQebbwy+Cw==
X-Received: by 2002:a05:6214:2022:b0:705:227d:a511 with SMTP id 6a1803df08f44-707006663edmr31545426d6.32.1753270906513;
        Wed, 23 Jul 2025 04:41:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b672sm2257705e87.27.2025.07.23.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:41:45 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:41:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org,
        linux-sound@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] drm/bridge: dw-hdmi-qp: Return 0 in audio prepare
 when disconnected
Message-ID: <hw5grsaqfef4l55pu7ypsgojnltcynl22l4jqb7w2t6vlo3yxo@d5yhtxcmtroq>
References: <20250722195437.1347865-1-detlev.casanova@collabora.com>
 <20250722195437.1347865-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722195437.1347865-2-detlev.casanova@collabora.com>
X-Proofpoint-GUID: BJMXZviWM9qGbjeQk7h_Li2vTlA4QnPp
X-Proofpoint-ORIG-GUID: BJMXZviWM9qGbjeQk7h_Li2vTlA4QnPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5OSBTYWx0ZWRfXwoF/Rys+kxmH
 PkyyGZ59tE3JfJUjvch2F058Vnu19ai+N88csLE1bMNQ8DZd4ku+bgufVQQwV8jKHRfxgtMlrIQ
 cA9WZGVKKDIWX5oBVg6XXV1M4af5vizN4McICT2A3U7TgqfUTSom9l5zZSCY+xG1U3i5/Tlqqs2
 vUk/pUinVR1qbFKuljR2hVpkZUbnEb+kiUAQXD5bP+RRuPBirgGDRcsuQS2EPSUkXrYdd2YvaHV
 uongO/TuYC4X+BvRRsBvQk8sLPsWODHs+Jmel1Y2ua9NT7BQWspK3l3KESpMXoKnkKW1C0yLml5
 Iz8+x96vjT434M9OYKNcpf2ZGMDjDIW/mEg2XjvZUYqztK5TpN9/RbaewkJdZkLCGpp5Hg+A0hQ
 4PGSRfF55JyqPd6v2WKzREselKM+dqSU3Uqd1/D25CS0a8v3kAbLpB1Cun0ZSSfXWZQiNUgc
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880ca7c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=nOY6ST1na_5B9o45XBQA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230099

On Tue, Jul 22, 2025 at 03:54:35PM -0400, Detlev Casanova wrote:
> To configure audio registers, the clock of the video port in use must be
> enabled.
> As those clocks are managed by the VOP driver, they can't be enabled here
> to write the registers even when the HDMI cable is disconnected.
> 
> Furthermore, the registers values are computed from the TMDS char rate,
> which is not available when disconnected.
> 
> Returning -ENODEV seemed reasonable at first, but ASoC will log an error
> multiple times if dw_hdmi_qp_audio_prepare() return an error.
> Userspace might also retry multiple times, filling the kernel log with:
> 
> hdmi-audio-codec hdmi-audio-codec.0.auto: ASoC error (-19): at snd_soc_dai_prepare() on i2s-hifi
> 
> This has become even worse with the support of the second HDMI TX port.
> 
> Activating the clocks to write fake data (fake because the TMDS char
> rate is unavailable) would require API changes to communicate between
> VOP and HDMI, which doesn't really make sense.
> 
> Using a cached regmap to be dumped when a cable is connected won't work
> because writing order is important and some data needs to be retrieved
> from registers to write others.
> 
> Returning 0 to silently fail sounds like the best and simplest solution.
> 
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index 5e5f8c2f95be1..9b9d43c02e3a5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -458,8 +458,16 @@ static int dw_hdmi_qp_audio_prepare(struct drm_connector *connector,
>  	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>  	bool ref2stream = false;
>  
> +	/*
> +	 * Silently return if tmds_char_rate is not set.
> +	 *
> +	 * Writing audio registers requires that the clock of the Video Port currently in
> +	 * use by the VOP (dclk_vp<id>) is enabled.
> +	 * That clock is guaranteed to be enabled when hdmi->tmds_char_rate is set, so we
> +	 * only configure audio when it is set.
> +	 */
>  	if (!hdmi->tmds_char_rate)
> -		return -ENODEV;
> +		return 0;

What if the cable gets diconnected _while_ this function is running?

>  
>  	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
>  		dev_err(hdmi->dev, "unsupported clock settings\n");
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

