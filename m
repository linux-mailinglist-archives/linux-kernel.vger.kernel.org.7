Return-Path: <linux-kernel+bounces-862339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F3BF5083
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A754D18C6189
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379A28469A;
	Tue, 21 Oct 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltFx4HXK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BF28469C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032613; cv=none; b=JyXM16p2GJDyQuZ3teBmjgUA36fAGKNCyAYU6QqKSz2/ebE3OM6utbPnxuL0PgtPIefVshIQv7CCN18dI1VNRgOai4D/oI7mtt5S6pjlRkgMmDRFWCFzaRmQ4Jw/4EW3CTLOUNQ/dYLtCXtMdtc6e5gSsoQhDACT0cJgD51KZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032613; c=relaxed/simple;
	bh=UOGYTjjAne7jp0gN/Bh1ycgyr9fzZfnapktjDlzWN/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgkVf33CQT27xWSk5WNdrMlCmAv/MwumgRDTLPLufW4YFlm1mq3pAG77rDh18dfY92BG25LcXLs5gSSyKVn7B47D2/0a4QYuWLOzz0yli6TEyfKXZpf9qIMPubXfYFn/Sh6zfye5vh7zLgh/Mexz8B1SI3J6ZUcJuOoASvEfrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltFx4HXK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0xXv000966
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVfeUMgTBM3CAu9I82wxAPql1NahbWchYps+Z870ydE=; b=ltFx4HXK32YtKoIG
	dPPJ9j7qTS0KRq3oSn2CdYQKPnBKxUBOSpJ7njjqExchM/8QdicODlI792/0LJ+u
	VmpAcfhLl9ImsFVWfasGE+J0gzc27btfvV9KwHaYCElLDnrKAk6pgtKX/jcuHbDq
	3RSSYFCxQdbNyXx1ebQagbNg9M9AK3sAz2l3PETm+EeKdT6usvzNvS8rzkx70ci6
	FwKKYrlnbs6t7UNMJFUFs2p1NG7qox8DosubMukxiGieecsVI13SY06/GRs84KP7
	q+O30KYg/Yn+Rxxe/EGmmPOy+tI1XcTjGrm9VOnq4w8xFO5vTs0s6Os5BVlWhBUs
	f725Jw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w562j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:43:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6a2409137dso4251700a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032610; x=1761637410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVfeUMgTBM3CAu9I82wxAPql1NahbWchYps+Z870ydE=;
        b=gMBKaSDOhtIILs4Nt8gLy2kdjup0t8ligFNPJ3XtWa92hxi1I761OXettBJqjR2n2y
         X58wHJdNLvY/nTGpnQSq/H/klzfkFrbdE/mHsyPOOk1AvpBY2gmTS9wo8qdBebINmHke
         q6f3GageBSeC8oHzm2HjSXaPb4sL3GpWgMv7miRjTdKgLbebhQBegXe655pSIXkrr8Kt
         InpYyfFzd4A167oLFSmlLt63tJU4AU8hRV8LqjBXyjlth+5l2FwS31Q7nf/2UBmpSO+0
         EpwsSY307AQUaqkqq0he7hViiwbUS0q23kY2hpTkZ/ql8vZyS/YAL3hITKHmVISlJJBC
         zC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUc9OqmlenBbLudNt+L7HK3vWecKefWQmVZ5m/JZaiDjUoT/4jfTOlaWELynZQVJWOlGjnM/1aGfsFRQYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNKICF6LPnHKslcnRhkuvbtpBUExt42jCNVQXwNW8z5RYF5TJ
	BrQz8oD9b6r1f8gABUpcfW3WecDZF4E/jDkqYDyxMYhr4beZwO+0vpx8bDGiCF8JHrtYQe2LKU3
	WlNE+yWkoBEWoiHESKMNULj+Qzb40cmW+xvCtgR+wHTbt8RxKTlyCv2oHUB1HPGBZN4g=
X-Gm-Gg: ASbGnctvK/doElfmLNS3TlwZzhAdnZnkXnZktldknrzKGDsRjbzjlap1LG/mdFyfAti
	uzr3bHa9zeVe47VzT75nruX4NVzImy0FuRlxvH9VjCWkj3l9ytBixAzjIarAboRdRd5nJTt/vow
	uocWI5uGGfDzoYH8DItTSbIprwB850WaPSjf8vPD+hmnJ27R1KemXTHZUnixI9VMsCOmlsR/LRZ
	jbbI+ELTiwhOSDoxwtU+xa+D9n/jlbqwcSfz3w7x+OQRvVXixw6CQzOhfyNCqsg/9PDmXrelR9U
	Y7ZxRpIOglDSiUa52rdYqhH0ODVo89TqEECHZ8y0OvLr4HLPEDqw3+zMsQ/FQYvU/tFzDY/BcLw
	0EEXvdD7DHdniM83cgSHh1bPDOR8S/4huO9ysG3VRv48QbEiNQ0S0si4yfEfn6Lmt
X-Received: by 2002:a17:903:3d0b:b0:24d:1f99:713a with SMTP id d9443c01a7336-290ca30def8mr218012495ad.31.1761032610248;
        Tue, 21 Oct 2025 00:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr8+0hmXEglm2VrONIYQuNr3/IelIpMrr9RaoeoOUTL0/N8ALs8rMkTd/VGSWryNSxw636ig==
X-Received: by 2002:a17:903:3d0b:b0:24d:1f99:713a with SMTP id d9443c01a7336-290ca30def8mr218012235ad.31.1761032609750;
        Tue, 21 Oct 2025 00:43:29 -0700 (PDT)
Received: from [10.133.33.105] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebccf3sm101559935ad.1.2025.10.21.00.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:43:29 -0700 (PDT)
Message-ID: <7d81d7be-0752-4a95-995f-3477fa274466@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 15:43:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: ETR: Fix ETR buffer use-after-free issue
To: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251020-fix_etr_issue-v1-1-902ab51770b4@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251020-fix_etr_issue-v1-1-902ab51770b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZvKPDM2p9CsWm-P3TDzX1FCZQDDzQGhd
X-Proofpoint-GUID: ZvKPDM2p9CsWm-P3TDzX1FCZQDDzQGhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX2bUrB0Q1FBJ3
 ovN0sYgn7/6+gSYXaPy9pp/Aa0s+SaPitROzAA0b05KvURhLkdcxvkT/ZEsymPF7KiiI4voUoIx
 bTd4zkWXU8ivJaZ1/RGHyTQGAegkZOHL7L8MIzROZMf6gGm/kF3CoCh35qA/VDmnZf+jtmGv9HM
 f6AAGF/CMUGqT6C8eeAidQ/6HQuBUP9yBVgxKpzLQNFUZIOfsWBPuimwgBh7ZdSijtOyTmW8vww
 ykot/sYishrA94t7VZaTksKvu2zU7GGQWGKYcMR/Tfd+IiwKWa2MtyPst+wZ/nJ1K+LLblcxPgh
 1cYoFmn1eTQOSbRx632G5fSe+K2WGrW2FOp4yVecC1hvtYsEEoK78MPlSe/3cg3NpWeKzvBGQgM
 FQwVkNR9ahYKbkJDBhrvV7dE0u8DEA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f739a3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=yZ5FxKY4llv7UqssUvUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090



On 10/20/2025 5:06 PM, Xiaoqi Zhuang wrote:
> When ETR is enabled as CS_MODE_SYSFS, if the buffer size is changed
> and enabled again, currently sysfs_buf will point to the newly
> allocated memory(buf_new) and free the old memory(buf_old). But the
> etr_buf that is being used by the ETR remains pointed to buf_old, not
> updated to buf_new. In this case, it will result in a memory
> use-after-free issue.
> 
> Fix this by checking ETR's mode before updating and releasing buf_old,
> if the mode is CS_MODE_SYSFS, then skip updating and releasing it.
> 

missed fix tag:
Fixes: de5461970b3e ("coresight: tmc: allocating memory when needed")

Thanks,
Jie

> Signed-off-by: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index b07fcdb3fe1a..3e73cf2c38a3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1268,6 +1268,13 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Since this sink is already enabled, the existing buffer should not
> +	 * be released even if the buffer size has changed.
> +	 */
> +	if (coresight_get_mode(csdev) == CS_MODE_SYSFS)
> +		goto out;
> +
>   	/*
>   	 * If we don't have a buffer or it doesn't match the requested size,
>   	 * use the buffer allocated above. Otherwise reuse the existing buffer.
> 
> ---
> base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
> change-id: 20251020-fix_etr_issue-02c706dbc899
> 
> Best regards,


