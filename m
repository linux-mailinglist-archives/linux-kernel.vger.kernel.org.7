Return-Path: <linux-kernel+bounces-773040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53970B29ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4851673DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B8279DA3;
	Mon, 18 Aug 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlF2kawC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995627990D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501807; cv=none; b=MyNR0YNTulXOhdkbM0uaHnaqNgYSqRB6jr+0fIOEI0AYDrk1PimecVG0BYCAP/0OIEo39FkjNzbADJwXiXnCNTy3wUs8NYIcUJWJj8nBbHQgBZiFL874TisJsGed7c6q+O4S9f1kwq9N1bdA5tmBySKS2lxgqSjjnUkGqjhLz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501807; c=relaxed/simple;
	bh=0171qvNEwhctc8IfFKLfbfF7b9YjDUBrifuNLF1OewA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I92DEcVK7F5lQipZqP7DMtg0YPDe/y6M1C3lWfgVJ6zi6VtRbPv0CnIErV7EqsAIQq99CGjOl7S2z85NfJ8fJc29NMF4fL5xPvzli5Gzb9/9i35qzC4DhpUyblL8vCwMwULagPnBFoVx4pN6dPFMKG7OwD64IbEujFGzOvEutAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlF2kawC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I6c6T6007903
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CljCLWxC3VuOUrt1/JUd1oMX4O4FgjwPAOwwS6aA++M=; b=HlF2kawC+j703on/
	tH5fytuhbAfUDjBtj0KO0CikZ2/NCfa+q9or3wRHbgqp13aUjx+Ud6kQCPRUpzBO
	9IveNJ1Y3to6RGWVghPNpGt8tPAeuuq59leOkbMqbcgUSoizMqyGpSdN/m2+N4Cc
	PfIYK65uQFyrOFX7EK9R0juooZhyIWJfz/c2Qm1U//3dps9ujo+qxbg4ZVaIstRe
	5nEB1W2xB5Mz8iCUczH85RGtwmdNHb92adpboptyWY+xlpZxse6U4KTAuL3F+odZ
	v+oWNt/Pj1bxVUQyWXrVykC64EWHpok9icoe4hgh1WpptpVuht+EK1gcxEEJrUoY
	Zq9xAA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj743qed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:23:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704c5867so1652336185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755501804; x=1756106604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CljCLWxC3VuOUrt1/JUd1oMX4O4FgjwPAOwwS6aA++M=;
        b=Nsrqc9FcdjZ+3nDVKQwj4OZzc14j1M3OlizZ/cey6gCh2mtQMn4uqYDRD+RkUfdXDT
         i5ZS08gMGt4hPRzFqTAQVx2rp4nBP6irr8tRDr51xwB9hLWTFXBX2KwSvcCVcQYzonRZ
         aHRquso2AFnHqm3amj/IKHJQaWeOGwbmTVNCydhIzB5K5vV3ZCRJ7fR15PpAbLpCKl2o
         xPXyn/qerD/mOxhOEbUU9qyBPGGS5ihA5VLFIwSdI5CDO/7NrwbTSq/AOCZvr5pUy205
         VgKs5Tey3BTQc2RMNnVBJufgj5R5dTTHIgTXopBcvXUQAFXBM7Bul9unt4yR06Jkmp9M
         xCpg==
X-Forwarded-Encrypted: i=1; AJvYcCVdOGZZVXzECRj+8uhZZq2KQQL3VEh6BhoKWpZ6lycHlysFMlbI5EgyfWxWfaTKAds/HNqaPvkFniBi6sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFO1pJi2RevU52GUgc10H5GwGG/yjQA18aGL3y2lj8/azb2uHF
	ZlC4NCXvZxOvDYKORKo48NR6W+GZbvbQWvMCzZeXxdUhl1vhVIdIIF2iUEInC3PQOInJE+sBSQC
	Rtmj01zSe0DoZ5aJNXp1bjDV50H3LGPWulPHnr42Tuz+Z2iUdoOyso8dDfEYZJHrXOLM=
X-Gm-Gg: ASbGncsRUFDR3BFBuzEk5eO2MekDk3y0peXLR8HEXfIlNsmTOjKqu5c+A4hbtvgBj8B
	ptbabMYO2bluE1Ld9Sya4Lw4aSi6hls38A0HcB5+JAZ0Z+g4Fz8Ctq9QppiTsToNPcqOkC1Zb3s
	ifOR8OT6jNUMdksjsPlxMo55UcsbT10AXObJUHFlEOMGEB7LRObq28Bm1EnWMZxcGE3stHJhMsA
	47XAb68hnrQHxX+2+SATOI97PBsYsM8gu3kmWEgNkTYBSi27UD4Lror0P16APp8KxcNbn/6Hnww
	gDiU/lMUzTTQRvHWKVZu6aIYR7H6SHVrn1Lubm8/0IlJrYfUBArXUuVzLmdW2Yf7tQ==
X-Received: by 2002:a17:903:b8e:b0:240:9dd8:219b with SMTP id d9443c01a7336-24478fd2a8emr122795125ad.49.1755501054563;
        Mon, 18 Aug 2025 00:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm7LsS8pR5b68tpo9G2VcNmUMBXY1NQ7esD+UdwLtswNRa5j63VuLnVBb7Rr2C4YZHwcX2Nw==
X-Received: by 2002:a17:903:b8e:b0:240:9dd8:219b with SMTP id d9443c01a7336-24478fd2a8emr122794915ad.49.1755501054124;
        Mon, 18 Aug 2025 00:10:54 -0700 (PDT)
Received: from [10.64.16.151] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54f8b9sm72276985ad.130.2025.08.18.00.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:10:53 -0700 (PDT)
Message-ID: <77067ec1-4f1f-45d1-8027-4c7a6f66ecff@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 15:10:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: defconfig: Modularize SX150X GPIO expander
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com
References: <20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com>
 <20250818-modularize-sx150x-gpio-expander-v1-2-c2a027200fed@oss.qualcomm.com>
 <43e2a824-d7a3-4142-9b59-416df0c0c2c9@kernel.org>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <43e2a824-d7a3-4142-9b59-416df0c0c2c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DWfVHq0NegfIL0q0B_tTW9fWBgjmRLY8
X-Proofpoint-ORIG-GUID: DWfVHq0NegfIL0q0B_tTW9fWBgjmRLY8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX3tZ1zZe3NZ7o
 0YJbKCIN2l0cDT0DHHgCZyhBEPah9wZZ58GzyVFFkIlah7MM0cF+nSoTYwZm3ov5BNy5yrfgqGI
 LIDeIT4wHsRGuYIaS19vSIEeF3Tb43VBSzwqjWR45GyPXjhhHjsR3BhA+FCCJD2WUfTFJeGvHqy
 RVTQ7++khf+l1s1Vdag2+8xD/2JTrDvQqhD9/jxkdb0mC9yI/ZSIEYr4Do2OYifnootogd8mbY+
 +LEZcMnc7sAMZMDDfrCZQDmEH46+IaUJaEdEkwT6YAWxZG7kpiY4XvJwgXZL7M1edDBUz5eJTNT
 mTEV1pZSyOt8DAK/6QMlSObzUU/1pSoMbFywHj1aWyDPxXCN8704wFVveF6JYKidSuEvDxGudXI
 MY3LSwqt
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a2d4ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qthNqDW-ekIAEVpD3OwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033



On 8/18/2025 2:33 PM, Krzysztof Kozlowski wrote:
> On 18/08/2025 06:41, Fange Zhang wrote:
>> Modularize the SX150X GPIO expander which is equipped on the QCS615 Ride
> 
> Qualcomm QCS615 Ride
> 
> You are changing defconfig for all platforms, it's not your personal or
> company defconfig.

Thank you for the feedback. Yes, The change is intended to support the 
Qualcomm QCS615 Ride platform, which is now upstream-ready and actively 
maintained.
I believe enabling it as a module ensures it's available without 
impacting other platforms. While it's not currently used directly in the 
kernel, having it built as a module allows flexibility for platforms 
like QCS615 that may require it in future use cases.

> 
>>
> 
> 
> Best regards,
> Krzysztof


