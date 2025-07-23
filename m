Return-Path: <linux-kernel+bounces-742301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB4B0EFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4725679AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AF28C2A2;
	Wed, 23 Jul 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSbZ/oLy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789C28A706
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266184; cv=none; b=ncbghOZy6sS5EL54+jviojZe7NYDmD9LfVG96hCT7FtwZfreD3IahW/se9GFb5eBQnJ1SwEnRRiHUPpuDoGprhHCn+z7lmlcDsri+6RTWZr+QmrB5JcPOPnpWzsiyS1pVMNGJ7cH3H6k16LaASYeUXh9KwAm5vC9xctTnZCFpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266184; c=relaxed/simple;
	bh=bcyKLsB3eb4YS9fuhXTf5h3qyk92uF6p/Os/+PB4kTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chumnFgywlFbPye7+n/peQHVXJYopmLsancEV7lScR/3L90odn4MoslAXxqKH5WyAeYvAeb+Rovuj16QzTONXYW3Kv6tWrOK5IlzrxThsJp3jQCg0rFTTERElMUSsl7zYUSvsUfdX+KJaAXhtHDB2NfiF0XEmT9CBoO0EQ7L5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSbZ/oLy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9Ps34031341
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A8pYxrLggsp/Pc9lqDpa3++CGRfIO5nj4AvygT3vYys=; b=dSbZ/oLyUawVCApG
	U9s1cCPf1xaU5ffr1QouCSCReiTXpsSdXT7yImzX80Ko4E33y+KWyJl5y7B9zmS5
	D2U2UwBB8crRwf3p/3/G//AUWbfC/MJa/EU5dDSNahH0XM6MGursDaTOnoT41VX3
	ocl/Y16OYNQ4+WFYSx/gSyzZIKXHpeXcQs5uQB271ERjdxN9/O1rNtjPHXFw6z0n
	4UzOtDr4+5w7tSTHVyINko/jOvcoEB2IihBvFnWmlWvjwYT5s/B3LblCndbDvFLh
	LXymxsVGKKRdd6tKAMLHV5BmUU5Xv3YP7Vx+u6BWr5Y4jeKNNlzNPAclWLc0rl+L
	ivewTw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s4st7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:23:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6facbe71504so9864326d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266181; x=1753870981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8pYxrLggsp/Pc9lqDpa3++CGRfIO5nj4AvygT3vYys=;
        b=Oi5D93U1IgglnEv1gpxfhPErVV4D2EjvZRITOVADtiljoOuz/0dXb7lSN2bJN+stbd
         nliP1335mXLK+VrFR3NbZvFZO5DKVHZ2fiwhZtXhBBqJzsr0V81T0uzjOswmYNj+RgYS
         U2jrlorGpF+afigZISFkStislCnhGjNQLPd9dbj/FigA82/TYrGZEXXwb6U0D437GZ5M
         xaa9Z4izpxwhVJf0VCBFYgAffvavsCYFZ29knrb0vWtyNCMZt8nQ9LUUdKvs2kaRLQHs
         8Y8pPx3CemeMTzlyrncgEYCSn3Ym8f7hvnHeGOlK0YUPMJhGkau0xfLCQACpWl7HBGde
         7ITg==
X-Forwarded-Encrypted: i=1; AJvYcCUrKqA1XntV3S5BeBNXocjoq9Wt8YdaYNOiJLjQx2Ae+3LQmIgWOEsbgqqQ8u7LorbUgxF0j03hypAse4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvxm3KFJ3sicibg30aPtlyAemIg3VvdUw06x2pRVywEyJ0X4D/
	8eonzJ9YQm+k8mzImueLBaGP7+EaXBeZIeX4udqNx/HiDsSBH46yDhreSpw1MOcPA29PyWYoAk7
	U51RtQZ0sR1fOzMns35kFcaxA++rUrpQu25gnjxacdzqGQdprwzXVEVKDJuG+mA+kXWw=
X-Gm-Gg: ASbGncuz5dSyM3Qaq8LG6su4XwL++zquQelrvLW2I2Jpe/dhoStT+vLktKjsHnuGiTd
	r9U+sXKH44c03h0zpIivLGtipu5HjdrYHKjdq6uU5imgcXex0vDu+mDedJrM2YZwjbPFdqqp2uO
	BWTsyKOv25bGFaI+kkq4GOtoMlBRqOUdDgDVGvyIqJRgU+jVEnv8tXpQUBYlW9U62hfQ8mq0VZ8
	t/WE/yvrF/83EXZ01kMV1ANowCoW7Boh6rgsLIz0MgmCOLZzcR0GRwBfU5OHWUmwFBdh/8TG1d5
	bi81gsi3IgGJ67Jce6BWOCU5X5CiooBDx7Yv6PzAV7YFewd2UonCq5d36MmE8C52/3iZt16vne5
	aPj2I5E3zpjjkMom9MA==
X-Received: by 2002:a05:620a:28d3:b0:7e1:6d46:9bde with SMTP id af79cd13be357-7e62a1af38emr109301685a.11.1753266180888;
        Wed, 23 Jul 2025 03:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbdAr1cLYfzXD8fo0X4Lr4Ip40OFyltSfV9KEUBwzI9EI09L7HNQRYzee7xRd+UpVLCkm7uQ==
X-Received: by 2002:a05:620a:28d3:b0:7e1:6d46:9bde with SMTP id af79cd13be357-7e62a1af38emr109300185a.11.1753266180496;
        Wed, 23 Jul 2025 03:23:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf9ad7sm1021436966b.164.2025.07.23.03.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:23:00 -0700 (PDT)
Message-ID: <ffc28d89-ba45-480a-b664-9e4ffc50a3bc@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] drm/msm: Add support for IFPC
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
 <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NyBTYWx0ZWRfXy/UwCUgV24vd
 dbPwmXhFZp/cfDb0Jp3m1Xcw4hhX6eu9ea6B1Orc0P9KByPK1Wp1Tzg0ZdEoTjeXKMCBTzjlD21
 FcuHkrTm/RoHXidzK0oghDgZojG82rtWEEHHWck7ety5LdBqDKrDjGv69QZwZCLnhEjYuTzyoya
 qgmUd9R5IRlfUfrwVejdSL/Yq1Qlrq3yxMZq3J+nDycp06ZvQUgqqZv1/1HxhMdng3IyUxRNGmx
 DDAFH10UyFpXEr3BsQPLF3CiF37LO4mu66hMAOoh5lnYQrP6bfCT0tMDAvdXzlLiRxQCYqVH9aK
 3HCcxEiBLJUSdhdjTvZfiHUTCFikcfo6Gw69de3LTB5YhjTZ4DqgKCt/QxEE23+ZHga395FjIQQ
 jhhbwdq3/cuzVc1kqqGKM+V09Ano/pssPfSZfgthN1Rt5jQREeKa+g6Kwf39y64Zx9tthnC6
X-Proofpoint-ORIG-GUID: L2mhQWmmSQjvfxZrZ8glY_9kZRHRs-qe
X-Proofpoint-GUID: L2mhQWmmSQjvfxZrZ8glY_9kZRHRs-qe
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880b805 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mXZsdZnO6U5RsJfdWwEA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=983 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230087

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> Add a new quirk to denote IFPC (Inter-Frame Power Collapse) support
> for a gpu. Based on this flag send the feature ctrl hfi message to
> GMU to enable IFPC support.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
> +{
> +	if (gmu->idle_level != GMU_IDLE_STATE_IFPC)
> +		return 0;
> +
> +	return a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFPC, 1, 0x1680);
> +}

If this function is not used anywhere else, you may want to inline it,
checking for the opposite condition

Konrad

