Return-Path: <linux-kernel+bounces-855384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82947BE1125
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 016AB4E9CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE32C8488;
	Thu, 16 Oct 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mVbD4ji1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6E17E4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573124; cv=none; b=Bbwa6zF5zQAXnmviRQJX0U3+9NJQHrQqrL+XSYqvFrXxG1dtU9vU4p3GEP/YVRu6CAKp6GrMwI0EQNJbZVwD3xw++NrwHxoSGmS4ciAyj45ig7Rm73svjHI6berDzEDcabyz2cR5967zA8zYO2Jh1WDu9uHqURAEuYJdZDcf2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573124; c=relaxed/simple;
	bh=Fax6VecnDWG9WfiWu3rGm/yJBg16kMyhvyosAjZ8fYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB51IGOlj0vTpOrBuHHKuefYXfMKTXeIZ1Wmhbg0NGwycK0IXsistswNl3iufK7cD7KTrWR08uJfheE3jOCBkv+u0IPZrYpbPFK38qe0iKpCetEI9v6wFwF6grOaNVX9VawlTh1Q33oA0irlPI0wf8lXaNIZodHmY+dfvaW8wSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mVbD4ji1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKiLmE002648
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ttH9o+JKFt12U4z1bUTlIexU
	G6jcvhEibO1N+cM/DzM=; b=mVbD4ji1HvPHj0I8MTQbn2quhJKosorfDjRHqDmi
	vz7qiYp3yhclG7K3UIUh4Jw4sDqUokOwqsDjDWcDCeDD4YhEAT73v8Zq5orGwd8g
	nvUyuhS2+KgTbIlQvVPGQYw2goRA42L+yqGvFAx2GsHcvqcMuqpXpHgPWKcfEsvK
	nv1VgxufuYnUf0ZT9RzQdR8R93HsRcEzWNSoUdg/I/cfoINn9Cl7ZaEWXYsHvLcb
	UrJCahJKXyz5H2SfvcsZycMe7f/HNu4MtEt9Cw8fpLRPrrZotGb2Fq3t120/f3X9
	MmTkszG2aaxB9kSeU4VwnaZyXoGCa6YvhlOvOOxfURpYhw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd96e0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:05:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78efb3e2738so5660226d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760573120; x=1761177920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttH9o+JKFt12U4z1bUTlIexUG6jcvhEibO1N+cM/DzM=;
        b=Tlun10eqBV+h1bYVYDAwhWTs/jtnRzEgBdmsVsVo2HEy+y1A+v6F66B9t2Lb43/b1d
         H5IO/K51zqtqQSVViGJ5mwJsAqxvL/i3pjJzL2aqMuz+idZHJ7wrqBBVwDX6Tfx6R/qa
         FZdYBHQQU48qDhh2XIuhkszj4lcZrjxyMmvfhYETeIh4ArOp/KjSXydqWMbuST3g4QQn
         KmB35lMD4UwmIT644x1ir0IacIdva5gP3SMBDsuN3pcdXiCouaaaReVo0htnJ1mg/TZF
         gimb058wG6c4/BP+dFxQkM/otwloUQNAvCTpDRHsdadWc62pqScTQD3qs78HUd1t857+
         CUQw==
X-Forwarded-Encrypted: i=1; AJvYcCWlk+MDV8IQtxKrX0HqfOmjstS4HUscirRLc2rLU91SPyeDzdXi2fjzQPLQ5zv9AH9P0xgY/J6zxaJq17E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsEocigFQsYKskZMMMXqzBTwo4jmpAcDL6c5pAIYoVlN1ybS+
	oswFq6Y06VoSsVJLZfT55GMFbuDKDPwfheWTwsRNoUl2AKJbcbBG8OQ4oL7Kqt9hs6ud+OgPOqO
	qFPYwke86vCXltzkgWJpJ4FNPxxlroTKQQ0pASNFuQuxjkOYgGCV5VXudLOCVQRIurMk=
X-Gm-Gg: ASbGncvdNaxGhiVjmi6yJ/iDrv8He4wEb2039+R6wklsRCNhzEv5+ZzyG1jQOVNfEsa
	drtnfyo93aol55lp2ftPBmh1xnQL/oGZZlI98oeM6fcJLO5oqIqKw99WgtykKk0PxdEZ6RHM4cX
	9FCkbTSILoBrl02QaZwVM5sx+orHs0BFKuFUyy6pSnkh3eoCer8ACcfPhhqrzacudXCa4iKBaWk
	pSev6fg5DVDegpbwGyKridcDOkwtPx59tdZxth/PJCIicfJeSfoHcAIqVLWPX+TLnjI/Hb2vH+W
	+6+AF3L3qscbijBvpt6K1n2C/a+iA+tPLuW6JrQaGw3mMGS4Ct/s6Y7g0CzE1A2WossDIepvuFj
	/AD2Hsy9/3TD/Vx2RoXh3Nxg9h3ZtljpPfyIsKjBdhZzpRUwb9CYqJfbTqATIz39J4seKQvi9IW
	uH0Z/36ft9Sew=
X-Received: by 2002:a05:622a:4890:b0:4b5:dada:9132 with SMTP id d75a77b69052e-4e6ead709f2mr460284941cf.75.1760573120308;
        Wed, 15 Oct 2025 17:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHSdX8RqUU8RAtgjSgrc5QwEf9TAs3cpNtbgxxS9fE9uOnZFE46JhxPCkQd6l+F9bJayOlQ==
X-Received: by 2002:a05:622a:4890:b0:4b5:dada:9132 with SMTP id d75a77b69052e-4e6ead709f2mr460284401cf.75.1760573119860;
        Wed, 15 Oct 2025 17:05:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f8c79sm6592635e87.34.2025.10.15.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:05:17 -0700 (PDT)
Date: Thu, 16 Oct 2025 03:05:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/6] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for
 Kaanapali
Message-ID: <k7xjihanbqelhm6pytrugv73pc6bmspn75vy5a2thcqnxkzwhd@bsyp2nqkl5rf>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-6-84fa7ea638a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-6-84fa7ea638a1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: g-pNdZcm1troeudwWJGy_9x4dhzVHuJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXypNsVsXYGIHx
 iBrqprBp9x4WqZWM3xm/UTOsecnQ56Ps+fOkw236W/vZrd6gNu+2H8dJNq2Dn1d2Szq05vL7PF4
 sFUJRhfMnSKdDINYboencpr9AmLUBc9zjKh5MpsBhVluNK6/q8bf0M+3Zo190nHYhTij+1IwmJ+
 AvZToXjqHrpVJpA8StMEorpOxNYVQ8UGFYpPWvjBIGvXMDotIT2iCBIqPRLkInTgeGXEzV3g7IY
 UQvQ38xLh5CsF+xkRs1VtSPjxvIJc2JGFB4W9vso14a85ISRAHiNleW0KS5vrB30Bm+YwxRNc/c
 at90A6C32E04QVe/kMV0vxnTfko9fHP1LCO3om0YdU7u141F/8tyPAxRy7PscK4Nfbu9frlh0Ev
 sqYKQTTTe7Lg7R5PUwIFdYeSBx8JiQ==
X-Proofpoint-GUID: g-pNdZcm1troeudwWJGy_9x4dhzVHuJU
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f036c1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=tdoatHydnEAQPWUjzvIA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 03:27:36AM -0700, Qiang Yu wrote:
> Add QMP PCIe PHY support for the Kaanapali platform.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Who is the actual author of the patch? Do you miss the Co-developed-by
tag?

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 194 +++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 

-- 
With best wishes
Dmitry

