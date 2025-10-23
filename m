Return-Path: <linux-kernel+bounces-866512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B64BFFF79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511013ACC19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B03016FE;
	Thu, 23 Oct 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVTexMTc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C7301487
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208761; cv=none; b=ocRG+6xQ10DOvpPP/GO9zM/bvUos/FXpY8gCZAEq0YuZyQFTNJPfx7Z3j7bmExyPhFp1pSaUmL/XoWEcm/a12tc4500CimIDos5kDVJXCLTl/lX5/tppa+TmrweY86yQMIQEHdLQuLzdWzf9ZaPHN73az1h11relNdvn1KcgKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208761; c=relaxed/simple;
	bh=nOax5hQLsN9PT1AWGz3YCtsa3xYATSOpBANd8fewLts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMRsohjXCBXGXNzWaGSPTUnNV4bTmOjn3AyTfp2fPsVAK2I0svdI4WCSAwMLYIuRwEngsmbEWJLfn/tvCG6hEfG2af50j5jv5cK+a3umC4wzy/qCv+Ue9RTIXxrqvsA57hD5kfgGcUFwPx5CHIv5EluRx1oYg88dgEOTOwQtuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVTexMTc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6pQb4010377
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hWklso/dxpLXwGPGUP0msBHS9WT93suLvo0LKoUXLFo=; b=oVTexMTcIxNPHsts
	3bnBsHd2KLHjGUj/+aagPZ8UN9MxyGO5059ZiB6S6yOLeNRRRv2mR9BzIDZ1mfDu
	Z+5hoSXYYG5NnJYvo4EnP1sx8B+N8Pctq153qcDABqO9y/I+fTGaXbukTlaCGpDr
	ilo5L3gOthqSmEuhBBEkK2GM0+5e4ZMCoTY0JaYuL3lLlizhhzFWSoDap7vNTMhi
	/u0iiDU8abW1USS2gnCxXi9tT9T3tY+OxzKXBxKiohKtAxGIvKHYqFLfjF04nOVf
	y3BooNhgqIfkXhepQulUuI3OaxmIZF8RsJQ4IzoW53irK8Zq0zyA8ONxm5fIntWh
	6O/bww==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3447qsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:39:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7f5798303b3so1288036d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208758; x=1761813558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWklso/dxpLXwGPGUP0msBHS9WT93suLvo0LKoUXLFo=;
        b=O2bDJQlFkFxi00rGXybeJKVi3TlGnFaI1cnwWUAo57HjwiN/PkVi+HXt+L0RCHMkN6
         iKHUE7JzI7LDyeYdmbq3xmpbIy8w8g02aaITjGbrRoNcO15yNtDWHxgWUO/qdK72NndM
         mnjvB+21CFK17wnr8TaX/iE9lYWN94ziZ5/kim4G+UtHkVDioGboTPelNahOa0ZG3kf+
         ow3bJp57o958NWHl1SxbSrmU3xJH0IvalaK4jur5tr3WDzjRXqk2hEsbv1qpVzhHfQeO
         qPrBhOGx+0O9kiGwJZoDhdbi9Kum6xDoDgSXkmbHKQwfTHz7XarV/Xc3+dcNAfqPtaky
         xxug==
X-Forwarded-Encrypted: i=1; AJvYcCUF3M89PRRIEJIFPsJAPDx8r8T5GySRHVSefvLVu1dIHJ2gBSYRbPW39uwXbDyUXVmCyIYqxkI2Lg7nqA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUEH9+dm/Gtu8roAUlo6f4CJfu7JWLxvfOGid+SIpHy5orpH7
	j6e6EBOR38FeRRYrg6qug8S3d3k4CoTeYs52oy81q5iOOdGae8dzxpCOuWsIi5a8oFccf5NiYgR
	MIuYs6iUjwrzB2KuUhpyUHqgavtkMSUo+9xpY5Z6rdQnYZ/Tlmd0UxtHnjID/qHudWDA=
X-Gm-Gg: ASbGncvULniF3SozVyZUJOEBZHVC3gs6grN/yE34GITnYCw9cVGtFe9Ln+42U8UaL6A
	rayllCkbP59Fcpq56QbZysEC6NouTLAsxsz4ojQYsrAhBxmTMTmZjz7f9tWK1tRjyFBC0w5Pb32
	0ibDkzA4OYB/t40kOvFhAbjc/k68d6iQURMyV+++eGHnXJYpKnr2bK6qs8ipS1dZpBwgQ8wTF/l
	y9oJf4YgdJAUyGUFm37y6W084jmD0ORj+hRv8E1+HSNkxNaJV+OsMvUP77+Pcb1JgfHpwifVPay
	YtmQZOCB6kZHBYYH2DixT+pu71fuCn9rbiz7PdbQ+AAafBqVLTvrwi1exAc7LIyk36KXw/aEsxH
	LEG6i6Hiu/EvWykaMNa/e4HtxP9DlwG8miaCvxNUQAcCREVnoQ7LLkbQ2
X-Received: by 2002:ad4:4eeb:0:b0:87c:1f68:60a7 with SMTP id 6a1803df08f44-87c20648934mr220471766d6.4.1761208757884;
        Thu, 23 Oct 2025 01:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1cj9oNKOdOhb82W7AZwyB/d6gcZ6DzbdGz722pp8OHNmq2vXVRfnz96SMP1l1gSm5txUD9g==
X-Received: by 2002:ad4:4eeb:0:b0:87c:1f68:60a7 with SMTP id 6a1803df08f44-87c20648934mr220471536d6.4.1761208757410;
        Thu, 23 Oct 2025 01:39:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f3349a8sm1129107a12.36.2025.10.23.01.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:39:16 -0700 (PDT)
Message-ID: <1039aea3-47c6-4205-826a-636e595f127d@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add cooling maps for CPU
 thermal zones
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        kathiravan.thirumoorthy@oss.qualcomm.com
References: <20251023043838.1603673-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023043838.1603673-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hOMP7iDf-oLvh4B8YLss-fsShIjqcspa
X-Proofpoint-ORIG-GUID: hOMP7iDf-oLvh4B8YLss-fsShIjqcspa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX76y6tK0JLLxE
 D+47u/ED5CsdTN45lzZo52dutmCVzfztgUZWPu1Xzh7UtbXAsV03jII4BwcWalCguxzjjVvL5NM
 FeNRtfBBS640uSwyBxnxLSwqiRZePAvEoLJu075gTcdULO1tXVXzOV7b6Bqc/r/gjg8q5MFK1jF
 vUKncwNswaGn8Wl5ElQFSC4QAK7hVkuCb/JPouNSzhsLWcOOYnAoOmpSxMsLuZQacs4VHK4pDGF
 dHMpW4oaAz25mxVM9sHSBEKaAeMqn9Ze4lsx8vEpHoC50N4E9mVqmg2FX43yItwip+Ygr798vPN
 ESVzq0LvuM4yzEb2eWfPnsdakKw5ExT1jzS1tP+tSBTZvQ96RPZwoQo2Kgdt1qA9+0HHTdiV1RJ
 1FoTtOvTCr9B/UAYnPqbA+tvTdHg3Q==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9e9b7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=FqFNHRKa5SRjCxdZjAwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/23/25 6:38 AM, Manikanta Mylavarapu wrote:
> Add cooling-maps to the cpu1, cpu2, and cpu3 thermal zones to associate
> passive trip points with CPU cooling devices. This enables proper
> thermal mitigation by allowing the thermal framework to throttle CPUs
> based on temperature thresholds. Also, label the trip points to allow
> referencing them in the cooling maps.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

[...]

>  		cpu1-thermal {
> @@ -1254,18 +1269,28 @@ cpu1-thermal {
>  			thermal-sensors = <&tsens 12>;
>  
>  			trips {
> -				cpu-critical {
> +				cpu1_crit: cpu-critical {
>  					temperature = <120000>;
>  					hysteresis = <9000>;
>  					type = "critical";
>  				};
>  
> -				cpu-passive {
> +				cpu1_alert: cpu-passive {
>  					temperature = <110000>;
>  					hysteresis = <9000>;
>  					type = "passive";
>  				};

This means "software will start throttling the cpufreq at 110C"

Is this what you want?

Also, is there nothing like LMH on this platform that throttles the
device way earlier, without OS intervention?

Konrad

