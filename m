Return-Path: <linux-kernel+bounces-818631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD2BB5944F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A818E7A45DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078522C031B;
	Tue, 16 Sep 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7B0bIps"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCA217722
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019871; cv=none; b=JI7OTsS8L8Fb9Svdg3yCIF5HoUAM5eTU4ffwYbwiWWdi4zMifm+d+pvlncSZb9L4NHTxQWeuiLg+g1pvj7Wrp3VeKT195nVFsmHEcfkK5AO4m/sN/wMUiKiCj7nd/+kt5wogp5moZAPGn+YUPowmxjVbJz7ZT5jsXfgULdSpb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019871; c=relaxed/simple;
	bh=kEfwWe+VHc/Nr7dgeDGRdbm0d6c2a2tZk6u9cmKA1oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9SOvukmeqpU+F+GH/bw+Ke0YCDvX9T4KdF+e1FKeFWi62ss4ZJWm7iSmX3jPuFbmwwI8zr7dcIq6Mksv47sN5BPiVH9xHtweDxyc5PD7dLxlgVpagOcPcUNqyF1f0nKvm6FDjmjsdGIl5ubSPChGIlAlF1HHqRq6+QIdD0H5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7B0bIps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAQdX4012753
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2FWNiMd69SOkpVvXV5XEQpKz
	vB2oZ4Z/GeoK8cF0vYc=; b=b7B0bIpsG/JCcvNB2e1mtJylW/6MvvYxPj8AdmLC
	ieflZFyo1A83dp43fAOjOyV5DvEXR0mRAs99zMGkPdhJcwzcO8iRPBGEw1b9BVmu
	C22vowFK6Ndu46h1AxG68eC0QfHDvDxKgPHlAnU2Y4/I2Ec0m9Cg4Q5Xy4g7ZYfi
	yPWCq+cLnISH2WA8olDxyROzISdm0SVfqY9iJIzKz688waklo4GcAtPd7IncfugF
	3F4ycxVBMea/B3xLS3UCL2+XdL5/lf3WxSSjjD93m0V0W3wZefv31Zk9uMdtyarA
	swQBL8nFyrcP8EOPCc0a1R35Ym9IUrCQLv2S7phXS3AFaA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072rjuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:51:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e178be7eso149297411cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019868; x=1758624668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FWNiMd69SOkpVvXV5XEQpKzvB2oZ4Z/GeoK8cF0vYc=;
        b=lRj1jr5KXQ4O1dc6NoUgUcnwqJchuHGJ9ISC2hZ2ruenJuq82f9iEVs0dfycxJNBHJ
         F4ySuM8Oh9iDPF25TcIDlBeUPO89UbXiMDwsf+HiOUNgabeK6qqc4l2tSPj9SGeZyw0o
         8lgdE9HMF7KS511IATjZ4Vjd3YAqXezeN86FnwCzgqXrgkD+6oeQpBQc9pIzwaMB34Ek
         4BawMeZvYaVRmxXCAWzcWt0ERi2rVAA1M10TeqDxqrV63LIhxRkfEguo6l05qqwFs4Nh
         rRPEdeNUqU8v81HV8qTZQrkYcwG9agdhVO7RImXUDfEqSvH+UVkXyjfQr5OApwrfv8sy
         aFMw==
X-Forwarded-Encrypted: i=1; AJvYcCXlZ6TMM/7huc/F/wpsCNTB+JtlKiaAxyBDgIgpQjScpSau87KdrX/FFRNa4YcJqPlxOv7xk0ISfMiK1lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wU1rkda9GPO3tK9kq/bSHZ4gg+Ua8HECJke9anES1PqU3fxy
	ynxZxUW1FcDaDpwSf2FFlauijMmqJCs2rRgaPmiaFEPIgdeOZkGrSSuT0YUj/GVYVjzihcu1DzO
	LtB/oTPOOjLZU9r7wfWkhKpaEN26Fym3KP7Wsy8zY3PZChksAro5R3648GBmtpoyGi8I=
X-Gm-Gg: ASbGncufLlkHFgAmo0wqNbaeVwBuGiBQqhpXnpYqnvmpB/hT3w/KM5Lz73VGPV2j72F
	aWl+5opRkXYN+gNcnRb6AaaNAAaK5oEWpu8D/lV+KoPfC5aoF7GdX6eHZFOmQUU5ULVju1j6Det
	yP3QdzdNXMhGi4A2JUXFqb8dWAUF5smBRz/iwCTyChOUHKzfJl/ywNtWz5YSS8F53wUFzwNUOQt
	48xSXRWkTBJP7f3FLZfmNbWNBor9LGWamEtIuu6kSbpucauGcDnJk34Zhw7hw05sbvKzim1qukk
	X3SZ1/19JUI9SPDUJWvOM39e7AWKd7ozNdsn2OoMvrmtbAyzsaDV7QL5rP1wMxU76R3MTr1O+tN
	pSeLNfOEypJrOtQN7/dhzsvAmOOC9baJ9bMuUf1fxj+aNZ8DVydVc
X-Received: by 2002:a05:622a:2617:b0:4b5:d70a:2245 with SMTP id d75a77b69052e-4b77d12aedamr217457121cf.77.1758019867416;
        Tue, 16 Sep 2025 03:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLdtaBJl4Dq2wLZch+XJIZbmZ+n7DyR5fUUJ0r2GfTbCwlwe4XzrdpDgcxuCfKBDWHawqRQg==
X-Received: by 2002:a05:622a:2617:b0:4b5:d70a:2245 with SMTP id d75a77b69052e-4b77d12aedamr217456721cf.77.1758019866821;
        Tue, 16 Sep 2025 03:51:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5dba7604sm4325333e87.59.2025.09.16.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:51:06 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:51:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>
Subject: Re: [PATCH v2 2/3] drm: panel: Add LG SW49410 Panel
Message-ID: <tu26qvyzihyknyzjeu3ycz5fm5mddlvmw776tjbqy7qpguq7hk@unfyoqd65azd>
References: <20250915-judyln-panel-v2-0-01ab2199fea5@postmarketos.org>
 <20250915-judyln-panel-v2-2-01ab2199fea5@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-judyln-panel-v2-2-01ab2199fea5@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX6N66y7cw8oVF
 rJ9lG/Rgm5U0I3AeG1exjE7UzWEvYA1zjDGYYHIqiYZcoixrh1x7+9h8tdCexxf+ND+uL/16KEM
 5LUWFge7w7G2apgv6YInryrbKuM/HY9DnjqQp8Y5sOU0/Ve1T2eWayYxsBXUGoj8KJNhiYXwSVZ
 QD25T0fw6Y+BZg5x9h8hMcG7tBNvXunkq6NiUiT4vveIBykmyooF+htEw1YJchL9J173hjyvft+
 ZOvOeT+VrpWY2HvbQ2zjZXM0/IRUfdNiImi+n4/Vls+dAdT4XA7DAjJokIg0yvx5mSY4Zfkzheo
 sM3wd7w/lZlp9CFcXSva35fc33IfjXDPpuetQ0ZysSp9gfzY2hl3UvG2eSq2khwnclIJ2qoRRg3
 e+GsN7Ui
X-Proofpoint-GUID: 6oEhJg--FrDEsJHJRYGh-boHUYMQUd5L
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c9411c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8
 a=XYq36MTTh7cM02dhETgA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TvTJqdcANYtsRzA46cdi:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: 6oEhJg--FrDEsJHJRYGh-boHUYMQUd5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Mon, Sep 15, 2025 at 07:32:13PM -0700, Paul Sajna wrote:
> From: Amir Dahan <system64fumo@protonmail.com>
> 
> Added panel driver used by LG G7 ThinQ (judyln)
> 
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> Co-developed-by: Paul Sajna <sajattack@postmarketos.org>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  drivers/gpu/drm/panel/Kconfig            |  13 +
>  drivers/gpu/drm/panel/Makefile           |   1 +
>  drivers/gpu/drm/panel/panel-lg-sw49410.c | 502 +++++++++++++++++++++++++++++++
>  3 files changed, 516 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

