Return-Path: <linux-kernel+bounces-882059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBBC29857
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 128CF3451EB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA26235045;
	Sun,  2 Nov 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ccdr8S4j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KbHtvm+t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157334D391
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121869; cv=none; b=aooQ4oqT4S0KBwW+CSvfhWHnLXImIMToZtnawEc5OucbzZcvPF5TZkx5uTwHYmvFvQ3JQWMRXSog5ohhtHOgPZFA8kLobjQO2s0iFu2lv3d8rcFDGNbq6LXmsfxTT4L5FgnqI7z6+VLwIqhAh4GxiC3E19mZFgznM5c44fo6Ujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121869; c=relaxed/simple;
	bh=tQZW9+dDgSbYnIuhOWigTzdfgTz+kJ/K7hAWC2M2Ack=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPf4ZpUzsMMbTHbzdbLZlUtUWxyOrNiPtTt3FJMQ8nToPg2g7Sk7HskvhlsPtYkryy3NgW3TvHLj8OQ6BNGigI8olSJ+x9pXMPwvwnHKJqk8Mynt6EGyCxfzEubyzZGKuEzFVTAI6dHHH1KfHYkh6y7FH+4MDgKcfgzkt/1PW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ccdr8S4j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KbHtvm+t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2Gh9Ro693803
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 22:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6JQo7wed00v6G2v2l/AOp2Cj
	244tmHQ6AbEypOtyoak=; b=Ccdr8S4jtGVwRZB1EqCZyOcZD45Ja1v8ZN2CFM2N
	WX+KrauHW/7Bf5rvzBmZpdS9jDxCqZWrhDXKQzBr3c3ZIramL2vIGwyBSmzYe1Pz
	MfIfpfX5U+hWZPouAfVq+4s98Nv/I38HLBzXGF4ExkKHDiw8Eiv/HWxJzD9r0bDm
	UjfknwDWyUNx3YxIcazRJHIiYr+VUnjQhghJ15F/W2BDkX4nGvbBmVwSFVOi/lvq
	ZnCDCIFYU8xh6wrTPGxmiCtLPRfDbQ4rvCEfoLbHX6H6FodbBgFoavdeg1/QgzLI
	1d9iJ9mb1fGLnGmeeDf9+wvb0ExSTt5ke9qpxx9QJszMug==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5a9vjq8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:17:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e892acc0b3so107288991cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762121865; x=1762726665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JQo7wed00v6G2v2l/AOp2Cj244tmHQ6AbEypOtyoak=;
        b=KbHtvm+teL7hEtUhqa2tWwTpJgL8EUjgsXlIfdsAroDliTTXkBqWxxyoazJLfQDLN0
         4peQQTKCA/kWMSmt25leM7m7953d+gvb2ExogqX6HOpODF2YevRrI8n3f050iZuYtHSA
         4eIHW4ZSZQGq6dRUQ1RWLjWN//56LJ5a1a5NuWmB5mo5VjDyRSpeWsVqAhRNUpqHPEyQ
         hbCjmJfruaoTIe7tL27uFJ3qZcB0nYDn/BWluhSyF24qMkcpn3luzRO44GIRadd1QCLr
         Cy5c5BDUk5szNcB3ZtIk1K5oFPAr9Ggo1ngEiFlzPYhu0IGaTP2RrbiGig0QQPwH6iKu
         0Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121865; x=1762726665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JQo7wed00v6G2v2l/AOp2Cj244tmHQ6AbEypOtyoak=;
        b=jvTPC2HFwkW7WINyUABAJoRom6PUTRyl1LLHP4AClUtE2iP7sdDPZGSEE26cB4RgYH
         6FlKzHUyJLMDbj5ZRj8NR6h0lGXWJ5yRHKH9TGXyXK37rrceQDHPPaGRnFcFYU9G2Cgr
         /LefRMYc++BvbaB3X+bVUwn92W9CY2EWD9zAMW/yqX15n6k6NbhsSeF88PF3qSaxtZRz
         kCJpO9NDICgoOyWQFz3ynVu21+vkWrzELT9qFu8OqhIfyhN1V7KsWM1FfMfyLgF7x9SI
         dUVigiilAwIvtXIQtwbueoU1R4m5M2x9leYJf2Ads+kOC+C4Nu8E3sKZI5SerN02Wj07
         BKmA==
X-Forwarded-Encrypted: i=1; AJvYcCUAauFp6CIalhMkP2U458yPscrn6s/VA2dbvSYpzSHYVX5h8NhV5PxhDtNrCBBy3fO9aocmqq1uafjD4ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhRY/vnNyLSB+NT3ZpyNgpxW3570OT60d8rmxjQOxzsoyyz/W
	qCzugf4IFJdFHcDw7ZTeZZ6vGMGM2Gg3O5lcm+AFfJY2cE9nrfH5Z73g5Iu5C+e5GirL7HU1ccV
	lYIdgFNr2uPl0d0KMpPRYz1fQuSz8ILiNpxM6B+dMxTNuGv9FFxmIJBaPYfR+dukRnU4=
X-Gm-Gg: ASbGncsQg3QVa4apyeUC0coCfGJZuzZ+KK0ImlMAoHqPl0LcLdUqZoPDGDRs5Cb/Xj1
	i4HpAhr3voGDLUguIOtH+66cHyWJFxI1+Mjrv6TpxwQmv8k+R1AHICe19D9Ezy2s7xYL8B2+q0I
	N0k0+JMWVcDC7fIM0JhCMHcztHL2keFq19YnKsxhGydTi3yVdjZV/TawJqwM9ItcS8GNpCAu2K0
	2Qkw+vNi6IMeohMkWvDPxJ107AJ4rp4hEekFs5HD3RomJnv9zG3u/lPdCOOHYuaTGhieXl0vyfB
	AD0thd2PJaLPH/Dojuo3/bwpOW/XQTP798x+1/A+8oksrBs0/sLbDt634NEX3Bri67ND4yXc8NK
	llBC3rKmu68SUNl0NKCA8MMwC8vy49r6YgoZ8q7/aKz9y/r9iD4ESWXVgZ7ckdNMEDkNxezbcv6
	wisWVOZ4hWd94F
X-Received: by 2002:a05:622a:1b8b:b0:4eb:e283:9262 with SMTP id d75a77b69052e-4ed310a7896mr128717041cf.80.1762121865375;
        Sun, 02 Nov 2025 14:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmAKJhop+j7hdlHiiGqRfXCjewIexYqqgeYXYic+LYuBAAh0RBy2NHdip4iwrCy+CDUQyPUw==
X-Received: by 2002:a05:622a:1b8b:b0:4eb:e283:9262 with SMTP id d75a77b69052e-4ed310a7896mr128716761cf.80.1762121864960;
        Sun, 02 Nov 2025 14:17:44 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59425f77cfbsm1328091e87.100.2025.11.02.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:17:42 -0800 (PST)
Date: Mon, 3 Nov 2025 00:17:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: maud_spierings@hotmail.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: x1e80100-vivobook-s15: enable IRIS
Message-ID: <d54z4j34qqguyqmlvgfy5uj5vuhlow5gk5zdk2xjbyrzh3gbvl@jbn7xyis5njx>
References: <20251101-asus_usbc_dp-v1-0-9fd4eb9935e8@hotmail.com>
 <20251101-asus_usbc_dp-v1-6-9fd4eb9935e8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-asus_usbc_dp-v1-6-9fd4eb9935e8@hotmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDIwNyBTYWx0ZWRfX6pI/BK76eqDs
 EQfEs2Qwk/datylJAt5YM7D89Qybnz+K6bgz9iE+gtOYrwWiBc3m2yZ1gscQOPTALWRizKxYdmR
 YuLLUhGAoBTAiTAeUiPSlHK/kEII7N8P7CIXZynDDfNKS0lVxqjsEcHtXM8t4zAL7be9jOEnOp9
 fk5yLjn2hUi1sompeXAhy41twyapO9hA5UNu9DtEF4Lzmx8vOmRb2M0gad1CLbH3g+1nZFdu4rW
 37fNpTjGBYQTgq3cNruMAP3QpN9QyOYp/ZExxlaWrGIaJE52A/LQgwCTlp2WUdQJiephLGYVdPM
 V9Vo+RkSyLV/WHseQa96onvn/HIm4p2hF+u5IK1kyno7JEzMMYwN9LFsCvIdcRTFCxMOxyu7/qg
 CLm1YFtOFte6mbHrFj+L04f40U16tg==
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=6907d88a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=69EAbJreAAAA:8 a=EUspDBNiAAAA:8 a=GX_lnnJ6PiQ3Sj9TFooA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: ZsNSkZY5Rlyd0_HelQiLcHYWw3qszgcd
X-Proofpoint-GUID: ZsNSkZY5Rlyd0_HelQiLcHYWw3qszgcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511020207

On Sat, Nov 01, 2025 at 01:54:17PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> Enable IRIS to allow using the hardware-accelerated video codecs. The
> firmware is not upstream in linux-firmware yet, so users need to copy it
> from Windows to qcom/x1e80100/ASUSTeK/vivobook-s15/qcvss8380.mbn (just like
> GPU/ADSP/CDSP firmware).
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

