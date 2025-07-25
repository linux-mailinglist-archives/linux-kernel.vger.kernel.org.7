Return-Path: <linux-kernel+bounces-746000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85898B121BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4566B1CE6CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3622EF64A;
	Fri, 25 Jul 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFdm9juM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAD2EE606
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460069; cv=none; b=GbF0ru0gx1gSxkVC1X/Bk0UJOZO2feLUGcnaDqlFWrEZSurtAuBfXUDEmTgc5+EXVAlekCGABxUp5mAb3Cgq8QBVI5WPDFLzO9orJk1ZpPSr4eOBRb8b0RWjGk5O5yrg/VYkvsU/O5swrj1PDowmF5iLYe5bFszizxqXBHpLObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460069; c=relaxed/simple;
	bh=zy4+5I7aIssi/rmMSBtYygJxN6pNtn3MaFBiLibPOAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqcrVfwrHAEbea91GIvuS1lfiLZw5juKiw3TDh1DxFST2axwg2i2Dcri5vZUCwi1567gONTMfq8ujDpmQh8KXf5ZoChLDcF1IHV/OPLeoCi5+sGSM+sfgPkF1ROQ8w7Q1GzMYfCJ80dhkUaxEjGFQdbUEQL0otwmF6qKJ4IA55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFdm9juM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P90ALi015704
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pTRAzXltnnQkXzy/4MfHD1BpN0UeO0JYTlGtIooVxhY=; b=VFdm9juMycnYZSHZ
	zUXA92nIOBcEnWTYEaYZVS7emlqydaCowoY21CWFScsHSDVVExvYnMTn3+dlby5s
	4hFLISQiz6TZG5bi9tOohYCb2gCWD9ar+XlLTzhbijgIX5E+1GuC37zcPa/MIpya
	Oo+QWB/wZTSCWzJFBHyT5vIqi3kLN//g/8yaVMd6jODWQHGtad5rkobIVYMVlpGi
	QLhQbu1VTEgSBYOY3iL0IqqWARLFc6G4r96pz9jb5jkIpBrByhITf5ekJy3yUGmo
	cGXUD/bTv2Rbch1TAYQSSp7JiozaHKVfDPiHii4f0OPK+8rFfOAqjLYfe6b2gPOs
	XMi8ug==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w502nkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:14:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b115fb801bcso2854489a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460065; x=1754064865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTRAzXltnnQkXzy/4MfHD1BpN0UeO0JYTlGtIooVxhY=;
        b=SmoM9O50MInHbe0PMPdhqky4ljx9umXelUm4ukTFxXAboixRKEQ7rUr0bSkztV+/TG
         hlymcfsFZSxnZlvBhmDo7OAtpUsj3MIHcjzsd99sjUV6TTeqxxNIZAeOWBLbxDlQIeAu
         TovVT0PVIC20NS12SP2AI6e4Vgus3yVBANaM0oHo5aSN5ZOgeVWIowGWM0VqREBLAghu
         QHkO9Q0s9wyq5mrSCXevovt96CfBBeLKHUEWROhgXTexvdLl6URx+FSnRNLg3EDP17qK
         dlPliHuJEPts2Bm5bMJPHzTFKL5oXEo3TDtcyv4JNEybgMPa9hZJITLwgiWf9tF+NAcv
         /Btg==
X-Forwarded-Encrypted: i=1; AJvYcCVkK+F2bAZpYsJRFZ6irx+Lgig7x0ukceV8RjdVpCu4u60+R2mtXq4XgEMiYhkYwiDtfGPlGXJ13YwynUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvhcoCuxu319r0KgjnaklhGSH6PSEuquinhIvqez0G5xyrENw
	tIJnV9ssD/3Qhog+DDDTWrom+cCdJQNLQmd2sTtT+A/iQW4Ln4F9yGYtHUUDIK7fxtQHMWYJX0Z
	KqfClmOxTQLuMeY6UiF7Uedc7Zx2z2D9AlgVcJ3QDHeNWSypoxClpjA+WcBpuJ6YYzU4=
X-Gm-Gg: ASbGnctr8FnxQoC0pgykROYopfgxmo9nrUyra7wtJhRPHpfPa0PCF2bJuxgqTpsfFCa
	xClv8o36qzkwiB0x8RhoS22oO6n+FkfJOc1HNDElb6GKFm/zPjB3O9sYrRiIO1wFSN/K/1qU2Nb
	8RL3exdP9mlO0ndFNPqGKUJCz0xRu0V99NYT8lS9m23nsN7X1BZeaXba9gGEqWeNTt+p8KBZCqL
	z9I/DB8H0fPAkI2EA7qn41GLt9ack6ON0yOgsjbfNnuUrJNH15z79I1wDrF9ToZdmJB7lmWraci
	6YoI1Sa52B8QLXFRMRQSsZ5s3Vwy889UczV16TRdJuT9DKNgXssqvNsCzG4r1pET9LyZqDV/81d
	iIWyTGMTJEpQpeQ==
X-Received: by 2002:a05:6a20:7288:b0:239:1c1e:3edf with SMTP id adf61e73a8af0-23d701eaf4cmr4483538637.40.1753460065435;
        Fri, 25 Jul 2025 09:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH45mowQM24zNVVrDWA1OAKen9/Rncat1udl96ywd3HTaGlMrzSKhS42XbAwTPbo2lmkT86g==
X-Received: by 2002:a05:6a20:7288:b0:239:1c1e:3edf with SMTP id adf61e73a8af0-23d701eaf4cmr4483464637.40.1753460064981;
        Fri, 25 Jul 2025 09:14:24 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b0c60sm71215b3a.126.2025.07.25.09.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 09:14:24 -0700 (PDT)
Message-ID: <12223a91-82f0-4889-8f07-bfa5833c8ffb@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 10:14:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] New DRM accel driver for Rockchip's RKNN NPU
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
        Robert Foss <rfoss@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250721-6-10-rocket-v9-0-77ebd484941e@tomeuvizoso.net>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250721-6-10-rocket-v9-0-77ebd484941e@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kWre5_s61019c4-dM0TR-CUDdaZFZ1hD
X-Proofpoint-ORIG-GUID: kWre5_s61019c4-dM0TR-CUDdaZFZ1hD
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=6883ad62 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=DISFzqtZAAAA:8
 a=XWXL-kdBtCKZFopiRrIA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzOSBTYWx0ZWRfX/AB/FelnoRL5
 1Yi5kgNR5hV16cf7Qf6XXCJJqi4oym5qigElHp7F2cZI71U/XGMWJlNxxDmupiSvLiCqx4xxDbM
 9QohX8ANZYPD5Gf8+2UBIUMbsg9KgVB46JQUm9S+h+lJTE2GvNeUqoKtRw7E0rkKmdRWiZiCeBK
 060I1OJFpV2bhnHFkg0vldg8lHcQb4wVs2EuwoIoS0e230SgA/9fKpfsRS1ymGpsM64Vc1aQRLp
 Dpcnq+feIimP8GHc4d/43UQA372hRTxKJrDIttzrbgq6PcEv4oKsUMpkepIzx1RAe/REmtBC7PM
 EdFW2kB/1uXu1f0+tTlKqvPJszsCcbMIPLtTcJlVQV9V5xgnrD/g1plLooCpG1qy0e7XH0wxEhi
 vTF0AfZvmJtPezBMjjOQERlFSlj/6RA0s+bQpGBz6h/vhsvyV361oaonCUJsU9S8/mpNvcUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=753 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250139

On 7/21/2025 3:17 AM, Tomeu Vizoso wrote:
> This series adds a new driver for the NPU that Rockchip includes in its
> newer SoCs, developed by them on the NVDLA base.
> 
> In its current form, it supports the specific NPU in the RK3588 SoC.
> 
> The userspace driver is part of Mesa and an initial draft can be found at:
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29698
> 
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Patches 1-6 pushed to drm-misc-next.

-Jeff

