Return-Path: <linux-kernel+bounces-857285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ADFBE6691
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 907164E9019
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C501E2E0901;
	Fri, 17 Oct 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HObBw0uN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF422AEE1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678769; cv=none; b=oYpKLzmOpPiKHDxxw891QE1SGnU1RH7guh//PzPR1546mblvNDRGAdrcZJLuIQMaoTyEty6lRgqPyGBT2UZLyztHNTMwpsDMuipHPLkQGz15Hp5PFgjGYpdmoJVvxGPlhM7d8kyjXUBMsuIIjz9hP+vcwDac+4LzeWegpdKrvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678769; c=relaxed/simple;
	bh=wJkWqDpTx/JzuX59QtPl9pvzoatzVSVntoY5r1KwcOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0vJ1mSd4XnrNi0ujhZWOaA/yP3Njqye6/mVYVfwH4/VS4umVd2FUR0qVLBRJXhu27e626wnVS0VJqPde9h/BaWfvUZbp/mVi9thl8PUQU0ghKd+xRtBfAsIo/uuxbY/61sfDotm7+sIC6iIP6WJYuFoSkXIup1sqRMweQVIPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HObBw0uN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GIm0tQ021709;
	Fri, 17 Oct 2025 05:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nN7TiA
	Z/MGjE7/97TqtyN6BIKmWAZdJXWKjKQPiHAFo=; b=HObBw0uNuMIMUfvHVlr9Ah
	QbdYTWYTsEt4SVh/I2jPSi5ADASxYNCxVZ/Xcd+YmacvwhmlRsFesXpdfpp5RlL5
	Qta93r8srROcm3niCb7DYJTT0VNkpM6d0vemO0lf3wdvpIrDTPHvYCHqBhNNKCrw
	w8O281tKaB4VoCyoaysNqNDlYpVsCRCOkaODZrlgRG2csCPAXD58DchPT8bFgi5k
	ky+wueyruJh2kE4j9ky4DOHMXyfg6CsNMohUWrbR9/pPFNk/ovK1K/9z0Yv9M+SW
	A3VdY9xaCXp9BuaBQB/zwyGcJgEAYRoXSZ//ByPqIjQ4m1EV5oT/8FTGri0mRfyQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey96ynh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 05:25:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H5PYws022298;
	Fri, 17 Oct 2025 05:25:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey96yne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 05:25:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H0i75i028035;
	Fri, 17 Oct 2025 05:25:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9gp4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 05:25:46 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H5Pipc33620358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 05:25:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA6F058062;
	Fri, 17 Oct 2025 05:25:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1CED5805D;
	Fri, 17 Oct 2025 05:25:38 +0000 (GMT)
Received: from [9.124.220.117] (unknown [9.124.220.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 05:25:38 +0000 (GMT)
Message-ID: <29051a26-d0c5-4ec0-97e8-e32e17a9a6ba@linux.ibm.com>
Date: Fri, 17 Oct 2025 10:55:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drivers/base/node: Fold register_node() into
 register_one_node()
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
References: <cover.1760097207.git.donettom@linux.ibm.com>
 <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
 <ed99ffc0-4a70-416d-9bf3-58c4a3ebe566@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ed99ffc0-4a70-416d-9bf3-58c4a3ebe566@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xL6UujgZrapbJuP98DZf3K-Jzahsg6az
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX6tW0gdb9eF+u
 NAv4+LuGdkIRfOPXperOzmunxpsCGYvs/UJGU92YP4QtUt+QStkTILJT4rcRXedz5AvvgAG4K8w
 l5TT5j4wIm8gfPXwkbOub8335Xa9FUK863fVMC8VrU0R6dsOa2+fK4zr9gLnPlYRXlnTwnQOGBo
 HJPyrGlr+Hd6OZYk5AA7zh2IF2vNenv0zsyVlJIh6ljdMv5jZeXGLk+k32VYAVLjwc+1yb/8MI2
 Kj5c1xWYTC/9FkD6SC/4luGVgGisdYQuK5fQSEstlBolValozO12Cypk7aI0/hCZL0xupWtP7Mx
 ishjIZGV9M2M2Hp8xO1OJGRb/rPPgMC96LymYUccHn/yO+l6asMkscjJLTtF5A0+bd6ASk8xoPA
 5TLwDPLELFXOCDAEtuwD9aWqcgP0oQ==
X-Proofpoint-GUID: MRs_fUSnLc8GKSOeDOtnOPvNauEZyTiz
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f1d35c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=p1EqsZHEuOmFBkmSmkgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011


On 10/15/25 6:06 PM, David Hildenbrand wrote:
> On 14.10.25 17:39, Donet Tom wrote:
>> The function register_node() is only called from register_one_node().
>> This patch folds register_node() into its only caller and renames
>> register_one_node() to register_node().
>>
>> This reduces unnecessary indirection and simplifies the code structure.
>> No functional changes are introduced.
>>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
> [...]
>
>>   /**
>>    * unregister_node - unregister a node device
>>    * @node: node going away
>> @@ -907,7 +880,13 @@ void 
>> register_memory_blocks_under_node_hotplug(int nid, unsigned long 
>> start_pfn,
>>   }
>>   #endif /* CONFIG_MEMORY_HOTPLUG */
>>   -int register_one_node(int nid)
>> +/**
>> + * register_node - Initialize and register the node device.
>> + * @nid - Node number to use when creating the device.
>>
>
> I assume that should be "@nid: ..." to silence the warning.
>
>

Thank you, David, for pointing this out. Andrew has already applied the fix.

>
> Acked-by: David Hildenbrand <david@redhat.com>
>

