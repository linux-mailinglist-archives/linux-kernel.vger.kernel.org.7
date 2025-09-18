Return-Path: <linux-kernel+bounces-822039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B70B82EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B70E4A1265
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A42749C5;
	Thu, 18 Sep 2025 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HzqxFbJJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC8259CAB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171379; cv=none; b=WPKax7o3GTPpGkLjirUdJMNBBXtlysaX7/ZicTy+86gj4Ff8FrzRzg/VZfgWFBkb2au21XQtO8u4aeMXfoX6jdaJkHFpWdQIHK5hVOUpog+b4yPcja3/FZ2x3R7RhgxbagcRB7G/vfIWqErfvLBA2zgFv3plkr3T+1c9y2YtsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171379; c=relaxed/simple;
	bh=G8wmUt6omdKOr/GsALiLLbhKcZvQkjTo+mX02enj4Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8Y9X++I/ZXzUv2csmSxHFR6DoUsf7alBTUL02O+nzI2hRK28IbXyV+TP6abopytC2gpjsab2uBPM/QDSM7U8L6mvdWAxWBKKZwwAhCHpXw2D3U2yN85HlbJIETIobiuq6UZ6HyllGNL1m0GlyegSl7maeWbJlzy8HKo1dJFHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HzqxFbJJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIWI3b027152;
	Thu, 18 Sep 2025 04:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NotAuU
	ShrSCvXvm4Q5gT+Oz5+LaDyGv2IOTdAjj1U5k=; b=HzqxFbJJhi3a4bB9d4Tv/A
	UHuVpokOUbsJGvmP1S6linVLxCE/k3Th5TTXlJT1y+pPAutk3FJFp8WAjMSQzbMP
	kfYaMMWD45UI5GzfJlsefrn4xOOlMY70GBvj6FEUBwU5og6lpzOrv7u0YBIpudPU
	ISxJAkL5PTSxGKAEj/KulSlgwlqZC4m/fg2JSO5Q4GigGqwmLiRBIW0mUspqDhnp
	6ZeCl6pwH4qwxHjr/+1+YhLspRRC462bK3QAF5PywDquLOkRIUgRCyJg8rbqyqjA
	r/ke/duC3yZEJr+dUkWmSA6V2b6BDYRloBdA9cDHbCq18bByrU3D+uFpsXKxdGyQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p816e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:50:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I4oouS010353;
	Thu, 18 Sep 2025 04:50:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p816b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:50:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I2Vlkr018629;
	Thu, 18 Sep 2025 04:50:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mmq8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:50:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58I4ondT54264216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 04:50:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285AA5805A;
	Thu, 18 Sep 2025 04:50:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B0958056;
	Thu, 18 Sep 2025 04:49:46 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 04:49:43 +0000 (GMT)
Message-ID: <e6f5d1e6-afe5-4225-a672-7523d04c6504@linux.ibm.com>
Date: Thu, 18 Sep 2025 10:19:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/base/node: Handle error properly in
 register_one_node()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@meta.com>, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20250917134604.2149316-1-clm@meta.com>
 <676712d1-7b4f-4614-bd82-5b0c43881865@linux.ibm.com>
 <20250917144844.e8d9b9593aac9f3a4b52a0cb@linux-foundation.org>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250917144844.e8d9b9593aac9f3a4b52a0cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX9n+UdE8F3voc
 Zb8tlE4PplCfB8r+8NIxpOSKoyGDzgNY5l3sNA7MFra6V7pCaIMB4byySaUp5ftHOvcmXlCD27B
 KXbGFXTnUDkFz5HGfXz6C5LEd5pmVQgubArmmSximt6pZBL7wqv+PcMyBlQ96M/OuENiV1ODBzq
 vWLHNijjFY+SA+A9YcwkibOuIM2DgKAlTtiV0ggmF0DiwKF529bU9jpkxpCEZs/UhZefX7EE3Vf
 LnX5fbAGaAct+XwQw+L/4GZs+LK4sZ4Ddu669qvZdaOR2IapjXmW6Yn6rBpPc0BUedGKj+6uA9M
 OlCGpT2m6yHJzQny3bqansd9ZOcmkHW+9Hmka3jzfupUflO4SdUY3XiJr31vzrtU3ceMtZbUfAD
 z7zhT7+v
X-Proofpoint-ORIG-GUID: lbaNMzgAgeoT0IXfYsWgEKGFdMi2SmhZ
X-Proofpoint-GUID: m6WOCbN5gXP7WPh1-QjaVSYAsLzyPdmd
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cb8fab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=AYsY0RiJbjKyjbCzuxQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204


On 9/18/25 3:18 AM, Andrew Morton wrote:
> On Wed, 17 Sep 2025 20:25:48 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>
>>> Can this cause a double-free? Looking at register_node(), when
>>> device_register() fails, it calls put_device(&node->dev). The put_device()
>>> call triggers node_device_release() which does kfree(to_node(dev)), freeing
>>> the entire node structure. So when register_node() returns an error, the
>>> node memory is already freed, but this code calls kfree(node) again on the
>>> same memory.
>>>
>>> The call chain is: register_node()->device_register() fails->
>>> put_device()->node_device_release()->kfree(to_node(dev)).
>>
>> Thank you for pointing this out. I will address it and send a v3.
> This patch is now in mm.git's non-rebasing mm-stable branch, so no
> replacements, please.
>
> A standalone patch with
>
> 	Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in register_one_node()")
>
> is the way to go.


Sure Andrew .I will send it today.


>
>

