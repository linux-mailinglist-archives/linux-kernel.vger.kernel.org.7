Return-Path: <linux-kernel+bounces-803088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03754B45A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656D27BC23A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50B36CE1A;
	Fri,  5 Sep 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bni5Q9St"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245736CE16
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082352; cv=none; b=NpvlEFcmR7/wEmDspVDl3m1Kysky4MEETqj0WQtvHx7Ut1MxnMuANOeWe/bR6Sfxvvr7ZncHvebvgHR9cElOQxDJ27xGn0Tl0s0s43uG7D7Jz0tm0uYqVPKJA43vrq4Pg8kjGx47LKE1eFw6ekPzqYkGpEW4JuXfDv/6Z1ZSEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082352; c=relaxed/simple;
	bh=aW3//HwGu8x9jaAcVNv3PdV3US97+9MbaFZEAQq6U5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7+HQIsCEf4Sr2bLRuX7mr9O8Bspq2QCuDMSR6rxy/FfSXM1BVDBdE9wD8dzb9pKXbVpdnqjvSSLAtQ6l2O8g1ZUrvWyd5YP088hQ0ZjV1MtcYc2lp4lzCq/ze18GEkQZUD1piRdA5OYeU3UBuRxJRXVPwR2Opk1foRvnZVXgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bni5Q9St; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857E3gU004654
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6iRscjrYT/DPZlwSIr2CLeb9O1T30WArLRGLG2+NEY=; b=bni5Q9StBcdCDpxY
	lGziyr5rOXIkZVsLww6yBedSSK0VII6wjwcFZJkvUc8ImuuUbEWe1LpBOfSoYUCG
	WLHN9A7ZnTwSd11awnaDkDtvPk2sq9T85wgieT2fOqi0qiqaeKR3EFbdwlTF/aAg
	/c2JAYjgkFXGmD7JnSjvmWaWCKh359vU1yNHhXdaim2fG6p5J1WedFL4tAnwT0mT
	zVG9waVQJ/yErHq4bynOKxjy23fBgy4XAQM77Pee3aQBujllLsDYRlxL/Mw5B92c
	LzneKMmQS72SOCEUCoEiDYi/CVpKvKVds2Wu2bjf75vHKNolKqTq2xiPqzXILDeT
	g7mumg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbgcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:25:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b31bea5896so25684361cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082348; x=1757687148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6iRscjrYT/DPZlwSIr2CLeb9O1T30WArLRGLG2+NEY=;
        b=QGcuX71HOqMaEPKVd/p72xS5lABb4KEs7SCGt7goZEC9i/Pahsw76Ae8tACM/lfMc3
         jOezSLCmGNwkPDN435uKaoKXtyPh6K5ybCeNHxgNE1zFFg8pWJeYeYsnZNxtnEAbTnnU
         3yjxvD1t9vlgEVs+qL9B52ZtOSiwN3bwPBNGAdBDyVvHgCMXbx2akt+sUUmkZmdNIex9
         sbReXTtmysFMwmRLcOxqgbwRvxakAYQ39FSC5UHEUhKdyCw05fB34kS+MFCYmJF+7SX8
         IMrk+IkDIrb82BWLi+1FiJbSBJdqQH5fAUXQ0lxBeruN9wmyJFeMogDsJTdTXhaBV3+z
         pD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVghs3vj/phmoKbbT+PxWYn6kYO9i32VCIk+Z/DqZuQV8pasQ0yvPzxfEKE69rSLCGQVOxW2V8p+k04Gw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQ8nnax7wYqmCf8EADCZ+a3bMpLIHfZfiBvJQNskKN7AYjm9D
	rSxIql8cYfTHbE5b+rMJ8ekMO7bMwgaGeUUQ4tPkIJRrDnCfV+6M4xDqMGZI7j+4dO6X0o8LgpW
	kQMf0ejThMfTeWV/Mv7p+oZ98Cg4MmBhJxdhRkOakuOdQ2RcPI1OLqgimZK96kfykxng=
X-Gm-Gg: ASbGncuaYcxmhGdnBrXcBPzBtIT6l/pTJfYOXxQvQM/hhz+x/lz7VRLt8wASfFO7VSQ
	fvzssKfh1aXkpF+2Mo0/NQsfMRPvY5mDbI+zSORydmBJmWnfdq3FdW26CKF7yOxackgeyLleqfX
	sVbcTaP7jXJ4ueTXSclC7S1jx350LX0rLC/F6dU/bxa/M3+kXfUtEUkFEVNKu0mwE8wR5DHtctk
	zK8a21Q3QE1My53Gi0Xhy7BAECq+yDwjbXhEKu50b+a5Sn5VCxxZGLxzF9nwvYQlNdlOH+I00QH
	FY93OAkQNBavC//t7kn1mCFS3w4s6eNiGa/lVza9PPC2z5tNc/lzLF/R0fl0tANHu/0/u/zokEz
	3M6U/DtWMzfzlAJVTj3bOLCIli74ZX0zBX89V4BghBE1I5hPuRzhr
X-Received: by 2002:a05:622a:8c9:b0:4b3:14c:e0ea with SMTP id d75a77b69052e-4b31dcd5f14mr311844561cf.79.1757082347718;
        Fri, 05 Sep 2025 07:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmRcp97gTdFtrmsl08AMGcm4eMnJBcuOZ+uR2vNLX/Az9KvOHZLOyXY8lOdDTpf+6Jn7Qkqw==
X-Received: by 2002:a05:622a:8c9:b0:4b3:14c:e0ea with SMTP id d75a77b69052e-4b31dcd5f14mr311843601cf.79.1757082346844;
        Fri, 05 Sep 2025 07:25:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad45889sm1783021e87.138.2025.09.05.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:25:45 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:25:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 0/6] Display enablement changes for Qualcomm QCS8300
 platform
Message-ID: <e524ak243snz6kjcvcazjoynm7phzds6ziefr3ydybsf66lkps@a5nqfhinw5qy>
References: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
 <5bc0203c-21a1-4948-96ff-8eae844bfb93@oss.qualcomm.com>
 <d2940186-7baf-41d3-80dd-fbc860ac5acb@oss.qualcomm.com>
 <f3aa35bb-5ac7-4fe3-904e-2dd97b9c034a@oss.qualcomm.com>
 <fgzptkddxhgqpsylthgo4a465jwypcu2oxo6woeihyukpn3zqd@hitdv3ujjhvc>
 <2b986468-59b3-4586-9d4c-3ec34dc36c2c@oss.qualcomm.com>
 <qrqokzgr4kvsdgejuv53nn64mvgnk2grbww6ynbcitzpogf3pd@5cm46bonctrn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qrqokzgr4kvsdgejuv53nn64mvgnk2grbww6ynbcitzpogf3pd@5cm46bonctrn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX7aWC6T93D+qI
 fy4ZsUiNhqseELx9mcSveaDmFV4c2dcX/zBYsu0wwn/DMY/4sLjpfYU3g5/ydEtuT+TSpCC/fHJ
 wkEGEyBuTyM+I3/UZNQAyBsPVrND5URY0TDG/jRnoOI8vlt4yproHHG9n+Ta28lO0JTgkcI9XTr
 GRVY3cxd80eTe5lrQpq6kLdx8RoHo4n7+jw5AvLY+FXZTyWoWA1jWHKPZH0CvONF/4Lhbk9vDMr
 iWCcy70JFIjjNdNJWPYmQ84FyZsXLTTicbF8+iKpSGLn0jcF+UEKQ/gr1yNbArMSL1/7eTROi1B
 39qPowQ5bNRrfYRnJWEkfCoXj/knpQLroRhBwiNUkVIWUUgXR+DOq3ZlYQDQnjSeAeFjCwxzSvf
 nMYTix1X
X-Proofpoint-GUID: uVbkOldWAV_y09ae04YHaiyQfQSvWnQ9
X-Proofpoint-ORIG-GUID: uVbkOldWAV_y09ae04YHaiyQfQSvWnQ9
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68baf2ed cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=1XWaLZrsAAAA:8 a=KKAkSRfTAAAA:8 a=6Kpmm3Tfy8Ve9GjPoGYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Fri, Sep 05, 2025 at 04:49:01PM +0300, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 11:55:52AM +0800, Yongxing Mou wrote:
> > 
> > 
> > On 9/4/2025 9:41 PM, Dmitry Baryshkov wrote:
> > > On Thu, Sep 04, 2025 at 05:31:01PM +0800, Yongxing Mou wrote:
> > > > 
> > > > 
> > > > On 9/4/2025 4:21 PM, Konrad Dybcio wrote:
> > > > > On 9/4/25 9:55 AM, Yongxing Mou wrote:
> > > > > > 
> > > > > > 
> > > > > > On 9/4/2025 3:22 PM, Yongxing Mou wrote:
> > > > > > > This series introduces support to enable the Mobile Display Subsystem (MDSS)
> > > > > > > , Display Processing Unit (DPU), DisplayPort controller for the Qualcomm
> > > > > > > QCS8300 target. It includes the addition of the hardware catalog, compatible
> > > > > > > string, and their YAML bindings.
> > > > > > > 
> > > > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > > > ---
> > > > > > > Changes in v11: Fixed review comments from Dmitry.
> > > > > > > - Rebase to MST bindings V8.
> > > > > > > - Update the clocks-name for QCS8300 in dp-controller.
> > > > > > > - Link to v10: https://lore.kernel.org/r/20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com
> > > > > > > 
> > > > > > > Changes in v10:
> > > > > > > - Rebase to MST bindings V7.
> > > > > > > - Update the P2/P3/MST2LINK/MST3LINK regions in MDSS yaml.
> > > > > > > - Link to v9: https://lore.kernel.org/r/20250825-qcs8300_mdss-v9-0-ebda1de80ca0@oss.qualcomm.com
> > > > > > > 
> > > > > > > Changes in v9: Fixed review comments from Dmitry.
> > > > > > > - Updated the description of dp-controller DT binding.
> > > > > > > - Add new clause only work for QCS8300(one DP controller with 4 streams).
> > > > > > > - Link to v8: https://lore.kernel.org/r/20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com
> > > > > > > 
> > > > > > > Changes in v8: Fixed review comments from Krzysztof, Dmitry.
> > > > > > > - Fixed incorrect description for dp-controller in driver/dt-binding.[Krzysztof][Dmitry]
> > > > > > > - Fixed incorrect description for ubwc change.[Dmitry]
> > > > > > > - Link to v7: https://lore.kernel.org/r/20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com
> > > > > > > 
> > > > > > > Changes in v7: Fixed review comments from Dmitry.
> > > > > > > - Rebase to next-20250818 and 4 pixel stream series V6.
> > > > > > > - Add more description for the dp-controller dt-bingding change.[Dmitry]
> > > > > > > - Reorder the MDSS change and UBWC change.[Dmitry]
> > > > > > > - Switch to the OSS email.
> > > > > > > - Link to v6: https://lore.kernel.org/r/20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com
> > > > > > > 
> > > > > > > Changes in v6: Fixed review comments from Konrad, Dmitry.
> > > > > > > - Rewrite commit msg in dp-controller dt-binding change.[Dmitry]
> > > > > > > - Optimize the description in MDSS dt-binding.[Dmitry]
> > > > > > > - Pass the sc8280xp_data as fallback in the UBWC change.[Konrad]
> > > > > > > - Add the DP controller driver change.
> > > > > > > - Link to v5: https://lore.kernel.org/r/20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com
> > > > > > > 
> > > > > > > Changes in v5:Fixed review comments from Krzysztof, Dmitry.
> > > > > > > - Rebase to next-20250717.
> > > > > > > - Change DP compatible to qcs8300-dp due to add 4 streams support.
> > > > > > > - Add QCS8300 UBWC config change due to rebase.
> > > > > > > - Add 4 streams clk and phy in the mdss yaml.
> > > > > > > - Link to v4: https://lore.kernel.org/r/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com
> > > > > > > 
> > > > > > > Changes in v4:Fixed review comments from Krzysztof, Dmitry.
> > > > > > > - Use the common style for the dt-bindings commits.[Dmitry]
> > > > > > > - Update the commits msg for the mdss binding patch, explain why they
> > > > > > >      reuse different platform drivers.[Krzysztof]
> > > > > > > - Link to v3: https://lore.kernel.org/r/20250113-mdssdt_qcs8300-v3-0-6c8e93459600@quicinc.com
> > > > > > > 
> > > > > > > Changes in v3:Fixed review comments from Krzysztof, Dmitry.
> > > > > > > - Fix the missing space issue in commit message.[Krzysztof]
> > > > > > > - Separate the patch for the phy from this series.[Dmitry]
> > > > > > > - Remove unused dependencies and update in the cover letter.[Dmitry][Krzysztof]
> > > > > > > - Link to v2: https://lore.kernel.org/r/20241226-mdssdt_qcs8300-v2-0-acba0db533ce@quicinc.com
> > > > > > > 
> > > > > > > Changes in v2:Fixed review comments from Krzysztof, Dmitry, Rob.
> > > > > > > - Decouple the devicetree changes from this series.[Dmitry][Krzysztof]
> > > > > > > - Drop the dpu driver changes and reuse SA8775P DPU driver.[Dmitry]
> > > > > > > - Fix compilation issues in MDSS bindings.[Rob][Krzysztof]
> > > > > > > - Correct formatting errors and remove unnecessary status in MDSS
> > > > > > >      bindings.[Krzysztof]
> > > > > > > - Add the the necessary information in MDSS changes commit msg.[Dmitry]
> > > > > > > - Rebase MDSS driver changes to https://lore.kernel.org/dri-devel/
> > > > > > >      20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org/.[Dmitry]
> > > > > > > - Package the DisplayPort controller and eDP PHY bindings document to
> > > > > > >      this patch series.
> > > > > > > - Collecting MDSS changes reviewd-by Dmitry.
> > > > > > > - Reuse the sa8775p eDP PHY as a fallback compat.[Dmitry]
> > > > > > > - Reuse the sm8650 DP controller as a fallback compat.[Dmitry]
> > > > > > > - Link to v1: https://lore.kernel.org/r/20241127-mdss_qcs8300-v1-0-29b2c3ee95b8@quicinc.com
> > > > > > > ---
> > > > > > > This series depend on 4 pixel streams dt-binding series:
> > > > > > > https://lore.kernel.org/all/20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com/
> > > > > > > 
> > > > > > > and separate eDP PHY binding:
> > > > > > > https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/
> > > > > > > 
> > > > > > > ---
> > > > > > > Yongxing Mou (6):
> > > > > > >          dt-bindings: display/msm: Document the DPU for QCS8300
> > > > > > >          dt-bindings: display/msm: dp-controller: document QCS8300 compatible
> > > > > > >          dt-bindings: display/msm: Document MDSS on QCS8300
> > > > > > >          soc: qcom: ubwc: Add QCS8300 UBWC cfg
> > > > > > >          drm/msm: mdss: Add QCS8300 support
> > > > > > >          drm/msm/dp: Add DisplayPort controller for QCS8300
> > > > > > > 
> > > > > > >     .../bindings/display/msm/dp-controller.yaml        |  22 ++
> > > > > > >     .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
> > > > > > >     .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  15 +-
> > > > > > >     drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
> > > > > > >     drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
> > > > > > >     drivers/soc/qcom/ubwc_config.c                     |   1 +
> > > > > > >     6 files changed, 321 insertions(+), 5 deletions(-)
> > > > > > > ---
> > > > > > > base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> > > > > > > change-id: 20250818-qcs8300_mdss-a363f0d0ba0b
> > > > > > > prerequisite-message-id: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
> > > > > > > prerequisite-patch-id: ffeeb0739a4b3d310912f4bb6c0bd17802818879
> > > > > > > prerequisite-patch-id: cdc3f4515ab23a8b2ce719bbdbcb56043803d03f
> > > > > > > prerequisite-patch-id: 048b11765f49af4a728db1525fef1eb8ad48bf88
> > > > > > > prerequisite-patch-id: f0f92109d1bfffa6a1142f2aaecbd72a29b858c0
> > > > > > > prerequisite-patch-id: a8185cf3ddd85b9058691500b8dc0c57c8226e97
> > > > > > > prerequisite-patch-id: a389a2e4eca44bf62bb2c861c96596368be7a021
> > > > > > > prerequisite-patch-id: 09ec7f51de0a65c68c2c781750177017f32747ba
> > > > > > > prerequisite-patch-id: f76ab0ae189df14acc851fa52f8f8e8faed9a505
> > > > > > > prerequisite-patch-id: 983fc8a7bea459505c5b27db1a1ef7581936555c
> > > > > > > prerequisite-message-id: <20250730072725.1433360-1-quic_yongmou@quicinc.com>
> > > > > > > prerequisite-patch-id: 2ea89bba3c9c6ba37250ebd947c1d4acedc78a5d
> > > > > > > 
> > > > > > > Best regards,
> > > > > > 
> > > > > > Hi, maintainers:
> > > > > > sorry for the inconvenience caused. This series is missing patch 5 and patch 6 due to network issues. May I resend it? The missed two changes are identical to V10.
> > > > > 
> > > > > You can fix that manually by sending them both through
> > > > > 
> > > > > b4 send -o /tmp/
> > > > > git send-email --in-reply-to=<cover letter msgid> /tmp/0005-xyz-abc.patch
> > > > > git send-email --in-reply-to=<cover letter msgid> /tmp/0006-xyz-abc.patch
> > > > > 
> > > > > Konrad
> > > > Thanks for guide, when i use cmd  "git send-email
> > > > --in-reply-to="20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com"
> > > > ~/tmpyongmou/0005-drm-msm-mdss-add-qcs8300-support.eml", seems something
> > > > wrong, error log:
> > > > mou@oss.qualcomm.com>,  Dmitry Baryshkov
> > > > <dmitry.baryshkov@oss.qualcomm.com>'
> > > > (body) Adding cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> from
> > > > line 'Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>'
> > > > 5.1.3 The recipient address <y> is not a valid RFC 5321 address. For more
> > > > 5.1.3 information, go to
> > > > 5.1.3  https://support.google.com/a/answer/3221692 and review RFC 5321
> > > > 5.1.3 specifications. d9443c01a7336-24b1ba1718bsm64512315ad.39 - gsmtpWould
> > > > you mind sharing some suggestions for this? Thanks~~
> > > 
> > > When `git send-email` asks you, just press 'Enter', no extra chars. Or
> > > it migth be easier to just `b4 send --resend`.
> > > 
> > Thanks for the guidance — that was the mistake I made. It has now been sent
> > upstream. It looks like the patch wasn't archived into the V11 series. So
> > does this ok?
> 
> No, I don't see them on the mailing list.

They are now, but the In-Reply-To seems to be incorrect.

-- 
With best wishes
Dmitry

