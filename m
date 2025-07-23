Return-Path: <linux-kernel+bounces-741960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E4B0EB40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFDB7A4ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68C26C3B0;
	Wed, 23 Jul 2025 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CI6cHYjZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8C2727F3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254281; cv=none; b=Bx6FZ4D5tlEKKuncjkNuPatarUbU8sS4tlzlDFRbvmCyOLQ60ep0NeLZTG+g76YgnsCcupnZzsJajrvxZVUiGdVj4HmAiTjfIwtxWMwJGOQyuMpfyhn6HJpIBZLPmxsWKOT8P4niw7J4hFuMc8E/zexRUUG15TcKLxabuyWu2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254281; c=relaxed/simple;
	bh=PoqcbJsGpwvHEHRaYv9tGRmPiuuf8WpUxuWrdAv1enk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rk0LsJ4kljmsTeRIgHY3eYAgPeHVO7UJ7N8WPIThT0poKUqs1F9kCxZdzW4sRBzagE2ax92MjPYwZxCCNk3ZWHZei/Zo2J9naZVI8DRYL4uLdyrFtshL+hruFlJ5rbNlVvSs0rmFMWNASRUCv1UZp36IBL1srGF8vCdj2VfgnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CI6cHYjZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMOfT9024777
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vH6UcnPPc6AgAILCvjIhfjZbNXQE5ix/Quz8z4LXSmk=; b=CI6cHYjZrdwPRlfh
	Hz4bmDHKcCXUe3Q07LIjxYFPD6utjV/v+e35ELYDZ2r5EhLpAy/cslLbxRN3oQjz
	NVoHgVhAO15NIESgms+VvR/uDRVy7/N55cilfJ6W5n7aW80jVEUUNqMED0gZPUtt
	WtjZpWNbbizhhde/8/r02ROKsDRiEjymuDf11rwGFOFmtZObnLy5PNjd0MehumQT
	AQ/E7pfWW7PhRHu3Ke2wgrXAbJp9NdUaEUV7AQvr8SsgXE0KLdH4J82qcQlQZM27
	9j/n0vPGHsjW99AhV7mhYPp5TNcKueZY/jgPwZ3cSOcy6BFFplyxyDFCQ8V31t/7
	k3pq4Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dm017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:04:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2354ba59eb6so93610385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753254276; x=1753859076;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH6UcnPPc6AgAILCvjIhfjZbNXQE5ix/Quz8z4LXSmk=;
        b=nyPELlHZft/69TU5Z/CQe3ihAc8rvCZEkY7MOnoheH3sDxHhunMQgPckwRctxn7NGk
         oOPFZgeuBq18ne3PsboqgoDxhUVroY8BmFFjpdx/f9Es4s5bCLnUDnqf1MIj56n9GKka
         loqt4/pb3D/+XTLQAQBfN3tTDvG3rA8znrn4EZ0du+cZYh+kHh1VIoSIxRYbLvIdidNO
         A0OQF3OzIxSptzJ4S7/EvWeId+G42GWC1Ng1UavISnr1am4H93g3q44JTZtNfqwGb/Yz
         /HgYpoBgRQaNJKL7RwxqC/MXp2gQdNIe7cjX5rz+NzVd3SWF0lre5DKlo2LkNKHqNB1V
         k7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcSTmnwLbJXvlvjMWJDCf8COE081U5zt14oCQwXOh++t25er+YEKjGOfF6SvgWvmUCnlhZVAlNaBLZ6ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEj/cFnLTJzqpySCbgTlXMIoyQLsxFVGvS19WcYwh1BX8xD6mh
	ams/gXqqSQnuxDQJ2RldbBU5brb1RWd4mvYDoaYj9cGecEuJuunnUFV0K9QYZZ6BIPtNX/CIXeq
	IKoVWOkO8xuVeKHsTmoYIhC1Gl3w3n9dXaJZCgyYYHxbx9eeT1I5+h+0Kj1PRN3p81ng=
X-Gm-Gg: ASbGnct2XjghScdsNP48mMpiI+EHCfpJXJ5UK9OmjJFdI4HZALQ8/dLALG+Y1ZmtLmB
	mEctJBPDsABGmlGoHPApnW1wxpghXEmcOO5BfbwkP9EpXJaqJW/wqVw0Ya19f2sLtidxXNS+6rE
	gaXrbs2HGKb6PH9T5Pmdn0rXOL/GyFnAJu/fUS50FKBNy7fAP4rZbbK9E6T3xgw7hhRPjhLqxn9
	1cI0yUovkY9K8bsBn/hU4OYXd3/3/hXtqZjslHxLTR/G2PrWI9GwE9LbRvu399JsNu54xp9zwxy
	o64PHaJOK3/Zy+71/A6LZwKRWy5eF2n5IsrtMWLMY1c7+ea8+pCrAT8CcJjvx4SMnp9n+8okfv6
	O24E1PgU+
X-Received: by 2002:a17:902:c943:b0:234:f580:9ed with SMTP id d9443c01a7336-23f98142a01mr31946925ad.21.1753254276036;
        Wed, 23 Jul 2025 00:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQQHnDxC0IpogQNmaCVUpDYUfW0d0gC9XQA8tMK1P98ASHk8Lii3GJrd0WTMJHT7IWRGOoZQ==
X-Received: by 2002:a17:902:c943:b0:234:f580:9ed with SMTP id d9443c01a7336-23f98142a01mr31946455ad.21.1753254275590;
        Wed, 23 Jul 2025 00:04:35 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e400esm89793775ad.47.2025.07.23.00.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:04:34 -0700 (PDT)
Message-ID: <64febbd6-abca-4ab2-abe9-93812bc115cb@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:34:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5424: Add reserved memory for TF-A
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
References: <20250624-atf-reserved-mem-v1-1-43b1940e2853@oss.qualcomm.com>
 <0826de9f-0125-44d9-84cd-1c52ba199a4a@oss.qualcomm.com>
 <7d641576-7ec7-46f2-ad53-e0b8b36351d1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7d641576-7ec7-46f2-ad53-e0b8b36351d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=68808985 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=YISUMjRIwNUwlFPiRe8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NzEuXFOveNZ08h7ivQZqqw0lGAC2HI3I
X-Proofpoint-ORIG-GUID: NzEuXFOveNZ08h7ivQZqqw0lGAC2HI3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1OCBTYWx0ZWRfX8dai5lT26bof
 0zxkKM0KhCWQVbgDd8+6WdqZ1/93atc4FEicCKvuWQscXsCXM0S5es3pbeT8b09PUydc7ozerEM
 ZvHPLjGO1sWF2h7cHUEVmxrkq0F+oZfMZa4yjCRz+drgu/TT9/FNYfbnN5ZnESc3XxQe5BY2UVl
 cn2oki2DB3TTIOniyPiMUy8ENl1BnpvW8CImHuceYzaEljuYPv5WTvd0EJk0epOMq38GprzE3Ek
 KoCyWlY7d5wHPtHfqOy5FFa6zz+jfNnRy5U2ihoOEMaHCNox951nyMvh2QvlNM0sbLSpVNLvia7
 ZgxjuCNRVhk2cA2Q/RiJGMK+udgqxm2aYyHLIon1upeBfRV8nqlTPku1LZ+RZuJARfVcrUUNcc2
 MDkMSxlsp6L7IdFCAq3yd6tXhSlkqz/OG1BsPU0TGVGbd4Q7PJrfT0Yklny8BvdN8Cqv2zAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=494 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230058


On 6/25/2025 10:20 AM, Kathiravan Thirumoorthy wrote:
>
> On 6/24/2025 6:57 PM, Konrad Dybcio wrote:
>> On 6/24/25 12:36 PM, Kathiravan Thirumoorthy wrote:
>>> From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>>
>>> IPQ5424 supports both TZ and TF-A as secure software options and 
>>> various
>>> DDR sizes. In most cases, TF-A or TZ is loaded at the same memory
>>> location, but in the 256MB DDR configuration TF-A is loaded at a 
>>> different
>>> region.
>>>
>>> So, add the reserved memory node for TF-A and keep it disabled by 
>>> default.
>>> During bootup, U-Boot will detect which secure software is running and
>>> enable or disable the node accordingly.
>>>
>>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>> Signed-off-by: Kathiravan Thirumoorthy 
>>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---
>> Can the said u-boot simply dynamically add the reservation then?
>
> Yeah it could have been done in U-Boot itself but it wasn't. 256MB DDR 
> configuration solution is already shipped out and the stock U-Boot 
> enable this node to avoid the random issues.


Konrad, Do you have any further comments on this?


>
>>
>> Konrad

