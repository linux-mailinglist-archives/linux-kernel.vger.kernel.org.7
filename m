Return-Path: <linux-kernel+bounces-737106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40320B0A7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A175A7DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15A2DECDF;
	Fri, 18 Jul 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yk5do/aa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B92DCC1B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853104; cv=none; b=aIiIwiK5TPHK/9YCKzuI80221c7ffInPvH1DLGtkWrEmU+bduKecySvgo4Q9Jj6chmnCUVOj5WmrA0ooqZ9VjLbgCDb5m1fHzopvb7Cl6jT6GD6nvzzyN4sbAdGkYmzTLpBuI1odRyxQCyb1SWTzVDvLF3Mr66qDeIAfhlhQqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853104; c=relaxed/simple;
	bh=Yexg01c8qAXHR9qOdv5Ggo+N164p2TucG1gvimWownQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqm1gBwL/u1SaHaCkOQyO73rERonFCAgLYLZ97CeQJ21ZrUNN9zTyM1pR+enOM5pyyHG40HBmOjU7Xdl9Sue6+4OvLokoMtEUY5o4oQwoEfYlfjooKPO8NNoBfm63H1mZMWkBhYdjHYXFKb9q2CDISQFf19cpoC4yzTpf79jeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yk5do/aa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8TlTq026790
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P6+RrV5N6b5UIHIYz7u63iYh
	pmaqRZCMbsPgsoyq814=; b=Yk5do/aaXxXgyXWXtPTqhw369JOW3lM33wSsfvUo
	mMwHda4cGAn5H7/UxU1XA4Ncl4p+Rc4nBrnuyu2dB5Dj/GPO/nMWBw01WD4WBWcH
	DCsD+XXKpz98DvH8NM+Wid7DCjNZjzfXovw1D8mKyLNvTllwvmKhqFdM8pmDqipQ
	iPjGSiWgWkptRpd3RCK53bMlZIe/UF/pBlcblPMSC2q6azx+UG1oT86eVok7Q1D8
	JXld/ddNMaDDfSkY9xzPhrn2Q3TafgRKnzgDeu4LJINBQnciediVkDsv++bqm7/g
	LIFxmeybDQJENMTGiIplv9GfW9croPQjEOGssQIbTNlXeg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqg9w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:38:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e338e627f1so593903385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853100; x=1753457900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6+RrV5N6b5UIHIYz7u63iYhpmaqRZCMbsPgsoyq814=;
        b=G+OjxwfvYKQn0KuD9eeJQHmUN6ZRH9aInWJifGxTuwxNaRrifgTKXh8aNnPFrf+Iyf
         9ItjnXG/QKhLZx7lpH+w8DOQJxJi0yo7huOjuMZXR0MUGgnzBCsq+C2+K8okt783YEWs
         zs3YySBWxHkcl8LMl4SdDa1FUpJuidRR2OQQextSz/8Bgvx22OkcO0l6bz428KgFOQI6
         41Qnlg8ED2x4WyP+UTIUnKdIgMu9NuGXkKxppu2xmkcPEaRxu1ox4xPPRlisZHqsRgUu
         P/DWmlXp6sxPW2IicPacwFQ/oQ1tMCFvnAG+hzfiohEfohfVTBry1j9+zmjwehbGd/tg
         A7EA==
X-Forwarded-Encrypted: i=1; AJvYcCXO3Wvw5MgFLP/DVFcGSWlyXjJwNDJZDjvG+nEdqVrnmJNe3t+1taeOXUt/OrtObObRd0nQyji+MBa37iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGp1Ca1x3TsE2yDvk/fcZU/6PCzPNXvtWwY6J4Wn2ol5d0tmn
	7LINa8Ga1p4BdcQ7RnUhBDk/ke6qmy/1oY9O+6FlQhG4gksTpOkv4h1BK+SkN0unGmkAp0RwUvs
	1OBXlj8JjHhaNxk2CP1gCq5qmFWpHjE2ADqN4MvxuYYZQlKaWLetXLM06UVFe3HjM7dfHsuKj5e
	o=
X-Gm-Gg: ASbGncucytt1lUIxmhO7rCePXgr96ZtUlrPBad1TtFk2sNRpqswkTGg+nnON8Autzr9
	r+tNqL9ZGYG//CtT69/bpP7Dtqb80alakEKDfDkzkawZ2GcLAa4BIZjkQ/6CBC4QBYAdwgWrsnB
	G8KcIyWTkKTquEP+HOiWvT63g3XsXwslmHD7DHJvfxXS0uiRWsBldWcC020Af/uA4x5RuOcV09j
	h+qd0utCE1Kcb8mguKA21ESYpaF01WXvyx4NLmI624bNO+NBRk8Je+4soYWlfWQ32e48TQPdRm6
	F7oA+v28QtJnrYeRN65rDT9ch6bZQEGN5RvN9reYXDiaF5WZiL+UTEUAEUNwu16xw81CmsIOXse
	LFEg0Dzp8pt9Aey11Gq0vIXQszFn7m9fUnn+nB+QQhqAl80wr1REJ
X-Received: by 2002:a05:6214:5d91:b0:705:456:c4a0 with SMTP id 6a1803df08f44-7051a151c83mr38645716d6.33.1752852752525;
        Fri, 18 Jul 2025 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhdFZv0OG6o7Eg5mDKIE8QQIGFm51wq0J8H1lXv/eB6mvbVUlAvHR8+/JMoHeLGeFKXURm+Q==
X-Received: by 2002:a05:6102:ccb:b0:4dd:b82d:e0de with SMTP id ada2fe7eead31-4f9ab36d3d8mr1698721137.17.1752852259972;
        Fri, 18 Jul 2025 08:24:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a90d5925sm2572821fa.1.2025.07.18.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:24:19 -0700 (PDT)
Date: Fri, 18 Jul 2025 18:24:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8150: use correct PD for
 DisplayPort controller
Message-ID: <jdzmyxotemxufamyemcotx5tgkuotn5ywez2mbt42v3thajbum@idgrarw542ic>
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
 <20250717-fix-rpmhpd-abi-v1-2-4c82e25e3280@oss.qualcomm.com>
 <2ed06cfb-2b06-41ae-ace6-b404878a97dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed06cfb-2b06-41ae-ace6-b404878a97dc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a6a6d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=gOKfhFuQloHwmF_bC4QA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 4fk_wa_4zEJjEvkBkFcHZDOaZudNxxBc
X-Proofpoint-GUID: 4fk_wa_4zEJjEvkBkFcHZDOaZudNxxBc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyMSBTYWx0ZWRfX3h5wXnESpSeU
 +U0PNgE1YuCGiyBLycev9ubPpiBbVTm+OtN/wdMaBfhmsbDgeS35QpbkDRDHaxibM7XtEhVd4Ce
 o2T4AbtViV8KYvr+tSGNoipWmvILTrCtHMiLsY6i4LqQZehUCqgRPZitD7M7yMPBvVQOcIDEVjJ
 juEW5bnct8QGzjjLeoheCT33iuMvOT4KfaBYfGiTVeKIhaeK7X415D0ZXB2brBLzQGXtDvEar/L
 wFLDgOmnD7Vx25FucaKnAXQdaXMQfy/BkKaw+ShILjo+IOQiOiBiDMk4BlOCJpY+LLpySNUxvVh
 9x7J/7ifQ+Pv8phDS4lUIcYPcRCEWbgsAq6VriaHvIh8h657y5zKFg1Egk9/+rcvTVdHOQH15VC
 mMCEg+DIBM9QfLj8Ok8S5iTVgg1tVFRRn0KWnTt+xAAIXhIryWrotDOGLGStBxkJZ9OQI4Cj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=749 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180121

On Thu, Jul 17, 2025 at 04:27:33PM +0200, Konrad Dybcio wrote:
> On 7/17/25 2:48 PM, Dmitry Baryshkov wrote:
> > Commit 5dd110c90a50 ("arm64: dts: qcom: sm8150: add DisplayPort
> > controller") specified SM8250_MMCX for the DisplayPort power domain,
> > however on SM8160 this indices maps to SM8150_MX_AO. Use correct indice
> 
> 81*6*0 typo

Ack

> 
> > instead (SM8150_MMCX).
> include/dt-bindings/power/qcom-rpmpd.h
> 90:#define SM8150_MMCX  9
> 91:#define SM8150_MMCX_AO       10
> 109:#define SM8250_MMCX 6
> 110:#define SM8250_MMCX_AO      7
> 
> (i.e. the commit message is misleading)

#define SM8250_MMCX     6
#define SM8150_MX_AO    6
#define SM8150_MMCX     9

I will try to make it more obvious.

> 
> 
> Konrad

-- 
With best wishes
Dmitry

