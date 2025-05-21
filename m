Return-Path: <linux-kernel+bounces-658042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3DABFBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 19:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268F7A20437
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D4262FF5;
	Wed, 21 May 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VcafkNJn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5B25D548
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846873; cv=none; b=QvjzuodOFFWh5dMhBHEwYXrqO5UqVHesz3fwFl2ryIy+W22/RFH6T7eddhIt0nTN5ssnSqnp+gDJXR4dnIEIpjJfbeUvG6qkZKQEBoZpQ3ttpsnvdLQzFmv57+FQVNTODLHFehx0Nk+cl6dWr/xKgM5uzg3A8P+9unTiiNVttNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846873; c=relaxed/simple;
	bh=W2xFQ+2/E/Rk+8ShlLetpjcpac5haLT7J5spEwuRII0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZCxGF843skXtBV1sCoownDuuCfw4iieABIzwGqW6mxSe5zFcsGmKo7gUJeQs7w96pxJJXPeidsQQqcjKui85W4wXWzbB74cy+9bbsWAzUjbhJ47dDRPEY3CVEs77ZWwhf8IHc60723bvg1yXCpXHMmXVNF8CakgvQQ39ebbXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VcafkNJn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XNRs027639
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 17:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9XUDoddwcOnxMajTIY/aI4OKKGbnFz3720ytXGqLnk=; b=VcafkNJnIJdLeHra
	mA/ut3LSw+pWUfJEbhgJxz3wzhfyT8Z/wZSSgScYVmBxkqo2RrvomknvlR73bW3J
	edmJcwK//rVNKYBD6oxM8lGHy1w+vaaRhDH+au9aSt2apXz59GkU9/4gDd5CqbtC
	Yf0VxKfk1AkkmH++hF6E65AZREcXyYOGLoCXSwRhrsEWUWXV0FVV1CZiM0xMwcrS
	+nDAcCE1FqCYb2QMVvuK4THDEKcmVneM2Z54TrovsspgtPVkHIZP3kMom/UDn9if
	JFtm0kUBWQP7bAW/1yAS4rpC1m/Ax2FSJhsIPbCfk9VJc/PsHFM0N2uo2Mr3RiNI
	MnfKTA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9bmgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 17:01:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c552802e9fso176713985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 10:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846869; x=1748451669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9XUDoddwcOnxMajTIY/aI4OKKGbnFz3720ytXGqLnk=;
        b=enKXrjhQrvJspc24X9HeEPd5wjm6cgjtROG+oBsspQIN9LrNsX1eJYoQu5rypPRFZv
         0INAk/RaOQw5Ysl9KQm6R1rnU1HIzyrMFN3Ym7nRIvtyJQuCADjP+fxr5JyInK+6OVRz
         Al9fGj88/Mx0V4gOvyBGGqz4CQXwV4/u9OceGpsCX1wPR5H14PgWDIqB1JNoZPm7DzgS
         iZWByCCpb3Rigk50hBuhXZaohqNW/pUPw7IlBp7/6+WtQHwTWwakXH1L9uBPlsZEewEh
         mGCYQPs15ZaeZpjpneqYg/aRgb7WmcsydSQ4I14YF8FtqtlIGjQbAvAAzuJdwSsmZZV+
         iGlA==
X-Forwarded-Encrypted: i=1; AJvYcCVBa3qOSJRUwTi+yhIYUWhJiDQpi5OFnDw7ZyvHtuc4b07WUSDxSreQ2erSxUWggOmAHHo0H8A/ppv9SlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsw4HK4VeoYmd2QNekEhcz7V4IZuB9tXGsMcZVrRP5C4xVpvev
	kefSnxhD/8Ygc/jZlxxSWsPLZalChSMIcAeEqMby6iRXXwYUdoXxKloTpMfGnmvdKvDaarrLnHJ
	vx0JowctX+E61LF9gEZKgkolQ4KItWhJ259HoFga1Z3B3aPYQS0vUyZPAg9a/O7eRNVo=
X-Gm-Gg: ASbGncsnwe0l+ZSjomgXyM2XuOvUOj2L1GfwGT+KB+NXFsuYSBSCg8oWGizMRIwKtBX
	jdgpW0sz5q/sP8Tgl8T6Y+4/bbJsIfMCuTxWZZTNzTn/JHdzDLO8MLcG8MNHtBkdm7fSddeiPTy
	7qRGAIAfdrA/LDBLFUgWNVolH+7QHivbl5t2Vh/tDeqGUEksvL1/2UIGGjiFkjD5v/6et7HJM/C
	kb+2vXUNWEwo/Vuow/r5qmhmXED2kLB60SwcDaVi/AxMBjrqwr5gbitKt9bqH7RhZ1bIgAOhxTi
	YPvew+bnLvMt+uN3b1UN0CnR9a4UjWt1XygeIlp+l2rQx4QZg++iNLN7WI084MV6dA==
X-Received: by 2002:a05:620a:2693:b0:7c7:a574:c6d2 with SMTP id af79cd13be357-7cd467334f1mr1333948785a.9.1747846869447;
        Wed, 21 May 2025 10:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNHS1lDDeDBQUllE4zZV5CnCSt8BLX//4DkjdEKYf+qhDNZ7uIRPICPWLey3JSoexL/h+InQ==
X-Received: by 2002:a05:620a:2693:b0:7c7:a574:c6d2 with SMTP id af79cd13be357-7cd467334f1mr1333944685a.9.1747846868906;
        Wed, 21 May 2025 10:01:08 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498b4bsm941652966b.148.2025.05.21.10.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 10:01:08 -0700 (PDT)
Message-ID: <c4442c3b-4f05-4031-8b1c-243e3028fc78@oss.qualcomm.com>
Date: Wed, 21 May 2025 19:01:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] soc: qcom: qcom_stats: Add support to read DDR
 statistic
To: Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Doug Anderson <dianders@chromium.org>
References: <20250521-ddr_stats_-v2-0-2c54ea4fc071@oss.qualcomm.com>
 <20250521-ddr_stats_-v2-1-2c54ea4fc071@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250521-ddr_stats_-v2-1-2c54ea4fc071@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ueQAwgBDC2CSbDjmOS29Aq5IWk1teM4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2NyBTYWx0ZWRfX0H12KPatjURN
 HOu2QSCS+ms0qncz6pFsBrb/pWcBdDV08v67kuY6uIZ0yB8u1A5cNf7xDTWu9LUyS1gY1mOoORY
 LCd7qraazMRb2C6MOD3MMreOyZs1YjsVpAIW4t2xNWCrG2KjZC5D1OFdZdq3Gq6TqXr0uojCZHU
 b3lCh98f5gNaCVHLj175AdNe8eq12e2rhpyeqoncecKCLTWionJAizAaZBHhipiNLB1vXluxY6n
 VribLT/9KZVHiPdgmPlBQsMqCWpXXXi5uZ1c7R2i/221FuO+yIhkj0fy98OLeDb8jfdxhg55Eww
 PbMzujqWoT/LltjlEeN2HQy5+QKEsog6PboitXwMTxsx9CJadJbwzfY5rSHvJkbttbZ7EmZsIHL
 gVzy6sZKSC5bowDkFqdvO6WQhFYY24HtVbcKqQJ0SZ2dfhi8w/ktmEhrs1JTbIu2sZ7oGyIp
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682e06d6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=px1QxGzWThjcCEIoTy4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ueQAwgBDC2CSbDjmOS29Aq5IWk1teM4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210167

On 5/21/25 10:32 AM, Maulik Shah wrote:
> DDR statistic provide different DDR LPM and DDR frequency statistic.
> Add support to read from MSGRAM and display via debugfs.
> 
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---

[...]

> +	case 0:
> +		seq_printf(s, "DDR LPM Stat Name:0x%x\tcount:%u\tDuration (ticks):%llu\n",
> +			   DDR_STATS_LPM_NAME(data->name), data->count, data->duration);
> +		break;
> +	case 1:
> +		if (!data->count || !DDR_STATS_FREQ(data->name))
> +			return;
> +
> +		cp_idx = DDR_STATS_CP_IDX(data->name);
> +		seq_printf(s, "DDR Freq %uMhz:\tCP IDX:%u\tcount:%u\tDuration (ticks):%llu\n",
> +			   DDR_STATS_FREQ(data->name), cp_idx, data->count, data->duration);

clang complains about both prints:

drivers/soc/qcom/qcom_stats.c:173:7: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
  172 |                 seq_printf(s, "DDR LPM Stat Name:0x%x\tcount:%u\tDuration (ticks):%llu\n",
      |                                                    ~~
      |                                                    %lx
  173 |                            DDR_STATS_LPM_NAME(data->name), data->count, data->duration);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/soc/qcom/qcom_stats.c:181:7: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
  180 |                 seq_printf(s, "DDR Freq %uMhz:\tCP IDX:%u\tcount:%u\tDuration (ticks):%llu\n",
      |                                         ~~
      |                                         %lu
  181 |                            DDR_STATS_FREQ(data->name), cp_idx, data->count, data->duration);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~




> +
> +	key = readl_relaxed(reg + config->ddr_stats_offset + DDR_STATS_MAGIC_KEY_ADDR);
> +	if (key == DDR_STATS_MAGIC_KEY)
> +		debugfs_create_file("ddr_stats", 0400, root,
> +				    (__force void *)reg + config->ddr_stats_offset,
> +				    &qcom_ddr_stats_fops);

else
	pr_err("Found invalid DDR stats magic\n");

(because through the compatible, we much expect it to be present)

Konrad

