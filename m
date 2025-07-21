Return-Path: <linux-kernel+bounces-739893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B811B0CCC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04391C227F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D94244687;
	Mon, 21 Jul 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKSw07Hq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F9241CA2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133824; cv=none; b=uw+H89j632cyOhAu8m5R89htjNIZveGms3Uoxvt9+jf7XXNFuTeuZoJBvZvc2AJEwsw1gjnphy1RWehWa+1OFIbNcSk9cxECrLz26QWpNGkQ8DrNsA4/IW6ON3yKaamF/G0Kh2RwISIDJ4VxtluPMbFf1fEvDNk9xIO2Wepxh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133824; c=relaxed/simple;
	bh=lYYKUhCs+uz4dDmKo3vq02h3Jse8lPTWG6JPP2itZp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bLxUlyjsk4RJsMUb1AdjaAwpW4WujjkarVy8p89C/klZUSsUrfD8ikndDC7fTkxdtxXeDppx0/lo7ZQ9KfunX7dW9JVbD02YwwZAha51SVj0BOA+ok2R47bOtblVWj7sSDSThXIFSH3UVejtwtcgHSo2xZUd8pkBXumSysjDVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKSw07Hq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIgZtB013299
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xz9e7mclBhH5orfH4FzOHx/oIgFQjvxzhGF7K+F4Uks=; b=AKSw07HqCfy4xvUY
	UzFFJrNjfYEG5Oll/OMW5uICGOTmAC5p/grrW6lOf5l8UgIL20ULK+jJFAmNz8yr
	522+IjvYlM5zli87Leg0JCX3jwtm8LPGiQ+5tfXrlpAHxVWqkyVgZ2ao7O5Jfnbc
	EwpJERbfiZsyMaC88UYHt+5XsXJ2fjUc39UcaPaVPcTC9lTuUEl29Wa19Tjjm5zq
	osL8bm2mwsDrUBu66yo54z8B4InSbhEgdzv7vRQEfeTx6RWn9LHeyNiFIgKb+Idk
	F04UCCuxLEiHI/gQQ3+VAtJa36JVU/zxmFm0TrzqHNrhgW3G76vSb3b6/aM4dtnQ
	mSs8og==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3ej1ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3f321dc6abso2306546a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133820; x=1753738620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz9e7mclBhH5orfH4FzOHx/oIgFQjvxzhGF7K+F4Uks=;
        b=qRgotuS2tRgJlt8+FcTIYFZzHpx9To7y8HbQp1V7A0icDPLqvLJxAIjrZeJxI9tr5E
         UY1FGZKHiATgtVrvhBagIbuyrs/C3UwIqGY17Q9hKmAbmZMe/eZQfnxMQDl6fLRwr9HD
         06Xl37NyIIVnn4XJeDCqbSXSsAPBPib2skJLjE6ywSfiw0SKpkDF7jEej6VNbmrceI0E
         kRNG1aTP/+L5xJ/7sbfI3F4zlqVo+bY6V/ZLnXtNymXcDs/uL4Kyuvp0fnT8mmtnKAau
         6qcJQ0134/Yc5Knu6YUsJnBDamD0Hwxnb2pJqRQDIIXf3V3x2+bcLF9ptpVmpc4nEV61
         2OWw==
X-Forwarded-Encrypted: i=1; AJvYcCXGH6cYSOeVFlr/2PqF7hS5NXQLExmg7sWJ+7TmPkb5LHnOTukDBY3BJawNkt3lCACEi6qH2/qCzloaEUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d9zkgs+2tz5wNP89vsBID4NMY0epzmjK8I+wbCJMJ+hMWf8+
	6iRcDrl5ntjjjQg9yJ9CqhoPkVkGoV45xcUis1o2bB0vFCqSjh6HqPjKsV8oimfSnx1t0YtO/3V
	oJOutE4Udo/vFNPJvoYTwzPNtPe5m5Z1kQ9B7A8f4KlaQZUjCBFal/Yc344uBVhQV+gw=
X-Gm-Gg: ASbGncudbiGJ/KobjNJ94fDnhHcIUeYCCDD5nMHz437lTX4+XxIJWOGYU7xMgm/moZ9
	KXyMtElSyCeHWgfYLCyHCvEzrakcdG13K+RkFc3iCyEBRwHe3V5IxCYzhd81/+R/Lcp6vFmLZV5
	/MaEDechBsL2GwoDyxCjVuLe82I2JK+Z4Ev+uwO2rb4O/7KZjuGDdIuYTOkKouTr/yMJwmhTSlq
	jaM72YPDkkkFOqjnstuBoY6fxpG66zUBozT7dHZhjl+3f12EGF2W6t6Z9b+Dxi83KfQIJMW2BS4
	ZA+57zzPD/0yEnfMP4KGjj18aRlb7k4gsE3lFNJCS3XbG8hpIbL4hpEKWwAfAOd9T02gBKo5tNv
	P
X-Received: by 2002:a05:6a20:6a1c:b0:21d:1fbf:c71a with SMTP id adf61e73a8af0-23811d5b54emr38208370637.4.1753133819748;
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7+hgdKgVE4EXjVGVzar57QfYjh4Oy05x6E9LQmjF74p8a+b+VC5yfpsbdqrk8pYEzeHsKQw==
X-Received: by 2002:a05:6a20:6a1c:b0:21d:1fbf:c71a with SMTP id adf61e73a8af0-23811d5b54emr38208344637.4.1753133819355;
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250720-ath11k-zero-brace-v1-1-6132e2ef1748@oss.qualcomm.com>
References: <20250720-ath11k-zero-brace-v1-1-6132e2ef1748@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: Prefer {} to {0} in
 initializers
Message-Id: <175313381869.971667.17737779436475573060.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:36:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: weFSE-laC_6WDa3DPNyDXC_DOUBaSmVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfXxv+lc7qXCC7B
 EKnWpl1mM7GLmVEbxRhgExQNdFsuvszPQHy2bOY/vvH6zJcGl5T7iQlNQjW2Ha2t/VvYjw+lqHT
 VOH7LHzhT4Kew5BYMdsrhD2BitoHIisITv0Xjdt5CDTa+nEWpf/iBreBBOEe7WBH0fIYLlE9ixr
 ai4BkxjtXRq2xJ20E0qsfCu1leOKVVAddDZuFqkREQ/plHgBCK/cT9Cxbhk9iq9lnyGVtDp9cD5
 HxJvIwtZ1tHQZmtRFL/DezZG9xX+5Q3ihh5ln1m0iHNrSBgt7DPHR5U+ZxiftURcgv3xfmy2oLW
 hJBlFFB/a2lTMCy2CW1HAih369MgXZ212Y/uVAnlyDhiqZMVDxlQqO+ylv4HYpFSRxJSNtTmJe6
 3bb4bVEI01K4qmpuqLYOAelETjMku5tfFiRlR5t8NPYrWPdsxvbCfwjOjzDjBVrIlwb+IoIH
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687eb2fc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=tljXboN4zLINjdsvJowA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: weFSE-laC_6WDa3DPNyDXC_DOUBaSmVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=656 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210192


On Sun, 20 Jul 2025 08:13:38 -0700, Jeff Johnson wrote:
> Prefer {} to {0} in initializers since {} works even when the first
> member is not a scalar.
> 
> Generated using:
> sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath11k/*
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Prefer {} to {0} in initializers
      commit: 1228d99fac4c103a1ca6af82ddd27ba2c445d0ca

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


