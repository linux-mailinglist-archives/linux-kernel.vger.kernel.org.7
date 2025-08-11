Return-Path: <linux-kernel+bounces-762362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F6B20588
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACA23B192B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D82641E3;
	Mon, 11 Aug 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fa1OArYr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F387225409
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908423; cv=none; b=Mc7pzjyEfpU9c6CtZZSaorZ4jxRpvKIrDnzBKQv4uG+BGhFgrtrmrJtQLNrlR5tM3S5dxPwU8t+F8v49jXJ2z8TuYIxbEFHG6HMkma2xkyIOjiL7STzzroEndk2Zceue/OqmxIIf9G5+vVEAMi5yx/1H6SQN6cVeCYBKiJZJC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908423; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlE0/AQxFIWRPHOdnQVkzPmY1Wu94WfluhJjbbHXv0dkw4TH5yxS35OsEtxE6oBZEKGYy+FeTTThfqKZSZAX5qcmTTEmA3nahiAIunl/QMmwL5AUR32b/5KsghlcCZLJehe8THOb12fz/1ylLBRzp5M6yQEIQQC/ypbt91xOWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fa1OArYr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAGIqU023741
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=fa1OArYrsMY1cNmv
	6U5JEBininEQETN0UrxidHl7XVnaDk1pndGlmoG23MCFUxED68xnDTNCSFHJIoSU
	ZIPwylxia739ZMNH8Q+CRQUzLNK+jVU9M9ux6Cvxy034AnLh7yPwJRzmMV4k+kT0
	1tqtXQl0X1XLW9KSZtgGRL0FmUFs9kNo2eMOVUzEzhQaVnNaOf+txkpqqpVJFLUE
	QDIsKSTgiY4a4JwpzbQisDLiDH3mLyYaeATtMFd8khcUsIKrsCZ42+Z6enisuDJY
	etaHEHFzHMotOcB+HuB7UIY0rf8xmx+IGGobpkQA5wxETZ5MyMyGRf08VgmHOPhk
	ZJXPMQ==
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem481av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:41 +0000 (GMT)
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e9055838071so603137276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908420; x=1755513220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=UWFeUFqr26YUDVIlyUqR9i6I2zcWhUPiDiU8fLm1iFuQqiZH/DBlljzZOv6Yy64tKw
         vNJh//VHV3gdqQgI0hxujsPEoGas58Ygnb774FdYIRoWIid2iyhtuWLQv+fw0qxgS2Z1
         XDWKfI2N8zES/NJ4P22fQb6jYxCs0WxxRosoF+c4gBe/Bjs9e1mJuN2pUKt07bNWFzRJ
         RSLDE0UjEyZ/dfDiPtPwSGNI2awRs6kmMZ3izRu9sxytWNha4eXv24DZZh4K+hH7PmCi
         2hgR0E7zjDOJbIlm5wuaHYIovd11d9W6QALgQhZ4NuznNFurvEQPPhbyROQI+K29RZL3
         CwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0bDCXMndvL/ulPHDzAJzLUPns688oCkTp2TNmb5QCWi0RnLaJGwy/sBtnZxmgJ1hbzsbVyZNzOatAwkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYDgDOsQD5pLE4KvWXqnT/5QZPJ/ZNxtVcJCsitSR6leHUOg6
	p3hh9yWF78YE3V8RYjLEXaRe+1C7VYxOJlh+ElcmbFPChBC8HF8tlSjmjNRI5IeP0tE47LEdDOt
	GFEBVI8uL0SNBfjpbbV0pAF8Komk4oV43HBHeGU3Q6R6+ffUeblE/gZUJIjzFuLwABEs=
X-Gm-Gg: ASbGnctuRKNd2oa6l3iXJhtCYfPIlyVOtIwktyJdjCrXwXA9nTStZ7crPoIR/78R/8Q
	+tw3xGDBGt7juNUtBQr+h9XDy4/T2wlnePVztHjPeMCdno7G+V19M9QUvtI9HtcAIgvk6xfX0uO
	pGQhXphStMdTgpdRcFvDjsQRW0QkRma/XyR3E20QR1xdj+qgTnH+0CWLjoFcMnAncX7SgYOSzq/
	gM/cAW8YF401DBhOSyTllgsZogQXptw26jx2BnYvu2NMGkm995iXVzC+oQq8QHiv+zqAluCxFOP
	fAVfS00KLlTvhSoJzB+so+LOJneTi7xVkdbO4MxXs/kkY2nFboqDNANEWC1Gm9oPAoYkhHNAXVd
	1iLoxMDzwFyBLQiyxgw==
X-Received: by 2002:a05:6902:1105:b0:e90:569e:8a1d with SMTP id 3f1490d57ef6-e905c530befmr4533782276.0.1754908420459;
        Mon, 11 Aug 2025 03:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEntP1C0STH3bZ4zJOHqYgn5Z4wBvYvhRLLkeSBhIq4vihJkw/i+kzn7lwfCsqCq1ZHC74r2w==
X-Received: by 2002:a05:6902:1105:b0:e90:569e:8a1d with SMTP id 3f1490d57ef6-e905c530befmr4533757276.0.1754908419897;
        Mon, 11 Aug 2025 03:33:39 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:33:39 -0700 (PDT)
Message-ID: <238a18e4-43b2-438d-9ca4-886806b77002@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] drm/msm/hdmi_phy_8998: convert from round_rate()
 to determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-7-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-7-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A5f5stVv9bEm_1SytIyOyyeyoXklQ4Dp
X-Proofpoint-ORIG-GUID: A5f5stVv9bEm_1SytIyOyyeyoXklQ4Dp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX86xFbSexP9Ky
 BGuXHaDV2c+DJGd2W0tCjSO1d3xp7T0PscsO+lbM8/FHNhIjBukmGUZcL8XWJf603tw9qErEOnK
 szItfLwL0S1T9dxC2m6jSp6aiM8444qh4hbjyFoQkIGXJioI2mYEB9YL+38sNyT4H5X9Q8m7gfx
 LIZtymHrUI0v2gHHOWL6NU7Sf2ABjqI2xdyG3WEWs/P5KWVyT+CVtuRvuVXtCaoRE78mPloExy2
 2pn4IqemqvCJ3Gyop9mCBJ+mUb5tWsE1tAsvJW4WOusiOGHXCKpue7NMe8T1gciHRbK9VedsqLI
 ci58th5XN4Dl5EAYNrgzb/cqhOdcjlEs6sldVvpVWpk2bEdkdrfJrGLH8cZxvPm4uCj7/fqSR7R
 k0aD7auL
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=6899c705 cx=c_pps
 a=OxDXTYJfYfhXdKRNwaci0A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=cxVRdw0VslE0MYWkNwNp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

