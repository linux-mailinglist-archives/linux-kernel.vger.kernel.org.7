Return-Path: <linux-kernel+bounces-727543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD67B01BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9365A4491
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD5298987;
	Fri, 11 Jul 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6k/UOfc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59523ED6F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236134; cv=none; b=d+73R+Fak44IwehUgkzHZuNGkyVyYZvQplyrZLFql1UakEfFTgQ1iSqhvBThjASZPZamxogfVHzSi2CmUqORMbHLsdS0o51juUc4FKQCmSsCPvop0O39o4ebZCL94AZW1OT0guekANSsPBU3rtLr+tdT4MJbq47AB0xKiEI2k+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236134; c=relaxed/simple;
	bh=Xjn5ySGEMA9LsrxbMTZ6SdqT5i31QukUV4A0p1xnku8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr7KATpkN7RJlsKEpBacqeKiRxDt1p++WdCNGNeSLhOwc7iTEzwQ/nZO3dBAsCi3Wvs+djBsmg3nNgPHcq+5F65VCGyHUE6c5MEL6VWnWvzAhlDRuHVAGQSyE2D1OTw5NUqFxkhIxlhLW06PLf1eLM5eYoJo3wRH3bvK+cy2kzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6k/UOfc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BARt1n018181
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WmSJVa8+LyzMZ7AuALMmZArLhe9+Oxn8lyjPgHFxns=; b=g6k/UOfch29P5CwI
	pqtIbwhQNYh5wJ/FG+d5qTLMv3uOF9J4rZS8PlXlw4ARvQYZ96QHgm3DQFKi2uAz
	v8rd+pwUwbnPMKXl/IyIel8uZh8YOw2CcTn9SZQMGQyQleDmkft5vZE2lYuss0/N
	0HZWFHax5VC52ZJguWDzh5L/tBw9jOjjEMpR5Lieo0mOqKVvvdSTNqTuckwroswg
	MvPwRtZeg1AAEOXG92f9aU+B5xtiRvfVbzo2fVY5JIr+qidvo+E3IboRLrDrEVtX
	3H8NO0Ot3lxVFcNUvMbC+TThfLfawJliw6yrbBHTNGmVZCRiUyfBfZX1oqLCpCda
	FmRWPw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf32dn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:15:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7deca3ef277so20311685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236110; x=1752840910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WmSJVa8+LyzMZ7AuALMmZArLhe9+Oxn8lyjPgHFxns=;
        b=V7TwFnI8yOau93Tr1mH+SFmNXRM0uAwjXtfLyheHB/EqtcQeS5mQ5zHhIt1Cewi+Kx
         UFqRSianazEuAtzrJkFIodhCLI91AS+WqyecguExJ5Y+ThfXz6vozg4cx2Z4/78vwkP6
         zHoAzKiR9XuKpQSsYEQt5SrHdwxXQH4y8MJrCEp8okVkBD9O1+VwQSkvdtHOeqHCJBgh
         G9xuUkWtaTknRSXmQ3CBHzXcndapk29nCa19lg8ma8KmqUzXYwa7J5mrzuKJMsy+nTaH
         7+eJwDmiyBt0CYO4cJ5y/kp0ookFcYli5GQl2s1RG+4q9KGRIp3WlKNMvjrt28og9T2n
         q2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF5F32gTXN0TM9UMPcmowulSBmJGpj5xmpgdamqSNBS7g5vxQPx6ntT0V+P0fecFQMMMS2SD5AG9rRzvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9nWw+M+Nh8Rz5hyg3I6jX4BwO5WPTPYj07mEprv5D1L8XfqG
	yUiyrEtjkR3aVW0aSgjTMpvYzd2sI6m+RJGU6mvOLY74rdcdvPPAz6SxtUxz366zBrelD2ONN9X
	TIJEkUv1/DlJRzKjuOhSyNhfmy1d7KddxS76Hr/X6k28RGLA99KpfIucGJtK/HXyZies=
X-Gm-Gg: ASbGncvtA5MJga6TYYiefM/g2eKMzz50fqzP0KJkSa38U2/xtD0x4vREw41NPpQ3Qh6
	dhLvK9m9wCF/YCcr3is+fd4LMoamACwxx1rl4844OTfCZNSay857y6XRSA0NGOkhyCREVhc8x5O
	2ehtMkhSWFZofZTbw+jV1Ab22UP3k5PspjpTSDDSgWeH2uRcAeL6rZwE+kYFJwf4ACasHUxbCjq
	xsjneO6nv2wId19nfnEP1X9V3Laha5UXKP1CuRpPsz4ncX0Zi+mhWjwOoeT7dSbcjw7jQWaZOEC
	0GBvkJIXIIg1/XJObS/RAJaSTgaYG1d2iX60nveyeBy4J2SiGaHZH6Re4FfOPE0xHlQlCwzJog9
	Eo43sQwFLc32RCouLwNXl
X-Received: by 2002:a05:620a:438c:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7de989b3079mr130007985a.4.1752236109093;
        Fri, 11 Jul 2025 05:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9IlpHxAb7R4TrzGfVeGwtAC/FU5V/+FMIw/QGwRVWYeM3sTSRsEHYiAI4QhJLyZVlXQj3Zg==
X-Received: by 2002:a05:620a:438c:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7de989b3079mr130003685a.4.1752236108508;
        Fri, 11 Jul 2025 05:15:08 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82964f5sm293248466b.143.2025.07.11.05.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:15:07 -0700 (PDT)
Message-ID: <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Rob Herring <robh@kernel.org>, Luo Jie <quic_luoj@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
 <20250710225412.GA25762-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710225412.GA25762-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NyBTYWx0ZWRfXwN+baZGonTVg
 f2EBEn9arO1MZ/oE7WFBFAkrX24OUcFp6K8rTMiO+6pwwR7ueN7+5zq+2yF8zOo0Hr1OAMGID97
 I+M9xAtY8Jd+SbbajNnYoH9WkfynUmgjlbmHu54TZAjJqCIKauEAJyVAFzC1RFmMAkmOIRwSgdi
 mLoEXJfWxPuXsd4Wvalo2RUzMsIHcVX+iXGhjIsOiwhgcm6kWiD3GaPsAH3qFfDQisQvPU+/ZiY
 aFTHhJsREsGfE3jFuSwfz3fFt7w4UOM0yLwHYmscnFrm4oqGBipRO3wJ7dwzwrRomyvmCymK/AC
 /2m0VDPSuZnkAPvTJ24VMisLsXj5EiYY52RMPrOn2jKgLyz/gUNiwvZxi01jXMNn4lEjkF+b2+T
 AS97Eb0sMssU/Z4R1eo4SsX4417eUSX1Ifdw4w8qLMlRKVtoLJmSfQJsZpOhr8ObIHNYNwow
X-Proofpoint-GUID: 4Hs2gIGJY3P75VKBTrCQhIpkyAt4MGHh
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=68710064 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=icw32r7lKnDoEl_Wh00A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 4Hs2gIGJY3P75VKBTrCQhIpkyAt4MGHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110087

On 7/11/25 12:54 AM, Rob Herring wrote:
> On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
>> Drop the clock rate suffix from the NSS Clock Controller clock names for
>> PPE and NSS clocks. A generic name allows for easier extension of support
>> to additional SoCs that utilize same hardware design.
> 
> This is an ABI change. You must state that here and provide a reason the 
> change is okay (assuming it is). Otherwise, you are stuck with the name 
> even if not optimal.

The reason here seems to be simplifying the YAML.. which is not a good
reason really..

I would instead suggest keeping the clocks list as-is for ipq9574 (this
existing case), whereas improving it for any new additions

Konrad

