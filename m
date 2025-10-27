Return-Path: <linux-kernel+bounces-871532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D5C0D93D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668BC421137
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9F303A14;
	Mon, 27 Oct 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvhJ+CqQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E203019D2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568150; cv=none; b=aDyixFyNHyfPUB2XHMGbNCqJtAsTuRFKKeHom6tgk4lhBQXX0fhn0HmF9Q0oAGJe14zWNDDHGGGUFnO9EMliy58oIC2MyMq9xD5vMzf+PfcxEIxPNNQmsTN9JmIB2lJDzyt3CwsuVIYsF6FKYCi7fLhpuVSZ5Jw03PaS67Gbujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568150; c=relaxed/simple;
	bh=lII6u1153jXK7yIvSiss2MRwBO0uCHE+B1I41RCrf44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5H98z6fF+oulyP3q1UuoijVfdJnQH7h+tzFM5NPiEbBncpxPr+8IDu6qvzWtOMTFvSN2Y5m2QFsSaRS+ele8FYw1MQIE1XNnjTjRTi7QG+DmT+szfHefT/gOwkr+tWxdG9gX7s5QgLr79JXu3S6FpMXuiV4cSNfGrXnhWfgG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvhJ+CqQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R95tDq1231230
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/rsr7uUBm8i8kH7yFAmBlcni
	G9FofbwGslfcQG/PTJ4=; b=kvhJ+CqQOQkjPo2cVAGfDsuL4HWLYOBffmy/ZTgH
	Popr2gHEwj4bIx+0dYTh3nhDAn17krh++oEtWs8VQsk9oYQ2HNgJtgRdwd5j1Sgx
	6qJmwJynIz4z4Xj9dkazjaJmK1pEwMKfD3d2KxAippn78mA18EW+ZNyB+koL0Tg6
	WwHLnn0zwUpBaltFe5uENtOWBoYPVsBZp/Laf/+v1N+DunkUPbsJpgY3YJWb3zlE
	TFL0d/zeKdgvuNcruDqa8BbVIQmVFx7NP/Orb9h51nfAf1jj3GUFuSSpLoxD9Jo9
	8SDcaCpND7fmYiOH4kaL01O2KLjz6qGqkJhvWXVkRWxf4g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1ud1sx9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:29:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eba247f3efso53740551cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568147; x=1762172947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rsr7uUBm8i8kH7yFAmBlcniG9FofbwGslfcQG/PTJ4=;
        b=ZHsr03cdomFchuge8N3VChBxZLHvg6DkMEIJFNigXohuG9dPYTZIuvZ4zfov146HF4
         b7esMwFOu/CEajORQtWBAJb08bXFNHW6paN/EQcByaRqh2TM3oy910ytponj/ulisVZa
         uKjRhydcfV0mbF00Gp6zx6BfK5ae2zUXIf/MkRGY0s0YeCXQ6A2pBz/USmG5bfpANa3o
         em3RUSepx0z16rzBNcKQvCIgIa2bRBhyrhrdyTY/beTrmWH5WJUz8q4yeTmOMOmRo9TC
         bV2mHgsuel6cmHvnQgIABO15eprSNITfkelv/QQACvy4ZhezSCTWqrTo2gg3dGNCTHU8
         7f2w==
X-Forwarded-Encrypted: i=1; AJvYcCXYh2zxDNXe2/HgOJF+K15sDAdhZxtIhhdNBQaokP/RGFUyZ4I4M5rCNkMENw3p8iBn3fLTKyAGDDQeW9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSZr3K0SWUZFTwSZ4aY64D1CrPiNx/47yuBghrYhFoyGd17Tw
	MF7N8/sl8gtPeqFug65uDikq9pPUn5eH6nKeywKPF0ZB+jO5zhV1YBKHqigCz0VTz4mO9ury+2h
	X5wRvIDPoCX8gLgiQFojqdQ8yv6fSH1DfbPhFwg8Vi/qVkBIY2T57pR3zyfnZOk1ORTM=
X-Gm-Gg: ASbGncuu4qQXK97T7qeMqb4Ok912qni01wGO9VqjG2ScAI1Np52FNnLWZv5//0CdYtD
	2xX71VuDC3e4DlLwUhJnXOVXUrnw+OCHevgbp4Yv89r1w6JDIC1ntgKkQtSkpHeJHKf+Tz0H/e0
	LJr/iXdkD8opbczRC8+Vz2+L5IZ3MFq5x02cGgTsDBGMThBkfYRq/dsQJWODlyKLITVuMN8ZStW
	19S6URhoQm2fcLxNmns/AOLpci27MvfRGLHC+CmDEXiXPCcxZQDnDAlNc5XnvBTFgxk4G0uQNtX
	wlK9tU0P1nbGnaYIzz5hEY+xeWyrULLtqN1fuusKFlCwCJUvH9qavwWqQf58V0GZeSPxLMz16oP
	q4u0ZuKCb+MAt4aVux7I5JITcontvKlXQoU4LBCUyxz5BC+abMWm6tn7oyhRN7FndTygXlY0eEA
	1VxNSvunhQfEaR
X-Received: by 2002:a05:622a:5a98:b0:4ec:f3ba:ceda with SMTP id d75a77b69052e-4ecf3bb1e3fmr44759851cf.65.1761568146687;
        Mon, 27 Oct 2025 05:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbAPmmSvzR7IiPpq3HlUcctfPxA/tqwPBS9g1DPUfBmIKxr6HJf+bYxHzHjkN1JS0U1LBubg==
X-Received: by 2002:a05:622a:5a98:b0:4ec:f3ba:ceda with SMTP id d75a77b69052e-4ecf3bb1e3fmr44758051cf.65.1761568144757;
        Mon, 27 Oct 2025 05:29:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0a56ccsm19486411fa.22.2025.10.27.05.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:29:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:29:01 +0200
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] soc: qcom: ubwc: Add configuration Glymur platform
Message-ID: <7dxq62ltoeerb4g2fgchb2hd7eomvlexfgyvamxsuuirblavtn@4bg3dy2bukdq>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNiBTYWx0ZWRfX1iM+Csk1Joc0
 eBVYiWbJkZKids3kbcUa+5N0nurHTedCcNJjSOP6Ll/BRI93N20xqbPyRFusz30sH9q59S2hq8C
 4wl9L/Ojdrj5t0it/U+C3ESC76Sm+ofKg29AA0EBS5syTWB9LuUbxZY+xNyAwXYi4BRQRlrskG6
 fzAfmroexizmQNuGpKIFzopBR7NFe/VoltQBz0KDdMLsoB6FQw7ujZ1UftlRW+xPqmp0ZkE83nS
 eO0eI8U6x4GICxQs8dIj+7YOwsduk54lX60Hj3TM0TZE4r9jwW207HTRPrKsb/zyHq97D5PJP7j
 tystCwolHUmBsiVDBCEcXSgQ2C91rDq9+iW8az2x8GOCFqAplp/sb/IOFsESjF6gWJnXQedkPuX
 700WR739fg2DuZCacMMA2qLAz+56hQ==
X-Proofpoint-GUID: PcPzuRXVKdF4AT7hj-dxqDV9DeLcVAnU
X-Proofpoint-ORIG-GUID: PcPzuRXVKdF4AT7hj-dxqDV9DeLcVAnU
X-Authority-Analysis: v=2.4 cv=UqNu9uwB c=1 sm=1 tr=0 ts=68ff6594 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=rYq5acLp8HI6pBODZ1gA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270116

On Tue, Oct 14, 2025 at 03:38:32PM +0300, Abel Vesa wrote:
> Describe the Universal Bandwidth Compression (UBWC) configuration
> for the new Glymur platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Bjorn, do you indent to pick up this patch on your own or would you ack
merging it through the drm/msm tree?

-- 
With best wishes
Dmitry

