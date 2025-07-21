Return-Path: <linux-kernel+bounces-738768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBDB0BCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150DC3A0F83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9727E05F;
	Mon, 21 Jul 2025 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BDRFiugy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BA1F3B96
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079902; cv=none; b=ciYYnpEZYYEliFTkijXK2gUStcsfbdku8l4Qr0pweqWbj7OnhhFNOQg/Pcbq8WkyAPkA2a8/fiTxOt3l1HSFyR/KkdH1StfuTiJvaiVdFzBJ8ao7P0g8k8jkE4hbHEO7nj2sIBfX4O34PETH0YE/cHTQ0KTFGuCcPHDhWIzcVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079902; c=relaxed/simple;
	bh=ZcoU0TGwdamvkaiI2FBd7ECUaQOwGpBw3EYD+sAv8S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzpQQkn0SiFt4c4xkrXQApi3MJwDzzbcWNRtUw3hB9AmwLXd7GPxlE2iTJOkkOcBmb2b4oD2SvyoZFmRe8U7lKqOH0fLL8Vm6NdGkYVMY+qWEjpOzKmAazFfglTDhp5RF/Z8je70Rx/J57RGts8fml3kLT4roGlj9ypT2dw5cvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BDRFiugy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L40e9f029344
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZcoU0TGwdamvkaiI2FBd7ECUaQOwGpBw3EYD+sAv8S0=; b=BDRFiugyrqxv3i3i
	FgVP9TWHbvtVHHPXQ+WMfOkJp6KGmLgOn2C+oThHXkr/ldbeYRzjvW9IVUCvEmZa
	lnWWvYBLovX8LFWkxEeQ6BErK6kSQ51grGvDtRX7bVxeZHm//AqE8gIR2OAt7qEl
	FB1hfvJri+SSVfKjCFWUUbN9/duOdQSzrL3AlCVwAfuMqsZ2aW4qYedStdmbOnYS
	iZPzROKQK9ZjkxbI25hTq4ZjEkH4qksPcgfayRBtEEnWksdDL1Sd1Y4rXubOZYca
	1qmDol+rRgOOt0ZedsfJcCo+9ProMn6lLbsR+0lqEfjI8iirlovbgHEsO/q4XgG1
	rfRt+Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048tbkpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:38:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2369dd58602so31308745ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753079892; x=1753684692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcoU0TGwdamvkaiI2FBd7ECUaQOwGpBw3EYD+sAv8S0=;
        b=LbtdjZgBUj05bNGLFQ4Wv6culKy8U8krVzA8SOWoWqqsLMwy1OTqFmnvkh7n4hyPdh
         6/58ijoDz6Ztcjh1xdz3IJ8ozpcFJKmd0uUmW5a4uqVQkGrvXJeZYoD2PSq15W6blON0
         MSjYQFdE0WsVyzSWRx/UKCXaAj3Whrwy+5DB1ioHEvS0O+yt8/xBZbZp/6SwoyNcoqsy
         aRIg2DiQ1D81rVJrseLWnTsuigatvhN7b78btBETaXi2e2JAR1TyqwMCFz9vFCguhMZp
         7ROs2EVxKbDqyFp8grWEidIGiyXMHU8X4FmgAW8I5mjIDa7vBN2CQb5EagUAqTjBCGP9
         0ZQg==
X-Forwarded-Encrypted: i=1; AJvYcCUt5hUT3cUSiEku89amIbXRu7Ii6vIHMyuqPNUZloV7DkOB6mkKTyDVes3VScuBFJONH//LBrHpCMZgYus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqZxDE/M6o+RNBhxffLpihBc8B2N2c8k2jIWOv0Aa9TAooHm9
	tAELcfdUjolJELcBMYGWt/IG2NvKvYukyTsh5eEL5Xq7/wm9Xgih9XdZCXgqEWPeOtOVi/C/WBJ
	F5aM/r6T7HURBMoqxP08jEhdXkprckPnkP4cbM9eJTYdVyXcxdakEqWqrIdaEVh+DbaE=
X-Gm-Gg: ASbGncv5RQxVc7oJBzbhbERnlpvLcWzofmVALWg7Vnq6xyhYZ1701FJ3zgFeKSL1QmJ
	h0Cm7hdUqrVwu8uFh2BJ7H/2b4Cd+VMrLGBSeWx1MRhKFndnYLBTP5nOw33AvtIdBoLeaR40E4f
	b8pLq7Fe12ryGmmvxl2a9THWPKFfnpgoQwL//j2TNR8hpEkr+r2WldJY60uN1gJ2Vr+ZD14ulGs
	VihB3Rv7p7o34Gu2JAziOsK9SfxwC84jXGMm4nN+GV0qrCalumY7w1EWZ4H+EG+QUjqwrLm9MKJ
	9+XxY0Lx3Jw4xWqh1ovzEc4xXjYUpguhkJjfgNGtXSwpBEBq4yRAnRrJGOf46Fj3rWqaNsAjbyR
	EJNqx4L1lD2mgakEHMY/gnDmF3lZrPHS5Pp4UAaXvH5lEtLG+11/4
X-Received: by 2002:a17:903:1a85:b0:234:b41e:378f with SMTP id d9443c01a7336-23e256b5f80mr272335775ad.15.1753079892328;
        Sun, 20 Jul 2025 23:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJPo/UaVeW+EGlYevcpLuFgKAeIRLV0gRofHorAuBZ0G3Vhe9/bgkD/9w7yL17PZR7jZP6Aw==
X-Received: by 2002:a17:903:1a85:b0:234:b41e:378f with SMTP id d9443c01a7336-23e256b5f80mr272335385ad.15.1753079891894;
        Sun, 20 Jul 2025 23:38:11 -0700 (PDT)
Received: from [10.50.52.170] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4de3sm50912045ad.111.2025.07.20.23.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 23:38:11 -0700 (PDT)
Message-ID: <ee2f2d91-c18a-44e9-b048-10cab911e65b@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 12:08:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support for Clock controllers for Glymur
To: Krzysztof Kozlowski <krzk@kernel.org>, sboyd@kernel.org,
        mturquette@baylibre.com, andersson@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        taniya.das@oss.qualcomm.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <bfe8b558-444d-4fa7-9e01-e55aaf48f2d2@kernel.org>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <bfe8b558-444d-4fa7-9e01-e55aaf48f2d2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA1NiBTYWx0ZWRfXzc1g1m/rWkCQ
 uMtxbzRBnGQKDSv83biii6wrNKHBXHQqRpoJKjpf65ceindYqNlpB167RVCdFdLnxHdotPCjTqH
 N57n+cXXom1n519IspghejsGGz0Z4UyPBvnzTHexx8GF7y3PKWf1kU1reaGoedrAIVyuuk+5dnF
 CP0vBYgeIzrMJvQjepC354A4eVVEbX4TtUM5HCQknGnITHwAHixKi7p6eiL5uZdQwM+ydjgILQD
 3RzKbGWk23E+URTPTIuKSPhFRTdWoQd6PANHFQWH2Pfv34Szxgx62/S2xwxX+SLP+jq1AdQilPJ
 3XEMT4mMrWOh4zzjliMsSZs8ZYxd0lkQ0ef/MRI5CmFjsFfx/Brl3BtdhvWDGKds6O5VUJ1IQiE
 6ecG+N+CN0EPc/MkiIVG4aMnByyFqoH0rxq407WHftf/9w+rOSgjvEKdGRnvEtG2/L0vdqa1
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687de055 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=8bVFQ3Vb14ZConFL0MkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: uAOlea3rf1lPvxBhgU7gx2PHrKd5-C9o
X-Proofpoint-ORIG-GUID: uAOlea3rf1lPvxBhgU7gx2PHrKd5-C9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210056

On 7/16/2025 9:42 PM, Krzysztof Kozlowski wrote:
> On 16/07/2025 17:20, Pankaj Patil wrote:
>> Add support for Global clock controller(GCC), TCSR and the RPMH clock
>> controller for the Qualcomm Glymur SoC.
> This is the first time this name appears, so if you do not have
> in-flight board bindings patch with full description please say some
> words here. This will allow the community to understand how this maps to
> other known products, of which 99.9% use model names, not internal
> codenames.
>
> Best regards,
> Krzysztof
Glymur is the next gen compute SoC.
Will update the cover letter in v2

