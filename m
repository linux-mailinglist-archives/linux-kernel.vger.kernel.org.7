Return-Path: <linux-kernel+bounces-785576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DD7B34DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B94242AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D7284B4E;
	Mon, 25 Aug 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgPxhqlt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E227B335
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157073; cv=none; b=LqROI8EHjvi/PBZ5ZAQEDsm7dhCZnwX2L5q9LE0tAd76zqYoTeEFUCe83YT62VWU6HtCActZXdYRy9f10oUDA2xBCgoXbTMbDIrodc+cbRTlF5wPVf+3dR4yxgIWzKyU2MTX2sDkelIBteFoOfJRR0NWgilY8aeg3Vq7mqKt718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157073; c=relaxed/simple;
	bh=cpZTDk56y9bF51KOzYWzjHTLBt3bmAawNU2VPBMxKC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBAAmBi+ZgVHLP+h5QPxhjt4X79FTRr1KX+7pL956+JioP0WAf1icS3dISD0M7NUPbU6Y0Uo5wVle1v9sU/HtZ8zQfIQ0yE6Fsph2mwnhcYeiWfUstvm8RgyX0otU/vveY51pcQbpIn048NizMOEfzJuo3xQHJI15RQ0indvAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NgPxhqlt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFB22Z018258
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EQDx8Ekd3LgKr5C8JKyRUgZa
	ehoO7DCfDNyEHU0DkbU=; b=NgPxhqlt/xhwmOcuWi+ZGzi1m6NPMJwUGvHv25+W
	BNdc24dg0JqdLPocZVH3TZBTH9K/zr2efrP0bIEW5ykRclCrAnpp39xwrDMfSdFo
	vFfa4IzPPVsa181ExoG22tM8ccTMY3BkSkZn0Lj0fOCzbLy4dr48Qjgp/xk0DgeU
	KxwJhKBHpR5pfXp7CptefBCRsreS+RQWfLMp/a32RineUIneUipBvc4gBtFBzeGA
	7ieSURl9OODatVvd1CtAwKYRc0cJHiDrmLW3zIcFTxSfJ/vx4ZSnsCxVydVpb5Jr
	4B5uvQRpJCrwWMZNd8vtn6synnn4AxP0LI0zNV97gtJHNA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x86hn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:24:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9f5bdf6aso68736736d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157070; x=1756761870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQDx8Ekd3LgKr5C8JKyRUgZaehoO7DCfDNyEHU0DkbU=;
        b=PZX+XuTBNNPsUUXSU9mFaIgo5uvg4YNfmanLHbQNpBROYrRKX+yo92O6N4JzMIbB90
         MXVlvspOdPKrYW61CaDf6kMunUs75OyAf/2zI03BzsEQ53TKpAl/YJFSCyRY0oGUS6k3
         Xud76ph55fix8Lwf13JsG71q9tCuCKkUsMPeaEaZVrpjr9nxsOoPkDxu1/vnYQN64LkC
         mhrc8kss2WloPBv0laJvETOv1syCum3jV+7JYISn9WrUpWLM+N1zq8jqyWto/+qHLm+B
         r9V2u8OXvzNiLYfuC1rn7l1kgXy8ltrMmPlSJ7Q4kIj6gwGw2xjSq/wV8iWMBCRllKfu
         x2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDufAxq/GM7pHc1t/SYfquaC9iBxRs46C9d90tpBg3u3jw5ZDTvh3PG510SU2NfonafouqLwhkc2yKe/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8gsWaNyTWFe7w4Z8GusPbZ0/H6Wm/GJTsSg8Ig0EQ5X2iG0O
	AYAHY64suUtVyu2cNnBObRmwBKiKKOur8DeiFTX+i/aTe3lxrYVoifHCXRe7uwa3ChVlljH1KD4
	21i8G2LNqhzB7Lr4LMGQ+zv+C8zQSqPbhZyD1BQE4EHgP5LEJWxAC48kOo1fntZq/bf0=
X-Gm-Gg: ASbGncupkTRrKjf/Pbjff4eb7bvAlhkGFIa+/646t1K2DFkf33AEsZrnuMmZkbsF0VK
	/QSPbXtSqXnEejBvCPT1z9OldIx7DNV4G6WDyIzg4MOG7sVFyC5qR8NDKqmiAxrb5spNuts11uc
	GRJSQjGucRemYSl937iukV1rl+ZRijb/18UybE7ZMKA9HgcgfZWySrmkRs56ifelbRghuuZc4hE
	emDrIembybfaGjH2uj4ycsZIGrPXlW6JhtrtEpwkvPJCag6JDdlhaOto8eii4el5faKTv64AV/D
	AH1TCLNa+JFu2WfrASMYGaPF7fdUYiMlIBbVDeY/g+v4JVrEJ7obZkRAi8oLqVNqhMi515IWW3C
	G50BXZi6jDVGBTVsWQneoRa5L+ACEv/mQ0KoP6kO8bggRBQ+kZgnq
X-Received: by 2002:a05:6214:519a:b0:70d:c901:64fe with SMTP id 6a1803df08f44-70dc9017863mr25628676d6.41.1756157069658;
        Mon, 25 Aug 2025 14:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4JBxu6eZccnvdZJRTroWtFNllocYD/kVOyxn7pmff5QlDW6XmknGCCRLSE8cvLFZ9mCVnhQ==
X-Received: by 2002:a05:6214:519a:b0:70d:c901:64fe with SMTP id 6a1803df08f44-70dc9017863mr25628346d6.41.1756157068897;
        Mon, 25 Aug 2025 14:24:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3366fc06c65sm11094811fa.60.2025.08.25.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:24:28 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:24:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 18/38] drm/msm/dp: Add support to enable MST in
 mainlink control
Message-ID: <ahgabnh7e2zszqjakexr4755orihk6afvqlyw3lvcffyvr5muw@hmy6kf3ociku>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-18-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-18-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ypqeSg32ME9GIv7CIGSxo9vYxoY0o5Zj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX144EBnZoq5DY
 ZlxbvDu/7NooArysubq5i9hrwyElCyC+taevb7dv+pFCRbGbGJ5xUe61tnu1/N1vz59QLv3c196
 E2eaEbEagp7APASkZHD6xu7RNnal47hdUU52MZ6r96UqZqGfvICGsorOKUnP+X2J6tfR+vJce7g
 +c0Fb+C35+eY+HcDZZQCTmXVuxcL8DGkmqzozORr0igLJqxh3Qu9yoznJobdLGSVxFlfl0FmUdq
 ySHGpY0JktHR2G9FZ+KvkoS6nYVgTunTzV8LDRigjRI80meRXWzs+hbN8elvW+bw/XxfL0rfRzl
 pxVILOr2rv/sJvL/QJpN50K6FL1nqBM1efyBstr9FmCIap3ZGHqKTNWs9wTcr3yvptJNwhDY1cQ
 EG72l6Ms
X-Proofpoint-GUID: ypqeSg32ME9GIv7CIGSxo9vYxoY0o5Zj
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68acd48f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Dh0pfIAITmfDrERymUkA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Mon, Aug 25, 2025 at 10:16:04PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add support to program the MST enable bit in the mainlink control
> register when an MST session is active or being disabled.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_reg.h  |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index de3d0b8b52c269fd7575edf3f4096a4284ad0b8d..fda847b33f8d0d6ec4d2589586b5a3d6c9b1ccf3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -128,6 +128,7 @@
>  #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
>  #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
>  #define DP_MAINLINK_FB_BOUNDARY_SEL		(0x02000000)
> +#define DP_MAINLINK_CTRL_MST_EN			(0x04000100)

Why are there two bits?

>  
>  #define REG_DP_STATE_CTRL			(0x00000004)
>  #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1	(0x00000001)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

