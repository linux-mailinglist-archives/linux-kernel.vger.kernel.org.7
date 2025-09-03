Return-Path: <linux-kernel+bounces-798977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9AB42575
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6EE3A639F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A97257AC6;
	Wed,  3 Sep 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSH+Gm4Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AC24A06D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913124; cv=none; b=cX/C1by4qX0puhD2aDQ/muq4bPAk0YkfTXQQbtS223Qh/7jMyeh3XR59YAr/ewbqj8Rm3CM0m41RcVa0BQO7XZ38N8ERfJ6yEWoU1Y57Kv9K0FDUE9MX4EL9KvNSQGS8JuZXRnec/oiMakK2d4+YKbDW/53eLnm1f3bZCmM5fSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913124; c=relaxed/simple;
	bh=+YkVF9ra63z3wMgiI/TfUqIfihU7tBSzz2QwS/q8+PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay4L45/YN4afLQTctnPaZCYG4/A4AoZo8Un3PIrZDHxD2g7AEev9szebH2bexWiY8JorZ9QYpj3ObC2rAO3s5Bdyxg2l5CI/rJiZ5FkHID/UWE3/ixe7p17Lmo9M/WPT1389I8UaKB8J6OLiRk6TAFw0U4axOD8pedAX4ByS7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSH+Gm4Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxR1u029667
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IzstwaAk/9gASzk67aMPoDLF
	wx1pPBoDPB8FIPR+FXc=; b=dSH+Gm4Y8lZ+abblwn5oiEtwLhMymGrVbiwpJt4G
	v2B1G5YfHBhcHX+Y+p5PawEKefsDIBm3rM5jc3SXoc0dObfIMHOWLM7Wd5yISKwB
	44SdTKgzXbQCZuajuUYV+t7fDneQ8vn9Fu4TsjjZ/RCG0eScgwNVCDqElThXTNQz
	nu1HBhHjcbuNE74uFcCfXNNEcuXkNVHgVdyAqA3PnD4FGSOmHIUS/8WxcXVBaPs0
	b9G5kujl0uVlyKadFNt3E2XrIvT+Ur2w+buORX61Xzqkc67rpRdfwguB8IumTl4z
	hrQiLuBSVGWSCyElf0SmC/YuDIiQk8Hcqv9M+R2RSstR3Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0482r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:25:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b29cdc7417so692901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756913121; x=1757517921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzstwaAk/9gASzk67aMPoDLFwx1pPBoDPB8FIPR+FXc=;
        b=Oe/M7rD+G8nEqrCLol5arTFJ0mfWGtF8/6O34xGZ1CeJ6cZ143LIIlWQFtBNTq9uKu
         4gwovbmyg6k6ro8xX9vKYn7JwmqG3Z6ygSUFkDwS42x4KM3L+sXYA6VMM81rGORlrzSP
         fOrzlXN3AaoctJXPEBslweu2E0IWxCzW10jlGmGX/ANLd+Llt+lvIUcT330AmqkNGwO5
         IEbHqSj3qzSUcNgatgqVnLhGTmLK3vs6YoQNNb3q/zQh/thqXA4OHjg8SgWMAJy+d63O
         wO9R0JyVPWLcPyPB3FQNSnQJyZvfuDoqAhbdlSPcyZ+Vx5f6ROrrrAwzKgKRsg/+kmrf
         rxIA==
X-Forwarded-Encrypted: i=1; AJvYcCWthh70zQVd6NKNt0jmO/lSYJo0PaEX2oiEhUmWYtR5fYmmE7shERA1lKgq6w7sJFkisEMNt4RAO1jr3J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ow6Ceu+PBJ6jF9arZRZ4N+Y1erOIivpCiJgUh+uVVgi60fke
	aQSZa8mXgX6eEBKfpcjkGLAaBJFrS/DmA5PE2Lq+/tKBEbB0j18XVYiDxKiDCwMi5QQC44OGgo9
	iG2XpJlBpYMFg1qx3TnuZLcFtUk/mplLFAQBhUfeEC57+mu86E5/S50YrHUZQ2yeJcwo=
X-Gm-Gg: ASbGnct6PEzgcVy8oepsMNU5yXdFcO1nTprMD1jWU8u1s/RY0LN3yPV7TZg6LSdgqPr
	286UKBzh9h8c8RIGnUvk/Z3AzBMwK/NcTzuCG7ITEAi56d0VN9ck9eoj+b/zqAlniEA+tHqe1Ei
	Ddlqe5+xzVu9rcKq0RvmJvFCV03Ci2dd8KylWyPvlrfWCc9WCUn2SBOHml+X1dUpZFZee8RR2Pt
	6w18Sp8APpSeZGW8CqTpoqncfoD9JW6o3rJd8ZPcKIxRU8u97HNgo1UGDNtqJXp2MBmmWR7xTxA
	qLclWQB9SLp9Tpox9q9jAGC+c/VMMmQSfRyRv40zQ4okH7yqLzLQa3GhF6+9Ls2lAyOl5IskgHY
	FFb8ee/GjXUAU+4b3mViTBNlvbcimfKEplQ1ObeZOPE9rBCPJO6He
X-Received: by 2002:a05:622a:997:b0:4b3:735:c36a with SMTP id d75a77b69052e-4b31dcd00c5mr189313601cf.75.1756913120699;
        Wed, 03 Sep 2025 08:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsXzIAz12Lk6+O5Zx3h1C4NcdtKzpJmeWYRdgvuT0mpQkWtK7EWAI1sP87I4FOMC3nC+7qlA==
X-Received: by 2002:a05:622a:997:b0:4b3:735:c36a with SMTP id d75a77b69052e-4b31dcd00c5mr189310761cf.75.1756913119675;
        Wed, 03 Sep 2025 08:25:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e530sm589009e87.10.2025.09.03.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:25:18 -0700 (PDT)
Date: Wed, 3 Sep 2025 18:25:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <37czaypq2newm3hn6nfuy5ndkibvaqf53nx6zvv3mhddh4qku5@psqqxbu7bycf>
References: <20250901142958.843678-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.edc18686-244f-441e-a6ac-0b62492b96c8@emailsignatures365.codetwo.com>
 <20250901142958.843678-2-mike.looijmans@topic.nl>
 <pml7rfbkerzkx5df26x7kxn3tk2o7oqrkqnx26tzikeg53djn5@islb4hlm4ks7>
 <aa80b3c4-01b5-4d4c-9fe0-523cdb895eb3@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa80b3c4-01b5-4d4c-9fe0-523cdb895eb3@topic.nl>
X-Proofpoint-GUID: 2-o8sK63TCZ02zBu41sJGjKKVScoLdnk
X-Proofpoint-ORIG-GUID: 2-o8sK63TCZ02zBu41sJGjKKVScoLdnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXzZ45SfYnTrSr
 36ZlERDenUs6Be7OZLzoP3BTdUH6zeMU5aKVYiL0I4J0nDAFx/3vYhXIq5hBhUmeEsRSRTYGu2l
 ZeT3qBLyoQ8TG5BRWeuNysClWKvxVr9xWatDnXRlICkGZ6G+3kQIZncKXiiV3y7Qqy2zuuaaIiM
 9IjLc2D3TjIFNLIsf65h6AAfS8QmL9fmAZeOGeY7R59iaLGUKdFuhwfyiJvOBP6BJzozdwc19SW
 3E+nnZtO8/OMbNv/s3fqRlWk2Q90VaAn1rLKiF/T6L71mWwzt55a/15OO4EDXP6c0fwIQtiSawB
 52+5QMSWtZdhWgZJTDtHDbdwyFlxgUqY8emL/JEvJKX5cQftrWwYVkPaErrfW8MV70XGJPyNtl4
 YoaESH3m
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b85de1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=S_xtky-yvbmAgHGpMXIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 08:17:33AM +0200, Mike Looijmans wrote:
> On 02-09-2025 19:29, Maxime Ripard wrote:
> > On Mon, Sep 01, 2025 at 04:29:01PM +0200, Mike Looijmans wrote:
> > > +  ti,retimer-threshold-hz:
> > > +    minimum: 25000000
> > > +    maximum: 600000000
> > > +    default: 200000000
> > > +    description:
> > > +      Cross-over point. Up until this pixel clock frequency
> > > +      the chip remains in the low-power redriver mode. Above
> > > +      the threshold the chip should operate in retimer mode.
> > Why should anyone want to tune this at the firmware level?
> 
> It's a board property. You'd set this based on the hardware you've soldered
> on. If your clock and serdes are good quality, there's no need for the chip
> to be in retimer mode (it will consume more power and actually make the
> signal worse). At higher speeds, that situation may change, hence the need
> for a way to describe that. The chip has a similar function built in, but
> with only 2 choices of cross-over point.
> 
> To tune these parameters (retimer, equalizer), you'll probably have to take
> your equipment to a test facility (like we did). It's not something that
> end-users would want to tune themselves.
> 
> Most of these settings can also be done using pin strapping. I guess it'd be
> helpful if I added that to the description.
> 
> 
> > > +  ti,dvi-mode:
> > > +    type: boolean
> > > +    description: Makes the DP159 chip operate in DVI mode.
> > Ditto. Both describe policy, not hardware.
> 
> I would set this flag if I've soldered on a DVI connector instead of a HDMI
> one. I'd consider that hardware.

Do you need to set this if you have DVI monitor attached to the HDMI
connector via the passive cable?

As for the connector type, you can check it in the .atomic_enable by
checking drm_connector::connector_type.

-- 
With best wishes
Dmitry

