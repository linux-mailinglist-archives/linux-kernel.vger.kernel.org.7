Return-Path: <linux-kernel+bounces-796581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E1B402C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36530189F9A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D53043BA;
	Tue,  2 Sep 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3U9eeT5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696233019C5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819315; cv=none; b=QGgsoFzf8CsyTMZJwcztskTjNbYLZl4dbKOhjPXlrx7Gttsy4ybA0Vukky5lao3/W54/q9uSOlkRIDZydYL7BhGv29D22MBed/VKpRAHuAeFBKgUm1vmR/AEUvHPFXmlImHuSqhXqUPXT6IPSoVy4aebGduXqHFacEwrvh8YezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819315; c=relaxed/simple;
	bh=CWiUnmAw+vPsRhD1SkHyKDhqzUdNzR/yf9yGGUVjYHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hfb3SyRR4oKdBh/D7wPma4BtQio8eVzCJuwxSmPnhNsUpDMo56eR1qQSNs/olkphTWsmpO9SpQcMHmhXHbpILKOEryFgCMFVEICHp90XrDLgnyoQvO92d8KQIchD89QWdD9E5+osXRFJ1yloNNzN8xISmux6jyEw5OPqLP8YCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3U9eeT5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Al7tK025161
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 13:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JaC59KBlwwCcOLBxHtuji6zgMyRa9S7aKGEwvTUep20=; b=I3U9eeT5pnO4RJAg
	owJhVON8S/oZBIKm6nhzL1ZvqAWe5rQvOUY89w70y679wfzHeOg8OuSz4aXNokMI
	lA9NsVKj1PSM2bIiNQAics2u4s6NdTKUcXU0EgbeRwAq9LfpI2F/vdgHNubsirq3
	sEf1tqYfIIM9GnqxoNULC6ksTxsaXc1gmH+a1OjO40JwbcN0VakdTrM3WTpoqB9A
	MCGkNFSKZN3S0n9I1Xs5CJ1+GblJMn8Eg7objwj7zhl28mtKONd7SCNQJkPuQvz7
	rwz9TmesLzyO88D/AmiJ7sZ45EOTO1zMtNpLjXwU4E6ycwAcdd6FL1KLEnCQJ5WO
	r6jg6A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuyxkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:21:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4e1675ba95so2701453a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819312; x=1757424112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaC59KBlwwCcOLBxHtuji6zgMyRa9S7aKGEwvTUep20=;
        b=bSgV/VxD1rLc87Pw+bxlzHlWQHkzvrwMPtap1/85JDNYdWMtNVemo3Iziz3PA5AKX6
         rxwZgqf2YtuF06cjDjCtdFeVSvGWt9rw79CkDLpKytxUNOaATE6OmgqDmjc3GO247kHC
         oJWUvL8nzg7qKeMJ8lPRAKX/jiNPOd0iQrODxx06JDhSwUbBQrf0caUCdX4hXQ+RxCM7
         Gh/06gzBEAmJsBCw8nn6muHXvEYIxO0dOUBFrzl4lZFYC2ye3Q5PpMG31t5S7C1uPqWA
         Lw2oHbaRUlQPdhm9rcK3pfelRt90cyjl5YyB73HyvvWGZhm49mGN8yzrneN0O6RDbK5W
         Sflg==
X-Forwarded-Encrypted: i=1; AJvYcCXAn5dGgcR6kKTmTjPV8R6M0JC/0P7hZVwgqCZgRO7BN3pdRi/H+f/FwzoTt7v6Wrk9LP96Lp7Y8gWSnMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuns07yspv3vNTVpzIfxtfj6AlEOVBn2LOk8f78BejVX1OFzSz
	0X150KOm4Y4VBif5OoXnTndqv0u6xvJ1UY7O4ZlSU2nxy1zJ7fVebdA36GcKUM4B9jaCAHDqlkV
	aEARU0OuGgV4deCKE3GMhnWuFQKh9Y3XnNlCjS/o+0VwzzilUHlgwjUmBJq3z/M11RTY=
X-Gm-Gg: ASbGnctGf1mtSJ/u7XYx+wLr5easCmZZBEIwR7Q4eqnbn8fFmJbMrcddU2t31FN6ytI
	8S0U9PZZe1+MgiZEMSAmWA//NgwPXohLUXt1+VheWnkpUB18OgAv/jDKy/SKV4FvzdPvZvf7IjC
	3Mz3Wtqr3DQ2A6L4KNKIJ+It+rhg5E5kodeyMvyXOCyfR+KjLcQesXTK/rcIK2SCKoCaFAsXn9i
	VynL6TiZ+GplFndZ+FnPkHskCdQH1zbKkRxrNqIdnAaCBePUHn8Xad0T1Tj6+jy6ntKQVAGxHLH
	cLfeBzIUn/QywilQoIo49BlpVAHIAhuogqzXP1NrT4JqVgF/BmBb8yuTkGnMxg==
X-Received: by 2002:a05:6a20:9145:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-24603a66346mr664689637.12.1756819311968;
        Tue, 02 Sep 2025 06:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtkIfOFvD0HUzJY6Lkpwe4Ds7LLmmdnhloqIvQ0PtyT9neILbf8iU/dMY87XxE3U3HYu3y8w==
X-Received: by 2002:a05:6a20:9145:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-24603a66346mr664480637.12.1756819309536;
        Tue, 02 Sep 2025 06:21:49 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm143396b3a.9.2025.09.02.06.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:21:49 -0700 (PDT)
Message-ID: <72cc7f71-fe49-411f-9a7e-71c4f51c283f@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 18:51:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/msm/a6xx: Fix GMU firmware parser
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-2-f3ec9baed513@oss.qualcomm.com>
 <9df42327-b417-454d-9f4a-608979498f79@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9df42327-b417-454d-9f4a-608979498f79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX9VPTbe2peBoP
 J7mFHgQv8Lr2INDCtPdnzchvXJHxf7iea1T2A7S7yIx4vourKrDYPb57t7QHCuF55gC57E3rw8z
 eRagzkxhDON+qtm9Q/RhYOXWlnTsHEZaXqnMjXWUcwFSG74BOvTJ65xUmM+HugHljIACGiPT/7D
 QcXDeuMpqAlYEbiNBSv/fdliImPZlnmLtKCH4pnEfW0GDbKgEZhyCZTHzLx9vgzYCywRIWQ6Qqk
 5KEClAb9THK1NxJBhVz9vK+wDTDgJIk1ljB5yzLrEm+dbSedEiRk3+ruucqdlkhOV9Tw/Kc9+3e
 Lutp6VQZXneK6dxP+IdoCqrxvHD6nfjVg8dI8gR04JaN2dD1K3dxM2nb8rFjK3ipQGdJoLDbdmb
 hXGZ2qxs
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6ef71 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=L25_lxYj0dBuOpUmPZMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 1QBFHI0opSOIub1GiVCUfQZM7CqWG3AS
X-Proofpoint-GUID: 1QBFHI0opSOIub1GiVCUfQZM7CqWG3AS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/2/2025 5:59 PM, Konrad Dybcio wrote:
> On 9/2/25 1:50 PM, Akhil P Oommen wrote:
>> Current parser logic for GMU firmware assumes a dword aligned payload
>> size for every block. This is not true for all GMU firmwares. So, fix
>> this by using correct 'size' value in the calculation for the offset
>> for the next block's header.
> 
> Hm, I haven't seen this in the wild - do you have any specific examples?

I saw this in an unreleased chipset's fw. But felt it might show up in
newer gmu fw versions of older chipsets too.

> 
>>
>> Fixes: c6ed04f856a4 ("drm/msm/a6xx: A640/A650 GMU firmware path")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 28e6705c6da682c7b41c748e375dda59a6551898..ea52374c9fcd481d816ed9608e9f6eb1c2e3005a 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -758,6 +758,8 @@ static bool fw_block_mem(struct a6xx_gmu_bo *bo, const struct block_header *blk)
>>  	return true;
>>  }
>>  
>> +#define NEXT_BLK(blk) ((const struct block_header *)((const char *)blk + sizeof(*blk) + blk->size))
> 
> CHECK: Macro argument 'blk' may be better as '(blk)' to avoid precedence issues
> #146: FILE: drivers/gpu/drm/msm/adreno/a6xx_gmu.c:761:
> +#define NEXT_BLK(blk) ((const struct block_header *)((const char *)blk + sizeof(*blk) + blk->size))

Ack. Thanks.

-Akhil.

> 
> Konrad



