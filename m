Return-Path: <linux-kernel+bounces-850144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C6BD209C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D29CC4EE1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFF2F3627;
	Mon, 13 Oct 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfHjLIZR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF42F2610
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343923; cv=none; b=VT2EO+GPCIS4SncWb0Mo+y5fMaGvrGOPWckqCNRIAIab6tmasug4cWQvMIKo6Px4kO24HXDrd+F49ic8BG+3tGmj9aguyZU+65sUdF6xoaAGZQoiOZ6+5kM1JFRDsb7/sTVtHe4lz+AYMPkhyjSDi0UUcmSk4WYErDjC7e41nhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343923; c=relaxed/simple;
	bh=HEat7AkewEQ3u7PqhtZ4WEa9dj4GOCyAnBkiPOW5mTA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ham9rfsvTRI4nWRpba+Mn6BRJjchTpyqwBpei6nFE9uMSKHjVwE5Ym8/bG0lw2steATvOwVcKLJER67suXz6MIX1Pd8WCBr6cD07AIl6I3N+kUvCHNuGU7B8dpOj5TXfyrwizwXQhuPTf+hoWH9cO0Wf1EjMzlIZlJO90Dx9A/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IfHjLIZR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nBuc029362
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cX1C6BYRcl11MPbTFCuqbjie5JWw/JDuuQ80Dzz7xis=; b=IfHjLIZRQpLCK2/E
	bC9cw+hQ/OgSc6zCB6qBxCd5C0iDyduHmL2xVyfCKuMtmgl5Nf1pFz05ZSX14SRr
	gBq4wUfNVs7U90wYEhyXZ/0Xc385R2oPE1NX2ZQHr36bGinDPUCXLYjU522SiMEC
	5rkp9M9urh80zrUELxSE5gBp6twAxx1KGB2Rw6wJFKuhOzvwYlyRaZjydLEvbqYF
	58H04Yy0qliiIEsWoJvAcuzYT7EPQic8YpUxjFgHuNeTTYVj1VUpy6ot25Shg+Mi
	XBDijqPncfy4vcTg7ssLJowEiwR8IBaO6+d4un9r+v4qyM6EgTr/QD1+FzrmVvqg
	HBRMYQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5busc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:25:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so9149237a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343918; x=1760948718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cX1C6BYRcl11MPbTFCuqbjie5JWw/JDuuQ80Dzz7xis=;
        b=M/Y1HQjVNtDc0lr7ylnDV4+BcYC7W+w5iXPxlZmeYnvM6e4SnZAxjvmbxoh9KwM216
         9OtbrKgXGunb5zYRmZH2pc/KW2t8PcvUQxOvZDH9meXmaxE0bzPjo3XWNVS5xkSL0l52
         Y3zDUXjkCWp2/Cc2GqlDk3wsD0KXAjC8oS3MjfyzWKkVTDa/8799vpyKTCEZPge/8UFm
         7CI1NUMc5B4hne/+vMJINk9NMBWb1J2ENYlIk1KZ+pro6jxWqxg9XDAcqMx66QhCiMqj
         xo1A2HCXJ5QuvMlACUaIj/jcGDb1JL7sEOy0u1e7zw5LIn2kUEPkd7LV3yZNzbQNAqUw
         Jyiw==
X-Forwarded-Encrypted: i=1; AJvYcCWeLdRRhuj/HlnwZ/s684+mLyPIYa317hK4DNjhb6AKzaMdBTWO4ewpm0Zww0nw5JaA3WpGA6iKKlUucRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03djIPiTqis0gzByvCAzv+aQaZ8QAP7rZuMPbBWt4jyTTtTx9
	oKQsMx++ORvzqpKk7Xg5S/vzvHecC5N69KBhRysV2QsnrNf0edDUaqSA+t359aVZDVwJRrafHHw
	5lM8ezDz4u8TIWFJ/MyGAf0gd28nWtWx8mHaEQuD34MrQ5FisrNC9uhgMwXhTQ1LrHAs=
X-Gm-Gg: ASbGnctC4D2V8mvwCdCHWk2yCFZl8Mv9B/qHoQMvEEsHQFIwdBwSM8nZTcRWJWPcCRC
	o2J9nqoyWamIjLBQupg37uB3ndu0fR1oBmmNtOKk1IhXLr/hsuPRuujy/Rlp9vNHYcWyqk4nBUA
	QWUtkALWAWCp7DrL67rVDsVI3K3GX0m0Ky/T3Gh0SSNQSNy3CqxvRjhml76b71mmWetP5cMxmyg
	kuCXkNer46xwCZZHl7emBIYI8RFGoL4ZKdJlAFBPHWSjYUJ33JtIt7teOshLmb+ZroliyenG+Ht
	Z0nZIjr7B/Y8JHzLEdFSKfn69ERLyMx3T7HYu8kpOUUOgipgiTensuk7u0rrR28dTGx1XTEYj0F
	rFGMChvi5NWJcWKpl8mfurdX69KJmCA==
X-Received: by 2002:a17:90b:4a0b:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-33b5116a4b1mr29857497a91.12.1760343918346;
        Mon, 13 Oct 2025 01:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrkOMOMk67rmSiVsR6dlFd09MdgUDcMj+0J/ZFBTdTAe+wDZFQkg9mfmItRqpsDRlhZVXYqA==
X-Received: by 2002:a17:90b:4a0b:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-33b5116a4b1mr29857469a91.12.1760343917891;
        Mon, 13 Oct 2025 01:25:17 -0700 (PDT)
Received: from [10.133.33.133] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cbf2sm11436365a91.8.2025.10.13.01.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:25:17 -0700 (PDT)
Message-ID: <99de75a9-cb2d-48e0-8a8a-c8345fbdf989@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] add sysfs nodes to configure TPDA's registers
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: James Clark <james.clark@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
 <49bf23dc-705e-45ab-a2e3-fbb798cd8e34@linaro.org>
 <77342c70-3b75-4ccb-ae3a-c0418511a33e@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <77342c70-3b75-4ccb-ae3a-c0418511a33e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eFFGYUaivC-YJLeuq4ohtuYQGmHfPm48
X-Proofpoint-ORIG-GUID: eFFGYUaivC-YJLeuq4ohtuYQGmHfPm48
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX4n91Mvm3m3Pd
 jVSroLgg2P4jqmbVjEd6qCS8DRA+busVj3OWqkfXt95NS4RZXwrPmFHIQ/YxjcrIJGv1F6SJB4q
 ByppXgUS6AiZqoO5h2sskenKWEjcet6YBqjtcbHJ4EIrmx3NEopj0/I7+xtfrTsHflyzFNiI4cJ
 pXqtXcJsFnN3TPtcNTgOT4/x6vsj7d73rcUTtyi5ZfHzuOLYBdFmqHE/V++hZ026y4RCHwcu+3Q
 w4+0MmPQ+RKNJ8ia3H5cOKJh6r5W1M/OHHs3WMoqBwETPIY7pXNdQFuBp6uQkcuI+iuePqPCxhS
 iHS4eE75ssIaXmEOrUf7IhR5GrPTW0z2F7Ks534fG3aLvwtNas/A3kYv3EPeBV9rb94jguckiXt
 bOImDqkQUntBKbRqBr5g1ecSInDIDQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ecb76f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=otdSkCFsg5a9Z_Vg604A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 9/15/2025 10:12 AM, Jie Gan wrote:
> 
> 
> On 8/27/2025 7:59 PM, James Clark wrote:
>>
>>
>> On 27/08/2025 11:55 am, Jie Gan wrote:
>>> Patchset 1 introduces configuration of the cross-trigger registers with
>>> appropriate values to enable proper generation of cross-trigger packets.
>>>
>>> Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
>>> which determines the frequency of ASYNC packet generation. These packets
>>> assist userspace tools in accurately identifying each valid packet.
>>>
>>> Patchset 3 introduces a sysfs node to initiate a flush request for the
>>> specific port, forcing the data to synchronize and be transmitted to the
>>> sink device.
>>>
>>> Changes in V3:
>>> 1. Optimizing codes according to James's comment.
>>> Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1- 
>>> jie.gan@oss.qualcomm.com/
>>>
>>> Changes in V2:
>>> 1. Refactoring the code based on James's comment for optimization.
>>> Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1- 
>>> jie.gan@oss.qualcomm.com/
>>>
>>> Tao Zhang (3):
>>>    coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
>>>    coresight: tpda: add logic to configure TPDA_SYNCR register
>>>    coresight: tpda: add sysfs node to flush specific port
>>>
>>>   .../testing/sysfs-bus-coresight-devices-tpda  |  50 ++++
>>>   drivers/hwtracing/coresight/coresight-tpda.c  | 278 ++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpda.h  |  33 ++-
>>>   3 files changed, 360 insertions(+), 1 deletion(-)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight- 
>>> devices-tpda
>>>
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
> 
> Gentle ping.

Hi Suzuki,

James has reviewed the patch series. May I know whether you have any 
comments about the patch series before get applied?

Thanks,
Jie

> 
> 


