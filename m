Return-Path: <linux-kernel+bounces-817464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C119B58283
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26147A7C95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18802857F2;
	Mon, 15 Sep 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxQU6Bdv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626401D516F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954924; cv=none; b=aTfX6lqhyzRF/idMJr6owJZzzcoRAMcfO+3WdmWi/kHLPlWQ84tFKl2EOTv8qwDfuhrhHCccafj+KBYfbDV8vntGZFfPRZD61UBEvzq2PdZ7uLN6G9wPpTTZBFQ8CQ2lRSH6nCSMqzc87RxNoQkWqFGJ/29/viUZkQpYLZN+mjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954924; c=relaxed/simple;
	bh=nwJS9qEspbxpq4mneOqDczMeT37Zd1vT1vWWj4f0Yq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk5EiTJJD2VBZZODJyY4qHnxken5RaKb5bHblglUuhL5QnorcZPnekQqy9MUOpCo2UQmvWYWSh/lhNJKomCopSR1hcYuqG1SW+1OHlEc0X+tjEMjggWqL2wMTY2/K03+lIDhDZmpMM4PHExtOvcvCFZoOR0HGkZdGFEkIiolJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oxQU6Bdv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDmBS7009334
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qtUff7GpnhMs59SKsoOJoYOq
	908txK1JBO9Lr8PYHXo=; b=oxQU6BdvwUMGx1j5+mNby8UAn33dYpCPFoKN635b
	BfxL7R8qHqaNv7mK+BjjmARUYpyrGtcNsK3jQ7qzOGRPM7Q+80LrGmnOIG6XPNsd
	z/vm8NYIVFHvOYDmQPaHfouDavEanDQXk7Jke2s1GE8Dw7jbNB0dj7CAxq5QLeWy
	iKCme+w5tJUV28LS13ifHne7uGnLzqSVHyLsMGPacquwAINQ+FkAw7eT9q+I9xE+
	9RxEHLAf7oxoai9dhRqM4kgw24ORMkhg9vohkGRmzSGaV719LCz0nOaJNBzU7HqR
	8vDZE/qEb6q2IJW/pXhvqYzmUDvYwBdzjvzyJn/NWWs/eQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpvnf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:48:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-776164a4484so51277216d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954921; x=1758559721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtUff7GpnhMs59SKsoOJoYOq908txK1JBO9Lr8PYHXo=;
        b=NHbLE/NXVKwnND4PlpVfJrJRQ5LtpVTBap7KISzqBbfmP3Bme2d4iZW0Sb8A+tbRzo
         kS9GM+EH9+Bb4PGLkToMXtqDWfIuZfCbqG9dGD3ytAxVQrFNdCMK1UXJsSG9xPI3SAa1
         QN01Dqa1XO9VXBSNEsBF06GkZKKaTi7MNS8huTN0JrsjPVtvyFGr8LGRIPKXTBcP+T/P
         my/7EfAUalxQbDUEsdLCWrdHDpkis3FHmPAg4494kwWxEuk9IGiDsMDArPvwLxM2cxcL
         4N/b27HTX+9U4Y1yxyAPL/bLsGN/L3AEDSd5mcYhmQxX6d6jBZPfCZEVTErcqKYhNdIu
         sfMA==
X-Forwarded-Encrypted: i=1; AJvYcCWDcpVkliv0YDpup90SgKlUkIIsAcwbKfd+3yZ0iSTG5acN5zLiUyKj6HCTA/7z+Prvy0MPTVdp3B7DwRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASzXaik1IctVpWkQpTrT2HtmD8EGBxj1UkCXqEEmbvA9JO2H+
	aXfmrvcTQ9+JWmhyC0po98gejvDudSSpSWkbRkzIwZ7zdaIEp9JGlSN5qZOLHMFyI3xdGX7f+Wk
	zMI9W61WwmwuITJv/IVZ9aFYChR7ohIa4Zth7+NXad1ynARPKxlUU+gfjmIbBc/Zt2fI=
X-Gm-Gg: ASbGncvk+IEm9Rv0E6Je5SRMNuYZEev3Ofdo1gefKE6mvGMYZAFsu6coXsudZ0tuTV+
	QB1mlcP6HIvzKO2dILdX7U75t6chsKIQcwXLzyD0LjqcLA2S/uQF+HBy534V3VdonILuQGrUHuv
	TdTdpg0T1540K1hGxcg++dUkmhOtPBi1p6KRtnV1iIJ6i+DJ8m/Djub01gc9hYPN9YPpa8RmjDQ
	KUiwDu1KWu9VOObqIHTx4IZ2rf8nhtpvh7gi3rKhqpaOxbYpgGyy6Eur6uiATAq4RZbtyZA5Tah
	V3cfxiWRAT65R36fuID5I12xfJ4cmc6gu8DfJXY7MAn3qrMqk2oKXBLK8xwbbKlDbVv7sYj0gvl
	FF56mmgs2t15DvEylgveBFdyTNP7CCa7DJBSwk8r+3zZcG00qF8aw
X-Received: by 2002:a05:6214:2a4e:b0:77d:3048:3b49 with SMTP id 6a1803df08f44-77d304847a4mr68275336d6.49.1757954920886;
        Mon, 15 Sep 2025 09:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH4oGx3bjTjrUfiUqVTWgspf5spSr1LkxnKsfsL8JVKYAo4+vRpO9aEEz/N7l6s7tfRKv4AQ==
X-Received: by 2002:a05:6214:2a4e:b0:77d:3048:3b49 with SMTP id 6a1803df08f44-77d304847a4mr68274746d6.49.1757954920255;
        Mon, 15 Sep 2025 09:48:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63c92sm3761483e87.92.2025.09.15.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:48:39 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:48:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8916: Add missing MDSS reset
Message-ID: <7slssvb2ksmmttzuptxgitc6tljswydd3watiwnjbila7aumex@525iupy4eecs>
References: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
 <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>
X-Proofpoint-GUID: Iicebj1jvv67psOEQH7tZnl-kUAjU3p3
X-Proofpoint-ORIG-GUID: Iicebj1jvv67psOEQH7tZnl-kUAjU3p3
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c8436a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=DXmGxE4PG6Zmd65NNY8A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX7DggqZV5UDGD
 L/g75YU0UW3kokACPL0vQBNHMou3TDEz4UP0y8UfCXm7bVAHm7IWPPl0YYCUTlYtNN0PIqICKH3
 Eh75vy7z4y4voBCL70ktLZ/k88KZPB38kzR5FNYc/MwyqsSYoaAUX2LADobG7AkmpTQa9QOhMRC
 HwU2FFMmWhBC9Fh1TI+EfspmJk3f5w+w3FkIjDEz4aXrUuVt4KicnOoW/7GY0mEk4Za2bYo/7WS
 MBuzaOKqp/fCIwQTKs2kMelh1hoP8R1QjceDFqYFgTYHIzjFho56pozu/MGOsovU8QTNA2Vrt01
 08gHJ3NULDSM0N2jZsH+noETtm+PFB05pq1G6yEGZepVO0JUlmHIJsT43xWhQrn0AC6JxsS5ToA
 ryxKAaf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Mon, Sep 15, 2025 at 03:28:30PM +0200, Stephan Gerhold wrote:
> On most MSM8916 devices (aside from the DragonBoard 410c), the bootloader
> already initializes the display to show the boot splash screen. In this
> situation, MDSS is already configured and left running when starting Linux.
> To avoid side effects from the bootloader configuration, the MDSS reset can
> be specified in the device tree to start again with a clean hardware state.
> 
> The reset for MDSS is currently missing in msm8916.dtsi, which causes
> errors when the MDSS driver tries to re-initialize the registers:
> 
>  dsi_err_worker: status=6
>  dsi_err_worker: status=6
>  dsi_err_worker: status=6
>  ...
> 
> It turns out that we have always indirectly worked around this by building
> the MDSS driver as a module. Before v6.17, the power domain was temporarily
> turned off until the module was loaded, long enough to clear the register
> contents. In v6.17, power domains are not turned off during boot until
> sync_state() happens, so this is no longer working. Even before v6.17 this
> resulted in broken behavior, but notably only when the MDSS driver was
> built-in instead of a module.
> 
> Cc: stable@vger.kernel.org
> Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

