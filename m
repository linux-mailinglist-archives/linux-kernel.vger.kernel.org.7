Return-Path: <linux-kernel+bounces-836076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941CBA8A95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330A317067C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037011F3BA2;
	Mon, 29 Sep 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqX2erMb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C726A09B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138682; cv=none; b=S+NPlHFFCgqb/W55lRodKwiHV3CTuFxF2DyZMZWT6Ed+r5L7DTCd4plCf8HCgYBLwdjbsvfrr4SLRtHf/YZpIzRDTTkfzHdyBAhRDNvJ5ts8U2mlp9XytaRZ2/Zs3aeY5SkWThUCjP/+D44kicUFO77LVcDVmjTG2uMAyDSXP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138682; c=relaxed/simple;
	bh=1titZlYiqCGea4shUB6s1SlT200aB6VqOgT9uvqDHos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rizKAX+q5C8uxpo1mabH51xvtrT8kHFmOhRj0JUTF5EkGbzWKRoW/SpQfxG35DpaDE+T6CNn6bJddbTjmPyqdrsWKOcn4s8mgmFRSIqf7JyoB0KFhV55htXJeBDeEduBvox81e6JRcs36vO+R2dU1Ylrn3KzyM6xU3nnaHjF8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqX2erMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLax8u029473
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uMrlZfYJFsa/roxg6t05N0o/
	qG4IRrmXSTCcqA1YII0=; b=lqX2erMbnrxRKWLuns06uDSLqkXVa6AirFZeCU5R
	TnlBtePDEsyiapTu8FAtXRXVRW9/9CJZfdBmZw0z6O3vMx/7Jb0ek1Pkn/wtMQwp
	FPrHN6sUHfv44RhuWAu3ZCvYhRgpxsRHJjPUpCySzID69NQN34OPGxlnCD359/6H
	fP5vo540McH7RD6VOIk35qd1fhN+J1u1ic1NhC7san93DTn3QzXNA+fYegFpJjq6
	VGOvJ4IaR341XAToGkyUdXU1KEp+xPhkhMOLd3dCk9BcBt0dN/vbGpqmWKyB4P8e
	Z5NOj+nVA0Il1PboIKseTGN5oY36TfkuerY4adQHXTqIZA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdcfmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:38:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d6a41b5b66so107678201cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138679; x=1759743479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMrlZfYJFsa/roxg6t05N0o/qG4IRrmXSTCcqA1YII0=;
        b=uvNz5qgRetGaQ7PaIKC7vLSsWd/DFBDP/8qsw5FNPoLH7uE2kWRZCLFpCQ0mEW0xE6
         cnNCoyil3Um1J9PQjg8dIoqkutrwt1JDfCCz61gevrrUIjtWTa051q9MWuyyBOBFrusp
         +94Qqheu9okB3r436Ut6+5SzMQbJt4332t6nx+AUBlGiMFNF52vUH+mJI4o4et0M3cEy
         AhEGifw/l0YIzAuCTdHyh1xT9VqPkmP5HuYj1Sn8FuXX7pjoAYs6I0ZUoh9usF6UFwYO
         lymmOFYBhM/H8WQcSvVUnEEP+mBt3hvhRQktb5mg1+RBL44Et8mu5QItzET7wsxsuTaU
         +1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgPH/LBErnNkK0QMk/+DCH3A901vgG3LLOp1ep5T8GecHIpeCm2+NHC6yODxHncNE/MiRhrK5Ajv89rt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxelgdQ2/SCISGdlshotTBJ3abAJ1qKIveZVgRm0Q5xmkb4VSRC
	Xmyq1r1bCq/Vl+ttZYsnQuioYAooj0LinaFWdvLg08tb7fQMBkHN2wpjm5l7MVEY39yso8LI9rh
	y8iSBwcoOE4GNRv3ThGYq0xK0BfJg1Ddwgpzus3gBFDHs95feTTeXQeSnz3t/KkNXmrs=
X-Gm-Gg: ASbGncv7j5mez4YnLLWAW1IikgvS8LKl3jXh6WPozmPHEB0/Fo9h1yN+xCLVHddlKQd
	OLIEyFrAPCsuYetRuPgjCC0WDAjCaIxLjqlzEOkfSg+5Mfksb6X9jHgLXsgT2UmJYqnBZO7yRzR
	eZZtAfxI0SXMsoqWLnz1UdTTHL/oGCUTEEAoQq0ihEtQGilZ77xOJpI8vjeO/MCCkPspY87//Sj
	TFSzYslRTEE/UNxuMTp7Or7b009XfSopzf+9Wfvz5zbfI4xjQgxy35LTkytFTKbX502QCu6h5Rm
	noIUWJrWEX1K08tBoJtzuqcySGplpcqESQmf0SxSiT9DLiba09Pa57HO2FHoCEaRia83JDej2CC
	ngdhqrTMhMNhMWkB+LebNzHOWAKI8hHnuteDi5B7KzVCl/biYoG3b
X-Received: by 2002:a05:622a:a942:b0:4e0:e01d:9b10 with SMTP id d75a77b69052e-4e0e01d9fd8mr40968321cf.80.1759138678800;
        Mon, 29 Sep 2025 02:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD5964wxBa34FImGPLm/8ZICEnP/mK7N2I+GucPncX7EMAJYQKfCHTslaPOWWcyM2ZGE+L0Q==
X-Received: by 2002:a05:622a:a942:b0:4e0:e01d:9b10 with SMTP id d75a77b69052e-4e0e01d9fd8mr40968071cf.80.1759138678292;
        Mon, 29 Sep 2025 02:37:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313fc205fsm4034625e87.63.2025.09.29.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:37:57 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:37:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 0/2] Add Qualcomm SM8850 socinfo
Message-ID: <2wk7sdt6xq7poqzhym742yvfvfdctq7oydhu3hdcwbev5swhzn@xxsyt2h3l2ok>
References: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
 <ebxbhaaefuoemadcef5h4lxfw2k2hwkfe72aubctqb3tk2zdmp@p7ck45rd2hy7>
 <6094ed8b-ddcd-462c-8753-06a1d58a9691@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6094ed8b-ddcd-462c-8753-06a1d58a9691@oss.qualcomm.com>
X-Proofpoint-GUID: koMDRKFmvF1UYvfSt-FaeFErfXgZEOpv
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68da5378 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=k9_RiEPCMvdJkSLYmZIA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: koMDRKFmvF1UYvfSt-FaeFErfXgZEOpv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX+tUJ01G0PVio
 COHkGBBtLQEtr/twtb4w8R7p4n6gNoLUdspEybZSKxImI1DAAJVeLl7qt62wMCGBYNxowQnYm9r
 ojMNoKUirQnLjccZIxZ42Mu69H0KyHzguoCha3ngp/ACDw6nxx8zewiILzluP7um1SGqtoze2Uk
 8bSRsB233iDHNq1wsZ/e6nTHjWdtqB8T8KWuS/WqtovP+nFVY1mFv2E+HDGfnnFnyiYvtbr5TRy
 uOb8o8CqknsKtpSlMYTzccGbz57QRdZPCTqpDkITOhk0+eDpO3PEibrbYgIP+zYynft8rflwg6a
 N4M/wijqBJybSPyY3rR3HQkRsbEh4s35oM2L7s+bYWwsndbKMzsgF5enJzGwdhp2hYjz1G2svc9
 ZOtwie/o+WTHSf5pdZbTzGMebelo/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Mon, Sep 29, 2025 at 01:54:13PM +0800, Jingyi Wang wrote:
> 
> 
> On 9/25/2025 10:38 AM, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 04:17:45PM -0700, Jingyi Wang wrote:
> >> Add socinfo for Qualcomm SM8850 SoC.
> > 
> > What is SM8850?
> > 
> 
> SM8850 is the soc id for Kaanapali, SKU numbers instead of codename
> is used in this file, like QCS9100 for lemans, do you mean we should
> add the info "kaanapali" in commit msg?

I mean that you should explain what and why you are doing.

> 
> Thanks,
> Jingyi
> 
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> ---
> >> Jingyi Wang (2):
> >>       dt-bindings: arm: qcom,ids: add SoC ID for SM8850
> >>       soc: qcom: socinfo: add SM8850 SoC ID
> >>
> >>  drivers/soc/qcom/socinfo.c         | 1 +
> >>  include/dt-bindings/arm/qcom,ids.h | 1 +
> >>  2 files changed, 2 insertions(+)
> >> ---
> >> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> >> change-id: 20250917-knp-socid-f96f14a9640d
> >>
> >> Best regards,
> >> -- 
> >> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >>
> > 
> 

-- 
With best wishes
Dmitry

