Return-Path: <linux-kernel+bounces-741459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20C2B0E466
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D961567ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78919221297;
	Tue, 22 Jul 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kr774tyK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82084280CC9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213948; cv=none; b=l8nkeu/zZ3YsXWIoGmCZ8kntVMPqlFux3IasN8OWJ9WnAf5QrR1uteAApt2h3p4SaT1En7Hoop4ZwixBCe4Cx43tlEYYGoi0fWe5duTsmR6sgRkYrjCA26E58Vxi4ij1EuVmQ/AoHo8O/ZlXUlA2VVug9kudQpPbo8t7hlxah2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213948; c=relaxed/simple;
	bh=+DTj+E2P7uJr3tHLoEQGe/iSqEpBHzLuEPN9shGIf7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpbDzanX6OXi7EsSortQpbpnd0h45vZSMe5OcOz5HOsP7GbYJna7vgaMtZm1Vgxwa2jVhlvo6gg2gdJt6f6Q9xNNpYtSvigVCD+BGpekQrRj7HOckJ+qiu0I3Ooakc1aSM5h2X4c6lVWnq6A87IwmeNH37Z6JktVblb+uLXplzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kr774tyK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCriOg018099
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NgleyO5RfA0jJonC4fbj/fBe3zzFRDRyWtUD4mibfAg=; b=kr774tyKpnQ9Zyws
	IuNzzBUb09SF2MpAfZsdQnslNeHCnvzeZWMs5fDOb38LZRUtSJnk3arYSHS5hXjt
	yCimrEi6zN5BHVIDmqBsUuN6wBtQTl6hNX4nS49QV2Wll6ZTEgl8EsR2BKZls5wc
	7X+gf3kHSKpRARHjXcDdv5q8ts/KWNteAlWdX23/ugJDhxKwXSfbuDoA3I7G2ZGC
	FHmn911HnathefJ52Ew8TVzbdeuZF4MAmQwASVhC07a5OdN0Y2PJCY6MnDRwMnJw
	Yd4dJBqOv0VRoiQ68WLJ+UP8+6TTwYsyA3j//zWz6LRTA2cMx0evaUs/xQCv155N
	uGGL7Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1u98xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:52:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7492da755a1so4457657b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213946; x=1753818746;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgleyO5RfA0jJonC4fbj/fBe3zzFRDRyWtUD4mibfAg=;
        b=Cvib46Ffdv6NrEpIKZzNxnerBxLaq3ut9p7Lc/I0p2Udoc32uScqbgGmDyP5a3/SRV
         OObpE9zFikdgq1DPIKyyfPMC4VGO8ZuYWmdn7d1IC1DK4t/d08W19BwGd6D8saVA/0Lj
         agPZAuYaFNKWF6FZLdEJNXveGtAC3/zM7ElQz7C/B8+8TiLRkAV1rwy9vaNReXtSC94p
         GEiZH1LlnfpJkg4AQLSbqEVaN6b/5iM5YJ7Yak7c73Ch9xcPTDo6QDXHfAd0SajLEAhX
         hHLUVCvMSmDkGcUn2CE/ygcHSMG3S/nQsVtOSzJWK6UdDVT4oCicxtfcvzrODf2dWG/n
         R6/w==
X-Forwarded-Encrypted: i=1; AJvYcCUsDmEUjUn1oMDLdlYQy1r4XSOV0Zo9HoGorYGQXaFULPS2iPYBHjB6tC0PzEwsEArQ7yuKxjopFr6n++8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQ4JBONN8hIqGh9M2pzGSrqEeNi5wPgW1Ed+CI4xWU2rV38dH
	dvdBrmIyEui4GMPvnOLS9bE01z//AiuG9leHdSx5YIvJOa70fDLVHx5NANNhC/CLYgUVdYy7JqV
	4iiUvHIJwca1mSdE2fHvxhX0GDzkg2YDNma73YOpryhn4uScymDIu1+J38teha2Aj31k=
X-Gm-Gg: ASbGncvmbZoveToeR4isZHLf4kfFwva7NyKtULaG0u+BBZsfYSqnLB8Veaov+jEEgoh
	7BN8d45MPOadbJl+5MjgQSxrvWcBZX5lp3dqhLz+5UvWBhOu8keKPwCAEXutj5uS7yH0jId71d+
	GEyScLzipAZjq1JMXKuLlHcDFofxN7RRVnWtsB/1dTMw899z8DL1G8glwKALF7mLgVUbCFiMhht
	V8Zzuj4bl+Hv4jKccdXCOcyfJ3d2A8xA/cKxakRYI0gyhHdbTZw0eMM3s3Cds6Z/Tft2rm2grWc
	Ex3qS4dpODyGUQTbPRPg1RpfO9NtR77lUFjbJosjmoVb0oqZtcFEk9mn9po53Pga
X-Received: by 2002:a05:6a00:2446:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-76034510546mr882718b3a.8.1753213945709;
        Tue, 22 Jul 2025 12:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUuhsn+CPJWTbTSXO1IZeQTiGzjVoE9h75N3Pgihn8vh+oCDCTqUQNSuxmfB1Ryj20g7s3JQ==
X-Received: by 2002:a05:6a00:2446:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-76034510546mr882673b3a.8.1753213945209;
        Tue, 22 Jul 2025 12:52:25 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd63cd9sm7622600b3a.160.2025.07.22.12.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:52:24 -0700 (PDT)
Message-ID: <62391e11-2f26-4e30-9c8d-b47d4985b41b@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 01:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] drm/msm: a6xx: Fix gx_is_on check for a7x family
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
 <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
 <84a33e15-edaf-4951-8411-24b17ee5f4f5@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <84a33e15-edaf-4951-8411-24b17ee5f4f5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=687febfa cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KQakvA195p00paWSqTwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3MCBTYWx0ZWRfX0pg6UlF382hr
 Cczfd9H1yVVLYNA1M6sVyasNuQObK9lUY7tD63Kym6Y58Eeny5M1y7ooXRp+8MjaCQuHTO/5duY
 TANdz/oCJZfud0+FKSoK5fh82LXFfuOYOxyj1tmkc6FT60LfxvkeQLoaKfOkGxaMg+CbZkKxDyW
 WPLrl38eZ5YVbrhA0aKXTRwbOPvu+QJjKkSIExQUoqLh8JNxEF9xwbMRwzSjlxvRFw0dxP+6CCw
 BciTYoptPZjCBReTUnXBJ45iVMi5L+veDWeOCAAX0adeNRoPsSb3zuJOFZAt0Cki/eeY0r3gdQy
 uYFfgH5YoAofY3rAgC4CaUBqI4BabscA8f0im0iFRQWaC/zXOs68feaKF5d+SWROOWX3HM0xEF+
 nZPuEfbYH3UC1J6HyBPYRrGiHStOcCoF0mAEzjdKgUU4ist2KUbFO1josh+JpRvphNQDUM+Z
X-Proofpoint-ORIG-GUID: UtzBRyfBlTt5KJQMuTQKeT6rBqWGTtQi
X-Proofpoint-GUID: UtzBRyfBlTt5KJQMuTQKeT6rBqWGTtQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220170

On 7/22/2025 8:03 PM, Konrad Dybcio wrote:
> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>> Bitfield definition for REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS register is
>> different in A7XX family. Check the correct bits to see if GX is
>> collapsed on A7XX series.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> This seems to have been introduced all the way back in the initial
> a7xx submission downstream, so I'll assume this concerns all SKUs
> and this is a relevant fixes tag:
> 
> Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Dmitry/Konrad,

We don't have to backport this change because the existing code reads a
couple of unused bits which are '0's and that is okay when IFPC is not
supported. So there is no practical benefit in cherry-picking this
change to older kernel versions.

-Akhil.

> 
> Konrad


