Return-Path: <linux-kernel+bounces-829215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0FB96895
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9848162247
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E611DF72C;
	Tue, 23 Sep 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LigH6/vT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0718E20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640650; cv=none; b=Yxm+T3oCUqM9CUM7T3Y0Pg+x5YmbSQQlqyMQ3IrMxIIg10ZC6MrHcyDHq0O88sxhQdvznRCe96ME+BmbYivDMqurwfg7rZ5AbhxY0VoP1jDG6IoZ7AWuzxAVIc9GVXYTQi68PdmozSerODjPDQQ6u8SY1st+FUbKaGFv+Hqrwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640650; c=relaxed/simple;
	bh=/7kee+I8j9/Lr7ysS2tbhFYpdtuo1tTppWFv+ttxnGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaUPHCteYSIzYznF0tdeWYLmUznVJs9j1j72k8t+r1H7gavwEj4GrIpCHhHIOutO/YRFLLO3xPz3E+7lOZi6aupWkMfAG+m8ILu8T8MICCyOLy1D4UhTjC7R4OjvCzgNiLqj/yDfi4EADxDDPVeKl7w+rvpZRcMIxA/c3pZYgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LigH6/vT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HIVb007754
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zKMrwI1eQYz33WkyvRDWZnB2
	zzJf4oJ0W5w8S7iD9HI=; b=LigH6/vTaZEWPZ7Cf1S+hvgNRAcTbmd375676yYC
	emQK3bQsKjHVyhIALwXK0eRZpQPFWwogCewflIGZ0UCRTNXrJ6mf6OHIlLrSZ4UE
	1kWhN/TYLANbhwKC2iGv2gJ7fhzxI/HTtQZVBEjCapM43v3Sxlk3PoS/vEHRz3Wh
	/oC6rijCCWYF3XTq7jDDqSOQQV5KTqOn3usGSKz2GF63mYb4e7kArSgMcVJrbDzm
	vlFXqSx77tkBpEJjp0hQJOGydOYzy0PeQ05bPnte8YbanpvZ3DmcPHYOK64F+Quh
	7U79C0ef7loOnqM9ZwkU/Q8ZrV7klxvWQAU196cmtU30/Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98h3p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:17:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-767e5b2a74fso59857486d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640645; x=1759245445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKMrwI1eQYz33WkyvRDWZnB2zzJf4oJ0W5w8S7iD9HI=;
        b=im1xh0j1gVH2cNvWptX+AGXZmvV6NbzgUReWoFDrAy0GHFv413Z/7Z+FPudi8gzrQT
         18h2EetaTsqYo79GwC5CLx9T5w3SettnAOdc3CPaCRYHjEt/hNUqNpxIVmd1kLyTsrZi
         lmC8FZq/4PTaiUd3enBQidEYDxoFz1upQpv4vDrgbouHnrIpZTVJSTjzE6zBSKzC9NQ5
         EdNhO4jWJ4H0JAviXFsR4JYmxYRaIPsXB/WCN6VGX9NW8PHSpWdsMHZ+Mcf4hx4bCGdx
         Z3y1ULKVSQl2ZYHcVpIN6qwagxTUfAJRn65UaZMzAbo7lKCc/f/tZcImrjfC5jZTVO/R
         p20g==
X-Forwarded-Encrypted: i=1; AJvYcCVPiDYkflQH4xzqbS975NszsTaTueGr4SyBNzOae1VfI59BHlVFUY3a6sJefpFMrDt9QACteXIOWihtggQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkOVDbr4NCKmVTuupjCRWKNotrMcnWIoWqtzNRGMqwiIFhOd/
	f8CkbWyoNweXSfjAh5h1Zr01BPd68SqDnZgsfWMleBgdSb4OITIP+YgwkNQrM2f8JPeQ90avCRv
	cBDzVhOrOjzWx3jY+x8k5CGucQj2eB8OiG00Cz324kVqmg/bMN1Xdsw6Cq+mTFLl6yTE=
X-Gm-Gg: ASbGnctsHlIM7RRSYWZIclAHbaRB+BU1omkJRMs92VsSjdLa4AE2O51F/otmXxjKDR6
	1vOu/JEQtCoLgNP7u9YW1WhDe+bm5gtvQziz4XwiNRHm6kOvK92cQvjPoMn1crPx1JJ/Ag8Jyj5
	PRJ4TndRnVQvx4UQIeeE951F4IuIy9bermi0+vfyNpB5URBwoe1hj33izEqcgOOlvh3klcJYoAC
	8vCfMPxGPkdLkHgbqfNqm8j9DW53TcaHp4/vBO2e+HVW+7EGXtefe7K9qyc728xQaevsMeXeK5v
	tmZXbTvvR/msZ5zYZ5xiMgR4115fndFiOQa+Vbn3zlR0iYZ/1etEXk58YkvaVR1htmYJQ3TVjI8
	LzAj8qYAs+N5Lf++ql8fh61bekKqBbfKlNs+fwlbi4pvKfpDYxvqL
X-Received: by 2002:ad4:4eec:0:b0:70d:ba79:251e with SMTP id 6a1803df08f44-7e7a4cd6a23mr27206016d6.13.1758640644789;
        Tue, 23 Sep 2025 08:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbjx8nOdd4srh2DDvcouzuNx8y7t17u070QeQCvysOaVT8ihRfB3wbeiinjQMhJI8Wz0tAxg==
X-Received: by 2002:ad4:4eec:0:b0:70d:ba79:251e with SMTP id 6a1803df08f44-7e7a4cd6a23mr27205486d6.13.1758640644122;
        Tue, 23 Sep 2025 08:17:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a1e079e7sm36471931fa.13.2025.09.23.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:17:23 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:17:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: rename dtsi files for sm6150,
 x1e80100 and qcs8300
Message-ID: <7o2n3wcjlb3ltbqndehfntqvsdpnn633pk4rlfq3h7fz2ygaus@na326qso5rs4>
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
 <DD075WC7A6KR.NJJA1Q4WAJUZ@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD075WC7A6KR.NJJA1Q4WAJUZ@fairphone.com>
X-Proofpoint-GUID: X2M2uwVvW_pB8zneD0nXOpIAx5GXtMoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXzcQFj6Xw1Ve4
 rhTEfSR73ZwlYpC126Tulj6rLSUl3bl5KYCGe32kVWxpQreLXm3gKuKhhAFX9h2agOkVGu238DQ
 yhue7yXyPSIJMiwwtXLtcJmi9iRGA7fEOHvEccRQSlLdknEyOzYF0rudA5kypdeRIPcl8QpJ7h9
 Tp/g/RLIbbDqi683JlCVKY9l4srEtNSEALChHrE2HVDF1+CLB3GlIfPKDPzhRGxd/urFIi5XQFb
 BXZ8AX5h0ngRhOI0OqM8VK6SGG474fJxSh0ueUk+he51zWJhq6xz+5wgQVljac+pVhOABGrnes7
 aNJ2a2bYjb1HPFtM6/xI5Pf1gpYO4DxP92Fm8wdKNJI2bW6qvR9SeHJdtSBE4vi1UKugRNIx1Gp
 rP3yunGa
X-Proofpoint-ORIG-GUID: X2M2uwVvW_pB8zneD0nXOpIAx5GXtMoJ
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d2ba05 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-__yLQ3fiRWGdVT6V6QA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On Tue, Sep 23, 2025 at 03:00:19PM +0200, Luca Weiss wrote:
> On Tue Sep 23, 2025 at 1:01 PM CEST, Dmitry Baryshkov wrote:
> > Bjorn said to me that he disliked the conseqeuences of renaming
> > qcs615.dtsi to sm6150.dtsi. Let's increase entropy even more and rename
> > even more base DTSI files.
> >
> > Leaving jokes aside. It's not uncommon to see different names for the
> > same SoC (or almost same SoC, with no visible differences from the Linux
> > side). The platform now known as 'lemans' is a good example, because it
> > had been using SA8775P, QCS9100 and QCS9075 in different contexts for
> > slightly different modifications. QCS8300 / QCS8275 is another example.
> > All such names cause a lot of confusion when somebody tries to follow
> > the actual SoC used by the platform.
> >
> > For 'lemans' after a lot of trial, error, Naks and reviews we've settled
> > upon having 'lemans.dtsi', the core DT file for the platform and then
> > naming individual DT files following the marketing name for the platform
> > or for the SoC.
> >
> > Apply the same approach to several other platforms, renaming the base
> > DTSI and keeping the DT names as is.
> 
> If we're doing this already, sc7280 -> kodiak? That also covers sc7280,
> qc{m,s}6490 & 5430 and sm7325.

And few other platform names with multiple SoC names per platform.

> 
> Also, does this mean that milos-based Fairphone 6 the dtsi should be
> milos.dtsi while dts should be sm7635-fairphone-fp6? The latest patch
> series uses milos-fairphone-fp6.dts.

I'd leave this to Bjorn's discretion.

> 
> Regards
> Luca
> 
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > Dmitry Baryshkov (3):
> >       arm64: dts: qcom: rename qcs8300 to monaco
> >       arm64: dts: qcom: rename x1e80100 to hamoa
> >       arm64: dts: qcom: rename sm6150 to talos
> >
> >  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                        | 4 ++--
> >  arch/arm64/boot/dts/qcom/{x1e80100-pmics.dtsi => hamoa-pmics.dtsi} | 0
> >  arch/arm64/boot/dts/qcom/{x1e80100.dtsi => hamoa.dtsi}             | 0
> >  arch/arm64/boot/dts/qcom/monaco-evk.dts                            | 4 ++--
> >  arch/arm64/boot/dts/qcom/{qcs8300-pmics.dtsi => monaco-pmics.dtsi} | 0
> >  arch/arm64/boot/dts/qcom/{qcs8300.dtsi => monaco.dtsi}             | 0
> >  arch/arm64/boot/dts/qcom/qcs615-ride.dts                           | 2 +-
> >  arch/arm64/boot/dts/qcom/qcs8300-ride.dts                          | 4 ++--
> >  arch/arm64/boot/dts/qcom/{sm6150.dtsi => talos.dtsi}               | 0
> >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                  | 2 +-
> >  arch/arm64/boot/dts/qcom/x1-crd.dtsi                               | 2 +-
> >  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                        | 2 +-
> >  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                       | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi        | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts            | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts             | 2 +-
> >  arch/arm64/boot/dts/qcom/x1e80100-crd.dts                          | 2 +-
> >  arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts   | 2 +-
> >  arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts           | 2 +-
> >  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts              | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts              | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts           | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi           | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                          | 4 ++--
> >  arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts              | 2 +-
> >  arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts          | 2 +-
> >  arch/arm64/boot/dts/qcom/x1p42100.dtsi                             | 4 ++--
> >  27 files changed, 34 insertions(+), 34 deletions(-)
> > ---
> > base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
> > change-id: 20250923-rename-dts-5d74d6132f40
> >
> > Best regards,
> 

-- 
With best wishes
Dmitry

