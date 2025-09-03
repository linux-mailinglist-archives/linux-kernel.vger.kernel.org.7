Return-Path: <linux-kernel+bounces-798508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85BCB41EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7763C5634D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15242F3C2D;
	Wed,  3 Sep 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6Irafxz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECC2C190
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902656; cv=none; b=OhT8p5oqAN9fNvOy+htCBrBGWQXoCE1arvd7WsnEEFlll+omRzYTHS9zL41bcdjiQ0WtxG6ASFjzN29mJb7CtGrMEdKUMSvzWM5engIdAXqGmJ9/UUUO54t9AQ1UBTJuROuisp9KEJtAeC46YQjfebzue6kwS2IOcql7EUWPQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902656; c=relaxed/simple;
	bh=N8xj5bZNLcP1eYQY/UQ4GOKWqnxujbe0QOOjK+vE4S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYDhjFXhQ/PLAfgWsSYuvp9d5JL+cLRCCmg2K2Jk9eA5Wmb0N90L81Rqt2sR8HzB7hOUj7B8nubo9E6w6wU9Aw6faSWgognc+dYiHmFi/YauFuChrdwVYWGiuhESjjTq0bfCFxEpp59VUBFNu6CJTEpU/H6gurl1Hdhtd1T0nhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h6Irafxz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF6Wk004755
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QLthK9+25KX0PZkgxfUXb/nyfRZ4etTvDcrXLtnH1gY=; b=h6IrafxzmpW06kYa
	/dGoXvBizu/hIHW8yizzqVcUZVDilW17OR3qvIHNLtRVFQ95nM5fInGNniDBum5d
	tNvEV+q4p0fD14AQsj9rW3hF0DwyixVgCID5X3cn+B5ONRdx0S35iv9+NFpBmiRO
	UbdN0LQL16VIwIDWXpxobrJsQBEbLbkCXbTuSBmECNJ+kWdtPIZcTMt8x6QtxiT7
	K6/dmsuoUAS+piT4UJvTK/rcil9ZNjkK4+/koC1dClbGlRxaVCwyNyvzCGtOhKk0
	Ad71m3Ot58exLzhGKojjYQQgwIvNqK8m5CPTJDWTJ+EHipL0yu2Jj/ptEmt/Uv9V
	MRFMoA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbsw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:30:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-80584b42d15so502796985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902652; x=1757507452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLthK9+25KX0PZkgxfUXb/nyfRZ4etTvDcrXLtnH1gY=;
        b=YmMnoqfmTn0A32bR7ct3Fr+59sI/Z6Vqsr7qYnoXvFi2D+3fa+yhExB8353hP2An14
         e5synjvrOrNsOdgKaO4zR1cSTxSBo6FX43DXOVSqzHRBJnJqKpFWMVqXV2kGnhGwgywT
         Y5mS7qjKrzsJaWMFsO/C+u/G9mk570RCFo7mbMda8MCJjHFjVt2Z7HEFxeDfS4Y745sc
         1KkR19bffL+PLrTcJ6bXz6c4VM2gBzOJxErIljfgY+N3AlpGX3NU07bmdaI/oqEXOM4p
         SvAhIs3mpjOs9jJ644giygGamqM486RlpqOpMuLY2Goq7B3o6l0Sm6Ozx9j9all9Pn//
         EVwA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ztGRmmqKp2NQhRV+/qVphuZZ7Pyf85KZ+8yc5pmzXbbz4B1NW3Cia4CBO+L3mSfSKbkAHpbPY6znrdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfwk/je2e3IXGWs/XWcSjgAQVQhWvMlBLmKn/e4ljjviQ5DDBz
	vaFdYUTzRnIabSQjHicF74biWlHLLQPoUAFdBgHAZe3noKPrsc57KqifXIXsKPvbR6p2sxIX0Do
	Sc9nm49zauo77+V2mCeurx5VWMMDSNdvrqlkDnm/pJyhIRT6s2TNA+FsotAiEbQYZm84=
X-Gm-Gg: ASbGncv+Ch4EA+V4UqVJh4rLlqVbcHkachDrcIByyTstsF7TW7o/FR9HxkkFecLUyJf
	QpJpQ7Go0mRuFvzJkK32QPyjssCtzgxBd845CpWjeMs43TB3O4wGFX/zCFP1YDcTnQ8nivpp6Ak
	0cNQwMt1lx4zJheGeInrjNJrRzA9o4Pbu85kfb7f0A3fF44hhLz23sncC6ResdhROry+oby3Csb
	l4hi3DQGiG/wbUCEbNIWjapSfb+USHVAA0xpIV/9fsbYa/U+A51IWFsEee5GDmy2Zezc8Q9K6Ud
	00zmiA66HNETrhqRpDCNR97hKGSC3NoaTdOnQJzGzycyCV5uYJ1fiSPm/xUqVqL0Cl0kqjBFmD6
	mu95SMyYLcD7s90WeNEbGLv0Iie4OCs5pAQwIx/elCekR0QRyPosw
X-Received: by 2002:ad4:5dcf:0:b0:719:50da:4a21 with SMTP id 6a1803df08f44-71950da4ba2mr111873416d6.26.1756902652483;
        Wed, 03 Sep 2025 05:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnPeg40muTt0G1FfsjpDxo4ZRqx4blR1Wc4qnDjnE2n9owGkHkgKD0nBs0gJYO2KbOTOtoGA==
X-Received: by 2002:ad4:5dcf:0:b0:719:50da:4a21 with SMTP id 6a1803df08f44-71950da4ba2mr111872576d6.26.1756902651807;
        Wed, 03 Sep 2025 05:30:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608abc17e9sm499952e87.56.2025.09.03.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:30:49 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:30:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Heiko Stuebner <heiko@sntech.de>, Yury Norov <yury.norov@gmail.com>
Cc: Andy Yan <andyshrk@163.com>, mripard@kernel.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
        knaerzche@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 1/2] drm/rockchip: inno-hdmi: Convert to drm bridge
Message-ID: <4ox7yh3i47odinoaalzjz7d3gvx36bxbaspo6qfvvvl3jqhdiv@24ownjco3ud2>
References: <20250903110825.776807-1-andyshrk@163.com>
 <20250903110825.776807-2-andyshrk@163.com>
 <5255838.1BCLMh4Saa@phil>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5255838.1BCLMh4Saa@phil>
X-Proofpoint-GUID: DU1d5sdX0yI5nh_Zd6tm-JZmoxWa1n57
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b834fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=0SXiZArQvuHb7nzfZOsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: DU1d5sdX0yI5nh_Zd6tm-JZmoxWa1n57
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX0I9Z4JfHemTU
 bYiQ6Gg0ycaiC3jVukraC3fzePd6BDPLBgDjaFNBWClS56mvw87PWqHVbp/W43jwzonYBpDxgLl
 BqMufkBKnsf80mNtQPmMMVwGIcIz8bkh+BsaTDtkDr+eAKRhFkcGGe5zuB/GjBh6Xdel5jQ7pAU
 tQ0BW4Gakdpkkl3+0AYTH0+0gIy+cOmfGQGmfyyMFoiuzYqAF1KR0WRxY2+RY3Ke5Z6k5pzQejT
 OMg+Dhb53dTRn01jTOY3f5u3oAHvDNaqEXEFfwu4pnOYgLB5JIUi/CsolZx9yjh/aOV2dZaDJG+
 os/33dGOyUi7VmD7370Bq96a+qLNIXNyTLchLvHTa7YEtClcGYU4MphF3zToDSkdTcFpMutoai6
 dWKx7W3+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Wed, Sep 03, 2025 at 01:59:51PM +0200, Heiko Stuebner wrote:
> Hi Andy,
> 
> Am Mittwoch, 3. September 2025, 13:07:38 Mitteleuropäische Sommerzeit schrieb Andy Yan:
> > From: Andy Yan <andy.yan@rock-chips.com>
> > 
> > Convert it to drm bridge driver, it will be convenient for us to
> > migrate the connector part to the display driver later.
> > 
> > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> more like a general remark, this essentially conflicts with the
> big hiword-cleanup [0] that was merged today, as the inno-hdmi driver
> "lost" its separate HIWORD_UPDATE macro in favor a nicer generic one.
> 
> I'm not sure what the best way to proceed is, apart from waiting for
> 6.18-rc1.

I'd say, the correct way to handle would have been to:
- merge only FIELD_PREP_WM16 addition into bitmap-for-next using
  immutable tag
- merge the tag + all other patches into subsystem trees. Otherwise
  that series can cause a lot of conflicts with all affected subsystems.

Yury, would it be possible to implement this plan instead of pulling
everything through your tree?

-- 
With best wishes
Dmitry

