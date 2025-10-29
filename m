Return-Path: <linux-kernel+bounces-876036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B137C1A7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5482189026F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3634889F;
	Wed, 29 Oct 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZ6nJaY6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFC8fK/a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E92347BD7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741304; cv=none; b=BdfQVQp1D/5zB4UGphYl3kGz5BZ3ykef0yb1Qe8BYCHkuash2aO52Er7cWt1rGLl7XzO5nE6sevoyDBj47wJKgMqSIMjd4t30szN2Zi7dT7FUZJBwJ5ajVOWQzZtNdpt7gfZW9RRPI3PVU2Uio+gWXoEkzfGjpTr0HQv0VEZQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741304; c=relaxed/simple;
	bh=dnKBgkT1Amxz2EOcqaHGfJ6KsEaQ2Zw2NCM8IZjdjvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1aqtqz8NjWEdG60OTtwO4/4ijzE4tf9+pTtUlM5wu1HFg39gqS+u+44ZFd4yVLBNUiQtFe3yGn2mxtNyClrxRM+aFmN3xAO/GKKoxBPd3BSbVXZgqe2buU6HKG2sSsXZJwgdzPzT2MHmPIuU4Jwyx2xQcUTMUgiRQX8w1JvojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZ6nJaY6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFC8fK/a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TCQCGV3755502
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IfxBhg5EA7KNG33hDreKmS9S
	RAlwrx3aLVwNmvAZprk=; b=MZ6nJaY6z1YaZe5CbP8kvziWuXbRFcKTxnHqMQBi
	nxND2dtzHlBuxNcHZxE6PZAYa8+d/bXE/yyiJZ9xeS2khgahWdwlirCIUzxINVNZ
	8z0yYIavabj6XgRYCKLifhXJ7TgZjtiMtSKo4sFY5C6l2jTKVXvDCBwh1Lv/mxqf
	r+O+iksUDFN8C4T5VnsbR7MtmhzsYLfYyq2IwerAa6AKutp3Fi0A7OuV27AHbRKD
	Fy5GQzCtf8Xl6DgPrq8Dr2WgcWRmrqltIyySDixkjIiZm/VlJpyczsv/+OIn55Gq
	WP4j8RICXbt2Ds5KmoLocJ62BTNO0kAdNa4iEtF68K+mHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0jgyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:35:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf2adbd3bso27032501cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761741301; x=1762346101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfxBhg5EA7KNG33hDreKmS9SRAlwrx3aLVwNmvAZprk=;
        b=DFC8fK/a6Qw5a3T+qxcsGVXxZdgYFbRWmgYoiNf/94YsQ6uzX6uMkoSuifa9YkZIvv
         0b+C5qoGzFd9j8uBk8of40WhAHF0MQI1ddclJ5WDRkPnadipV2He+CeMNn490qLd6kc8
         00iEahSk+PTrv+11St0LeH8oAw6UlwyDEMeFYjXxO6BngESxkkAm8PZvu1WGnOYnQ9Y0
         /kQLLvWrmCVlktZLBk5qf3hBamdf5eHp1Fop13c7DOBPsREySmmkuB8y4lW9UUyj8tUI
         o3J4DIW0921YZN/0R+DUm98ggTQuYA0+ewQ84W+ybY/kgJBHZZRWU/MjVbVmyxoZphD4
         WLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741301; x=1762346101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfxBhg5EA7KNG33hDreKmS9SRAlwrx3aLVwNmvAZprk=;
        b=ZIF54EqjUpFEiZX98/X6fDH5kt32rybUaiBt4CjJsE6lP6ivsmJe0vSEqq46weUnRb
         EpYtcvsJoxUb26ERKhLkk2o/Gni3GlK3+GGqHYUnuPIbvEooGB7kI4RN+ciIc+dyycsm
         MFsEOkKZrec4Cx8tjYoXe/cGbd9M1T2yKS/pZ5NwCcwYaFMWpSWdE2L8VQVwQTnx/C4B
         r5pnu4777InWR8gUtT+zSHEnL1A3yZC1lfxGztlBEPhXL44XIJ+CannEpRjBe3oZzi6x
         vbYLFGN5KpKnWDJJhys0dLpVM0MBS6jano+clnNTCm0UonYunOt3CsOSbnoZEB//Dz/l
         vJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP81hZQLNwGswgs+xjK2113utlGpQVcJH+WVbFS4CZUKygd3RBNhCDGy+ZxuFuOJJF+IRn1t3e2oia484=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhVDpmNfjyrgmFIRPr4COxtyLzXD5TLeH5JW9KxCpxegBmNc3
	5EV3gSYU3z1Atp9w6YTEo76Ryr1FJD8NWJKpxbaJLG6pP5Y4ggcHTUdFfoKbKS/4QV/E8AZElOa
	9dRs+tVe1EJJVbrhBIuBF4zmhgP3bTPl5eYtwSI5gjN1sGD1MMnN9m+tv5R/TkXN1/vE=
X-Gm-Gg: ASbGncueyfEIhyvh0YkFTdkwFE72kPtbRGGLl2g2wjSL0Po+VHqrTuyq/fcLlp/uxIi
	d/grNaPLoWM0E+7v7662nUUPgYtzA8JnpNjFwZExWcscVzJ15cRb2h3rXvJ+X7ifPUzmNejbEZY
	C7wDguvKDwgmTrANTWXpzIRqJD6MjIBjohR2z576BgvYslh+dECQ3ZhfCB0KS7B8BPOdLeALQQc
	xFOZtP4bWvcnbkr8eK4ugdm/gpZVTYUwaz3sajZ1HoAt04IqHPY3HkllA9cci0lZoFVao/e2iDF
	GM1UUtImXnMO+iqxhCRjKHrf/ztkEkd3tebfjOL2GMi35iKRCHQdUsQndqwUs7bPcHYBXHaxe99
	AEfp+MME5Wll7FB05/ujSs+4R/oGfLB+tieSncw4c8GOX8SNt0+4C9Wgu7Wj+RLk/4B3P/TKVa4
	FpxucEwierNROq
X-Received: by 2002:a05:622a:14:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4ed15b552aamr36075261cf.28.1761741300982;
        Wed, 29 Oct 2025 05:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm3Q+dGlW8otQlZhFsV0mtQgmLxmSohXRXXVuIKe3S4ieVAm+unm8XOsCtG+LLQlVUTpOAZA==
X-Received: by 2002:a05:622a:14:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4ed15b552aamr36074791cf.28.1761741300397;
        Wed, 29 Oct 2025 05:35:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-593041884c9sm3457534e87.96.2025.10.29.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:34:59 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:34:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tessolve Upstream <tessolveupstream@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
Message-ID: <sfxvtfzzstdbt7in6z6ztsjfy6e555fr3sjbi5kqkv5sk77b26@kl57zs7iuuvk>
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
 <d05fe82a-640f-4a09-9d83-39bb5aff179d@oss.qualcomm.com>
 <9208d2ef-79da-4e80-ac1f-e01fa5feae0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9208d2ef-79da-4e80-ac1f-e01fa5feae0a@gmail.com>
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=690209f5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=AN02phsTtlwncWaBwlYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 4vyaGmzaqZgtXHLljz09mjKbrg6CHk6U
X-Proofpoint-ORIG-GUID: 4vyaGmzaqZgtXHLljz09mjKbrg6CHk6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5NSBTYWx0ZWRfX4iU84BYXj/JW
 lgrKUoWu0hh7Oz3rMnFQ3NCl5UQE56ozpRh2UTbmNYlG4vvNzbaXywtLupSGnKtwBop7cWGJlL0
 nxVOVWyumLRHMtrW/ECFSo6ZuWmFG2y/oi+/U7H8t9sPr6C8654TjXvP1HR51lVElvntcRcnd5q
 bKRx3cFJ2th0j80AMkWKuYst5xiBuBQayA37BkOQOTGAQCdLtinEkE5Nz/I++33Yhf69kU0Ztvr
 mYUPIL43sl5gmuk/1G3EFwLv6hD6eddwg173fkAns7+NkQ6U7kceqSHXYwZ4wKsYt5KhuDCSjkd
 NUi3Q4cm4zOhDrnQMegxSWaeXEsI2eek3G/YL6G4KIfLW/8oDPY8Xk0gHCwqliDjaKkYfJ9IilN
 XoyYp6JZsNl2iCari/qgEvWACH6hsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290095

On Wed, Oct 29, 2025 at 05:50:01PM +0530, Tessolve Upstream wrote:
> 
> 
> On 28/10/25 14:55, Konrad Dybcio wrote:
> > On 10/28/25 7:16 AM, Sudarshan Shetty wrote:
> >> This patch introduces a new device tree for the QCS615 Talos
> >> EVK platform with dual-channel LVDS display support.
> >>
> >> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
> >> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
> >> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
> >>
> >> where channel-A carries odd pixel and channel-B carries even pixel
> >> on the QCS615 talos evk platform.
> >>
> >> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> >> ---
> > 
> > [...]
> > 
> >> +	backlight: backlight {
> >> +		compatible = "gpio-backlight";
> >> +		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
> >> +		default-on;
> >> +	};
> >> +
> >> +	lcd0_pwm_en {
> > 
> > Use hyphens instead of underscores in node names
> 
> Okay, will update in next patch.
> > 
> >> +		compatible = "pwm-gpio";
> >> +		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
> >> +		pinctrl-0 = <&lcd0_bklt_pwm>;
> > 
> > I think your intention was to use pwm-backlight and wire this node
> > up to that
> 
> Soc does not support the PWM interface hence we are using gpio 
> as "pwm-gpio" by setting the duty cycle to 100%(i.e. "no pwm")

Why do you mention PWM here at all? It's perfectly fine to use
gpio-backlight. That looks extremely suspicious since you are not
referecing the pwm-gpio device at all.

-- 
With best wishes
Dmitry

