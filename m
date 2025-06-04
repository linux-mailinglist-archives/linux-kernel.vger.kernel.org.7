Return-Path: <linux-kernel+bounces-673353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B009ACE048
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19737A9C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9428ECED;
	Wed,  4 Jun 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wd+QjN0T"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7464BE67
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047455; cv=none; b=kMzmaJLZlhYUISFRd3fS+wQ/dF67QAyP11wzsMPng9xABQKxhQpWAJJ/HCz7mqEPPQ8GNfOi4kmo1GfNah3CJw9BR77aS+D7dja/Qkjf1m9R811yuEH7EJfat0gZ/BN+tJBofbvYgSEoH5D444gVPuZF4S09nBL8HRyxQqoMnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047455; c=relaxed/simple;
	bh=5JB+GYJIDPXn9o6tcyZZmI0bJQETRfFPrn1mq4SbOr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZnmWLJEDLybI2NjiF3wif8A7oJ/IQpMcy1l4ulj9AodGrXwPzlRmGUg7V1S8gi5gQRT3ibJdwaEEgIMIW3MErIR4jHSA2I8LkXP/k1LRZQNkC0sI208gZAEZ+D3rKqyOWXty4wjPxOvlDI1ki7OKlCGynlzcsWVie5TW+DSVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wd+QjN0T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DCawf032172;
	Wed, 4 Jun 2025 13:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AyofCP
	+ZN+6ircaf7mXhdeuKJnDTj+s9f0clMqZxlXs=; b=Wd+QjN0T53cJ5UBS0BP1xh
	UoNltEcgex7nx4RL2dI/9ob1j+9I0sh8lGb06Z8yDECNrMDf1LZWEPMwMv6I8s5j
	IcNdrV/mfCpCobGpLaKXpuAyhzs3gga7PjSFbyY7C+OBpr6RSVsBGJ6PegI0tRjD
	lm0JhgdAQFrFiZhLqssqlyD53tZa1D9qQZBVRqkatFL6+hiF0T8PwA4u+tx31VC1
	buUgd7LyC28IYlSDhDoqBHJvUXnJf8cHwtRBUch7NcdoZ0YMNu+awjzOxrfpk6nm
	WvELcIcPxBe6adYvR3VwJBbi5Lppb+StgHvIFoYyGY3X0WVB02NDLSrsBnl9r75A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geytmnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 13:17:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 554CxI1B029221;
	Wed, 4 Jun 2025 13:17:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geytmna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 13:17:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554BoRl0031650;
	Wed, 4 Jun 2025 13:17:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cfyyymw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 13:17:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 554DH8MM25297572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2025 13:17:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD4BB58067;
	Wed,  4 Jun 2025 13:17:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF0ED5805D;
	Wed,  4 Jun 2025 13:17:02 +0000 (GMT)
Received: from [9.39.21.166] (unknown [9.39.21.166])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Jun 2025 13:17:02 +0000 (GMT)
Message-ID: <9f7ae0e6-4640-418d-a4db-dba594377ac2@linux.ibm.com>
Date: Wed, 4 Jun 2025 18:47:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] drivers/base/node: Optimize memory block
 registration to reduce boot time
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nilay Shroff
 <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <2a0a05c2dffc62a742bf1dd030098be4ce99be28.1748452241.git.donettom@linux.ibm.com>
 <20250603200729.b7581e017e4ca63f502c795e@linux-foundation.org>
 <b355e72d-0284-4a31-84e3-ae4a79ad922f@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <b355e72d-0284-4a31-84e3-ae4a79ad922f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4FsplurUS7c-nNdN0AmIoqUxedlpBq1v
X-Proofpoint-ORIG-GUID: cm-Oc-tEKoBA3qeJIzbOxbnJXz9fYfvv
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=68404757 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=k8bw5oIpvhWMPjh-KD8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA5OSBTYWx0ZWRfXwW6CTbwXdFug zCXnZycTe/FqRgU6/7hAGmicwbUedmIIArWprAYdtHHYFavfFa4G+KxKc+VYO1pl6alcHRcrnEf xtqqWsw7o4wouJXJZzoiVu80TLtzFLtJwUNLpc6hsMSpgi2KAPuhJs5p3mGD9U84OeoklTUc5sn
 PO0Oz36/aec/Qkgp/dwSynzy9BzkcF+qgNlnrvE9Xo4/YUm9T/pCxhQS/mkX2twpZ2oBIWO+y4E fLsZmb8Hm2OFz2Owb8eVOZs0ET6iz52pippiIXA9bORtj7zfZU5Vif2yLNxoL/mevj+FhZvouV4 jeOJ8otynWo0iTOxhMKjLDCuX5C0uN78khP7zH28mqiv/t1+dsNkBy3020SYjol1DSCiNLzXe9j
 DxyfRX481RrnuSrz9kupxaY++cA4LzgAC6gDwjUeAhnBviMJhEI4V4hGPkwPy4jkwFCF2rTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040099


On 6/4/25 3:15 PM, David Hildenbrand wrote:
> On 04.06.25 05:07, Andrew Morton wrote:
>> On Wed, 28 May 2025 12:18:00 -0500 Donet Tom <donettom@linux.ibm.com> 
>> wrote:
>>
>>> During node device initialization, `memory blocks` are registered under
>>> each NUMA node. The `memory blocks` to be registered are identified 
>>> using
>>> the node’s start and end PFNs, which are obtained from the node's 
>>> pg_data
>>
>> It's quite unconventional to omit the [0/N] changelog.  This omission
>> somewhat messed up my processes so I added a one-liner to this.
>>
>
> Yeah, I was assuming that I simply did not get cc'ed on the cover 
> letter, but there is actually none.
>
> Donet please add that in the future. git can do this using 
> --cover-letter.

Sure,

I will add cover letter in next revision.


>
>>>
>>> ...
>>>
>>> Test Results on My system with 32TB RAM
>>> =======================================
>>> 1. Boot time with CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled.
>>>
>>> Without this patch
>>> ------------------
>>> Startup finished in 1min 16.528s (kernel)
>>>
>>> With this patch
>>> ---------------
>>> Startup finished in 17.236s (kernel) - 78% Improvement
>>
>> Well someone is in for a nice surprise.
>>
>>> 2. Boot time with CONFIG_DEFERRED_STRUCT_PAGE_INIT disabled.
>>>
>>> Without this patch
>>> ------------------
>>> Startup finished in 28.320s (kernel)
>>
>> what.  CONFIG_DEFERRED_STRUCT_PAGE_INIT is supposed to make bootup
>> faster.
>
> Right, that's weird. Especially that it is still slower after these 
> changes.
>
> CONFIG_DEFERRED_STRUCT_PAGE_INIT should be initializing in parallel 
> which ... should be faster.
>
> @Donet, how many CPUs and nodes does your system have? Can you 
> identify what is taking longer than without 
> CONFIG_DEFERRED_STRUCT_PAGE_INIT?



My system has,

CPU      - 1528
Node     - 16
Memory - 31TB

I ran the same test with and without CONFIG_DEFERRED_STRUCT_PAGE_INIT, 
and the boot time was consistently higher with 
CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled.

I'm still investigating this. I'll check further and get back to you.



CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled
----------------------------------------------------------------------
1. Startup finished in 12.959s (kernel)
2. Startup finished in 13.036s (kernel)
3. Startup finished in 12.944s (kernel)


CONFIG_DEFERRED_STRUCT_PAGE_INIT disabled
-----------------------------------------------------------------------
1. Startup finished in 12.234s (kernel)
2. Startup finished in 12.287s (kernel)
3. Startup finished in 12.230s (kernel)

Thanks
Donet


