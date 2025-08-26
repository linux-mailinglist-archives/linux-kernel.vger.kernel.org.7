Return-Path: <linux-kernel+bounces-787315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8280B3746F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425F33B6F59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2512FA0F3;
	Tue, 26 Aug 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAsrtfik"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453C2C1596
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243712; cv=none; b=DWivi/toEPC3Cf3yNVolyqQNSOa9Dq6UA/6/CcGqjPKjIE4DRz6zoDSLd5gI3+7QU9PGoqgRnYDaL46gVMPxEiXGReTRFd9/6N8DNetr4Yu5yfnSmEAvbhT+1o8OUt2skK6DsRmrdH/vsVDAGT6+y2OZmj5/jdp1GruDDk6GH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243712; c=relaxed/simple;
	bh=Qde78mFgh7GtdK1Q3VM3SDoWByRWzJWdWCqZbIAYagY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFqL6H0XQfZGuK5GEz3TiGv/XnqoHyBObxGWfVJ2Ri2kY9yqaXvdqtX58yhvGaKGrqAQdwvojoKiK6YBPC1+R95hV4ZvlvfOnPOIWWOCwMQLruiireyMNkkyqgg1fIzWA6NTrEeTB6cp3Zu6UVFaMea3eCrDRsuhe0kt+5WezHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAsrtfik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHLBMg027949
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=clTRNlMfsTDWnZAZ4jytuHfn
	PZmj1afqUgmhWf7cX/k=; b=VAsrtfik0TLBIkRuI4N3JDmJMS2bvlceUWREYRmh
	/OEntdKy0NOP9cfM4wpFpgHRjOfDyjAXEax7TaYXqo7Zwl53LJHVjsoi/Zg1351V
	2j60JAC8jxgCACiyqinxvR8qgw1pBuMMQAe2OCbVMqzM8p+LyaGHH4xi9s9jnSwb
	013pD8V6GCA9hSJ6ByEIMW24tJG0g6tCJ6b1dfZgHAtizuN+NFteNyrYXxVHQYny
	xy/lMoSUCD30kPDv7FKTGZ1yFVY7MhvOrd8Y+UE041Ch8HN00XqyOd32/0PnbuWJ
	ZmzI75D12MKF3kqE945U7QfgxRcdlfqYNDsF5fT8iKtjAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8agngg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:28:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109be41a1so235591601cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243709; x=1756848509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clTRNlMfsTDWnZAZ4jytuHfnPZmj1afqUgmhWf7cX/k=;
        b=fT23o1QUGdUjk0DpyxnkQTdv+90qAaQA7WY5tsI0gPzm42nB6Crcm5mfG1cfd0tbQ+
         o9KAS+V+z02vfQGYeYkn9e+rMdnkJaP+wW9Mp3lFVQUSpoinsrVNLCntW7swuptYT8VS
         B9mGpHM0JxoCRea3Y69XrV4a9A7StLdeCJ62182Iu79Ch24vWuxG3/S3MNVFVNUJOKlL
         oZkF0RUaDjDhZYzTBKl/8Gsbx4rfq17wfDnaZ2w5SDO86bNHO1h2m4D0MEjFhZV6Ub44
         8DF9xGPwbQ+/we0o7qcWpi2ENX1JET8Xp1iCJ8gzw5VaumazrrR8or7b+6Jw8efuwpFW
         bg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCMnhp0bwdVwPdR5uXLcb06L1voP/9R4XJBsASCBk3yzgF3EgMEkT/2WsZBd06KZW4Kvlqxfec0beSoys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGE9xpOTBqrEl2HYLgQTCtIvVyIkGMLs0HN4M340GhbO1dMIzP
	kR2B8y1Pde1NR/5doECAGr+ZmgIGbnVH88Rt8qtg/tabgR35SXcgMI11eO8Pn+V7GpMLbVJLRdb
	dqm/0r0HdJyavFDfqaPwXE8yvccHLOEx6n5bzYyFYaolTwy6mw7Xivngcp5wDxnDYJC4=
X-Gm-Gg: ASbGncvz7aTty+qi8KgRNEVpQG2LOwIhFm5aoQD/dfmVGO+SZkbGg91tCkCHKzGlULR
	9KdeD9whkq/i/tVSo4PrJAx6mgfVb0ziFTCLlCLxTsVnKsvpViFVmKnFQjVqlJbcB9INJSOY7kY
	1sX1alXep1sEYZuP0vtGkfonJDDsngP4IOSYkg86mK2fKraVvnMtIPs6D3AIVzuZtH/yvRhyPln
	jcydV9TB4niQPmc7sFKg/lmT8by7iIHjVHegx+JXGwnUbEkXiiWRUkmVobva+LZDGsfrIhlCSN0
	UE45us3vJ4xsOX+lwjw5hsgP0qxFe+Tu/RDm+yobhNNudI2yhdMOb3OzQDvJ+5YThtWB1cE3nX6
	eu1L0kuVTwUX4Oaeawm3pu9eNPFBko04ciRg5IHlhRUXOplY7JXin
X-Received: by 2002:a05:622a:118c:b0:4b2:8ac5:27c2 with SMTP id d75a77b69052e-4b2c4d99612mr129989721cf.77.1756243708968;
        Tue, 26 Aug 2025 14:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpR67kwi5LVp5pSfPnw+J3VFspElzcvSFuZyuXNRvTjYvd1FyPiBQ8eOYtogA5Vrr61DpMWA==
X-Received: by 2002:a05:622a:118c:b0:4b2:8ac5:27c2 with SMTP id d75a77b69052e-4b2c4d99612mr129989341cf.77.1756243708542;
        Tue, 26 Aug 2025 14:28:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3366fdea6eesm16950191fa.44.2025.08.26.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:28:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:28:26 +0300
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
Subject: Re: [PATCH v3 21/38] drm/msm/dp: Add support for sending VCPF
 packets in DP controller
Message-ID: <irlo6dhfm23b56hojskn5oxwznwmcfpwkbq6zq66o7bhxvq6w5@4qaldcvcwqev>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-21-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-21-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68ae26fe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=abZXHuzVrGm33jVRzXcA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX5ipySDvRPe0K
 kMx8pTIF5u9qCPc55PwQxQlWYZGzcGSosbttcfPI+YSWD2al94zHpg11jyxI3sr1AHa/1M6llM3
 zECIZSNJUUqF3YcWYpNirIeFVZODov1fGE5xom8c1NZ/Gswci4fvc6zstxpP0nfrqMhbXRUqJQV
 0bC7uJrhArXAsKf3k2k3gHTXfv2A3ThsKfz/82K/3WHCZmz7uwdSik2qYHO+XFJHk2TEsBvrSyr
 LMBaWHcqvajQpwtQPSbZDqBwqq6wG+kSw+RXvWqoyFcbOCj5alQKKsByxpP2JFaEp2He1lJwmJI
 YBY2y/5SMxfHkbDOeJ4VeUz/+tFNY/ftSd2ti9/dtR2wTVq3ma5ZYC8JTJPyi9OeYsrJ7kbS4QB
 M7u9nid5
X-Proofpoint-GUID: qni74dVLhSVoS3xU3gpFuCMfHDNYbB5x
X-Proofpoint-ORIG-GUID: qni74dVLhSVoS3xU3gpFuCMfHDNYbB5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

On Mon, Aug 25, 2025 at 10:16:07PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The VC Payload Fill (VCPF) sequence is inserted by the DP controller
> when stream symbols are absent, typically before a stream is disabled.
> This patch adds support for triggering the VCPF sequence in the MSM DP
> controller.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 56 ++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  6 ++++
>  4 files changed, 60 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

