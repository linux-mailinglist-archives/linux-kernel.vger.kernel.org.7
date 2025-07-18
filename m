Return-Path: <linux-kernel+bounces-737209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E92B0A939
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98972176DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306CD2E7184;
	Fri, 18 Jul 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9HONGQ2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42A2E62B8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858890; cv=none; b=Ue5R0FwQJPEBK/PPGeDAnsYreY/cWvnVPHbT+mvhTAV84Q4fM8Pm+dijrzJFYxOAoNMt9ALI9lIJIcCHUCIjABE3k1Gc+slIyfPnvPU37oLtJNspejIb0eMUgXcfkV3JCBTLQJWvCgTLg+RKdgF0+hH6xgt0uJkHKvlDwfDl0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858890; c=relaxed/simple;
	bh=tmfDngngXq6fj8ZEFrgrno4R29+ACZBn3BYWv0UP28A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEUBb5WLhYtgx5XAS6smQBLasrYq7cCWZ70YQwbrHIyRRzqfSBh77/wsm8q7VO2vQL0/pxtwR34Ji1mToawz1407IL9UVpegP492I4buX0caMgalwivikQp2RYTDAFFdSxqwlujUIW7kLq3Rw0yjQJ0r2TnC0lJ+658QFsTmvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9HONGQ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFG8AJ030459
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hvQRsE2lG7WyIIQnwV/DeD9T4vuk4piXmEgdbjYc460=; b=G9HONGQ2Qa2uUbLZ
	VJY4Lqvyrv1n/8Lykdjk8ImdB8+wf9SYMMzho7gbPSwHGSDoxrUBE0CiNNwxX9tU
	eiuk2i03SYOOUMR/fzdvSMV4XqbJNDyDuvShdivyYxYc+NZo6O9pnZkJG20id4xH
	+GQ6CivijZWO/Yf86g+q8FR696sTRXmGqNM957Ntrk/wR/1dcjZG442XRPYcu9Dl
	2t6TTIi6n2flM1t9PB5QfE+BihzXzRoIFag/A/QdGofEojZLvcAH6xsAgHzN8Kev
	m3Vck5j3SQIkQddI4fbh5TebcaUGQBnIOFC3p8FE571tDb26sN/rlJWab2c9WjXO
	d5BCRQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7s7ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:14:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso2839569a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752858886; x=1753463686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvQRsE2lG7WyIIQnwV/DeD9T4vuk4piXmEgdbjYc460=;
        b=p9FWFlWAPc5AY/6DgIIIZba2OMAqv1RsBHTTLQRfMfOWDiKorQcixPVB2OKpSwJXSB
         1IjMswM1DlkEUCZNCkSy9YjqlVBOjQuEC+XZH9chuppMLEgcauB6tYDQW4mSi64fHqSa
         xAJnqylwskY0SUm0ifGfpsVvLh1Ht8BAqqUikyVG06ryRVun7/05JjpKLSWgFoq1auGq
         A3N9ddpwmHiJFTiNC2LYKKrPaOEKw0r+CbSeTgYDKhLlm2ceekhNTwgfRG7osBpIG7rK
         U2XBaVAwLFyeSgY1BiIZDsg4+CUAL++Uc7iCSLzEbac/0ZBKxav8zi75O9mZq59k7HG3
         BVWg==
X-Forwarded-Encrypted: i=1; AJvYcCXkC8b/iTOWBoNIx2yx52XarTAknygvCD+YLmH9oil4Cf6/DwF503QkEUlJs2v0rgynTlquH4G7a8IDwmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RlrBVl3B9LSqWiPDUbKHuzzzedlrTqrFop8NPaf7UqPvTKqg
	rSJL9O3iZ059tD2m+M0A5eTkO70jZfTmA9s+P63iDRSXJ4NDhD6ZR0uMCYCVYZzb3bOai2/87Hy
	M46DVhLfARaNPWuI8IXRWCgmjQP1FVGciPslIYRijKjUpTMhpGNRHZCTTpIPylRuvO6Y=
X-Gm-Gg: ASbGnctrXIWej8cRkZkms6yMQ/cE+5wYapgpCcgqX0jpMz0IzmjyNM8a/eJnB7wWvRI
	gvp9YuoyfJmiKsokN8GVHk3lygTM+oUIZ2tEinnw5LbUo9YoXb8sPgl8kwVQRbDMR6ts7VVh1m2
	vBD76OF2nkbx52CQUyo+0j56PmenUnPhI5UXqV7/n6ixBapqr5zElfpXZOsoFr2AcAvG6/HmYNk
	8IbvNjycJwsYwaGdQTZychKgexWD0FCBVe2RtLkERcF/AXmbMbljKmQw5Douz3mN6RNVSjEkcJC
	K+YbuScPjsqMaTwJkvqeNEiDFMfcms/rVgyuxzKN3VzR+vqX57Ynz9Q1yAZ7Pf0EP1OoQh5fhbl
	0OrzxAu32lEu27A==
X-Received: by 2002:a17:90b:48c8:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-31c9e6f71b8mr18347568a91.14.1752858886371;
        Fri, 18 Jul 2025 10:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZ4uYoT0jpgwok+1LqJLQaSu3L2fEp1diUxE597ewVDpbjd87lEWbuWkSUsEweCpZR2VK2w==
X-Received: by 2002:a17:90b:48c8:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-31c9e6f71b8mr18347517a91.14.1752858885895;
        Fri, 18 Jul 2025 10:14:45 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b56fsm1593934a91.16.2025.07.18.10.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:14:45 -0700 (PDT)
Message-ID: <7753e1e8-5e2d-4d8b-8a46-a6fbc58a144d@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 11:14:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] accel/rocket: Add a new driver for Rockchip's
 NPU
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Stone <daniel@fooishbar.org>, Da Xue <da@libre.computer>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Robert Foss <rfoss@kernel.org>
References: <20250713-6-10-rocket-v8-0-64fa3115e910@tomeuvizoso.net>
 <20250713-6-10-rocket-v8-2-64fa3115e910@tomeuvizoso.net>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250713-6-10-rocket-v8-2-64fa3115e910@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNiBTYWx0ZWRfX/Vl0j5828zQX
 IVwdDzEZhft7h2ZKWaxoHZljk1ZrKdCmr8pmcsMQSYO0XQpeLT6gyz3ZybCAvv94IL1PxiK35gM
 wsy2Ps6Vv45J1gBQJX0k5M1+l5X/uBfv5+qEM/6FUlMkSnjaLPCOLdmEu5F0WofjLxEDbyUkyAm
 GyWKhtTYyqfINVasbGqqqJftgEX3tnIzSBV7hOeiQ/W5qOA4VmL9mS2tbpWbKrNgWpunzMAd6rG
 GjuL0ayU9IJw1kGLW/jIMgKV5JG6dO2/eQfJTT3mw5OcRNa/P0cQjd3MMvH90xo6cNeFaqDL14n
 K4sv2aKoacJkcnLAPpmiG7EumNfzBJny87tRk+H3sT0sCT2iIx5vV7cyWZBHJVqwM+EipdSHi97
 maE9fcdzvCvXn/qnJXZzi//K8/78NdPVyegkD7d6jHRi8nUEoBV0ljCi+M3pShh9soXIQmD9
X-Proofpoint-GUID: xgvebiEvIjduKZP2Cd9GBvrPiqZdFVcx
X-Proofpoint-ORIG-GUID: xgvebiEvIjduKZP2Cd9GBvrPiqZdFVcx
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a8107 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=DISFzqtZAAAA:8
 a=EUspDBNiAAAA:8 a=V6djkQ_TFPnTOxwyQKcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180136

On 7/13/2025 2:38 AM, Tomeu Vizoso wrote:
> This initial version supports the NPU as shipped in the RK3588 SoC and
> described in the first part of its TRM, in Chapter 36.
> 
> This NPU contains 3 independent cores that the driver can submit jobs
> to.
> 
> This commit adds just hardware initialization and power management.
> 
> v2:
> - Split cores and IOMMUs as independent devices (Sebastian Reichel)
> - Add some documentation (Jeffrey Hugo)
> - Be more explicit in the Kconfig documentation (Jeffrey Hugo)
> - Remove resets, as these haven't been found useful so far (Zenghui Yu)
> - Repack structs (Jeffrey Hugo)
> - Use DEFINE_DRM_ACCEL_FOPS (Jeffrey Hugo)
> - Use devm_drm_dev_alloc (Jeffrey Hugo)
> - Use probe log helper (Jeffrey Hugo)
> - Introduce UABI header in a later patch (Jeffrey Hugo)
> 
> v3:
> - Adapt to a split of the register block in the DT bindings (Nicolas
>    Frattaroli)
> - Move registers header to its own commit (Thomas Zimmermann)
> - Misc. cleanups (Thomas Zimmermann and Jeff Hugo)
> - Make use of GPL-2.0-only for the copyright notice (Jeff Hugo)
> - PM improvements (Nicolas Frattaroli)
> 
> v4:
> - Use bulk clk API (Krzysztof Kozlowski)
> 
> v6:
> - Remove mention to NVDLA, as the hardware is only incidentally related
>    (Kever Yang)
> - Use calloc instead of GFP_ZERO (Jeff Hugo)
> - Explicitly include linux/container_of.h (Jeff Hugo)
> - pclk and npu clocks are now needed by all cores (Rob Herring)
> 
> v7:
> - Assign its own IOMMU domain to each client, for isolation (Daniel
>    Stone and Robin Murphy)
> 
> v8:
> - Kconfig: fix depends to be more explicit about Rockchip, and remove
>    superfluous selects (Robin Murphy)
> - Use reset lines to reset the cores (Robin Murphy)
> - Reference count the module
> - Set dma_set_max_seg_size
> - Correctly acquire a reference to the IOMMU (Robin Murphy)
> - Remove notion of top core (Robin Murphy)
> 
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

