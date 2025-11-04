Return-Path: <linux-kernel+bounces-884141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C416C2F71F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8F10342834
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753552C11D9;
	Tue,  4 Nov 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a1/lePkB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10422285074
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237632; cv=none; b=pC7L73a0M2heid6ekEOadBYAYvmyzkm2Bg9vr0S/fmCPm0cl6R0mCBeaWKkJL6TgFgNO714jWDEhhxNGkibkVvbxGPhTXXJzH0Mu++hpgo9gZHX68WJu33d16QaBSN/pwGLQ8KWS+dBliCbguQyQRCkWwqB4yLtlpOPXlMPNXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237632; c=relaxed/simple;
	bh=MnuXWNcZIFgwY5ORqHa9tT8kSaafqZbwip6inPdeiXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQ+L0+T1q3GWh25ZFJkPVDJJpJP0ZOu2syqKvtkLDHfUxjC32ebW1lz+BWG4dLCd0EgWCHqG/DoG91EclelzyiYuAyxl2KaUYPYY8LRg9V6HAm6u81IShktewNnBKucjEWlARj2B/VDdFHOmPExlntVqFbq/DI4UFTjQowbJNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a1/lePkB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A41O1fx011187;
	Tue, 4 Nov 2025 06:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cgG0nh
	aHUcLMZC9dpZeHBf/+ElAE78vPoSHxQu3AQgg=; b=a1/lePkBJIBKfGpM+Diiqd
	yFiiyMbvL97fzz5OwrZV9/Rtake6MxkT0YUtu675T+miSN6+BW7g02amsbq1Pg6V
	/AT6TyxYvu26qriOh9D1pHiD8PrGwaTZpsbD8HtS3v8uScrYXFE4E6v5RzXhlrAN
	wmgg+CTYo/bNc3uOdlyXc0xxGCEp5gHoEjihvlFSUMFdeuKhQf0EUP2fgnqNRtC4
	6zYsJeI72g9OmLleGw0/DnaY/VbpRvb5aQnlg0gRbVCEz9SLjW2cAGUNXF31Kraz
	Mb3HGDKgWJMwhdxckzSWEAVyoHKQRmm/4vidHe5aCHFQXGDGb1LhdyXzfs3EdNKw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr2kwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 06:26:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A46OVNd029361;
	Tue, 4 Nov 2025 06:26:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr2kww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 06:26:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A46KE3w009831;
	Tue, 4 Nov 2025 06:26:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1k9ndr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 06:26:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A46QlQ340108410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 06:26:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47BE720043;
	Tue,  4 Nov 2025 06:26:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 967D020040;
	Tue,  4 Nov 2025 06:26:43 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 06:26:43 +0000 (GMT)
Message-ID: <dd8b0b2e-b3ea-42c9-896f-630c864883f2@linux.ibm.com>
Date: Tue, 4 Nov 2025 11:56:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Export kdump crashkernel CMA ranges
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Shivang Upadhyay <shivangu@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
References: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: opMdqXoXuHzzqDA97ozX4NfvyOjw1gdU
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=69099cac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=JfrnYn6hAAAA:8 a=iJAgtciTF2dadzWhSi8A:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: pafzTugha00TAbBSMvDd4fbGf2Zn_0WQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX2lxEIQfUWC+o
 Io1msdIIhj0d8XkDLU4OSf9j5sShsyGbQy8KjVwl+EjyIx+77cwrRZ2scoYzaBv09DunZD4j+ih
 28ufcFTwCNuCWp9Ogab3FwHEH/kb47D4jp4Sd8+nOFyPzYKPL6y4sqPF6h7rvX1V+rGNSsSEymH
 JcrkFqnmw6WrulIepMl+oDgh/h6V8+t8Sc96JUnBCIMq6f0FZY7DM1M+HkWitedzdIJ9pnx0V3W
 AzG6wxN5aN/sohGGPNxYUnVT+qz2GX/3v8zYzbZvjh8wGYCFn664dax5y1XB2+WwijXhGm3ScVB
 Up3QIfCzTqzyTXZMaDJquiQwbkh+JE88BJ4k4iVoS9+jL1B8g0sQhhCJnGYF63k97JCS31ljU7X
 l7PMaTZwmBhCEtRVeDuAu6FvJICHKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

Cc others who can provide input.

On 03/11/25 09:28, Sourabh Jain wrote:
> /sys/kernel/kexec_crash_cma_ranges to export all CMA regions reserved
> for the crashkernel to user-space. This enables user-space tools
> configuring kdump to determine the amount of memory reserved for the
> crashkernel. When CMA is used for crashkernel allocation, tools can use
> this information to warn users that attempting to capture user pages
> while CMA reservation is active may lead to unreliable or incomplete
> dump capture.
>
> While adding documentation for the new sysfs interface, I realized that
> there was no ABI document for the existing kexec and kdump sysfs
> interfaces, so I added one.
>
> The first patch adds the ABI documentation for the existing kexec and
> kdump sysfs interfaces, and the second patch adds the
> /sys/kernel/kexec_crash_cma_ranges sysfs interface along with its
> corresponding ABI documentation.
>
> *Seeking opinions*
> There are already four kexec/kdump sysfs entries under /sys/kernel/,
> and this patch series adds one more. Should we consider moving them to
> a separate directory, such as /sys/kernel/kexec, to avoid polluting
> /sys/kernel/? For backward compatibility, we can create symlinks at
> the old locations for sometime and remove them in the future.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
>
> Sourabh Jain (2):
>    Documentation/ABI: add kexec and kdump sysfs interface
>    crash: export crashkernel CMA reservation to userspace
>
>   .../ABI/testing/sysfs-kernel-kexec-kdump      | 53 +++++++++++++++++++
>   kernel/ksysfs.c                               | 17 ++++++
>   2 files changed, 70 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-kexec-kdump
>


