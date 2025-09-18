Return-Path: <linux-kernel+bounces-822158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196DFB832F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64367220CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E248236A73;
	Thu, 18 Sep 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sf5cA2Tq"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE208F58
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177990; cv=none; b=ThVmyAXGNSx3erJvGkYv8eoRvnMJQRvkrXYkxaxij6x7Zxq1NkhL9VuJpIxi4PoP1F8lFTf900kwzjh9ev4VQdODkHMAr1NYOmTuTQFF+esPOcLBnLw82LLedWXsO4JDY/YzFBTC3VyRbjVvhxb0coxzOZPcZXk3txqg1XlB0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177990; c=relaxed/simple;
	bh=21XInRBpw8y6tcLKVm5GDvMo68HhqY5IJadzYNSFLnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK0TzKVZK6FPoSWyFzFUFWV8nuncGoXerB9ZvzXo1uJW3PxCi8nRT12mb63+YjoPVlEqyrPMEN7AA+mLQAFksqraozjYvw4uUwDE48Eng3uM9YB/xgwPJPmI8FN3ZaHzFSg0egCyDEy52SJ2Ee998IKfMmwgCl4H5Z3ka9ib2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sf5cA2Tq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIalYU011054;
	Thu, 18 Sep 2025 06:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UmyeBE
	S4QYQMD3WHm2ocxnsfboYzNZugX1gq0nt42Ro=; b=Sf5cA2Tqtu3t2jFLNJPZDy
	qJTWKGOrMZ4SwISlXZWsMV0cdnk0nWB8srPg5nEvbXKlhNdhRsm8PrTyYRbx4sC+
	H3xAU400yeF0BR6VPftq9gHLIR9rfjDogTc4yO5FyiNkJuKLWLj+38bjcVIde+Tg
	UqK6fH0yL4x2KFybDy4agH+imLY9bGdQ2gqpt4vUiSF0uJVNMpJGWHRonpMFZKbu
	QxwdOMI1stIu0N7InaU9mL1XK5UGtCS1XL0lRzun6LmYqSjq39eXMuawxJ5u8b3G
	YkB//BXA2DJ/iRhOyfH+ON3ddtZm/2FKgeB11EwVVRrrZq4w0UBCkY4YdVoYTfCA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4ng2u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 06:46:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I6W6il029922;
	Thu, 18 Sep 2025 06:46:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4ng2tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 06:46:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3FUH1009486;
	Thu, 18 Sep 2025 06:46:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3n0au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 06:46:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58I6k0VV33686028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 06:46:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CCA158064;
	Thu, 18 Sep 2025 06:46:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA79E5805F;
	Thu, 18 Sep 2025 06:45:54 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 06:45:54 +0000 (GMT)
Message-ID: <196c1592-3383-409a-8b4e-38ef1c215528@linux.ibm.com>
Date: Thu, 18 Sep 2025 12:15:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/base/node: Fix double free in register_one_node()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        clm@meta.com
Cc: Jonathan.Cameron@huawei.com, alison.schofield@intel.com, dakr@kernel.org,
        dave.jiang@intel.com, gregkh@linuxfoundation.org,
        kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, osalvador@suse.de, rafael@kernel.org,
        ritesh.list@gmail.com, yury.norov@gmail.com, ziy@nvidia.com
References: <20250918054144.58980-1-donettom@linux.ibm.com>
 <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cbaaaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=imvTE1wgVU1FVdfX0jYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l04Thvrv5UYZLP7kR0BDhfQtkmNnzQK5
X-Proofpoint-ORIG-GUID: n0PqdEgIoQTB6dCL5DnTqMuUmzVh3SsI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX7XZVJ46u9mjV
 gtRw2U+xyN1qGj+1eBEz3J/cMjWfJ8BdWa5fAD2JloyEl6Id4q7F2XrH6juJhIpxXlzmTrsd/xY
 53ktt5M+9vjxOo8Fd/qdmu9+f2w948B1+VJ8UTgO74jA9U4Eykbv1DcEFgXYkeyaSpuvMnQib4n
 EKndKxGxR7g2sQc4phhLaNtxUa+G/qrddKkt5/eNr4s1fgpCLQkBdnQoTGRqZz6QPmf1gqdpu+/
 qoS93FEgGpyFg13oVagzYzgSdwiSnJzXTmEmUQ4YlY961toMET9+1+GEl0d+qHcYXPghWzW2aqF
 ABNw03BvPCwUcER54uXvFKnkAxJ/DaHy1/fW0oiBLe4udlNWmrcMiQqFY9dNPIbNoqA5SuFq61B
 0BKIGG/K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204


On 9/18/25 11:25 AM, David Hildenbrand wrote:
> On 18.09.25 07:41, Donet Tom wrote:
>> When device_register() fails in register_node(), it calls
>> put_device(&node->dev). This triggers node_device_release(),
>> which calls kfree(to_node(dev)), thereby freeing the entire
>> node structure.
>>
>> As a result, when register_node() returns an error, the node
>> memory has already been freed. Calling kfree(node) again in
>> register_one_node() leads to a double free.
>>
>> This patch removes the redundant kfree(node) from
>> register_one_node() to prevent the double free.
>>
>> Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in 
>> register_one_node()")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   drivers/base/node.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 1608816de67f..6b6e55a98b79 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -885,7 +885,6 @@ int register_one_node(int nid)
>>       error = register_node(node_devices[nid], nid);
>>       if (error) {
>>           node_devices[nid] = NULL;
>> -        kfree(node);
>>           return error;
>>       }
>
> Yes, that matches what other users (staring at mm/memory-tiers.c) do.
>
> I wonder if we should just inline register_node() into 
> register_one_node().
>
> Then it's clearer that we perform a put_device() already in there.
>
> On top of that, we could then just s/register_one_node/register_node/
>
> And then we could do a similar cleanup for unregister_one_node / 
> unregister_node where I don't consider the split function really 
> valuable.


Sure David, I will work on it and send it as a separate patch.



