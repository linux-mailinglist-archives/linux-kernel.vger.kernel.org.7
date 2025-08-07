Return-Path: <linux-kernel+bounces-758935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7F1B1D5DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C33D1664BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B218FC97;
	Thu,  7 Aug 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddF2XvkY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689A42AA5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562823; cv=none; b=WEpoCyEYvEfk37DUzeXZNJ2FoniNCGlA05q6FiAlSBoCF38kV9DkcByf3aGI1E0YuSwsyOEnf3VIIzyJj9eua1ZvDnDfsYyc81r236Sz2yuHzze0+hejowQ+uMUNpO35Qx8kEEQsCN/n7hVkNgnyX4f7Gcn/w7IEqTRivJdEHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562823; c=relaxed/simple;
	bh=aRfkNpM//pBU+oYZRnw2Z6WAeGX51uxS/BOb0CAPA6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAXoBKEO6mNXuuf4HUkOqenJZwckC8LjTHw2VThyLsAUre14yqRF4V6J83DSGHxLBjUfTGPr3xHkKD+TEifegQkDAMaRDmQFBRF5R3Wux+zXv1igKcAqgjDSFh+Ps3Dyy0V4d1Mz4ocfXDd6A840HrTy3PGvgeHaFXC3m0RlEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddF2XvkY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779Cvdh018698
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 10:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yj4wYlTbCwxe2PSZY7rFcU9tQhw7WtnXz4t6GtIJ6mA=; b=ddF2XvkYouSbD/jW
	I9Gfw8ecfrNOno3xqLGPTcI7vIADoEwAIucXcHMemYaKY3xtPVNzO9gXQwWSOCjP
	Fu04Ld7vQUm3h1Bv5fcB9qBTKCaUsKsuhaa96r2Urc6tvQLfbEXE9GVUcupG9rG7
	QcyaPmDB3kyQV2GlLrARQUd9ygcjirEmq4yGzm9CSdWEaf+g5Ps2SVRU3Upj9KH+
	oiLMs9H3jaJQE0OvkTaW1eu1vwpnbAKXN7W+o8sQYtY9hUNeuVlyAfNsJjR2A59A
	WiOydk0b35h3AlEC4VBV1ab1HCfD/O1hmD/hBJ/NLeaKrFK452wNLq3QRg0ZSqgH
	x2y1iw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8dxuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:33:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76bf8e79828so1863727b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 03:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754562821; x=1755167621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj4wYlTbCwxe2PSZY7rFcU9tQhw7WtnXz4t6GtIJ6mA=;
        b=YWtnYYtXZmYDZ+O6fVyT/JUIhGaZsPspIW3a4IrWBnOHZCn+ZgUOsoZ9tTAGnKZlgN
         RKLnglQBuCURDa2N0sk4P8jfgzKfvhXi5+QEVcB20cojzTTX63IU/rFaQujZL3Jg6jem
         ZA9DBJJMuVH4CVxAWbZGMukFtsYqvjkGkJvuO7DKlb9+MdBWNHkczD1783z8ManQdanb
         pHGjdHv5+gGlhGiLtGDWCenA8LxgCFup3DAjUl1WmohH4jzw7p5SqSMytJ9p2GvWVfHt
         Nzcxh0jS3YSKqGtWal+IKu3c20t+cbKy6CUUCdLXMQZfzbuqrq1aKZf0V3Js+NSXvXlt
         qFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfHNKpU8dlDCLyZ7tsiMQZKd/E/o85vww+6OT2IfLGbthcvoROnagYPOcz1kG200HKbAvFu3xr7c82Itg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORzkEXk7hwRTJRUMmOtO1OXAnuPjNtaoUbX9Xux1uoZX5Jbn2
	irvKdpLxO5a2CMIiZ/R2JEVekTStunkAwN6P+3wREV4v8ftQMev6OLUOsfsmT7dyGxvpSbtuvOZ
	fbH7m4OAD772gBIq2QMXug8SumpMnBLgRguT6c0UryqUUJQRaptstgCb2Sv9odlp+i1k=
X-Gm-Gg: ASbGncvfjWrpVh6E6A0R8e7H26vZTOW4dbPdt7km2e2tAJwzAt0rrnlGwL6/BU0Um2w
	K+D0D4JGthvko/kPQ1fKBinnH+rQ6cgALuuhBtuDNSwx3RvpswinYsjLJ3Hc5tWKRSrFkCodObt
	46HycUDnlfrNHzL2HsG+ezxQFPQrh4YywGoMQPXP+mbY++UaI2jUodM2TDif9bC4DipGs0dB0LP
	9H34Wh9rI7F4hFnEo90el9Na4ZLnlwTgnLgu6CGEUWNYkPw5eqpi+liLl2Sx1/o3Jkf2uYe7Jf2
	h6OqQroW0VQpIMrcThHor+5lK/Q0F9x+ZpzI5u8A1dGEHpmrC9C9U0JIAqQwLaSXRmE9ppYpJI+
	29F6gtIsp
X-Received: by 2002:a05:6300:218f:b0:240:160b:81bf with SMTP id adf61e73a8af0-240330504demr8438048637.19.1754562820797;
        Thu, 07 Aug 2025 03:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhYvbZOVRKIjkflKJ6i4gZ1vDxK7SFCJ8tqdD4ynpxPyraozOCdxExCiCicXthuRRWP2JZtA==
X-Received: by 2002:a05:6300:218f:b0:240:160b:81bf with SMTP id adf61e73a8af0-240330504demr8438021637.19.1754562820406;
        Thu, 07 Aug 2025 03:33:40 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm15502209b3a.6.2025.08.07.03.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 03:33:39 -0700 (PDT)
Message-ID: <8b262389-3c1c-4618-9670-8de86751c83e@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 16:03:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5424: Add reserved memory for TF-A
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
 <64febbd6-abca-4ab2-abe9-93812bc115cb@oss.qualcomm.com>
 <95959a89-655b-4ac9-86ba-d8d943809b6b@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <95959a89-655b-4ac9-86ba-d8d943809b6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X59pyCjEg3V9dfeJcjSGxb8cxCZbenMj
X-Proofpoint-ORIG-GUID: X59pyCjEg3V9dfeJcjSGxb8cxCZbenMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX9EaCD91nQ5Zz
 H4EEc2WHah0/dsWsfH7yop1lWyAUqGBvzp2w7WPBq/9qIFtVpCHe8YSn3qUz4xFjgNEaurpGUff
 xyc4g0vTTcEF9SGnNGkbewnOjuUkuTfo9tuRdx9l+LM6btVo/GdLzHj6LSZbyxFsb8svHPvSS2t
 J3/nsyGk4Fp4MSvYqPV63hIZCsDSFWlSOxq1pltesYyv6ETaTfplpGLsidOcgCKmAPZ4Q1Q2iQd
 QPm8zt6yRccrehd0riUTLNd/SA5NLdEBIy62G0B5v5k/R0n9c9DYaILh9wykYieCOLzMEXN0xOE
 QgPQQbJ4CfdEudbsDveZuD7Pj5EIkvscgdajbf5TjWJvBbuJNAwzpdvV0EEd9PyWk5VwhGM1kq0
 9DUc18cx
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=68948105 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=OAahIlVLQCIYRdnnqX8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009


On 8/5/2025 6:52 PM, Konrad Dybcio wrote:
> On 7/23/25 9:04 AM, Kathiravan Thirumoorthy wrote:
>> On 6/25/2025 10:20 AM, Kathiravan Thirumoorthy wrote:
>>> On 6/24/2025 6:57 PM, Konrad Dybcio wrote:
>>>> On 6/24/25 12:36 PM, Kathiravan Thirumoorthy wrote:
>>>>> From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>>>>
>>>>> IPQ5424 supports both TZ and TF-A as secure software options and various
>>>>> DDR sizes. In most cases, TF-A or TZ is loaded at the same memory
>>>>> location, but in the 256MB DDR configuration TF-A is loaded at a different
>>>>> region.
>>>>>
>>>>> So, add the reserved memory node for TF-A and keep it disabled by default.
>>>>> During bootup, U-Boot will detect which secure software is running and
>>>>> enable or disable the node accordingly.
>>>>>
>>>>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>>> ---
>>>> Can the said u-boot simply dynamically add the reservation then?
>>> Yeah it could have been done in U-Boot itself but it wasn't. 256MB DDR configuration solution is already shipped out and the stock U-Boot enable this node to avoid the random issues.
>>
>> Konrad, Do you have any further comments on this?
> I really don't like it, but fine, I won't be blocking this either..
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Please make sure that the next time around the bootloader reserves
> its own memory and doesn't depend on what the OS decides to do


Thanks Konrad, yeah we have a plan to mitigate this one for the upcoming 
projects.


>
> Konrad

