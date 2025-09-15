Return-Path: <linux-kernel+bounces-816012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45FB56E29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1032F1796C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99121FF48;
	Mon, 15 Sep 2025 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c6NeE9NZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34191F8ACA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902392; cv=none; b=USGnb03CE0knTUsufpxBtIZhNafC9ssYY3LbHjw2M8l5p8vgGhy43C5r+ROR4hsPjgts1sGyBOD2q26SFy+wpNSNDuOr0PS3p/mvDXUoXJdFADxxZAeQPMw63f3Ok4bMx9KUXUHaGNNRmKmSj8dPSnccIevY1S/M/+sYg4OAIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902392; c=relaxed/simple;
	bh=ohUpipTMt4gASQi64UZFtyaRndLD5f1QK+vaH5E35dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo4AvEL4ybumDmUn+YbzQZG2tPt0T3NEjWKL5nX51ZbH83R8SnTMMz0cjvHxtmHy+UM7tRb+VPQcFABqZ4MjqGU3V2H3UwiryCLjmRIIlYCRoNDDFjdveWE4XxQ6qvpKMnx46zu8cx5M7bIyKzSilZKMIz2RmDgDAuaOf1ORvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c6NeE9NZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ELoYWX004264
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8U+/es2auF/UpL8wkEHJ/UTOBmDkqedpQR+r1cxVz0Q=; b=c6NeE9NZym9u3/Y1
	5GGelEyagUcFuSUPXxt0viCk06INZ5fs9W1IwIkbbpl7gEuI7Z0rQ4BROpupGSXj
	nRizF2zIY8vfBZOrUDrfoNHw2aXlHodU6m/UFN6hBpOMuY/NAuePKC74EUwEU5BF
	9IbVmUln3q/jJ0jJ2czalrzp/kyJ2CPQLLHUQIDgNePGKlzZ5bVFCpUElcB7Re99
	UD0G2BVJHQ1lXUed0yvgTRcWpt9nVl9HEBbHnv1QG3Mf7VVh2/ilrShdY/JFnfqq
	2DewBZKI8Wq1XlGKrt4zkqwXYSHbJrZLlFVhQahNUaaLuJFGOJd4NAu4txbrLsqd
	itqLxg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yxkb5wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:13:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77260707951so5561529b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757902388; x=1758507188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U+/es2auF/UpL8wkEHJ/UTOBmDkqedpQR+r1cxVz0Q=;
        b=d1sx2fqWdvb/E5jXZ4djvK3D84Il3zplFTfs4TKziGgLp/erzkSf/R3B9yujkwN7TR
         8csK5wB5IvkkTNZ5E4ikS9b3Nsa7tJyhEfoF5jKKPnsXasVUXnybQhDAVcvpybC3wKDj
         BrgzAT1vzIM6NasacONfzmwgj+5y3NW6M03d71M02F0MfiRhvwBYtPJly2GGK8rYjihP
         s07ot98n6yw+brjVDJ9VK6XNFmDwBIh0G1LAD9UgprBe+b+a8xcPFr6SvZQkIobLMWsj
         J7vpT1ME/D2dRw/Q4r5sq0IcwyTM3kpcgHxTaaTTfhccFsCN9giDTnlR57vr5a18JUaY
         4dVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTqLAenpRQUKqzuGAPaeyAvpi+PGry3Tz7adOSEn5kSwOPykd2Xy0X7l8P0k5+hABDyRghAoUQaTGgEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKzcnHF03ncSMjT66Ry9BAzbfRIfjONDqoD68Eyzq9AhgWsbB
	fDWzj005kq0aL+ZAfTjkXHaPWY976UGtsQZ9H4eSEW4jpFqxOE0XOXTVTgTQR9khwTHkolT1vZu
	kWug/El00lMQPXoOq0I6/DTn11AwDRf38ubFLf0golSGf+tlsEKIXTwL5dTimovuz0cY=
X-Gm-Gg: ASbGncugpddtoBP/eL2xcW8zaZ9SlpZymVlpe47l2zBX+6eTrYuzgHxVrw+8bFPydHO
	bfcfHKY3bXQtI8aRilpROc8msuTTt815PywxM8Ic1kuUQ0HtXLOLGdd8AztM1LQhTlEGtqN8vAf
	Jv3etF5CJphta+BuKrtK9f53dCppuabBShfmVlmzdsIsiaWL88pkQ9+HLIDRs9xAEA8AzxtylAh
	M/arTQxRUOYmo2QYehozlr2Zg9jqIb3RKLsGnJALAzJ700gCYWAtSRopX+Bf64NVu4+AN0Co3dP
	GWZsShu1GAtHOjeIbwFg1gz2OFd9oEl/sRIrvRXvAD3uEa1EkJ9CQz85A8Wi/33CM0g0yrfZAkv
	PSgNBhSA3QHDjVn/AVjBAHqJVuT1Iow==
X-Received: by 2002:a05:6a20:c40a:b0:262:23dd:2e8c with SMTP id adf61e73a8af0-26223dd314fmr5121177637.44.1757902388559;
        Sun, 14 Sep 2025 19:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNdmgeYdPGgEBBnW9LZnrDbOV/8e3BmXeugleNAIQXSUHtKSZ13d9gG/jmrPwhW3MoO6DJ+g==
X-Received: by 2002:a05:6a20:c40a:b0:262:23dd:2e8c with SMTP id adf61e73a8af0-26223dd314fmr5121157637.44.1757902388124;
        Sun, 14 Sep 2025 19:13:08 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1a22sm10159814a12.52.2025.09.14.19.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 19:13:07 -0700 (PDT)
Message-ID: <77342c70-3b75-4ccb-ae3a-c0418511a33e@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 10:12:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] add sysfs nodes to configure TPDA's registers
To: James Clark <james.clark@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
 <49bf23dc-705e-45ab-a2e3-fbb798cd8e34@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <49bf23dc-705e-45ab-a2e3-fbb798cd8e34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMiBTYWx0ZWRfX7k9xckD1gCEm
 ozd5cIO6MftvA9QMjXoJucdbpmUEkZYDPydFLSVUvF7a6qRhU2otyYqEU9sbDgecxKMa1hzkM/P
 3TnRNySLQahdUOOCGTHZ7L5KOad/EinVi0ddfmnq9i9fJt54UzElmoUgovc79lo27jUklA3gxS6
 wQuAMI5vtNr45uLQRh4odL0JYUT0++xgwoPTrrdQx3lN/6nQhugprZtGZ3b6BBeiiNW2iXr2e56
 NXFpFqYb6KhLOIeiC/yO2ssLZQ3NQMHJqlSi+iMsz/+mihKQnWR5oTbQD9FYPasc1KE7BYYJS3i
 ruV4G7veQxYdBQENfz6N3iqjNI6ssdpA2Ea22CKNs/3TL3aoN5rX1bxn0+vkdnG0c+n3p5+Wuty
 ibQ5MJwZ
X-Proofpoint-ORIG-GUID: 38V37mpLA27HkXUEeCwsB7iqHgGwKF3J
X-Authority-Analysis: v=2.4 cv=KfjSsRYD c=1 sm=1 tr=0 ts=68c77635 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=iF4Rue9Sqs3gHakc6bMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 38V37mpLA27HkXUEeCwsB7iqHgGwKF3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130022



On 8/27/2025 7:59 PM, James Clark wrote:
> 
> 
> On 27/08/2025 11:55 am, Jie Gan wrote:
>> Patchset 1 introduces configuration of the cross-trigger registers with
>> appropriate values to enable proper generation of cross-trigger packets.
>>
>> Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
>> which determines the frequency of ASYNC packet generation. These packets
>> assist userspace tools in accurately identifying each valid packet.
>>
>> Patchset 3 introduces a sysfs node to initiate a flush request for the
>> specific port, forcing the data to synchronize and be transmitted to the
>> sink device.
>>
>> Changes in V3:
>> 1. Optimizing codes according to James's comment.
>> Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1- 
>> jie.gan@oss.qualcomm.com/
>>
>> Changes in V2:
>> 1. Refactoring the code based on James's comment for optimization.
>> Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1- 
>> jie.gan@oss.qualcomm.com/
>>
>> Tao Zhang (3):
>>    coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
>>    coresight: tpda: add logic to configure TPDA_SYNCR register
>>    coresight: tpda: add sysfs node to flush specific port
>>
>>   .../testing/sysfs-bus-coresight-devices-tpda  |  50 ++++
>>   drivers/hwtracing/coresight/coresight-tpda.c  | 278 ++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h  |  33 ++-
>>   3 files changed, 360 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight- 
>> devices-tpda
>>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 

Gentle ping.

Thanks,
Jie


