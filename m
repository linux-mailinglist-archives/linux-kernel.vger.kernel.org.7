Return-Path: <linux-kernel+bounces-838123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216CBAE7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F821C3ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD3289E30;
	Tue, 30 Sep 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPAcwORD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033038F9C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262782; cv=none; b=RgeaO8RTT3fmcs13gLq8ZhmYFEDO9PuJkzrrd8Br6wZa1mFvM/oWB3FHBPO9JtELiLNhupvGxYry60l7WLcLjyMxyyQjR8jcboS3OlxG8XqMGmG+j1kwFcqrUaBjzOFHh/tGJsmehs9daVwupLwg04Rnqe+WE9utv5+s80X/D44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262782; c=relaxed/simple;
	bh=uXkF/ihhwXZnSvOZ1vZab5GXRver+3TRBZj8qTXUuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QftC9rozsPNYBh+uxjcWrYftlhNInHED+89rI+Gtp7JD2qEftxnAHXRTlRBbUz18ofKGoLy+nOaVPRLElHNtC9ELpjrVf1JeGhOmQMSVtbhrR48TAi3YFmfWP0xeChEtG9DfyeWtDFCNDignJcet7n4oDq2HUYaPX90YXegrrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPAcwORD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJRcK0020484
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nnCDWQBx3MEUkPGk1nPDrYBk
	0/iZtvd9WsbeqrQ9y0s=; b=pPAcwORDhNc5V5kCVRdy1IZmLTHcRoUgyba/fmd3
	LsdcVm9mBl23+/rygXKXLx4xTmFejhl5BRVUieYfVrucQZuz4UUt1acQc6HyTIyO
	RPqAXMPfwf7YaC7RTcJr4ZV3JkbbSxBKxh5pPWHJSWSsno6VL8fubM/sxLmOXb6M
	lWHGcrG0XGpyEMF1ttNJPNALUy6c1JR8Qk24PVus9lvJdbntQaG2hFR+Ln+FlgUF
	AyOiJsXXSybd3jMHrCKtl4KLiRcraBsEtSM4sCTFmWu3LWeBbK5TpP8rLv+3bwAG
	By3BP5CkBKpniG/bunzzytaqAcm5eQROG5ldQf3aestZ8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5tf1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:06:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b78fb75a97so66983261cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262779; x=1759867579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnCDWQBx3MEUkPGk1nPDrYBk0/iZtvd9WsbeqrQ9y0s=;
        b=QaVuhFm8GHtkyHvKwOkszRVyRmDT6Day3BuiPM9AJmz4yesMDpjyKoUq4VGLKNycAL
         1vl0OdxUrTU8ZTHmEwFKR04qMRe4VA/fceHopyXLNOVb1WztHMy1wKLJPNEYe/aCi+7O
         sxxloiLeih4cl4iQEjDmAvMSsPIuCZHA73aYwBURHfoipv5+1L4xSmTGI1+rH9U2wO95
         UsbZFXvNx7rZjOLlq8U7O+mqrwo5eyJx3JAqCaP07gw0rycTD1enlhF0saUIIBdEWxp0
         ZrHPYY/n4MDJytGherVYwyJXquJjPbFECHjfE8aJEtp/J7E0ousWseKpCC7sTUJKNtXs
         L+mA==
X-Forwarded-Encrypted: i=1; AJvYcCW1thWxtjS+I0RZbx2pPHh+ffCTj42mCz5U4eiEgMnMD553HrnrK0WnrlIVlCsAeaQ4YqHFQPhxyyFczII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZojEPNA5HiKR8SgkNIfZ9CqYPrtFhLULICQbEPUliHl7n+5c
	VtppNgUTZw3q1bP3xgMGydV+G89Q+EhzfyzSz7kqiablrz2gJa2wpPPGfoElcgZx0gtqWziYgg8
	es+gKemQXykxG9Yrzu+qiW55gBKYLKZZyiPW41rrdAhDMkSbS9By6qXp+TjQfuFT1mYI=
X-Gm-Gg: ASbGnct968Lwjb0N6sz2Osv2pVQjoe2cH8YlQJjoG+dr+RwYTSsUjI0AMs3tg80XP9O
	SuvKCZhRWmabPg93suZME9AKkUoUNKJi1DoolFvOPw2gou19i3iK8I7mNhLSDsdgcFuXB6tS/QE
	oaaQNyry6nop8ArAIRTQ0pxIwG8Rp2dAev31PgFP64L2j5NaCT3VEjOHIfBrB0+bcKflpyOwZwT
	XcM++ou2plRTmUCVT56u1ERaQKtX8mBRAyQ56+ee9TRi9uLDmbwU+M01gF1+cgn9kg+/TEZ5BYa
	wqkm0f2zLclZ3WLzP5KrQ5KSjaASWPHaO9j+ibniHUarANmb8j7bYyDikT0IXBBpo2flgxnjX1+
	yZko8LtRouePdZd9jdPrc26tjMhEedDDM77R2zqEiHmUSPAT8cOqiMpgI3w==
X-Received: by 2002:a05:622a:1f06:b0:4de:8e13:2ccf with SMTP id d75a77b69052e-4e41ea169c4mr13229351cf.74.1759262779114;
        Tue, 30 Sep 2025 13:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAC+gjWYrGkYGyC7iuQx0n8IkXtiwE5ml3GBXLD2rdjXMDvnTqbMjAoTH934KEvOlO8Ctyg==
X-Received: by 2002:a05:622a:1f06:b0:4de:8e13:2ccf with SMTP id d75a77b69052e-4e41ea169c4mr13228591cf.74.1759262778420;
        Tue, 30 Sep 2025 13:06:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-586048c815asm3037274e87.25.2025.09.30.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:06:17 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:06:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] ARM: spitz: Do not include <linux/fb.h>
Message-ID: <atoda7fiaw6xxc3arfg2rvczt4ezhravwogbshvca4dsr5kjqm@vjj32eqjxkwl>
References: <20250930112651.87159-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930112651.87159-1-tzimmermann@suse.de>
X-Proofpoint-GUID: 3mhWwLdRIkPIJRBahFNmozr7Pq-Td9-A
X-Proofpoint-ORIG-GUID: 3mhWwLdRIkPIJRBahFNmozr7Pq-Td9-A
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dc383c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=al7qi2xbfAQSSKGDXgwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX8ankXx5i/yGE
 6w9rovrq9h1flXC5mp87j0SjZP38IwwtrqcNUUus4PbxDDMXGU6ldtEeQh7Iv5NZ0tQGNTVYsIH
 g9+UQpCAZ61+SpJ/cvzDlkRfBgyN6Oi9pTHjGiDDW13NhyuQYSTJnpfN7sB+wlR3l0Zz2nSrAaO
 4oZlu4XxeDb69ZWU0WMVVHF1oDupp1DyY2DvtIcKis7frW0bhfE7BWJZEXQSrGYsUjjfE4H5rDd
 4fF3PR8yDJOaqgJdA7flmtYJkFkrOkjwwn8YIMGMgdQcF4BEMNU1s8VgVRTu5/OUZjEPayX6m82
 bXky4UE+xsVAx4Lj7V4cd2ltEuVvY0HFy2dFNf78GDvdqhbVMXQMIESen4kODFoxRNYQkn0S2HC
 /WoXpIwlnAYzxkv+lZoxRuZ8BheI7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On Tue, Sep 30, 2025 at 01:26:46PM +0200, Thomas Zimmermann wrote:
> This ARM architecture's source file does not require <linux/fb.h>.
> Remove the include statement.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/arm/mach-pxa/spitz.h | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

