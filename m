Return-Path: <linux-kernel+bounces-742583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552AB0F403
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FAF963010
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DAF2E7F07;
	Wed, 23 Jul 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UN7ohAC4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6631C84D7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277463; cv=none; b=AzDx5uo5VW+0h2rz95MRmH/sEOXpVV2WyrXk0lUnyw+ENHiD1zM4QWt8qZfpk94WTI51crSqIzI8PM+oPQqWmXqSgyhp0OZtidH+v5m60GcWJC2qQ/rUVgfQvtgs2+5i5PwfJEibRrgoORnGBMxEraUQi3huo/BYvZVwE3VfE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277463; c=relaxed/simple;
	bh=EsJ9Yttdjk/WRUeHjLMat6aruQsPF5v/ToVWKIRY9WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcqhG3EHqtAq298B/xYtDwqwDYHHvlpQvEFLZJxnRzb2YoeZmql2cc+/yi/ELC2+kXxua+lldTzcYKbqEt8Ee9YBX3eEnb22sNSnqX/XLgC2UfN9QaljoZNIa1FMV0hWg+O1D0cnfJOhvXDa5zmv8z/hrkJPvIzSE1gVVIbLOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UN7ohAC4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N91Xlv009233
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pJyi0IIymzYW/6UhzSsrgJXNO2BmqOWGv65j5AI+HXk=; b=UN7ohAC4Vf5Bu3ct
	04dtla9DCHR9OhS0MxGr7e9arNJbWNlmmLUXkuCkC2XmQyfoRdV23gWvvz4f+FZW
	ErDoKo4xgEP9c0piRbPIrt5LX7r5dFonGWGKPIiRC8Zf2tv1S8jegaHp95//gNq7
	7T5qB17S6T/sK1UYCrQkqfMV/ZGnvRF130SX7JaalcJgoOB0VnrTQjBK+vmmQfin
	ru6N/eh/IAI1exsbS/8sWM+oKeSXX4+vMBFrxA4++2OQ5/1Ot3N3jWgB7VbPzHWO
	2B0bCwbEPjj6Ec88AoxD63Zls87U0GFqPsYTRHUwcft2BWxwi4kZXp/aF+3p1f/v
	pdPYLg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na3pjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:30:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e33e133f42so33519385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277458; x=1753882258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJyi0IIymzYW/6UhzSsrgJXNO2BmqOWGv65j5AI+HXk=;
        b=STE5czj4ljLBrUP82+/XB0WojgAsjhWYRheyRhbic+p37MWZKE1FDFmh5o40ZS2XdR
         O+hwN14eDekaJW+MEkUZAWgkf9E7vcxseRfFRKsOREDea3gQgL13UOELJjiiIuveO/D0
         3lcNbZRR1JKOMRt2/kw3R/BbSrjvSuudSB658myhSvkGV+FY/1nMo3xCxUO/VH89sDzv
         kLrzC6sm0oSWI/Y99e/3qoBQkoxFhpQoMg9ECHhiMN7qwrZnjHCLu0admLGiXZTvXkKI
         DYsIoToMM6a93oInyxjisVpSf3CYTxTLaosm1tQKYduxaZBOnxdXun3MjjtUXtzwiSwp
         9wWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEi6Tn95+l9uWPcIm7sJZNIToH7lVOKqGLlhcSvmy3tbfNptQjpqbmjk4ozb/cZNaeS0tDCEkZXoADUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlG2Wl4ogHADAqVa736Voy7qaAXsQZzKO/49viIEOhA56bzXK
	wcpZCp8xKgJjVRWM6OR3/KUbuR4dhzHuP2bJaXsMXbLjzNeiTM0yPuqQQz4Xpo137L8/p7JocXW
	xyMvR0G+9YrlnO2UkfHzwJh1M/xzuP1almARLTqcGP8nl9OCto2rMhZ5uEbZ/amfkZb4=
X-Gm-Gg: ASbGncvTduEId8iVNKpR1kEMDa2jJCQPDgrjBSd8EEHY4Gqk0+Y/qBlyxHG5Xmo85QY
	GoN69rj58wNlDptS6lPDpe2hAl0ZCX3Dftrvt+7kZ/d+66RYHiM8Tp8zAz/bWDJ0ReSx7+/vv7d
	OzqMUC6BG3IlJYQmNpbLpZSpuhtMC7GIhnuNTveZZoEhLJSqh6WAocMdfF/adREFLjwW7RglmF4
	8bgiuEwYmPCEdeIyw5twgJRV1ts/kdk62jCwefD1VDm1jwLECQJOJWAIJt8UwjhbDLhbLh4e/j4
	blzVyuKAcv7D8ALHzrH7ENTBIMXPSY0UtPl8eE1ZtaKfWUpwcgm9zerqZwVHU4d53ZHeHwqqoiz
	5zaKJrEGKZpouWdbRCQ==
X-Received: by 2002:a05:620a:9633:b0:7e3:3029:44c with SMTP id af79cd13be357-7e62a112c00mr131774685a.7.1753277458140;
        Wed, 23 Jul 2025 06:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoN9KlCmUdoNJ5eN9OsT3DyPSLXqMvOlWulVwgaFKPCWWpNreyCerv7PTLgQDFAM+oBFUZTg==
X-Received: by 2002:a05:620a:9633:b0:7e3:3029:44c with SMTP id af79cd13be357-7e62a112c00mr131772785a.7.1753277457457;
        Wed, 23 Jul 2025 06:30:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d55c1sm1056237866b.41.2025.07.23.06.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:30:56 -0700 (PDT)
Message-ID: <ffac121b-ba15-4384-8961-2661f9748d2f@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:30:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: pm_helpers: add fallback for the opp-table
To: Renjiang Han <quic_renjiang@quicinc.com>, quic_qiweil@quicinc.com,
        quic_wangaow@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HEWXh2NKTwBtuFumYNO5H8_HREYWFwn-
X-Proofpoint-ORIG-GUID: HEWXh2NKTwBtuFumYNO5H8_HREYWFwn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNiBTYWx0ZWRfX3TtDudvfqRLd
 kg6EJSbdZhgpZJxnyMpOpyYQdbmmgHqq58ZSri/HhsjGmdNw2YINVXKA/FK23fBiKALAonfGhhG
 KAfoP0H7fFyhCuuRCcC0u2F4zmc9Xk3zB1JLXaIbJHC0sHFqobVOJqH1zU/4gy6TvIreaWm5Zsy
 9RrbrJ5GCaLY0HkLc8A62mqIEqB4PFVUFi1wT6nehtGDa6sD9X25sW7tiMjwz/2s8EKq9e03GsO
 uroimc8z1QkRzjR8M0rvbQjAQ7HQwEL+/iHnB94aGVCZZDGqBJnfH41JCX1NYiHSllF6bKSErFA
 OBcd3Y1dkJrUw+2lBQk7cJrhjfg45J70G05EdSufYge0x2cLyJYSOZclniFrZk5ZyVIfNQ85JRg
 WJc0lAftlsZW/s4w5LQPjCNcRGpD4CCFEPeybbY2ob9TSgvMiXiLbCLn4EXy8YkO7gLempl5
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880e413 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=iWKRvkjQqEvONqlByQsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230116

On 7/23/25 2:56 PM, Renjiang Han wrote:
> Since the device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX
> do not include an opp-table and have not configured opp-pmdomain, they
> still need to use the frequencies defined in the driver's freq_tbl.
> 
> Both core_power_v1 and core_power_v4 functions require core_clks_enable
> function during POWER_ON. Therefore, in the core_clks_enable function,
> if calling dev_pm_opp_find_freq_ceil to obtain the frequency fails,
> it needs to fall back to the freq_tbl to retrieve the frequency.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
> Since device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX do not
> contain an opp-table and have not configured opp-pmdomain, they still
> need to use the frequencies defined in the driver's freq_tbl.
> 
> Therefore, if calling dev_pm_opp_find_freq_ceil to obtain the frequency
> fails in the core_clks_enable, it needs to fall back to the freq_tbl to
> retrieve the frequency.
> 
> Validated this series on QCS615 and msm8916.
> ---

This is not a proper fix, the logic you added in core_get_v4() should
be moved to a common handler

Konrad

