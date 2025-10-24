Return-Path: <linux-kernel+bounces-868417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B3C052FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95B7A58204F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4B309DCF;
	Fri, 24 Oct 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7EkyC3V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C63093D3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295205; cv=none; b=mzBWCoeFy0acy54bQHd1GhmF/Se+QxCyjiFrHNpfdtzo9rDx9JIBdiosyJAgQCQxMsDefWEp7ahz8PewixYToGQWymYN8olyUHHYxULkqqfh2Ejri4o9TA+1i9r0PDb4sSWNCewBW6qxW8Iq+NcH1bmBtSL8b0SEawUmGzDfOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295205; c=relaxed/simple;
	bh=JYG+1M6PiT/mD78iOJ1agyaZE8yQPk6FhGZI0XIiWLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACGceBoOvFtlnZ8QPFUprOZjNvl57A4a7EnhBqs2fB5RuVTNd1M47pLs4rtuMrb1XVMhLWnFnyOSzEISqudMlD0ZoqmwAHiZ/hVZUPIIrAUh2+de8PUPawC02Ty4UWPgBYt3vgSoIQ8r/1BJkXPU2ofnMO+5UucWG5DNiPG0vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7EkyC3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FL5B020350
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1JOLmma9bqlEv6mHUzEz+JGLukJKbebhm4RprQi7te4=; b=N7EkyC3V4jno2qqu
	cri/U0CCVWsxtL80RgQTiqAAbi5Io/FErEVEqOQkhu4irHFPgpoas8cci/k1AldD
	bPVxwZIKQyfcuBVTYnF51Ifdgl0VjsNwLtno5vixKyubJSwxj7CsIez3sFgG5tmP
	5it57gNgFEDRDweHrXOBh4gWPdbcRQKIIYCDHP1ztfx/cSSjbmGNE0o3u6wNPcPO
	OjHIdGcPPTR5fxYnfR5Wsz/I1Neh4ZM3N0OMJGvxsO3GrIERWVoCSvBcbD56xkH/
	Z4dQotg9mBZXeo97jkhhtYHYqmy8RRlMFktz/aFkAepg0II8g9sgFp76kDNc93S4
	exhcYA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0sc2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:40:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87dfd456d01so5362076d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295201; x=1761900001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JOLmma9bqlEv6mHUzEz+JGLukJKbebhm4RprQi7te4=;
        b=dBiCtrXs+y8eGAA7Zc7J2f7p1L32ljWuNoOxaBA6uYtIMgsm9apmPAGQzTbVP4R5Sv
         bJRe/AfDYGeoPrmR0R6B4ZsJYdwxdCFJQoCibsduMNahreIl2uInC0HBhZZh18jXj01v
         L87I6/y/WheeTbzFoWvTwH47gIbsOSxzaLfRdoHOCJ1WM0tRvKP8//w4LJgeXY+1FuKi
         qu9q+XR7SFi5RVXMifPnXVDR9s4ZSuBDA1RTWEGA6Dhv5YDhtOjxbo4/sxRN7ACCl+HC
         8RDbK+9qFVjzl9IStJzlciZqI662WNcutgaEHmov0ThkZQ1hYQsyZbIBCVVu4La+ER0c
         4flA==
X-Forwarded-Encrypted: i=1; AJvYcCWsPuCJ0iwsknUBphJSlEKDTQ6fCA7qW1FMLjSI6H6Tnjze1pPb3aS9k98WtQ2itvRm9PV9mn4x7wVIWvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAEfDqvVOJf+VSI6saSrTEt81xn0ubge8jk006elte9Eulb/K
	00ppmJglJub9TviHp18GJD/3hEuvLbmypE/J5J2IO9zNCG5PMle5/26c/hq+ODQVgKKEPpPkLLt
	3OfrMUxma7dWxGrUQAdL9IC7qIZC5A/GqeXwZy1ELbJ3DkKHwRtOpXNYQn3dgg3wyOWY=
X-Gm-Gg: ASbGncvfysXbYNJ/pwc/pm3qKYOeQQ4c1If75DRhccZVuFaNXNoSd6YZzUEGSSVy23h
	VMI4L3y0oPB3Obc+WY40xtogsgX/90Z6+nbCA+2iRsHmfOWRXBf653n+XAH5cTEcs859L9Fr8e7
	iwmKObT/Hmt41kTx7FkyvgXQmVBo0j5lj1icInOl4n3OxFa9/K7RSsNNdJC00vbYdKMjFtGrQ8V
	KWu6Q9jMCg2byAfA+JPPR+wP6M4vkY3GdI49efQHl7OCWEvDE99XE3BfDYO3+2WpbjSnFkueRhi
	Hp5zSv/BB4FUEffDdnhDLSch742rGD5krml6uZT2KT620uB6WeTQf4hIdGg2kOlvWd8uUPTQlD0
	ZrNZshqCGvYqrwn/BOQSkLtLQIBScURjd8JoKQBktDjkd26665KMGEoa6
X-Received: by 2002:ac8:5f10:0:b0:4dc:cb40:706e with SMTP id d75a77b69052e-4ea117e0b30mr119093121cf.13.1761295201557;
        Fri, 24 Oct 2025 01:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHogEfnZCnfST81Rb3Ac0hj/uzXgJkTfe2vdk/f4ZOhJqmLDy0hT9TzZwbdfJg4861TgaON+A==
X-Received: by 2002:ac8:5f10:0:b0:4dc:cb40:706e with SMTP id d75a77b69052e-4ea117e0b30mr119092961cf.13.1761295201142;
        Fri, 24 Oct 2025 01:40:01 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51471ef6sm444517466b.72.2025.10.24.01.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:40:00 -0700 (PDT)
Message-ID: <102d9042-49cb-4aff-8b93-a882ed8da27c@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:39:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] clk: qcom: ecpricc-qdu100: Add mem_enable_mask to
 the clock memory branch
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
 <20251024-sm8750-videocc-v2-v3-2-6286bbda3c8e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024-sm8750-videocc-v2-v3-2-6286bbda3c8e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX0qXwgEqJtDou
 kgkbROLLVvk1+TcpeGVu2RSH1Eaf9L63j/j9QbPCMJCtn7IVlcdSFM2vRAFKi54gligXYwfM1id
 dOFCIVxhiskjhy56evi6Ce4LBUCPXYDlcNHydEIjx/YoQseSqAKtGdEzSTmmqLlYDJJXfLHZ+0P
 FRR3zws45rpsGc1e+mJGhm6EoJeGUgnOyqA8e/8RxzJgdtZvJgY5FvcUonX28C8f2lxjVnPAcE0
 Ssu5gR9FbyjQw+a3cnKgHCKF+T20DMbwN5Z4GjkDJUKrZVy2qRG0oC4ERTn0SHfb0+ITUsz8qpC
 nW1iwccKDeMJ5dPxo+qBfBobqJ8IcMz0M3bhdgF20NvJPsRnU1TS/JYoQ7KIPYJsUuBgsSI/B2r
 8KMT304jgR71fGIcDr7jX+VADeHXww==
X-Proofpoint-ORIG-GUID: 3N8qbVzS1RfNLd9pN9rHqfCPLLwF7b23
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fb3b62 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FB20kyDvaZqv9jGj6gQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 3N8qbVzS1RfNLd9pN9rHqfCPLLwF7b23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On 10/24/25 6:24 AM, Taniya Das wrote:
> Add the newly introduced 'mem_enable_mask' to the memory control branch
> clocks of ECPRI clock controller to align to the new mem_ops handling.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

This probably fixes some ugly issue, could you please mention what
the impact/problem is?

Konrad

