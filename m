Return-Path: <linux-kernel+bounces-759096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E057B1D866
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E5C1694E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5722566D1;
	Thu,  7 Aug 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o13u3Q20"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33552561D1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571454; cv=none; b=FCvQUXRR1A8y+ccjSDoTSNHUO2BgJkQjPH3/8P48jMRalCAB9fNwpc2d4htTVdUCpHADrlVzBKk4ESz6KU2OPRpJ1TaslrPnk3wOdrozy7FlUcJS8qT46OkVghUqP1xTm2EsyWgzPy33GI+fSj/RxzXvobsSX0S4c8cMKGTOaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571454; c=relaxed/simple;
	bh=953AY+7dSbH9wHF+PhJo4FVLVHqsLsP5sdwZQ8vgZ6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRmEJAdD8UXkC5Ii7DvuepbvJq9s4sNsumZ24Cg0ySBeSuBIEhTq4fLRWjVseJf4TO20iNZO8VQCpBE5Tq0TClV8sTtstryOIx3EoqdpU4FYjZ5h4aBIr9RS9tOGH9m8muQKC3lpePLd26wYrYHVbm1/8yoo2zu8Rqe+Gc8sYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o13u3Q20; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779CvOt003579
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 12:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8OIXeaOB8flxhwBtUk7y6V4kuUsN1FGyAko/S4lculo=; b=o13u3Q20IrjAGfVJ
	YZysEu7KzM9biitSFTyHmsCptr845x9RRaQT5Xhk/b8+4kq/Usl1U0TiulQ5Ku98
	tfXw0VhmEKMyskYC0rLL3+Ko9bNc68zj1EfpOpYuxSy31/aFeXbfN2kYn1yPWoJO
	sVjyGZpkf5wZiUTVchZJh8Pf9LIZ8Z0bAQq4f83im7odXa4cA0YZceByzsd/wFQK
	YJwM5WErKEvdiJAwtDcGIeiJK5iCRTuVoP8TsUi9oK9KJ1NePDumReaz/QjCP776
	kfTSRtNDyq4JgMl0Hl38biK4os3p13A4dGOP54+qchJJJ8IMtPxbaOGvlWYrDt/p
	04wHDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyae9qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:57:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b07de45deaso304781cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754571451; x=1755176251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OIXeaOB8flxhwBtUk7y6V4kuUsN1FGyAko/S4lculo=;
        b=p+45JBe4NHJvL7vYUzIi96OfZ9ikw4m3Yofr55rOwBJ84DBK1CkSuoUSv0eNN/yTAj
         I9F/IsaGMrnwk0QLeWHPwIhpvtFbkkZRox/aE8rsfi9s/AHz7AcB9WiGMjbh+NAxO5ER
         m25EYidxANRkvXs3cu/tqZyZkoYn+lkIsLNZ0DpM+NoYdtrBqGYgBUOMJb5vFChRWr0V
         D8TJrVYlyoMQ925bx9BjR4UIJhGhN7zb6Y+Z1CTSXJ3LYDQo7k4bSdi2Y4Wj/LIzDDqM
         9Gl+UakEDHC79z+YNp/UjrsALtd7kyri5xYi0ccaiZO/uljlKhWXDvwYd47H6jqaYGxq
         yH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVc0FNbavCObynQMSdMoX4gQ0w7Yf9s4BBhk5u66QeTu/L/Wq6INZzmvrlMPTD3U/CMav5iAdxbSPR56Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc63JSrZYH9qIRoYW324qVyhAqba/EpKyAYp3/FNQECGZ5rjFY
	eXNQ8WbWUxgm9XHm2uzaQf0Wj9i2hIHxcgwEI2foFVPhCNzIMBDMOtZgJPNQfaUSYPAeCPoE2ga
	zQER+9ttArwFiR4TghOB+VHpcH7f3CZs4FjabMlJiorXsOOeqnME6Crv9DGlWR8r/D3TbLoExqJ
	g=
X-Gm-Gg: ASbGncsK2WPZOjkb5s+U0+Git3BogWuE/jnb79hUMbF+EZdmK02H+iZdl5Yu1S7a9OK
	fuYzQtTaHOqDjvEfvFjBVoG8+fn4d42RzBgx7a5KhySfg0wETxr0g/tRJ71LjwJN3R7YGiAQOG4
	mHuB4MWdYxieiOrdOWnytWB8hM7uRZK7IJcoEohJA0o/kHQ5zAKYj8hVt5pQMJediFmsr7RaeEc
	9zb7z9VbOAaEwv/yVLFKIWVK0eRDgc3QczKMYtHy0TphOuhFpDiEEmmoqbc5C8QTDZGRK0AOuJc
	zPNAXbnr/jnJDLHIFzgfVH+qLXhncOS5xuP8y9MwxoIODxKDlu2hQZ1YfL2AzSU5nXC4IVRv85i
	F1lSB1amfTU03unNpIQ==
X-Received: by 2002:ac8:7e83:0:b0:4ab:67a3:ec09 with SMTP id d75a77b69052e-4b0913bb1c0mr48010161cf.6.1754571450477;
        Thu, 07 Aug 2025 05:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk/SDii2Ay4cMUIPxE/YCmiA3Zx5HlsYuCta0Bz3NHjAwJALVYuo7dGy/xCJsgW4ItoZmZtg==
X-Received: by 2002:ac8:7e83:0:b0:4ab:67a3:ec09 with SMTP id d75a77b69052e-4b0913bb1c0mr48009871cf.6.1754571449847;
        Thu, 07 Aug 2025 05:57:29 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f245c1sm11833035a12.22.2025.08.07.05.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 05:57:29 -0700 (PDT)
Message-ID: <41a0e236-2637-4a23-b4ad-4c8d87595334@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 14:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
 <20250806112807.2726890-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806112807.2726890-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YN_tNWuC6SCF9P_E5_mb0zpU1awmrxnO
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=6894a2bc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=vuI4R3Do2uEHNfh2jzQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX2VYHr6vLlPV6
 mpB9LPx1WVGjf+jWftKs5U2bc3NHuZG92tPbUkWn4nIOsj1tHJKS4bum7l2j1YOEO1Qb65LWALY
 hN8tns+wlTDHNN24AvIuRpQGUplqZkV1iu4nJXiNiG1JvMPdCMbgwt7PmGte+f0JKePi67o3Kug
 HloLQ4xFs7te0HZj2U+6V6XYpVRhVfUUHDoRZV+qg9L9ywJc5Dci6tUNTMO18IUcAqbaXuQ7XyZ
 wResgqMBwyzo16vKTPhBWMXao6/iskSy4F83DaNvfmeDudAA+e1hway7vc+8pbQtPse/4Gw98RN
 HZnU8ZAMjS7oU5fuFrJKehjLt0aYy7XCiTWgmPyPIO3JsgpLAdUa/4GrAa3QjiHcC1ikDJI+cN+
 /RopnrRl
X-Proofpoint-GUID: YN_tNWuC6SCF9P_E5_mb0zpU1awmrxnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 1:28 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> CPU clock scaling.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related entries, fix dt-bindings errors ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

