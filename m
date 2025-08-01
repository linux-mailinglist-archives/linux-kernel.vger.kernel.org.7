Return-Path: <linux-kernel+bounces-753253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A4B1809F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1233BB1D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356A23C8D6;
	Fri,  1 Aug 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcECG74I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A1213E9F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046105; cv=none; b=NaY4zAZwgQf3hbdAE3AoKVKo46GtT112qmJL1s/VGN6+msUCSGdBZ1r5OqoNWntJ/wnHnh5iD5bAtAAJdfzMF7neI+otiJagAEf7ypfyyDpn2MvMpyfebiPcUo0o8fs+ztKdfUCEQJtTpHV8EfEADdIT2EqojzkWFm1m/hQ3CHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046105; c=relaxed/simple;
	bh=PGLfLe/RgFNUrcEMhEAe/ep2/uugDAkeebEyoCQFeGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grebAB3m+4u2aLaguUfpYcXbCev61al5JYElnapp+LpyK5FoxBohs9v88W4VNIZQcnW7QsVOoLYu5liTIdUMMoWCNj0qBc+w/WQ7ixxZ2kNMxNnX7VbUmHDPQ86xufwMQNf7oiZp5BupT3/xPLgU/oq2CZWmKaqriPOuO346q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcECG74I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719AaG6006860
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WYXbzMnw5z0EY1ywIC96A2ih
	mXgctEyKvWfHkcqiLTI=; b=JcECG74IINB71b79qt9bmcDbE8rCgBzFU18Ibe3s
	/iFWDj+a+KdAnS3o97PmmMe8CtF2f4q8cQvx5tFKdEqUmaUtrBDVz43anokERFD/
	eSBzvbj+cuumSVM9NLVrWyy2zI+zUUWrfkEpGcpQv/WniKd7p/k5AeFbvT+SyR/r
	I5UhMf8TX3xl48O5lN2efCCWyRWgVPatZzgzpZHzJg2PlM2HsYBfEEUAlhuoReiv
	ow/kpm6sewgNaL3UFM4LlFuCbhRbb6cvLS78v4JF2xcS21c1tbXHXrWJh026gVI1
	xAMFtY2DKBuWHTpKxlOB1Bm3mdtxP02SZP5mMa/YaK4Ozg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2uf8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:01:41 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-41b4a69ddc2so834153b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046101; x=1754650901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYXbzMnw5z0EY1ywIC96A2ihmXgctEyKvWfHkcqiLTI=;
        b=S3rvDBCFeSqUVL71KwlyYD2wBgEzJ2k5zWS9zHwDrxmViC3DrIXn4xS06AbqcD0f/C
         aO66MXsRZCKhga8kJQRbC223fPiHMGnUqUxP2r/WDaBFaeiBVnFYYiIRWOl6OE6zLp7g
         1I5yQpu80LI/9L7eH2ULdiwrNPRhFBsV6zvU4zh7TrX1HMsC2vtbg982L4ocKhpUdQsB
         t+dGg7zLnBzjwgUuLyaY6uRtD+qbbQOviBhwQBmx5i6gkJQQCjdEhXUQ5pF2P+fPFNlH
         TC4QKnm7K/ZDl/EOPpM+1AF/IIScHZNZdtqXHBekO0+M6VjSj22Go8EH4BXROIFDOrG9
         wPnw==
X-Forwarded-Encrypted: i=1; AJvYcCWiSjoCJW4HfHA6m5Gj2ap6I5u2Vuczm8Hf2WKcSpr+/T0n0OqVAoT4jDMqCHNo9UKZZLqB+N1ykMqhtJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA290HkT99i4vFqgMaPMUMCPEh0ZedzPajUDjvieH52rholWNl
	7Bldg7Ga9qjTB9N7B4ldg2+9PlPlULcT9sTSlOe2DCCEhzYwXJQSYrVmO1mcaHJjElwp+ePejMo
	oonMPD9ylKuxVnaAx0rRff2IVMlXjL3SS0e9Hb2lDYvH4ys5A2dR3aq2D6Xg99AZV4r8=
X-Gm-Gg: ASbGnctzs8KrlkzsFO3+/ZCuHAA7jQaLE55DcLm56udfUPVXwOj2koGsaWsiSG9nlg8
	QZ5Hx5leTjc31uDj2Q6xjjLjyJTzSrfKqXcuFFwRuXWuTYBp6/MQ7J7kqs0eE+iXC8qThbwawyA
	X5Riu6mPgJ/1LIX9J0v+Pw4K6MFMe/r2bfPpEtFASTDLrudKj04FswxD2+7sp0osbbdripNgiZa
	2ST4reOlxewwbLhJ5l1VUf6Vzk7qB3M9zeeU5NdTR8Ow3pKBB0yhwIvmojanv3E9zS1Bvz4xZfA
	4iBpfj81WrFZaGCwa89hmuY7PyncAF03z3Uzp1wOLmmEBXl6/gjqONF/n+L8R3vvu8P8GBUqhiO
	nZbHXXERC3QrXgYiRXKvDJkNtV412D/DjO7ER8GOz2lz7Tq4oe01S
X-Received: by 2002:a05:6808:11c5:b0:409:f8e:72a4 with SMTP id 5614622812f47-431994c5dc7mr6196320b6e.2.1754046100530;
        Fri, 01 Aug 2025 04:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeekOIBhBvM1aX744gw8MC8PaaFZ0GuPKhfPo5fIJIqWt7YIuUI58LsNEZlnoO8H3h7iHzrQ==
X-Received: by 2002:a05:6808:11c5:b0:409:f8e:72a4 with SMTP id 5614622812f47-431994c5dc7mr6196247b6e.2.1754046099912;
        Fri, 01 Aug 2025 04:01:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm547517e87.54.2025.08.01.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:01:39 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:01:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, mripard@kernel.org,
        lumag@kernel.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, lyude@redhat.com,
        luca.ceresoli@bootlin.com, viro@zeniv.linux.org.uk,
        andy.yan@rock-chips.com, linux@treblig.org, javierm@redhat.com,
        linux-kernel@vger.kernel.org, devarsht@ti.com
Subject: Re: [PATCH v4 1/5] drm/bridge: cadence: cdns-mhdp8546-core: Remove
 legacy support for connector initialisation in bridge
Message-ID: <zur4q7hcb2jujfxowrhoh7sxzkawadv4oe6vuemb75xnajq6gb@ti7hhpt3fb5m>
References: <20250624054448.192801-1-j-choudhary@ti.com>
 <20250624054448.192801-2-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624054448.192801-2-j-choudhary@ti.com>
X-Proofpoint-GUID: X4vuvTbD4ePEj_cx0aSOeW2V6t0OubdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4MSBTYWx0ZWRfX4GcshZMP9K0Q
 cwhsawyolnNjplcKAPfeiNA7qIsOCo832cGwA44P9MhdwLIDSR8ReWjyVEBUrytKA+HYNrrFwkz
 RsGHs5qts3+766CP/GRIJC0yWLctu65NyAW1SgiRUz7FZ4YGh3A+wCOmTNsYw/wdkFm4aQOJ7+m
 haX4r/duLYVVqhsLjQPo0TAGitwF7n84YQ1tzsqHMFf3GRQ7J07qfVEokztHb9Q6URk8Yrw4g3w
 zf/FRfIS7uRh4vERXpGt0FC29aOVXWVOghwdYh0kvLPHUpttt2xOmRdrjd7Mu2sJLkMX1MJjY4z
 VY/ffvN6FjtGoevgPXnOzcht3P0XRkXl8p3os3j75i3fP4RTTuihn40bFvJTxcMIEcr0d3/HLK2
 TTm2BsazfpdvJBefm9PuKehDv15Uh8WrMHB31x/u05yO194CEVyCzN9C/oSgo+ZE3uEqEt5C
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688c9e95 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=sozttTNsAAAA:8 a=yxYSh2cz8_at7VSpBNAA:9 a=CjuIK1q_8ugA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: X4vuvTbD4ePEj_cx0aSOeW2V6t0OubdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010081

On Tue, Jun 24, 2025 at 11:14:44AM +0530, Jayesh Choudhary wrote:
> Now that we have DBANC framework, remove the connector initialisation code
> as that piece of code is not called if DRM_BRIDGE_ATTACH_NO_CONNECTOR flag
> is used. Only TI K3 platforms consume this driver and tidss (their display
> controller) has this flag set. So this legacy support can be dropped.
> 
> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 187 +-----------------
>  1 file changed, 10 insertions(+), 177 deletions(-)
> 

> -
> -static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
> -					    struct drm_atomic_state *state)
> -{
> -	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
> -	struct drm_connector_state *old_state, *new_state;
> -	struct drm_crtc_state *crtc_state;
> -	u64 old_cp, new_cp;
> -
> -	if (!mhdp->hdcp_supported)
> -		return 0;
> -
> -	old_state = drm_atomic_get_old_connector_state(state, conn);
> -	new_state = drm_atomic_get_new_connector_state(state, conn);
> -	old_cp = old_state->content_protection;
> -	new_cp = new_state->content_protection;
> -
> -	if (old_state->hdcp_content_type != new_state->hdcp_content_type &&
> -	    new_cp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> -		new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> -		goto mode_changed;
> -	}
> -
> -	if (!new_state->crtc) {
> -		if (old_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
> -			new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> -		return 0;
> -	}

This is the only place which handled disabling of HDCP while disabling the connector.

> -
> -	if (old_cp == new_cp ||
> -	    (old_cp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> -	     new_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED))
> -		return 0;
> -
> -mode_changed:
> -	crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
> -	crtc_state->mode_changed = true;
> -
> -	return 0;
> -}
> -

-- 
With best wishes
Dmitry

