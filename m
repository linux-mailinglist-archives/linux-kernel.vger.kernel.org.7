Return-Path: <linux-kernel+bounces-768698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A90B2644D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1457B1D45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B515DBC1;
	Thu, 14 Aug 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSR/pTAR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AC41A8F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171125; cv=none; b=EMJLPouu+30rq7xIQochH/hMUoc90/+a4NnkHk6sGS7Ldynn2XbhNg6lAU3hZeuQNsmMpp4tir06Wph+2Z/cbJgN9eOmclPWCVVismNT6m82wMINruLl0OE9/Ibbuio8ankdPsSTwb6x93QmCWlYZtD8jubWn4tJs0BbbXPI+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171125; c=relaxed/simple;
	bh=GaMwSbjkG60bn12Jc6n6QxgCb/4smz88PCPExvO9MQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg72hVx8pf4Vg88VNECzXnSQgEnVsnaUbib8aYb7uOm2TmW2PaX7yxgCwtQYc1DPPnEC4VX0GmNK0l4/Q1CLmd4Dq+iOnSDuavgPMUUkdNflJWhIANvRAId65duYXpTxPFvRRYuHLnKagu/vOBc3weQ0KNKciZQIWfSJAC+vix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSR/pTAR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8leQ2030070
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5Kue0XqCDQBiFPjMdNWdWUal
	mMTuGI6iAR9wq8/BtWc=; b=WSR/pTAR391nn50XjCL/aJZ/WTlDgAsSGBmK5J1y
	Cy/Vr3PgP9QWmRpKzk6VMpymN5nB/eQgmbs7ynWfyOQ85zcbALsODg1rba7u9vDv
	+Bb/joRtfdVmt2TsB8zng1kpYG4begVuwzZkCzjgn3WIoP1wilsTYMgi63qn3zlj
	nRa7Br6Mu+sstVVm56IT+NVsI5zmB7A9qYHEU6m8wsNwxVIT6y+yCTDWujnZa6Nq
	N2ruh9V0w/wBoYD/puEmhsg1Euq94f3JWhi8+1qn6OR4BOD6awYAhIUh8nh/KPw2
	7HF2Q/AGIRZy8K76xq1Wa/3FGnv3+eTUEq8FeYNZ6F8J2w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vtd42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:32:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88dd1408so18762436d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171122; x=1755775922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kue0XqCDQBiFPjMdNWdWUalmMTuGI6iAR9wq8/BtWc=;
        b=L6z6Qa3AI9LOKmjMxNwIUoSuEdxveACfj+gYqhSHT/ZKKeam/AuO/2Ozn8UeI+8m1A
         9VU2/bdAZNRA7WnnSnUCrejFj2qPft9W/8MSXAkKPbSqUcz5pgBH+j3xg07qmNfx8eBC
         y2f6P3IYnyOXAYrvSNVYieObbPsSGesz37RG91EndBsmD7JRPcaXyfr5M+8qWXk+e+vq
         FpsysrFb5dOTM8ywWyhrgVwSWzMp2rePG7RlRsQU8A5+CcWvoM+XtbvIYwIiA3MgLFbJ
         2TP1Vj55jYeV2cCgWdCJ7QtLgxMkHfcmD4cnTIetOYLGzjHrfde83lKajkDPhdEOAetO
         BnRg==
X-Forwarded-Encrypted: i=1; AJvYcCWDwwkb/3UmRTcKJF7X3BDAM0f1iGZkEKJ3UzK9ouGRbdHchqNI/HeorKwPzBJ2OCv9DZquXg6GAFQboUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYy6bWu77SrOIVIlyMwOgkpK8JCognlc/u3euF7lzpwaUUla+G
	83vSLZiricX8dLP2ait5pV9yL5ebflqYeQcDXuEzq3dEYL/pT1VflFuzZdlIBMg91rVPDrtGzaC
	zoZMXQ0g6AQ+3M+DPWLyIqjYEH/k+5AtbMfnKp7a6YMlUD0cBOBWJWjRezLlFefYVqEE=
X-Gm-Gg: ASbGncto5MCAFISD8lARtTjvu64mJaD0mR1l0snXwgFQO9w7p2KE3PkuhgkSGAIFTt+
	dQOpTyp762MW8uoFlby/iq+6HXlLRzz2UrYDciYQdCib7BxsLcyHVElr5sUnYWXnutbliB4EfIV
	+W82saNqS7reysmqQmVzxViWloFIat/UYDGcJWR19Nbks3VsdbUDzthkH5Uhc7AEmtG+c+MJetB
	FmnDoD2ju0xY+iNn5fB/8MP0bpJgFuiHXvGNAqVyQmqjMPj6euX/LzFf+uL7B9I5EV4JacA8toP
	y0g/Z28LXTL9rLTbRy+6IcTqiZZ+NB9UKu64tKN4Y+QtVIRmSVD+ZT6gdzyKqX7p40xw+rimhv5
	ULOq6P+NrsxdUqj+hFzoABugcisTiRIaXULXHSHuH2V8e0rhtsjhv
X-Received: by 2002:a05:6214:5006:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-70af5ca363cmr40078106d6.51.1755171121600;
        Thu, 14 Aug 2025 04:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg5jdW8W1fj9bgKm6O8r1ZKr3wStaA+qanKjmVzi7C0TiTgUxx6swb/Qxlonq4zBcA2g4FEA==
X-Received: by 2002:a05:6214:5006:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-70af5ca363cmr40077536d6.51.1755171121034;
        Thu, 14 Aug 2025 04:32:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33401455074sm530531fa.46.2025.08.14.04.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:31:58 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:31:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] soc: qcom: use no-UBWC config for MSM8956/76
Message-ID: <3muxbxytdezrptwrugu7yz4byycq6lteezrv22gs6abofhdst2@nnawschabj4q>
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
 <20250814-more-ubwc-v1-4-d520f298220d@oss.qualcomm.com>
 <7813c237-241b-4f09-8948-283def984792@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7813c237-241b-4f09-8948-283def984792@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXyDNhcQbmjhHj
 peN2lhxpk63SnHqqTPSnqIYaf9Q/3dop7nBborgui3VNYsM+qgFRPFZNIaH8pUq/nbTojP8q0Zp
 ffLOG6K6fFBVNNjuH92nQktXOMR/EY1CdD7le9+SxHpBsH9tdYECtB1bLRnIR1QWt2Ialw5LLLa
 0nNln2w2GTkNn54YM7Igu8I6pzbkbZW0JJHoXLlNhRQStfzTYqt0Iq40GnoemzYTZqMBXzQG9Mn
 1gkHlhWHWLowC4/n88AvJi9hyv0An3kW2fD5HBh/DvLKxiZfHswbnqfUggPYde+PZFuQp2RB7kH
 JU9CHMhGqeHcy+ZcT8YKGvkb+GH69yzMuDFvMxBXlUuw6zK+NuwkK5IcCXcVPe4GsplrY1YfdEB
 KrSVEoRB
X-Proofpoint-GUID: fmT1zMXNOsC2sbjG1p2OT5Ycs1NpBQJI
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689dc932 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=velJiXW0qwFq1mr4VzAA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: fmT1zMXNOsC2sbjG1p2OT5Ycs1NpBQJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On Thu, Aug 14, 2025 at 11:25:16AM +0200, Konrad Dybcio wrote:
> On 8/14/25 9:22 AM, Dmitry Baryshkov wrote:
> > Both MSM8956 and MSM8976 have MDSS 1.11 which doesn't support UBWC
> > (although they also have Adreno 510, which might support UBWC). Disable
> > UBWC support for those platforms.
> > 
> > Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I've posted this patch, but I'm a bit reluctant to merge it. These
targets should be able to use UBWC for GPU work, but then rewert to
linear for scanout buffers.

-- 
With best wishes
Dmitry

