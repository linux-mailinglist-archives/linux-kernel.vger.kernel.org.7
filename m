Return-Path: <linux-kernel+bounces-757865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61702B1C78E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9CF1897EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D128D821;
	Wed,  6 Aug 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a5JLCDEY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42B28C86F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489999; cv=none; b=WibcuF5NBZRRzesXlx0jeBSHfFtu0TMhwCMTQDLoGmSBcJC6F91axKFa8bUIRceGti3W1z8KmI5bU1Es7BiMBXOlqfvV1yQNNbwyAUDtTtglBAkKYA8Jvq3xhEzwByxVovQavgKrO8sFoqeRwa2AMTRwlO4ONqOojumyBUhQ5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489999; c=relaxed/simple;
	bh=/4HcZ8C/DLFhYlHPzudguMjtzYtd7nqZrVkkpMN56sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pd1Ld4jvdTcCweMF139iGXZpjIBrmUF1faX06+r2PVRHkJiWt/EOhKy9IZVdmmRf6cPd6fWkca0UONlGTdTdcKzPXk06Szs6gz3Rc6DkYaYxznkkhscDTg+0TqaNceQubL5LqLTKnnZaXNLsn/ETdRtapWKFtJ2jq7N7l6PNLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a5JLCDEY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5769094I012310;
	Wed, 6 Aug 2025 14:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=va3UJ4
	4dXitPu9NfbgSPLyc0EPutVrF40nR7sMnql8c=; b=a5JLCDEYR8sbmW3Z3At6kY
	ckfg00e7rNzTCaZAu652IwWqYOdHXE2bYNr7dhJLwElBhLfZzPXD5fC2PqiQVDhi
	oNJkgpna0AJDZnIljHOfD91yN8AJiNh66lOK1Mj4pGYjFBH0ywJFvnB2Vu2k5Q/H
	AIUW5VIVqJhXFsWBQ3IDhLXyZupneRgj5Yizsl5nPWIUD9c/MX78UMvQe61IjACS
	cQCqw5oVrxCGKzy2SORA5v5qQQWmVpWTY55QqOGX8o8keIWERdwT/r7XxRJTE6oO
	KZ2V2sdOjZH5WmwBmasRBuXOQHbFCxHYGxrGPSOLBsyjDPBsDSqfCi9UEsuPi8Dg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63mmy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 14:19:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576EJ26r008182;
	Wed, 6 Aug 2025 14:19:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63mmy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 14:19:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CNfaB031444;
	Wed, 6 Aug 2025 14:19:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnbyj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 14:19:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576EJGp451708356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 14:19:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D261520040;
	Wed,  6 Aug 2025 14:19:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F84620043;
	Wed,  6 Aug 2025 14:19:14 +0000 (GMT)
Received: from [9.39.27.18] (unknown [9.39.27.18])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 14:19:14 +0000 (GMT)
Message-ID: <b2e88230-84ed-4b2a-b097-1b813fb42e2a@linux.ibm.com>
Date: Wed, 6 Aug 2025 19:49:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pseries/lparcfg: Add resource group monitoring
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
References: <20250716104600.59102-1-srikar@linux.ibm.com>
 <da3a0717-fe3a-49db-bebd-f231a7fdedb7@linux.ibm.com>
 <aJGZ5_Sf4c1ByCeb@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <aJGZ5_Sf4c1ByCeb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA4NyBTYWx0ZWRfX5unnUC4QjhC+
 AjaZVB2KZACWpep0PN8acXLSRZSEhXrQMr5CjqdpPXiMhbasvdEYkCStFBm6722AQ7186nXBP5/
 KPsdGky7xWvDMImXlqt9jWVwHOjxZlOEwETeV/jJSVaWjmFwBjDwuJKlB2cNfRpVE/zjXJZIBYl
 bYK0Rfl+7GUY/8IEJ6Qk/HAkuxlqmLzR6kzJ/JgXCLuIie30Q2J9HGFs5uIsD5pzcDYD79HTVZ6
 mO5Hmy6m1wcxNAOiee+592IvKbVrYBMy986PjFzk6f3Gwu3CF2tjIR7ciJF5oszksy9zkftVNvP
 +p7at2PavPH982vEwKeToiVObDEmykZnUlEvQnNK5cSnjXDT4a8KeTut8WiFQKgmsnrAgARnR77
 on6K32CjX6ZPwzWMC4tf76BhKntBa9y9viIsYnwQFG93Cbdw4vh5k/NZCfTPr9FP+ZjV62x6
X-Proofpoint-ORIG-GUID: rwMKSs5zUQ6bXX4hwsnEtCdXh9y6FnjI
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=6893646a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=6vAR2VqdJ3ZSXxe2e28A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2hLZv3NO1cIkpNeh5d4agVK7AtFDZDeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060087



On 8/5/25 11:13, Srikar Dronamraju wrote:
> * Shrikanth Hegde <sshegde@linux.ibm.com> [2025-08-01 19:27:22]:
> 

>>
>> Could you please add a link to patch on power utils on how it is being consumed?
> 
> I am not sure I understood your query, it looks a bit ambiguous.
> 
> If your query is on how lparcfg data is being consumed.
> All tools that are consuming lparcfg will continue to use the same way.
> Since this is not changing the way lparcfg is being consumed, I think it is
> redundant information that need not be carried in all the changes/commits to
> lparcfg. Such an information would be required when lparcfg file was
> created.

I was saying you could point to power utils patch that you have sent which says how
one would consume this.

https://groups.google.com/g/powerpc-utils-devel/c/8b2Ixk8vk2w

> 
> If your query is on how resource group data is being consumed by users.

>>
>> Does MODULE_VERS need to increased?
> 
> All tools that are consuming lparcfg will continue to use the same way.
> If there was some conditional changes that need to be done by the tools,
> then we should have updated the same.
> Hence there is not need to update MODULE_VERS.
> 

Since there are two new fields user scripts might need change is why i was suggesting
we might need to increase MODULE_VERS

>>
>>> @@ -78,6 +78,8 @@ struct hvcall_ppp_data {
>>>    	u8	capped;
>>>    	u8	weight;
>>>    	u8	unallocated_weight;
>>> +	u8      resource_group_index;
>>> +	u16     active_procs_in_resource_group;
>>>    	u16	active_procs_in_pool;
>>>    	u16	active_system_procs;
>>>    	u16	phys_platform_procs;
>>> @@ -86,7 +88,7 @@ struct hvcall_ppp_data {
>>>    };
>>>    /*
>>> - * H_GET_PPP hcall returns info in 4 parms.
>>> + * H_GET_PPP hcall returns info in 5 parms.
>>>     *  entitled_capacity,unallocated_capacity,
>>>     *  aggregation, resource_capability).
>>>     *
>>> @@ -94,11 +96,11 @@ struct hvcall_ppp_data {
>>>     *  R5 = Unallocated Processor Capacity Percentage.
>>>     *  R6 (AABBCCDDEEFFGGHH).
>>>     *      XXXX - reserved (0)
>>> - *          XXXX - reserved (0)
>>> + *          XXXX - Active Cores in Resource Group
>>>     *              XXXX - Group Number
>>>     *                  XXXX - Pool Number.
>>>     *  R7 (IIJJKKLLMMNNOOPP).
>>> - *      XX - reserved. (0)
>>> + *      XX - Resource group Number
>>>     *        XX - bit 0-6 reserved (0).   bit 7 is Capped indicator.
>>>     *          XX - variable processor Capacity Weight
>>>     *            XX - Unallocated Variable Processor Capacity Weight.
>>> @@ -120,9 +122,11 @@ static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
>>>    	ppp_data->entitlement = retbuf[0];
>>>    	ppp_data->unallocated_entitlement = retbuf[1];
>>> +	ppp_data->active_procs_in_resource_group = (retbuf[2] >> 4 * 8) & 0xffff;
>>>    	ppp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
>>>    	ppp_data->pool_num = retbuf[2] & 0xffff;
>>> +	ppp_data->resource_group_index = (retbuf[3] >> 7 *  8) & 0xff;
>>>    	ppp_data->capped = (retbuf[3] >> 6 * 8) & 0x01;
>>>    	ppp_data->weight = (retbuf[3] >> 5 * 8) & 0xff;
>>>    	ppp_data->unallocated_weight = (retbuf[3] >> 4 * 8) & 0xff;
>>> @@ -236,6 +240,13 @@ static void parse_ppp_data(struct seq_file *m)
>>>    	seq_printf(m, "unallocated_capacity=%lld\n",
>>>    		   ppp_data.unallocated_entitlement);
>>> +	if (ppp_data.active_procs_in_resource_group)  {
>>
>> ppp_data.active_procs_in_resource_group can ever be zero?
>>
>> If the entry is absent in lparcfg, then lparstat will print it as 0 (which happens to be
>> default RG, while default RG may have processors)
> 
> If active_procs_in_resource_group is 0, then we are not printing the
> resource group information. If active_procs_in_resource_group is non-zero
> and resource_group_index is wrong, we need to report a bug to the firmware
> to update it. Kernel is very transparent with respect to this information.
> It can neither verify the information received nor should we even be doing
> this.
> 
>>
The comment was more on the necessity of if statement there.

+	if (ppp_data.active_procs_in_resource_group)  {

If one runs lparstat in the LPAR, that means ppp_data.active_procs_in_resource_group is non zero. and when
ppp_data.active_procs_in_resource_group is zero, i don't think one can run lparstat in any of such LPAR.

btw, ppp_data.active_procs_in_resource_group can be fraction between 0,1 or is it always an integer number?


