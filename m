Return-Path: <linux-kernel+bounces-853418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24BBDB9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C84ED2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680D30DD2B;
	Tue, 14 Oct 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3CZsYbl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D12FD7D9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480342; cv=none; b=hejrHd8vlNdxYbTs4spy80QM1YQCUTxT0aJlcXLmXyp7NeDKPs1U8lvQKzcVWuhtlnwVsx+9Hukf9bnrjW8XODyjGDjj9M6jUWFT9R775bG0Zb1a8gLCcKNZYj3mtmJVAsH4ywtVwL8tHGRvnAVgrhevnC/JhIPPapaquaHhjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480342; c=relaxed/simple;
	bh=BgOEdwjIa0sGaBXDZWeP/zbioOzpk1ibfhXUvrGElG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx8vtxuQpPsiUyNu+xfUljvSXC3ursnfi+e1bcOSRWgNPtlbNkajCL2iNHBRzXJ3tL4gdOq5g344cWcit88LHTv48Pi6Wj4AiQ57y62oSuZHwF31yYnUlDP1yNqDirbT/5NrDZ6poI+GjnHkxhWKQm58JrwZu4KPrjHjq8T5Q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3CZsYbl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKROj7014658
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OkOpBf2jHdOpnY2dKRzZfr8A
	V66mGASDdTGyX8Gj1ZE=; b=k3CZsYbl6IVyzJiYvjp8IMg6+AloVJA7TyNccJR2
	QXNEHf1jD8GjHqD1oVkHRGP0GRO5oSGwFxDnXsev31VOsqRzUd/CN9CzFu8A5dor
	ViykUK8LI+t0cFXFKC/sDl3nertJ7Jj0NwFT1VmnohUoInfTxP5X4ipTnD9jGHme
	Rh9bALdkV0OO4SU426F9KVXeAUuy2peF74Z1yloAdoGufSkYWorDo4GN1b5ojhy3
	iOG2OdCDXSLn3vypuHgM1UvTeKRI2x9xxzNmgNi3Lnep+d+O1XciETJF0P5lQV8K
	nnzRmAsED9vCAfGp2EVIYFTIvPXZEQAaIPTnXedTZoXWgQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdka66f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:18:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-829080582b4so2979552385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480339; x=1761085139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkOpBf2jHdOpnY2dKRzZfr8AV66mGASDdTGyX8Gj1ZE=;
        b=IFY38JHDYCvR9LvY0WKBUIrNGi8vKtmTusPlDaArOy2r8KFQ0kpewG64DFTlv8WyZt
         qODO9FblANwYxB8k8KaqRvqzQfbfcjH1FwLqbOLzLv+pyzVUgUOu/R9rxyQ9TV+b0EmH
         g5HQrKdjdthxVYxoRbIHyvXn5Zpxy8VJpA+GlnrMM9tlHDgI8s5H+gt44BRqFi9zH6lP
         JjrHJ+UrWAJe8thLXhmZsPMGmqwKFp1RVn+JVdQXMEFBqMG3CboBVT96uQt0Bwav/raC
         V1AJu/CXpATjEbN9Cf1Iw2PTCor0CrNrIo2k04Fj+TjYWUskoREx59mHvL+B/MxKdcJO
         sbpg==
X-Forwarded-Encrypted: i=1; AJvYcCUnhFPRknO2wkq1IJDLolVLsVCGxMKroTYvR2HQ/rUzuq8RS4dHr29iFeQzgWFGOM2ztpPf/d0+vzNMt3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWQwSJpFoHCdTxij+Hqtk8tsCuOr/zwqzFy9ky8mY6fSPVrsO
	OKi+9zPwzc5cEve0DaPrreXh1dldSz1fKJe3rlWMLrRbfJMNwAqgJm84ykJFRc1NaUWTvPVgOCe
	JqEEmb0NyX/uGHbaDZwDoJnxyuPeFm+lDeUldiwqI9Wg+u9alObZMUHMpGQjdAUUvcZE=
X-Gm-Gg: ASbGncvxDwgwf/10KkBUD8K958s3jINqukbnydhhHExKJmm+It00HKA0f//iiKow+Nn
	wvwaMjVc7T2/IiVOX5p3b/oWLMEm3Co0+u17P2eYNctH2xg0RHo65x42qLeMPJDtXE0FhRiysd5
	L+R0qb9s2tI+CwKQO3xvH/Q8DWu4UpL0RpeB12DD6udjj1kIpcQa3jJScehy7DLQh4D6LRtYGl+
	Pgo758JjNCSRd1bfDgBKP6ke4gtTmbld8iK+nw6SFPp+7gGdLaiD2sGQnP+Z0WLq6rZ30RQ6Rlo
	SdGgNKLuixRPB9TofzeKMy6XRhaxNoUUdz7koA8qD8G9uMBc+XnmuF17GKQXQOghXJQ6m+STaey
	1JFkO/f7KiF13aZMafIynsNG8dODJISQcpc2cN8rep7n26EJQuQjy
X-Received: by 2002:ac8:5dd4:0:b0:4c9:65c0:7e46 with SMTP id d75a77b69052e-4e6eacbbd09mr386007801cf.2.1760480338868;
        Tue, 14 Oct 2025 15:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoofHc3p3XoPw0ntgLmVxwJwo1t56LJFp9p6rCx/UWs550Z24zInc1mT131SYTrfrcnEeFLA==
X-Received: by 2002:ac8:5dd4:0:b0:4c9:65c0:7e46 with SMTP id d75a77b69052e-4e6eacbbd09mr386007491cf.2.1760480338443;
        Tue, 14 Oct 2025 15:18:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088212380sm5592069e87.58.2025.10.14.15.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:18:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:18:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org,
        will@kernel.org, saravanak@google.com, conor+dt@kernel.org,
        robh@kernel.org, mchehab@kernel.org, krzk+dt@kernel.org,
        abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <mwthowuei7pcqp2b4hg5c45n47iakclkioumc6diyznhnldfv5@wloeoys224bg>
References: <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com>
 <hOs24ZavnUyKYyNwBWwRpYnrsefzBfp95yuy9zyp1ByxR9_3VacGX1Yntt8pCE4w3gllPwvevs1AZqghmwKoFg==@protonmail.internalid>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
 <a4WDx80rJP1GnGNEK0OOD5lh-m-MiAvireXdpiM9ETLKZ084sBJ2UthU_QqRbU_nwD4XtsdiyEqQ0AhxguzJ6g==@protonmail.internalid>
 <6gx74wxie4wcabq27wo5y7v36uuurez4jxlzanroepqazdlgtw@sdtv2ld47d3q>
 <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org>
X-Proofpoint-ORIG-GUID: RY5Os-9vbwKle-6RrDIRYd-35HTzFngM
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68eecc53 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=GN0BuYHDo_BzztcbwqwA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: RY5Os-9vbwKle-6RrDIRYd-35HTzFngM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0NK6ecbfuN2j
 x35KCnnGFUUyzbtcRc9ogm88V94jh/xdEVGDDUerL0VtKQ5cLEydEqKbDBJK62agvQJen9HVIRH
 LodnTJp7sy/98ppf8yywff02n7jjDw+9jQ3Jw+sJ17nNMPVZqXl2/u+lmW/H3umA/GtGu4PHHE/
 XI1eOXTAhjHrM+J3r1kWnhTZ5QPmA+skewYlweQ5Z2/1kCv01+iNLbOg0un2g6hEoPhYkZeXMQu
 EVXKuO1vv4ujvC2ErWP6JVpVsjIKbyBFpzlB8QMvsib1SnmmfaqK8QxCKltVRA5QukAanimJgMd
 JG/Vc1RrrXmHckuI/6Eve8z2Pb0MBCAin4WLp7hKETNfSJ7Gv8LjHKeWLwdaXfpooPv6ONxbrM6
 mQnuCbONLkiRK7l747cleNNR0dMYFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 09:49:17PM +0100, Bryan O'Donoghue wrote:
> On 14/10/2025 19:35, Dmitry Baryshkov wrote:
> > > Each function id can be associated with a device and a compat string
> > > associated with it.
> > So, which part of the hardware is described by the -cb device? What does
> > it mean_here_?
> 
> The non-pixel path video encoder, the tz video encoder...
> 
> What's not clear about that ?

Where do you have pixel encoders in the fastrpc device node?

-- 
With best wishes
Dmitry

