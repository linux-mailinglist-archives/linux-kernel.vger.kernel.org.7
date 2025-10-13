Return-Path: <linux-kernel+bounces-850163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D5BD21E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73AAA4EE448
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EA2F90D3;
	Mon, 13 Oct 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fnhd6Zvz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22F2F3622
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344736; cv=none; b=ifZEdIIN1S8rxEU8buugkE1jkizabuYgroLJdv+4rnw6eGkbGeZpUuvVpGqM32YyPLS21GLtRjgxzphGR2IqpdX9RR3/F0vUp1s0sv9fTb2HOMTQj3sHKrj3K6WhdpXnLtnuhUvLfUWEC3fRu5g66JE1Jt4FhnI9qxchICL9NHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344736; c=relaxed/simple;
	bh=aM9wpYz7D19h0818wM71Oi/TLVEQrjtN25oiHTy769Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye8SgSrBpJvv1LMG94YOWTLM4pWjJFYlnXeyboCxWJXBY+FJvqHZEuVw2TLxJYtwZHZt/xk7xbiOCxf15SWQNgds62NlAOWVsR4SNEVHLfH+CFv/b1NxOoOMG8e7C/f41rpnC/ybq6a47+u4gFJDTf2GQXuntERWGR2iismYZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fnhd6Zvz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n3lj032708
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kBVT1f4LC7X+qF9EMdOlijngoSBVrKJPfb4IYgGz1Hk=; b=Fnhd6ZvzNmGrNqKr
	Ta2fhVD20s5qTfXx9lhoSl+Wt8fBhPijpEtd9jaETgbvk49+jcBOzd0r2Bmuzq3y
	q5kmT14AE6nRXQMn5+ccH9QDFph6/6HxlxjYg9A/bOfwZKd/2G1JhXrT5i9UYB9I
	DYrKyJeD5QE1+9U5peP40Cv5Tugu7YDSg2qZ9phCesD/KQ3xnIuGsZZq7yZ0C5Kd
	847H3V1GnXZZhPLHXfkDTxmhZ6E2fdcHy3bp7YCp4p6dUKmrdCoMgKdQMCwbKRK+
	8NktZxu6jgb8ANoeD+ZPqxU7ggt3zGJd6nEG3qaAURKGz6sVc/G1URbqdsJl2ZLn
	nspLIw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8uwxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:38:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso7967554a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344734; x=1760949534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBVT1f4LC7X+qF9EMdOlijngoSBVrKJPfb4IYgGz1Hk=;
        b=Jj9meSwKXhY7tGU5ENNWd55A8XEOl3TYuHpva1Eh1gx6/nd9ZXwJZFArihgKwAb8CI
         Ep8F5/dmN6CibnQWMrpikkU3lIKkN8NJGUMbCBvzupPt+2ZvfDA1b4CBtm0OqxM2q5hi
         OseMxlzLgxVPHUpbNmiSIoaMs1B04NuL1TW+8qxNisAq1d6FfbJi8JJd39phjvZboV/v
         Ay5DyXMOyBDJNmchGod3WrfOT+fqCZ0HBEC4aczz6Ym+JSD9MUvsRH9Yv4+1JxdePiFD
         ZBYSJGmCLIh1MJf6le1l7bT2jbJiqBcreKzUs2rRGm/aMihfrTQkQbxg1Clgr4r/VRlQ
         jyhg==
X-Gm-Message-State: AOJu0YxF4vRboO8n5KXm7WqOADehVbM1VLA4cnTjgaNg9MwCibzuxa48
	Qj7uTKWz3ksAVWhC7+rRGTEMih9K9kOAXPf+pt4pT56DDENBSyx9lPksZOqcBu8QKxriT3qLFNo
	eLSq7DThrOv9Ibeqkpe77oZMHyuRNlJnPKu1vsXmlYMMUCxFm5BAW76rbODXlj4P80lY=
X-Gm-Gg: ASbGncvi3ANIJzpKZVbYf7BjVKJvmO2r7z0fx8P68IeVOBjrUPvpxhGsZSNJj6RZ2ci
	dMt6Vl68/BKiQpC56RD5mGzUMuzY6MZBcc0VZvEJB9ZHPZiXtN+LEfZ3vxZfqP3G8hTWcxVTVd0
	3KJMpEa1wHcNuUf1SLlZGHYanNsYkiVJBQFwxCBUTyycHQlzQX7F5BTv8pClF2tXGLZpg6Ty4Ok
	EPa2vNWpN6XVViZCAydXOKYqD7dliy+WCPgQdU+1zLI3Aj1xLz20eWWGixkTTF4FzYrU3nzpiUE
	M80w33OTl+fKDyq0TNQacF9WRotQfArV6G60aZFX/lQXrRhl3Meo6UuMiyUYRMdIZ+byJ02HQDv
	SQ9cpiD58hM8b0yuWqldi0mnlhK5KxA==
X-Received: by 2002:a17:90b:4a8e:b0:32b:dfdb:b27f with SMTP id 98e67ed59e1d1-33b5138e27emr30306529a91.17.1760344733594;
        Mon, 13 Oct 2025 01:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs7ZzJjXcOdRj1a6iEgitTMaufzAdrFWCf6u6RbYV0u2V2fa3XRScqidAK8Ls4TD09WlYnzw==
X-Received: by 2002:a17:90b:4a8e:b0:32b:dfdb:b27f with SMTP id 98e67ed59e1d1-33b5138e27emr30306487a91.17.1760344733107;
        Mon, 13 Oct 2025 01:38:53 -0700 (PDT)
Received: from [10.133.33.133] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb72dsm11172324a91.14.2025.10.13.01.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:38:52 -0700 (PDT)
Message-ID: <4d6a74e6-53fd-4749-8839-907a9d0d11d3@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:38:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-binding: Update oss email address for Coresight
 documents
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Rob Herring (Arm)" <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        James Clark <james.clark@linaro.org>,
        Tao Zhang
 <tao.zhang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mike Leach <mike.leach@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20250902042143.1010-1-jie.gan@oss.qualcomm.com>
 <175684936304.1217220.3167248149687349464.robh@kernel.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <175684936304.1217220.3167248149687349464.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Mb83GB0e6d-EElk7sR5GFQl4gpcoWQDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX4C6Tmreruyls
 4Uu3a0bAlTvR0tWO5L+Vg/2mumxsBwLuNUwqD3529M1CMLAPhArx5BnIEP9LUFs46vsEqzYj5Dx
 D8zsamKDrcyQIXVBaJ1CpE6zmw2/aEMBCzmKKy9JDZFWeASi8DxEB4W/4C/LbUT3P9QkHrqwK+j
 6UFJQARXaezkeQxrz8l84WoyYHLWkz+U3haAQihV3eViXBiKQOnB3+VPlq0YPF10f7QM/uqWQJf
 k1KLnz/sEeJgT79MNCUhxF8281xX7hg8L6O1LDeOPzhkp00xJ0TWvvZRkQqZZw7Olw0Jz2G1B3H
 fDAlawTmgIjIUoFFwQ468rPoXedgI/2NvKxV1AMYFrVyuauqnQG9tVr/IDDvjSRU/plUzHhNbUq
 dzKEd4vo9uKjy26uHlWN7RM9REm3gA==
X-Proofpoint-GUID: Mb83GB0e6d-EElk7sR5GFQl4gpcoWQDX
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ecba9e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=TojU4j7_S79YkeO3qSUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 9/3/2025 5:42 AM, Rob Herring (Arm) wrote:
> 
> On Tue, 02 Sep 2025 12:21:43 +0800, Jie Gan wrote:
>> Update the OSS email addresses across all Coresight documents, as the
>> previous addresses have been deprecated.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../sysfs-bus-coresight-devices-dummy-source  |  4 +-
>>   .../testing/sysfs-bus-coresight-devices-tpdm  | 56 +++++++++----------
>>   .../arm/arm,coresight-dummy-sink.yaml         |  2 +-
>>   .../arm/arm,coresight-dummy-source.yaml       |  2 +-
>>   .../bindings/arm/qcom,coresight-ctcu.yaml     |  6 +-
>>   .../arm/qcom,coresight-remote-etm.yaml        |  4 +-
>>   .../bindings/arm/qcom,coresight-tnoc.yaml     |  2 +-
>>   .../bindings/arm/qcom,coresight-tpda.yaml     |  4 +-
>>   .../bindings/arm/qcom,coresight-tpdm.yaml     |  4 +-
>>   9 files changed, 42 insertions(+), 42 deletions(-)
>>
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Gentle ping. Is that possible to get this patch applied?

Thanks,
Jie

> 


