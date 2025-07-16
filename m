Return-Path: <linux-kernel+bounces-733782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D1B078DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AEA3B41CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEC9262FC5;
	Wed, 16 Jul 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9mAF7cF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C4264630
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678021; cv=none; b=E8EbHgJY/Nv4ipMe7mC5G8NOINfh4+dH0RPVFQwu+a9B7bYXfHI8nZT+pzpdCQT8Nfqs3ZHM7eLKDDIbnKtgrjLkgyTE5AkdeJqmkbt3iFF9YjMjSCfvcPrBiotqsQv0hQc8JnTLfBGr7BNyEipncTCrr8sYXtiPXou0QRlQIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678021; c=relaxed/simple;
	bh=BwHmnv73EJxa8pAkw/DD9qciTC2+e5Jm3oOKDe6id+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXMicvgj2ecOUYUCYpmG8iaDpHQMSNLKsdsKv+tBRVMOQDryod6GGyKHsiOfARPXFkaly1RK+E5P6cWxqfyiT7vxggleO6+EUDIaa4ce9Mwdqy7FrfEwu+/mdhsJ+OedqXkrJomCkWve5y4QJwyOJPR7n+PhhmakmIiDsTLqpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9mAF7cF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD0MGI003402
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CAkscxFZ6HPZNFfbizbkemU9
	/nA8/uTZ5nzyZGm4eYY=; b=E9mAF7cFp0O/oPxA23hAjZCE4ukdBn9E1ECZekk6
	J0+L2cXbTsuT3r7zPG4NJB/hvxzGebmbWlvVQ4kotzxbVOo6ISVGkINW0f+aGhuC
	wHGJ7Td3R1MyznuYDavStZnjviMYjrfuahkaIIe8xMRNRpMU4fopzsNnQewUPJDD
	VMJAYftLkowOIlY3mm8BlLvQpjOXVY5P5rh7mg2Fsq8LHLQuY/zno7/5JVxHGXf3
	/o5Jel+vQcJHu/k41qnnrmyjGRGO4Km/a22LsJK9xbGeTSGuJUlS4FEECh7ewyk6
	lTLl8th7wzxEUx+Bbt/KdksQykh1UWpjrlpwv8WZgqBBxg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drqbex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:00:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e1b7fe85b1so668374485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678017; x=1753282817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAkscxFZ6HPZNFfbizbkemU9/nA8/uTZ5nzyZGm4eYY=;
        b=hgISsOs74656km6dIVB3FTQ7rZU0eDn8u23WSOx7Utyra94gaceUMjJIn6+u900+ac
         vCZ+eYj9xqEHP2IuSgaVHA+FKH7mJLvfhGM3JOFLIXmm/GPrDBA1ANRpVBLLJbJAVwdv
         Y+5CvTq4ZB6TMfA0UPfavKnnA493PhPS7OkuUvs0jkF1jCQMiAY3Hb4fqd6xFiAWns3U
         HjFlMm6+nZ0H2bUAzu5p0/fgm/UCvXZcEs/sWWewG3+i1CKJYWw8smxEPyNVPdfkRudg
         cVbeGbeAF9xWW86qWLaujAy1y/jddR4bm7dStw7pwDetQf0twV3jqRHgOs7yFUflitp4
         nztg==
X-Forwarded-Encrypted: i=1; AJvYcCU2g/JCOpHWO1WRYv2GDPLHjkpo4YG29i1by3WYwpoKfH6Aw39iIheg04rzujFCYYTnfAsqMmHOLDMsPx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/y7if2eqskDOKtiFqa0N4zzx8qRTsDaFoVCcGicEKdHjPgoC
	7/BlWD7ds2h1m9IgpWsUE/QyuVjPPbCuLaVFUPIl3lKniJvkekOwkvICdOsqvDwf3Hznv3tSmoY
	cH3ckDekgT7joWQPzAid9GO3L57sZ+D3GSXzb08hdjrGOrgOHnRBPlwCMKPj/O+h+r2g=
X-Gm-Gg: ASbGncuP1vtYppowhlM+mUVFSpSTDyOXCwcU/0Ch+qhDMZXO2WIUQu+b3JU7TNyYXCD
	ASxsp8B+N3/qgp0JXlNWQsemrWer+ugfG6CeeaYuVDWL3MMfUjPZQ1x/zfRG9VDMdEIrIxDfKwn
	S1hBRri4R5bPSSBoiZyewtcyuFW9u4BGBI+GxT63E5bHOgrRj0DndMc0zFZswRFPWbP+jNX8hnB
	pR74cOnHxkH/XvL/nyJ8y+8xA8Gljy2yok3fA7TYWtjrI/IqCJkJo7Owshu2NUogQkRCpmWoI30
	bl/ODwPjd7hTLyggO7pnSjceep43wk3tcKBmTF3KOm6Qn/ZSv9gynMkTSa3Q5ptW5OcsoCWcONQ
	7XArtr1DSEc96+5uijsaXURmnUNEWpQDsj4Oyx8TEafH7RaXu48Ig
X-Received: by 2002:a05:620a:31a0:b0:7df:dea8:6384 with SMTP id af79cd13be357-7e34362a36cmr473587985a.47.1752678014551;
        Wed, 16 Jul 2025 08:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXmj8FKGIbR1WpW/ts2gzvh16kMRBL5dGL7A/pS8FbIBPN1NfTScfYvF7qf91Ybpr0sAjHog==
X-Received: by 2002:a05:620a:31a0:b0:7df:dea8:6384 with SMTP id af79cd13be357-7e34362a36cmr473573485a.47.1752678013808;
        Wed, 16 Jul 2025 08:00:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7927fsm2648229e87.224.2025.07.16.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:00:13 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:00:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luka Panio <lukapanio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/3] arm64: dts: sm8250-xiaomi-pipa: Update battery
 info
Message-ID: <tpv2xy2ycbzacyqlcztrvyd4kmiyocb7qbquit5rar2c7wun53@llrdpzhdyvnk>
References: <20250716141041.24507-1-me@adomerle.pw>
 <20250716141041.24507-3-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716141041.24507-3-me@adomerle.pw>
X-Proofpoint-ORIG-GUID: HefyTrIdZ7JYB5XLnDvUN05sBoIn89rb
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6877be82 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=9pW74NbYAAAA:8 a=EUspDBNiAAAA:8
 a=oujwet5aPAZ3wE0JuRMA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=67o8LzlnqLyy2xoPAWJp:22
X-Proofpoint-GUID: HefyTrIdZ7JYB5XLnDvUN05sBoIn89rb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNSBTYWx0ZWRfX+Nb7oxNLy8Gc
 simkE5FWH8OHyxy56YIZK5HlBMdlES4DM9KF1lWKbP9OwAvhuIzazp2rSwlHC1U+VuYVG/dc5Nt
 H2xLHyQFNfh41UvdVf6Eswn6kUbzU/YUXUNLVaNVJ78c49AgiJMsTGspaLRU1yfKC7WYyrdWo5I
 x/bfx3kU2/SbPuVmJSyKu0rIttHmAAuSx6PK4IDRgcY2w5VzrSE6lMN2feVRfNmkWOuoEUYAOnr
 37b9xIjCT2INaOhM2zyYyiGLBvWGeWnyTQJNskbXuuMXtu/GWdOTi4R12w+rCl4XIs+7ie7pSH2
 gT99NwNGGIjI0PbIDM7QQQWwgw3pgCrvQFPy6Nxd9Ih+zBeh4bd27doYn8tumNeSP+OdDCoH+Xu
 eo3kkFXTpFbPEA9+Fd9qWySDHB0rK5L7531iBiwSG7RksuqLBr1K3voo7IaI/UwIKdMKAiG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=819 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160135

On Wed, Jul 16, 2025 at 06:10:41PM +0400, Arseniy Velikanov wrote:
> Added max design microvolt. Merged battery info into one node,
> since pmic fuel-gauge uses mixed info about dual-cell battery.
> 
> Reviewed-by: Luka Panio <lukapanio@gmail.com>
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

