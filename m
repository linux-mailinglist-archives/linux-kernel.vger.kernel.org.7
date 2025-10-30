Return-Path: <linux-kernel+bounces-878089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBAEC1FC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA4B424B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54133330313;
	Thu, 30 Oct 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLC2u/lP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S2IKZK9D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE012D2390
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822695; cv=none; b=g3TZHqEHAhDTa+UMWdVjfQzmSLsGnOMXso6S9Qo9RHwm/eu1iIt2iPGcGOUtp8Aox+PengNy0mDGlMDL7iqBYpllUnRVKCAMf6R6wOZlEazV6ahPSKpbvuAzLbMEAtcnIMpkHHsMLVPUAgxA1aA2RPv5XqL7bBIw5HEGMmPwucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822695; c=relaxed/simple;
	bh=ctUO0h3bkvxYBr86tkrbliK/doG84nCjqEI/sOZ4WH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyuJxhPZSTTARevtBkmJZK9uIRN9qyMjt6ZoaZuxqcpuQkT1H0/bILfaqlFD1MbreD6KzQFLWgxypGVIjsaAgyBtR+/AwANX2fnbx612peNeT14k8BoamT6wxrsd/5pjLSxjvy45KrFqM5OvyiudNfNEXhEy41/rUhamMeFFj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLC2u/lP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S2IKZK9D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9SUw61994626
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PDon4uLNy2yUeectcUHOsh5oGOg/cnHyQWjexZNhfK4=; b=VLC2u/lPXur0GJob
	17hFFVud8/MEeNG4GKJpWn+gH05lfyd/Gy46armaOCxDcp+LqPvaj3FNxJ8tfmrP
	b0SUPi5B4bsNWzdvGKFBzP0Pzxb+RzMzj22DcpCVwGG2J0TfXUrY+KFVFUOvg5Qk
	TJCkSt7k2pawd6KnJeJClPQVMj8JvaHWl57T4JnOaW70J5SNLZN75TFJYgjH5hqW
	E3ZMVIcCsRtcd5r+YJnr4QsALrlKbaRnn4Ln8aE3trdCXKWpXCL4CUTkM4dk3qnT
	8ohXE6L/f6JUsLzaXmy0/quOcXG4egL4NLmHL3OssZ7IGN/CqOiHOD38C7SAlOGj
	EDW0mg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr71m98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecee4fdb80so845581cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822692; x=1762427492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDon4uLNy2yUeectcUHOsh5oGOg/cnHyQWjexZNhfK4=;
        b=S2IKZK9Dm5xw77lsoQej5qWokCxjgHtf0RNJw/Y+xxw3oslVvBNejLDogyaEuKgz+t
         cJwcmyc6ahTj24ZJ7zpaG0rVFElygB5+UhHomhQ8+BRGSqI1/+CVZE/BBpDMlqYyhU90
         eaYaXe+pKKVP8+ut+wLEVGe62YmMcQ+ePkZHUqmfB6DWLfAwGBkAzN0wBmo6hZS9viKF
         g4v1p1jCjHMFNe/oeFs5+K5ulCcyEfF0DYEHgnvAJR9y1HiGxLDSdEKQMjPW1mVJHbQm
         TV/V5OxuNpIaxcW+GMdnDvP5YmbgiK4v0IvORXQJvKcf4LDHbMHMJAn/RLhW7ItR2kpo
         eU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822692; x=1762427492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDon4uLNy2yUeectcUHOsh5oGOg/cnHyQWjexZNhfK4=;
        b=WXmejX7FXhv8TLzLV+OkltoAhOtmfCjtW8Kwc/dTQt1z+f6dN3NlAN2O8ceKijAcaP
         qWC8SbpbvBhlgOoYcz4zpTCrbRLOLzJsxYOc0VRvyTKbcMoE0RGygAhe8ACUeS9T0S2B
         laXlmim4+fbWXSVY/FmH/lWHqtoLg5T7TqkBqQVqQzyZYNpLfmCQ0ybJD7lsO9nlOf1F
         LH5frQ/A2/kVpzuE0lYpBpAdTTPtatZqQxDenSlmrg476HKH7pPFtcV83Gtp7I096SSk
         /G4AngVImAAl4lIVF/MFXHmUCcByFnCUDflJUqlSMGoxBkRtzaS32sHFXlKnHxbUkiN6
         UZoA==
X-Forwarded-Encrypted: i=1; AJvYcCWGJlYjr7lQIAHczYZDGsYy/tRjpNo8TJyN756Hqmy4K8K52r+lylhQVGZYlFGquwMVS0S7XcHV+RQZitg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwXuCixH/hvx3fGCLvkwnJFrVDh+Dv6exvNQRGDOmatrO9POlf
	/clU3XGxFt1wT3rv5jp9CHHUJjP6Km20Tj+ufaEZYhm7AD3OOCQKaVPFrDbH8YO1hasG5AXQmqu
	bIvaSUUPr5ZIOlhguFH4HSeZFuubQHy+L5oPwdvWj5J39MisTRRTRd1ybeUJZu+kc1eQ=
X-Gm-Gg: ASbGncsxvzgkY/z0333ZkmnWIZTtn8xi1GTe+mCS79faD2Vle2mbxkV8UQPIWwNgFNd
	NhZ1tTic5xS7Xm7lHT6+1aGs/rhgKpSnYd9EdPrXuaCVhUBrwHOSQ+QQH5rioSOx3P8ig75GocW
	Rbi6YGsNoc6+KR1kjhmgx9gXNsfOzTRqKNIrwBOeoYNm4Tczup5GByStupeRg1UV+hTOAp0hDKa
	2LfnAn2NQJYwFw2GC/mpuT3nbRvSM6u4tXnHqrr51GXJ7PsaD4bWIChsD/3XHvAUwfHVND11m6w
	Px911TBxyLXLVU0c7BkdFjG6+G5PcwfyHk3NZJ/iy3z0QP6NirNibGWNTP2cYVnOK+n8mYM/UrO
	v3x3+fEaVJbqq7YizyfkGS9emKgTkTbYdlevxVUXLZfiYhTVO+qiGl7K+
X-Received: by 2002:a05:622a:54c:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ed15b4b304mr59170401cf.2.1761822692449;
        Thu, 30 Oct 2025 04:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUeZyE7zsL9Ndn5kVCCm7WCbI+wxddHa4VCy1ePFSnHykBK9zYrDXNkInOEGWmaNKPC/788g==
X-Received: by 2002:a05:622a:54c:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ed15b4b304mr59170111cf.2.1761822691954;
        Thu, 30 Oct 2025 04:11:31 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb97b3sm14460770a12.30.2025.10.30.04.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:11:31 -0700 (PDT)
Message-ID: <d001f158-008e-4aa2-9f30-a06d314377e0@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] clk: qcom: videocc-sm8750: Add video clock
 controller driver for SM8750
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
 <20251024-sm8750-videocc-v2-v3-4-6286bbda3c8e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024-sm8750-videocc-v2-v3-4-6286bbda3c8e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX5fCvJP/1sU++
 bMrdSvWC0Bl4uVVGgy6QZ6MUKU4xb56NMrr7U5jII+NbzXEBhHOqU6NpqrOsUVn9NYSP3UgoYCa
 /cz4PfZApaWUgzyMAgMgXbsF7KrEL6KQut2acA8Q+M4O+3RG3pFKzRm6UrcMwiFkoHPAQTERxZ/
 2UYbALPIm8bPJGTibiJf8dAvIhM1W6ymuFVi5TmbRAFPZJjuIHRSDCo+PM7LL0MIRwlL9Sh7hnC
 vECGHxte2Z2BdGmcpGQS8HhiLWAdDmK5zD3VBVoLQ2v3DrJk3ZCz04k/i88EJYs66WGMiTXLXoa
 bYDEBDc+dbndwOUMknP95e4p0WGDrjbKrOG+C4ZQNNHErQvh7iC4u0Zuj8i8cIACx/z5ukbHMCU
 D5kBdk3YFcQ1A204fuQbQbs2Snqecg==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=690347e5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=d7ClhsmVZ3m4v3ji_18A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: q2zEK8FGYysT0itJp6ggZA9OzdkeveFz
X-Proofpoint-GUID: q2zEK8FGYysT0itJp6ggZA9OzdkeveFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300090

On 10/24/25 6:24 AM, Taniya Das wrote:
> Add support for the video clock controller for video clients to be able
> to request for videocc clocks on SM8750 platform.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

[...]
> +static struct clk_mem_branch video_cc_mvs0_freerun_clk = {
> +	.mem_enable_reg = 0x8090,
> +	.mem_ack_reg =  0x8090,
> +	.mem_enable_mask = BIT(3),
> +	.mem_enable_ack_mask = 0xc00,

GENMASK(11, 10)

Konrad

