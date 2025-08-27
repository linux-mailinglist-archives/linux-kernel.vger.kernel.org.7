Return-Path: <linux-kernel+bounces-788690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBEDB388C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DC446028F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8402BE7A7;
	Wed, 27 Aug 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aYQoa5Tq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3043299AAA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316457; cv=none; b=F+bUAbY74JRqCxef0p4Tjrlwh/yFvMtBaf8rXMp+Pn7M7Cyl8QaFwOMILvJUFJ0i0CODSu2Rw2/OC4Zk6D7uxENQmSrRSgZCttVsx+ZH6QLSLiioNHXL0GvviePGX0UN4Kts00p8shvi6B3v3X6JTqkq/lnRxjru08s4e+43qQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316457; c=relaxed/simple;
	bh=8mZSXa5tllwYg7Vri8XTHsFCezJ/LPItoC8qISf/FQg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BLqpVCQNq7HuUAnZjf9kQMEbQ5laF8fog/KzSb/dPJbffQXYbZc8LWD4YFVs6djO22JP8iVNRbD4Y1ohZ2czosrFpdg+MKJ5lLzo0jvWbHqis1uT/JeC1kokcWjBwYGzwZwG9cCfyv/so7vGr0Hqdfqr2AJBHVV6m3oNr/aWtzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aYQoa5Tq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGKUUI018175
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pryiKbesf4KLCmykOzJgOnqNMnr4CU7A7f1EXmgKk4=; b=aYQoa5Tqtc2tN8AL
	iq3IQTavdCc6+N80wDp9/1ryQ6rtURE8hJYJ1JEf8GeMDt8Z57Ye+hrSjWGiS71g
	dhTRly7ADDiCbZ+3yuhupKzFgyym6AZwAcOPdPXs4ELX8pirZMJET9j7BYqPdz6F
	ZDY3xCJRWorp+AKCGAuCK09e4laJy4I4REdEF1KxFyiaKUObIG+jnZSoOJ8hsS/P
	20/Lf4vNVU0EKTh1RpsR1NuG7UbcbDM0y4LlPFN3ItahZrHzGcEe80H5Dqu1duk/
	fYwIxae0xwk6pCPszhHTrzdgVA9KKBlKZFlMQ3qfiDI1b8OwiDD7D9G8+1hGmZRi
	jBWi7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfnemg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:40:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109919a51so3255921cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756316454; x=1756921254;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pryiKbesf4KLCmykOzJgOnqNMnr4CU7A7f1EXmgKk4=;
        b=p7Pj3V7gLqc/CKMDWBganPYRUUkkszDm0jDEJe5IWvn8OAU+bNzIpmWp8enPlkcLbs
         2SNU2oIiPvAIw5GL1KvwenktSktokFNvOGtxWelbPQpBuZL84ziV0FTq1De2z0wgMEHr
         GmaG3tctoKQavh2vfUX8UEkSbZSeET1Q5/T4SBCXvBbb0+FbbkzMUyZ1lxiXrUzA4ktz
         XNx4lJSWuqpr7Wkt8FQvDSv8sVibWthwr7el48ejZjZWd52w56NwG2Y9ozxRmM0A/swc
         EjsQbE6lfyECLcOVQ1Mn9yKsC95ei4oOJB+lrLnpVnW2vFCRpF7p8ALAPSFVJtnn9+ze
         L2rw==
X-Forwarded-Encrypted: i=1; AJvYcCXBMbJYv8Od8sCyvbs48dulUrwcLZ9rckjh0xJFyM+kRXy4OSH7TF1PCoSUOgCW8OsnlGRVZY+Gndz/J3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzz4yrkRyt6iLvt5upm8tfITuGTl9vY3/83STWOzL0q+dLQs/2
	mKg4qcvr6ESpB62/t2vtYgDDAc8v/6Ctkeo+0aT7Th9Zgmwg3RaRlP3WkDfzx1z9oWzab7MNkK5
	1wVgk4kNb9mFXWqJkk3x5xFEiDsvmuMBGKa+OVppg0tladcoBnr+pb096otvxeqDcvcs=
X-Gm-Gg: ASbGnctuUGtAUhtWte2C3R1AiNF3Pwq4QriiyiwvOJk3R0ENqxz4emcetXGiR6YmI5+
	KQkJ9aBKRSrSAcVKJCgYZ9lC/NwB45uxQa6V7salYJ/CcqW76yCm0uNCpxdPEOh5T0nSTv4NkN2
	ThMviOD2MeqThp/Ps075HeyrpFjjHl0OsNEBanVq6vjtjIr7nLUKDsjbHx0EsNozSgr7PGkrvh8
	lF0xdYqNn39dAZlIZFY7LT9eYkIorAZKGRvMWNmoU+hwTFv+zPwFlZxfy3eXi3FB1vDO0S9VVPT
	/39Zo3xhXM3LC48I50Jn1zzknvTTtymqM/Xj6W5sAUstKN6krJ8BQD8axeWeUhJH3GWD7VLDGTH
	+qNfIjJtQ5UaA14NYbqLRdA==
X-Received: by 2002:a05:6214:27c1:b0:70b:5320:d416 with SMTP id 6a1803df08f44-70d970cd29fmr238271556d6.14.1756316453898;
        Wed, 27 Aug 2025 10:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhCi0u3Z5H0bwldj3p8+1IvfpKHSh571vUpFu3K1OKrspl//SOwGcmP4Yk4ANptZX5dCndsg==
X-Received: by 2002:a05:6214:27c1:b0:70b:5320:d416 with SMTP id 6a1803df08f44-70d970cd29fmr238270536d6.14.1756316452731;
        Wed, 27 Aug 2025 10:40:52 -0700 (PDT)
Received: from ehlo.thunderbird.net (85-76-46-56-nat.elisa-mobile.fi. [85.76.46.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5aa917sm28124531fa.41.2025.08.27.10.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 10:40:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 20:40:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Louis Chauvet <louis.chauvet@bootlin.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Manikandan Muralidharan <manikandan.m@microchip.com>,
        Dharma Balasubiramani <dharma.b@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, Liu Ying <victor.liu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hansg@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?ISO-8859-1?Q?Ma=EDra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
CC: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_01/39=5D_drm/atomic=3A_Make_drm=5Fatomic?=
 =?US-ASCII?Q?=5Fget=5Fconnector=5Fstate=28=29_early_return_consistent?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250825-drm-no-more-existing-state-v1-1-f08ccd9f85c9@kernel.org>
References: <20250825-drm-no-more-existing-state-v1-0-f08ccd9f85c9@kernel.org> <20250825-drm-no-more-existing-state-v1-1-f08ccd9f85c9@kernel.org>
Message-ID: <BBD9E72B-B1B6-4072-A465-68204879684C@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwc4W8AJm3T/S
 M3jjVvlQ2PmXa3YERDloHKtdUE9ZYFdAWeE8fD4uvZCHRV8K4tof+pAd68uVgSPJBbfLHFSohVP
 iTeUUvqBqela5b1b2upmtmAvnZ61EbUpB5ssfGfwqX14TSQm2lrqqiST3Z9DGy/jO5jJx3BZFeu
 yRw4oHe6wsTOXrTm6uQkHnXnyTlgcpVAUYcWBAI1KFUJclsUFUo7qUbRuV2xoMBIsOEBN85BU7q
 YUIEVHyn7wYq10gs7WDSDZH31bkk48PlmE8s2UZIiL0g6s99TfJB3n9U9cMtK3DcZGoZ7u3smY5
 bIsTQCc19lWn+rERFsUk1YFvyN1p/WZ3ON0/fSerLF9wSdthK6r6TwT5r6xYNYHnmOCi8qC9kgB
 7Wjb91Nm
X-Proofpoint-GUID: kfP-19ew8y2vQIAPEPDOSR8CYIoqVC_-
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68af4326 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ntis2/2Y3p1p47GkerkPQg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=puQWGBksFvoA:10 a=VwQbUJbxAAAA:8
 a=V78A4Cvkybgf4icwE48A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: kfP-19ew8y2vQIAPEPDOSR8CYIoqVC_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On 25 August 2025 16=2E43=2E06 EEST, Maxime Ripard <mripard@kernel=2Eorg> w=
rote:
>The drm_atomic_get_connector_state() tries to lookup if a connector
>state was already allocated in the global state to return early if it
>was the case=2E drm_atomic_get_plane_state() and
>drm_atomic_get_crtc_state() behave similarly=2E
>
>However, and unlike the other two, drm_atomic_get_connector_state() will
>do that lookup after having called drm_modeset_lock(), when the others
>will do it before=2E
>
>Let's move the early return before the lock to make it consistent=2E
>
>Signed-off-by: Maxime Ripard <mripard@kernel=2Eorg>
>---
> drivers/gpu/drm/drm_atomic=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/drm_atomic=2Ec b/drivers/gpu/drm/drm_atomic=
=2Ec
>index cd15cf52f0c9144711da5879da57884674aea9e4=2E=2Efe21f154e0fa030f85fb3=
d6d35e2684adcf36e26 100644
>--- a/drivers/gpu/drm/drm_atomic=2Ec
>+++ b/drivers/gpu/drm/drm_atomic=2Ec
>@@ -1128,10 +1128,13 @@ drm_atomic_get_connector_state(struct drm_atomic_=
state *state,
> 	struct drm_mode_config *config =3D &connector->dev->mode_config;
> 	struct drm_connector_state *connector_state;
>=20
> 	WARN_ON(!state->acquire_ctx);
>=20
>+	if (state->connectors[index]=2Estate)
>+		return state->connectors[index]=2Estate;

Unlike other DRM objects, connectors are dynamic=2E There is no guarantee =
that at this point this array entry exists and it's valid=2E You might be t=
ampering with the unallocated memory=2E

>+
> 	ret =3D drm_modeset_lock(&config->connection_mutex, state->acquire_ctx)=
;
> 	if (ret)
> 		return ERR_PTR(ret);
>=20
> 	index =3D drm_connector_index(connector);
>@@ -1150,13 +1153,10 @@ drm_atomic_get_connector_state(struct drm_atomic_=
state *state,
> 		       sizeof(*state->connectors) * (alloc - state->num_connector));
>=20
> 		state->num_connector =3D alloc;
> 	}
>=20
>-	if (state->connectors[index]=2Estate)
>-		return state->connectors[index]=2Estate;
>-
> 	connector_state =3D connector->funcs->atomic_duplicate_state(connector)=
;
> 	if (!connector_state)
> 		return ERR_PTR(-ENOMEM);
>=20
> 	drm_connector_get(connector);
>


With best wishes=20
Dmitry

