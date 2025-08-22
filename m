Return-Path: <linux-kernel+bounces-781755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B79DB3164E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988F0AA0AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8F2F83B7;
	Fri, 22 Aug 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2eJNvS0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077B2327A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862094; cv=none; b=Pwoc4YhTEdwrv7cnO/tT0Fk3LqgIl3V5jiECXyoVk8bSR7jvQrPu/3Qc/3JUnoFCkw+3jnRr4eJkXjF7XucvAR+30onLmZ/ot5NTU8ZlE/wEgMozMtnYbLsfeOhd1LyonGo/wQ8EtXQHdzlG2zPIjJaZWgaF7unQl5qe4E82a1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862094; c=relaxed/simple;
	bh=+z1J6cCjTp4cVVZFfPJQaGcyBnTv1CpWlH8yDx6pxfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx/Zx5rZxdvVIc5rjfXbTZr1sYj76HK5nXorYZpnpwmefQruRHCfsRbhIKaHCMTz5Kt54PigRpIxjE/9ieW8HwOGbP6u3IVY1iBRNxKgXc3YvFWs9F2sNxsbpQ9CSxz/9i9Fk8HVlUXm2ZEJaysluEpwvD6AkVQCldGZzlgQEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L2eJNvS0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UJB3028627
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HQz9YlcrsVzVP4cHdjwrgDoS
	WKhu5gMFDTaj+Iok/ns=; b=L2eJNvS0zWsr7Q1hBIQQoXynFZf0P6WCQv4SNOS7
	BWWrgCtjA/3wxq/M816xosxDI4D0lMXphZ0J0HM+zZiTgoPIDML1Vbr2jfoPnNnU
	rZiHWfKzKIRZ7IQnmVNSTLWAxcRboXvmTQuFGH1dtRT5aHzBK7mjb8XmpBCafvhg
	p3+9aJqRBJvZvHDCEg5zwBdrk05TuY+2ATiB9vsfajakJj0Quv422whZsMjenXzD
	+tTlkJvkI/v/nwMnA4Vwod3Tuk2xEZEPq9rMNEq3quYWuM1tVY/dG1LfrBU5xxuZ
	FcawWBLMWfgmyIzTeQiW2cK8z7nASWRt3xBvvCOoSg/ZoA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cs0w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:28:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109a92dddso58886851cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862091; x=1756466891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQz9YlcrsVzVP4cHdjwrgDoSWKhu5gMFDTaj+Iok/ns=;
        b=aSWerqtwbQ1JGXQs+14T52QcpD0L4HfVFIGCMr6GeNDvBgSgljH+mFJWjTdFYD0epS
         JgXhDP8nMplgZ7u+1F1dPeVvSEoE4cpPrRiBLfzdxEjisBRB1e3kJxuFeeJJBoGffbGB
         CHbbE0CahvysLkfOEE473s1tB4bIYFKV26W3zaLBoVbI7FmjWprm1SmyFAF5B+JayvQC
         qKgOkBWScPKGsh8q4PzzhRep64q401BWh7Wi/+k79gqgsFcEmKE0ZnFFmDnjCXEXQlP7
         WlSXemiJ1wlquY7zPpvwYMw9iqTv93JIyuLC2qh1xtdxLoVvLpAuC6AsKu81KxD5KVYo
         pL7g==
X-Forwarded-Encrypted: i=1; AJvYcCX+lwqX8C98SZb4ZsFS4a607UWvk3VUVRwlEf4wE3p9oeNUu32VvYFxNgBPw7dqx3TDDeDIburmc3S6rYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTWz8JH8sU+z8LCUxFbcf5IpxmAT2FAfok8L9QYHQbH/n5q82
	xS3KBiaqHCTzPk7edOg43ZtWlodKKQw1DCwYaKTIvLY9241jn9wf7Pr53yGNNcOygY9VVZVW54O
	5UHkMC9qGykieTbokW6oq0eBUV/AvIyBvc+Jpc5c1AuSP4/k8QD3PDrHtsiD5eZALAoA=
X-Gm-Gg: ASbGnct/gBnbq55KB2keeB22PiZujSTZTYvRwEQhXjsja3az3MYKw4R3CjoEEwPa4wF
	HhhjT2U9Q47nXQdjze94+6sRgOaP3nZB1nesKoxVs4Av968i0oKwgtIVeJYaj+NXUdHGnmCmWKh
	FDOk760LxHEDgruAgIK1mv9uTtO9xlBeorpXDO2FjvoHs8hgtj/C9e/z8xNNEmrgiNvL98fyWdl
	cXOaRBdVc7YJmcdgU/XbKXUP04xc2L0bJJ/dM+tfkZnETjmx2TI61k3gam9yyTi5o9XjaxP3TGU
	eAIJ90QAGHgbQwQTuxkI41dMminfdbKN/i5FxODVGeyRoC/NnokTMoHLvdHsVsuff9zjYoqppYM
	rzVqsZPjN0YR8kNfNIUVObdqw1hcaYpuDmaig7jzQRXgi77hNv+LA
X-Received: by 2002:a05:6214:d07:b0:70d:731c:c81c with SMTP id 6a1803df08f44-70d971edc63mr31908146d6.55.1755862091055;
        Fri, 22 Aug 2025 04:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQfRAzVUKYrkQDCJSAkHkG3B6Hn9CCgM8N73vWZyOY+0UMPseinW2ZJn20zITdxr8y3MuBqA==
X-Received: by 2002:a05:6214:d07:b0:70d:731c:c81c with SMTP id 6a1803df08f44-70d971edc63mr31907706d6.55.1755862090515;
        Fri, 22 Aug 2025 04:28:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a4742acsm36642481fa.28.2025.08.22.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:28:09 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:28:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/8] ASoC: codecs: wcd-common: move component ops to
 common
Message-ID: <mmheu5fctvd47gmwilievo27suijuok7zr46qz5acti7vsrpaf@osdoa5ouaqwn>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-5-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822104927.2621866-5-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-GUID: ibsyfE-yuUSpalg3plmtILQE51oDh6w0
X-Proofpoint-ORIG-GUID: ibsyfE-yuUSpalg3plmtILQE51oDh6w0
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a8544c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=DUU7LNq4FxFGKB8gttsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXw/t/l2zT9mG6
 57/ej5Hym1utD44fb5qp7nZ+CF+wH7QsizgMJzbi49p6G2+zcLF8u4/6W0VgHIL+gfz3UhNeTKY
 AvE2eB0xvKYVfbXsOQpBTreFNPFsajPRJMXzs8wyicN78ZU3YntVL3J0e2dO5TCSmws8TS9TZ6+
 vjNY5LgVn3q/CqiyE5xHxV841SJ0yv6CizKMxPCAvvS8hU4f1bQX8KUUiLVZVlIpJ1T0ud7iglY
 u0R6q4A+2wq3jo1G0uUgusqNxJh4vnyAP1IQqYzSzCfHPFB24pbgEybNewwkZA1gIg3HOnhclQL
 hRls1PaVbPceSZcQFdumZ3n+2i+lPfA9KPNsqqCJYHBZxLCzcKjTY/0ToOtwp80wuXQHsEuJ7Gv
 sEQTkJVbjBo1GWKtzMns0C9aHXeIXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:49:23AM +0100, Srinivas Kandagatla wrote:
> component_ops for wcd97x, wcd938x, wcd939x soundwire codecs are exactly
> identlical, move them to common driver to remove this duplicate code.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd-common.c  | 27 +++++++++++++++++++++++++++
>  sound/soc/codecs/wcd-common.h  |  1 +
>  sound/soc/codecs/wcd937x-sdw.c | 29 ++---------------------------
>  sound/soc/codecs/wcd938x-sdw.c | 20 ++------------------
>  sound/soc/codecs/wcd939x-sdw.c | 29 ++---------------------------
>  5 files changed, 34 insertions(+), 72 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

