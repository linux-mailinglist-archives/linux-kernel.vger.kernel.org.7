Return-Path: <linux-kernel+bounces-815973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F6B56DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1048E3A3B53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3F11E521E;
	Mon, 15 Sep 2025 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9vpjLUS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE81E51EF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899329; cv=none; b=UCPEcrXDhMKpA7bNKXJ4V3UuwUQOdqLWGr0h3day5Rk9RtD7jFpY9zYh8MuMvxfkPy2rWUg2l9Yp+cdRioDtNmet4FUIel3FCPcNM2bM85rRJaPxj6xBPqrCDXYriayTQfVMTFY08OjEYGvDOmKBMQTv9nvRoe3IUVGTPdH9mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899329; c=relaxed/simple;
	bh=/lbNWezT6xAjhR3Fi6g7CVjB3nh+YNu5yF3jsdtlE/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrlcT6DtP+1saPoJVhLSglerG2+BXsd5IClvZu9ig9ydBzGjrdSkVx9opTb+F+5iOhIh2CFmodzVyvwIoJyPbfWp4/bz5HVdoldhlWBTryFI3t0zZQY4McdMzAVym/UiNfG5R0YthfZuIKrOiWzLjhCvIRR874tSs0O/dTMNmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n9vpjLUS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMEq8Y010953
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eAPS3mv1/cupyBVCM8O2L+PZ
	b+74Gk1BkD4WB5VbJmQ=; b=n9vpjLUSeLW60sf6PRJPoFV/qcRDX6p3g5GPM/0u
	M9khqpntj3gFRsPmgHEm4eO3L+Hara2g0SEES74h6OOR2QeRu1JisNhUlvJaGJoa
	+DHI9zBFEKxdA+iwW7U8vPdwM/EIULhj6uNd8eSPuznwOQkwZ/SPojT3fLSmDBjN
	T3yDodYwEyx0dLhSKcsXGIgCZ9F9cK/IhkJr7Puo5mxh0dgUGy6fAPMAErkLLOAS
	K9TASU2Vk+lRI4HAtTScnrfLIi1FAxVfxgysEJAtsxb8ZJK0Gb5Ah3mTz3Pz7UTc
	PIFgHisePjeDsU9XP9iARxcwa/zNbHZTf32qLP0f72qPYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv3509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:22:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso88015321cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899326; x=1758504126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAPS3mv1/cupyBVCM8O2L+PZb+74Gk1BkD4WB5VbJmQ=;
        b=WpqEw/1VfbwH//FrbZ8bGBnBrXPONCtaVp0C1lLL4QbhYVxcTLCIDc0dr9WFTrN9ij
         4sDXmZQvXV5+steOLQtsWaxNuxbyp8sHgxLYP5AMzpZBXmEFOo/L9RfHhs+Xa9L0o5Rk
         AoVYoE6BmT2V2ttwYIgbuxPpgu2jOuBD+MKltJ+qROxKlkw0EUfX2eBHv0EvoyoZnJBM
         nExMKFVjy8205FY6ZzBG4tjvn6AfiwmS7GUKtULqufkASIYBWih6HbMRIKjM4fi/TNDc
         f4yZIlvofE5pXkEmjn2IIRnLlDpDnX6fWGzj/EdhA1ZVrqQkiZjRAdMlDSKcx37SEFFc
         diuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6+sFUZswh7K3kQrpYZ6LEMMHNN8WcMS6uJlJOgZHO1/qdiBVZWPggWMhApA7387OPfudq7lR75zdUj9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjoAEcs0AoGwnL5X8TgSIZRhPH9T237ubOR2jqKUdLF29Y4he
	lMj8fvK6Rx4hoIkuzlreBFDKnzngwAVB9eAeKMAFr28WX6R8fqTYHOc5nVY67eqxrQqs1s4sOMY
	J5h6ZpPu0USYNwwiGICt1UmWDAKlsIR8FNYAjOMd6SYk27ziUuX0NroJQZi9VLfvidyE=
X-Gm-Gg: ASbGnctOdIrTrC2za0XKD4pfeyxi/0rkLIcj/AHA7i2vpX4qmveLEXsOStJbacHf2xi
	3ZDbflaoBni9qcS7VEaqofciCsR2Bb3cBpoiY/PQJ7e0UaWLtwG8u7SUd92cMZV94EgPC+DXtLF
	/nMSHefd7NHs4RnhjDFwil/bsBaRmOy3K8ytVzRZBXmrBL0cPQVkPKzE8ukfmoDrW11440JF6CM
	vgxAS67xl7QMdEjTYd3dc/9DEs7R9hu4kpNLsM0zgGa5WlMeTNLYII5+S3WfTgQtAalmV3mxhxB
	JoxyL5+0S4K97TLWRjFMbkLJgZuiSZcERaK04/qERlgCVjSxN2z3eP78q++jZuEh9nYvW1OUStW
	A2zVb9gLYDCf55i5Z6dMYqPsZ5reDkmO68B8OXVtLkK8nJx8W0Jx0
X-Received: by 2002:a05:622a:286:b0:4b6:23d0:c89a with SMTP id d75a77b69052e-4b77d0db1b4mr132581841cf.37.1757899326146;
        Sun, 14 Sep 2025 18:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQSyYeAgSEmgcNJTTqp0vPaZyCuNNzRtT1WBhvlsaTwF6ipWsBzX++GOjSFqPhPAIn7RL3Eg==
X-Received: by 2002:a05:622a:286:b0:4b6:23d0:c89a with SMTP id d75a77b69052e-4b77d0db1b4mr132581581cf.37.1757899325711;
        Sun, 14 Sep 2025 18:22:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a820665sm23743431fa.33.2025.09.14.18.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:22:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:22:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v6 1/3] drm: panel: nt36672a: Make some command sequences
 optional
Message-ID: <v26z3jsjr3kijnfkbu3qdixzxckx6xshyxlx3ro52y4cfmbc4n@vmunmuquye5g>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
 <20250913-nt35596s-v6-1-b5deb05e04af@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-nt35596s-v6-1-b5deb05e04af@ixit.cz>
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c76a3f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=AaDDvXmx8HBLlr6wuooA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: a_3h5duKk4DZApnLdCOYNG3V6aqSySN3
X-Proofpoint-GUID: a_3h5duKk4DZApnLdCOYNG3V6aqSySN3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfXxpFxvbu89G1N
 QoHzdhmPi1CL4kBQMZl25EGpE+5YsAb2EbUUqYpKk+zzKETNesfjLFH4VqFl4TGI2PtxKc4mSQ0
 BqA6lnQc1Iw2OVbyeHI101ZlGiC18Ki6jNh0XAB/iZwTYeibGBhKE9oW8r/4vewtEm0a9uQgpep
 CNt1DPAh5FIx6YRW00VGrIuwFGlDw/PSt7TSs2OlTIE7DBN8429POQV4EAs26b27toadqAc6bI+
 CvDsF5dhDRYA7yeocgA1eZctbNIsWLQ6/3HoYRRtNmhHwLHoXnzRscVFlRUSh74rlWEqYrj6FbY
 JBynUU4/Fs6+y19bExM3uxGMVIBQVQoaycvcA4oSp37eKCxKqy7Fulj+YSfSzZIZwuWbBNvpcIw
 GzWxJ4Fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017

On Sat, Sep 13, 2025 at 09:19:47PM +0200, David Heidelberg via B4 Relay wrote:
> From: Molly Sophia <mollysophia379@gmail.com>
> 
> Preparation for the follow-up nt35596s support, where not all sequences
> are provided.
> 
> Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 27 ++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

