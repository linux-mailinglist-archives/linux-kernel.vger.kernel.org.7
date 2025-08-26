Return-Path: <linux-kernel+bounces-786354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15ACB358C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB984173B11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70C3019A2;
	Tue, 26 Aug 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MsFTymMn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19942FE052
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200288; cv=none; b=OM/dGCJm7BD0y1EQyqDhQIpP8SAzgOmrP/9lNFzlhvZgnOkyzOHfiUaJZJb6UDQD4NTOinTW+qP7Y68TtZuqqQpqocl3J2cGzf9fRPFzWZgEV0DEcOooqZMLgUT/KQ05B6bujVBXSFNJX3A0qllmCByYtEMoQH2cSVzp82x7fiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200288; c=relaxed/simple;
	bh=/Y8/vgNyT/vT+AICu3lRlNY3HskT21GQ2c3Ra05pcBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZTDkCdV8zxmh5IpEVcdC0BuoredaJM/gNa2pPdv4o2e3wUWBX5llmp0rdnCzVuv903C3UptFnhbK0o1EiENA/+hcORl/mt252p56o8nPK432HnQiEqwBt4hes/PWHkPMR4A4bFRxykyMd2QvEQIg9vJLx84ps+0Tu4xYsQUMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MsFTymMn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4k8Og026003
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CfVQerc+uHw+N4krqe/n6SfCqS6EUafruS/6IpTFDa4=; b=MsFTymMnI093YRxP
	U9CBwp95o4AtBT6NO5aEgQ9yvd9CVwwrSzMjZwDx0PhDwPbF0UrfQHjjVa0+QmF+
	NZbK06MXNPiJm4OlOuYM163DWXlZOt9BbfI6t6pzK6ocy46Y9aCp0L70dlm90NV6
	yUqvsatYg91DMMyw8WnZyZREPMMVtX0QEIhy8/T8rZEihQSl4Sp0af5Y+6b4u4iu
	UfVrTEjZj/mn3OfyKD+JXSAgN73N0GJnGGaQNDkTyZ9Po6O5zLkne18rnR4pDH2n
	Osvq0g8eoTWwOYrYMUqvjCX1/YiS2c4Gh90WwcWtaHJJ5hxY7t0oh2DErM4aiIAB
	B08kSw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x889y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:24:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b49d41ffbb4so1989262a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200285; x=1756805085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfVQerc+uHw+N4krqe/n6SfCqS6EUafruS/6IpTFDa4=;
        b=E4J2Eo38Vf+Vd+IqwZbjjwJ/scBUUZPjakwyOxXdqBIoYd+wc6clCBxsN9p+K6khHx
         ccv3dMiDTPS9GzIdh4rNhuHXnGtoEhR8/03B6/fuq4tNbDiGYySO6Q9yBnEjZPwjC9Ct
         8CXRJU82uhtFpZkLJsrXKdYjRwC6bL8Ud19ocbmkQ9Z4dKm8z/i3CXo0nZomgQnaaQds
         AnEjEEsD0j6Qqpv5LLu+0ViRrBTC7vbJa8uHZ6JPneB3kQjT5Lmq1SGcnKMtTtpNrLAi
         r4AA2GljTxISNt9Ai9BpPocEwhTQEqeHXkj5NloZjJGo1eaPrO+AYb3+ecn4Hy1dk2f9
         8GYw==
X-Forwarded-Encrypted: i=1; AJvYcCVQmumeDAnTnYe31E1jvP2UoisI8o4Tjjw3FMvJGRL/QrWPgvrfJSRt5DRM5/pFb/sVswsRKKKeXQnXD8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yrmscZmCPtDJXN6MgIm1rsYBkACxlTXpfgic4t4iNXhGKlMp
	8JpnqdbXqgRjJSmNX+ZAL9cCtNN6BOdwmuw9+1siBNMODUX177FbR/gYGN9N+s1taK1YKM6w70h
	6Y4lH0Bu3qLZtlQIZ1Fd8ovlBm3cJWzdV8BVGqfcZ9udRiYz9/KSq1oAGaf8mqrI2rQs=
X-Gm-Gg: ASbGncsAny2YbshjvR3S5hUGRZwn+fWOK3X/bqHgThL6OXA/OeAwy43QMoqINagjJ71
	zr+HCqZSiRHYAEZJKC/QY7tTN+osz/ivLAOEiWkSjSAYLM4tDutICcDxgJdKcpBZ3ixyyB1C1Y7
	pzDWe3bJiu7mms5QlaQAmf2SjvC+ujriTa0BqWsCELvCjn1Zfxg7nUWOrFxMYqZTcEzOW3qCNYd
	ouxhRHT2vh7/MvHY0ZY2fAm5uki6m24X7s2SkV9TPQcrRaOxOzIj3F8LoxK1DL3BqOMcOHqaOpO
	9QcMSexXmEeihvcO8/Q9jVFYpaU+rYvZ5c820+5hHZm0qVEFuXXlx2J3a0rbgDqfFLt8H70KT3X
	4rP/Rhrbsxrxs7srbtBjtnvLCgpxKEA==
X-Received: by 2002:a05:6a20:3d1c:b0:23d:c4c6:f406 with SMTP id adf61e73a8af0-24340e06848mr21993642637.43.1756200285019;
        Tue, 26 Aug 2025 02:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpqloeXmXwEVuJtSSmRHXdt1+2U4Mw4rv0BI++2B779xAglt/pCmwtRWFeQCFBd0qp95/NUQ==
X-Received: by 2002:a05:6a20:3d1c:b0:23d:c4c6:f406 with SMTP id adf61e73a8af0-24340e06848mr21993602637.43.1756200284591;
        Tue, 26 Aug 2025 02:24:44 -0700 (PDT)
Received: from [10.133.33.155] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b23a2e8e0sm5281035a12.49.2025.08.26.02.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:24:44 -0700 (PDT)
Message-ID: <2c542b10-ba75-4e75-a2cf-964edfbac52a@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 17:24:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] coresight: tpda: Add sysfs node for tpda
 cross-trigger configuration
To: James Clark <james.clark@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-2-jie.gan@oss.qualcomm.com>
 <ef2267d2-a6f4-4f51-be44-687a4074a4d3@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <ef2267d2-a6f4-4f51-be44-687a4074a4d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LroiUgfVnLgUfgz9ABVAQul0Z3S5yyxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX9S53U73a2kPg
 Y3CBX5Yixvq9r8QrhMGkn1U6ZrlOtb5Ht/dSYGlci/W5AOusOR9xbG5Pm8JWligmRw+pr2yJeQt
 r+KabJ4Vblnn77KFQjWPJ7NoUs0IXSG9L5yZLcm3mFhkGnDGOV6F/MqhbXPmJlqwql8Q3ES0EwQ
 NNIeqM/xIpV5Tl1Jf/Agq+esisxc3Nla/9pCvzU3RXVGgYCHpeKjrLiY921eY/5HjcwQYN1LFFj
 N6AjmbiN0CNFUzUu/xq7EHgBbej39RxJ0rHrNk+A42bQXVVH6HBMMdaR1in+Yt8MQtzsRnDP/c0
 73lyfr/g/fUUEj0Yceei6e0jyEql7GzKbO2U+nguaV8luSFxUUKzKf55vynfCxoSutOhJ0Ni4QZ
 wkcnkKiS
X-Proofpoint-GUID: LroiUgfVnLgUfgz9ABVAQul0Z3S5yyxa
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad7d5e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ytvvUmyFbC-rj0LgiQgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044



On 8/26/2025 5:17 PM, James Clark wrote:
> 
> 
> On 26/08/2025 8:01 am, Jie Gan wrote:
>> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>
>> Introduce sysfs nodes to configure cross-trigger parameters for TPDA.
>> These registers define the characteristics of cross-trigger packets,
>> including generation frequency and flag values.
>>
>> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../testing/sysfs-bus-coresight-devices-tpda  |  43 ++++
>>   drivers/hwtracing/coresight/coresight-tpda.c  | 241 ++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h  |  27 ++
>>   3 files changed, 311 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight- 
>> devices-tpda
>>
> [...]
>> +#define TPDA_FPID_CR        (0x084)
>> +
>> +/* Cross trigger FREQ packets timestamp bit */
>> +#define TPDA_CR_FREQTS        BIT(2)
>> +/* Cross trigger FREQ packet request bit */
>> +#define TPDA_CR_FRIE        BIT(3)
>> +/* Cross trigger FLAG packet request interface bit */
>> +#define TPDA_CR_FLRIE        BIT(4)
>> +/* Cross trigger synchronization bit */
>> +#define TPDA_CR_SRIE        BIT(5)
>> +/* Packetize CMB/MCMB traffic bit */
>> +#define TPDA_CR_CMBCHANMODE    BIT(20)
>> +
>>   /* Aggregator port enable bit */
>>   #define TPDA_Pn_CR_ENA        BIT(0)
>>   /* Aggregator port CMB data set element size bit */
>>   #define TPDA_Pn_CR_CMBSIZE        GENMASK(7, 6)
>>   /* Aggregator port DSB data set element size bit */
>>   #define TPDA_Pn_CR_DSBSIZE        BIT(8)
>> +/* Mode control bit */
>> +#define TPDA_MODE_CTRL            BIT(12)
> 
> This one is missing the register name prefix, like TPDA_SYNCR_MODE_CTRL

Yes, you are right. Besides, I made a mistake here. I should put this 
Macro in patchset 2.

Anyway, I will fix it in next version.

Thanks,
Jie

> 
> 
> 
> 


