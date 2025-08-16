Return-Path: <linux-kernel+bounces-772289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1239DB290E2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EDD1C2236F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D323AE62;
	Sat, 16 Aug 2025 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzbsPxQ0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21F17A2F6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384263; cv=none; b=qplMMvJ4Egcoo0DRpuoMK88Mqz4pRCm/qZTkzKJ//AnnW0g2rxQoOA5LQf8E1S+q+rgKvT3Y43jKTZbZQv1BE5+YQJrDVwtEUkCnE046vPwvGEL2rz95CjCvfBcR/YMYPmeKZO/Quxw9q+VDMKp6vLB/eK03xFGCDSb1JH9CZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384263; c=relaxed/simple;
	bh=cKiKievcspWn4V/Fk14/R1xdh5elwACGN0pwMEQpmNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGzlhodXGvV658WlZB3oLlRklIpe0QJnBOBW9DOmlXs6lE5BeyDBTOl4Xq7T291QOpz1ZJ6b0qoCX2CLFYLb7E2Q8jBWGjFrMXHUBIBtVbTRmPiiPwDj9aanlfdrYVJQNEArRlCoPwLDOgwTMFZQE1xLNqcFYZ2GLL45z8MuOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzbsPxQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GMU2m3005934
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/EuIJSQVFipHZ8gh/mIF17Lq
	KU5ewaZXgNr+7RvbzUw=; b=DzbsPxQ0lXmlfah3RuV3nAP90tK+ivc2QoIV4QDd
	XA4b0wnLUeee/3ryNUaWx0WH9U5SBX4itRovfT3gmSig3PehjaOPeIw57Ja7TfrZ
	zn8ZlaXS/RUh9T112Y3amDR8K7oBta4J0vxEQWpeXUC59Vf7ia2Gr4vyPE9R4pSN
	rkUmXir7pQRjAtJxapFIxc6JMRzAhIGQ439F8qsDbDeoLYf2e4ZmCgjOughDtAOV
	ZVumldT/D6Y6epq0BKacXKqqqNh8lTutcejq2ocgdAIbtDU7CpHwAnH0XyaGGOI9
	kapq2gODvEMjrkH2LKYWzkBSCHNzMrenNO2Ws66i5JASIg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh071bn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:44:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88de16c0so69914776d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384259; x=1755989059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EuIJSQVFipHZ8gh/mIF17LqKU5ewaZXgNr+7RvbzUw=;
        b=T/S4OJiJTn3NDzPbiHgtzwDuU+qLldNkAC2J+j1ZVYJ9Hor5oiiQYS+vhNBBWUvh6d
         tmWmJe6mAs+tBJq5toe7SwdozT3ZwqyVbbtHLNFiAMo+S/6dXg25+hUbdLdJJJHAiKyq
         tJ0Vvhub7FCOnJSoSbmmZdwqVNkZnOeCbiOMJvqBXgnioIrDpHSBJvLshko25aag+bT4
         GXQ/+g/LqymGp9jWM814BCMPhAXrbn4SWxjSogAnl11jKZzxz+ZoE9e8RRuA/Tany/S6
         RFUgw/+U2A+ACq+FjgmgR003Uv36sdHgyPYArYCPJ//6Mqu+jk9vKLdbTVP7PeJmZXHE
         kUSw==
X-Forwarded-Encrypted: i=1; AJvYcCVG77yAK9UmRV/rJpCfjAk5n2f3OUCRAjCisulXtjAO/jZI7T73YL4yIHHrOyDP76WdVSIhmQe8eVuoz+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsmf9W25OqNxmVRzf/bx/3Q8rMnDovwG5KEo1c5liJTKCJ92Z
	thS1Z5GLH6ogmCP6++CZ17xTjfdMvaHm0JNhQ/PJ7oPpJmBKGP2HkinBM5QM8IILNJ4FpClpEgm
	5v+WVBMP8uOxdyVLd43bbak54vo/jHtx7LN6dwsOk2JCoLwqkPryUEn7jMdpY13KVEvI=
X-Gm-Gg: ASbGncte4B3SrmsKPifjnXNZHcWwhg1U6qGOjDkrQNYFFG+Wvf2IC+k1kn6EJHVNQ/o
	XTelwP27xnOXtO93LjgGoYhgTENtAlNwHu8CMPJsytkMDe028u5Nx0LEn3G7hBS200wAcwYucLb
	bf2YrLA9OP3tYmvVgxOX8txTHHDjC7qWivqgMZxymMiTdamL25pSZaCrig5i0W4iJpL/vGtF2eT
	znQsZly94CEwl3bmjQpeSxZ0QVihZz+HuPFr9DG2jen43k0vcVlK9rlfr5+IEwMUEw1Kr5BcFpT
	P/fowLmtMOJV8ECgAf1WuJ2tqEhTb49bZw6S0WYorXsMnCP2GcLyW2X5M50c+VpGM5lzDQ8jWE5
	H2rDKoticgutlSF/uUXlil2wKR7DZqvQbbKo5x1Q8CLV1NplCMYJ1
X-Received: by 2002:ad4:5c8f:0:b0:707:63b8:3d46 with SMTP id 6a1803df08f44-70bb060bb12mr45909226d6.30.1755384259407;
        Sat, 16 Aug 2025 15:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/81Mu1hIcPhQHya8AuAZQxUdP6z5ibn/KOi+EOfMscEFQ+1FDg4x3XoqGsdUIB1vu/DSt3Q==
X-Received: by 2002:ad4:5c8f:0:b0:707:63b8:3d46 with SMTP id 6a1803df08f44-70bb060bb12mr45909096d6.30.1755384259020;
        Sat, 16 Aug 2025 15:44:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a625b9dsm11727581fa.56.2025.08.16.15.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 15:44:16 -0700 (PDT)
Date: Sun, 17 Aug 2025 01:44:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 07/11] drm/hisilicon/hibmc: fix dp and vga
 cannot show together
Message-ID: <4meqnxetljf2uafcx2qrtpw3pg7aggk7wqqsyrj2unffraww75@orlxyaplqg3w>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-8-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094238.3722345-8-shiyongbang@huawei.com>
X-Proofpoint-ORIG-GUID: BgSFYqesqazgidlttnAKppKcr13WEqY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX4FKAaInvhKG0
 5NS9rJOEZxwylbeZX0uYHcCd5SoyamK0IWDgkJbTJW3QoOsq3ztF8W3/gA6WV3B8NJsQ7UvZxW2
 WMLzSskLTuXFM+8Ai/jQDRktUNI97UT455zJwX5jl/uAb9W7I3eEGphJe6wfZX1k3bZlfZjhWK9
 Dpu42mvMu7aSERdw8C4bACFYwDdLMHAQ3DTsGQ/5VXBocBfRzDJlwi55aKmJxET/jxsDhuIzFVT
 bw9v0abkVeh9/R6B4KvSCJyaz+UgIF3rKKSSabPXuLRV4u7tREl7tGZ9Yhh8D63AZ6buABjjGFG
 YMbgSpCHNrsfD+qSqpMfLBiWI2sqa48RIjQU3eYjXfkWC5eI0e48UtW6nKXGkpMoXXLOt3VYo+T
 F6adRxnd
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a109c4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=1_qZpLKbntRvsT6nxJwA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BgSFYqesqazgidlttnAKppKcr13WEqY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

On Wed, Aug 13, 2025 at 05:42:34PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> If VGA and DP connected together, there will be only one can get crtc.
> Add encoder possible_clones to support two connectors enable.
> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

