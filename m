Return-Path: <linux-kernel+bounces-880423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E6C25BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7EE14E7E87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312322F656C;
	Fri, 31 Oct 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ANprUrJZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ejvEsMQv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA02F6181
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922005; cv=none; b=KA67C9XW2yLYDege+gWy33wr/luVtc+AXsYcrUw/5zxiXXgb5DEjWa2VJucT+XwHdGH34J1i9WHKq5AdAODZjiGoKblx1tHLIZMu0LQmVXSXsMMiJOBI/KuKGeJwxpNn4tNj2XJmAHLVgVCc2vAAxVBwL3Q+aXZR/yk38GKCdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922005; c=relaxed/simple;
	bh=jzMI372OwDFBH5n8TtNj5NR2LY0KRBtXcDe0DjYy8tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLQzrOfEwossbpuOqtC3tNq4IwM41iBdr69FUaVcw2Fdtz2mWNu4pxTr9q6en8dWOTpsarOPgeQKYJPiWhAv0hevBgwWiJzg54E2qjMnqu/r84N0YZnyoUrie5lBtU3JW2tNVrtlbHSNSDmre/Or6om8QQQ1eLEloghJyOvHmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ANprUrJZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ejvEsMQv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VANP0D1513623
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UdX0k9Bu7csqPDyXGQIuEEoR
	5weAkUXnaL92NORs7r8=; b=ANprUrJZ8c+P74dfVD0Eocp3aWx8/3R/Mx7s/MT3
	18KdjD1DeCR5eITTnIzLd333qhJQhcQ+nOCOucQYDbTRjuzgDhaRs0RFKqc6YXHb
	V41x4xkE2mrMeQxGrCShyQf6lufLM9ae4dOiU6FcjbAuloW4Z0gz+npQ2xycjNY0
	lVkN9oUa3b4yoBOJMU2dJ3CQ2pK3UvT85Oo29qA4hffvH6pd8n9Bn92/YfMKQhl2
	nVZ+DekGNFEZ/VRzd6RT1Y+GraUwxiHVqO1fXGFvnXxvPRFmd73fQvZihW41Xi8Q
	nyOWkDSEJRIyOWJ5+Gr9pVqaXzDZcnN6vobaOtP/jiJBOw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69j0n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8a65ae81248so699717285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921999; x=1762526799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdX0k9Bu7csqPDyXGQIuEEoR5weAkUXnaL92NORs7r8=;
        b=ejvEsMQvgCcXBenwAfw/fzaZoGcbVjWLPMyvzV1+rQj9c7SrP8XlHTGHPozxl9cvdp
         8t/5o77vmrslNrRKOTsYQ/C0zzh1V1C0E1zEZKEPCmZ+i2Vi+mWksMyOayA7XP+Yowv4
         2Ccp7FUEWjBKN4zMXJQDP2+j/GOpf+Qy8r1db37AknFMTkEFb/coVQR3mIEaoAnGb2AS
         aTR4EWbCm+p96i22zRuc0uLVTe5i7ecF10OWfYRsm1bLLRjN4swDLDgSAjcQ6NYRtkn4
         sMQv3lX4CZWuu67KQmkjYGNJ6GVq/nxg0uA3utuz1fHG3GTGNjp9YxpoLuJ5oevgodxm
         llyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921999; x=1762526799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdX0k9Bu7csqPDyXGQIuEEoR5weAkUXnaL92NORs7r8=;
        b=KIRJAN2cRCvfME6N5QhDM7uCXlbKetL1fKM+0DviD/gCiE6Z04k64IXXPMWIDnowVF
         F6GtKOk0f0xgLIwZ9WCgr2lTn7uTjXPNhI7Wnx/lr/wE7NBcmhZWVIzWqrb6wQG6khiF
         EA0Rm7GfFp2erSzaGiQ4uofaUtQ3jPVEHG9weXnE5MnFqnlBakuL4rHaapH4O/5o8fnd
         5pDlr3KFn1v4lvLIpNqtcYz3vJWWQmwFMkP1/vpNtavWaQBNskgzZIdyslQ6GF7wLW7z
         N4VruavnA5Oz82COs7Vucp5xhAtmt21cfQNv/Q21XKO1CbWX5Fx3jgRPTANG6XF1BV2a
         +Fnw==
X-Forwarded-Encrypted: i=1; AJvYcCU45TlmmOPnGtTQ55poqt6A9XHUaRkdBOX/MRVtyR2NALVq6ae1UfOAKm9XuqO14iDRKA6rhA0axrUYfCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTY04EQOtQmYyQYYiNsqE9sLxxfZHKwauA1OovD0ebIov0IieP
	I5rIQqtZWDLzDKpf4lmJmZaXcFKXMHJA5h/69qpKrhyVPoqY/WLCUK2gaQYQeHcwECplwceYWWN
	t1MiA8sqkUCntDf0xrAm3ZIlJmdJl6P9UN1WOnbvhbH0uRKtDRRk0AOKtlWuAJqnW0t7YzqKIiV
	8=
X-Gm-Gg: ASbGncvZQVTvfN4D1dl/cbk/jRNOzXL3Lp61hXG7ugI/gKEX864RQL9Imd+HW75+QIR
	J2Oh/o16sCd9YBuEvp3kIQhkifUl6QFc6MJctBHowwTm31bxPKWcWx+oOT9ly/Q78eo7wVvvPcQ
	1kQdgnrYOqcRTokcNJE/aqogY62V1euhotYNE0JTRHq1I1TXLenN3TGIO/h2fI+tbKQgJdbmEqV
	exoFEWPeb+TcSII+mITjEEniUNMWgW09Md33VyKJVUbq6Txl9O/60o4Gy1z3b/znJ0YV+g0pIRZ
	6d9jwUP8Y7pBI2A5Zfn4ogrDrZ6+CSF7LvB0b5jZZu8t7+UKVxf9TxN0EpkSty4m9DhfU2bKQnt
	oUc/tMAppIInpRhhpvkYfn5FasQmCEqKF4+7cYwdhyPKAg/UdLCieh4IPKJfugIeXdW8CnWsBlI
	p4Yjgn3RRL0/+7
X-Received: by 2002:a05:620a:3181:b0:864:6609:2a13 with SMTP id af79cd13be357-8ab99687486mr417078385a.30.1761921998719;
        Fri, 31 Oct 2025 07:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi6GBRFMR5w7J7UxJRxg2+honWi0anDWZEWvntIfeGPZkEcmVDVsf45tO5pji3r2PVZfKHqA==
X-Received: by 2002:a05:622a:a6c5:b0:4ed:32d8:30d7 with SMTP id d75a77b69052e-4ed32d831cemr37045831cf.81.1761921987203;
        Fri, 31 Oct 2025 07:46:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1bfb45ddsm4029761fa.15.2025.10.31.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:46:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:46:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: robh@kernel.org, broonie@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, srini@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alexey.klimov@linaro.org, konradybcio@kernel.org
Subject: Re: [PATCH v3 0/6] ASoC: codecs: lpass-macro: complete sm6115 support
Message-ID: <dsgivtqhje3wnx2iuma3ngnq5kanmt6eautay57raf23vcxi2i@y5b3sg3mn5mh>
References: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 99tomGBmqB4PGcd_chRMbBrxh58WhC6o
X-Proofpoint-GUID: 99tomGBmqB4PGcd_chRMbBrxh58WhC6o
X-Authority-Analysis: v=2.4 cv=OYaVzxTY c=1 sm=1 tr=0 ts=6904cbd1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zc_iMHaRStx1I2ifTa0A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX+pD1jTbrpH+K
 vF5IYdzPMsQCxb+pzWoaNseSyO1109vw534MlsmPI0NMwlcnwi03LDKcvHBHcqyJKctS1M6Ibc3
 f98RpHKzubTqF/RvcShIEVeEYkGq1nB9AMwkuhl1l5ljladBdtjt1GI7isX2TcueSfL+ImZTfoo
 6wwz2yD7C1KhzOqxnE58REmYoHeanh0DumW4qqlD+4LmFNP9WrVWogCYvOxz1WUlsGBoE12eVCi
 p95Zg/j833jSJ67XPeQZbbY2IpczCVAaSoXIpXnrSbraA31LS7i+loNMBHPoyYTQq3yBGGtp8+E
 c/SB7pTJwW2jkxZ/27QS8n/l7lNMN5PmMHiVIXZq853WnmyCCTyU93dBWQ9NIGDrQnkzZfGrowE
 NiYQJsiRqZnVlH30mYDSteYGM2BR1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

On Fri, Oct 31, 2025 at 12:06:57PM +0000, Srinivas Kandagatla wrote:
> This patch series fixes SM6115 lpass codec macro support and adding

Nit: adds

> missing dt-bindings to complete support for SM6115.
> 
> SM6115 lpass codec macro support is added partially and broken to some
> extent, Fix this broken support and add complete lpass macro support for
> this SoC.

What exactly is broken?

> 
> 
> Changes since v2:
> 	- fixed a wrong patch that was sent in v1.
> 
> Changes since v1:
> 	- cleaned up va-macro bindings for clock-names.
> 	- cleaned up va-macro codec driver to include soundwire reset
> 	  for sm6115
> 	- updated tx and rx codec driver and bindings to have a dedicated 
> 	compatible due to changes in number of clocks.
> 
> Srinivas Kandagatla (6):
>   ASoC: codecs: lpass-tx-macro: fix SM6115 support
>   ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
>   ASoC: dt-bindings: qcom,lpass-va-macro: re-arrange clock-names
>   ASoC: dt-bindings: qcom,lpass-va-macro: Add sm6115 LPASS VA
>   ASoC: codecs: lpass-va-macro: add SM6115 compatible
>   ASoC: codecs: lpass-rx-macro: add SM6115 compatible
> 
>  .../bindings/sound/qcom,lpass-rx-macro.yaml   | 18 +++++++
>  .../bindings/sound/qcom,lpass-va-macro.yaml   | 49 +++++++++++++------
>  sound/soc/codecs/lpass-rx-macro.c             |  3 ++
>  sound/soc/codecs/lpass-tx-macro.c             |  3 +-
>  sound/soc/codecs/lpass-va-macro.c             |  1 +
>  5 files changed, 59 insertions(+), 15 deletions(-)
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

