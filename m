Return-Path: <linux-kernel+bounces-743240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A59B0FC57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A88F581E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8927146E;
	Wed, 23 Jul 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AfCtL84g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007042586CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307648; cv=none; b=fOBHD8mlVRuF2BjhZDq07LPizRmxsA4gyN383fAH01Ze4km6r9pgo2MTgfwJncq7/f8hrsDGU0zN9tfhJKCRtKiyqA/gkn/JgzSX0jOQFxiJPE2qLnm+1BxRFdW0q0eMebTfTV/BMuwKR3o1nl8T/xXo70vRQkUPfiLgiYTPh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307648; c=relaxed/simple;
	bh=jjCh+UoYp4thUJ4utFKmMc30L5O1p//QCj2O11qZk6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4ZKodKDnUUK51FzQ3Bq/H36iKK6oVtFHhZeuazu2ODkt+Ulr1xLbQDOb3zUQ9DBESKH2leVsJGFwSp4wqbtQ+UrIfOp3AHRkyh7RlGc3PFpbXrg75eCTPkOBpEViwUtdfSZNtZ10YmRKAJrg67Z3n2OSbymZuFjt0OaprYUETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AfCtL84g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHLd34002998
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzsHnqL9/hadPlM9oZ6TcSm5Sor5EgahUS/FmSJA380=; b=AfCtL84g/WgiuJo8
	wd98mkQAmPlVVt0pymqGy8LmcdiL8JCcan5VSCAzVgcfVUWMWrBviYkbGYz6AM+z
	7OG85BulK4hhCfzezB/KgaxMsuZzLuaqexCRlZLMas/Shozs/hYSel8eZ5XQJkQW
	gC6nKykdEqYgjqZsFGOBlAs/jFh5u5ij6kxoMdJxZzsjr82w7sFuBwNEhKW45Ml8
	jW1PIPutGH21X9cLYxkf7qWD2QOV7z8LoIhetRMVg/SzupvATa/V4laKwtYrWUpf
	49Z+X7VeKaq67FgOdh5qniGEVkJWkopuzDaqiIwSm/E/sWJty4jt1HaOuaZapMuJ
	IxoDoQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1dy0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:54:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso250206a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307644; x=1753912444;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzsHnqL9/hadPlM9oZ6TcSm5Sor5EgahUS/FmSJA380=;
        b=d+ldnSKo0Ye8CXke6/9k5uHce1CtXfCRTlYqL3rl3uiA7U4ILNTnZIZohKSHHD8/eC
         iLb4DrNegZ9BFhpKUXLbV0F2q0q/fm/JX8NrwAhs5NMsUdcitSI8KzSpOjtRnr9MRVRo
         BZE5QuLIR3ft62MiE/OmJ98tlNeDULwFDXYJ66uoZOtiWWcrxGUiXcaO/OJ6prVnMtHI
         lMGnmsOHE3Y0xH9Oxhpeslwqbr82yT8tivFU6KKKlBY+swlrk4XFGgoa079BuqP2jP/w
         POP3xlERZBBUeu6NpziyYOa6uHBSUqApsnVpX1kFQ4Cc8teEJrLszy5GNxAXff7pSNp4
         LnRw==
X-Forwarded-Encrypted: i=1; AJvYcCWcuBGR93aMn/2b8rY5vOS6gw449s8MW1OdS2uPKmiBXQyKsA/2t0xaVpb1thqAuKUHLy7rkhqLgJj9S1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVc2IjYQqMBs6xsWSbUIPodBguP5NB51Lt0yCtKJO5fAsUMk+0
	J9DIq+X2QuVDnEfNqvFgtS9XMOdkPK6nstW0kdLrXxpyzL7DbwpYR4nYOQNYRBqcYb+f1cDo4lN
	okuVJuYU7ZzKQVD/BxtGGlLXuMpDsltBJ5NMRcOMyKJUyhOsVno+F0EY/cJiL66moaAg=
X-Gm-Gg: ASbGncvaoR5L+M6Z3dtSY/lD9TowiKnfLFLcjXUXH40RKjEazYk8gy9qzwYwVI5mDmK
	yLXXZUBCLix9ghiRpEaspUpIF2mJLyHLSbjSU7Gtlb8BScmJM0H7VcEz9yVS98XsSZrkOcdQkki
	HlvAp74bosNaCWuE7pO24oQ4B0j36R7AFJrK6b0HSV6Xui3Niym7kRVfjmPjMw8daRSoBSFlU/h
	tf8b9X6YoHR7tvHBvNdGTtP8yiAPdOdCWLGcvkGH+4sNyAF6X0n9A+d4sZsUgWchp+5hOSwtIaB
	xyFarRmeh7krr2csOuhLxHhnqJ4draRSdMGqAoSdz28sef8B+0P/i2jVlMCoSQ==
X-Received: by 2002:a17:90b:562b:b0:319:bf4:c3e8 with SMTP id 98e67ed59e1d1-31e507c4148mr7375981a91.18.1753307644537;
        Wed, 23 Jul 2025 14:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPJPJDfrA159Lqv2Tdqj6Nf4Prqoe6Smdo5JPb9rk84PO6Hho36y1HH3kU1XqlJ1NR66kYIQ==
X-Received: by 2002:a17:90b:562b:b0:319:bf4:c3e8 with SMTP id 98e67ed59e1d1-31e507c4148mr7375953a91.18.1753307644126;
        Wed, 23 Jul 2025 14:54:04 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e639d780esm54569a91.1.2025.07.23.14.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 14:54:03 -0700 (PDT)
Message-ID: <343d2e49-aa52-463b-a844-e78af2a54d1d@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 03:23:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] drm/msm/a6xx: Make crashstate capture IFPC safe
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20250720-ifpc-support-v1-15-9347aa5bcbd6@oss.qualcomm.com>
 <d50f9a01-ba8f-44ec-9206-fcef641333aa@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d50f9a01-ba8f-44ec-9206-fcef641333aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QLB2BJbjCXesAgvyoNwco59PabBdSFRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE4NyBTYWx0ZWRfX8LozSPgDuB8N
 IgMbKfD+vrv6mO6eO5eN7qa9uP+iF/CqKvZMCvn+D2iGhaAGr6Q+ZcxZppvZz18J2uyhIUoENnm
 5rdO0UavbAlcz+IzAFm/HnCBLbv3I95deEKLTuKutP4WENMFZacwdfM7mtu39EvCeTcV9yRl3io
 TgqbdpBdQmagtJ2sjY62++tSfSLWxqhOboJMcYuA5LTOdYtfhm0VCFO9UaFrP2+PWqF+RvsN5YW
 MnST3zbU2K6I3Pg6DGEKbOSukKZJ5qXjw9oLkK3hXxPgzevVYV5kyksk5YrhcXQIYf8EpE5WgE/
 AdbKlirB5HhNn7Tb0XRd3c1mN0Rwqkj3VcIeDJVi1rx5QgOavXzjpA9e/EvqC5/yHBGJq5dPMZ4
 uHN2T4SxCkzE4UnWs8lS2e0/rObap/pdGI8me6ItUo/uBwjHShJopE8XVNFqdTHVWxrNa5pI
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688159fd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5VcmFa3VxYkzaEkvw6AA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: QLB2BJbjCXesAgvyoNwco59PabBdSFRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=463 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230187

On 7/23/2025 4:02 PM, Konrad Dybcio wrote:
> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>> Now with IFPC, GX domain can collapse as soon as GPU becomes IDLE. So
>> add gx_is_on check before accessing any GX registers during crashstate
>> capture and recovery.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	/*
>> +	 * This is true only on an A6XX_GEN1 with GMU, has IFPC enabled and a super old SQE firmware
>> +	 * without 'whereami' support
>> +	 */
> 
> Firmware that old won't even be accepted by the driver, see the slightly
> confusing logic in a6xx_ucode_check_version()

hmm. you are right. In that case, I don't know why we still have the
below bit here:

	ring->memptrs->rptr = gpu_read(gpu, REG_A6XX_CP_RB_RPTR);

-Akhil

> 
> Konrad


