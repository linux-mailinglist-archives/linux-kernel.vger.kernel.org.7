Return-Path: <linux-kernel+bounces-755116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A4B1A179
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EE217C57A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643825BEF3;
	Mon,  4 Aug 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqxekJlN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF125A633
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310800; cv=none; b=f9JfgIEC/Sku04tNOa2mJc62ejY49h0SuOgiXrbzsWNrz4zDDDNab31DpMCUxCnesNaLglhc1KNtj36WGrACWlf3qm3l37BqX/B/QBrbRSUoZh8POth/j/7AIaVgmc7+F46cxKnee1j8D00BZbZyL03iXf0T0EXSw7ZUgGtzqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310800; c=relaxed/simple;
	bh=ANVmw6AeR0GHHCK/HKaHO5w+extSI4H+i3GF9Iz3jdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmOE+87QDvRGpDkSRw+RMfi4//N2IisgmTV9ZjBbAKhfsrD8fzi60gSXwxXecLWnxoP5qTBvAHPbmMcvyFYK2Hl6/MBlXujiqjlWDAWDQD98XvmxjI7PXAlm92rnQ0G4qlZzTLK+om83u0jbL8LrcyBFnE8tUA3zic/4nRXDh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqxekJlN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57499VOM009778
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 12:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	46HAWgvv2MxgQgdpENwkPzAKGo1621//AEpZFMkCwFU=; b=WqxekJlNtED++Z3q
	iLHSuYwBGbF7pe7KzYohu6uNqSSJYYbYzafcZWS9UQXLPbpqIRg/Tc7xsa26i3zr
	MArzxNX5otzPpYwrdZu0CvGzPCra9Nwghji3mVvVBlfxXtXjL+t55zNZT2TrVavr
	7hkdUuvOfjDPaml7shA/N1BaOvBzIfFD0zB9uKVUHHM37RuJmvR13MOFzPhnGYAT
	Nhkj8XB1hA09ET1Cs+55oeJA6o01LO0mgWTFqIjSxwbp6wqKOd0N9x11cNoRTrti
	X/26e3/xsywbzRjx0lUTi51IKv80JSGs9d8/j+7LSu1NLeO0OeDFzQdsUEcaD6Tq
	oRkp1w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489b2a4uyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:33:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e800094c82so9152685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310797; x=1754915597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46HAWgvv2MxgQgdpENwkPzAKGo1621//AEpZFMkCwFU=;
        b=mH5Mvm1boINvqzfEGbXpAgEXILovi20AJZEd/1TkInSGvD4GYmmKYkgSSm0yJl9HGr
         DpCI/vIJPAx5AUT2+3b3i/JqNn2sVGK/pG0QH4tDNBivQ8MQNvSIfWPUkAqdTnwpqyxZ
         z3KE2KYVrS9Kxk2TmEp1OPIjYva6/cZn4kdLJBzcLlFVM6lhtLuI9suZfnAiKAmhl4yS
         ueZPXsP8db/lXO5FQ77Jp1OqNYaHRY8+G0j85jdqFNvg/d9AJOwZP5d9rCI/L0vdqDVo
         AmnLmVSyCl2RisMEfUumAfvO9VkET760xTscLJrhZSBKMc3fCmZe611JPUEhOZra8kD0
         JgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrg5c/Mwa0MRIeSy8pBDUA30wVXQ8QMrpZIbWuSH3QWpVY+1m0j1s8EHcleAquNRNgc9ftX4AAGZTP7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnWBle5ylNrvj5HgFElgi6oVYPSmZD5YTGQSQjMbFhYzb2U/D
	Dmv2RVTLetnJ8udT5PDNCPXFLAN3tjvHfvddJJUfFYabOjEGTW5RUVTaUkT+foim5rfTgBdb5lD
	VT/6fHbkywwmp8boMvuOIBSJX1Mnu9cmEZdbm4IsARtesoPgztzptxLetZY7GCVDaYWI=
X-Gm-Gg: ASbGncu5GUWK48IAFD51tD70yj4jqR8YecFU2Py1W+PuMDSxc68NxrCam+1pQdXYr7M
	Rwp5/5hk9slbdv0uKw/vKLlHaWLjZRP3D0y0ypuPLgxc0b/ijKbiyK9OFrAB3M+xq+FVx1+gM4+
	YSVKv0Bai87LzMWnMlgx2hDVjP9sr9KNEHcrPnFVWJurYO/JoetP320XU0q3olbBx7RwuWBsJ3N
	6kJm4AspmxwmgSvI97HxTmFJlSWoxptmQ5N+6piZgmaz+WkA7x2LPVO4s7zB1lsvW7uYHmzP4tR
	TFmJYJG5vqZBQMktFX0+ns6UPa0EapCHczkvhynyobVDxqW1EutkYMPwxcCn2P0OG9L7Slw+ecc
	ZqHHYXc2kTYsxNVrorw==
X-Received: by 2002:a05:620a:6087:b0:7e6:9e1a:1d with SMTP id af79cd13be357-7e69e1a0795mr468467085a.0.1754310796930;
        Mon, 04 Aug 2025 05:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIA4r05fZXfrH3ID5bH6u1l2Cc6ps0sG9WuleJWFvPFQHdK+8Dza/BZE8ttrEeY9KjyY/9Qg==
X-Received: by 2002:a05:620a:6087:b0:7e6:9e1a:1d with SMTP id af79cd13be357-7e69e1a0795mr468464085a.0.1754310796438;
        Mon, 04 Aug 2025 05:33:16 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm731035466b.0.2025.08.04.05.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:33:15 -0700 (PDT)
Message-ID: <4890c832-3b78-4294-aaba-b62735f7934e@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:33:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804112041.845135-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKwn3TaB c=1 sm=1 tr=0 ts=6890a88d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=vuI4R3Do2uEHNfh2jzQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 06Ha40mkUbPba7Gdr3rcQjhV_iWMjM5X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OCBTYWx0ZWRfX4uAygf2p5VXv
 NEBFNqND9PKmDK3BHJ+4EW++S0+P3uy35faRpSrrkEtXArI03YOm06AeCXQ1ru7rYbaw5hWehRK
 hbSR5N+TNn4xl5qkpuM3ssE021kXovkptefhXrzSO+Wo9lyb7DMmAUzg8gC6mnZfXZdUANpOiRv
 7uuRxVCTjEWib8dEBRYE2TmzVXzCxxDQL22GYjtKDjhujUUOAfQbe5u6kyTiDE+79npdoBsmdKt
 d+txVQzZLp7suFfDpwlhYp1hAaGd6abVsTKxhivW3HvCxoXpHvEckKr4galgkJNLRRHA7zg/+zu
 ZZVFGPFOWB3+8q2l+E4RJ2OpzpGoskB63fE21BbTkvaGOYti1494bP/LYPmQEFu9+jlfdQUkfYj
 LtuEadI9m4MKAg1K87Ebcqde7G5RwdZp2Iz5a5XhCt5Fp+LheAru+8DLTc8Xf4zcjBC71yft
X-Proofpoint-GUID: 06Ha40mkUbPba7Gdr3rcQjhV_iWMjM5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040068

On 8/4/25 1:20 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> CPU clock scaling.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related entries, fix dt-bindings errors ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

> +	cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2-kryo-cpu";
> +		opp-shared;
> +		nvmem-cells = <&cpu_speed_bin>;
> +
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1>;

I just noticed this.. I don't think we have CPUs this efficient just yet

Do we know some real values for these?

Konrad

