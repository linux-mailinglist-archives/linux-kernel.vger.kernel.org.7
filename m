Return-Path: <linux-kernel+bounces-848929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED110BCED72
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6824E2649
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79886D1A7;
	Sat, 11 Oct 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBKHJrrS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7662E40E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760144108; cv=none; b=uxCVLDhyVBjRX3OdyPHAX2kX6kjSqTUarWFrT6bOywz/3XlxbM+8oh/N8HbTSgXO07LtiAMKMExGBwH4tJ+i0D0XTz48TyQzBYuAAt5wGn7ALcGYmGUXVbSyPBnIEPS82R1nAkAWpWSthdra6JxHDIcqTf2DbGWUzTvCeykrNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760144108; c=relaxed/simple;
	bh=vi5IL7gL2WbF9PAP2+XIfl5Vm1qsFPHUVEzsR7J8UBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX3rnpHBwc/6WaskXVPxQOLmdQ+CiajA8JGVqGrsnS4y2KmhMhXQPYAVQTEkbzbB5mDdotqdCqarN38/l1YgduwcPrB6dE9BPDiFTUD4GI1ZGC3TZLV/Nuz+3E86qDuJICihdSRutanhqtk3vD0STD5mB/KkDDEoIE9zyMXaa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBKHJrrS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59B0QnqD017760
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zElZAglfow04KlHk8Ohc4+IvGBRtXWc8AJ3vgbED59o=; b=PBKHJrrS1zktZacW
	tsVoa60FeJKDj4hN1HwyV39ejelQb56msQXKXTI23qEPX+zEiIwtFDOIiJ5ROyO3
	L/ztItePqUTEtzXJj9zeZ6sYnYM1A8gd1tBuVLRvqWDJrwzPUN2HESgSNOz/sdaa
	x8IXByEKLwprfIdUqhRM4A57Qrg0kTdRSb1cbMo9S4yXJ/+cRBt+BF+MAfleDgX6
	zN23leaOXnjNI/fSrl9PcCYHYIdtLB0a6AT6X95JBV3I0vSyPpvr2g0x7tdB0xh3
	fpvH4fpzzgGBOpqBnCDtjC+ymexO1vMhPakM9h/DZgDBjh8jmIJdZq/hdrJgeL31
	yN+ydw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m82qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:55:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8589058c59bso1850339885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760144103; x=1760748903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zElZAglfow04KlHk8Ohc4+IvGBRtXWc8AJ3vgbED59o=;
        b=Zo8bHHtgSREDsUCZ9jjNaOs+cJjmnCGA0zHqejn+bjSsyWANLaNmHjYZJJZTfLgIOQ
         IlKJQ5OTgk5YGu/dB2d3z1bOYbBpXjQgfPWu3+azrX6Pt7vNIZAkzfX1lpCnLiF5FM6o
         BKIdo/JhsDt+EAdEZewCV3I6xB3xOwUVDymRrtwJLlOKF/IgWys/7VM6a5bD3XY1/iIS
         ffGL9oOO5qYRXtOJ+xKivx9970mx8PKdnCc9Kg4eWcbmrReq6nDIXBbwR9kjDiEQz+F9
         cM3xds7xBr3DJPPEJ6fSWxhqzJoe4hoFoonttWAvTzjw0Cs3cvKvaO882rp5x7nbkQdG
         rzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWocSZVjTvvGXhjGhHrDdAIXVXDCMBXDT1mY7XBQP29MsDz0khCXD1J/awSJimPT5TWw50yx/28R3+xkIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ce+DR/Ohh9pAOsNRYOAqg0TOgy6kiWE1bB6Qzk3VMc57jMF9
	zdSNRGMQ6AONlNN5oLn68XMDq0lMxZTjZu8OGOSyDzlFpHKi8bbq0uKZzGkGZEk8dRQcLHQ7YRc
	DK8qaL2PdBS9yR5O5/0GOqLbVuvZtm+biYxtevt4/tghwIuHZk0eFrQKwKbZ3tysYMn4=
X-Gm-Gg: ASbGncs0qJCs6cmenZZYZnIbEbedOS7NXVdUZbYeLzRy3HWBZsGnlHkaeAkCHUPB5kP
	dXp6jKUGqBVS+bAuaGiQDLhc3Zi0HOTACOHCJ1YVUJKTKtRNkVMI9s5llmH5wEAjTNCyS3LZlWl
	E7eZ3w9SD6vZZu9evlkbOk0I4czJWz0ViZTO/hKsLXe/YvhD2miYkIFFgaYkdoSnloITJ5QRjDw
	otF2q3o+sqw9zTXql0uvvBdgcAaUR8cFZ5lqw4+HwAPFFYjUdQ4uxDGqTHzxGjYVwiSVE6zSzoP
	2Xs1bbdX0yzbQYlsahe8p+CmHKsLib/1zx7AysCyBuTojOvmVFDod+yoahpVnMmnrIio1JViF1i
	pJtX7NwB3xYzOWIOkJRp3Qi5nP1sm62cyfK1/6krpFY68qa5VTveT
X-Received: by 2002:a05:620a:28cd:b0:85a:8ea3:6bc with SMTP id af79cd13be357-883530825dfmr1952570485a.76.1760144103047;
        Fri, 10 Oct 2025 17:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBu5SGEW5C5gP7CCF4QRIhTixeNmjP2vRuCHeD0uAcIlHgu237/1p80MfhyPqdzhEljr1ATQ==
X-Received: by 2002:a05:620a:28cd:b0:85a:8ea3:6bc with SMTP id af79cd13be357-883530825dfmr1952567585a.76.1760144102348;
        Fri, 10 Oct 2025 17:55:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563ca7sm1374441e87.76.2025.10.10.17.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 17:55:00 -0700 (PDT)
Date: Sat, 11 Oct 2025 03:54:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        saravanak@google.com, conor+dt@kernel.org, mchehab@kernel.org,
        bod@kernel.org, krzk+dt@kernel.org, abhinav.kumar@linux.dev,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <yoqrve424xt54wbuntcrksh5nwzekntwqgbu4rzy6v4ekwzjej@mpopdkmzjrd4>
References: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
 <aec0f40a-8346-4194-8b18-1022fe3366bb@arm.com>
 <0d0560cc-9757-4c7b-8de4-170148d99481@oss.qualcomm.com>
 <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
 <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <c863f6a7-b117-4444-ae6d-1d525b572be2@oss.qualcomm.com>
 <CAL_Jsq+LPpJxVRUP4b9Gt40t=Wr=2B+697Jv2sjtDqTpqwGezQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+LPpJxVRUP4b9Gt40t=Wr=2B+697Jv2sjtDqTpqwGezQ@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzHZkvwxM1BeR
 +Iq2EhmQ2RWeo7pO+8ukPdltTnGKBzuVIsegf+kXNvEvD624ScK8wFYBxLIifouDgt2+BwBkMr5
 v7nJXl5WrLTYLhZFUa/bwv1nzIn/sQ5jFz1IQmUGvVStcH6PRvGQc9lCYmQxwrXPFlHo1INY2sQ
 Z7b5Pge1eEQK9QiRSoMzDHoLAojo0yt6vMpL62BPi2d63sLYe6drhK4scwDpPvqgYJo2be23CHU
 J21H+nl/go+FUK1c9J0m8BEZ6fS/3VFxJtOLqwvtPmqINtRV5xm9pNjrF7TpCScDXR3S++piWnB
 4DHwC05xYdx5MBQIP2hqBsTK1mfhPum2G47jixux3UV8aqt9l8VSyo6oC53rzXQjHA1zYBhpOJS
 zZAdrgektF2qRixOGeDOaiJo8Zrnhg==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e9aae8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=E6X_DewmVMaNMEPXfb4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: onyFCLlSBupd_pnuzcrIF2dvnVF_aWeR
X-Proofpoint-ORIG-GUID: onyFCLlSBupd_pnuzcrIF2dvnVF_aWeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Fri, Oct 10, 2025 at 05:30:11PM -0500, Rob Herring wrote:
> On Fri, Oct 10, 2025 at 2:53 PM Charan Teja Kalla
> <charan.kalla@oss.qualcomm.com> wrote:
> > On 10/9/2025 11:55 PM, Dmitry Baryshkov wrote:
> > >>> I really don't like the idea of extending the #iommu-cells. The ARM SMMU
> > >>> has only one cell, which is correct even for our platforms. The fact
> > >>> that we need to identify different IOMMU SIDs (and handle them in a
> > >>> differnt ways) is internal to the video device (and several other
> > >>> devices). There is nothing to be handled on the ARM SMMU side.
> > >> Huh? So if you prefer not to change anything, are you suggesting this series
> > >> doesn't need to exist at all? Now I'm thoroughly confused...
> > > Hmm. We need changes, but I don't feel like adding the FUNCTION_ID to
> > > #iommu-cells is the best idea.
> > >
> > >> If you want to use SMR masks, then you absolutely need #iommu-cells = 2,
> > >> because that is the SMMU binding for using SMR masks. It would definitely
> > > I'm sorry. Yes, we have #iommu-cells = <2>.
> > >
> > >> not be OK to have some magic property trying to smuggle
> > >> IOMMU-driver-specific data contrary to what the IOMMU node itself says. As
> > >> for iommu-map, I don't see what would be objectionable about improving the
> > >> parsing to respect a real #iommu-cells value rather than hard-coding an
> > >> assumption. Yes, we'd probably need to forbid entries with length > 1
> > >> targeting IOMMUs with #iommu-cells > 1, since the notion of a linear
> > > This will break e.g. PCIe on Qualcomm platforms:
> > >
> > >                         iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> > >                                     <0x100 &apps_smmu 0x1401 0x1>;
> > >
> > >
> > > But this seems unlogical anyway wrt. apps_smmu having #iommu-cells =
> > > <2>. It depends on ARM SMMU ignoring the second cell when it's not
> > > present.
> > >
> > >> relationship between the input ID and the output specifier falls apart when
> > >> the specifier is complex, but that seems simple enough to implement and
> > >> document (even if it's too fiddly to describe in the schema itself), and
> > >> still certainly no worse than having another property that *is* just
> > >> iommu-map with implicit length = 1.
> > >>
> > >> And if you want individual StreamIDs for logical functions to be attachable
> > >> to distinct contexts then those functions absolutely must be visible to the
> > >> IOMMU layer and the SMMU driver as independent devices with their own unique
> > >> properties, which means either they come that way from the DT as of_platform
> > >> devices in the first place, or you implement a full bus_type abstraction
> >
> > I don't want to dilute what Dmitry is saying here, but the below is what
> > i can make out of Robin comments, please CMIW:
> >
> > iommu {
> >         #iommu-cells = <2>;
> > }
> >
> > video {
> >    iommu = <iommu sid1 mask1>, <iommu sid2 mask2>;
> >    #iommu-map-cells = 2; /* does it look weird to define here, even if
> > it is SMMU property? */
> 
> No, not weird. interrupt-map similarly requires #interrupt-cells. So
> it would be just #iommu-cells here.

The major problem is that our DTs already use the currently-defined
single-cell iommu-maps. I'm not sure if it is possible to support
old and new semantics. So #iommu-map-cells (but placed into the IOMMU
device) might be a good way: by default iommu-map parsing code will try
parsing just a SID, but with #iommu-map-cells it will use specified
number of arguments. The only question is what if #iommu-map-cells !=
#iommu-cells.

> 
> >    iommu-map = <0 smmu sid3 mask3>,
> >                <0 smmu sid4 mask4>;
> 
> But you only have 1 cell, not 2 here. The #iommu-cells in this node
> would define the number of cells before 'smmu'. The #iommu-cells in
> the &smmu node is the number of cells after the &smmu phandle.

-- 
With best wishes
Dmitry

