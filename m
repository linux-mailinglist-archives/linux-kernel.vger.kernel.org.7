Return-Path: <linux-kernel+bounces-898617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129DC5599B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD54E6443
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53305295DA6;
	Thu, 13 Nov 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RDeWLHol";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXfl8gn5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE37E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005891; cv=none; b=h+QFtN0PQoiyJjJ0NrxIMIbpqlv1U7NDTFsE0kbet8iZ3EVqSz9GU7QnMsKa9M5Zdg9E6aTvh2lIvnpT1YufIa6pTwDs0C4sfAaqv77cTTamioTGtxgEXcnybHte/EHIoZ20gOg+HHlcC7hrgMChuDHMOqtDCNTmOA3Xuh/LUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005891; c=relaxed/simple;
	bh=dm43yIpUSUgoHYBigryFpNRAR3gcbeMI1TqEb2Fu2sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2hsVx3c6B+ZV5Dy9eUT8AGXLrBYi17CHvAtQNvvr2Vanf1hA7GsqjIjtWYY4c0zlnkbJHx3O5By4CujMFRB7sjK8c1Fq2fHnYKkHSKRxWEXQQo1ENgwNH0ATO6FXUkYQCiDV8YD90Wd784QdnUX3ejOSkUQ57YEzpbcqe5WLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RDeWLHol; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXfl8gn5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11RHx2869503
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZDUWVc1JY/664oQBKeQMoM3n
	vN/xoHehdQznDtdVxG4=; b=RDeWLHolPT3PFQW0nlEH6l5up3UkLYvljkJ0v57q
	daRgs0WzBHUlIUCuaY5bVuQqRnpzUcSw6sblkWnkcGrJVaISXL7BcxmLQEslXdzq
	d01Emb35TTEXGC1V0qgWZDPSAaLhrQnsaqJgrvDXWsAYSde90R+SjDFydBeuqOih
	qmLOcvB9M1ftf2ldVnWHdwIXpPT/MKaijfOn5G8DdQiS0Y1uQOYg0j8FxZU0+x9N
	+kylKNc3km4M2bnVdy5pB9BCN8DF2iBVm83JavnW8nkE2Howlvt+1B/1RxOMd+Ef
	NSLWKnJNtnyUFx0lqsBcqbun37pHg7ZgMNmodEuDFR4jJA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqurb32n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:51:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2217a9c60so186915085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763005887; x=1763610687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDUWVc1JY/664oQBKeQMoM3nvN/xoHehdQznDtdVxG4=;
        b=hXfl8gn5iBoDrQVdc0esdofJ2bAuHZccQEMQ2S8pzt0BazaTr0XQmdtSeY9ACP8QzH
         fXt6SqBmpOHXhtjyz7htHJeeOBoNGd2uuz495i761At7Am72EVlTUn/h+vgYjO+VxBkb
         DsbdrgFEQ68D/A8G6ZcgTeRrdbnXvAZB6l/5GIaxM30RqyRMqHCE8TvPBzwypq4fdjWI
         7QJ84RNt6I4Zc13a6c4OhRlW2JXr5Lv+L3w5HxE84UJ6YylsUkO4WZJ+2mudKiclbt4U
         mKr8r0ALaTz0rNPz4YOjKzCns1Pulum534HWJiHMeoM4SyeOCyRrErLlvZk3PNHEUa0P
         fNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763005887; x=1763610687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDUWVc1JY/664oQBKeQMoM3nvN/xoHehdQznDtdVxG4=;
        b=qvmhi7nqOHFOAiRnBjX2ui075O+3PcYujjGGwX8/pfu1y5qN4vMKRdDD9kt2SCmg7c
         Au9yfSfOeKIj+4rx8YK0WgVET4vQ2bVThUXSAlxh6q8dXECQSGTrmrP3WFJfnipwBir/
         Tb0nBmWHAwVGuRVRt2V0/1mqcb/ZuuzUCkKT1XJ9Umz7in8v6pNi8qN+PUF/g2xwXB+Z
         HvKxW9C5LmT59MgcQAOMEGDN7LPZw5ojUePZ8Ve4T0An8oYhPdxm8VCeEfMAR+7rq9Wj
         lgAHVM69ppHTedDlrvcZOnLFE91bR2Yjozb46lqfddxiPHJ7Wn19RUrk4Kbw7P2qGMoX
         M1pw==
X-Forwarded-Encrypted: i=1; AJvYcCXU6GSNP5YF9cRakQVibbhLwBBJDGDY0PAWNOzcHbzG++B76F8ac3hUiBInrUeC049PAKMLrwHGqYgSPNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tx36lX6eotY+1btj9JH5tht1/yVIlgRYExZz8N4DD7gCWGZh
	C2AUC71TdQx7cGlb/bxq7AQ89aTBkFXeTT+4EkdwyrN/b8/2qvc7QwWyvi8DanoFJ4Gp8vs8j3j
	Ql5JX2gLO0P9gW8L/wGXWBw+t5CyB7S15emY392ERWHabLosBppVFqlXfZVhytmuNkE0=
X-Gm-Gg: ASbGncveipewgbzz/a++5tD4+OoTJOwnIFPBdrpUZ+U689hD7RiemVSF97v0oeKJq6R
	MuRdSVIPECdSFXb9gFe9n1rOD+AVAi1vr5ffdB4Zlcec9X8rxA85waZwI6VnxDKyzviUGKSOPXu
	8OHQMKBSXH5/nZ7ifxOR167B1INzVFWj3KhOkYTQa+cCJB4sV6Lwpi65xwRmBh6vulV0FL25GNH
	xM9JJNFbEXkUdFD9z7FlUnX1k3q4bn51O6O2KAHNyeRk/5DRkgAepkHpzCsdBjGMKDoogJnb2H3
	giOuf87tYshlDC+vtDXoBKmTGgu3OGJVnSB1COkkYv3pXQmhSXYJ63a2NLnWl7UFwG5hnv0vw5R
	++vhqUl5YIH3dk3vvJV3yoyRjzS9CRBd/CVKELs7RuYv7nHQtD48IIaNdL2tK5F+18z+urvjTSw
	8CJoZEfHr2K7oA
X-Received: by 2002:a05:622a:14ce:b0:4e8:93a1:7464 with SMTP id d75a77b69052e-4eddbc7cb25mr77817641cf.15.1763005887327;
        Wed, 12 Nov 2025 19:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJN2gqOX1ddSoKJUvNUzwvFvUiXlNlk3wSnrYzlQ38UsqjfogumyR3FzMthbJmM4v/9TlSVA==
X-Received: by 2002:a05:622a:14ce:b0:4e8:93a1:7464 with SMTP id d75a77b69052e-4eddbc7cb25mr77817401cf.15.1763005886862;
        Wed, 12 Nov 2025 19:51:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803ac925sm125731e87.10.2025.11.12.19.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:51:25 -0800 (PST)
Date: Thu, 13 Nov 2025 05:51:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jesszhan@quicinc.com>,
        Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sm8750: Add display (MDSS) with
 Display CC
Message-ID: <ehxnrpcidyt2v5x6nv6vjkxekcvc7tdyks7hxsytqfbh3gnqq2@yffpopklqbyd>
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
 <20251112-sm8750-display-dts-v2-1-d1567c583821@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-sm8750-display-dts-v2-1-d1567c583821@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyMyBTYWx0ZWRfX2PWEkeGgNERT
 d04YMuqoztIOXudw1PjrANbQthFAT6JKGmxcmU8IPRLDc1zYCpzm7yTwwm7VrzSZ3ZVA0rVUXYY
 2deSrnGoTipMkRn4Cu/O2s//WW2UD3s5HWrk4yhkNgETMLaG7k07/YD32RO6NP8GAKwllpjlth+
 noCl1KkK2TJ3nuDj5HQPYw0H59haVQr4zgu0QZ2YrrrgZsHe+jrP9CCbs+3fPNsRlz7b+e2542O
 t/PyE45TddghT+PvslAZjz6mPcKbtUFO9z8t6TDpzi0oXnONQe4Lnz+cvqF+ElBFiToNEH701DY
 3Mywf/hVAFPr686h5+6IQ7Rji/wPmBrJW7WxuS0X2DbopbPQdbXF2IdP5CACgu9rbDQ2PyFBBtm
 B8Ot/Ld8+4AnrJvq6mEYqxxoZeCujw==
X-Proofpoint-GUID: LiqCeTElyjDXn0GIQzFOmGJx8i3o1d5h
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=691555c0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ztn4_cRxgtR80OVh4l4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LiqCeTElyjDXn0GIQzFOmGJx8i3o1d5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130023

On Wed, Nov 12, 2025 at 04:02:38PM +0100, Krzysztof Kozlowski wrote:
> Add device nodes for entire display: MDSS, DPU, DSI, DSI PHYs,
> DisplayPort and Display Clock Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 437 +++++++++++++++++++++++++++++++++++
>  1 file changed, 437 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

