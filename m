Return-Path: <linux-kernel+bounces-753441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FFB18309
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D73E1C80FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAA24EA8D;
	Fri,  1 Aug 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rb4WElaJ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78DB20D4E1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056678; cv=none; b=huEsCNxEMZIWFCT/JUWEilJx7y3Y3buWv/zBkIlCTVqE7iw7GV7G6nrjniKgG6xuhchGmSnGG8lfxzTWEw+rfNg2p7/i2Ses2+79+Qo07Fgnzz+jcgFFT8IQvUlTKy3xipS8frjVvyxogtVZeNMrYeewHfSsmnKF0e01qAVY98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056678; c=relaxed/simple;
	bh=PwrokVXDW9zbfKRW5o7BEayiSwWB6YDwypmI2xwJSKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0WGIKl/a+uCWfXnGb/cgskQVPMiHGupbV6KjZCJN9TMBMgKhp3OSUZKtGumcVqBzjM8lHwpla7yxmjSGY+oYbcBW4eZtxpoZ0efOyIGED7rOPkRl/TWFklUazmhnLZmEcNdW9lxo62voFFGmveNYNDRHZS5jKqWGEQGr78ktNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rb4WElaJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571DUW1e025685;
	Fri, 1 Aug 2025 13:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F21j2v
	sKrTzEgCJ58dBdfo1wfRZGwROFMGfRXDGEHrs=; b=Rb4WElaJhDROwuXUayCa0t
	YqcFAMU8aJjn7bvwJ61Jwejgii7N0dTH+8E63NRGHzA84+MCtwGP5gbC4vLKnTPJ
	8bafp1wfMcjSt43wv/89e6G2AI29GkMl9Dh5Y0MV0IWJmPUcyKyv62yXg+M9RaN3
	qm8ZeDPVxieFC/vNA5cKNJSHaIvIC6Bi4iZIN3u9c/CWjNwZr20IYjdYFa6Pbz9S
	z1lrLJroedhm8IFT7LE77k0/L2LHDxBCehfWypMh2/8LkTB0R/En4mOefTq9u/m3
	4e7cuortv1CcGxxAujFh/jC5szE646v/XHYJDCNVv+Cl/EK7XrVpxxiHbZLmRpeg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu0ekg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 13:57:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 571DunlH015664;
	Fri, 1 Aug 2025 13:57:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu0ekfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 13:57:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571DcReq015952;
	Fri, 1 Aug 2025 13:57:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aun1hcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 13:57:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571DvPbD59113888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 13:57:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52EA2004B;
	Fri,  1 Aug 2025 13:57:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F18820040;
	Fri,  1 Aug 2025 13:57:23 +0000 (GMT)
Received: from [9.39.23.28] (unknown [9.39.23.28])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 13:57:23 +0000 (GMT)
Message-ID: <da3a0717-fe3a-49db-bebd-f231a7fdedb7@linux.ibm.com>
Date: Fri, 1 Aug 2025 19:27:22 +0530
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
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250716104600.59102-1-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZNPXmW7b c=1 sm=1 tr=0 ts=688cc7cb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=1UX6Do5GAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=GWtWlM49-EJBfVYlMYMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: SBK4bZsuubV6sSpEbK9HQD3xi9o0RGf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfX7413cyPD2YOP
 kb9IZbTdSWvnyT/XJN/o4HvieR3q6DOggIb5K+YSgWa2EtGhOxiGPDBVel+g4QoXds9SQd7JjSQ
 nkb7qOTcFQQ8LSc78Ka0DIlV3wRjvK9pgbxC4QB5pa6skjs3/P9zhMavU1MMjoHTLPLM91wC7Fm
 v05YeEQWY3sUKUTEBfllvnoMKoUjEqR0mFkc20o1pW2HEQ3IVDITPwUXo2vKl37mDtoC2ZDzeUk
 QcczgABH7zVylsAjzZ3VpfPow+9T1pG9KAzpbKGZ79EGYFiogjCEog4mCM8nQvYvKX54rrEoHtz
 AdLvlUrvpn5YaWKk1jkOT5dZGkPty8QIjHyuDOqHdZpyR7AvdDfmF5UZjIcM26ezEVAqYSi2wAj
 Uk/6JLoi/EVQWLyOdV6oH7AA+D6Z+LTR84eTStFtjIDWbpnTUliB1I4JX26fRnCSNPrL1eU3
X-Proofpoint-GUID: mb_0c3hhABXJtT4kyYOkqupdJp7SAdyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010105


On 7/16/25 16:15, Srikar Dronamraju wrote:
> Systems can now be partitioned into resource groups. By default all
> systems will be part of default resource group. Once a resource group is
> created, and resources allocated to the resource group, those resources
> will be removed from the default resource group. If a LPAR moved to a
> resource group, then it can only use resources in the resource group.
> 
> So maximum processors that can be allocated to a LPAR can be equal or
> smaller than the resources in the resource group.
> 
> lparcfg can now exposes the resource group id to which this LPAR belongs
> to. It also exposes the number of processors in the current resource
> group. The default resource group id happens to be 0. These would be
> documented in the upcoming PAPR update.

Could you please add a link to patch on power utils on how it is being consumed?

> 
> Example of an LPAR in a default resource group
> root@ltcp11-lp3 $ grep resource_group /proc/powerpc/lparcfg
> resource_group_number=0
> resource_group_active_processors=50
> root@ltcp11-lp3 $
> 
> Example of an LPAR in a non-default resource group
> root@ltcp11-lp5 $ grep resource_group /proc/powerpc/lparcfg
> resource_group_number=1
> resource_group_active_processors=30
> root@ltcp11-lp5 $
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
> Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/lparcfg.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index cc22924f159f..6554537984fb 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c

Does MODULE_VERS need to increased?

> @@ -78,6 +78,8 @@ struct hvcall_ppp_data {
>   	u8	capped;
>   	u8	weight;
>   	u8	unallocated_weight;
> +	u8      resource_group_index;
> +	u16     active_procs_in_resource_group;
>   	u16	active_procs_in_pool;
>   	u16	active_system_procs;
>   	u16	phys_platform_procs;
> @@ -86,7 +88,7 @@ struct hvcall_ppp_data {
>   };
>   
>   /*
> - * H_GET_PPP hcall returns info in 4 parms.
> + * H_GET_PPP hcall returns info in 5 parms.
>    *  entitled_capacity,unallocated_capacity,
>    *  aggregation, resource_capability).
>    *
> @@ -94,11 +96,11 @@ struct hvcall_ppp_data {
>    *  R5 = Unallocated Processor Capacity Percentage.
>    *  R6 (AABBCCDDEEFFGGHH).
>    *      XXXX - reserved (0)
> - *          XXXX - reserved (0)
> + *          XXXX - Active Cores in Resource Group
>    *              XXXX - Group Number
>    *                  XXXX - Pool Number.
>    *  R7 (IIJJKKLLMMNNOOPP).
> - *      XX - reserved. (0)
> + *      XX - Resource group Number
>    *        XX - bit 0-6 reserved (0).   bit 7 is Capped indicator.
>    *          XX - variable processor Capacity Weight
>    *            XX - Unallocated Variable Processor Capacity Weight.
> @@ -120,9 +122,11 @@ static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
>   	ppp_data->entitlement = retbuf[0];
>   	ppp_data->unallocated_entitlement = retbuf[1];
>   
> +	ppp_data->active_procs_in_resource_group = (retbuf[2] >> 4 * 8) & 0xffff;
>   	ppp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
>   	ppp_data->pool_num = retbuf[2] & 0xffff;
>   
> +	ppp_data->resource_group_index = (retbuf[3] >> 7 *  8) & 0xff;
>   	ppp_data->capped = (retbuf[3] >> 6 * 8) & 0x01;
>   	ppp_data->weight = (retbuf[3] >> 5 * 8) & 0xff;
>   	ppp_data->unallocated_weight = (retbuf[3] >> 4 * 8) & 0xff;
> @@ -236,6 +240,13 @@ static void parse_ppp_data(struct seq_file *m)
>   	seq_printf(m, "unallocated_capacity=%lld\n",
>   		   ppp_data.unallocated_entitlement);
>   
> +	if (ppp_data.active_procs_in_resource_group)  {

ppp_data.active_procs_in_resource_group can ever be zero?

If the entry is absent in lparcfg, then lparstat will print it as 0 (which happens to be
default RG, while default RG may have processors)

> +		seq_printf(m, "resource_group_number=%d\n",
> +				ppp_data.resource_group_index);
> +		seq_printf(m, "resource_group_active_processors=%d\n",
> +				ppp_data.active_procs_in_resource_group);
> +	}
> +
>   	/* The last bits of information returned from h_get_ppp are only
>   	 * valid if the ibm,partition-performance-parameters-level
>   	 * property is >= 1.


