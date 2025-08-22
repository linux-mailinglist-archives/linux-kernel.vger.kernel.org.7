Return-Path: <linux-kernel+bounces-781749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA931B31635
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89366AA4940
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE60284669;
	Fri, 22 Aug 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPqao8lk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD61E5B70
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861683; cv=none; b=I+9FVHHEGEiU0fxk6GP3+ZkRG/GZ52omHEdXfDbQkccFvRaP/P1f9/Pj+wXyqZEGgzeZCf5ivCPzsX9xabrqLeXX0ODrysFmgf6vrsRXJUoz/jFlIoqaa/bUOIXsEPZl4dbAaYBrm5aK1UVtaOCGiKHCCeRC1K/muAqA8Jq8guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861683; c=relaxed/simple;
	bh=Ke5Bs1RSqo7dH0bQML7IfzQo5RoAdNMuGyO5ShXHmUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJQ1iJeh4ypEsT9Trguho25Azwj/buqE2XqZ9zPmQ4Vfo/bcTqB6F2i2vfKefeNJTTVBTjhj9TNkKBghZiM8vCALMU6dYL5Mp2Pe85CqRMilSzF0qhXnkmuDi++zuJluaXpDr4FdfXt4CoH2mCuKgkGcHYXoJjdMC3PhIHhzoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPqao8lk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UlJf030778
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QOLeiRcyikkOXdelLFPCIu6K
	rPpr4gBP2+IVs5G5Gec=; b=KPqao8lkZItBexfa14dNxgB1nx8C0I7M8940NUOI
	xmTgTtKmyKHuInP/o4U00r4fSy6L+CNc8mXB8JqugryJDYw05opO2wyaFGtUd+i6
	I4pMwbe0wZGke//Q3YINvVxaRMGdo59WkTL4owOv2oI3xrSZIxgRO/hdVhtR/tZS
	IQojynUvjvBuE7vnxJJNAqskomWqSVoIeqgy4oUEXNpT+Vwr1eug1Xw+jKaZ6WL7
	x98qQkx6KSxOJ/F6NJuN5Sdbdv+ofa/OAtQI+LnwTxKib97cd9m03dser6ak2e8M
	InR/tlYGyqtg9PtxmP/gHccm3JiiDPEEV+yhSuL5lAOixw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdpuhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:21:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bd3fa0so20271121cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755861680; x=1756466480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOLeiRcyikkOXdelLFPCIu6KrPpr4gBP2+IVs5G5Gec=;
        b=e6e0IGUNebJRpX9gxeRRSfr2tlV6cz4uevOfJKrN25KZ4U3upKFNhQzK7hMuHgHaVB
         TkDkktupoPlTV/797sSJry8eoqU0q5eTLVBTxrsKC55FNJsYkbaLpFL9aU0/7b9HI9TC
         lNNEJiLP7VmeYsz2W36a0juRJybTfnnkKDWxpJYtyecK7U4CYRb6GYR6h9kiKA7FYH3w
         gJtgjrPvGxtWyxyEnHoy4Fznyx9/zZht5NfVRzhVe5bJr97s4BzUSHkHfoWdUbqgG+PS
         Mld1xcEPRfWZojZyrtvkkHeImsStSxM0+727bc7xMpML2LDYDldxLQESgElDaF/8oPGh
         3eVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9qxdTLrnD2/aa2Q+NKo0OO4pT1SUD45UuQxlulaimuqxtQ3H7qq+8D3vWHycfGwys8QCHWtR2IDZxWv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6shRgmJTGYAmsmJphTiHHR/iIZgeQVPCVyGD+z01iSCxDtuU5
	ftNib0RBRzzXXFXvNufQGbsZcRS3nIK5nO3vhhRMADodepHF0A0NTk8nTOkKUqxbrzlNlOZGFry
	z7vmYoO8zIaoKqwqaPUWAUl6blRqTl1aG9RwKWp9+As2VxIRxQbUMJCzQAkt/qQ9BsCQ=
X-Gm-Gg: ASbGncsV3flQOpEFudrktdpC0A/Do5qoq2IdO7YsrRrZ6Fu/oEXUixArt8QezDpLe7x
	wdTkzLSfyNvOozq7RtGgTttSfsI4PbOLNkZwXS7JcHXEE0Ca1/+GeW09MQwn+ZktnA1+uIXkaH2
	t19zc2h5mltUa6o4GwJf68ovJQxmE7btK1WO4/k1wO4HhKL5H/VldneYyOV6kdFmfs457/pPT7G
	36dhIv7Odeqak4k1hymQLZwsTVqzWI7wG6QTH00pCipK/9RjBVGnePoIUFD9NRD2FYcf9macPcT
	N5BpHnZTM5IbYSAzKyghVsIi6gvqjdn6ZuyjXtc5LjWvQ5Fu/uWr8vVmAwhDWKGYIVVyzDcFaJ5
	vlFFa2M8m2SDPgJdPA/Ep7Bgxmc+QZhQAiCS5GiZSrFypaoWJ5NUc
X-Received: by 2002:ac8:7dc3:0:b0:4ab:5277:a5ab with SMTP id d75a77b69052e-4b2aaa3fa77mr27327181cf.6.1755861679703;
        Fri, 22 Aug 2025 04:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEaOak01WwTjnUuienCHYk4SGhkFGQMG/CUgI7oUtTAemM/5tdVtKFnwof/wGNbh824CEIA==
X-Received: by 2002:ac8:7dc3:0:b0:4ab:5277:a5ab with SMTP id d75a77b69052e-4b2aaa3fa77mr27326951cf.6.1755861679234;
        Fri, 22 Aug 2025 04:21:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm3431010e87.13.2025.08.22.04.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:21:18 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:21:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/8] ASoC: codecs: wcd-common: move WCD_SDW_CH to
 common
Message-ID: <4jklfoinsr7ldw5gn66kmfh4vwl7hqrhvnodakirsd5vx4uzqe@axhf5e7ei5g2>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-4-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822104927.2621866-4-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a852b1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=g_yewJXOhfjxRz4zaJMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -JWO-CvD66QoUliAm6b4MGC7G4wTqdIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX2OiMa6lJvVik
 29XWV4OV4m6fNJIjUUi7gifTozttKCBSGAyif0W169nk621M+8nPRp3bdhgT646lZrKbh+39/Xe
 jmdVan5ma3petkih2she5aHG+h/vKVLv/Ki9oep8onbfQ1gM+CIirhlY0STsTSoJv4dH3V0XU7m
 KcwLrakQrslRxYr1rC5o2myf2Od0Ea4cj47lifWJQ07BDDyJ9iYiNyxWyerSgB6I2kt01M6GAYU
 C41HGMNI2DrD13Uf+MCOygT3Sp3Cgiyy9A7/AF8/yQdOZEkzukKYqCnT2x6MaUqFH2J+kCzUvk2
 PKm5SrKuh8wyn5GlIbHnlHD1FuBhYS4QoWnfdC7grkDw5F8Ue+8D2ZRhAe7ba5583GSD7zuNlT2
 WW6I2dAAtBOysrHEqWlbBtDe/Snv4w==
X-Proofpoint-ORIG-GUID: -JWO-CvD66QoUliAm6b4MGC7G4wTqdIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On Fri, Aug 22, 2025 at 11:49:22AM +0100, Srinivas Kandagatla wrote:
> sdw_ch_info and WCD_SDW_CH macro is duplicated across wcd937x, wcd938x,
> wcd939x soundwire codec drivers. Move this to wcd common driver to
> remove this code duplication.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd-common.h  | 11 +++++++++++
>  sound/soc/codecs/wcd937x-sdw.c |  4 ++--
>  sound/soc/codecs/wcd937x.h     | 16 ++--------------
>  sound/soc/codecs/wcd938x-sdw.c |  4 ++--
>  sound/soc/codecs/wcd938x.c     |  2 +-
>  sound/soc/codecs/wcd938x.h     | 13 +------------
>  sound/soc/codecs/wcd939x-sdw.c |  4 ++--
>  sound/soc/codecs/wcd939x.c     |  2 +-
>  sound/soc/codecs/wcd939x.h     | 13 +------------
>  9 files changed, 23 insertions(+), 46 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

