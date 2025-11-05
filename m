Return-Path: <linux-kernel+bounces-885909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE6C343B3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B593B2625
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05AB2D0C79;
	Wed,  5 Nov 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGL4kMix";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kro90Op/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F1263F2D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327831; cv=none; b=bx/fWGbMv1ColfsU4H2A8MFqLS84997JrEYabG7txFGg0WaW5HQY/0cM+EiclvwhefA4XFC9rgqvGZW1oib+y9Z6+EPkAf94VQwGkqPR6m7yCDLYNIzjhtEa1DYJfFUFoFIhxy95SwuSxV1ZbH3pjx5VOp/u5180Nt/zVn4oeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327831; c=relaxed/simple;
	bh=YREQWGc/2Q767XLJHCmFYF4Zsta90az+yMFwmM0kJGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dh7iEjc+WGHDTnUi79cyJ5F83IbyKHkhD+xAB8SVzu5uPM9XcbN7Lhhvs9wz/ldYkzB1QSKkjmoM2dA5dzxKG8UEVteHvujcg2pS3DLzaEhRtQJaGuzrTE1v4SnG/GGO71IJqoYEy9aMH7dVpq2wtlA1bDeizKgIgbpP8NfLb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fGL4kMix; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kro90Op/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KfkNQ3049610
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 07:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QT+WeRl22khRMpzgXolFoG5vQrtoq+N22GF4lGmy4FU=; b=fGL4kMix9e+yJyMz
	udj6vjMtpMqJU24Uwj71003LuaYyBXZsrR8eunApkjJC8Yr7ZjjfxjP4behokjdb
	G1S8oXC3Nsl4tTBiBpGTOEZbm/MS4aoamWwqkG+3BhKqxHD6tYoQA5s2Xb43Xvq4
	86hbZguRYF1e0/Ou21fi/h2uz6goODr2IPjlel2m6RlUcgX4zMjObuFWPiMPNX99
	XM/SHo4Mem/JiqDn+f5BDsDGOBHu/5D3xi9nV5ukR32bzoOFq/tPx4i8FRmEZvGF
	BHmUV1E5cO5II0OoSUPbaeuH2HeAuhz5Y4Mwof6ugNzDSG2NZgbRPmrkovCBwQYF
	JKcwQA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ex7ufbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:30:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295595cd102so75663485ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762327828; x=1762932628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT+WeRl22khRMpzgXolFoG5vQrtoq+N22GF4lGmy4FU=;
        b=Kro90Op/rwoIScLoMM5iPujmExL7syb3VmeM9plCesAuJF3jX9mclKwFHhCvASCIW8
         KBmO0JRNXWbPPfGCpcLQVR26Cyd848T6FYWe4qRYuNlRW1b4UNF1JiSc9ZRAdvM7V6Kp
         gQbxquiyGDlFPdqBDkyWX9TUru4Dz2TCfg2BlVJEiKRX4Rh2KF+9YKZHF1Uvv6RoHsOT
         0NE2gyPZO/VMCyvFDanssVZ+mWdu2eX2NbBVpD8kvWKkNl4E/K0FSuYhSTtKpIu93tf9
         pKfihyMeWXpmeoFk9tWctihkaXPPKXPTTttjRNgwf+ohb9W/PdWqL0LtXNIUeGRoPJs5
         Wr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327828; x=1762932628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT+WeRl22khRMpzgXolFoG5vQrtoq+N22GF4lGmy4FU=;
        b=t6QZ9dBgTF5jB4V4eEjjI/PybWB8FJPOJfCylT+TYt/H3RzFXv0UA0lVJvcYo52xfg
         dXZcd2qpbOd95KTWO/cs6TH9NSliL8Qfdx/DNBBIesZQSLm6qovFx4bBBEjBBWmJ0iLJ
         ABm8XbWMTR1oP6QdGBiusAlBcuyOELMV5I9DQ8b0aea9n9D593i8d5Dp9II8kxZK8RLu
         i7ZvGe2eBzFc4GlQlHHz/GBDgVOp3Upl4459xIfWUVk+WSwUD2ouKCkpfbpBnAwAlsUh
         jC8em7fUtb3v17V1CHqz/XjFP96F+jx+Ut08ZKbOzGotsYv2xDea9FqKSuJQHOdLk9OV
         ZZjg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8uQFM712qSkez0t3Ac5rd2i9bnIRhvuvllP4sCOoL14GluuHNkQyyYvBKmh9ri+aIycoYwT4oErMkVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwx8/H1IK/t1loyAT7wdEKHtay/tX0V4xIecSxHKwEQLN5xg0H
	8uuTp5OOP18tYZK9UcRBI5/29CYN1Xee07UxLqOQjxvBWFTkHyuwzizj4BMJ0gKh5BSVQ1gi7cr
	QpJZ2Pz60tdsLbDYQDvGAj1eEvoVAjZWenvUj7Y/O5k+0iFP7fPaQ+odmx72xGzMdsWI=
X-Gm-Gg: ASbGnctWDHoomR3mggx0cUPajHyR5J6rb+Dq2yo8GCDAgHx3WSb23nPeTUny5uVi0wA
	O8f6Fz1SuCYMLPNbqnmnDJo+/J8YlK1lgPGqKnjfBTIip8lx/amkhhm7cb2grkPttpTzdMvhhFh
	V8T3jxl7EnG6+Zt7DRNderd/MmdmVSmPwxTl7vCtFrYfW8w+zPnpioPKxRyXe0rvvF7HjDagW5m
	DIfYJd0KtxhD5NIZLH/1V/7bIvOJhD7RjTsKb9fAv9C6Ce7+8W4AepFCgz5IbPQWtFC97vmNXKK
	HunZ/nf0X93SCV8CdLQ9dgIDlG7JcLDuDeDtRh6PtM8mrQUsgO/4C6HqNRjBkA6mRRF7ztvOXuE
	G6DVpjuLe+qN9jJaxf9nF/anEpecixFyoo7dlpjkrXDR+kJNLk9ZGQ7LuK55haUTfQVlt
X-Received: by 2002:a17:903:2348:b0:295:9db1:ff32 with SMTP id d9443c01a7336-2962adb2191mr34731105ad.48.1762327827923;
        Tue, 04 Nov 2025 23:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUfAxppeC2gM9zMiAF/5d/xEfVFFICiIOTAgszVGo7fSvW3WzHOyM/ZK3homH56+oZ20mO3g==
X-Received: by 2002:a17:903:2348:b0:295:9db1:ff32 with SMTP id d9443c01a7336-2962adb2191mr34730705ad.48.1762327827308;
        Tue, 04 Nov 2025 23:30:27 -0800 (PST)
Received: from [10.133.33.93] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998ff7sm50804145ad.44.2025.11.04.23.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 23:30:26 -0800 (PST)
Message-ID: <a8586851-7f71-43f8-a1e6-6f8510c2985a@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 15:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] arm64: dts: qcom: Introduce Kaanapali SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
 <36fcea98-06a6-4ca7-a378-77b44b196a9d@oss.qualcomm.com>
 <7fc6ab09-44c9-434c-ab19-764c74b1176b@oss.qualcomm.com>
 <7f8aa7b5-40b6-456d-8b33-0cd505a6bc3c@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <7f8aa7b5-40b6-456d-8b33-0cd505a6bc3c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MyBTYWx0ZWRfX9T0BmZSgqhQx
 XxFt6HepMZ/lprPiECsJ0njb/TpYahJ/DSlNjHs4bhJ8ogBiOSSoi5R5P2bhqPMTqqdWUc/qXJT
 xnAioTf8Y/ZiX2lnYahZWevGLBcS1kYlnSpxUBzPXXWxG5ORfLwSE4jPiAFRiynb9rS6yKtdTqQ
 wwRZR94aRuOMjLT0kqDKfwylC56IMWxglNPH/n1g99A7BIuNd2HtwDNbWfRnA4JrAHjFmSbCgzg
 TQMA0CYeTdpsuzntWwFuH6L9tcVbYehfaikSW4hv4PaWhiaMa3Yq7s4qE/N/laa9ySfHMgDPrKJ
 P5Lw2tjINq3JOJwZHPUKCy35UC6/9EF6RoyZVKRUiYslIQa6OlfdjXMARlzMPAXAyVq4KvQR/Ec
 +vyqLAAtWf8ilauv7SfRtEVHuYeeMw==
X-Proofpoint-ORIG-GUID: wupFUcooDcDuX0Pd3XIK0nvGJSqSr4D9
X-Proofpoint-GUID: wupFUcooDcDuX0Pd3XIK0nvGJSqSr4D9
X-Authority-Analysis: v=2.4 cv=auy/yCZV c=1 sm=1 tr=0 ts=690afd15 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=kzD8ydeIdvGHlAoY_TIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050053



On 11/4/2025 8:54 PM, Konrad Dybcio wrote:
> On 11/4/25 10:04 AM, Jingyi Wang wrote:
>>
>>
>> On 10/14/2025 7:46 PM, Akhil P Oommen wrote:
>>>
>>>
>>> On 9/25/2025 5:47 AM, Jingyi Wang wrote:
>>>> Kaanapali is Snapdragon SoC from Qualcomm.
>>>>
>> <...>
>>>> +
>>>> +    reserved-memory {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        ranges;
>>>> +
>>>
>>> This is missing a bunch of reserved regions which causes device crash when you stress memory allocation.
>>>
>>> -Akhil.
>>>
>>
>> Hi Akhil,
>>
>> We will not add all the reserved-memory in dts, other regions are designed to
>> be added in bootloader.
> 
> If what Akhil says is true and Linux is crashing, something must be
> wrong..
> 
> Konrad

Hi Konrad,

There was discussion about the reserved memory in QCS8550 change.
And the conclusion is that reserved memory regions which aren't relevant to
the kernel(like the hypervisor region) don't need to be described in DT to avoid
memory map change and update frequently. These regions will be runtime added
through bootloader.

ref:https://lore.kernel.org/all/20240618072202.2516025-3-quic_tengfan@quicinc.com/

The bootloader we currently use for Kaanapali has not supported this, and we have
solutions like add temp change to add these in DTS until the final bootloader is
provided.

Thanks,
Jingyi





