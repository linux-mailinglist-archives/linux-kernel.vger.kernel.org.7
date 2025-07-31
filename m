Return-Path: <linux-kernel+bounces-751860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76CB16E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A635634DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B82BDC04;
	Thu, 31 Jul 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pSeyS4kk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A81E571B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953680; cv=none; b=ho3I5cFoTvtcyT9HwdOQo1OXYhrNsvSViKCaUDmxxR+7a9pKdMnzwdNULbjRTcGXIBsKbE1LRuJMEQRKquck2uwEd8ZT84JpxOYjbFKgEQxZmImQrRV8FlOfOJZU+JBa+JjPO+B1bWocSH9lJCkadu2BRmnfiZXdksOKDqp0eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953680; c=relaxed/simple;
	bh=qlDKy5v33MNBCPwvxdICUi44jXxFlSdLVNybQ4r9BTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjIVvdLMUL+JIo7I/KfV3rKz/Mv49Q0MTb/PrFDCkLRU0ryCqEmEAqXpQ+7wAD6SZQBsQBYsyZMiAZ9YjHSrbNftkO+aiLxiR5KlYyjiYKrReGfZivnjgf/AtRjaJ4PAQMUL1wkVtLb2H/2QDLQbbqZ7zigcajdHBkUXtBKvbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pSeyS4kk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fMq3024812
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tyAiPZN05+p3QMCIsbsm3CJ18gwqmsxE7OQUlpLa+6Y=; b=pSeyS4kk+WgAAnwY
	BnB9TcCKMH7aFAq7f4JT8nTSkiiIP6AVWRZ1X+GXkGtRSHQjNEJD1rjszDN1tHqE
	Ig4CmpPgC1chcXjQd+xX9pUKIspPBfQCQdLbZnboz3J9Po361Iwz9rZRiAX0HO8h
	nUmFiqiHXD+8ft8mI+etNuBqHaDfeeBUK6oxAGXeDTMwN1CClupFeEm90Gu28Adx
	ebfkUGVuUxG15rliIYw/9fHrP3e+HvVj48d3SN3PA6f/HGndAPQ52EVZBLI25tPT
	jiCoZsXrzYGNz9yv31Lm2bj/19xS3LXrZfhZ4A2cW1on2SA+fiLncQ9PTDWgjSoK
	JZrQYA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q867bs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:21:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab61b91608so2337741cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953677; x=1754558477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyAiPZN05+p3QMCIsbsm3CJ18gwqmsxE7OQUlpLa+6Y=;
        b=EDS4ZM79qXPUF844+E66VklYQRKriogfIY+T1daJdgdfquSeSdjjpfvhueskRKUrDN
         Am2IkV3KA/tKkLaUvrvvFX3RnVk3xFdAnJ63t2zY59gFX7iXfJ17/bZZRXmhWJzWQG14
         P6O+JdBJfMGMDTNfYrVfiHPceGrrRGrZnlgcBumv7vajzuWu1E510XllLqmljUVgyaHw
         tAURsAvOmHI37k8EfTkGm3TA7MehBfphTwfnKR8OZC8FRPvLGE8t/x3EUy/iY/BfOZaS
         UOEMmLsN7ZkVTI2goM5jog8DhdD0zjo96v+z5LPsGbOGoQZV20K5DuzLwF3xLddREZx0
         rN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs5R4lS6bBXjVioKIdmz/UnLHdRPTAy43D8fdpo606T5yeZ2RTiJCh7tbtMCR7VOa5ta3b/AWgRPSP3tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNOeDG9YXLgdXa+xia2z1hUAkOo923sOtXJOlxLWHXW1B9rUU
	I6eDCbe/KLqYTffiZutvwqO1FaPkp9zWx/kjBSN54oolZXe39M8tWjzM3MZ0beAV2RTEM3k06pS
	hGg0uE0vht0SvGmET/9Ne/qpgmTpYJpFARAmXgEzCObKvB1J4sRuhuWhqlefNXyfyTFo=
X-Gm-Gg: ASbGncuO+m5dEVMTSJdqn3KH4aK9WWdiqinTJPlwKpT7wYdLxmnMsqN6B49lLd/aURV
	qQc3ZMfnvuaRSMQyqDSFbRsy1haDORFIcJWA7sGjOKSAfoxb3pfl/3vkZDDSqQHWMsO9ZX0NWTJ
	TVJSg0gYh+q3+K+echTFE+HK1oFk5uTEhTuKQnu2rumAg4zOo9umIgBZ+d1br9+kWphSjrXsv9E
	T11LAZSD4eYWXVZvkxtI8+u72s/+Dn/buhDplWujtmXdSq/IblkaSKYHiZmJ5OourN8yZMRpNs4
	K/fFG+wu8lNDS2y/dlLTA4j/OsRsbt/2Ts1BUCq9THRLX7Q35oc4IHWVAZgnyhty94kHVF3Hmwk
	sWtx9l+Mn1gS6lWnNhg==
X-Received: by 2002:ac8:7f4d:0:b0:4ab:72c1:cf31 with SMTP id d75a77b69052e-4aedbc5d109mr47966941cf.11.1753953676636;
        Thu, 31 Jul 2025 02:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg7y3Mzh8kLpvXdgFmJK6NcsIZpRA/EOh3rdkLqhLgosRXc0fkF06g5WZgKCLXL9Gc73OGlA==
X-Received: by 2002:ac8:7f4d:0:b0:4ab:72c1:cf31 with SMTP id d75a77b69052e-4aedbc5d109mr47966681cf.11.1753953675720;
        Thu, 31 Jul 2025 02:21:15 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3792sm79613466b.50.2025.07.31.02.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:21:15 -0700 (PDT)
Message-ID: <304124f3-3686-4a04-808c-7ee84356966e@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 11:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][next][V2] Fix dereference of pointer minor before
 null check
To: Colin Ian King <colin.i.king@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731081854.2120404-1-colin.i.king@gmail.com>
 <20250731081854.2120404-2-colin.i.king@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250731081854.2120404-2-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2MyBTYWx0ZWRfX3sXzOGc1SXKZ
 xBPkpCYSgse60da+wkSZzPj8GkbgUTrXfvnRE2nneY6tBwEOe7rhNz69sHA5f5CnMyNT/5MM0Ng
 S0d940n7KlNNCL9AkKk0gabVMlTd4flwnne2fYcjfMiDyZSgApSgpo2Le+QBw5sFD5CO20gSn2b
 64y7Yiam6LQX6aDgFdwTki6QlsWAuDwpwHrx04dATGhh1WMyyq59XjIxXkg7nMSqFLdcStkyfh/
 zxdhqmwcn0itAzw/gHuWS3P9MkkdvdSktuAbywUhx/R0siMT6q63pG11aW2ezclihA95tjN/VTV
 IGl0R3TwdDFnGXGfn8qHvrCHxz1xTzgP48zYnQVPVL18TYVnp8mp/mFYRG5f+xo1nJjYnjopRZH
 lmDW1hMUgzSHmGjrpW0zn24OriyYXQDyPe0xUq3ZQ+ozA4t+0f6lUHva9uQiae5rWxE6TN0l
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688b358e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=uhsglmO2XhRCQ2AnPp4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: gP3y8ziu86ENL8Kl_mmaMX1kJ17y2Ctl
X-Proofpoint-GUID: gP3y8ziu86ENL8Kl_mmaMX1kJ17y2Ctl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310063

On 7/31/25 10:18 AM, Colin Ian King wrote:
> Currently the pointer minor is being dereferenced before it is null
> checked, leading to a potential null pointer dereference issue. Fix this
> by dereferencing the pointer only after it has been null checked.
> 
> Fixes: 4f89cf40d01e ("drm/msm: bail out late_init_minor() if it is not a GPU device")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

