Return-Path: <linux-kernel+bounces-737179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C2B0A8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D714BA88300
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39EC2E718B;
	Fri, 18 Jul 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxgOpYEs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8282E6D2C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857003; cv=none; b=vBjvgDTvd7RWX2xQC0r3pyVhlOMV4CdL8J9q/KVZfntD+MBmpk9q3tPw2gPE1rRcQPwH9qZxAxfQDXggG/E+Q4CKajML8mJ86jvwct+9qub4/dCK2lyz11Zxio2LCMToYSSbE33vxyUEAo0mLZvV4nd3Rg6xY5bKa/ysXJiyFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857003; c=relaxed/simple;
	bh=Sb26gdFLXtWzDTynP60UgoekrjmlJEabtTBrQ67slRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8OYLSonTRkp6upPmfmCu1VnNEceyDuvYlTpixhWvZFIRWPeXzuwvipltFFe1Q04C/E28KqNNBz/bpuyOb0XwQ6Pq1bjrZut+SxTZrkT0AcKcw410bRZYgt7vAQACFrINfh256l+mxKei7FAijYIn8vJrZbtaZz4mktu8VyctLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gxgOpYEs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8TpXJ015642
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4iHjg0yMyuWIDVvOC/k5MiWC
	uaawwe3vjDf9NJDxgHQ=; b=gxgOpYEsJYpO9xyIh070IoNezkQWveY4BEIRAFJS
	SKY1qpz/GK9FIX0ij1xXOb5aHrk43dO3wE9cHErPkaKXomnXlXc/Sjom0U4ZV5iV
	BC03Bg5OPedKjVL0zRy+D9nVnIXJcC9IV3xoMvN1c0RowrJSbJ4mYr+ph+cyPJIM
	pZedL2iKWu+7idJBtbwDQ2uNwX3pcqU/+6UA9Mby3asjSSDVkucPxZqMjqqw9cBY
	duNJKHdAtmeeTdNRvz5SG7GT52t72Wehuv/S+hVLDRA8g6o6yVfYMVQKLbHSSdSl
	HixbEhScTMZuhcqdlI/afn7nxeG0ESf4yG9A6g6jKFoh5Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyy817-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:43:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab684d3b55so39673801cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856999; x=1753461799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iHjg0yMyuWIDVvOC/k5MiWCuaawwe3vjDf9NJDxgHQ=;
        b=AHIhg9qsPFoeXst5PURXCoW+R6Md9CiFUG0LFT42Tq8xyh3pskOwc6Q4PwQYKsvbfx
         3ecKgFTO8RJgca+EnJURebyRWbs6AD196/4V3KFqs4DtK6zeTlML5Y6i0X3qHdF3e5Yt
         p+1wlGQP1QW85eGuLgBpm0+JUAeiTGwJO8UrVFQ05Haut+hmD9Tf3RKqSI7jR3PPyIGU
         Uio3ZK2Uo67+LOwnIKKAL8sRyr0EL/8tTkikB2fp9A9J1hojclmIHBfJxQtUIVfH/oNe
         4DKtiYM1Jy4/ePjxENWPEsRFJfu/NMOzl+UlvYdd3SJEddVq0Y3Z3zsGv4+f8ygM4Uf6
         j+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyxVsWrP4lSrRH6aqrt2Qb38BOOq44WNeTfoJkw1VuHA/un5YM6x2u4Pb6CNhwwnb7J+RqCLo1xRnYYEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuBBl24hNez4aiXFVKW9R3w0kd/WIrijXEbt7mHv0GQ+D9j4o
	Hv11y+6q/IangBTU35HVXTEpfkZ0uIn/TL2qpVOo2PD43nu9xulUb8Ck4cliMeGlGD0LJS6aFyr
	pMWLOwq1ADtHy0PSBDqMu9FfzEUP5gGc+j+d/cpSLLQirH5bwBScDa6tEcadEMyHGCgo=
X-Gm-Gg: ASbGnctBzL4EltfwTOEl1Oy5L/XM8J8c+aCUUrNR8z/t4RD+8NvLN/ASk5YjkB2drx3
	qMJ6bImgPFLxdkMfdoJbrLl88Svcb7sWHMgU8RPWt87hKlkd3IEsN89ZNy6G7WiK9Uqqh2gTPGm
	bT8w9WQSD61w10FwVEGW4kSCXRip6cCKCvg/MohTsepD5ey8jlPMMBJwx8AL49MjU03kZ4uygfp
	M0PxFLyfnkfbMHtYFVHg6T7kqHIaGmGl3moGWgBUNOmBDdLPVCgJmb6B4I3zcnmgXinZYExfb74
	qod3XNC5WwKN2ueAJRIeaX9O1xTx6swsL8BhF06OjIO9b/vIm1ZuAvV1KcMZ8BIsT19XmKLwQVb
	AwKjdqzq7BxE8l7ghtHiG2/rriwK+cZdLKjE3sXsPK6XfixbhI6BE
X-Received: by 2002:a05:622a:993:b0:4ab:5c1b:4d29 with SMTP id d75a77b69052e-4abb08bcc18mr71426011cf.20.1752856999175;
        Fri, 18 Jul 2025 09:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbZvzJ33XKh1GRS/821AX0SMZRPFuMmQBKRQJilQygxHg6c2UTUUaFHGWmAdQFkyffdOw24Q==
X-Received: by 2002:a05:622a:993:b0:4ab:5c1b:4d29 with SMTP id d75a77b69052e-4abb08bcc18mr71424721cf.20.1752856997985;
        Fri, 18 Jul 2025 09:43:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac8besm319491e87.71.2025.07.18.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:43:16 -0700 (PDT)
Date: Fri, 18 Jul 2025 19:43:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v6 08/10] drm/display: bridge-connector: hook in CEC
 notifier support
Message-ID: <yybl66iajdrdkkfwerx4wmw5tvosp77l2ase2yaidam2h6n6er@nyhdlmak7xtt>
References: <20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com>
 <20250517-drm-hdmi-connector-cec-v6-8-35651db6f19b@oss.qualcomm.com>
 <20250718164156.194702d9@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718164156.194702d9@booty>
X-Proofpoint-ORIG-GUID: v3bxwBY6lFxk_N_qsIb7k5inOvI-lbO3
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=687a79a8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=eeht8Fw2wJzQMlc42zYA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMSBTYWx0ZWRfX2BeG9+s23p62
 T9Tp97XD3L/kQknVo86a7wNaJcGBpIwlVgR6cg94y1bdBcLAz8l0ucpmEKfrfqXD61PVYuOAE0/
 bH9Rue3EBMytM2Ek8OM3OWr638thCZrYFKghFa1IuFKDDCvpFBbhNp47npEy7OUCvaOOcp9YndJ
 GFadco10zXeG7x2Cv90vHdHYgPAk/viNsjORbBXtHQneTRRrY2HTP7wLQ/U8Fcnu8sTfpVgxPYd
 TgCSa7mWMCJAR2R1VcuUqC+lRPZuBjRLxRHAZs9fP+dCR9jf5WUsFIcFsknA/apg5lG9PEnitHl
 xZDseaGXVsEiNKbUdhGv4mC43RRGC8HbSkzpJV0xObk0XkiNaUBWk4m81ZJeGXgRBwTZ0o29j9f
 dT5tGUPesyt25YOZ6uFF2sEDqUVqpaiINRLEmD8Ms6MPL46hiUr/4G+WlCBkL78Q8l27ZMj0
X-Proofpoint-GUID: v3bxwBY6lFxk_N_qsIb7k5inOvI-lbO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180131

On Fri, Jul 18, 2025 at 04:41:56PM +0200, Luca Ceresoli wrote:
> Hi Dmitry,
> 
> On Sat, 17 May 2025 04:59:44 +0300
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > Allow HDMI DRM bridges to create CEC notifier. Physical address is
> > handled automatically by drm_atomic_helper_connector_hdmi_hotplug()
> > being called from .detect() path.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> While working on drm_bridge_connector_init() for unrelated changes I
> stumbled upon something in this patch (now committed) which at a
> cursory look appears wrong to me.  Even though I still haven't analyzed
> in depth I'm reporting it ASAP so you are aware and can either correct
> me or confirm there is a bug.
> 
> > @@ -662,6 +670,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >  			bridge_connector->bridge_dp_audio = bridge;
> >  		}
> >  
> > +		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
> > +			if (bridge_connector->bridge_hdmi_cec)
> > +				return ERR_PTR(-EBUSY);
> > +
> > +			bridge_connector->bridge_hdmi_cec = bridge;
> > +		}
> > +
> >  		if (!drm_bridge_get_next_bridge(bridge))
> >  			connector_type = bridge->type;
> >  
> > @@ -724,6 +739,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >  			return ERR_PTR(ret);
> >  	}
> >  
> > +	if (bridge_connector->bridge_hdmi_cec &&
> > +	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {

You are right, here it should be:

bridge = bridge_connector->bridge_hdmi_cec;

(and a similar change in the next if).

I'll send a patch.


> > +		ret = drmm_connector_hdmi_cec_notifier_register(connector,
> > +								NULL,
> > +								bridge->hdmi_cec_dev);
> 
> Here you are using the 'bridge' pointer, which is the variable used by
> the long drm_for_each_bridge_in_chain() loop at the function top. The
> same happens in the following patch. I am not sure this is what was
> intended, but I don't understand all the details of your series.
> 
> In an older patch [0] you had added a similar change, dereferencing the
> same 'bridge' variable after the drm_for_each_bridge_in_chain() loop.
> That was a bug fixed by a later patch [1].
> 
> Superficially this change (as well as patch 9) appears equally wrong.
> 
> Basically the value of 'bridge' here could be NULL or
> bridge_connector->bridge_hdmi, depending on the
> bridge_connector->bridge_hdmi value.
> 
> Is this the what you'd expect?
> 
> And if it is, what is the correct fix? Maybe:
> 
> 	ret = drmm_connector_hdmi_cec_notifier_register(connector,
> 						NULL,
> -						bridge->hdmi_cec_dev);
> +						bridge_connector->bridge_hdmi_cec->hdmi_cec_dev);
> 
> ?
> 

[skipped]

> 
> [0] https://cgit.freedesktop.org/drm-misc/commit/?id=231adeda9f67
>     -> hunk @@ -641,11 +705,16 @@
> [1] https://cgit.freedesktop.org/drm-misc/commit/?id=10357824151262636fda879845f8b64553541106
> 
> Best regards,
> Luca
> 
> -- 
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
With best wishes
Dmitry

