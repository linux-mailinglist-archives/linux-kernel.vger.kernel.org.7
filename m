Return-Path: <linux-kernel+bounces-785479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BEB34B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F7A2071B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD7286422;
	Mon, 25 Aug 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjlo3I6k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DA287252
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151998; cv=none; b=r8pdKPBc3HMONOq2maif3o3k2RDd1MVOUHzLzQ+2HO1g0PgPZg2XN2C/sMOsxRKurkzCXpQ+dEb/LudaPHdRArRy6djKgBnX1NhmPS0ReKPk8qde2c1ZcHw+hl8Pl0PJaXN+KgK2q4Be+SvEVhpxXHmxg/bsaWoXok9jB7sPNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151998; c=relaxed/simple;
	bh=GgVblSA1zMM7t1gvgP3tTk6jx+onVRa+IGzUAL14PZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jssCSCc2f2LPzYuYZfJAHXrMEOKRpNiHU/GGsmbPEVjs38/jv9lQyKXHIRkoXUyuuhj1ZJYZIQegUBFlXDxUHP51fBWH2P4vJc7DsZ5P1U3cPr1rI4MafIuQmJ05sCkr6UpkvdKTngUIYOSCITfQYuBMxjNOn5FxBT9iH8vLcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjlo3I6k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFm3Tl004580
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QpMXjjOloTbOcv7VKi87DER32XX876zK5UxtTO2ua/w=; b=cjlo3I6kOhBPZA0p
	cSlGSa5xmLkswO5obuRr3lT6JCUurIBNg29AZt1dNny5CZcBaCf76N4y2nuELyXf
	ncRqJZeHIPP5OcEcaqOMOJYxu/au6gGmi/qrz6pXyz97bbkWG5tLYmRs/XeiF+yD
	jTVcBDyJLiedm65n8oeOgMwmma2GdCDn2L3XAa1xrrUMtfdgOIo8jzytvoZ0xPSe
	3zOrnvWB0JqyUALi0IcShbU8z5qgIs8jonUFjLPaq7uNGFHGz++Aqzqhla827Nbc
	y2L+7qzuNqSvXmUm7IfSuGfmSBEIXVfB1drY7hXAnmBqR+AHxrx30Ia8vLPriTww
	heiRVg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um6ddc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:59:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9a65c239so73086056d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151986; x=1756756786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpMXjjOloTbOcv7VKi87DER32XX876zK5UxtTO2ua/w=;
        b=Anaf5iQcjE2ogCjC3LuaH9787vpeb9jpNfQoaMqYTabhzP3cpC+dxFWFJQZbDoEBbc
         Yq3ynOAct7vWQtXO3nsZG8gVt+T1f48zkGDOpXyn2Ty1wngdiubSgL7tEoZGVXDhJAQM
         ODkCVYVgS0KiHmD20XsW4ju5cosmaQ9gtZKgiBytPSfQmzLMLbiBnkkWhwfPojRrrbiS
         eZYjFF83i8x5d4eGQmPDzWp+O78bVW4AjO1tvhClXpk2SDvkrKck0SY2lvBpAUj1O6+Y
         lytctky9TCu86+3Xwa2f+DrYs9gFmv79VCANylUV7bTRpJsayP7Fl8WYEv/fr6YxH655
         qeiw==
X-Forwarded-Encrypted: i=1; AJvYcCVAPAAJo5FiFFQXCekKeQ9dKravjbbJ4nOey+WXzrdQqKwJy+YoQlMZrCEw1x5mgCP27+uJ7J4h9ENLq30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJMvtF+NXNSF69qPYSuAwzWNs1qajV2V/UExIcWkxCjUWa7l8
	v0Ghh3PFUx+rHb7QUE7aqQsiFS0DDdmadEGLyHn+8HK8oldnEfQShtQ0w6o+IgTqLizxetj4bYX
	K2dkPdProzrOTXXAm4wtbcsMK5GL/wpc8ErYqqm/yAmfUu+4vOrfRxFD0Lnb61PvCCPE=
X-Gm-Gg: ASbGncucTqO0VXbPYfF+xg9uMIe18SxI/1m2+RrKFxZgz3O7xAfXsFGjadoBlnHDXCJ
	ZdA1DU0aNzStZvFnXkjqwdNEvTlDaGGu7iFhG3S7G/BUm5o0mRc6mMj71uiKKj9AMUliPKvZgMF
	bT8DgoG2p3Jf4B8kCIu4C6gSn8/VxF7ON4SBOgFwk+x9l/LusKj4FMK6GY6VYxrth3gd4bzpARw
	HvldboH6Rwy0FED/sTSsHvTU2jfXQCmS8P62YjMnb8lXG5HA8SYAhwUD6dJWWJ/ejJHm5rpetKs
	QWCsPJJo772t66ICUeC8HafBVOwZ6U8EMAqHbU4i9FFJQ+aJtkJJcI004G4gQEX+JOnn8CatCwx
	wkt8hzQT3X7asdqGs4SDgjcO66Lz8MnVj9OX6fIKW84M+2NcmXmQG
X-Received: by 2002:ad4:5de9:0:b0:70d:ac6c:d5e with SMTP id 6a1803df08f44-70dac6c152cmr97978686d6.17.1756151986337;
        Mon, 25 Aug 2025 12:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQJCEWzdMqyTuDrQVNON3NoBMK6mCKwkSCCF09YR8Rv+ULva4lyyz7WmxFpfIfcvr79oPndg==
X-Received: by 2002:ad4:5de9:0:b0:70d:ac6c:d5e with SMTP id 6a1803df08f44-70dac6c152cmr97978436d6.17.1756151985824;
        Mon, 25 Aug 2025 12:59:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e2687acsm17787781fa.32.2025.08.25.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:59:45 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:59:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Alex Robinson <alex@ironrobin.net>, lumag@kernel.org,
        abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: fix race in Adreno header generation
Message-ID: <7w522k6vkngqw2tfbmrhuvxxcdlby3wwzueaqw75pxud2y7puw@2rjhjl5ikn6c>
References: <20250823020919.9947-1-alex@ironrobin.net>
 <6sdzghcc4uynvmk6r4axpwgqlmgxqzi457ttedqlrql7f7lt47@glsrzu46a63x>
 <CACSVV01R=FPAErpfJJvESKig+Z8=amEkpf6QFnkXHhTjFsPf5g@mail.gmail.com>
 <5a405510-3eec-4262-9855-483dd589d8dc@oss.qualcomm.com>
 <CACSVV03y1s+EdkNm0nWFL7yuR8y=YuBs-OJaKquOh4izwKc_nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV03y1s+EdkNm0nWFL7yuR8y=YuBs-OJaKquOh4izwKc_nA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68acc0bb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=foaXouvCAAAA:8 a=ogmizbzjsSRwc_UF5_MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=lBkOZJTZZNyIbKe29SIT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX3PkM7QqiM/4w
 ciCPVm9MZz6ZuHMqGrSs5uNbEgGT645NLJuikU/B9JHHGLkZClqoRGwdUD4bSPyOu97wRY8rxK/
 SXTjb577wRnURNg+H9TIGhOQ6WwQMaBSjlNmaIUK+fLcWi7IIkjbzM1nhVcuRVgkRi0k8K4mTdj
 U8y7mPBJKHHpOidB1qunVswUN0g6ELa9TzW55wDTkLz5TFN6/J6LD4mY/bllgGwS2nPLOB71oBr
 924gZG8Ig2ULcoo07nZq2+/Y0Dsw4J1Q2wezNjgIb1t2bFvoLes9h7/v4fjgSXiEI8so0OyxIvq
 5vO2Cm9vxrNc7t/YjXzFUPpOcYSi2hkmwf4BsMyt9dLuMVo1bO/R9KaFmHL6RQyj8sb/ZR2pAl8
 VfUKTFF9
X-Proofpoint-GUID: dnrtFre20PcdgGVlPXOahMUbbEHV-65g
X-Proofpoint-ORIG-GUID: dnrtFre20PcdgGVlPXOahMUbbEHV-65g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_09,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Mon, Aug 25, 2025 at 10:48:06AM -0700, Rob Clark wrote:
> On Mon, Aug 25, 2025 at 9:23 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
> >
> > On 8/23/2025 7:46 PM, Rob Clark wrote:
> > > On Sat, Aug 23, 2025 at 6:49 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >>
> > >> On Sat, Aug 23, 2025 at 02:09:39AM +0000, Alex Robinson wrote:
> > >>> Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
> > >>> before adreno_common.xml.h is generated in trees that generate Adreno
> > >>> headers at build time. Make msm-y depend on the generated headers,
> > >>> removing the race.
> > >>>
> > >>> Signed-off-by: Alex Robinson <alex@ironrobin.net>
> > >>> ---
> > >>>  drivers/gpu/drm/msm/Makefile | 1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> > >>> index 0c0dfb25f01b..1a918d44ac48 100644
> > >>> --- a/drivers/gpu/drm/msm/Makefile
> > >>> +++ b/drivers/gpu/drm/msm/Makefile
> > >>> @@ -221,6 +221,7 @@ DISPLAY_HEADERS = \
> > >>>       generated/sfpb.xml.h
> > >>>
> > >>>  $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
> > >>> +$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
> > >>
> > >> I'd say, no. The idea was that msm-y should not depend on
> > >> ADRENO_HEADERS. If there is any dependency, please move it to adreno-y.
> > >
> > > probably we should s/adreno/gpu/ and move all the msm_gpu*.* there..
> > >
> > > In the mean time, I think we were going to drop this patch from the IFPC series
> >
> > Yeah. I will drop that patch.
> >
> > Btw, was my usage of adreno_gpu symbol in msm_gpu* files incorrect?
> 
> I suppose _technically_ it is, but the split btwn msm_gpu and adreno
> really only made sense for a2xx, and only if we tried to upstream the
> old 2d core, which never happened

Granted that there seem to be nobody interested in OpenVG anymore, I
suggest we forget that Z180 existed. I think it would be wise to
simplify things for the GPU cores (merging more of the msm_gpu_* into
adreno/).

-- 
With best wishes
Dmitry

