Return-Path: <linux-kernel+bounces-855241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C6BE0967
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AD30357A38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370330C630;
	Wed, 15 Oct 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oI0tZ5hX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92391DB54C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559062; cv=none; b=SrtX4XrVIBIDGP6z6mqOwPiklVRNPu/WRMPevDZwCQmwzEDILzjTSyMsu+XroMoLkW+yiKca0dPUcguFsMItqHdMSlh+f6ieTmnMIPLAg90V+CfHJdWHG9j8Pu8CW4bDQ00B5f4zSEQulcit0Q1BP9CLmYbYpFNCPQzDAm+gdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559062; c=relaxed/simple;
	bh=sL8XlQVWDbCwMxkOGY+GElcggW9WEH/bRfpKika/kno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWjp8NnPA4/7lLsXNQQLgnRnKctW4c0M47xP0u4BPJc+PnBHgrcIM6iUYGVYBxwnWShmLFvIJBu71BgVakOJavzkaOIpat0stujfVILR5SbKf+qt20Ks1RI+VrKixaj/WHqnWG7AG6bxd+pbEICOVFD496LGt6QumkG3GNZ2AqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oI0tZ5hX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FHiGlH026136
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/t1dCpZdqV7X1GUFpSEVkBel
	pnG5Nvy1baTgwTwFhOQ=; b=oI0tZ5hXRsmVkvIp3yVduM/Fb5Ze08QMasknNW3G
	KR90J6rTB3TA6qEr5k4rZGFN8MkvuZhziUONN+OWllEQ0zTgpwrTJp7r7k0CyAkL
	uWGTVA1maNugwqGSW7Jb4iLoxQxC6csqeF95N/ZVsVfDo/YW4vs2Fbm2TRX6oYsJ
	OQxmQD0DKXRZIRZZaIBHwqIbLsBzUE17U25Br0SU8Zh7veibg4k0zodmDddYsDTI
	12V0P7vnQUydLZUs2QxsA6NaAGuNu4jTKSm8MDwCty3p6Mkml50Aowzwn3uU2Q0O
	dMPQ1qyqIccATaJ5Xy2lpdub07plqyxDGOhhjNM6XYV9GA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0wrve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78f6250f0cdso487316d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559059; x=1761163859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t1dCpZdqV7X1GUFpSEVkBelpnG5Nvy1baTgwTwFhOQ=;
        b=kyzF9AeVxeh9x7SVI+Y5qW63zUQq3fONJiXB7wxwyyovAx35ApMSU+dq0HdALR6eZN
         xjROpBgpQD+1DTBgPKK0q4IYn5fwDnwrAyys46YWMs4x045bjzUl9JirszZRfDgTR/pQ
         d9xDpYh8jzfMm7Ha2aDpGhMy80luD1jol2c9oaj9nAAMh2KgeP7q0IT7PiYGSf9BvaT5
         sFxJjiEjy6AymhmnTibS0sTPyYntlZ5jxTNV1uyrjn3iHr93sqrub50WxEi0H7SrmfvN
         00ASea6bTTkTZaHG3zHOoUVZHfAfrK/keGA6Nj8oRhTOT9AgyO7X/B6xSff7rMtwJRWH
         vHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSzFuSLTmk9FUQWyLK9igbDTh9SIQNL3Q1nXwf4DHvoqGxFhz49MfkoOznxzniFcqixHeMC9oVZtZFenw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHenhLxKd4IMUd7LPd7bdBAcWUqvnc6C3x4GglLVVwcE5bUEUG
	HMYdGXV6q3Cys5q4CQjlVMpn4EK1SZr3hRhjAwrMc6gUyJgnnzkQ81xo5i3j89H4Ve5gO/iHnuY
	bCD1nSTZgVvi21MF0APWM9ReRtudZtqwttonvtQ6CpPhmn67PFmycQoDpfulpbGOlvf0=
X-Gm-Gg: ASbGncvm53Hkg1w/vcml37J3Ek3PuYrojy0pKAkaAWsS3SWQnhJooQsm3cz1NbBv6CX
	w2ALv65xW03hb1C0lLKhjn1WJNpBqmY9b9PMAsRfwuKLBM8XXwbdrcrs+pEbnC60sO6yDoUmeC/
	1xvl68ZyAAMlse6ySpYmD7OQDNXHsG4nAS2tC1iHn/88N1Vrvn/EMirS/F1IKlewn8Qh6K2kMk0
	HrqaJwQXO9TDFbDmGJgDHMBqfQiFRLwR3Q9vs/ziD+qX5JoD7MrRlD+A3CBVJiIG4UEiquPS6xQ
	qypHNX0iDN3DJ5tLOTj1me5iqyKHjJvOsbM4sFzicKKkHAXcxUoyh/5sSNUBXsXXJPq19czvb/G
	yo8Qv04jKKd/iNzmtWYAUkOV9+yqQxrlupTb0P+MBgMsIv3yzAsTL
X-Received: by 2002:a05:622a:1894:b0:4e8:8590:f9ab with SMTP id d75a77b69052e-4e88590fa77mr43148831cf.60.1760559058834;
        Wed, 15 Oct 2025 13:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/vQDmK813/cqY6aMyybRLQ+i7/pAaAqNshFsyxlW1nEMLUL7OVwu9YAiN7ac2zmKIZfOPGg==
X-Received: by 2002:a05:622a:1894:b0:4e8:8590:f9ab with SMTP id d75a77b69052e-4e88590fa77mr43148541cf.60.1760559058211;
        Wed, 15 Oct 2025 13:10:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577f2csm6516484e87.107.2025.10.15.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:10:57 -0700 (PDT)
Date: Wed, 15 Oct 2025 23:10:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
Message-ID: <56fcl2ip6ecu4inig7ecpjt7qrsdt6sehkrzrk6joysbp6tea7@4xdgxhhe3aso>
References: <20251015-topic-qciommu_bindings_fix-v2-1-a0f3c705d0f3@oss.qualcomm.com>
 <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0q2SKr+zS1SU
 DWw6djSPy7dYX97aZpYcVLf0+K5akQT/sdtzy6dFLwME/Ir0L4v+Zj/nSG4xucfLKz7J4SzsH4c
 3TzjaNYOFfRh03uToyQf3ObsQw5qdihS8jqExB7C5weZnR8vbq5iDTRqbGzvtf997Mxp36YjVK8
 aSXQCn78cpIKPiTuD/Gk4gC60n2lUI8uKXe3u0gKg30K78ztmbt9UibY/UYqaTvbjtQb8WBUNvf
 UwE5dxx5DjWzrLScmBlRnCRml9YiMyanSz1qrVNDJeURNxbboEq2WBRwRYdPJcyqja5CUbji5ao
 Fc+0+17bkXbb4JXCl1pPfmqH81vC3GMXpjmFjw4qA==
X-Proofpoint-GUID: oYhcsqBJpDYHOmL56SpRJCWPN7IfWTum
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68efffd4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=0xTHEX-RkNz-9oJQ5AgA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oYhcsqBJpDYHOmL56SpRJCWPN7IfWTum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 05:48:05PM +0100, Robin Murphy wrote:
> On 2025-10-15 5:41 pm, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > Some IOMMUs on some platforms (there doesn't seem to be a good denominator

It would be nice to provide some examples here.

> > for this) require the presence of a third clock, specifically for
> > accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.
> 
> Hmmm, but isn't the only thing that accesses TBUs the consumer of the
> qcom,tbu binding, which already has its own clock?

qcom,tbu is only defined for normal arm,mmu-500 platforms. Here Konrad
is fixing the older and more obscure Qualcomm virtual MMU device.

> 
> Thanks,
> Robin.
> 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Resending from a 2023 megaseries, no changes
> > 
> > v1: https://lore.kernel.org/lkml/20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org/
> > ---
> >   Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
-- 
With best wishes
Dmitry

