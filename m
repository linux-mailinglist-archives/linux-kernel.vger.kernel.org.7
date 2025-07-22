Return-Path: <linux-kernel+bounces-741017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F12B0DEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F24F1893404
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F332EAB7F;
	Tue, 22 Jul 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6uh+MGG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FF2EAB6E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194834; cv=none; b=pnvN9oj9mXnxHtJMN9fsrLkZ1rQcXvbletldUbG9+oUy0OeoYDYxRwIYTldZnnHBuRkE6IviLMINbYEhh1v2EIB99x9MA0cn5VCjYlzPOygvxx5ifhbq2qKE+4ECy2tWT3YsySgdXI3cHKVZbT+A11Mbz7henNP+rDqdOWXWp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194834; c=relaxed/simple;
	bh=HnC6eudhab74S+HNC089ggQr1Wce6NWyzPqRySJv01M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZu2cf2w7imUYM4gK9ZBOYt5VynSQIy3NsLmp1E0tl2gXYcVvd7whewaU/IO0e2zMPehvaZNBWdW7Mkzqg61PApOJHiGBDUq0CPEIscplvSDjQS7K4YKvG9xozGcTNVhvRmO3wIJ6LoFshSD5CIgNfsQweXQYWsxOitl6PwjiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6uh+MGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MADarg005659
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtT5su/VJ7JP1pHjFV7X/fYhQ9wlxMPwqcGXpQ4560g=; b=D6uh+MGGULIyksQh
	T1z98YOrVB8kJ3nH/vaFmvUc1IfBWpz8u0xhpyshYnb99/AfS5SqUhMAYDEMLYpP
	xNUvw3lHLhJTkEfTlivMfUj3jb7mXStVBncUdBjfuZyi3fYAGnt8edcWZHdf3bQX
	MDWPWdi0BqJ8AGbFosXVtz4O5ZCBNfAweH45AbC9XYUWpf0UXJA3B89ZU6ALzcut
	UQ60GCuT/nLISw0wGWVJEfCl1gaBUrAGXPYWzGUgVXYccslegUOQNYumJ0R6+opH
	J+1m1XDDRjBKOfheJt2+x2TzW7CB2+Y7J16+DzY+25uvuyabjNe7G0NZgq9wLAi3
	anrgTw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q9t42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:33:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so10619041cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194830; x=1753799630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtT5su/VJ7JP1pHjFV7X/fYhQ9wlxMPwqcGXpQ4560g=;
        b=eu7CmrROpGBEVXnfglL+6IoqYrVOwqCSLfCm4KpiPluKAJ4d70pt74HqQSflV3PeGo
         /ioJwws6R6HdcQ3PkmeCU//BCLFvOH1DIXNk+nARSZaycyz7jh6Xg4E/n6AqiJZiUkje
         Zz0cXI2ubOJ9hhJxUYZkWzZ6PuqnpkO41WHMTOj5Arc/s/VnNJm2BA/OYeupQw230vyC
         nPJQI1FJV9lFTUeNfs/z+gjuPjzoP1+D23DQWEd4B5XuJzfoV7Xpv+7LBy73RQI+jgMp
         4X7cSKCORjVht+1MXDKm9EMknPrFNKkyOLdEI3sKMIlCZTANjgYDLBxXLKeoS+cRbzj4
         upCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUogqXh5v4Df5D7XLx3hwiQZg9jNaE5/5jPj9AW9Cxb/W9EcCJrAihrhHBP1UZiFmCVBNvCQjUy2XdkWOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Q/aQw9TQPh9HEI9dG9+YxbjF9sJ4mObE00Uzly4mfIzToKdo
	3xjdGSBA9MztuOOMQ39DrTlmhnM8j+VChehmfAIXaJ4fy3szsVKRwuAeiHFee6uX34WQfgNKO7l
	nGTIFGYpY9sQF8q6cEO1E2WErITmWHgHRgShESC99oljGmIyJ4pN+0Ks/rbP6CZYNNqo=
X-Gm-Gg: ASbGncsX9QOx/dowTBI5vlxhrGaoHLb0Xvw5pibGh0IXjYKpqnTCvOF+DqIrO2tgrwD
	EFq8H3WsQhPNKtCWJ33Z0FKpYyZoQnvFCYC6fMDBODdQn11nXgXPi/j84/N5FO4SVkvFhqVNRci
	KaKzgHqC9azVRidOO1HVPXq2Iy8WLTZUMUOUMtZcyrF3I9sbD4EZBFyPZrdykslZEwW/3NnwGN0
	0Su8kWmNU2oJ5bphixBSe8x2La+ataRjkP1vjhJ9uN01jTNbYWSE4xaWRkryBUdZD4bBCZmH2GA
	gZnoV5+3xZ5zn/FXtSGXEcCeZ7VOIOHHLRvtGrBDhFvgMHmUIfi4hcsrBViW+4dFd5ORETN03Ej
	ZiLfz7uiqch1oq/GktPX5
X-Received: by 2002:a05:620a:2227:b0:7e3:2e02:4849 with SMTP id af79cd13be357-7e342b41754mr1177997985a.9.1753194829869;
        Tue, 22 Jul 2025 07:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU1lbhaP2WVsTXTqM7GGer/GTSGogiYRwUzlLubvQGVjS0cOplM2JT/IJ8lGgLcTomzSOXCQ==
X-Received: by 2002:a05:620a:2227:b0:7e3:2e02:4849 with SMTP id af79cd13be357-7e342b41754mr1177993285a.9.1753194828498;
        Tue, 22 Jul 2025 07:33:48 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c9075d76sm6920459a12.52.2025.07.22.07.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:33:47 -0700 (PDT)
Message-ID: <84a33e15-edaf-4951-8411-24b17ee5f4f5@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] drm/msm: a6xx: Fix gx_is_on check for a7x family
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyMCBTYWx0ZWRfXzK4KSN7Eu9Yk
 nYb3Ymc6gA+hKcoABcOZQ9uSg207b+bpFOAFN0ELuF2fdAJ62B3vG2kEyrPVT6v4y/9nG5pWOP7
 Vx5+1wj6CQuqN2WscuWOXYCS+wxICh8erfuANphCrI/3dZtqGgrRyMxcaMXHjSdxaFZJcp9tEp1
 kyqU8eBTq1ufyqQhM1QF5KweDU1c3Ugezup212j7d5K5sra9ITakaGqqqN3BPb8kSR8fbJRh982
 reipMFmI4REiPYNJtnbE15R2RPcBlMemui8Yzek4IUdZOAVQP76jPUeVFmiIO7lOCYwKeLuff6/
 8oFAcKsc+PIs9vUa611C/NwgBSGzOtZgJTGFT+P2tiW3ZXTHvN8ukUEstMRGHlbMaLM5rl07fIR
 2CzcYe6k0+oISYSDmX/YVgcUVLGznipewg43m1IU98NUmwaM+S0osm7x+Ev+upnOcH+Sc7nq
X-Proofpoint-ORIG-GUID: HwB9XBA7NRpjrjA1LH_6ZeLpgLwyN4Lv
X-Proofpoint-GUID: HwB9XBA7NRpjrjA1LH_6ZeLpgLwyN4Lv
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687fa14f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=rILJP4qTGdYfNujWrMwA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220120

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> Bitfield definition for REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS register is
> different in A7XX family. Check the correct bits to see if GX is
> collapsed on A7XX series.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

This seems to have been introduced all the way back in the initial
a7xx submission downstream, so I'll assume this concerns all SKUs
and this is a relevant fixes tag:

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

