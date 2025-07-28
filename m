Return-Path: <linux-kernel+bounces-748283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE0B13EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BCA7AF458
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7752185AA;
	Mon, 28 Jul 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YnOzpmvy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A275271461
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717316; cv=none; b=FEmrPAfvNuBMnBXU/1rAMPPWxqxoDnuMqYsXFtKYBxjQQ0Cx7Ah1MNkRZd5h3bnx/4Ff5cJkjF7rn0sqGrU+kxa6eXRpnzMDIlA5OKDw2Tl3B4yvSkYnSXAhxXw2EK7Y4H4TdJlQvq/ye8yhaf/4Uiym/rOR3mYVu+6b1lPa8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717316; c=relaxed/simple;
	bh=Zi0iijzHSRqj0C8gWEoCELIwDD7xb+A1y20FdLS9gl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlfMaKWRv7WiRGyawF4n7W5l96cMt1v2OdQG3FQA4aXGX0130rnoVQOMPjopWXrL8O83OQnaZGqF68Cb6A7B8lWDV9Xc2ihLbnfzT/TqfI1eVZjYf5GTp3mc0m7nk29Dqf+SNbMNxtq+SzuqknbKlTKKD0DZy1MdZVUpCnEO4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YnOzpmvy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlJrQ005004
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7j5Mg8G551vXb2fvdLo7IXqKWF8nW+MN9Ie++oA4Wlg=; b=YnOzpmvytC2WkhbU
	B4j4pPur5j4QeptVL9h/mLo87zj6Kz/4eoebTZqUgxuH+u54u6VZY6yFA/np6Xn6
	yLW5zevDTU6f7SLhPi2tmIZseQx38xmUDL/ZfK+TETxuEn4Pir7GcU59sa0wjz/q
	ojabnigeI09W/H9wPmlH3bJuG0n3lyVQAs7IR4voLjgpm5WA3Ichb6kygJora3cu
	zeljvGW9CQQjGCJeoaOPcecRF6gxpU7lE0uF+lxrPwvuPtUfjr/+T440VTBga3BO
	IUSeQasU4WL3kA9FeQmcv32hlzxUAKuSxdquvHv8cTuVVnSv6r86hkxm8x0izXIM
	ERT9DA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytw8uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:41:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aecb246b86so3237671cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717313; x=1754322113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7j5Mg8G551vXb2fvdLo7IXqKWF8nW+MN9Ie++oA4Wlg=;
        b=GuS7sJ0ax752gUzcmSW73YLtRYi3WtvEnoNdVCae9BGoeI6/B/w4cuo3QQeTbzgDV+
         OYntf9LcuSCk21T6oVBwvEeL8Wym4gKldt8kj7uKk0i8ApuOBrtgMrQc/6Q+ioGSGr9Q
         RazWea1sf2gwHoGgis7z0POY0Qbq//CSq1cdtGSRR51gmeYw6o1jM5ajXhfBoQMS9WyU
         LfHWGsmVQK3IWrOVwVZx6F3gwPDAaxAszWnzInhfRorCiNM81Yo5/DBM9NDKX9S1Fttn
         DwJarP6o29b1AcLAR1ybIVFWHrzRKzqzT9QhKM71SaeDyG3sGDWngBifPD4Ys1gIeabD
         FBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk3px7oH4YYNa9MIQGpAX8nJV0kpabdoT6HxH5FyEWcKJxnRV7e8qJr+xcxR8q6CNPx+34g7x27eXDnc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylv1pQk5LopyPnMPauc4PmlEGFi0neB6fCRON4bnX0vFbMHOn9
	ZPfOzSEJkkCmUBudXEozOwS23iIqvnOa4sR+m28yhoN3CWepqrAdaV57qplqlCpdKXi1lMpuSxW
	ryMg5LzMYuReOMMNkBgO3zzIAoHItNjhNbdsIz4x0JIXnYm73mA7HLF7EFwkMcEMZJ9U=
X-Gm-Gg: ASbGncstJTkADKgik0MfYwwFIgz4EPSy9AKisL8hhMWvorxwoz6fHrf+FfQog+mPy/M
	L6+6O/+evV6trYn43ZwFJpN2rgcPl0c+sdzuQ4YH3nlkCWlcP1ic8vlu/Uh02CIc304mqTUlh4d
	3auPVgGCrKCWH1AN6kmxn4J3RceBp3+oPpsG5ajXwGXhlcByZHDK5dsPqQGsG5Fjg0s8mxi3tEX
	LYpHeunv2dUYj1V49MIhmv++NydqQAg8bOpRL1I2NTS7oRByLBDRJjeoE6hDpydvs45H19ZGPbP
	IdPeoNDxcx/RxgAXEhmp/XsFBI59YqsH5E//AKmMduv39vL7YOKd25xxHhtqgXRlGOGD48Tq8S5
	Y8r56y9v4mfwDDXKaxG2DltxtZfMQiYf+vlZ1LYGrhUQUwrCswVEp
X-Received: by 2002:a05:6214:2488:b0:707:4fef:468b with SMTP id 6a1803df08f44-7074fef495cmr26841296d6.25.1753717312827;
        Mon, 28 Jul 2025 08:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOAm27xnvjCoTPX1PfqanlpxIU/37UU2TzXPWd1qLty3Pje9we8zuKNFPEu4lW3V9WCb1jGA==
X-Received: by 2002:a05:6214:2488:b0:707:4fef:468b with SMTP id 6a1803df08f44-7074fef495cmr26840746d6.25.1753717312155;
        Mon, 28 Jul 2025 08:41:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633ae411sm1315965e87.203.2025.07.28.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:41:51 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:41:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] drm: of: try binding port parent node instead of
 the port itself
Message-ID: <szwbsymzms672t65u5z6hqxeyfx5t7ikqwxswwdnkqs24loc23@4riccvgkxke3>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-3-e4344a05eb3d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719-ums9230-drm-v1-3-e4344a05eb3d@abscue.de>
X-Proofpoint-GUID: oraysUBYJbGSpl1snXnPUmLbySr0JFed
X-Proofpoint-ORIG-GUID: oraysUBYJbGSpl1snXnPUmLbySr0JFed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExMiBTYWx0ZWRfXyz8OUsH6ZwnM
 FY6C2Gu5sHjgE2TgcpyJTgxLpiwYFGnLdINyWM66sU49+yB81YSpAbbvZHFIMLItRwSciPnngzt
 Qg98gkpzLJwqBZEBFhgk9Annjdj1qs1eeYgxLBqHVsC5Osdorll3cid2M7mhzodp/FpMEm/JClD
 /Mf0CEJDzwA4B/kR0rTluYlQ8vxhP2s2Pech8oMGtY+uqxSCEWW16x4PC7DioWoaF7KL4PjHmcW
 6UFxMvnpsLe2hmmhrTw/ulmwxdcXh81OnF3LhIZVUXF/jI6p/0EnmQlGpndYXSrznrwXoD/Z9wJ
 RyucQ+Uk4wFRJG/QXiOABmMtgzsm6f036cn99SlRTVcVKakPY10zQQ+RKdDtKzX+529CEfuZc3t
 w5oqN3Qdd0PVa61QYjthnjEWaDAPO1rvLPF3rxmiNOHiQf3vaw4mTqL1DKvVD24zgFpTsjkS
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=68879a42 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=Ih1c1VdhKniI8WpLwA0A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280112

On Sat, Jul 19, 2025 at 02:09:39PM +0200, Otto Pflüger wrote:
> The drm_of_component_probe function is intended to bind all devices in
> an OF graph given a set of ports linked using the "ports" property on a
> main device node. This means that it should also bind the components
> providing these ports, not just the components of other ports connected
> to them. In order to do this, it calls drm_of_component_match_add with
> a pointer to each port node after checking that its parent node is a
> device.
> 
> However, when given a pointer to the port node, the compare_of callback
> does not match it with a device node and thus fails to detect that the
> node belongs to a component. Fix this by passing a pointer to the parent
> node here too.
> 
> Currently only the Unisoc platform driver relies on this feature, which
> was previously broken and is fixed by this change. On other platforms,
> the "ports" property points to ports that are not part of a component,
> i.e. the components only have indirect connections to the main node.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>

Missing Fixes tag.

> ---
>  drivers/gpu/drm/drm_of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index d0183dea770308e77f05da364ffe087d53f3be36..b972facc2ec3fe40a4e10b5d7178b5ac8c0158d5 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -132,7 +132,7 @@ int drm_of_component_probe(struct device *dev,
>  
>  		if (of_device_is_available(port->parent))
>  			drm_of_component_match_add(dev, &match, compare_of,
> -						   port);
> +						   port->parent);
>  
>  		of_node_put(port);
>  	}
> 
> -- 
> 2.50.0

-- 
With best wishes
Dmitry

