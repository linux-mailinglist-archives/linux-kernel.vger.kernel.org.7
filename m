Return-Path: <linux-kernel+bounces-702625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB29AE84DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64931C20365
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647925A320;
	Wed, 25 Jun 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hHBQ+xaS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC125B2F0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858383; cv=none; b=b5zPorVWVzQXF9x3VXFS7z0a2BrkUd5sArwRZ3bfgFjyhPHjtVwLiblAkV1QvCpwibgXwwAdSI5Mc3GpnuZqwnScXaPXJ4JVwi2tUGdJ38vOafY9pSpKQd624tTepzhAPSz1ZUUo/0WAfsBVC7A6jPnieQWWYZ/nxSKWqvtl6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858383; c=relaxed/simple;
	bh=iDtidSp9DZtXa8ZMAJGi6aHMYavT5+2Sfqse9JleUGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZaDVwKGh7HE+HHeGS8JjnVoQKM7XFuxd1qLTkVaPJCXG2mPlzmLTiT+gCPYaRTz9OWM05ppQvrcfjvJm51pSg8LefvMFZ3IVFRwQIcsaXEqh/YoTTU7tqnlyatLUCoO1Y3cO6pL9aB89VEogZx9wgEGsskgSNojC60JYSZUsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hHBQ+xaS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PCaWvp014580
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 13:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ugc15VkAieW92BplKCsOFTA9
	oTVM65uOh8ZQRu0jejs=; b=hHBQ+xaS+LqzXBmVTkE4eDbwL10mVelmSH9lWmG5
	TXd/0DW+Fqdu0XP1B+HDulem07hJhsGfvwtzOAZ+Za/e7vGsfLP5SdCrt0n4Eahl
	UxFnw58m2znu2fpyqPr1MgACD3XoGHL0vTNHnCwTkclKRMsv+cD+SA84qTmAkHCd
	fPW6Q2ZySWWswb06WEn0RMydk9fQtl1S7xemooUBf2IK9ivkCUhHbASyptvDr+1C
	AvbPF3mw+x007AF2//lDxQsYw4giydqUDSMJbEkIZ/Ab06xkieT+99siSyIinY7s
	ME+J1oEUjnndax06m0LCmaVVlCgJECEwnrSH/0T38wRsTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5s46w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 13:32:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7cf6c53390eso515194585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 06:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858378; x=1751463178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugc15VkAieW92BplKCsOFTA9oTVM65uOh8ZQRu0jejs=;
        b=ejzNK5iAWe0qInnm2rovxDupYse/m2GB3QDa+2eMoLkH+K0kuRadBkvolWvVl82hJO
         L9OfGppcWpDHQMaBaO6D0cKPfUNWWSPwbHK6+j5dwB04FGESLGRUg2MEOrg6GCWaRGfV
         eckYRqy4GW5rLZop9u0dB6lhp8x65JuTPgmp1y1VYPrdr9GtS+I0JHItlypPNwm3BALc
         wJgSkj9gZczU5CC4RKJnaLDX0On1A7AirEBNiR7rLtJ1f6CgC1T8pvcEkQD987jy+hm8
         K/Zt9ZrhNlHfPcDKGUqDhLLJ4NYqAbgO8K3hwS9ZqrA04m4JW0/nKdX95munYX/cwSV2
         +GvA==
X-Forwarded-Encrypted: i=1; AJvYcCUn+ptm3LJ1P1BtWbv114f0sc6ilX1aphWeagMRtds14WZIZM8Rr/QKjJGK60OpeCWyLoxylW3RHvPynhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYbEUoOgHmc8zA0jnJzrrwatEY+SaEDzguTk7EnIg5Rz4xUUj
	MSRUSXanlHpTOw3Y4MQr+UwiA94nfROceqKgPwE8QEiDgl68qNbDj7koE6qXLNIDFaTrB3e6VAw
	elIMprIiexaLOAjlGMZVSzkv03ODxcYvPCp/8rZzz5O1Kn/eWX990LsuWZUo1HiwvgYI=
X-Gm-Gg: ASbGncsNhPjRQD8vI23wmYn/rWu6bF0CZlRu5mpxrzxe2RVMlNWmY0P4acSEm2ucnOJ
	WWe8m0gEXfsMjPlrMKOopgyCCHuyvjfoTn3JXWp7Y7WK5l5jSOFOXelYRVZZ8UdAfww3zMYB5WX
	54gRYbBou7zuBuDetnJpmrG7NPU3sVeVebts4NM6L/28sYAhq8nXpzX/LxShTBBKQwreH7Rxl/N
	32MZ5DeARSDjcQtJ4CIwfOIha30Jz3h1J2smUsMlxdWW3Qw3avGVAASMayHG1U3OMEsXhpIGqiu
	sjVskyGcUaba8g2pnAYIwz4m8rs47VWzeSY78/yoNunIashkBb3miOLILtje4zgNDgPzVaHHyN5
	neo92WtZ2hEUnjgMn3bP9+/E1pqjlEqEw/Go=
X-Received: by 2002:a05:620a:1921:b0:7d0:a165:60f8 with SMTP id af79cd13be357-7d429745a9fmr410212385a.25.1750858378319;
        Wed, 25 Jun 2025 06:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYktJIbhNyuz8SUko28l7s/gB3q+K8KaX5gg77YQ8irCoTNQczVvRWQpLjlZxw1oZ297XRBw==
X-Received: by 2002:a05:620a:1921:b0:7d0:a165:60f8 with SMTP id af79cd13be357-7d429745a9fmr410207085a.25.1750858377778;
        Wed, 25 Jun 2025 06:32:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41d2e38sm2189145e87.240.2025.06.25.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:32:56 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:32:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v2 01/38] drm/msm/dp: split msm_dp_panel_read_sink_caps()
 into two parts and drop panel drm_edid
Message-ID: <buvgxzf5u5wkj2nxd6rquvcktjmxoclwrkkmxeih6pnikubqe3@yoytvnayvxtv>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-1-a54d8902a23d@quicinc.com>
 <g6wqvbszbrw6gnvxz7cjmhx4rc53kyulcr5wjekfjaisontikl@723odzngtlnd>
 <326bbd02-f414-48e3-a396-4b94f19054f7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326bbd02-f414-48e3-a396-4b94f19054f7@quicinc.com>
X-Proofpoint-GUID: yje2ReYKyW684UFEnRlkSyne1luLFkuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5OSBTYWx0ZWRfX47erSCpTi/CD
 8CGG2EZVyhklMkhOVIAavUAhAuYo+EcDeuTfJvCCUeT4ccN5dU0ImDVo74JGPoFpzehAxmoD/C+
 MWkcrL1F20JR0xdco7YPAUUOvUd/MMRuR4L0Om4EBtdGp31DfC6HSjU0cGKNaWXek/MX6KFo4lh
 mkwIbFeIAv7RulsYpgUjpd5WVcNY3+whHthFvIE4Q3mT3qZMBXmi0FsH/GnFBytZPWnhWlYJjf+
 DgWonq55waLuWqBZ7+LvxvZfi5dvcTCg/vB9kPj6V8p07dE8kC1z28biDqnopaz4horPB3lzt+E
 3YeEesW3WS+LI0w8NgcpjnY5nLj1Tygr2e0ofim0VkiXxVSh9/dBols7usU6d0bbVIAIwLJQx18
 J9v8mKDAkScMPuvdhEnmUArfg909zsSpsmAzs7WULzuzNgKsN6T0eooeHg4Tc4OTXDCNpzaV
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685bfa8c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=joTRkb4bluirJX-87acA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yje2ReYKyW684UFEnRlkSyne1luLFkuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250099

On Wed, Jun 25, 2025 at 04:43:55PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/6/9 20:41, Dmitry Baryshkov wrote:
> > On Mon, Jun 09, 2025 at 08:21:20PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > In preparation of DP MST where link caps are read for the
> > > immediate downstream device and the edid is read through
> > 
> > EDID, not edid. Please review all your patches for up/down case.
> > 
> Got it. Thanks~
> > > sideband messaging, split the msm_dp_panel_read_sink_caps() into
> > > two parts which read the link parameters and the edid parts
> > > respectively. Also drop the panel drm_edid cached as we actually
> > > don't need it.
> > 
> > Also => separate change.
> > 
> Got it.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 13 +++++----
> > >   drivers/gpu/drm/msm/dp/dp_panel.c   | 55 ++++++++++++++++++++-----------------
> > >   drivers/gpu/drm/msm/dp/dp_panel.h   |  6 ++--
> > >   3 files changed, 40 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 6f05a939ce9e648e9601597155999b6f85adfcff..4a9b65647cdef1ed6c3bb851f93df0db8be977af 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -389,7 +389,11 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> > >   	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
> > > -	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
> > > +	rc = msm_dp_panel_read_link_caps(dp->panel);
> > > +	if (rc)
> > > +		goto end;
> > > +
> > > +	rc = msm_dp_panel_read_edid(dp->panel, connector);
> > >   	if (rc)
> > >   		goto end;
> > > @@ -720,7 +724,6 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
> > >   static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
> > >   {
> > >   	msm_dp_audio_put(dp->audio);
> > > -	msm_dp_panel_put(dp->panel);
> > >   	msm_dp_aux_put(dp->aux);
> > >   }
> > > @@ -783,7 +786,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
> > >   		rc = PTR_ERR(dp->ctrl);
> > >   		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
> > >   		dp->ctrl = NULL;
> > > -		goto error_ctrl;
> > > +		goto error_link;
> > >   	}
> > >   	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->catalog);
> > > @@ -791,13 +794,11 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
> > >   		rc = PTR_ERR(dp->audio);
> > >   		pr_err("failed to initialize audio, rc = %d\n", rc);
> > >   		dp->audio = NULL;
> > > -		goto error_ctrl;
> > > +		goto error_link;
> > >   	}
> > >   	return rc;
> > > -error_ctrl:
> > > -	msm_dp_panel_put(dp->panel);
> > >   error_link:
> > >   	msm_dp_aux_put(dp->aux);
> > >   error:
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> > > index 4e8ab75c771b1e3a2d62f75e9993e1062118482b..d9041e235104a74b3cc50ff2e307eae0c4301ef3 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> > > @@ -118,14 +118,13 @@ static u32 msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
> > >   	return min_supported_bpp;
> > >   }
> > > -int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
> > > -	struct drm_connector *connector)
> > > +int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel)
> > >   {
> > >   	int rc, bw_code;
> > >   	int count;
> > >   	struct msm_dp_panel_private *panel;
> > > -	if (!msm_dp_panel || !connector) {
> > > +	if (!msm_dp_panel) {
> > >   		DRM_ERROR("invalid input\n");
> > >   		return -EINVAL;
> > >   	}
> > > @@ -160,26 +159,29 @@ int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
> > >   	rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel->dpcd,
> > >   					 msm_dp_panel->downstream_ports);
> > > -	if (rc)
> > > -		return rc;
> > > +	return rc;
> > > +}
> > > -	drm_edid_free(msm_dp_panel->drm_edid);
> > > +int msm_dp_panel_read_edid(struct msm_dp_panel *msm_dp_panel, struct drm_connector *connector)
> > > +{
> > > +	struct msm_dp_panel_private *panel;
> > > +	const struct drm_edid *drm_edid;
> > > +
> > > +	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
> > > -	msm_dp_panel->drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
> > > +	drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
> > > -	drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
> > > +	drm_edid_connector_update(connector, drm_edid);
> > > -	if (!msm_dp_panel->drm_edid) {
> > > +	if (!drm_edid) {
> > >   		DRM_ERROR("panel edid read failed\n");
> > >   		/* check edid read fail is due to unplug */
> > >   		if (!msm_dp_catalog_link_is_connected(panel->catalog)) {
> > > -			rc = -ETIMEDOUT;
> > > -			goto end;
> > > +			return -ETIMEDOUT;
> > >   		}
> > >   	}
> > > -end:
> > > -	return rc;
> > > +	return 0;
> > >   }
> > >   u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
> > > @@ -208,15 +210,20 @@ u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
> > >   int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
> > >   	struct drm_connector *connector)
> > >   {
> > > +	struct msm_dp_panel_private *panel;
> > > +	const struct drm_edid *drm_edid;
> > > +
> > >   	if (!msm_dp_panel) {
> > >   		DRM_ERROR("invalid input\n");
> > >   		return -EINVAL;
> > >   	}
> > > -	if (msm_dp_panel->drm_edid)
> > > -		return drm_edid_connector_add_modes(connector);
> > > +	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
> > > +
> > > +	drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
> > > +	drm_edid_connector_update(connector, drm_edid);
> > 
> > If EDID has been read and processed after HPD high event, why do we need
> > to re-read it again? Are we expecting that EDID will change?
> > 
> Here we indeed don't need to read the EDID again, so we can directly call
> drm_edid_connector_add_modes. Thanks.
> > > -	return 0;
> > > +	return drm_edid_connector_add_modes(connector);
> > >   }
> > >   static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
> > > @@ -229,6 +236,7 @@ static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
> > >   void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel)
> > >   {
> > >   	struct msm_dp_panel_private *panel;
> > > +	const struct drm_edid *drm_edid;
> > >   	if (!msm_dp_panel) {
> > >   		DRM_ERROR("invalid input\n");
> > > @@ -238,8 +246,13 @@ void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel)
> > >   	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
> > >   	if (panel->link->sink_request & DP_TEST_LINK_EDID_READ) {
> > > +		drm_edid = drm_edid_read_ddc(msm_dp_panel->connector, &panel->aux->ddc);
> > 
> > And again....
> > 
> Here we need the struct edid,since we drop the cached drm_edid, so we need
> to read it again. Or we can return the drm_edid from msm_dp_panel_read_edid
> and pass it to msm_dp_panel_handle_sink_request, then we don't need to read
> drm_edid here. Emm, I'm still a bit curious why we can't cache the drm_edid?
> It would help us to access it when needed. Emm, i see other drivers also
> cache it.

Yes, they can cache EDID. However, in this case we don't even need it at
all. This piece needs to be rewritten to use
drm_dp_send_real_edid_checksum(), connector->real_edid_checksum.

Corresponding changes can be submitted separately.


-- 
With best wishes
Dmitry

