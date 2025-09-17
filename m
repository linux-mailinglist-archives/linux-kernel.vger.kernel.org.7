Return-Path: <linux-kernel+bounces-821086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A75B80553
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF41C583287
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457B333AB8;
	Wed, 17 Sep 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rct3IbzP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AA332A4C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120986; cv=none; b=BpskQTKMDobJkgN/Oih3BGJxnGratGycGn2cTGyibblPkZNZKcowLLUbNlIB362Ugv/Ne3agcwjoUG/T+0q7NqbCc139cHQuKq/W3tdS7fonsUejbg6zGHmTz74lJUxCvKY5mY/bdmceFxuoV9ctGCbFGba8lJ/cHouL3V8927c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120986; c=relaxed/simple;
	bh=L76MygXtrWm/Op3fNmmVWFGhz9lk1yCMEhmYAWTuPOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eau3UgxGycsAZhXLUZrJa3VrDyPbiFvEORtaZRf3zz8e3mpiKqe/Zmt03nYUJD7I5uxJDr8YCwbVskzOUehd19rIfSK/F8vH54NraGAEnVP1iOz5NctQ/150O+o03l4v8PMWgik2MUadVVaJnfxqRCkREp5lHsSyG6+rB47m1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rct3IbzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8dCHK023732;
	Wed, 17 Sep 2025 14:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rR06gt
	PnF/0lad3TuycRjJDpgyMkkm7KtU3RqeljMR0=; b=Rct3IbzPzfNYhATirBqtua
	GackugCR9dsjDApxHI3cuKoVcov9cnf2ISm8WTYWPvxjit0XSYolr5KjuuW5AFap
	J2coxAFv9XNDUEuUTM3tIWOQwTQowVu4eSNX2t9329ayZqY3ApejWhfzmAm1SgsP
	NzWNk31ZR6KsX0e4tIEpgs0n8gg/lLVeaGo9B7GMU4Rk1vNP36qCcwjFwWFAjl0v
	jKxepwgTOiBCRJB1nrcghzvBGuDNDoezYtKxKXeBs+ZSDYVZV2r0kUxxOUOdysPQ
	H1RSyzfNr1Tl0FOnJyNmpt68FU3hQ2pJSu6E9wjEA0Fq6V8K7jqxcN0c8KMPLmvw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qm6d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:55:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HEpFib002366;
	Wed, 17 Sep 2025 14:55:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qm6d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:55:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDqLTt029514;
	Wed, 17 Sep 2025 14:55:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb11yqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:55:56 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HEttdA27853372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 14:55:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E2F5803F;
	Wed, 17 Sep 2025 14:55:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B5B58054;
	Wed, 17 Sep 2025 14:55:50 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 14:55:49 +0000 (GMT)
Message-ID: <676712d1-7b4f-4614-bd82-5b0c43881865@linux.ibm.com>
Date: Wed, 17 Sep 2025 20:25:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/base/node: Handle error properly in
 register_one_node()
To: Chris Mason <clm@meta.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20250917134604.2149316-1-clm@meta.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250917134604.2149316-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wA33Ic2Fwwy0CtaNYj3S3UXMkwZMpURl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX8X65/ufRsGVo
 bDCC1dccNXM0EWET9nYDeBvXFOX+osCHHAFBagTCHm/nXv88A/WHoQGYfDDSJPHh6iUGiqByniK
 +Ps8jp+GPtn3Xlu318ZUmH9rZiXD6BRqERZDWz/JLpdHd4oxCxqN6zGWmPxnlWYEbbq03gw6lTS
 +FDJXupWDT/2BakFtzHXEVPFMuqWOTiXsaLJ6o5Ai2iZpP8aHeSnktedd2SEN2rqVw7q1Su/dup
 wn7Y0HRnt0UD9vX8e7XWpmFQ407ic2GoO0Clnmjh1KK9aG3/kNQAr1J99sh5R2qTiVbMM57JiGx
 fE9xNOS5gUBJfpnUNGkBw1+NN8uOO+GnKiFitv97Z4pDWeX92o9YnbAHCPAYf0O2njuJC1FKeX4
 1sBNEDUh
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cacbfd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rKeXGq08CVa402lCTmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EX0LyWaAr9H_o1C6qQrgirVdE316IUWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204


On 9/17/25 7:15 PM, Chris Mason wrote:
> On Fri, 22 Aug 2025 14:18:45 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>
>> If register_node() returns an error, it is not handled correctly.
>> The function will proceed further and try to register CPUs under the
>> node, which is not correct.
>>
>> So, in this patch, if register_node() returns an error, we return
>> immediately from the function.
>>
>> Fixes: 76b67ed9dce6 ("[PATCH] node hotplug: register cpu: remove node struct")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>> v1 -> v2
>> Made the changes based on Oscar’s review comments.
>>
>> v1 - https://lore.kernel.org/all/20250702112856.295176-1-donettom@linux.ibm.com/
>> ---
>>   drivers/base/node.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index c65b4917794e..1608816de67f 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -883,6 +883,11 @@ int register_one_node(int nid)
>>   	node_devices[nid] = node;
>>   
>>   	error = register_node(node_devices[nid], nid);
>> +	if (error) {
>> +		node_devices[nid] = NULL;
>> +		kfree(node);
>> +		return error;
>> +	}
> Can this cause a double-free? Looking at register_node(), when
> device_register() fails, it calls put_device(&node->dev). The put_device()
> call triggers node_device_release() which does kfree(to_node(dev)), freeing
> the entire node structure. So when register_node() returns an error, the
> node memory is already freed, but this code calls kfree(node) again on the
> same memory.
>
> The call chain is: register_node()->device_register() fails->
> put_device()->node_device_release()->kfree(to_node(dev)).


Thank you for pointing this out. I will address it and send a v3.


>
> [ This came from automated patch review, but it looks real to me ]
>
> -chris
>

