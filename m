Return-Path: <linux-kernel+bounces-760226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3FB1E832
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41CB5826CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA60627780E;
	Fri,  8 Aug 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZ9StkN6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211C2686A0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655494; cv=none; b=EcPQOxxsOF1QFLNvzO9HTEqoEqYDjyw7bf2L0hcjrW6Ssl3TrZ3GzuFG5YPoVqvmx7H99Q/GO3Q+c/e1ZxC5Nb6tZAj5wwizwhlVsuBLg8DA5J6BgQBNjdVNuR5w4sSVr9sSbHUgjiALiR6sc9nKxALDN7XVIQxFByz5TSg/xjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655494; c=relaxed/simple;
	bh=7ZHRoixuzIBNvn+KeOiNLAotL1dXpBu+T1EJlhAYdZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iifPxgb6pN995lxmlfST9qDB3lHowgi9m+1H0Rj0AKZthljhQGky0lDoPqQA7t9NdHWZCMiewzHld/XzJKjMLd55buCp8Lxp55rVZKg9Yl0V1twuzmLZye7o7FGy2aeamoY1+8t8Wo8OsNl7IGFAoNzn8AKyo+0hrTMwDcahfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZ9StkN6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57874iFb011786
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 12:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0yz86oqzd3VjdOQOtRR1PVTCk/A2sa94Ghh5mQ0SfkE=; b=AZ9StkN6NaKma5P/
	WpZVKBNz/60v1NpmcnNKFsTYVgFaavg7g7UjTrVSfyTAbq5Fh2xd6XoggV9bbOM/
	b7+RAb02GoCXif9warq9ChKFo5IN4tGxfYUcDo23aufM3jvyfuWLqVZaD+am4b7W
	GRSvKNez/fPovTjFLYGWRW1+yJMRMsGP0UAT9d3lXfGBcvqZ2RiSiSsVz9rgjaZ1
	qajf46b6phiXPGYvhakqHNTkdmLLQPxBFXRJrqlUypSdM+l257eXmriJvVP/4sLI
	FSL4+i4/QrrnJf6FvpGQPS1MCgGNrn4pWZiU1tSSlZfd+iLA4W8fOWRBiLqnFecg
	8J1WTg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy4qsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 12:18:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b081d742d9so75577011cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655491; x=1755260291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yz86oqzd3VjdOQOtRR1PVTCk/A2sa94Ghh5mQ0SfkE=;
        b=X9r0KgE6csCcbXECtL77XGWoinjC9edVRIH2p0vG6hp2OqgqkeMKfnPNG1WaKJPCN3
         iNOHCUS+rerwXD2W8XbqQsh1wR36678qYihW34+CLrX6pGPoaXJcNkURjkpmHr+4gbiu
         e5H61RKmzAYwM40BwgxwisSXEeSzlz0SkV9/ajbBD1bmLs/tBzO2BgHNQ4hv7tYqL7k1
         C804GYeKF8igXqZ367vHm/Iv8JsCCh+qeC628fX25MWS7Gfz0Uw06+Jzc7BDMZWprEYp
         xHaGjjwli1vLHkbEqpc9Sw51U9oLZ3Crm38p+X8qXn3mIF/2oVlrrxh3IMAEVTL0j2zV
         BgMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCHOV3rlr/mt2BuitvWifzmwusX374I0sJZQtTG1wSQ7iD8QIeR4Yf3cCiSvBJRtcJIL2ULK4RgNdASiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1IkbHYk6wSHBJNAw/rOLwaKtKtkoCSwb0PsdRrUIvMKnlcaYi
	ezGWsjnKCc0DBzk4W9qE533evHUWdtjDSYMrZa+r/BAXG0e/VLHaYdID7qXksvacnxQ1wY0aW2R
	WTFi4od4Fi9PNl45OUQYJP3NWF/rv7qSqLqoM9ZNSoHym6CQcLWPkpLJubb1m9yMCLpU=
X-Gm-Gg: ASbGncsVtDVHk5yn5/mKDNa9k9AgeYkncYiNIdSn3EW9IBnzCkt2cS/cG2bzBWY8Hhh
	V5XK7XKASJmb4mC/lF49s0hmFlnIkqzqOiSkXtpbmyg4+vK6NCq8/uGn97hGAsbMC+SOYbvjQBi
	7Mqxg/N0tc44fMgbX3hzXR0JwXIm3mVf7UBK2e/kNdsgLVGV6Gf2ZyoXOYe0hnalVoPU8gWw7QN
	Awne44Wi3pruZwh+x4ecEpkErvT3vbeCm+BLyYkXyvdC1I5wMWaVBPa9414A3DZUpOd/CXJJiD/
	axF7cq/uXJWkSPWcd52itCoVpuvIIxxuC4ML+Ujh2olvjrFVHB/U4iXBOucdUWdzFfnoGpjgPZ0
	MYFzbC3el+NHGXLbcmyhAVHCSvgVj4ItHhDyHhC37kFUkx13Ug+BC
X-Received: by 2002:a05:622a:d:b0:4b0:792b:273d with SMTP id d75a77b69052e-4b0aed42c5bmr35912041cf.21.1754655490508;
        Fri, 08 Aug 2025 05:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAacevF0NynIBY1AHvFu49qsJm99g6w40LkckS/o33l9O5/CYaCHNvLxyRNKTWZRBBBH/aNw==
X-Received: by 2002:a05:622a:d:b0:4b0:792b:273d with SMTP id d75a77b69052e-4b0aed42c5bmr35911481cf.21.1754655489826;
        Fri, 08 Aug 2025 05:18:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333a7752b6dsm1495551fa.73.2025.08.08.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:18:08 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:18:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
Message-ID: <uuhcud25gcbvogpyywmuv2rn6fq4ssns6x2u22a7eqjknf7oes@kvdrw3iqqkbi>
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
 <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
 <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
 <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
 <db8241b0-1ef3-439e-8d74-a3cb86b610ba@oss.qualcomm.com>
 <d0871d6d-7593-4cbc-b5dd-2ec358bda27a@oss.qualcomm.com>
 <7c1bd3d6-159f-4269-a22a-34290f1be0cf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c1bd3d6-159f-4269-a22a-34290f1be0cf@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=6895eb04 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=OIhUjEwQ9zQlmBhThOcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YVrHsahs0r5y0zKbcb-exUy7oh5DFFbH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX50ygpRwBwo0K
 uxJI0dzNDlDOgyzqVItXziP/uw/8aBdwZ9S2Q3C8ultBwojlPuSNP3TKGt8hVgaLjiGXu+6P6mo
 lAiR9BW6WdwrefDz8oyHcE5+wxul1mAgZXyc0Mlbm1UA5mfzjsXyVLuzJngCZFX1EjcVuhyb83B
 lzbQ73QHzk6RPjsKa6I25beGwfgEJmpCNhi2mEwVBRIaDT+udHEhfB419YUHsqkQPaJqwuDR0S7
 3XOCAW1F6b0r1q4+jk3zriUOKFePehjXIAMHZgKLTD4zx/dkVFNk7Y1c0oxMoUr8bCsdK1Ylnuq
 /j5bXikxuB2+hHB9CITGNpOV2nMdgHRELkR36HPw6eAAXxY5mHjlxSWqo5sSUG+tnU7K2o5oow/
 3lD5+nDG
X-Proofpoint-ORIG-GUID: YVrHsahs0r5y0zKbcb-exUy7oh5DFFbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046

On Fri, Aug 08, 2025 at 02:51:50PM +0530, Taniya Das wrote:
> 
> 
> On 8/7/2025 10:32 PM, Konrad Dybcio wrote:
> > On 8/6/25 11:39 AM, Taniya Das wrote:
> >>
> >>
> >> On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
> >>> On 8/6/25 11:27 AM, Taniya Das wrote:
> >>>>
> >>>>
> >>>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
> >>>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
> >>>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> >>>>>> boot. This happens due to the floor_ops tries to update the rcg
> >>>>>> configuration even if the clock is not enabled.
> >>>>>
> >>>>> This has been working for other platforms (I see Milos, SAR2130P,
> >>>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
> >>>>> seem to use non-shared ops). What's the difference? Should we switch all
> >>>>> platforms? Is it related to the hypervisor?
> >>>>>
> >>>>
> >>>> If a set rate is called on a clock before clock enable, the
> >>>
> >>> Is this something we should just fix up the drivers not to do?
> >>>
> >>
> >> I do not think CCF has any such limitation where the clock should be
> >> enabled and then a clock rate should be invoked. We should handle it
> >> gracefully and that is what we have now when the caching capabilities
> >> were added in the code. This has been already in our downstream drivers.
> > 
> > Should we do CFG caching on *all* RCGs to avoid having to scratch our
> > heads over which ops to use with each clock individually?
> > 
> 
> Yes, Konrad, that’s definitely the cleanest approach. If you're okay
> with it, we can proceed with the current change first and then follow up
> with a broader cleanup of the rcg2 ops. As part of that, we can also
> transition the relevant SDCC clock targets to use floor_ops. This way,
> we can avoid the rcg configuration failure logs in the boot sequence on
> QCS615.

the rcg2_shared_ops have one main usecase - parking of the clock to the
safe source. If it is not required for the SDCC clock, then it is
incorrect to land this patch.

If you are saying that we should be caching CFG value for all clock
controllers, then we should change instead the clk_rcg2_ops.

> 
> >>
> >> We can add the fix to do a check 'clk_hw_is_enabled(hw)' in the normal
> >> rcg2_ops/rcg2_floor/ceil_ops as well, then we can use them.
> > 
> > FWIW this is not the first time this issue has popped up..
> > 
> > I don't remember the details other than what I sent in the thread
> > 
> > https://lore.kernel.org/linux-arm-msm/20240427-topic-8450sdc2-v1-1-631cbb59e0e5@linaro.org/
> > 
> 
> Yes, but as I mentioned the new ops looks much cleaner, so wanted to
> take this approach.
> 
> > Konrad
> >>
> >> AFAIK the eMMC framework has this code and this is not limited to drivers.
> >>
> > 
> 
> -- 
> Thanks,
> Taniya Das
> 

-- 
With best wishes
Dmitry

