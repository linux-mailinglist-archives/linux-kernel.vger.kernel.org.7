Return-Path: <linux-kernel+bounces-755028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA7B1A047
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AB218888C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C325394C;
	Mon,  4 Aug 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="earNJcF8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33C1F582F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305687; cv=none; b=gSrPdjoi+g5DCEOa/K7bUoo7sksJFc6qtW/VMx7+HgOjeTVoD0dcM25uU9TA77zmbfPiH+1A8V/wzu9Ra5ywTpX/ze/QDzOk433fu88gqqfxcSz/BbTakO6GA18hHHa6XUP4xW0/pdj74GPseZZ+mLY42ph2rSKTJ4AuH4MCogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305687; c=relaxed/simple;
	bh=7qhyH/PU8NTXMb07r6bgr29blza+kLWRP/cKMCl7M4w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbXAtnJGYc8YqOvSu51OJBSUz4YojhvOeWkk1lTlwXI0KFAN+Zix0cC8EKaBmHajY9vR/bhaTNdj2M0DvBJ6H515DjTukbICefjVaJQB90vZG67OYlsKKGlvbDcptYthdHBaRQnsO/vmwPafqJpS6W54s7VQ/8sHOEJPuV/1Aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=earNJcF8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748V904029616
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 11:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/quFVpXGaSR9+jFTg65KdPNzkiQfbcpVWaZyCBq0GDY=; b=earNJcF87v6maYZ+
	3Edr7gGXrDDQC/tXRPm7w/MLWf/UlPLNThSm/WS8FImrvWFo8hVgvlJKxermNpvk
	IUjnA/fbiFT4xPl1t3UeRHhgNHnAI5BoXjxWcstXu/0KULfA4eztREzvqL7F8FoR
	p5d2v6IcRk63oouvsICt0UhHjuRw2/da2tlCP3bAgvmcwyOMcqCBEwXw/1m4Olp/
	mXWdDBCr/+K1k81yBqcaI6L+2IqA4JR+aS2vQBsy3Qdju2S++Ql51gh4PwUY12Bb
	7XoUQsNdxA8y0GJyqOSZoiHPQeCeONirBNcR5JCvhOCTYKnz0Ei19T8GKTS3s2AO
	gxV4Tg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc4m7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:08:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af156a27b1so67495811cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305684; x=1754910484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/quFVpXGaSR9+jFTg65KdPNzkiQfbcpVWaZyCBq0GDY=;
        b=qRuVWlWqTa9mugy7AcjlzDPf/kJjwEncpxMcR58zNa57PFgvpurFCEfqo8cYx7Au1R
         hDkQOCS+8nhwHHg5qo7+2GWxvvYqt/6pkcHYiMjPVRkFXzz/mvNl1XYUm9DTbS81+Eve
         68G9S4cnQyxWUfvau2zKVurtLwv/ZlNIhRUd+C5I5xSiwRYryQdSBwTn4TvwzU4vTVxg
         VSHPqFeFVQH/8PyuBPCEQO4VKgnL4FzvCBlWuUGYu9yfQr/e4dC9o17aFetDZvQKKKqU
         bBjmlXNMe3FCFzuBHT4+aDPcIV9qy3KDjh2xLcSbDCDesuGSwiC2uVNiPPuX9qBXvKlp
         C88g==
X-Forwarded-Encrypted: i=1; AJvYcCXRVnTZ6YUxYYW6xH03FNJsn6+B/8RUHs9VRD3XD53MVs2Ko6EXYFrnXu82BSZMBcVUkITq4q9UTWEkFwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlWjLWlD19gPca6FesVa1YX1c0ILO4COqrwPO4ZEr6Nmy0Pkf
	ToQlEKjInXEKCT0L6TOGvV3klCNSiYr1GfLRbCP0lvRukNdByGm3x218ccBhJF1Df1V9fxjm7Lc
	aMqTDsmIkuTYPC3qCNrcdZkHfnHYJWOfL5WgWKKtsJq6ZjjhlCP+DkUtT+SVcGGtEC4k=
X-Gm-Gg: ASbGncsA0jCWGyV29k/lILWVivopdzC4DkNDN0ADVrJsGFsAqiOIJuWevlScE6P8HU3
	m0tZ/dx3rs4moZTmSlZE6c7/XL4mRqP80ThtesFMwn74kspT2YmnWY1MfiKXWrSEPiNdsnaootA
	PRzExxdl93ovljp8wOhUjFNDoeqA99V486Ylo/09v0CdH2eZVgPgpftFqjsl9zY8WymrXfXGGjc
	WngM8QoMgeXVOjt1geSjkpv7gVNltc39xMfeS3C1p1u966fUlOyY6yM02oYK9rtjV5fRlBHHKVN
	TENpZr+bq2pKc2vT2WRlCdLamDh63voiKTbWj+64naYyME/RAma9VgJ+P5jhphaO9XF/WQ==
X-Received: by 2002:ac8:7dc6:0:b0:4ab:1a4a:1cfc with SMTP id d75a77b69052e-4af109e1692mr120452061cf.22.1754305684123;
        Mon, 04 Aug 2025 04:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGbFNrQOAHiSqeoYZPfVBZx5TLgseXs8R9ww0pxzX0zAUXdnmmDqsXaerx5Ls2XGk0BTwzwQ==
X-Received: by 2002:ac8:7dc6:0:b0:4ab:1a4a:1cfc with SMTP id d75a77b69052e-4af109e1692mr120451671cf.22.1754305683506;
        Mon, 04 Aug 2025 04:08:03 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ded356b9sm11743785e9.12.2025.08.04.04.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:08:02 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 4 Aug 2025 13:08:01 +0200
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] media: dt-bindings: venus: Add qcm2290 dt schema
Message-ID: <aJCUke55NXN7nN53@trex>
References: <20250715204749.2189875-2-jorge.ramirez@oss.qualcomm.com>
 <8a63f517-a443-48e4-9b9c-0c4b362f59f8@linaro.org>
 <aHiZpnFhhR5O0h97@trex>
 <0bb2867a-393b-46f9-ad6f-1aeee5a3a9d4@kernel.org>
 <aHjbjw8Z79Xcd/ZJ@trex>
 <aHksJum91s4ZmI56@trex>
 <5afbaf46-bbb1-47d8-84aa-29b18987564f@kernel.org>
 <18d013e5-352e-457b-ba96-3dd19f1cbaed@oss.qualcomm.com>
 <56d4e911-5bec-458e-acd1-3594a6d8b91d@kernel.org>
 <1402a52f-639c-4872-a153-b549603c13a7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1402a52f-639c-4872-a153-b549603c13a7@linaro.org>
X-Proofpoint-ORIG-GUID: nA98tAEpyVEA6K64wEeaxo2P0l8KZVxr
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=68909495 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=CUqL58EqNT68S6E0SegA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: nA98tAEpyVEA6K64wEeaxo2P0l8KZVxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2MCBTYWx0ZWRfX1QuDFBnPRMQ4
 Wv2UNEY/xH5Fz69XTuJpsU39YhPEJpNS2OaLd3gi9yEIBT1yqGKd9VnwMKZ25550vGZ7wszcI6W
 3R3Hz+nXgVh7FDMDsg1WTv1EoS73v66QScr1jZGmzqKNzPx2JJvPRwC/zcVd28K0GHwlnIeYpc5
 DnYMQkSGrrDhleHVlttBlH8+Xi5TyMva2jzhWU3kiuaGMCepWPSKKflh+IWSju7LHmRsTR7HUai
 qofMjhzJf6xJRYEzisgZkbucyG6FKBvM44ukKRsvgTNX3tYWMZMW4PC76kMDzHnLRdNdNYjm+6d
 Ly9YBx6Tg/yW1+v640g7zOXBcqyU+2T6qtQOjIOIiqZj7JXIM6/VwCZhQoytMXW/N3qW0Xmq2n2
 K5ZRbKX5nKmVLBHm01QGPw6ME8gjGGHVVvwFIGVjbLir0eHe+3CAv/C7918WANmtJW/wsFMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=797 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040060

On 18/07/25 11:21:07, Bryan O'Donoghue wrote:
> On 18/07/2025 11:04, Krzysztof Kozlowski wrote:
> > On 18/07/2025 12:02, Konrad Dybcio wrote:
> > > On 7/18/25 8:27 AM, Krzysztof Kozlowski wrote:
> > > > On 17/07/2025 19:00, Jorge Ramirez wrote:
> > > > > On 17/07/25 13:16:31, Jorge Ramirez wrote:
> 
> > > > > Not sure if I’ve shared this before, but following an internal
> > > > > discussion, I think it’s worth highlighting a functional dependency in
> > > > > the current kernel:
> > > > > 
> > > > >   - the driver only works if the first two IOMMUs in the list — the
> > > > > non-secure ones — are placed at the beginning. Reordering them breaks
> > > > > functionality, which introduces unexpected fragility.
> > > > > 
> > > > > Regardless, this seems like a valid concern to me — a driver shouldn't
> > > > > rely on the order of phandles — and I just wanted to make sure you're
> > > > > aware of it before I post a v8 (likely sometime next week or the
> > > > > following, as I’ll be taking a short break soon).
> > > > 
> > > > 
> > > > Hm? Order of lists is strictly defined. That's actually an overlook that
> > > > we never do it for iommus, but the core rule stays.
> > > 
> > > (FWIW "items:" is an ordered list, "enum:" is unordered)
> > 
> > enum is not a list, but enumeration, meaning one item of multiple values.
> > 
> > Best regards,
> > Krzysztof
> 
> As Krzysztof says the ordering is strict.
> 
> I think the right-thing-to-do is to document in the commit log the
> dependency.
> 
> The final three entries are secure entries and the ordering is important.

sure, will do that

> 
> ---
> bod

