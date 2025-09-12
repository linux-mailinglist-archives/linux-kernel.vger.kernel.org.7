Return-Path: <linux-kernel+bounces-813694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F6B549BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC683B60E26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1326B235055;
	Fri, 12 Sep 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="baq9JZNn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7A2DC761
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672435; cv=none; b=hJOJAOATlx48yJvCdwc9hri/uGQs+5VlPa/sW4WFBoCHd87nYLJpRn7lI7L/LxIeGq3M5xH2HLQoAb79deNccfGx/N485dx1HJjrBZyyBBTPJALsrKRaRVe1SBJyAHqOs3je8ocG6CMSp0v/l807LVmqN3mGYs6QTFlZEG6Qzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672435; c=relaxed/simple;
	bh=lGn8lwvYmkoBLqlcSTBOdo/mB29tRg/g9F6ugJIwNjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0unLK1JUGMYCqJncJNd0wkd+MOummMFQPPEbQmWlT4qy6VqcVF/IuTTJTzNp4zhUMsDoJZ6aj1XMLEirDtwy5HKokfSk4N1cVnY7JT06GZ7bwna96omklSGSQCUaktQt4sb01oFIgEdLUvEJO8W5mSCku3NLPqc+htDwdDnzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=baq9JZNn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fEfm001300
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2+yk/HK2uTnuVPRZXu78qeeV
	MxzPMF0ZBseadsxMnhI=; b=baq9JZNnbBmtFqW2UCkb8P6sbj8TO0pqY2b/7FaO
	ywtAcEEjCW0fP1NFmwJ2ZmyuM3qyL1s7Q5y1aW6oXXCven99Q9ZZBRVAqyRVkP8T
	tibnnQQDd95xH4Xsk0216wOSu2WzFbmu/25Eo9VM8WPN6bDJpYr8n6jNCi3hpOZu
	NT5IQ6UZn4hvzXoVJCDKzS0+etyoDyg2umSy5EBclcVvaq0iHHvB2EZwangsKRUf
	PHoQbZlk4F18xguE7gjsWM/w6x7HzwRRnQA01k6p1Ywzp2c1vbE3K5meUlQNsmDA
	PTjj9Zy9TGop9cvAn5o9VWYukgf7X7bcJU9cMIsb7vv4pg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h65wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:20:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b6019b13b2so64653411cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672432; x=1758277232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+yk/HK2uTnuVPRZXu78qeeVMxzPMF0ZBseadsxMnhI=;
        b=MUVTCmizQbJWyo9xB9KC3vksw+8ihgaaaDdzcPLT8S1k+3BjJ2DzfLwT4XjOEk3rGO
         2SowaY0qi9e1Qd6V89kZ1Ulfre40LzVESEzEzPuntOIyAL1bIXsITmyEh90tS14YVvWK
         C7T0kMGKjnvbNQG91xh7TbbvkFy8CQyxg29jiOZpX2vV7BBQXyO4fSNV2q9YzTJqcHmk
         VMFV6E1CTseh64Bj0z4s0TyKv03GOrZkzfHnt1PAS+94L4hK5cVDq8U9WVtBTti6qfcs
         C6Yp5ddDY2o0Yl8DUr/jOTwHH1x/o4EqYjw5RYzOZioTKqHSYhc5xgmCRXkq08irwUJt
         cnbw==
X-Forwarded-Encrypted: i=1; AJvYcCW7I878+jwmjxqaVUv2LHxRIcliaCDAweW4M1TNB1/ebYuHlPdDSKLpSmjCn6HYjyIS7b4LOBqkM4uM0TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9yamjEs06dlMfqpvFQszKCbOrqMXCAK51We2CIefvPPPzsAX
	qqUcbSuqqRetP/CkaXS6QUVrlQkKr/KxJgRTwvuakzTMUIwRWEsNeiyHq5bcBTs/9oNMPFOKSY6
	FAlzg2IYa5B0+I7v/IKULzAcVsoWc1xC9h/h/nfqav3xDkYWnkvlMn4Dik5W6YYipDp4=
X-Gm-Gg: ASbGncvS97hUr6U2rpDXS1gtAWjyRlvuJqYrDNkGXmyLKUeAe+jwj85hqVMgvXJ/JfH
	X2kie3XfHKdSyosXxIyRFMvBLYyTZHUdjxBYcm09zeI07J4BnqgoqsB+/L3Y1Id0u9/sLQixyI/
	30g9NXm3Vw+XhYQ5tNtSTTE5Qhb50q5mQuakXcOxMyuXZlI/EgASIx/P+oO23XC4tiJg9bgJaet
	/q2gB2ReEMZaF992EIz2yb+FHu077kOwFEc7ifTFhO52sY2QpQzD0iZLH1ll93rQ1Ov35YJGGzE
	EyijSqYTTItdLyvKzAljt2+obAXCYtYe/ozbwG/iq+GuRjReTiZ0fun0BsWfQfGRUJ4jtPWdytY
	RoLpIDRIevmjqarE0bJeMzLA6kYL5wVhgbLgolXz4euNDR87y/hvU
X-Received: by 2002:a05:622a:d1:b0:4b4:9169:455e with SMTP id d75a77b69052e-4b77d05e8cbmr30995041cf.34.1757672431620;
        Fri, 12 Sep 2025 03:20:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+kKC6NUmFZEfIjk6emSV08toNNjqRGF3CD3khX2vxvSwWG/Bv/20qxW9fKMHmTyb8jBpykg==
X-Received: by 2002:a05:622a:d1:b0:4b4:9169:455e with SMTP id d75a77b69052e-4b77d05e8cbmr30994371cf.34.1757672430879;
        Fri, 12 Sep 2025 03:20:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b5fadsm1073715e87.6.2025.09.12.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:20:30 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:20:27 +0300
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
Subject: Re: [PATCH v4 09/13] phy: qcom: qmp-usbc: Add TCSR parsing and PHY
 mode setting
Message-ID: <x6p3hgatsauguzxryubkh54mue5adldkem2dh74ugf6jf3ige3@cb3mmigu6sjy>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-9-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-9-2702bdda14ed@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: RSAdcaASkMZJAUy-5-swVtFlj24D2v3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfXyq585ZbRJ9qy
 Plb7KtOnoF26Zh/h1qvjCb/xtkRSP0K41nBfGW5j4PHBSwBP5JDvErAORdRwnD1Vek9G9lDXzyN
 zERgcs2IRBKgr8Db6wmWYwdkWbgBUUF1o7CIwdy7M0ftuY8jKuEZInbNlWV+adNFVjDuR78KsHO
 gzvrxuRcTVBGqtTbSgJBRkyuhnoo76VJIxc+pHd0aYQ66eVIWRLJvQwMQq6M2s/15VrHq5lwf4C
 0Iu3+HJ3DzZdpv+iGPBNG+yuf0i2F3f02nJAZX05WzX4UkNYnJTTzFm0eOuS5Mab0WYMgYUggo7
 a9AgLKEhWveNyVu+0tlA592QRqC4eQRMZv2lDDK6Rm0yL10IeWXdkk8kSqkX7VfgO0/tklzuqpl
 gfTNchB/
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c3f3f1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lnF_te-ij5czt4pA2k8A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: RSAdcaASkMZJAUy-5-swVtFlj24D2v3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On Thu, Sep 11, 2025 at 10:55:06PM +0800, Xiangxu Yin wrote:
> Parse TCSR registers to support DP mode signaling via dp_phy_mode_reg.
> Move USB PHY-only register configuration from com_init to
> qmp_usbc_usb_power_on.

Two sets of changes. Two commits.

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 47 ++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 

-- 
With best wishes
Dmitry

