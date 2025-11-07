Return-Path: <linux-kernel+bounces-889864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA3C3EB92
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3522B4EACF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45A1F3FE2;
	Fri,  7 Nov 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g1uXRAZv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287C1DFDE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499791; cv=none; b=GlmjAGBePYJDJ3qJFAPgt7E+xlQyG4b6lRHn758tZZ6bIVWZc1LzefOxzHJ4X2G8O6pxRIR+JZiv2kA+DH7O8grHcMNXd1esa5bYCahzjFODXXsL2RZqRK/ie7X9U/WKzF+trTNRmQCZZJNL2RYxyaT3OwvIWTOoABtg1zeOnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499791; c=relaxed/simple;
	bh=0ID4jP/HEUpHEYVCO6+I1MQonlBgUoWjF1dTK3UjlT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP3Or/HZK4aJjGc8KNAk8M1bOioKqS4IkSRRCF0hahslj1Myhps4qP26m8OjQmGQVlxeJbEVqKpbPz/eYJ+82irL0p9bOTM9l7XZ00P8Ycio4/TEgblq3za69LF6li3v2m08WgM+/sU4zV95zJLeprHcdODO25AHjcGe4U/NhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g1uXRAZv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A72iEV9006421;
	Fri, 7 Nov 2025 07:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X3HaBk
	Z0Y16/ZOvlCHIH11hsAoruhXZ8XfKm+QVi5aM=; b=g1uXRAZvhO00wkg9gfZaLB
	s2x+5PQOb2Uysd5rt5bAr46EJn6qtjf2cKf7hn7zWXyZa1V2QBYoiZJsxKFamLsv
	z0g2oLbKk/IG0xAAVH0V1vaLDKuBCfoJlv68VaxPRWWgaprKp9Y1nr3oMUTMELDP
	ZCtQuGKK7Z8HQtVDoyo5/7mCfpYkEVdJF6LXaXEEQ37YsT1ujEYpV5Fmj5iHVTCk
	Tu5ocYQt4O+K91q6sM4aCs1SLtdVrnAVl29ksm3Dqstspqnt8CAv+e8zPpLVv/4V
	W56iwJbD1RriLgo650k/xeJm2RqObnGwFVPal4mj2PuoB1CQdvg9PacHc5uidjiw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xcbb9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:16:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A77GA2s032292;
	Fri, 7 Nov 2025 07:16:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xcbb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:16:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7476K8021483;
	Fri, 7 Nov 2025 07:16:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrk1b2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:16:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A77G5pw52953528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 07:16:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E6A20040;
	Fri,  7 Nov 2025 07:16:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCD6E2004F;
	Fri,  7 Nov 2025 07:15:56 +0000 (GMT)
Received: from [9.124.216.224] (unknown [9.124.216.224])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 07:15:56 +0000 (GMT)
Message-ID: <f2c83fff-a5cd-4894-8014-f6b289e89019@linux.ibm.com>
Date: Fri, 7 Nov 2025 12:45:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] crash: export crashkernel CMA reservation to
 userspace
To: linux-kernel@vger.kernel.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
References: <20251106045107.17813-1-sourabhjain@linux.ibm.com>
 <20251106045107.17813-6-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251106045107.17813-6-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX3oDTbhKli8Pr
 8f3nXufGk75pmFiqgvo+8HUCiOmHeuWSqOrKGikPbqeDyF1e9JbxyevdXxdCoy8VLF5g9dR3TgN
 VvAQR4x02lVDcl8Xwl54XUzu50sjEXV/TioDeRfocmo6XSRSWKQlz7U2Tjp6H+XCa7VJPZ4pQ1V
 f1tO7U5RRJF0pxWDQZVjX10KmQhgg93oSdnhW1zkwt+l/edylINS6gFLcHSULR5hOHIaZ1bND0H
 pzF1p57c968iSrEHS8hReLTAZh8rh6JVu24boNv7Tg85l1AMEW7oi/N8UhhypFBbA6wqusptBUQ
 tdfU2j7iJdMUSESAMCalttCmPdVcyuqe4alTlpHMl4oGZVAhBKxUeEJS6kMkGue1sBW1ULcZepk
 P9VU5kpN6DSKusZlFrzsZD2fCZaOZA==
X-Proofpoint-GUID: 14-cE65UTlpF7D9vFBtjFK4_BH7bS4Ih
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690d9cbb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8 a=kZwJjtJCwpCGEqBlNKsA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: beCPzcuNJC0uG_6u3WqdW1RYVTuinS_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021



On 06/11/25 10:21, Sourabh Jain wrote:
> Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
> CMA crashkernel ranges.
>
> This allows userspace tools configuring kdump to determine how much
> memory is reserved for crashkernel. If CMA is used, tools can warn
> users when attempting to capture user pages with CMA reservation.
>
> The new sysfs hold the CMA ranges in below format:
>
> cat /sys/kernel/kexec/crash_cma_ranges
> 100000000-10c7fffff
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   Documentation/ABI/testing/sysfs-kernel-kexec-kdump | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> index 00c00f380fea..f59051b5d96d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> +++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> @@ -49,3 +49,13 @@ Description:	read only
>   		is used by the user space utility kexec to support updating the
>   		in-kernel kdump image during hotplug operations.
>   User:		Kexec tools
> +
> +What:		/sys/kernel/kexec/crash_cma_ranges
> +Date:		Nov 2025
> +Contact:	kexec@lists.infradead.org
> +Description:	read only
> +		Provides information about the memory ranges reserved from
> +		the Contiguous Memory Allocator (CMA) area that are allocated
> +		to the crash (kdump) kernel. It lists the start and end physical
> +		addresses of CMA regions assigned for crashkernel use.
> +User:		kdump service
While rebasing the v1 patches, the hunk that adds the show function 
didn't get picked up.
I will send v3 with a show function to export the crashkernel CMA 
reservation.

- Sourabh Jain

