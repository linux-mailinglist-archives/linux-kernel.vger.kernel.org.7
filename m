Return-Path: <linux-kernel+bounces-813800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708CB54AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D518916C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015AE3009D9;
	Fri, 12 Sep 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="krWodGzo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AA2EB5BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676026; cv=none; b=Q7IkMcKJpvSBhBVlF4jj6c9ZvcfuULPtwnbqpHLNz5yDrqtIlkaUCPE9LTnTr8K+sixwm9vyaEgvZZlC3K09fdK63BwwLp3m90Q4glr1zTrA5CAYpk8XqYhYtsfOB5apUN+StngopI50hDN5d0H2CcG/5Rt77eF8OvShZQNm12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676026; c=relaxed/simple;
	bh=5vY7hYU90S2QunXquBPv+jAuZKEEQALSyQ8ghgCIgDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyJh7tvrAoHac0m1IiG813UbThlvyXRTPxvzN7RAR3lQDSl7creLzhqRbFj9yCwVDVeC22SddIUg0FbalHqwCnMGVmqd5oCqh/VNvA1SM2J2S6U8jnunO3Infu0jAo8Zfl/AyUHfxdKUb2wQUSaSQ4OLMPabNwX43VATlXnpLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=krWodGzo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fCQl017410
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fb8hL5HEjKr2NxpLUkVthwekRLKNSk3tdU6N+cDThPM=; b=krWodGzoYywUyoDy
	Fo79eZ0LadN7Y3+zuA/9nI0SINjbOmR7mfzp7w3LdcAtUyWNZRtsR4u2tpW2UK8y
	WYME5A7csYND0pne7RsVq6TAOfJOq7uDngZcBpe1u5mz+bgLMwXoenu89b2qg0Me
	YmIc/8X4WSmRJs8C4IRDTBm1Q7ZZSlhphBrnRzG785RrC+03pY9jyZvrF4PoGu0/
	BGICzPEmVN+eAB7C+XjHZkLqz+PqKTLf0NrDKxwYBYRm6PaafzfWw896De1SwuxF
	haIOPStqIbheFJjpAiu6Lhk/9SBFI7X6QZkniajiUaY8zFGZvIcLiScwfg7ktz6P
	TBll9Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8uhb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:20:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f112dafeso47988741cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676022; x=1758280822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb8hL5HEjKr2NxpLUkVthwekRLKNSk3tdU6N+cDThPM=;
        b=Znym5NDrYS/f6Fpp23I7BKsHI6ID+Su9Cc9ZRt3+d+sVz7vqL8oL+JfBKyfV5CLhGj
         8/6ilfdq2z51f1SwxGMXFAdGSj3KOggXr86m4dv3kR+8GgpOwrBrerNHU4lsrIcNy6+3
         J5/pToHWxOsMAw+z9wCBistpxVod1dYkJaAiNfuOdtQHOPR9cVp44OXadVLSu7KE5sxJ
         qhVfWsA93BrkVX+ssonXucFKR6a4Co0/PhINq82E8fZdoPc7wztjl2TTU8cMUg/0TEU5
         2zcm1R6ZmGMarh7PUsJmkFLhjY0/pGqIPQEEXKEjIyy/cy/oA4dpce5Z8ahvTdkL3jvV
         jC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7+bKuG6vV0vQ212pSYurCXIzSABOdGb/pipWm9FFH3ntSbX24YinE5ud0NQdd+WKgAeLT1J7UIu+nyGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyrxJNRWYQhIaXVcgIs7Zm/rL3kejZNQmZQDoeLZSzVwXw4k3
	k9sV6USoXbTB/bMlv3KRT6n3Kwwp8Vgxh394SSgwsh1I1MlY+3IDbqlLd5DO9m4Vp0i2hVt5wR7
	Ct0vCADDvAtD7HxrxafjvxAL7PGBoRvYdH8rHBvUBIJgQ7z8TlNOTuhVv8b+qbaw0nAA=
X-Gm-Gg: ASbGnctkMqCjQDuj5Mb+Lh0oR4SCfWhpRTR403syKU7EgKOZ/yMwO6/ZHmw+XMVvTuq
	ajtGeiLeTg9mC8+2cGjhVkPYlEXhH1st4HsubKiCudNC7JA8kU2/ldwtTcNCJZDr0AVSYrnFPqj
	tzsK7evYqDnvcTttzkq04bUahIP1VeXfdCqVkOgQy5U6OC2R/vID7IA+cyKclPKWLQP7bqUBswo
	xoc4ofpk1uUR15Qtm2br1QPhEvgXNUKz9GhdP4kN9zs8QuWbyReJmcQtCyyIK4DUeTzfkEeR0qB
	PxdVT9qOr+ScWGh8CAazGN1ppiS9KQeseaMxmlZ54kScl9Ur7zfl4Nw1+XUVRNrtNxzuByYC5T6
	1UEm3FJfJU2SWrqKADz49ivST+kZmFzOBiUDry8j+ZaTTrG1QNAN8
X-Received: by 2002:a05:622a:1a9d:b0:4b5:e8c2:78d2 with SMTP id d75a77b69052e-4b77d077b83mr38580421cf.62.1757676022185;
        Fri, 12 Sep 2025 04:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHg4eYraHClGAC3c6ShRy1LlgD+/KS3l7smN2ljKJZw7h2XFpAAaVAZ2QtQocEx1SbSNnxuA==
X-Received: by 2002:a05:622a:1a9d:b0:4b5:e8c2:78d2 with SMTP id d75a77b69052e-4b77d077b83mr38579831cf.62.1757676021505;
        Fri, 12 Sep 2025 04:20:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63f6csm1074336e87.86.2025.09.12.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:20:20 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:20:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Miguel Gazquez <miguel.gazquez@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>, Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        kory.maincent@bootlin.com, romain.gantois@bootlin.com, praneeth@ti.com,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
Message-ID: <cqtjavx2aljj34d6rdxysrl3fsmi6i45o6w7gmcul7v3xkws5v@d4sensdcyrfp>
References: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
 <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
 <6164422a-6265-4726-8da5-68bb8eafb9e6@bootlin.com>
 <20250911-innocent-daffodil-macaque-797f13@houat>
 <012046ab-d866-4b3a-8c8a-e130bc2b9628@bootlin.com>
 <2l5kp4ojrcsg2apcpv7mzeeypwynecyfesenks6zzvnst3qkbt@4yhbosy2zhah>
 <e6af5c37-d18a-423e-b822-367441a48f86@bootlin.com>
 <21f80397-be9c-49bd-b814-ea5f0eb5fdc8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21f80397-be9c-49bd-b814-ea5f0eb5fdc8@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX2kwJQ8OpGZm7
 1JsuLyjeqbRKq5RUb4oLJtqz1X2woVgsPSUqP4zXHntdrnHEAUvrC+R6cubr2aFtI60vIj1/gRg
 iFciM3ndkb0aJI3i2um2txULZwX+R6jBQxv+KGn5GOXAmVyiLWtfs5Z18/dgfHkrqgr3oFmCuGn
 kW74IzazaGj8Vz2zb2hV/iSMlc+eAcFrZFjpkO5MbZDklA+/mnZdaj7Hy3dJEs+hZG9OUQbpx8u
 cNzz3Nqjvap1vK7WsQsd7UCCW+rwLL6v8xTls8mcSPjPpDM2a4/I+Ev+rChgFVSnJv2njbhAz2p
 NfiPCOVHwct55nhg/Tryi0F6fgEjbYNWJFHMsaKPFTWh4ThTUWZPfvIdZlB/pPIo5iS1fYFj9fW
 0YMCBWad
X-Proofpoint-ORIG-GUID: pWSQBMSRN2_dNrSLoFsu6h_29aBKuyz5
X-Proofpoint-GUID: pWSQBMSRN2_dNrSLoFsu6h_29aBKuyz5
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c401f7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=sozttTNsAAAA:8 a=046QJsDkA4Zp6KAU2jsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Thu, Sep 11, 2025 at 05:47:57PM +0200, Miguel Gazquez wrote:
> 
> 
> Le 11/09/2025 à 17:40, Miguel Gazquez a écrit :
> > 
> > 
> > Le 11/09/2025 à 15:09, Dmitry Baryshkov a écrit :
> > > On Thu, Sep 11, 2025 at 02:49:59PM +0200, Miguel Gazquez wrote:
> > > > 
> > > > 
> > > > Le 11/09/2025 à 11:50, Maxime Ripard a écrit :
> > > > > On Thu, Sep 11, 2025 at 10:51:06AM +0200, Miguel Gazquez wrote:
> > > > > > 
> > > > > > 
> > > > > > Le 10/09/2025 à 04:28, Dmitry Baryshkov a écrit :
> > > > > > > On Tue, Sep 09, 2025 at 06:16:43PM +0200, Miguel Gazquez wrote:
> > > > > > > > From: Aradhya Bhatia <a-bhatia1@ti.com>
> > > > > > > > 
> > > > > > > > Add support for DRM connector and make the driver support the older
> > > > > > > > format of attaching connectors onto the encoder->bridge->connector
> > > > > > > > chain.
> > > > > > > > This makes the driver compatible with display controller that only
> > > > > > > > supports the old format.
> > > > > > > > 
> > > > > > > > [Miguel Gazquez: Rebased + made driver work with or without
> > > > > > > > DRM_BRIDGE_ATTACH_NO_CONNECTOR]
> > > > > > > 
> > > > > > > What is the use case for not using DRM_BRIDGE_ATTACH_NO_CONNECTOR?
> > > > > > 
> > > > > > Some display controller drivers (like the tilcdc) call
> > > > > > drm_bridge_attach
> > > > > > without DRM_BRIDGE_ATTACH_NO_CONNECTOR, so the bridge
> > > > > > must support both with
> > > > > > and without DRM_BRIDGE_ATTACH_NO_CONNECTOR to be
> > > > > > compatible with all display
> > > > > > controllers.
> > > > > 
> > > > > I'd rather convert tilcdc to use DRM_BRIDGE_ATTACH_NO_CONNECTOR then.
> > > > 
> > > > The problem is that doing that break devicetrees using the tilcdc and a
> > > > bridge who doesn't support DRM_BRIDGE_ATTACH_NO_CONNECTOR (there are
> > > > multiple bridges that don't support
> > > > DRM_BRIDGE_ATTACH_NO_CONNECTOR), and if
> > > > my understanding is correct breaking devicetrees is not allowed.
> > > 
> > > How does it break devicetree? The drm_bridge_connector isn't a part of
> > > DT.
> > 
> > 
> > In the current situation, a board could have the tilcdc linked with a
> > bridge that does not support DRM_BRIDGE_ATTACH_NO_CONNECTOR (for
> > example, the analogix-anx6345) , and everything will work fine.
> > If we convert the tilcdc to always use DRM_BRIDGE_ATTACH_NO_CONNECTOR,
> > that same configuration will stop working.
> > 
> > When I said "breaking devicetree" I meant that a devicetree describing
> > this setup would no longer produce a working system, not that the DT
> > files or bindings themselves are incorrect.
> > I didn't find any upstream dts with this configuration, but maybe there
> > is some out-of-tree dts which would be affected.
> > As far as I understand, we should avoid that.
> > 
> 
> If I can rephrase myself, is my understanding correct ? Do we care about
> breaking out-of-tree dts ?

From my practice: only in a very limited way, if there are well-known
out-of-tree DTS (e.g. we kept some bits and pieces of panel code because
of out-of-tree ChromeBook devices).

But you can easility keep compatibility: inside the ticldc driver first
try attaching the bridge with the flag set, then, if it fails, try
attaching without the flag. Add dev_warn() and some grace period.
his was the path that we used to migrate the drm/msm/dsi: enable
DRM_BRIDGE_ATTACH_NO_CONNECTOR by default, keeping legacy support in
place, then drop legacy after some time after converting all users.

-- 
With best wishes
Dmitry

