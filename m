Return-Path: <linux-kernel+bounces-892240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B8DC44B00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC19188A002
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948C1EF09B;
	Mon, 10 Nov 2025 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWIZe86X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8IjDzL5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67834C81
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736325; cv=none; b=QEdl+l03rVWPmj9qva4hWoKq9JoDANXVGqjbqxz1ACVuJD3v+0zHha6Oroo7H7p6M287X10KZDfenSjQZCwuBOVVd1SHFEu3Kf+/cdOVA/pGYBVWOs9a1wlA+hA0WBstGGLSWlKjANNj4tWIb7+Uq6tfeDSZ/jaSLDOwHeEUKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736325; c=relaxed/simple;
	bh=165CLhCyIWYcyb+c8kVnCApzW6hkDAn2sLovFE/DI6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPwvbJZz2uN9chDmBHe6k1ZRM5KztXZUrr+u+GNkbDTRYmXDhFNNPUjwEL23yR/u/W+j9+wyC+GqJOksMJvUkjVgyyZRWskjl4Lgdh9B8wxItzhd34NuudkQsmYZIZBtuS4x7WCmomOGvjgniQpybpdoX8/lSrot2Mymz56MyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWIZe86X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8IjDzL5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9HSx5E833230
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bgtvgusnj8UUTeQJ6anDano2DXvOPmsvcBv42wqV/0U=; b=lWIZe86XoE9+ttao
	8OL5xlLofNJbOsk89bMtkqYSurqb6gsvnGghMEpOJUqwfG/sCnoTrCLdLEKuK/4j
	SeB8EkMkW5ed55kD+phE/+UtH2OgnUtelmkCZS6C0L5wJFee70paJ9/N5PuKXPg3
	q0L8j6HCkKyu7X+W/sS2UPro0S76y1lr8cmpCyNN00umcyr9MA6hNp11H0jsGStM
	c3nqVzeskoHq3K5PO4MGoSeAjel7Z5doj5/wwMmCtnyKtAIsiVKidsqTx471b/Hj
	G1gIjDDJmRy5G0/jNnUoGNFmdb2c7yuAHVXN9XM8syRDrlgFkrYQoxHnzzXJXVt3
	7JHl4A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y1h2wf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:58:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so4811483b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762736322; x=1763341122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bgtvgusnj8UUTeQJ6anDano2DXvOPmsvcBv42wqV/0U=;
        b=d8IjDzL5Jb3U0s23GMR6yRUIgBDVVy9Wrm6PPGShViLGja/p5SBEmDDRNcK3itFTT3
         AsurHCNSMc6DNAmUgkEv8qKSNU+QPfcd44qIqMafe21uZnSpfkxLpBFRsZHjo69StuVV
         DB7h4beZxuQ3QBEavIIzkTFPmTdAHqG+2ccfl7KS+B+tFNN2RxrH/NV/vsn/ZQDENYt9
         GT2DkL0aaXvNGwTUtOGrjTKKecql3DTCUn++PyYw9KRTAIS9NqxZ6DPEYmyn4doteCoY
         wHopdd4M33PWC0GAjD4WRTnE2kDwnQCYR0G7yc/EC2dIgHnbMHXDfALOgw6d0Do0b5xr
         BX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736322; x=1763341122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgtvgusnj8UUTeQJ6anDano2DXvOPmsvcBv42wqV/0U=;
        b=R1BmqvtdjQAXZ+acPo5pqmGQ+XVw/TwJWtyLhEqBM+tMl2cnX2F2SfQEyEQ7OcvYdw
         zl/nbDxNKFHzN97lFbf8/rmq9C21qOnK8DkR9kctxXEnnFidZymkXTuCcO69hd/4YmQu
         Da3cBfrOIZln/heH63e/yL590dJ4nZ0TmoIC6FqW/mGieBjTIiftTLJHSaenaXIiT27t
         PfmptG6LqJ8B696AK9c8l6Y/x2lEoLV3O667JSJHZejmTGfvtHR9tT4zWwIbUMVxG/bO
         DJHxo6XbUAlYcKTb+2fLj5Vpt0X2kBtIPKTjjHR+XVonDTRftllPp8mkfHr8UZqmDdh1
         eaFw==
X-Forwarded-Encrypted: i=1; AJvYcCWuOpeDvsYqPYWXqtRg7VVKFPyWEUob8WI2i3cx907WvRhGNT9Ti1Kgt4GlhKsyo1otAZOc75c1qI/D3Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdH9tZyaV5jsq6nhpvF2MG/qOv/wVK9axJZJR3IDDVy90ebxA
	cogugIAwM5gttoze1GMHovoeGmYZ7TyRGlSwIKxzD2vbG4rsC/urxsvQCMljkm3kbN0s0k8kvYg
	qPDhr1xPkD8eCo8dizsh/D9qt4RUVGIPo/x/h4aPoXe57FQ4Dz0964PhqliYdgGoHC+3UlHZ2Em
	zv5A==
X-Gm-Gg: ASbGncs/ssFtSvCVZ+HITR+AvhPYdr44SswTXKY5cjNOhiFR9BUyYuEcvIEBUbK1uAp
	J8rftFhRCFkPyAEa2z0pAOkrGpKzf9UhORhIKPPRmXsFvjAdtJN8XVanjqhzjiFLIiBUPDgVqnr
	lJ0rowhmCHCkI7U5YnBNyvNihtVhEsv5H0bpAvShB+ScK3yc06yKrtkGXPOa+kvf6vxR6qPg/7J
	ZtMakourOsuoYMwqv3umYZFOIfbWroPdEx9lV8veRoSrLi0YTfZJ49gWgeRW3ctwO+GogMwU5pP
	yBfimGtQdriPe5s/hWw9dYqeEGElPd1W5i4gA9enOoDGv+SnSFljvF2LlAS5oXn1LUjMgOPKmrp
	Oq7m4eJPoPy/XQok+l7gMecQrisjexusiNEt3x0VHIa+7akh7QNqktNqTYt2dHr+W
X-Received: by 2002:a05:6a20:94ca:b0:350:ee00:3c9f with SMTP id adf61e73a8af0-353a24f7cbcmr8603876637.48.1762736321961;
        Sun, 09 Nov 2025 16:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7AydeZT0JrhGShBhEOyz5MmnUHTKAZe9+iQAWVuH/FVpxNFi/omwHJ7lFM405ObY1Y85Fiw==
X-Received: by 2002:a05:6a20:94ca:b0:350:ee00:3c9f with SMTP id adf61e73a8af0-353a24f7cbcmr8603858637.48.1762736321467;
        Sun, 09 Nov 2025 16:58:41 -0800 (PST)
Received: from [10.133.33.229] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207232sm10576120a12.32.2025.11.09.16.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 16:58:40 -0800 (PST)
Message-ID: <22de0bad-4947-4446-b610-b4d8d0320858@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 08:58:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] coresight: replace the void pointer with
 coresight_path pointer
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Carl Worth <carl@os.amperecomputing.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
References: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bABftv2WwhOHlbEp45-Nafzc5XI-yYJz
X-Proofpoint-GUID: bABftv2WwhOHlbEp45-Nafzc5XI-yYJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAwNSBTYWx0ZWRfXw/FDOA8lUkUH
 AGIbg1Lbi/MooLZ8mwYxA3q5efV33Yve9G84RmMEIpb9MoVjL0eDsYPwsAxsyem/BZI8Iw49kLs
 p9IagtuyRs7uDqttHztyeJjMe72WAXFyDOeQA13jSwY6POC8xWwF+p4XmdBWMwEndnzuoIZmAmV
 cS5hjdiBMmJYkuDyPlSFj1Fw1JuGBTIKOZ1MNGMLuijPx2SV9cH3D+PyW9OwPB7xh1r+M+/xStI
 KidTXkvrdhrdngR3Vb6LCfNixW8+wU6wnQyITsMRhBcB9l+yRUeXt/RC2iMvXdwDPB5koNkM9zR
 TKtUGyymmTIsklOscW0YY4T2fWgfn0GgWi1HkSMrCgNdTRkAJZ332LWvl/VNLQllUi7yfQkdH48
 1Oa9IFMYfCDLbB9JWFQ7GkNSaSSF5g==
X-Authority-Analysis: v=2.4 cv=Xuj3+FF9 c=1 sm=1 tr=0 ts=691138c2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vzhER2c_AAAA:8
 a=rsf6x_vkuY_n4m1xo70A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_10,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100005



On 9/25/2025 6:42 PM, Jie Gan wrote:
> Patch 1:
> Fix the issue that the catu cannot correctly read the handle of the AUX
> event which is caused by the commit[1].
> 
> [1] 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
> 


Gentle reminder.


> Exeception call trace:
>       tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
>       catu_enable_hw+0xbc/0x3d0 [coresight_catu]
>       catu_enable+0x70/0xe0 [coresight_catu]
>       coresight_enable_path+0xb0/0x258 [coresight]
> 
> Patch 2 - 3:
> Change the sink_enable and help_enable/disable to accept coresight_path.
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fix error comment in coresight_path
> - Collect tags
> - Link to RFC: https://lore.kernel.org/r/20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com
> 
> Versions have submitted by Carl Worth:
> V2 - https://lore.kernel.org/all/20250919174932.3490404-1-carl@os.amperecomputing.com/
> V1 - https://lore.kernel.org/all/20250916224441.3008824-1-carl@os.amperecomputing.com/
> 
> ---
> Carl Worth (1):
>        coresight: tmc: add the handle of the event to the path
> 
> Jie Gan (2):
>        coresight: change helper_ops to accept coresight_path
>        coresight: change the sink_ops to accept coresight_path
> 
>   drivers/hwtracing/coresight/coresight-catu.c      | 10 ++++----
>   drivers/hwtracing/coresight/coresight-core.c      | 30 +++++++++++++----------
>   drivers/hwtracing/coresight/coresight-ctcu-core.c |  9 +++----
>   drivers/hwtracing/coresight/coresight-cti-core.c  |  5 ++--
>   drivers/hwtracing/coresight/coresight-cti.h       |  5 ++--
>   drivers/hwtracing/coresight/coresight-dummy.c     |  2 +-
>   drivers/hwtracing/coresight/coresight-etb10.c     |  8 +++---
>   drivers/hwtracing/coresight/coresight-etm-perf.c  |  3 ++-
>   drivers/hwtracing/coresight/coresight-priv.h      |  3 +--
>   drivers/hwtracing/coresight/coresight-sysfs.c     |  2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etf.c   | 10 +++++---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c   | 15 +++++++-----
>   drivers/hwtracing/coresight/coresight-tmc.h       |  3 ++-
>   drivers/hwtracing/coresight/coresight-tpiu.c      |  2 +-
>   drivers/hwtracing/coresight/coresight-trbe.c      |  4 +--
>   drivers/hwtracing/coresight/ultrasoc-smb.c        |  9 ++++---
>   include/linux/coresight.h                         | 17 +++++++------
>   17 files changed, 75 insertions(+), 62 deletions(-)
> ---
> base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
> change-id: 20250922-fix_helper_data-f56018fc966f
> 
> Best regards,


