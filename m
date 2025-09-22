Return-Path: <linux-kernel+bounces-827346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E868B917FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FE2A5889
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8D830C0FB;
	Mon, 22 Sep 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="To0MYj2a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371373093B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548721; cv=none; b=GSKuuJvL3lOqXph90haNE23nwgVMlkV+enCyc0cGK1+5TvFBpvCD800HiMnAMhF3H7gIdpTdUt5sU3g9hVgGV26iDiD9poI4VXIAob9W0y+uqTOUxcTGc7oAa+GyKgf3UlKLedzjaSefeW7bMKA/3SfyhzCwaigOPqNvFRE+60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548721; c=relaxed/simple;
	bh=uG75ywJ/N/C4VTC9ezp6AkudmGNPmDTqgRJVwd5unM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d17eRHLCM6i+Nig92HS4NAMf4tqL9Gys+ArX7sIQsxwxRr69Qm39sDnRdv4+EdUJwv5k+vabtJz1dVo+l/tkBKFqcpERgly7+xOfnsDvtmNg/TzpNuNi2u59Dz3+Ag0CbuS0SLO6P2kUuO68WKS6oL7muIY/ATDKSlOWph0GSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=To0MYj2a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M90fK8009360
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+GScQufAFT4/Jq3nDg5dsFylkF0kL3QXfWaxbdntkyU=; b=To0MYj2aNo8/9OTq
	e/rYP2cpxQIdJji9OOfwR9fV2WJBnUymGCrJW1V8SpZ0iBpVeFa6aJNau0zvFFB5
	wZl+ia0jCIQLvsCr0GkG0o7Of0HMpawOiwGHM4mJqmk2QDjEUxkAD9ZXqe+6IZm4
	06ITFC8/eUh8/GBgmNkFmCgy6a0q+EctabQ/r5fsCproGVzqF4uGOrTf67/7mbTo
	dbwRd6EXMQYlH+yqOrJN8XEt9hjA4jI+iDGWkRhUSDug818EqHikyOU8QsIvt3cJ
	qPFQK/dm/6Pg3zPKIoYB+F30z1WAkyT+EOh8+uCQje6BGgzCxEucJffJotN6Pyee
	mp/E2A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnn6ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:45:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5515a1f5b8so2653309a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548718; x=1759153518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GScQufAFT4/Jq3nDg5dsFylkF0kL3QXfWaxbdntkyU=;
        b=FntabuCS63ZV9vWS9Gp/LMdIDovmWvPMj6uZpRHdEjKIBn+oa3wU5Wbr2pX4JpF2Y/
         YXx6mXe5R9pckJw26aLKNaPY7/3kP8pn3OrjeZua90vBEfGMkjspQ7Z50wPS6eOS6MgG
         L8YrZl1URreheJU+bW+vWg4T1Ooz6ECYtypy7b4tql5Y/nH1VPodp29RVu87G5Vhnb16
         2Rnd/pLyJ8pG+aE7sLgnNT+n9jLSALe1a8Q+gfgeuB0vhn92UydO376HdeUaXO9doqTS
         gZfQaW2Q+HpX4d+/W8ehTnZNdcghge9t4i1jOF0Fs/WgBmD52Nrbd8xan9oF6Hu35mH1
         J/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaNnDlYQBK7fE2cxAIQW9aergoLZbLa2pyujpwbtotuA1t2cTkDHosEWhmwPAWW0gstzkU+0BleTn/0eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJugWzOnr5En0yapPCk3lpHSXg0IpMjVtz1O2ubk0KIAcMB/H
	b0nskxwdiIP2dB6OyNNiVnC1bsNm4mFrPINQuAZkj9/SQFLn6yPErDC3jjLkB1UuCbdyxI5rWFS
	2ygIoJlQyCM7tLra24y29QAwXRFdK8ii98hG3ncQY6aVOZDV2q6WqacP583U/5uAGlj8=
X-Gm-Gg: ASbGncuFbwQ/VFD8KJLVzDEGlTIc2DmT4FsVP7FhqdD2T/DsiVfT6n1coxKBsH6JIUh
	45d2rFVsilLnBVdBDNbSXn61YA48my7mo2RBkPMBqE0lBQqOeWhN5BwkL68TbtzDDM3Wh2y6Nf2
	2mBlWblb5GflpI7BZE7Iu5Wf91AQ/0m3JHUkKcN0hOsqND31PEsHFU0mCgmHUEEzl57r9sdx7h7
	3Ucdpp/D5HQ5eXAOusGdsCwCCg6FSKLhglSBeH3izk1mgz03iP0+mvs3488ysVkJXMJ7lJDSF8I
	j7829tySDDvEyoGqwjjeyVWl0E4GzQdlsZmZDiZHim0Xhvbef4VSJvSAmg+3rdl3VWmJRbSgeq1
	mmdcl6WmHiDBF2j8jVv02fuqku0mi2gQ=
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr154128445ad.50.1758548717589;
        Mon, 22 Sep 2025 06:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Bxtg/WM4oSQFnOHm5vgIFDxjSmyxZZcCDz7Kx3f4NlCh9peJ1mVy6ZCZLfMSaGBLSNf2zQ==
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr154128115ad.50.1758548717036;
        Mon, 22 Sep 2025 06:45:17 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df852sm134515585ad.87.2025.09.22.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:45:16 -0700 (PDT)
Message-ID: <1dd930a0-b975-4302-9e1f-f06904d8a25c@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 21:45:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default
 transition latency
To: Shawn Guo <shawnguo2@yeah.net>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250922125929.453444-1-shawnguo2@yeah.net>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20250922125929.453444-1-shawnguo2@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d152ef cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
 a=IMh0YCEmi6Npu7LhsKAA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: EXcLzxJxPV26PcbFC6yqda2MrU7HvL-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX8BHrxfLWGbBX
 KLi46NWIYygc/DMTTWQu2O9JxkHnceMc49yFvWkVtXGh7cyam/01LGNObG3ItqEmxJgcEZhjWPv
 B3LiFKxGp2b8s3U5nfrOPb8mpBR2NkZDJrUcj9tTljgtbKaaMKNQUqmDwMMW1v87WeiALcPz7eO
 U7kidYkh6dMGyTzopReM/YRZmf103dH4VuNzRi7+ow/FQyFiPOdK2wgtYKa2HYtkycvIb8H+ChI
 MJn8Pb5XA6a/fV3JeUHvQ5TpqFw/L/XWwuOPffUEPOgCkvrWf2Rf1Ln52NSQE8+hS6inuz0ony9
 k6OW9bmJGfcg6625Zf89HK/8lGUPLBKQFkKzAWnZclet11zaM/4BlgfXAS5pdUGTDuU0dM+t2Pt
 bqXX+DdX
X-Proofpoint-GUID: EXcLzxJxPV26PcbFC6yqda2MrU7HvL-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On 9/22/2025 8:59 PM, Shawn Guo wrote:
> From: Shawn Guo <shawnguo@kernel.org>
> 
> A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> due to that platform's DT doesn't provide the optional property
> 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> platforms, because the default transition delay was dropped by the commits
> below.
> 
>    commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
>    commit a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
Hello Shawn,

Reported by checkpatch.pl:
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
description?)
#12:
   commit a755d0e2d41b ("cpufreq: Honour transition_latency over
transition_delay_us")


>    commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")
> 
> It slows down dbs governor's reacting to CPU loading change
> dramatically.  Also, as transition_delay_us is used by schedutil governor
> as rate_limit_us, it shows a negative impact on device idle power
> consumption, because the device gets slightly less time in the lowest OPP.
> 
> Fix the regressions by defining a default transition latency for
> handling the case of CPUFREQ_ETERNAL.
> 
> Cc: stable@vger.kernel.org
> Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Changes for v2:
> - Follow Rafael's suggestion to define a default transition latency for
>    handling CPUFREQ_ETERNAL, and pave the way to get rid of
>    CPUFREQ_ETERNAL completely later.
> 
> v1: https://lkml.org/lkml/2025/9/10/294
> 
>   drivers/cpufreq/cpufreq.c | 3 +++
>   include/linux/cpufreq.h   | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..c69d10f0e8ec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -549,6 +549,9 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>   	if (policy->transition_delay_us)
>   		return policy->transition_delay_us;
>   
> +	if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
> +		policy->cpuinfo.transition_latency = CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;

For the fallback case, May we print a dbg info in dmesg to inform
developers that the device tree is missing the clock-latency-ns
property? (Rafael can help comment~)


> +
>   	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>   	if (latency)
>   		/* Give a 50% breathing room between updates */
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..935e9a660039 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -36,6 +36,8 @@
>   /* Print length for names. Extra 1 space for accommodating '\n' in prints */
>   #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
>   
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
> +

TANSITION --> TRANSITION ?


>   struct cpufreq_governor;
>   
>   enum cpufreq_table_sorting {


-- 
Thx and BRs,
Zhongqiu Han

