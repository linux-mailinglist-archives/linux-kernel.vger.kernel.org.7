Return-Path: <linux-kernel+bounces-777618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95516B2DBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2113F1BC5D13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769A2E62A8;
	Wed, 20 Aug 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOLvFsqS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C72E3AE1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690881; cv=none; b=mKexWmdruhMJJZ592MdtXey/neJkdpCOnn7bkybfArQZJdn6cr8FD72yJnjYnn4FnZZoJmwSHrsA87ByRfazhJ1uQq1vguwLw5UdSbh4hOg2TaZWSD3A7mM0kVnAkXWNhRvPvBA8a0a+LI4xUR+vBX0zDwigF0WS9IMnMZPm1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690881; c=relaxed/simple;
	bh=M/VdAQD2mntfC5YT7fKZskj7YLan77QmBL4eeQs5/Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHVrNrWkGKhWzZ04crz2D7A8lsBg2xkcoKZWrwJKk3ny3GhKT+wJHNe2yBz3xHZCGBhEYCib/wIV6xFFkcBd3pvtDUFAGWIR+K0OqCdDZ85B4VrnUdzRV5Zv+SQUJv5Hwmn/GNhrGhiiMEs5/yh26SPI54TuRv/37f9J4x68W9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOLvFsqS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9xaI1021351
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9hkspx9x0UaL3XQk/V0/oUor
	TUc0YPNibxHdtYC5rCg=; b=KOLvFsqSgDRvsUk8dBZIPg6ItXH5vgGC7fNxsrUo
	xlW01//Kqxv1Gog3ctPhAH9GDcrbgIGG5Zx0wQnw56uxBXAzIcsaSuEHiHnG5HsJ
	l5YqdlENf/QYmpaFeEKJP6uAMaTfksmoELauVW56uNPob+E44G3vsiwwxTle+XDS
	UNSsMkqOKKzPXnO13e11oeJhukfA7IB6FgDofPMopPNJFxXJt9tLAU5CUj5kbA9W
	99dkVgLlRwlODq4ZunV+1ueYlUFis/tXABZjwUzM2cBftWPS/O/HsF8+SVjdsKr4
	hGkxOlS9rL0kWUNVsTzXGHZDlQAFwCqeSALOcCEot5AQsg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5291k9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:54:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d7c7e972fso5956466d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690877; x=1756295677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hkspx9x0UaL3XQk/V0/oUorTUc0YPNibxHdtYC5rCg=;
        b=LHXyIdnGc25lfoPCo/s8kiqkZw2OFpGitqWjcs58032G1qyNeUGlr7MwM7R2r7624u
         /L/g97hmbKz6vH3nNPqKsjx1rYG8CD07vRaPa/Ae0bmBexbVMlkvcPUaNpaMJHEGwK9x
         oUWHnsCumxipL01ko5KF3xO8HB76NltJcdA6O0b5CpU6D5lqDoYHlPUh1kO0dPDXnPfu
         x/FQnwFg5wt8Sc4caaJRha/KN2FpslnCCuwY/fTWPSZlgUzrYETUg1gQ6qei/PA9w7s3
         n1vjHltvNoQKw+84K0bd7iNr9I/LZBpGyX1fKoZvb/VeRZS9X7VX0OR8fYXACfekceSi
         mdEA==
X-Forwarded-Encrypted: i=1; AJvYcCWxo6i4CuiAb4TCbcFvyd+CjMfv9v72Gt1MGq1D8Y6v+UvrbXEBW2O04eA2s2qQV7JX7eaMuyuj1oCE7co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3eU3W3ScP6RbVvOOZNdZQIhwPdU1qUkmsx6RexOG9Jdn5xBc9
	8XDbcA/KIsq5rqibovLetjrIilXE9+MkQD+8K+dsO9NqaayjmTf6cWGSAAUCat7/6HKeaMQsdVJ
	3vYBTKbxrCOxVpC0+fQoPxb74ngs3VpwLWlxGMDRyiB0EJroKjAM7M//LhrCFUcxLCZAnAl+oEv
	Y=
X-Gm-Gg: ASbGncuriTEFpOT5rgzMIhysm+UgnJk1Ok8gRE6EV7ZSQwuwVH9B0PY+4GwH4k9fr+/
	bFqQqLEJrRPem4NjJt286bnNrwIT/GinIly7pH0tXpA+ppWCdbf0Woq/8YH5T4aYhEQFR2AEM8x
	CJBAb83Rb7W38USY5PYl3DJ5nIF9dAjSAWaO2iw5rJeHS6fTINd2GERlfrr62mSwSKUZimFwqeb
	FXp2ubGVWmI4T86dMKJRiH8cYKlyDr/TKafgakGdeV82/mFaMCstrOWxaw7sGNQlt/CJqnIJvhN
	amHgVQJ3BP4488SNIg8MFyy1e00aUHj1kRLLOzSTVTmEqkqqAauodQ3mpnpJsrHld7OIpaOFYD6
	emdu8jGKOW4raEq1b0gdD8MjqKqQUQDExZDUXejyWM7V83GvwUrjY
X-Received: by 2002:a05:6214:e49:b0:70b:b06f:3d47 with SMTP id 6a1803df08f44-70d76f5825bmr26193636d6.1.1755690877290;
        Wed, 20 Aug 2025 04:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGgrTO8nnUT/lmte63CyExWcCFiml5AC0BmNDDeEox0FxHid6Ngno7F0JmrK609jC1RUQXsg==
X-Received: by 2002:a05:6214:e49:b0:70b:b06f:3d47 with SMTP id 6a1803df08f44-70d76f5825bmr26193296d6.1.1755690876730;
        Wed, 20 Aug 2025 04:54:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41e251sm29376871fa.11.2025.08.20.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:54:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:54:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, mani@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add regulator loads for SM8650
 and SM8750
Message-ID: <ukxv7donvkulgci2dwrokuflzxzeyh4kohoyja2vywropntxnb@qepcssbe4wpc>
References: <20250819222832.8471-1-quic_nitirawa@quicinc.com>
 <20250819222832.8471-3-quic_nitirawa@quicinc.com>
 <ger4kizeltjwalfuwu4dpfjiskrv2okgo5c7d6n3pb24yaxgfo@nkcndblyx3il>
 <b453b8ff-a460-4ccd-9019-aed746a7d52d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b453b8ff-a460-4ccd-9019-aed746a7d52d@quicinc.com>
X-Proofpoint-GUID: 6gjZJ68UJG2v0hgo83DtJ6KHGM5GHPRV
X-Proofpoint-ORIG-GUID: 6gjZJ68UJG2v0hgo83DtJ6KHGM5GHPRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX04yMhciEKnVn
 QYyg91Tcfl2IGRtTT9fexlVNBqzSZHySnBxOJ2n+3VvtVLkUMz/+zXM0w0pMwtYu/nMejPP4tEC
 1XTHDViMTOx1Y3xVFNKEw1MCmlGopRXfVyWReMm8c+QY78S1vl6LTF1L8HSGpCPclqRC5H3IBhw
 lSR7hOLcJbrauWxT36ODtb1IQxp9liHRbRtemYF6B/b+P9f9e2z64XZEUmrwBG0Loq6e03OU9Wu
 MRAc20G9fuZBM29EOKPh79hkD3OiM2JlRuP9OrTuDznSXLHqe281850ZqzeSOqWu/i/IZgO7UIk
 KyVfI8U5L9WmYZ0YusXmcBQNvHOX8F69vXVtDFZzSBlQCICPHCER7xuVOgnzwan+AfzOybvKuu+
 IqqQXwliq5gB9jTi7JvnyGvVm8OQAw==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a5b77f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=jOqwWQH_q4CvC3V4_bsA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 12:07:57PM +0530, Nitin Rawat wrote:
> 
> 
> On 8/20/2025 6:19 AM, Dmitry Baryshkov wrote:
> > On Wed, Aug 20, 2025 at 03:58:26AM +0530, Nitin Rawat wrote:
> > > Add regulator load voting support for SM8650 and SM8750 platforms by
> > > introducing dedicated regulator bulk data arrays with their load
> > > values.
> > > 
> > > The load requirements are:
> > > - SM8650: vdda-phy (205mA), vdda-pll (17.5mA)
> > > - SM8750: vdda-phy (213mA), vdda-pll (18.3mA)
> > > 
> > > This ensures stable operation and proper power management for these
> > > platforms where regulators are shared between the QMP USB PHY and
> > > other IP blocks by setting appropriate regulator load currents during PHY
> > > operations.
> > > 
> > > Configurations without specific load requirements will continue to work
> > > unchanged, as init_load_uA remains zero-initialized when .init_load_uA
> > > is not provided.
> > 
> > Can we please get configuration for the rest of the platforms?
> 
> Hi Dmitry,
> 
> If you're okay with it, can I merge the configuration for the remaining
> platforms in the next patch series after I complete testing on all remaining
> platforms.

You don't need to test, finding MSM8996 or 98 might be troublesome. Just
fill in the values from the hardware documentation.

-- 
With best wishes
Dmitry

