Return-Path: <linux-kernel+bounces-759163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9BB1D96A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2738F176427
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72852259C85;
	Thu,  7 Aug 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fL+ZZ/nQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D325CC5B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574740; cv=none; b=loXc4V1ilFQZhCmsL3ke3X1JFhhmbRq5dnOwm/1ZsgsRURPO75k13dPGZOzUkAX+NQcKTty8TRF/tSUl3qOA3LCfWGbSDR9PN77jgWBadfbALGXIdJ1wmkFk9bgRTtqBxLHsWkRklEOcPlVPM1WTSrGq2KCkQob8pgeWBcCGWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574740; c=relaxed/simple;
	bh=3RJmbFyaEI/2Q7w0DwSZjNnb3wdVv2MTkMkwaeC/i14=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD8juQwShlEfBofE4D3UfF5qeKy63KSBskbANLpbdpnjK3gj62m1i9SuBRtgfJCCYNXgF2M1Wh/L1FoyAn8s99X/mmnxyYl1gucrfA/Ns7oDMs7ZSzC6znjXIZqd47k7DNn2ARh/oVAI81Z/JCLGUBFJ1hqddKgQuIQc1BJZ71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fL+ZZ/nQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779Cwmt007669
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 13:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rx2HlkhZ5XkdhRBXb9tvkQ1L
	h/1Dq2jL/Wn7+DWmLHM=; b=fL+ZZ/nQQyDavnPSVlOqAFsFopj4WqOMip1q3L3z
	KKhq2DQ3WVJg2G8MOLXnT502V1wrxmy5HGTxs1OCW/VSlbA1H7bNyqtl6uj7+Ga/
	MGOvBTmRBE2dsy/h75ql3hnLQfmd2KYjFiK0M9f0VGR3YA2dzOdFb11w4v8wr5/E
	ifrYNfotJa9YAScxKFO+XwxOEcpiExapssaYQzkct/E86XoNClncG/4h2Wvh3mTa
	GBHsYJxpFBAB2a4avfUIxSPcwNO4hgn3iHmotKNVlIe7vxvyihii++g0GubTuyYi
	+X/ii7mDBIHkqZNEuD7dE+wNOMk9vqxch1rReb5zCW6gsg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u23eug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:52:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b07b90d5cdso13749901cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574737; x=1755179537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx2HlkhZ5XkdhRBXb9tvkQ1Lh/1Dq2jL/Wn7+DWmLHM=;
        b=Cxb4WW5BBwL/HyXvDAlDh3GOsSMQzayxJHz+IfhB5pcyCQ0ZmU4WAbe+MDoKTMUkzZ
         +41niVcc0UPueczcTStP4N31TKv9qZSPCbBM64UF1Ciho6Y1zogepbcOI/u4iDWyaZUU
         m26+77dx2GRjIiF4XnxYNJ0vdgVB91MYgI41r+W9MORU01QlaDaEDZrNoitMSuTm8VsT
         Vx6h0zDc3tRnFrkh0O0x9FAzQt1+a+SI59Y8dkJLbnTpuBvP+ZQ8RztifdcoYxEDLr9T
         l/ZMQRchtpuTEKFK5UKsIkn3gYwmaUJo1VasQrndULQ+EZDb8VdbewuromUy5T831pSP
         nJvw==
X-Forwarded-Encrypted: i=1; AJvYcCWDJ4XaD5vo/Mt2bZaaayRf+YQtRVvi5OYFGXpIn/Su8Cgd9xj+Lf/kKbNhu5Yk8P46xVGA6y22QU5mHz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzeH8JUSvQolBlY8EYgFa0My22avLEQv2lVLCZ2RIheLuqh3n
	nqJGTx2n2a3oQnpkqrHqc6snsySnftktpkcF9Z/6B9ZfDRv5h3fq6oEjQSnW7AZ7O5G0jYAoL/o
	6EY0A4LSq3A+3K2V7+X6aDi/bBx6+2FZG1thKa9nz3JR06qzKIrdNkdZtY1bZGWt6LTA=
X-Gm-Gg: ASbGncvfuJaIU924y2tcCs2FCQiOpiWfJAOsb6tESCYMihMNB/dIo9p+gD3jh4fmZ+8
	U1L9NsCJgNLjbUy4ThzrphR7arOgF4/RF6QGdA6h1G0GlkQrOl084bUhuHXDH9BdiC6xr1V/e+a
	QhYl7ywR2+7crtcRtYWye7N81EwXZP+fgWIPbnK9Igv3qO0eD8DXV3CBxQuCIifvXemeuDFgyKc
	JIkmYn78MweUER3kTX0ikUcYP4R0OqblkU6dz4A4EKQovzjgUYVjn7+UJDBUohCvTBSZOi1yeti
	zKJSdVa6GAVDOQN5sPWF9rdrDvvTKWrYwVg9iHehDEdWPn06sbW3h1sVHzLFIc99VWpP0A==
X-Received: by 2002:ac8:7f48:0:b0:4ab:aa73:9600 with SMTP id d75a77b69052e-4b0a16adddcmr44580701cf.51.1754574737236;
        Thu, 07 Aug 2025 06:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8h/LmSHvY2xjExIpWEd1N45JRbMyTF9ezrl99kb/xqJfV6y+UvYKQinxMnY+ofhU4FWNwBQ==
X-Received: by 2002:ac8:7f48:0:b0:4ab:aa73:9600 with SMTP id d75a77b69052e-4b0a16adddcmr44580261cf.51.1754574736758;
        Thu, 07 Aug 2025 06:52:16 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b501f22dsm145939755e9.0.2025.08.07.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:52:16 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 7 Aug 2025 15:52:14 +0200
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org, mchehab@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJSvjqfQw3kNrVVH@trex>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex>
 <aJHqpiqvulGY2BYH@trex>
 <to2hrxml3um6iep4fcxhkq7pbibuimfnv4kfwqzlwdkh4osk5f@orjzbuawwgko>
 <aJMMhIqNupwPjCN+@trex>
 <0248afed-b82d-4555-8277-e84aacf153fd@oss.qualcomm.com>
 <aJNTigOMy1JFOxot@trex>
 <fcdd9534-d494-3fdb-dfa7-1d15da6f697a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdd9534-d494-3fdb-dfa7-1d15da6f697a@quicinc.com>
X-Proofpoint-GUID: gpyV60QyTUuRZGSnyWaOrtbvPpUGJFqu
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=6894af92 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=FCMjqHPL4a2t-UUgg6oA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: gpyV60QyTUuRZGSnyWaOrtbvPpUGJFqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfXzVVZs1ESHCjO
 T9vOhykiHXJlRvlrNpRNhHjMB8/5rqZ7yEoZRDlScL4UnOHzJZ/1RjoG9ZPS01ddXcUsRorlwkS
 OPT/FpefVcr4j+P2jbge3mTlIq9k3+GQ0e04HM9f0LDXGSRrQ3upjm3Ex6fMaqLohqoqQewHlwM
 vXhPylz0jC2Cb2wJ81i3jki4KRsa69Tm5cKH0VrUsKvDQLrIcmYuCE6IV2dQodEV02aQd8zCUte
 1NRQDd0QJoSKJZ3ZNeKpCh/Nv6baaynYBNsZI6OD1WzE13Tq/Mrf7SBf6AvDcA/JrHp8P6/K3oR
 ydsQVDIAXW+i+G5RxEjWpWtWgMxhOLb8AHbLjxXysmywUmGjSn7fNuRBbCMxC7DF3grIC82oFMn
 1Px1DpZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

On 07/08/25 16:36:41, Vikash Garodia wrote:
> 
> > It was agreed that this complexity was not necessary and that we should
> > just drop <6.0.55 firmware support (which would in any case only include
> > video decode).
> > 
> > And so on v8, I removed the above.
> > 
> > Now I have v9 ready to post it, but Dmitry is asking why cant we have
> > the v7 functionality so I am waiting for direction.
> 
> the issue is in firmware for both encoder and decoder. Didn't like the idea of
> driver carrying the hack for a firmware issue. Just because, for encoder, we are
> unable to hack it in driver, we are ok to have it enabled in a newer version of
> the firmware, we can follow the same for decoders as well.

if that is the only reason please do explain what do you mean by hack.

