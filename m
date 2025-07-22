Return-Path: <linux-kernel+bounces-741457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965CDB0E460
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8132D1C27E33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303E285041;
	Tue, 22 Jul 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hCA7xZXi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6C27CB04
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213676; cv=none; b=pjjI3pNIuDJU3P6cJuxhfjo6fvjRROUxoDi7c1bflKybgoUtxqh6tWwrTbz1wAZLJ8pIvpfX0+/0xA++lYM2wouk3IlAjHyhuHt504zdEpevdp5jBf+Xu9Iv7pHmuQ1gNHwk6J3fb1KfQWn8qjmTLUa88oDoZ5o9GwABgMnFQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213676; c=relaxed/simple;
	bh=j8inDgZHgccbVD3/RyKwPXu6rETxgroGBtjf5kU4EOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUlko0S768JsbqmNyMZ9oJf/fKdxYjPq7zANBgp5WaZwV/p0IysSt5qBu54qedfYuz294M5l5Zo9h/boR87cE+EBtpKGbzmy7FUsdMOqxGBd0DBnmSEJc3eK6EoHbzA+Le4wSfdEmUfUriOfd8CMuiUgunAuyD0BrBSiUritbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hCA7xZXi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFn9u9010525
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EEzrFntqUpXwmzhEbd6zxsSsOyDtSlkzdmerHqu6YxE=; b=hCA7xZXiYFhwYDKW
	tpltNKSTlmbynKdXCm9Cms+9Wvjo3RSWdQb87B5oNmAVIdJa2k2TPl86UQyhNww7
	JKu66usKv+bpAcrQOi4rhN1xGsnNNV2YGg6PB5/kcs6dMEts5f5WUGIahGWD5b9h
	n9GGNqUT3L4O7wqXQuVszdzA8KwrnGsnNEf3tT5raA0oGqN892TwGQ6mNCD5MzwJ
	4egw2x2BrDZLxomnpL/rxrkjeiAOjn/c59mBVjc688algM4UcKsOiBlzeYyUDPIU
	2dZ9CQfKc60eMSrRxeQ5eCUbeSXe2H9G9GllYR7Yf9P0DVFbYC0U9wQYWCRStsnQ
	Cn57vg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1a25d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:47:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so4058390a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213671; x=1753818471;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEzrFntqUpXwmzhEbd6zxsSsOyDtSlkzdmerHqu6YxE=;
        b=Yl/VaFUUJFpBYUHOmRhxQes/UD2n9zGTGDipdzFgOC3mMgNrmWc/54pogAOIAbV02Z
         s7c135MC0n0d3xHCuOFSa9WPY+ZzLuivpNT/Wm+KpiEEnru6NZjDONi3L0cP8bP+2YEI
         jog3k9SjqvTlbLX72OS/e133u9geWx4TnvJG7+3NVIAKP/0KHOXhWI/je7LQTkUYUMw1
         aOLQ8zRKbjhvTZMTXyg245g/WrT1AePXOQTcgEFetXZSv/4TAgMtElPrBYE8cN/q+36h
         bjE1GaIUHYUOXJLyJFh3HijEcVI4CK20pRVXYJ6LDB1uSIDxjItvpUNPMkZUpDvenweO
         6FPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw+Ji8TRuYpzwsHB8yyYBnQsbfPlY9GALKRkiKJoA+xSP9tuRTsxC8qvX8kEbqViXUzmt/6ObuaorYvxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6IweIYImXjb7e4WGasyzEuFwZx/3tCAOe1w9GCEmQHk1Byx0S
	N6fzsVfH29c5Ji1J6UgePTRibP2UlxiUVejt08ZXERaa37XtgBy1Uzayw3L97VA85TrUAju4c/o
	9DNrqrShR4sR6rNp4GYphUbpO/18ZwiJ0zNUFoi96eHr7RaLitNicrHYfnN8KtYpLmkY=
X-Gm-Gg: ASbGncvD3M72UFq/j+zPzKxjfVN9CvKGAb0xXpOC4sTNmIuMK+VBpGp4tjcGdAhakIK
	+aLDJZXEw2gZaIaPhwmxFJKoZSJdRHhk6VgMtNYvJc6DCp8pCBBSwFCKsDDYQPIfQXBQY/FIzCk
	Eu8iE6ySfy0OiANPmFhL7qTUahA2uC+WWXh+GqFdTmMdEDZ2pnvozmCh9s4smlrJYxObg1u4qvk
	Kl1Bo3bBZxAYScOKwUEXHrDcg7/EExBxVDLDsedCt/IPP5AtBkJPiSoiXIF+XaUuAG99ZXhUtXf
	O2xdlmHz2Ny/cE0uD8SUs3j7kM70nq8JvK/nXEMubvNCf2jZsIo1xD3ESeretbGF
X-Received: by 2002:a17:902:ce8e:b0:23e:3164:2bef with SMTP id d9443c01a7336-23f98172240mr3021185ad.13.1753213671269;
        Tue, 22 Jul 2025 12:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU1qOtwmPdcPsJGIhheRiktlJaDiPc1l+Av8pvaEKyMToOna2BedvGFYD8Q4SL4rfvukJv/Q==
X-Received: by 2002:a17:902:ce8e:b0:23e:3164:2bef with SMTP id d9443c01a7336-23f98172240mr3020925ad.13.1753213670851;
        Tue, 22 Jul 2025 12:47:50 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfbaesm82160665ad.151.2025.07.22.12.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:47:50 -0700 (PDT)
Message-ID: <4832a160-344a-4140-a115-d4742f95825b@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 01:17:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/msm: a6xx: Refactor a6xx_sptprac_enable()
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
 <20250720-ifpc-support-v1-2-9347aa5bcbd6@oss.qualcomm.com>
 <d4b46652-c4d0-44b4-aef5-e8bcf606de06@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d4b46652-c4d0-44b4-aef5-e8bcf606de06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sJlWJITCCYajBsETpVSINC5xyXDkiStW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3MCBTYWx0ZWRfX2QFdfFdC+V43
 T7rAOAxq3aPANNwOy+RCWiv+Jq/3NPfg52LcHkBI7Lt8ByZ9oG0RoHuqn//HHKB+HhTIccQBca0
 VHHxXiUrAzE8NgNHesmmcAoOl+G0pWLPPvaM/Pe/4Kou+WFjWvCgQYrrlNqFNBfpboby9ppLWMV
 IPM5Xf870Mc8Q+LvWbXGjfkcCwDBh//22dFUkA0PRJqkWc0DgyL3q/J9WTosP4YMTENkg9+JY9B
 Bqb7f3CnLPb/epWmUESz4klZN1lzVI9W06XgxbNMdIEticv5IkLzDJZgP8hFvfxyjp7lop8pxXi
 KYnj3UhaJRY5BaUzB7Ms6wQvnr4BixVQRmWurKuoo/ahoU0sROsdvuF14r9J+OmBFufWCWqWn8Q
 U5cG47VLCBT8XPrkhvDEyIUfAixgVCyiicZIooBJaUAMD3I5QADOvQMYGopajLa/VnJPQx3s
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687feae8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=1Zk-24FEoXaHOanE9kEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: sJlWJITCCYajBsETpVSINC5xyXDkiStW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=945 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220170

On 7/22/2025 8:00 PM, Konrad Dybcio wrote:
> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>> A minor refactor to combine the subroutines for legacy a6xx GMUs under
>> a single check. This helps to avoid an unnecessary check and return
>> early from the subroutine for majority of a6xx gpus.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 38c0f8ef85c3d260864541d83abe43e49c772c52..41129692d127b70e9293b82bea5ccb6b911b0bfb 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -403,7 +403,10 @@ int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
>>  	int ret;
>>  	u32 val;
>>  
>> -	if (!gmu->legacy)
>> +	WARN_ON(!gmu->legacy);
>> +
>> +	/* Nothing to do if GMU does the power management */
>> +	if (gmu->idle_level > GMU_IDLE_STATE_ACTIVE)
> 
> This isn't quite a no-op, but I can't seem to find what the '1' value
> would map to, even in 845 kernel sources. Do we have to worry about it?

This is fine. '1' seems to be a low power state that was removed very
early in the gmu firmware development stage. We can ignore that.

-Akhil.

> 
> Konrad


