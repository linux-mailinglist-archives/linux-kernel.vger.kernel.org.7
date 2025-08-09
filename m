Return-Path: <linux-kernel+bounces-761008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8958B1F2F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E66F1C24FFE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985D27A452;
	Sat,  9 Aug 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8L7Eauf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029221D3F2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754725946; cv=none; b=HLTlucHQj4IwQb+ohJA+2jPtpnVzHjG4dr2rW3vXOs2K5Ddg4PK/1SY2XAyqPs8BMWU3x4LVsdJUXCszH+1oMpXesi28nVqGBFnrfKbmUtEy/6SdVQwCtiS+y/xT27cjfWwZFCZICuaO0mWzencvmxhQL972LbO8Hx0dFZLQldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754725946; c=relaxed/simple;
	bh=NShQXjAc0bMdUIG5TetdyH7Mk0NwnWLSBDC6CsUVxxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUM6w7tBXKfAXJUEo0StKS/IrIUGJ9/Fpq/RyJHqjBjgiaGogcurac3avRe4UI2k9Qe4qL1/dz0WuesLoZNCftZ6AZ1ChlGL29T7qtYXIikfJbk/5Wqw0kEOv+WYLfcHDFZnMbz+3aXnZezwGBiHb2DGOLEciC1eRLpNEmY2+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b8L7Eauf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5795tK3T003001
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VpEHcu9gcEArGq0cNR0CHEpsGr9nMZuYOYDfPme+0QE=; b=b8L7Eauf+2GTa4uH
	F9FNVrkFO7CgNzK4FCHg39V/+Ea32BiqVcOdCR/R9fpjyfciN+JGUAAzpTALVkbs
	S6sF3kooi/1CXYHdyxI+aab0q1uWho6jLMSGHmBBtfrxbRejsEwkHIAWnTsSVZpO
	Xqg9o62Hoo35E9qq5v8TFjiNuGAAyx59I//Bf4vWSZKcdiylxSG2r5Vz6CfBYIJE
	8go+hR3R1glDvDcTLXgI8UvYZgqaeUwqX49YzYDAPBCnX4o1lGI3H8XfXZCVwrld
	hvB4zsoLceL0rUzQlo6YDB/4DPwokVDOalsQ6gvKd+NDxm0lCgN9hn/m78fYZK61
	IQmVwA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmggd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:52:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e7fc5f1e45so586890885a.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754725943; x=1755330743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpEHcu9gcEArGq0cNR0CHEpsGr9nMZuYOYDfPme+0QE=;
        b=xDRr/W4TWWhojiqA4eO4xUECOLfUUMip5qOoiwcYkWDOLV77wadw5Gw6B889VcAFjh
         K2kiy5AjYP8XXis2indA3Co3RpTwVeB6XDYnqw8aWdiaxBQVF5bbSK60TCOKRC8BUJpH
         Y9By5jFL/2g6SztBXi96X/+bMkB1nnvU6ORl1MfhDzaKOBjXKoM8z2zJ8L+T4FVcyG8P
         zqwrnaVbetAk7pkvrNSr+hgskI7zNeo1OoQO3s1m8L8szg1JpbjNhmxXup01gS5o4EVx
         egYFRbCWR8DJam/fQ4/XGIFChSLt80Wp80cAbpOFKJRitH+eRyHdWgBd9zUTBknl9oF4
         xLKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuAE34iu5+gQXRY6Pz8yX0+U8srSxP2eewYQ4/f8cGk3XiRAovOWPoLXMEAEAup/FfI6KWWc7DOf3RZb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdtoTJggwfwlBYHkFfOSyrKVNBpdvVOrofXisdok7/CWgTfTB
	stESGx1SuZH0VbMcHL4ih1Mvllv5XJ4wX0l/xeQTEiLJ14I3NWqem6Vy0D3glVE8kmRF1CHrERq
	8nflONTfipypg/R/uF7/oCePWalUbFQDLqzG5Hr4lF+SwU8PItfBg1C4C/Qwneonw2Xw=
X-Gm-Gg: ASbGncvHdsNvBpt0+448a9E1AB1kklFiHdAXNgXlKGhEVMv9ALZUwbnk1DF2SJ+Yr66
	QXhsiVl3WXMOWUAribNlFlA40SPf/BHl2MzJ3BmIRqNwPiLvQi0ktthZAmRFdIJhfKT1QXVVa7a
	2WjlhQvN1wE9bpELQflaE3shARn0rYn1t4eNSy1infIzPCuXHguY1C/1Ac3N9lxAaYGiMNMgZFv
	XgU5nc5pU+zUJ2rrEheVehmX0M6py27uwN2wx1iZzFJT4gLrbrItuXl0d2JKm/hKMwots7DcPHX
	AieVPQ3SBOqr8YWfXzuX4HcszkfTOKHJp6WT8ysqd1pDNNlRjw4awC9VoxtZCTuTOW9jjzZHHRH
	Xubz1iQQWsByW1+eHlGdaxtBQ8clogtFkGrAKXJDu5EsJACb8A9LD
X-Received: by 2002:a05:620a:4143:b0:7e8:221c:c968 with SMTP id af79cd13be357-7e82c7a1401mr845376885a.65.1754725942976;
        Sat, 09 Aug 2025 00:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4XWRAAnL1JlYlSACEe9f4C6EFHC69s++GpGa7tj/KvlYxLz0g3xleWIOEQplk3ocUxXH+1Q==
X-Received: by 2002:a05:620a:4143:b0:7e8:221c:c968 with SMTP id af79cd13be357-7e82c7a1401mr845373285a.65.1754725942444;
        Sat, 09 Aug 2025 00:52:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bd63sm3312345e87.20.2025.08.09.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:52:20 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:52:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
Message-ID: <opjgpsvd3u2pje5ytyy422uxq7xzvuhfv2uhf3xz7ccampfohh@q5cu2lpcfjem>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
 <6cbe8955-cb34-43fc-9950-0fec4b7cac3e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cbe8955-cb34-43fc-9950-0fec4b7cac3e@bootlin.com>
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6896fe37 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=ROXIs7_yG6JpRt47qDYA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: _KrRla3XlRhwHnH2bomFgLd1GhhQldWf
X-Proofpoint-ORIG-GUID: _KrRla3XlRhwHnH2bomFgLd1GhhQldWf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfXwJqBrSb4JL+d
 aWKBu3UYBz8o9ACDMtQKykma/VqPv0NPJ15j+DCYKk2yH2NL1tBWL3U+C48We/K+yb7+oqdSoHV
 fUXBRQFy/GOvKQqabeP7gqL9xWvgf7RxjM0OgXZ05Os67T9RkC1JiWiB4GMR32DEGeUrgdrxUgp
 HVfRDpI3vFB35CHuos8pi0NiAiayy0wybZrrH3EjVANN0C5wkibcfttEXQrOzYqev5ba0dks0+X
 GavHxPwMlwvAP1R1N6rRSO3XFe805AFeOvjk6/nUe6Ia8IPcFognGnxydke6SEvt43NpR+Conlg
 b4rgNVGAbC2ZBUm0q2wk0L+YjvDmYovCb7oHZaAdbMs5dFgmSPuUnzrCf30fB/PBEvNa6vVhwms
 K4mhjW91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

On Fri, Aug 01, 2025 at 04:08:37PM +0200, Louis Chauvet wrote:
> 
> 
> Le 01/08/2025 à 15:51, Dmitry Baryshkov a écrit :
> > Use drmm_plain_encoder_alloc() to allocate simple encoder and
> > drmm_writeback_connector_init() in order to initialize writeback
> > connector instance.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> > index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..9986a10e8114680e9da48986f4ca3ce6ec66b8cb 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> > @@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
> >   static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
> >   	.reset = rcar_du_wb_conn_reset,
> >   	.fill_modes = drm_helper_probe_single_connector_modes,
> > -	.destroy = drm_connector_cleanup,
> >   	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
> >   	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
> >   };
> > @@ -202,15 +201,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
> >   {
> >   	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
> > +	struct drm_encoder *encoder;
> > +
> > +	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
> > +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> > +	if (IS_ERR(encoder))
> > +		return PTR_ERR(encoder);
> > +
> > +	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
> > +
> > +	encoder->possible_crtcs = 1 << drm_crtc_index(&rcrtc->crtc);
> 
> drm_crtc_mask?

I was just moving the code, but I think this kind of change is fine

> 
> With this:
> 
> Reviewed-by: Louis Chauvet <louis.chauvet>
> 
> > +
> >   	drm_connector_helper_add(&wb_conn->base,
> >   				 &rcar_du_wb_conn_helper_funcs);
> > -	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
> > -					    &rcar_du_wb_conn_funcs,
> > -					    &rcar_du_wb_enc_helper_funcs,
> > -					    writeback_formats,
> > -					    ARRAY_SIZE(writeback_formats),
> > -					    1 << drm_crtc_index(&rcrtc->crtc));
> > +	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
> > +					     &rcar_du_wb_conn_funcs,
> > +					     encoder,
> > +					     writeback_formats,
> > +					     ARRAY_SIZE(writeback_formats));
> >   }
> >   void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
> > 
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
With best wishes
Dmitry

