Return-Path: <linux-kernel+bounces-856004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A6FBE2D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B71A632AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C282DE704;
	Thu, 16 Oct 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6fpOvo4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5B18C31
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610804; cv=none; b=PrJE3mQZSTQMYpaQ5QImb9t6drAcxOQULJbGMlcL3l/Jb/YiWHI2OKKqbGo9pGG2+llAgz4UFe0NG2lHu3X5jrZyOBpGcTrtlYaPHa5c1l5e/GcyXI1opTnsKCa+gR92ZwGde5GGY05Rxtyc0GyL7Kc1I53S2PRtkG/pH+x7L3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610804; c=relaxed/simple;
	bh=WFikhz7ZRtIbncmZ1wHT1zy/N5DaaleJOyfpRNbdok0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mccu5dMcRmtM1/igiA3wMSZPUKca/edmB9qlEUgKlxmAJd4T7iqhbIdU2O2GTel/ZliN5NR6czVvSh5q+sAn3SF436wSWpRZfW7gn0dbc+dtxKQW2KYR7SK36FiKOAZVAF9lWryW+YYXw9XeUSzZXIJFAE17Tm2nNFxY87w8694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6fpOvo4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7TDV0002496
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7US01srTXfkHjr5hd7/lzike6tL4rbOPwhEWWKSwns=; b=L6fpOvo460KhSOZd
	IR1UNC51UDHLG9/U+HSEU7Sn9EXpTTvXH3GWmp7Ms949QvaVNuquvgHcfEi+/zjk
	yepd+WwUIb0wIcbfdk8KJWvwwQfFZiHjzsmtTDwtsUlTlv5bXLzq/lJzDHOPyhuZ
	r/TQxYCThokuZGANSVcrvyHjpPi24yutYk/FK3LjsxocD9w4+D36P5jKSTqWgNPU
	sdsFgLhwUfLB5WCmVQIUIvtpO0hpwdxkI6+sgQdBTooI0oIs4ei4wSQcXtDM6Xws
	3DLcZLjc/agLtLnKSUsjYjCgHzHQK/IWzdTRqV3mIF1ek3qF7FZyFr2vXotloMXv
	YqX7vQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8g0ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:33:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78117fbda6eso632011b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610797; x=1761215597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7US01srTXfkHjr5hd7/lzike6tL4rbOPwhEWWKSwns=;
        b=cjnAWooZuU2XrkuBAKCSbn89phH2kfIA3itQ+m3qBRKw/YEhHfXTAMcYeyzZZTbfKo
         H2+50F0OxuR6wuQH37qxQ37ONbpQ2p8O/2HeC5jsaZpUoBbuvql365vzMPZUttOhqybq
         VOPHh2WJx9gmerDk8xeYKnSnVmaDgzAcCk9dwbbuLMzypxu9/31O53kAWcfpPjKXWIAP
         JNEj+zfi0+wkhlsGa+RdIYijHypAzLF7T9mc6JVrkFs2cIC29e1JwQYWvdUogE5ekB91
         6RYHWwA3N5/UNdunpGnefv5rm1Yw7A9yfKXxJXmdQ+9EeaiWtZISBCh7UJOcuhiij7B6
         f+wg==
X-Forwarded-Encrypted: i=1; AJvYcCXUp4PDBxl/rCeMM5bMOuTwhgPYqC1evF4Sg9dlWhwUxXkyXxweHGtg7N2UuMqo89n47DYKHjWyHwxPfcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJ8wzHQEpPB4OpN6wJm+yjPnBJt/6ss8Ho2xLTl5lAejKtfvg
	aQui/M0wM50IT5/+YaObPW1TRm5mSXucXwoGhCbYdDq14FhZLGnEGus1wjc3pHZ4j5Bast+p+by
	P0nFelGCdMwqQaPNCglLpmrbz8gmXMmqMA7/WapKVQlrUgnK6SG+SOohlmGQh6/VJmDw=
X-Gm-Gg: ASbGnctQG7M1rS/EeogEfjQdaF782Uw+ZXH7/QbC3gFLIxq7+p5MZnOLu4Gp6zp7jhK
	9e/2Vymx69ZM8hiAqqZLp356vPHuzM5ZbQ0Yal3p4/NzBcNjzkDinjB1VyInHQahm0nsabdSOCB
	+32hqEbxK6l/nDJLxFMJ5whR7I+hS8zAqhQyL+lwA1Hz5TpI2WA9RH1MFw1R+1JeLKLdCtO+fGg
	4zetytJek/yVqccn8K8lX9CBmPIQWzNgWLXfpAkbvt3niGc6vIro5aUYjy2aGXfhAhLiIzaH5To
	K3ml0hc+dXBmw8pt/o3PfNiSqvOXE4CrXMpYIDiXTpIOODG4oml6L6b+l0G9Oq1pUAp0K/nc7LJ
	upJwAXSU1rA94OJRNpqxp7uaBaabvn+ypMgbWYQa3s6+x3khyjGx9SXV2Lpes2Aopn1eZAQ==
X-Received: by 2002:a05:6a00:2e03:b0:781:157b:3d2e with SMTP id d2e1a72fcca58-79387636930mr34814523b3a.21.1760610796810;
        Thu, 16 Oct 2025 03:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrLSzML+DluoqwIueLsJrUswg52tFyRY8b4V6YDJvsQCOJ7oWVWF0juXOq/0Srsugj9SZ/Vw==
X-Received: by 2002:a05:6a00:2e03:b0:781:157b:3d2e with SMTP id d2e1a72fcca58-79387636930mr34814486b3a.21.1760610796287;
        Thu, 16 Oct 2025 03:33:16 -0700 (PDT)
Received: from [10.133.33.12] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2c6csm21712627b3a.57.2025.10.16.03.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 03:33:15 -0700 (PDT)
Message-ID: <1aa133b9-2a99-47cb-8309-7e49b5dc4f85@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 18:33:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] media: qcom: camss: vfe: Add support for VFE 1080
To: Bryan O'Donoghue <bod@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-6-f5745ba2dff9@oss.qualcomm.com>
 <8d61f29b-ba02-4757-b8cd-5fb51b998acb@kernel.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <8d61f29b-ba02-4757-b8cd-5fb51b998acb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3s01R8_zZKowR6sy5OvNqtQFuUBKS-N7
X-Proofpoint-ORIG-GUID: 3s01R8_zZKowR6sy5OvNqtQFuUBKS-N7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX7rT3CdJn0lT6
 8Pq6+pmt4axxAy285ZUnBItKT/H4W9pq8iDAVk6JfaIHZadAOoSZrq+dl2DfHs0dV/PTV3jn4W2
 ZZbwE8qjR4eQxzgOq3lT8tdts1iU4jcKraUeFVOuhuO8fAbpH9MGBeTJQ/OpHip9DBiZchLXXus
 Gln95GF2ts++Nr1bYMw/IK2OUSBxbh7kWkmg8NAejZFnANY+oUyuaxJ8CDgvEKkDUaMKS7imWbK
 aC9sYooNbciv4MVinqpPRbv7pAPCxDj4NT+9IfeSg2KoQAQQ3r3AnXDIMS8T7xZ1zn7HbeclYOG
 AA1SqUWi1jS8ZIDG7mMza/Tm+OPa3Jm7AKD+rQwHaIveOVT9/LVREChQAjb5xzBxS5aoe1eJuCM
 L5LW7jvzTomprNNbVs1m47J0MuiqEg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f0c9f1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RkO7Omd9_SwxoHUsMI8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On 10/16/2025 6:09 PM, Bryan O'Donoghue wrote:
> On 15/10/2025 03:56, Hangxiang Ma wrote:
>> +
>> +        /* Deferring the reg update until after CSID config */
>> +        if (!vfe->camss->res->vfe_res[vfe->id].vfe.is_deferred)
>> +            ops->reg_update(vfe, line->id);
>>       }
> 
> But why ?
> 
> ---
> bod

That a story. When testing the RDI path on Kaanapali, we found one image 
buffer starved at 19/20 stage. We want to capture 20 images but only 19 
received.

On Kaanapali, the AUP and RUP are split into two separate registers not 
a single one. Maybe this hardware change impacts something. Calling 
ops->reg_update() in vfe_enable_output_v2 function only applies one 
buffer address. The downstream code defers AUP and RUP to CSID 
configuration stage. We mimic that and find it can solve this issue.

---
Hangxiang

