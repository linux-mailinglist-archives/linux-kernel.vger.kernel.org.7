Return-Path: <linux-kernel+bounces-831643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA1B9D381
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829A97B2A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B462853EE;
	Thu, 25 Sep 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSnJ43HS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFE15624D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768110; cv=none; b=LvUWqQtZ0LGd2YkarGNDCuePSEd7KMZr3f5nRfbvHc8+ChXA246jUy6Xj1BmGMJ2fdfmLr88ckgZ9XM6EZE1UacGmNHT6P0y46Zv2Jbra6T4aRu8IyzH+m/6qGqxMVWufi7F/I/3bMkfB0rP0KHPC804SY9WwzT6ZXJOa11kJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768110; c=relaxed/simple;
	bh=7ciLY+0WA0WdD0zQWgT/kOVB7yzTSooA9pRCRJa2KjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZiZ2/9JEt9zCPgy462m8m1xfJOoiHRdnNQF194zbjdlvBGBqSF9YwOilJOgFNn/2+J+on+U3evveXJOw9jByp49wOQIGYIwoyB+XFYpjLW9dvPJbHSY18QoBFDeL08828Xg8RZCZMIgRJpl843zgUBKvb6vrHH+iekQP/+jjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSnJ43HS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1WOhT029619
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l6roaFaJv6NtbeRVgfZ0Cnfu
	GdOUptJbjLE7JsJv3w8=; b=SSnJ43HSGLwhj3vESbnNlRYDklAMDge9yoR2l7zA
	OtvGAD6SR/fR8ubEgCByKraNYx1yzfG7UkX6hg6+B8LCuTYmfHb/kNOvmRYVyz+Z
	oxytUB0OEwEUUXnSQmW9QpxVkDE53X21B+uDSNfLV+nALUbOz6IZACwN5Xz1785U
	LHqdAX6PvtQlIS5GQppRQYBgI1BBxdgr4ioO9OmLbd4CHH44UWL479Q5vzLTDTDO
	X074lI+OZ5wBBnrs6Lu+E1vDJ9LhtNiyxKkRb6UrviRfZCV3f050LiA1vJ5J/e6L
	fVKR+et/FSVFgne+ABNUgDY/fVw+Fy70ABjPiaXYgE5MlQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpbyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:41:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d435215956so11520981cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768107; x=1759372907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6roaFaJv6NtbeRVgfZ0CnfuGdOUptJbjLE7JsJv3w8=;
        b=w11Bm97GZwELgYpBEJaXKtlc8SaaHOSU/SHfD+U+a/YovP+ZPxOYigUuPtGUV8qG/O
         YjYoovfL1bML5ksx5dpPf3df6V0WbCyN/gUPR//YP8J6XNN4tMLwvTJtXOkWpCsELXWl
         AlKXwSOVKTTHgd4l9+jF+/6WCe2IRcZsclY3Anvq8bkPLqOCvjECoURoLuQwxFsBCEAa
         W414fEMUctuoDGA6/mjNpPTJo4zVKfKE8n1634mGfEiUIcoBLJb/UzAS9cUu/KWccncG
         F4UvrbJUhurgQUM+vMdMBamL3GpJ6iRLf8mmVIWH8OfgGAri2gYKCDfL/zIb/X//JfJW
         PfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIpkctG06IC6slmdFNZHXIMQ76Yafx5ak8kiBwtwxVA7/fXKFcEIlVa2SSpxUA3S4RwQikr5KVHC7LH4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsWiclmRJ2v0oEO6OBEEHYypSQQGHfMLxeOzQIzd6ZhzzqVk8
	Hd4Zu//vbAkorY/xFl1oJAUwyIKYgneKjdNRjXOVp9Gsr19b2s0J3CbV67+2kCQh7vZW3ORy5Bc
	hcgNPFk+yBGviJJ1XCMfSQNDWcqGR3EeV/ytfetpUy/vutOJgf77ITjXVMreyCGtqKpI=
X-Gm-Gg: ASbGncvhniIR5bXURUyZFCRjF+YdHDjPdi6WnEnISUC+iZLPpbSRuqzcNoQ9khg7rQ9
	B9daYdKvF2I9NHm3BP97cCZNEE+3J4d8oz8d0caP45JHzJVKp0UgsWQXoaNTSvfTg+cG9L5Mrqf
	Xt/b/9Lb6C2UypywWchGvftPf0yqpHUfivLc7q4XvMEKuSjaO/ghvVMZxQl1D3b49R2uLH/CF4T
	F4pZEvHPzY81KYxQTDRcj0lNgoz+b5zpN3grwk5O7wIGHSdsFIHRqSg5l50NDB7893OXQ6cBxRs
	yJRIsyEhLlZIp/8L9L26cSFL48KGf8GXVho1Lhau1qTGlU2we6rkQoOAiMxzeG79nH9eTW1ox+n
	cr/Rv1vtpTs1ziy7ZHxEYjTan3ysX/znWeNtROleQAOcbo3yMmTkj
X-Received: by 2002:a05:622a:1886:b0:4cc:48c0:adfb with SMTP id d75a77b69052e-4da4782a6c3mr25545181cf.9.1758768106550;
        Wed, 24 Sep 2025 19:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKT8RyctbGQ3mP7DDb/CtYIWh4SsjSRD24MobA41ee3lV6NyrPEs1SAryjLLGpuLO2wIFF+Q==
X-Received: by 2002:a05:622a:1886:b0:4cc:48c0:adfb with SMTP id d75a77b69052e-4da4782a6c3mr25545051cf.9.1758768106092;
        Wed, 24 Sep 2025 19:41:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe8750sm2191921fa.66.2025.09.24.19.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:41:44 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:41:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add RPMh power domain
 support for Kaanapali
Message-ID: <fd234vzjys553445l5a2hgdkwoe3gub3ubjzhbmtuljjz3ukvi@y6irjcva5de5>
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
 <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 709We6mxJaWZQEFZapqkin4P9bbyQlaq
X-Proofpoint-GUID: 709We6mxJaWZQEFZapqkin4P9bbyQlaq
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4abec cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hka-zFMH_fk-WL56CYAA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX9npdisxLkX3h
 GOxuT5ZEXfMs+bZxgDMc2HDeJ1OoVQdSDMDKtTcDepFewuHeVAthkLw5kyD5rGwFAxFcMZXOEtp
 rKZlIL0XQOtwwL1HITrtFPOZPr53RJFi2vtm15AyBBbo/ZymYldK4p/2EVZJBBkKMNfB5r4w5QY
 Lbj2FpAJI6g83kFJ5D4th+p6ry/RDA0lLZyPwXNKccdi+PLAwaZ6F5omK0Q/hZi2foMJpFE92ET
 GLVAbfkGoMRxA/Vma+/ttZfxlnXWiQmr3YBF/wXW7iKrRFnonBptLmYV8JHFESgMkTOnJ7eAN7J
 EPBa88VLbLLcXsc2IXn6O/5RvoDSyx2WFMmaK48K/uOumdxEDEL8Hj/EOS+pt9C7b4JhKR5/ArC
 Uxz5YbZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Wed, Sep 24, 2025 at 04:17:08PM -0700, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add the RPMh power domains present in Kaanapali SoCs. Also increase the
> maximum allowed number of levels for ARC resources from 16 to 32, as
> needed starting on the Kaanapali SoC where the ARC vote registers have been
> expanded from 4 to 5 bits.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

