Return-Path: <linux-kernel+bounces-812103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD7B532F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EE25A4C76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB5322DB2;
	Thu, 11 Sep 2025 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NF+KtG0d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB7322C74
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595554; cv=none; b=YVEl5Wvy4PfX5ykepQKYaGT8YiKupdz6DQzELIK2adChYpK9BxVJWHuFOAmRvMm7vb6l+KCwgIotlpTRSkccyr7aS8ACx8jY+G87T1OyJaAIxi29tLsVRB5KGLkKTuaQqSTyqLnmtZp1f6NyfCRDC/I1YDk3oJ4MPSU5fGgF5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595554; c=relaxed/simple;
	bh=eJ/guibiApuxYOyuexqb55s4sia4Xi3oTrbQVvt2Xvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrFm1X3xb83twHm39zwYh3qCBAE2p9WII7J1DaUsybstJTwWAB6C4NpcQaGBGj8cZ+laDKGtzL2+9lPDP/queXeQYuurKSx0kkp9egCBHc2soT15jf4OxSDDABT8N9j0l1MSzr5wx34OQDXndHuwLwBv4sWPNT21CTKmAD8u+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NF+KtG0d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BB4m5f006784
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=erQHYt3izy31hhOi7nQaR12L
	KzLFsLkvUdjCmOIgf4U=; b=NF+KtG0dJrO+Jah9l4R1SQCTtI8Ig4bugDgBUDB3
	Q+tnn9DOXj9Cdz9U2r89R18AiyibwLhEt8DN11Pj8TQP8JWJhLN1zLjqrBwte5mI
	rCNPLEzQ10b8nRvzPYoumLmEz8KrYr08erJ62L6GSFvqhcD+FGAVmVrWR3O8zpm2
	k9G6G2ZqzfkYjaYQoIahqe4wAkekDbv19idhB7aJOoFpz/iURoLabuEBuL560VLx
	LvkUoruTmoYuB3hx5Nc1SkakwiaIm981eiz6gPJxXB/IUow0/9/i2qHFV1bS3qQs
	0cEa4M/bjyT57glR9zrEgMfQF3yOzzMmEnHmvMJYCwdaIA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8afpfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:59:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-765b3dc25b8so4881106d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595551; x=1758200351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erQHYt3izy31hhOi7nQaR12LKzLFsLkvUdjCmOIgf4U=;
        b=eFt6HhSJ+aliJdH0CiJ4Ib65Gqi7SQtdmfiQfuxdYBE5scEkMs89KMcFWOvuHN6qht
         gRfnzPRhTgBPxyLvFuHLeXRdRPEldAgFMOyPRcb1o26WCg/7C6V6xUDmAM/Kl0klPOY+
         g5xbQaBpuM/IlDRHwCzFmEBedqifYg2gevoiYeBq3/q7v2uWljkW7NsNdTEa7Dp/UGsQ
         swTf8yVvjK5kEgFiugIAfQjJNfj67rm+QUX54y+h28Taoyx5qKhCpiI2u18RdlJ9gD6U
         Ej5WkR9NsOF0shEvHzyRkh5JovtwcHEbtkF7wmzf7W5njJN/U3W3S8iA0Qx9ig8FH/AL
         ryUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVMYeEQSnj4IvuSbOJ0iyNIlQUHcxZHzBA2GXgMZZUDbWPkI3YTXl+oBD7SXj9ppirjOC+gMILQNP6OvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fC0XSCFms5IGj5d9eVwnZsneYeLgMUdAeuoFIEPWpdnMAuLp
	NtklgNvJsKMrFQw/BmfBqAnbyqK8R9pIRirshgX4RWYhPip6fgLpKmt/1pPSAJe3E6+HQ/wc4kl
	GngRF/SMUu4aPdFMQ0z4a2LCN+gNRvizvj98yNskAF4ZpHwezpKFzL166bui9FNTD0HQ=
X-Gm-Gg: ASbGncvWVyZ3Q8Z9L9lZmqRz3QNcMqmEze5ggNuAXV+GGfF5GWjz83v3JxCXQOHT1uu
	zzoKmoWKkkn5aC+j5Hb5aEjcabY7MabnPz2u/GYv5JCz9zPSagjJsbEZfvCdCn/F46BNTz+fxK/
	3vUpCQAqjPtGKPQ/PyNh2SyRiCelAueBXCELh4A0rNeecqDKtKkesh9GpFlV+tEjn9/BEOh3wT2
	9rfRb6uRHbdvrddYZKYonfqIbas74BqIJ9oGp9PIZDXD3/ca5+6WX3vVf1Bcaeo55epqFuEEEcy
	i+e6SsqTyzyMOKWTyfVyxWwzgdfhVt0ZyCSXX/R7aNbCR3bhaEOYvrsKl3/EgDWR4d3m1KOwMTq
	VQKyIf91ME2qIN9YjZPrbSuCpEDRghA0HYBvXqqe1NjTXPKwFjvhQ
X-Received: by 2002:a05:6214:2a4a:b0:729:9ec8:a1a6 with SMTP id 6a1803df08f44-7393ec167f7mr231642666d6.53.1757595549397;
        Thu, 11 Sep 2025 05:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELAL9kOk9qQGqQpSk7nyLvkiKnEOMoOscLtU6SuZkaDa8BaY8uCBWjurK/6Kut9nEHxlP7Tg==
X-Received: by 2002:a05:6214:2a4a:b0:729:9ec8:a1a6 with SMTP id 6a1803df08f44-7393ec167f7mr231642076d6.53.1757595548865;
        Thu, 11 Sep 2025 05:59:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a31a1asm400573e87.134.2025.09.11.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:59:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:59:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] drm/msm/dp: Add support for Glymur
Message-ID: <gteqgamsehrmaf2hro4uhqydckexjlvkzlpkj3xyt2w2derf6t@evk22k5y4bpb>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
 <20250911-glymur-display-v1-6-d391a343292e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-glymur-display-v1-6-d391a343292e@linaro.org>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c2c7a0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=r4hCbaOVonaLTjXU3fkA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bEu62Y4ftNPl5BMUkn8dsWtxUiyjn99U
X-Proofpoint-ORIG-GUID: bEu62Y4ftNPl5BMUkn8dsWtxUiyjn99U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX7s7LTg6XxEwU
 mQIYQMfEDArhqQ4bh8Z1zbB0YNeh2upy3EBVYdMxEg6HQJ53YAGUPcq/xJESWytSHOWRtMR0sZW
 arawx0FljPmDDmQv7oXzym5f3mOly9LG8AYljI+ZFyys+0yiaEqOCflStlBXhXCT7O2kInOlSWe
 fN6cBJtMAa4rJFH3e63XkbKqCKGExKxm7WWxDkqCRV4WDWdyhKB1NqI0ajH/YH26J6lzh2Npfbm
 CHXfD77G537CPA173R2v+VSxym0a++r9GnEYhOWuiX2TqQ/ZvOmk2iVQ7ZnFJLiuvsktMtNCI6P
 0ig8qEPdnziNXu7PHa0NVNtYQzyQGh5p+NYJck49ZLWJDwn1V7mxs57aqC7VdAb0Pn4dg2QPQ2j
 awMk3B5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Thu, Sep 11, 2025 at 03:28:53PM +0300, Abel Vesa wrote:
> The Qualcomm Glymur platform comes with 4 DisplayPort controllers, which
> have different offsets than all previous platforms. Describe them and add
> the compatible.

It's not only about offsets. It has different core revision, so it
varrants a new compat string.

With the commit message updated:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

-- 
With best wishes
Dmitry

