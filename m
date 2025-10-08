Return-Path: <linux-kernel+bounces-845467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED037BC50EF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176B83A2B37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BD261B7F;
	Wed,  8 Oct 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R9Pi6ndI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7442512C8
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928276; cv=none; b=Mnz0wRI41UjMxJLTk3cB0E8pREMl3Uey/sqpEVt8LEPFx97Q5khFeZ6eyJ44/eBMFZBD//shnVFKDVMgczJ3QWQ/gSlMExHoosuax7ALTbXcG3zjEEgI3aS893Ely/LqzaOD06i/GWp+6ROHvraV1/3aQNiggYedBLkDwoTOMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928276; c=relaxed/simple;
	bh=+v/rypylBH4oBhnJs+np/xDCpUOmLe/7JWcPYhHbIXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Meltti2VLRXQRYmGTnaWljLOxUIIwCzUkKjIpC5i9E6y7/QT0tY/URqmbs84aFKgyE+64QA/qf+HzhNBzyHiADqMkb3MFRNChSwA1RKl1fZLCKpdu122NbFXfBQf6LrnTv+1Wp9kb1o3sLKkCAOBZx2C5GmBCLL69ut9e6Sq8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R9Pi6ndI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Wp6001720
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zFb02Y25ke3gxp+QmVEaLQ1A
	ZPsdmeNsL3BSvt29jbs=; b=R9Pi6ndIzcQw/g6FVr/PqDlpIUnX8IvNePJVy5tV
	hcP69WQ80nsUC6IC6+pw1spvPz0gMSNkPQp1hxu0B8mFp7XQLvVu3k3IDFIwTwSs
	tHJv1vYiLieqDvd9EzyRlNkWdy8NZaFG5Nk+LHWc2PX7N/Vz4EytjqdtJUx7QhK7
	KVhePjy0kqS3I4S7ZuVdSs8LQJiMZfkBuynwpKBuQV9fldTR3E/ee/5teEZ130Zh
	tKgk9fkl+poGeF8HeY/CjgldsNdwoDV2zVf6CGdgWl2z/htqOM4Fw2Y54VGghsqD
	Zl2I8m2olY0Kzu7dayEe8SBd/5U88PPFYAof27k9Z7f3PQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxnav7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:57:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d6a82099cfso199248191cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928273; x=1760533073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFb02Y25ke3gxp+QmVEaLQ1AZPsdmeNsL3BSvt29jbs=;
        b=PuCd+qW5/5SeIFXzl0vHzZuESCm30BNS208ysnT9x/SNNprOgLVbZofcA1Gk675A7g
         sQ+FO6VMG3nAnw2BSmxtSonfuH/r3XfX28DYNocUe1+GM2cB9WPD4TcDpphmhQMCtz1H
         QFwAcOSc9D2RBOC/Wyj3chURYW8HGTllyTc5kSwxXzwNzc6GKNJ8/1hSgY2wUhjq/8gv
         go1+Dqcf6fiiX8b7U/AWfCY4bWZ3Lqbw5dKgO8igqheFv2CHIuMW1w1YqWK3Mz8d2My4
         53aHpmF+7/F1AaeyZsNF3JJTLyWGpkkZBma3idUxq13MniiJSdQsE6UxXLINQtFa2vUf
         qPJA==
X-Forwarded-Encrypted: i=1; AJvYcCVvbeB4wTFAHiwwv2CMwiEyNDuN6Lp3YtiV3tfLJiO+tjNajGaniMpcAvxukywx2g73qsEl9mDkjhUcCps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0a3Cy1P4m3fSR1z3NRTgBXNulZIKxt+Ribl6VU3CFHG2M7Q+Q
	+4uL2gA9opIe0pCWMwefUWSai/JIhqufjcNQkSsRTNTfbnme8tidE2R/Q2CZGG7+Eo7jXP/CaVL
	1ECwjCTiAbgsdwB/o0z8PZN4hpFEhrR+/RQkd2kakeAWhzHCjgKdWuqaL/dNyIEUFhM8=
X-Gm-Gg: ASbGncvCjMyu5MeeEEDDXYfo3v+a1NaEuJezu73QkuFQTZLcgaHh7JMhNFbgJ/rP27g
	egcPWtHN7sTOL//cpvPBRU/ojqedCu6SJUF8A2KtH9X5kForzbQs27hNXeVUhdyL2/OqttW1yvP
	/jzysf82BYnC0r1b3VTdVVoAVE4USZtvAgGlkjd0CnwUlRU+L6HxHviYnAiutumSbW3zvEKHuco
	Ug3yAVSwm83Rg90S6MZFWfB1GYdT9zAd70M8JJ3bBFQAN3v09vRYpOrFJLFa5g2OH5aHg7SMys6
	jikKJzww2kW3qeBb8z6K/pD3+yeSS1/tqdwrg766Sz8VkFNKZeynOpKHKe0YYW3S0+nWbiITOKz
	jQjSc/3f1g5tjZVX5GVGR2I4d6LbpbZ5i4em6v0UiTG0KQwMMmPcHqDoXIw==
X-Received: by 2002:a05:622a:4c1b:b0:4b5:e7c3:1dee with SMTP id d75a77b69052e-4e6ead54342mr41671561cf.47.1759928273168;
        Wed, 08 Oct 2025 05:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV/5Su9ZdMKI4CWmNqq4+T6K2gUd3n5lsYdeglyyNSBPSQUQCzIjG40ACDqXMHlfDXvWtfUA==
X-Received: by 2002:a05:622a:4c1b:b0:4b5:e7c3:1dee with SMTP id d75a77b69052e-4e6ead54342mr41671141cf.47.1759928272409;
        Wed, 08 Oct 2025 05:57:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d263sm7204971e87.74.2025.10.08.05.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:57:51 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:57:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        marijn.suijten@somainline.org, swboyd@chromium.org, mripard@kernel.org,
        abel.vesa@linaro.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        abhinav.kumar@linux.dev, sean@poorly.run, airlied@gmail.com,
        simona@ffwll.ch, alex.vinarskis@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
Subject: Re: [PATCH 2/4] arm64: dts: qcom: lemans: add mdss1 displayPort
 device nodes
Message-ID: <5ba7245mhdfa7ni6g4coaktg7fadkznft3s4ogulywwjujbj6i@gddfftavxvwd>
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
 <e3400ab5-c4ea-455a-b8ea-d4fba2ece85d@oss.qualcomm.com>
 <6uo2w4lscjlx5mtio2xw3xgyyu6kem6kavtdxtu7cbyix6kews@h2ou2awbppzy>
 <b14ca601-56d8-4ecc-8813-b9b642646a0c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14ca601-56d8-4ecc-8813-b9b642646a0c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX7Q1fforEwRPw
 7ilcIS1tmR5wHZ+sgEEdxBVsnJoqD09yuuPn6yP5+cywPDN12NIS8Wdl3RaLHBhaPKGOlHQGHmk
 3AhtIOowo179ir5XmT+X5zxbF+QCh+49ivcJRvXVU5tJLoOV2v3L7Eq9yGSnBWa4+Gc+tepRRoz
 MxWqXpejzCA7mjAw9PUFdoARi+fBcTUqVRvAt98xYdVj3dLDsHQgBY6+EGJfG1vKPtZGIPdgCrK
 rhKjYT4DcDOUpXXF25PrWw510EOtif9BbmqysAGjokVK5gd2En8/wwIc11M5iYnmLQlJ7/fyyLp
 /HnN3Vj/YbKxWBCaz1rtfeNyMjRcd5YG19HWsjU3lKzYlmuQe2UTG9fCJOvA596I8nwHsxBDWEB
 8vJyUPYjdWjZ/irnNAnAWlh50SFJTw==
X-Proofpoint-GUID: XI9aY9eu5yW7WfdZ82XdnHf1Su10QVrz
X-Proofpoint-ORIG-GUID: XI9aY9eu5yW7WfdZ82XdnHf1Su10QVrz
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e65fd2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=UNeRqKPLT5YhSiDNm34A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On Wed, Oct 08, 2025 at 02:50:45PM +0200, Konrad Dybcio wrote:
> On 10/8/25 2:49 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 08, 2025 at 02:40:35PM +0200, Konrad Dybcio wrote:
> >> On 9/26/25 10:59 AM, Mani Chandana Ballary Kuntumalla wrote:
> >>> Add device tree nodes for the mdss1 DPTX0 and DPTX1 controllers
> >>> with their corresponding PHYs.
> >>>
> >>> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> +			mdss1_dp0: displayport-controller@22154000 {
> >>> +				compatible = "qcom,sa8775p-dp";
> >>> +
> >>> +				reg = <0x0 0x22154000 0x0 0x104>,
> >>
> >> sz = 0x200
> > 
> > Hmm, why? I think the memory map specifies these sizes.
> 
> Yeah and I went in line with the allocated region size (not last register)

And this goes against the practice used for DP controllers on other
platforms (or other DP controllers on this platform FWIW).

> 
> [...]
> 
> >>>  		dispcc1: clock-controller@22100000 {
> >>> @@ -6872,6 +7115,8 @@ dispcc1: clock-controller@22100000 {
> >>>  				 <&rpmhcc RPMH_CXO_CLK>,
> >>>  				 <&rpmhcc RPMH_CXO_CLK_A>,
> >>>  				 <&sleep_clk>,
> >>> +				 <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>,
> >>> +				 <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>,
> >>>  				 <0>, <0>, <0>, <0>,
> >>
> >> You need to remove the same amount of zeroes that you added
> > 
> > Nice catch. Which means that somebody was sending untested patches.
> 
> It would work.. until someone tried to add DSI to the second row of zeroes
> instead of the first one

I meant tested against bindings.

-- 
With best wishes
Dmitry

