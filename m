Return-Path: <linux-kernel+bounces-795975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF25B3FA3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0733A7B1530
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F02E8E0A;
	Tue,  2 Sep 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iifSQy9p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747527466D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805016; cv=none; b=njT/Bp3eLRXlehscmXNZdG2TGJlAM0v5W5Z+1w7P02PdY/wWiUMf3EvZJa82xI/vD6dNspZKbiaI/JSreq/WKk7DvyQGGe1BY9X7q1Pwhbu3ps7cSBUqAlDgVrW+fe7Vn/2BLIkn3KT+HjXrgUD+BMUoaQCeFa98yF3phhQKj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805016; c=relaxed/simple;
	bh=tX3BCUzFmHYIg0myhvow09MB4ccfm98eYBIQHxNimfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hviapveNRhZIsP1ogkMGN765r3UZ3dccPRiXCdjxiAY37aUFCAN5t0AZiC+xbmafUpZObBp9hshJaem6qYWZ4JP//Lo4h7ua6xmYBJvh64fIyZCX3MunroL9GpElqSCFsAQeKqd/peIgFEZ5oPMucgOOaPMWkNUPEaMrVqLLPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iifSQy9p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rlvg021618
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 09:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ch/LhY4Ftoj00uev1yGdlcFF
	tJHZQ9xg8w0D9kgtUtE=; b=iifSQy9p3IEu5hNQ/ysGtvHwuEFAAtMxJbSFFxCS
	1HDtjhOMn4NA5Wwok95SBz9wNOiakQBHMMAtX9eObaDZT7dnRahZoOHXnTrMyVQD
	+zKZ7DKnPxghc4nF5imAfu1x+SY6qI6m3CBSh7V0QqIMgWeOJhFBFqUWUBmN/chX
	vRCgSRsi6u0n6lXU9UbuO+Iyz8cw/xKJg2lNUscGlabDJlZt9Va4jKcW3u/TO6ow
	d/MAq2L9C+wAXlY2vU5r3M+bj3qmjfb0oDEEDJdGRWvmbt8olJacHDFZCYwB6oLS
	Oh3G0mT8xmIm9jo3HG/t305jCNRGdvOVrvyBdH/7+KGb5A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp7e0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:23:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32a58c3f9so49296121cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805013; x=1757409813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch/LhY4Ftoj00uev1yGdlcFFtJHZQ9xg8w0D9kgtUtE=;
        b=UCxwAn/vtl3G9d2NFPTGLgjgH7AOcFrOpU79txYoWIg5XDJ8w7d86bsHqaU53hlDF4
         5XeD0cVk1KBtVeWvVlEUpoIo9bd9vdlzManyK9VvjDzVY/NcrAmnQDM9AKMOJBtm5cMx
         vb108/qfFLIfmyl3PPgCfRZ6z+wKQyVGf9ap2pmjeQBVG1MP5BZkUr0NkhgaZZnmlnL8
         QvKEbyle7S8BA8IAqV4KxIfbWai0DpchVHve+HqY6vFS+6M7HTI/YNaKNq6Tkt1bI6Kq
         /xKEPZ88xjoAegG/XKsDhimr7wiSmZMKAbeTIVeTLgIjARrqdycRSTCigsyeZoBXxK2k
         7Vog==
X-Forwarded-Encrypted: i=1; AJvYcCUjkfjjf0xeATbzLXb2kgFFsSHbP34SKgVhGDeMRJobf/zxcBgx558CNNoMkBnNQBERDJIlpN+OPJNQ5lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLro3pFHCshizhY4/tYEmdhqLry/kz3gE2M/LCFEFZM/u68HC2
	io38wwbcDjGNAnfQFkdf0Vv7RqFfj2EB0cUTsNiY+Rp7Co5GklaqbNL3/TfF3v707oTE0s7hdyX
	SLBEaKl7iBaZ6DRRDVcXWBA7KQqgf0YZhrid+sjany8niDJ0A550w758hXTR9GXAOOZU=
X-Gm-Gg: ASbGncuJsDmHKEauT3s5B/KyQPOPR/ESyfuXDmxahHXbKQGz6WTNPDVo1x4PIFWTRjD
	xEQFCcomQ6sOFPlsrwjcQyFxCXZlYO5YDW+9WdCsRuEpcicO2WBwYCkJhdrQZTRK4ZqG2nmTZOz
	Z13PhLdFTxGKW7mx4jdKOy8Li10H6/9GKdCBnsEgPkPt4KKjG7nLXAI0Ee3dFIwYCmOmLH2hLFT
	5vToSgLqlRHsWVaIEMGuv3l8fcoK7/SrrxTqf3VLzEyuYacaQKlTen8mB7G6goy5fQZWEOEB/7u
	FKEFqlBC+t5K0sQWyWF+H4Gr/NLLCQoHhAtR2Gi0QVhWh/hJWg1cfKUxMzF2UMyHBd+aikEk21F
	5g96nnJ6N943FU9c9495ozwpmWGlYQzbfc73HqLb6+5yL6//ZlVXL
X-Received: by 2002:a05:622a:104:b0:4b2:9bd2:8176 with SMTP id d75a77b69052e-4b31d84444emr121691081cf.27.1756805012781;
        Tue, 02 Sep 2025 02:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcy5unw6WFIHBHq5iOWTGUfamDps6b170cwBunY645CsFBbNJrcuVd5piaxYGqW0iNZ5IXg==
X-Received: by 2002:a05:622a:104:b0:4b2:9bd2:8176 with SMTP id d75a77b69052e-4b31d84444emr121690831cf.27.1756805012345;
        Tue, 02 Sep 2025 02:23:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608279ceb6sm546116e87.100.2025.09.02.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:23:31 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:23:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 2/5] drm/bridge: simple: add Realtek RTD2171
 DP-to-HDMI bridge
Message-ID: <w7lf26lyltduionxhckld76xhi4dsxzhmyfzz5notzt7cu3ixi@xns65dvdejb6>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
 <20250902-topic-x1e80100-hdmi-v2-2-f4ccf0ef79ab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-topic-x1e80100-hdmi-v2-2-f4ccf0ef79ab@linaro.org>
X-Proofpoint-GUID: r43HOOMQpCMHWGq03y2R0b7-1U5HPvEj
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b6b795 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=eHZZoxIKThfaNsFTWoEA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: r43HOOMQpCMHWGq03y2R0b7-1U5HPvEj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXxKGwmA7A4p7c
 UcfsEzADtxh5L7Cx0mPeI8ppjb5r/tYNJUKRgU1yZEWBXmpL43BK/gVH8irqt2fT9ZEUiJzYFqZ
 HYEqEAaWi6jmitJcfHCVwqKZLkDnriRvZ4FnnvXcCzqGOj0Pgyn7bpepSpluULrDlhQTTt5bPq6
 ZTgCG0G8BgWTSUprrUfhbFtH9RXqkq++AVNADUiz5ctDDryXHbCRTNHN44ocOzw7mDeLOvN/mcs
 I7JzV5rRZoN2/p2/myCeVOnIWLc/S0iL+vaetzcbya3kqH61ff5rKY6iBbRLkDviI/JmS9Qbz6Q
 tYbJAaySofS7bahWJBeQV+Phj6vUbIJ5ZlxbUtfHV1BmUbnaaeW30DqwJ6csgvWjv3v3AGna1nz
 j/MkSkNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Tue, Sep 02, 2025 at 11:00:29AM +0200, Neil Armstrong wrote:
> Add support for the transparent Realtek RTD2171 DP-to-HDMI bridge.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

