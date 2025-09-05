Return-Path: <linux-kernel+bounces-803101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91824B45A9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FDACB64063
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE434320C;
	Fri,  5 Sep 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bVUyYcmt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E04B640
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082670; cv=none; b=Ql52hfLmz1GadAhPCtpqOZK5w5/CquhQWo+A7d/T3amP9aZ8ra+pZnw5qTAaBz78mHOEHe1TcoEh4kYuG6UxHgdKAnWN7wT4OR7eXiTzMlpileuAxWweJSGW5ZS6FA50J2MXXaFlt8u+ECDIqnrzx/76xTPZ97DNEv+KB3SpgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082670; c=relaxed/simple;
	bh=IwImn0wqvSfK0iU03Q+t42WtAYF0FVldKCvgLIs9T0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVHHnuc2mhcJznzivbHX7C9pyNVQeQNeZ3rrAIOgt7jhVZL9sX7hEH/Ya4YxawdliZP8Jezdity38+3Btk1+gfREMA4D+D5HDRRxhbDdvgkkiV3Stw8vLtoSH3KzclihbdsaAjMXk9M0S0joht5/GlhcPIVmjsuCoAP2/zKIY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bVUyYcmt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857bgap023899
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=j9ZApnUjN7UsOQPoKIdWyAJT
	kwjuDYwDGZ/yh60PLK0=; b=bVUyYcmtDDh8VETAunA3B0OectvFAsIqsWfiKlX1
	uOvQW/i78nrmmgu3q2BOT5h54wiVCDkEsDXwbOX7eg09RNa+PP56/nNrsBMPzcz/
	+FTUS1PaMFGija2DLNlSNn2Y05yWCxeI0JOtjYLaggsFg3ElLM2TyGjTini3OwXd
	oP+saMrRRtel3EmHg7pHx3TQpQQq7nZKj4Uo3ooNOkJXx+r+L3zEuocV1czHFLfw
	5QcmDd1X4bznBSRiB/vRAa0B0pkysBYJoYx+K8nSvLgFJwrtrcVrPAL9d/NKAPKh
	kbBV17PqOWfJ+FXoCXeBf+uL88iwnQPwWjl2Pcb3vZdFHg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fu8se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:31:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-898c0d9f127so798114241.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082666; x=1757687466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9ZApnUjN7UsOQPoKIdWyAJTkwjuDYwDGZ/yh60PLK0=;
        b=lU9jvKiiJJokpugNNISsELpXbFCD071HVy291VJYq2L+hz19g6W57yaEga8mHiNUF4
         gaXDpSHV6qYkgILH+0HP3F7AgYdooBnW0/6/SjVXQp9rWU9ycYU3qnsHGHPMEOGHwh6n
         HZ0Tp22VSXTFHYjpN6TURgX9JZTcoDtgTrkHwCGNr913F/xeRVT0+9kJyGt7bH8wyuf0
         wfuOZirVEOTiCZPCv2q6lk3Iu0iceywZ1kPiFmOX6TkA5Wd1GQGT6uQ/5sWWj/KP7pfB
         MDfUv2n9z332u2AjiTHERzpInbVCrOYRZKKMpIgwK/xkaCRV80icgNuaqVUep+60D0ze
         wjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxjkuHEx6vvtFS9Kfo7KbFFtp70Lwi74ZZqg0NaglqCIbUIpRxOJT+vQ16aeGbL9ZX49WGQgJcL+2+Q9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKE1rPPQvujvq4jANGpq83qCA9yxx8LV93mRe17wY68LQFUWJ
	HWDElXqcUjSBRPdAtG+2AhYx6VCPSHEGK+hvHXhbw8ydf1v1/RnWMsHmCx8wiCBC4qiDDvGgyRW
	3oWirWx0vK/alMrn0gJjQthEJ5Utk/CJZbx/AL9NkrbqzDiiCq+/a6qNgQ0fRclKpsTs=
X-Gm-Gg: ASbGncuk38E4dfHGYlZ9xANgcEelZoFNuIv+1F3p2OljHSBeI6RVm7C1dOg5Co4sv9n
	jfJ2MhsgmIFZbvsL6IRgL8QlqSQiVK5JHB2HzBtPCBk5l20tOWyptWisrSpZZaOT2e2eiRszXtu
	1qIojTbK6IxSm0EALPh+aU0ayO/sPoQkGey7t8OMKq38+QEcZjVfqoyv8ogoMTANWP0NQhccCWD
	XBhrRvNzdvdwee+J0iimspCz3oQt1fr4b+aXZvePwvthiR4K3DnbN7JyvUOqUOQpkK5wvgRpr05
	PJcnneua68y383TN8k2ssmu/6qRh8610/NSsmaZl6sJ/gJg/dR8co96r9nAkc3OJxaA1Kwa8e2Z
	6aCAKFMqEJWWvbJkWDV0esCkpESTbAawry7+tCsrFlBr1kbrgcTiA
X-Received: by 2002:a05:6102:6118:20b0:534:cfe0:f83e with SMTP id ada2fe7eead31-534cfe10551mr3152007137.3.1757082665897;
        Fri, 05 Sep 2025 07:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLl5AOay7y0G17NEbLZcAoeTfq3O897cD1Qf/UFv9YwhDugTyucF2mNCmpTGSNe50uSomnRw==
X-Received: by 2002:a05:6102:6118:20b0:534:cfe0:f83e with SMTP id ada2fe7eead31-534cfe10551mr3151970137.3.1757082665027;
        Fri, 05 Sep 2025 07:31:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab93363sm1816654e87.41.2025.09.05.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:31:04 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:31:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liu Ying <victor.liu@nxp.com>
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
        Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ite-it6263: Support HDMI vendor specific
 infoframe
Message-ID: <jaqzhm6oi6emkpqrysdgxppfndge46x5hsarczplboyfaw7p26@o5nr7xvtrxp4>
References: <20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634@nxp.com>
 <6i7eyxajmelu3x4ckvwifmizln6jzybt6ykpwlefna3k3noop4@e5zdvzor24fn>
 <023ae7ec-77a5-412f-bef5-105350561354@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023ae7ec-77a5-412f-bef5-105350561354@nxp.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX0FJKFC7s85ZS
 vuBSI8Vsb1of5VVMtQk6axC6C9SXSVrpr8uA7Cft42Xlk8tr+i0q6Qos/GHYKqKFe8o9BbbAbKE
 NT0uI773CoZrA8rT/jKpGUP+5vYZ4dbUsna5KnDE3055zsvQUomheOLsIUd8irJl5PP6sfi4I25
 0O4isw+0jpZdbb9yKS3QLhMPojRXeh+9re/iwoKMi88kHerjX8IKasmIVELd62bW5uoiSx7rbXD
 Uh6CnIGiGJJe9VrSkeUa4G9d3t4QSoHQgJ+PWyBO8srdQX39NaPHnY2VE6CDAqtuCwlFSd0nOQw
 GKEGj0wZcGUbZZ5UrcuOTbQSy7IaX5bWD6bnvYlnPbouKW8fR4GrmZedtcEFI7+x2yyGglWCqCQ
 +WLDFTfw
X-Proofpoint-ORIG-GUID: GYvIlaMPsqtdBE2ntI5suEZFMe826PGK
X-Proofpoint-GUID: GYvIlaMPsqtdBE2ntI5suEZFMe826PGK
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68baf42b cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=Ns9eNvu6AAAA:8 a=QQB7br6kf_taGTjKchUA:9
 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=ST-jHhOKWsTCqRlWije3:22
 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On Fri, Sep 05, 2025 at 01:46:56PM +0800, Liu Ying wrote:
> On 09/05/2025, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 05:10:02PM +0800, Liu Ying wrote:
> >> IT6263 supports HDMI vendor specific infoframe.  The infoframe header
> >> and payload are configurable via NULL packet registers.  The infoframe
> >> is enabled and disabled via PKT_NULL_CTRL register.  Add the HDMI vendor
> >> specific infoframe support.
> >>
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6263.c | 72 ++++++++++++++++++++++++++-----------
> >>  1 file changed, 52 insertions(+), 20 deletions(-)
> >>
> >> +	case HDMI_INFOFRAME_TYPE_VENDOR:
> >> +		const char zero_bulk[HDMI_PKT_HB_PB_CHUNK_SIZE] = { };
> >> +
> >> +		/* clear NULL packet registers due to undefined default value */
> >> +		regmap_bulk_write(regmap, HDMI_REG_PKT_HB(0),
> >> +				  zero_bulk, sizeof(zero_bulk));
> > 
> > What if you move this to the probe function? Then there will be no need
> > to write those registers each time the infoframe is being written.
> 
> Good idea.  But looking at drm_hdmi_vendor_infoframe_from_display_mode(),
> hdmi_vendor_infoframe_length() and hdmi_vendor_infoframe_pack_only(), the
> payload length could be changed in runtime according to display mode's VIC
> and flags(see DRM_MODE_FLAG_3D_MASK).  And, IT6263 supports HDMI1.4a 3D
> formats according to it's product information[1].  So, it makes sense to
> clear HDMI_REG_PKT_PB(5) and HDMI_REG_PKT_PB(6) here which map to ptr[8]
> and ptr[9] in hdmi_vendor_infoframe_pack_only().  For v2, I'd move the
> NULL packet registers bulk write to it6263_hdmi_config()(i.e., it6263_probe())
> and write zero to HDMI_REG_PKT_PB(5) and HDMI_REG_PKT_PB(6) here.

Then you don't even need to write zeroes in probe(). Just write
something like:

regmap_bulk_write(regmap, HDMI_REG_PKT_HB(len), zero_bulk, FRAMESIZE-len);

But as a note: I don't think other drivers zero out packet memory. I
think it's expected that displays ignore the frame after the 'len'
bytes.

> 
> What do you think?
> 
> [1] www.ite.com.tw/en/product/cate1/IT6263
> 
> > 
> > LGTM otherwise.
> > 
> >> +
> >> +		/* write header and payload */
> >> +		regmap_bulk_write(regmap, HDMI_REG_PKT_HB(0), buffer, len);
> >> +
> >> +		regmap_write(regmap, HDMI_REG_PKT_NULL_CTRL,
> >> +			     ENABLE_PKT | REPEAT_PKT);
> >> +		break;
> > 
> 
> -- 
> Regards,
> Liu Ying

-- 
With best wishes
Dmitry

