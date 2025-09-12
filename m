Return-Path: <linux-kernel+bounces-813028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66FB53FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8435A5177
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0160146D45;
	Fri, 12 Sep 2025 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kIcq5BvA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A38131E49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640317; cv=none; b=BDX1ojzqqarax7LCAIxZAs3BluoV/s+bz8jMtOlsOK8m3/75cBME4yj9mul0ff1ujrRJjUhslL/ckR69ptz2V16F/B+6tiIUtl4scZAXvUdCq0ptpcuca42CoIwRdU/CbQeu4vOPv+SiE+Pdvwk3F8y7iO8H3GshS1EXiA9cBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640317; c=relaxed/simple;
	bh=5GCvWmNKo4cUBA+FwiYng+NcOcB+AmFuejPHwIelBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1WdRRvIGcAU0jX6OfrTnI/V7t+sh/rd0EHJWIHfn9Uiaevxjfu5btsSglm8MSHgijGMKPIbSGtnwbxgE8ajcZqMbgfTdVmH5StUB1qxeEJs4YwpzR9QJSpa4v12/eznSzrWM2x4mCf9mWiqs9T9/4C4SUyxFBRONJwcpSx3FwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kIcq5BvA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BI7mxB006011
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YsVWw194ZI1CWoyM8/QckT8m
	npp2FjAIPhrizuJH+a4=; b=kIcq5BvASDc27V0NaYPfTm2i8yEDFW+b0Y6Z2LX0
	gr9e+Mqnd/HS5R3jxQD/Ls7HOhSCQkUJ4tru+b8ktksPedSj3GLp2RQFi8fNKmcQ
	d7ilTtTwLSOUpW/ajBHQ/USOOdTXARBj+BxFUdp09XFgV4u5QAjGeqb4D9cVV05Q
	CHqSX1pZUDE3wn6OZpwAdjy90Lw7zAQLAiCdlDqTP3NCUYajvzKU0Um7aGqEifyh
	DMYPMHKSVRp1MinW8wT5YfdMa4BtgTsA7lMmyZMvXprg7JoBJ8l5o0bzTJ2nNVPL
	7DHJokCJ/LR+sTPTsovbuXEdE5MXjqFmR5ZrH1646bW+dQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ahrhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:25:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b60d5eca3aso37498961cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757640314; x=1758245114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsVWw194ZI1CWoyM8/QckT8mnpp2FjAIPhrizuJH+a4=;
        b=YYsj3r1/qwTnMLj2UANiwJW0u54x9ozRz9cjHunDXWLJd+sJdfhk+ETQjbumsU3bCC
         Phk0KzFXWBjnYS58MRK2D30GXEiShoKdYH7O2eRlrXNObNuyPdxgnA/7e27V/mdEe3u3
         oRSTgtjHGmHj5Ujuw4xT6b0ezSJ5lXAZDO3PbYfzU2Tn1LAfr+Gthg2wvCpPlqIUpZwM
         0L9Zyk27NV+A02jO1wtZCn0LUc4NHyZPeYTbovD7AcCE5r29wnxpPIrzIvcb71sXXTo9
         nbFWBNdCdM+wpLrapcf7uHyvU5fuQ5D1F8PkFMzxvFDUP/mq/URsbWPGm8K1omnLtch9
         WH7w==
X-Forwarded-Encrypted: i=1; AJvYcCVLa+/+WLpg7C+qWviwxHyJVT7JgeNYwgUUw8Gl1N+DhQhervKAqMt67/PjpmNOcEB77EmeXJI1IsS38ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxco351RTulJ2uNonOSIIJHaSEnJpwyXXLf9v5TMnFzAXyL95h
	RgKKLs8Lt+OHJIUF9ipYWpJ9xuVuWo+Dt476vuEM38hm879FecvZjIVYQjx2qj+SLjCWrK6Zmb1
	3QVHmCNXsXPx3CrtSYntYn9gHAPK9QYHnRBlGZinMjtDrVya0dHI+UDUnQMVcATKVRec=
X-Gm-Gg: ASbGncvjRUuiQyOW3Qp1Kg+ZjMndTQllC2g1wf4oLq7YXs/d92KWavTE7/55cJnfwmb
	qANvfctoqxs7sOG2yTfJ8dXvAnLlRoVgknZviYFXtv5BG2fXqdp1SIPvOf5RScjHqepS0Ys4nxs
	bXk0e36IqseP65X11u68iLxVkjymFsADe/ROIGlj82lHTaQKLysDDQOW0Ni94vX0UfFoR30ElWF
	5wKlnQw9tQPXOqJ6miagSys6nCh43Qk22bsWIZ1iH0cyvD7MiMgHA+BeT0d316JS0FcILz2cgeo
	tn8crLAfsbB35o3DdF8KS0/2sj4urbGC+ApNWeltTfvex3E1OCRowtB287fip83Asnn5k6vchEk
	4MahYaOQDKmzIjxPRmuyW+BV9LRo2lGkkR5U5kwqBGtKyN6TMT3Pv
X-Received: by 2002:ac8:5a0d:0:b0:4b5:e7e4:ba6c with SMTP id d75a77b69052e-4b77d16e805mr17533651cf.67.1757640313605;
        Thu, 11 Sep 2025 18:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeSzyRo5fxlQ1s5PZqzWjlXyF7vQvka83jPrQMx8jrzjabtE8ps+uhPSg0QScYf/gUsEIfSA==
X-Received: by 2002:ac8:5a0d:0:b0:4b5:e7e4:ba6c with SMTP id d75a77b69052e-4b77d16e805mr17533221cf.67.1757640313085;
        Thu, 11 Sep 2025 18:25:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c692d10sm786907e87.8.2025.09.11.18.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:25:12 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:25:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 05/13] phy: qcom: qmp-usbc: Add regulator init_load
 support
Message-ID: <qpcdlcxvu4avnpc2yebrjaptxcckp3jtk3gdrsdssi5pg2yjap@76a2o2bw6gea>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-5-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-5-2702bdda14ed@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c3767b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=mlQFcmInbWeDH1iYaCEA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: SICq66y6753hG1yixgxdMhZjVySQztB1
X-Proofpoint-ORIG-GUID: SICq66y6753hG1yixgxdMhZjVySQztB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXwzNRcc4awwPa
 EE278+8NZzWpB3KW1sxRhILsLLE4MsGmglSTAYw0UkrUkDSb5RgUeed1XwSHQcv8vExxK80zPjJ
 1crgRzjhHJPVWSWmmyl4miygTAyyNSwUPaO7yRyZYrn9C2kwFHPgMgBqSq7ln0wUCsFYNO8+5LG
 PiKK8jlIt8aYK75GmydVJrgqVmon8LcIjnkHx7JGautvnykn+4X2NkkkAvnZ3+eA44YAbRgXqvX
 kFJv9DCBeJNmEKRPCrx2BGk3UBXsmoWdK8ykH3cJsugnM/oEl3EpbrpQdCHIAS6siC3D8ikxL80
 mwL0T+VKdAQ12gWapqH2e8Imwj/0Kixeg+s/rWtTIw0f+AvG2iu/OAfgQprJqR2Umx8/MtwURUk
 RND6uEkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Thu, Sep 11, 2025 at 10:55:02PM +0800, Xiangxu Yin wrote:
> QMP USBC PHY drivers previously did not set init_load_uA for regulators,
> which could result in incorrect vote levels. This patch introduces
> regulator definitions with proper init_load_uA values based on each
> chip's power grid design.
> 
> QCS615 USB3 PHY was previously reusing qcm2290_usb3phy_cfg, but its
> regulator requirements differ. A new qcs615_usb3phy_cfg is added to
> reflect the correct settings.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 70 +++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 29 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

