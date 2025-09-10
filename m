Return-Path: <linux-kernel+bounces-809277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EEB50B04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E773A9799
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3123D7C5;
	Wed, 10 Sep 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6H7TMJa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9823C505
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471327; cv=none; b=i7acGa02kzHrnRpMsd9ityXTEgWo6rKzmiUnRXCDmo8BEj7/qsu7IwP7Nx05oSxT5mCY/Y/T+8oq9+Ey8yS3hBnVP87Ww9IVLkLbJhFUjlaG38IDLa81tQlx74SbbD3icKIJ0SwuazRTL6XuH+l7+c5QWn4f+ZLci3eRVPitPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471327; c=relaxed/simple;
	bh=VqPLxi1aI8B806X6L3Sj2V7oKfkJsGMR8krjWrq4S0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSt3x0Xjaie73YD/ZJN/x7hSyitTIcY9CiGZnlO7mXDs7S7ZOfZ5xFo9laGy18I9nDUfUGlgGYOKjrwkVBn9GW0gh0ocEBTahzqr1ZV1gTrbtC5NyW2dIbyr7Hz3NgJW/fjsCOX6DMAVBILxwTPRqwnauKoP0krlktfFjrxmS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6H7TMJa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HXglF011045
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BEuNpwDX5WqbqkKQ+ekf9ZvF
	gIZyS75gI3370C7Q5VY=; b=g6H7TMJaF+7LM4zHorGA6+Wz4TLnwS/j5yEgUC2g
	aZY8LtMby3tPFOypF6xizHIEejXZo8bz1X5zjIGCN5G4tUN84BOEssWk8wsK41CJ
	pzi+Lu5Ddzs53PQ26mcGr7ssMp1DjTNWDYZSehKB4OP0kD+2210E0mwiAiYlc8t8
	JXn+OnaL9VlZD/2Ho6cbeXfIUrLPsJlwuwSjBcnLCOzOWIUkzBjdAeMutktzMumS
	yHm1ofORtvgq/AqF1fYdtKh6FRxgLgcs0Hf+cn261orfZ6UqpyG2+Szy0Q2H083Y
	4c9+44mVvtuV+pRoQPuQNrsJvC3pjeMxH4R98yVRpRFfZg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0t9h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:28:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b60d5eca3aso83013631cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 19:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757471323; x=1758076123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEuNpwDX5WqbqkKQ+ekf9ZvFgIZyS75gI3370C7Q5VY=;
        b=TySzabvp9FbAN6zesm0fm5yH/IRfojfhXJJR9Sos2c+ARV/6BJn3qxzkWnlzcVDUi2
         0fabTNYZ77K/cXgA8T5B44lmjQ6k1ihCbq9Buegmtid7VL6ONCL13DuHGOraTFKn5PhG
         jDD+jq0lQfDB+Al9ni7Bx4YHxwyBh17q2327Jq6qxtkZmf2LovHlcgvOuw2/mcUbs7rs
         MCrFfPIjp8a7Hl3wsQt65BCdi8nFNrKRHdCywjE2vKzB+hIvJ1oklHGVRMg0qap7pg4P
         ba4UF4fqhqj8UUtQfs4/FC8JwHALWXpMRjWiABuRdA8+LG/9/2A73eb79kLWn5D26rPI
         gjIg==
X-Forwarded-Encrypted: i=1; AJvYcCXtHt632VEAxcizIUprZ2LpH/P3XDfEdKEkWwHy2ViuU90Or8EBwNftjUpwiWRs49mjsz6W2UJtHw505sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRoiD6/QLywlc1vqmX2QXkmjcpmdGGyVaOLw8pi0+GB4W+BOr
	C34edsdYfH5UHmB5zkjRACSyfGJoiJoZOK2PS0teWBlHQgJfOogZEHE1ierxfRXnz81LfHNxqLL
	l9G2K3eYd2CMY9Itnq6TO69yzD7A4PL2A8AwZ4cKEad5iywZhIWIFWwMvbaYVb6OzlK4=
X-Gm-Gg: ASbGncsAprBH1qx1lKuaWy/ats3ND5rCopXvT4EnNl/P+l8mujknqz8tpgB/Z50BLiC
	G5m5H7KE7sX4Rn4sWD3c8B2pbDxtxSFZYcbTv8lvqUQkv8XtB/kArrbNamt6FLEoNdS2cMk0hxO
	ggXupliauNG6mNTu3kFTDPMg3RPSE/VUthTReRxgiPY6zYsMxE4bO/buDc168QdQsPZug+BSYkf
	gcMFZTlWX4iRzOO63N/lVYZALfqhwZt55cBxDKfEX3NNmbuUr34dPOuZkGSZFQTA+ww61TlkUUW
	+huROJmZilsHlfVpZMyglt8l+Uvm2M2ARDYFQWggBsacN8xh6Nv7n3GbxtxfGL49wef+/E6fMn/
	ZJoEtLOYIGY8BK+ZZID2uYFCULk/ThzgHO8RJ8X/AZLTHKMwet0rH
X-Received: by 2002:a05:622a:1993:b0:4b5:d72d:b7ae with SMTP id d75a77b69052e-4b5f838646fmr134497051cf.12.1757471323566;
        Tue, 09 Sep 2025 19:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9x4MbBvbOKD0aSbVoYVr74gE1dB3oNEVQmR/pRvVCyBH2QQ2/LD6VQ65xHAMLv2cOjrMnKw==
X-Received: by 2002:a05:622a:1993:b0:4b5:d72d:b7ae with SMTP id d75a77b69052e-4b5f838646fmr134496841cf.12.1757471323116;
        Tue, 09 Sep 2025 19:28:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56817959addsm909011e87.81.2025.09.09.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:28:42 -0700 (PDT)
Date: Wed, 10 Sep 2025 05:28:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Miguel Gazquez <miguel.gazquez@bootlin.com>
Cc: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        kory.maincent@bootlin.com, romain.gantois@bootlin.com, praneeth@ti.com,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
Message-ID: <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
References: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
X-Proofpoint-ORIG-GUID: ske7zchF1yzWtspUgp9GbQOy5A13opnh
X-Proofpoint-GUID: ske7zchF1yzWtspUgp9GbQOy5A13opnh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX34yUwStsZ4t7
 bZddBsl5USnQkscpTyP1cxuuV5GrQVhxAKlSwU0EcKuES8fWKYWA2hQX2Tfw3E0wa3s2ovtWlUc
 4sUiG5Wo2NzAoTYru+/aNOBPcbWvcQot+A5oce4tYHXrqDm6HQy5NncfiImEOKLROT8jie5kUsO
 Nlb4Gl5eO5u9COzC/Tz6dbspqdY5dxUBLOlBBnsEvIe2wNJ7VAGp+WqO0BJ7KATfBtR5HTd80BW
 5N+iTEUe5vJWWzG9fKNnPlvq7TXPNF4WSrMGg/fwouXxf2Ls+cLnqQFenOH7hFJ/BMEJy47B5Kp
 Scycr6LTY/uESYs3jtC1uiFmwwDxU8zN+QCvAJOIx13/eblz6fGCjkteLCZjcEM4FBKJR0evTiP
 l0ZJnfpq
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c0e25c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8 a=odyaA6YF8D71xn_2CwcA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Tue, Sep 09, 2025 at 06:16:43PM +0200, Miguel Gazquez wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Add support for DRM connector and make the driver support the older
> format of attaching connectors onto the encoder->bridge->connector
> chain.
> This makes the driver compatible with display controller that only
> supports the old format.
> 
> [Miguel Gazquez: Rebased + made driver work with or without
> DRM_BRIDGE_ATTACH_NO_CONNECTOR]

What is the use case for not using DRM_BRIDGE_ATTACH_NO_CONNECTOR?

> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Miguel Gazquez <miguel.gazquez@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 121 ++++++++++++++++++++++++++++++++---
>  1 file changed, 112 insertions(+), 9 deletions(-)

-- 
With best wishes
Dmitry

