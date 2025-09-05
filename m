Return-Path: <linux-kernel+bounces-803091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D8B45A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5831CC5216
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2E136CE16;
	Fri,  5 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5vPBUQT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F236CDF6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082429; cv=none; b=SRrGhcrtZZ9EJOFV22EXgvs6HSQv7LoS2DTzSQNd1UIyOz++Pj60gCf1rgT3384YVlQK7EphAemN1YMs9Ywynpcs0Uaupq7Ykm2cBoYP25DYhBc3VJNs1dgiadQnGBHsZTHs18dz6QCembD3ttv86KnzoYoXsJNEmQs+LwUWa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082429; c=relaxed/simple;
	bh=Sbl6HkXn9HbFaiqu2h3yBfINxyPTTdsLyK/JjQYYPDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRC6heyUoaPno1JhTiiNIvO7XSBWGR/SvTVfS89icPBQlvVAYSLAOyc7acZwx8UEmXDJjidyslIvM+WtIUaMpp58iN3zv+3BoI183pvVrQmFiWt8lWdySqWgp3aDlxJfoITPffEFolDngUAsEgFsgX93hCk59BRYMubqWKB6AG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5vPBUQT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585D18R4018575
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eF61zkZp9mMYxVggMMzwArKN
	A1z21l0hZQVBszHsT2g=; b=F5vPBUQTBlKC7wn+jmgeXSyLos6dsnyMQncm+JVu
	4r31K2SfNeSKL8AE4GDWK6KuuJQ3CohKTgWA08ieqRKK/KfeX6oXYPsz6GKr1PS8
	xsylaqqlAAJ4PSyCGaPiJfVTAuz8DbfHuarGUxwMB67AfFDLKB7JUyQy9ZrG8CvO
	h2DoL4KmgSPDdrW2XnGUv1iDhE/wpi9B5aW8UdSEs2tvgr8wW6FjZI8C4Ak0SlYz
	H/iPBgeUqLrZJSUgvEimmNiN5sRt3FnCO0/40J6GlibJLiVRSt+uycsoGKwE1Ggc
	Xgvb8mLoVntLOI1qGVkZ/rg7Gxr29RFk/WPNQlITj9eq8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebuu97x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:27:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso17124891cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082426; x=1757687226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF61zkZp9mMYxVggMMzwArKNA1z21l0hZQVBszHsT2g=;
        b=oRVjVD5uIYeq/X3mSkgsdtedtRJk6eqpbcsqqzjKvcl/EkSf6yfuEByBcV3DrcQ4ZV
         qfFYTd19JBgbEYPNwjzEFMrkw/gVS4rzgQo3QIsKB2QElFQoysu2E3QqwdhZFNecuopS
         ylaAKu+soolzO6FqCUxR1OAhmRMyrDCFf4tpoTP4RR/MM2CYuxQLxvvQuOq2u6kePnc4
         JTueGdr6EyHVczkPokd47xyyS03R7+3jgZ0jpnUgc6TrL0effc/XXTJ01EItOyYOz6V2
         w7G8M6Zd9J4X2FacMi6f94mHSve0BPRggjS7bqcW6GeCNxJxaECvvLi2HEDmh4dKx3/C
         CvYw==
X-Forwarded-Encrypted: i=1; AJvYcCWIo676Xn4BveJQE4AerSf6ws6V8I0Sx14sr+hbfmtmJFmpnEokXO/WZ1g/y5cXYWHtEYYTGYuXyTDNFVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIL13etyuEZluEW72+0UDcXpO4//erymTbUnwbBtWysY6NDOss
	FVG75eVfdjExTiUuRjr+VWUQFl1QUopt5jWnMNKOzR7dkLwLCPAOEZy3shH6Pb5dw8XfYCbZtTy
	xREE9O8I8E3f2QiRK3bn7Q0VPlPxnIHYH9IcXVsy8VXg0+St562O7IqLUNIqBmu7qklQ=
X-Gm-Gg: ASbGncu5XNTga/XJZoKfZEUNpgoQ9q7dTKdKGGA9vlcvTO9of3FADphfkzxtKLjSjvw
	QW9wNOHSdibyu0fNSvG4iKDmw7bbdaRXBOuVHtWY6vJIPwdaGPAlGrDnF320eliqPjwaFNpiZKi
	+mdXZCiZYRSkMF5GB11Vk3I6t+ZS5tWrc2GnTmjFS4jAbgLA1Quh+3dbhtTYSBYUE0wiQtMMQPs
	vtW7AhH9jfD0SrRugaXZEtxuucq7NLyyCC8WFJOjSe/ndrFjAR08ykIVSCE8Jt3NMdjC5EXkdAB
	zyEoLG9K78Fh3WKYxgrw3CUdfSD8kYlQo1beWlEFgCV4mEPXLkQVg5i+3goKozh/TqB8Sp1HX+2
	9P1lEkCH5mPn50Rx+4UN6opg7LUBwmjGQpFmknu9wjD3c5vNQyfe6
X-Received: by 2002:a05:622a:1a89:b0:4b5:d739:627b with SMTP id d75a77b69052e-4b5d7396898mr89983041cf.76.1757082425979;
        Fri, 05 Sep 2025 07:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECmkBwlmY6UiEs6hcJX3488laXoD4oV0+tFPvFeEwoB/BLO8UPs9WqixuE8OIxKWAk1kYaYA==
X-Received: by 2002:a05:622a:1a89:b0:4b5:d739:627b with SMTP id d75a77b69052e-4b5d7396898mr89982311cf.76.1757082425175;
        Fri, 05 Sep 2025 07:27:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc24fsm1802596e87.104.2025.09.05.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:27:04 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:27:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kernel@collabora.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Algea Cao <algea.cao@rock-chips.com>,
        Derek Foreman <derek.foreman@collabora.com>,
        Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v4 0/6] Add HDMI CEC support to Rockchip RK3588/RK3576
 SoCs
Message-ID: <zni6d5udvawma6kcjp54d24kihlue543dfqc2ti3k43jntaphj@xtuusmebp6qj>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
 <ncmsmxdcvhj4jec6wmqf5abrb7nijx7ac2i33tvvcc2prljez3@uks2cb6aunnx>
 <b8d068ef-d083-4bb1-b34e-b8ddaa62b436@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d068ef-d083-4bb1-b34e-b8ddaa62b436@collabora.com>
X-Proofpoint-GUID: vUsd_TAVCGNljNcVcYiCnNw_gk4oEyGf
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68baf33b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=QX4gbG5DAAAA:8 a=gdAa2DyRb25O423_gIoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX7bwfN8iLVOy5
 ySuATPvqUyGdLnvFmnAIccTUm6jhBKk8G++i6VRk6UKKQ2rIlCoZ1t0R2ISJUFuTp+atvCMpa1C
 fy2k0jrHpc/In/XcU3MEgYiy6R6KInS5Y10gx7TqfxHT/3ZH7Ig2bDYixnHs9ixE2PNyXDmK1CZ
 P37JaDQnlpT20IN+QDRwcRGfEe0IRmCTdNHU7Rl+0OJjkDTAMFad0BVQNIfd+oPb6mHEc6JeApG
 Z+w0iESIg92dGgQyqn658hLCEc9tGHGBuMV1/Xu/ZHq+XSgRc/E1PcqbV9QGtfPWcjfjQvV101T
 70vUdWMeZ+fZNWutJB65ziTJg+Z7e7mg7RAmM3zyB5vdEtL+RCbbuBMRa4FxHMdOJjQfRlLQtDm
 aBY2ReGt
X-Proofpoint-ORIG-GUID: vUsd_TAVCGNljNcVcYiCnNw_gk4oEyGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On Fri, Sep 05, 2025 at 09:32:36AM +0300, Cristian Ciocaltea wrote:
> Hi Dmitry,
> 
> On 9/5/25 2:48 AM, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 09:50:58PM +0300, Cristian Ciocaltea wrote:
> >> The first patch in the series implements the CEC capability of the
> >> Synopsys DesignWare HDMI QP TX controller found in RK3588 & RK3576 Socs.
> >> This is based on the downstream code, but rewritten on top of the CEC
> >> helpers added recently to the DRM HDMI connector framework.
> >>
> >> The second patch is needed for RK3576 in order to fixup the timer base
> >> setup according to the actual reference clock rate, which differs
> >> slightly from RK3588.
> >>
> >> The following three patches setup platform data with the new information
> >> expected by the HDMI QP transmitter library, while improving the error
> >> handling in the probe path.
> >>
> >> Please note the CEC helpers were affected by a resource deallocation
> >> issue which could crash the kernel and freeze the system under certain
> >> test conditions.  This has been already fixed in v6.17-rc1 via commit
> >> 19920ab98e17 ("drm/display: hdmi-cec-helper: Fix adapter
> >> unregistration").
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > 
> > Cristian, I'm sorry for almost off-topic, but as you are working on this
> > driver: would it be possible to support HDMI (vendor-specific) and SPD
> > InfoFrames in the dw-hdmi-qp driver?
> 
> Sure, no worries.  I'll be on leave for the next two weeks, but I can handle
> it on my return.

Nice, thanks!

-- 
With best wishes
Dmitry

