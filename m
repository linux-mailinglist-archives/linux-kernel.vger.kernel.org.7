Return-Path: <linux-kernel+bounces-754758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE783B19BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FAB7A17CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412EC1B87E8;
	Mon,  4 Aug 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svj+1RU6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDF29A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290940; cv=none; b=RiwhSBYKHM/mbL6dFTStBC4dLoxq1hsJoC0+zqebL3U8f1q6tx7z4hMTkg4il5E33Vw2eB7SjScRU8SKNJsoJiUchWAKdCBkb7m6dk7B9nOO1TgKA4VuJtQZGVLIR68o3qu7G5YB/nUWknsc9ETCTA9naMLTGwVz+C85J5tI9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290940; c=relaxed/simple;
	bh=8zHHUdGD7TTJ6UqrckPSNAQlMBt0nXCGwHEtqoMF+uY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YykckEYYBrKfmXzbI7GBxxogHUR6ctjo/AdXJi/pWj3goT+VZuOz1/hEsIp1h4Vl6Fp6e4YsL1Rajw6MpI4b/yN+24PXeJ939NopbfWQPF7O+e2rcekJBmaWjXVvxPGedSwT6wI9/w6yxCaSOjzPxLYMGdFtNJowdF+ggvv5Y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svj+1RU6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573IiGPp004848;
	Mon, 4 Aug 2025 07:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ib8mVs
	rqwyyBHNS8GvpXt/uYJyY6X5Z4ZmPd8bii3tI=; b=svj+1RU6DOEA+tMwXEtW9M
	jXCntL1SXO3Osy8D+xkachrrzQgPIGzJu6WCU2Yu3kAyoFG78+hLEz5vKugSWAoT
	PmYnMcJEs2r3eNmpWWJ5/T4n56Pi31pyW8doFeVFmubmj/gHvw97X3YTy0+vQUSK
	jSEr86O6ZXErpQys3KBDfN0qQIIrj4se3R8AMW8hx+y8d72eRQ9IBKkR3vIFjFl5
	2Fw4iXN8a9t66Qxq8q7nBuUoDxzzV/naRw+2p1dIOFyC54DQ8eYwVfBff9KwiS7n
	q0DcKdHDxHc69zw6V7n9YieMLq4awePxX+hEj1NHTz03ZLjt9EPpJnLvrsalwv8g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9ubx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:01:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57471QMU029527;
	Mon, 4 Aug 2025 07:01:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9ubx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:01:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5745HomO009449;
	Mon, 4 Aug 2025 07:01:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0tcpx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:01:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57471Y3629426294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 07:01:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86B558068;
	Mon,  4 Aug 2025 07:01:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA68E58065;
	Mon,  4 Aug 2025 07:01:30 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.249.29])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Aug 2025 07:01:30 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] pseries/lparcfg: Add resource group monitoring
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250716104600.59102-1-srikar@linux.ibm.com>
Date: Mon, 4 Aug 2025 12:31:18 +0530
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6656B43B-FDA5-4624-B501-597D0F1B3F21@linux.ibm.com>
References: <20250716104600.59102-1-srikar@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Eh_O5gJ1uMPf6m7Tf81aJ_VaoMPp0Nnt
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=68905ad1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=1UX6Do5GAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=GWtWlM49-EJBfVYlMYMA:9
 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: MtdVDnzXAKgDZycggUT5SesrEpkBD_-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzNSBTYWx0ZWRfX2SkDCh3c91XT
 xmzynuu0VWiQdyfEx029LIUkMVxvRqqjYidQGrEn6DtGxqJk9mSzV3KIEaeaMDhtz2Dg2gFQAr5
 xRS0EGYh4buXK10dpKROOT+wJ8cqSJSf86a0n/9x4tGI4Xs0tJkQ1dkycKgE7XpHBq8PpTUwgFj
 4mki0OXgM19bknaocu4qB3+PF1U45wxuwI3mblCXB3RhZ0gSH3P7ch2ZpyuJOum3XentUQ0eObM
 RX/O8UojDcEC8mAIQX9UCAX9XCItJN4IE7xWk/VNf65t1AAyN7VNlzfbQueBakrBx3p8P1oxhye
 yYje6JUSAl0uGuZdeKugYFACTwxXUIuxdlXUNq3mAzLUFQ4WUgIg2pqWqMiNxPGZCp5CiS1ZWfA
 k/qkhA1VkZDMdCb6Cporto6mwzZvjHUCqHzBExUjOk6RSzmSEDEvd4zmPS2Xwu+8vO5LnBFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040035



> On 16 Jul 2025, at 4:15=E2=80=AFPM, Srikar Dronamraju =
<srikar@linux.ibm.com> wrote:
>=20
> Systems can now be partitioned into resource groups. By default all
> systems will be part of default resource group. Once a resource group =
is
> created, and resources allocated to the resource group, those =
resources
> will be removed from the default resource group. If a LPAR moved to a
> resource group, then it can only use resources in the resource group.
>=20
> So maximum processors that can be allocated to a LPAR can be equal or
> smaller than the resources in the resource group.
>=20
> lparcfg can now exposes the resource group id to which this LPAR =
belongs
> to. It also exposes the number of processors in the current resource
> group. The default resource group id happens to be 0. These would be
> documented in the upcoming PAPR update.
>=20
> Example of an LPAR in a default resource group
> root@ltcp11-lp3 $ grep resource_group /proc/powerpc/lparcfg
> resource_group_number=3D0
> resource_group_active_processors=3D50
> root@ltcp11-lp3 $
>=20
> Example of an LPAR in a non-default resource group
> root@ltcp11-lp5 $ grep resource_group /proc/powerpc/lparcfg
> resource_group_number=3D1
> resource_group_active_processors=3D30
> root@ltcp11-lp5 $
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
> Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> arch/powerpc/platforms/pseries/lparcfg.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c =
b/arch/powerpc/platforms/pseries/lparcfg.c
> index cc22924f159f..6554537984fb 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -78,6 +78,8 @@ struct hvcall_ppp_data {
> u8 capped;
> u8 weight;
> u8 unallocated_weight;
> + u8      resource_group_index;
> + u16     active_procs_in_resource_group;
> u16 active_procs_in_pool;
> u16 active_system_procs;
> u16 phys_platform_procs;
> @@ -86,7 +88,7 @@ struct hvcall_ppp_data {
> };
>=20
> /*
> - * H_GET_PPP hcall returns info in 4 parms.
> + * H_GET_PPP hcall returns info in 5 parms.
>  *  entitled_capacity,unallocated_capacity,
>  *  aggregation, resource_capability).
>  *
> @@ -94,11 +96,11 @@ struct hvcall_ppp_data {
>  *  R5 =3D Unallocated Processor Capacity Percentage.
>  *  R6 (AABBCCDDEEFFGGHH).
>  *      XXXX - reserved (0)
> - *          XXXX - reserved (0)
> + *          XXXX - Active Cores in Resource Group
>  *              XXXX - Group Number
>  *                  XXXX - Pool Number.
>  *  R7 (IIJJKKLLMMNNOOPP).
> - *      XX - reserved. (0)
> + *      XX - Resource group Number
>  *        XX - bit 0-6 reserved (0).   bit 7 is Capped indicator.
>  *          XX - variable processor Capacity Weight
>  *            XX - Unallocated Variable Processor Capacity Weight.
> @@ -120,9 +122,11 @@ static unsigned int h_get_ppp(struct =
hvcall_ppp_data *ppp_data)
> ppp_data->entitlement =3D retbuf[0];
> ppp_data->unallocated_entitlement =3D retbuf[1];
>=20
> + ppp_data->active_procs_in_resource_group =3D (retbuf[2] >> 4 * 8) & =
0xffff;
> ppp_data->group_num =3D (retbuf[2] >> 2 * 8) & 0xffff;
> ppp_data->pool_num =3D retbuf[2] & 0xffff;
>=20
> + ppp_data->resource_group_index =3D (retbuf[3] >> 7 *  8) & 0xff;
> ppp_data->capped =3D (retbuf[3] >> 6 * 8) & 0x01;
> ppp_data->weight =3D (retbuf[3] >> 5 * 8) & 0xff;
> ppp_data->unallocated_weight =3D (retbuf[3] >> 4 * 8) & 0xff;
> @@ -236,6 +240,13 @@ static void parse_ppp_data(struct seq_file *m)
> seq_printf(m, "unallocated_capacity=3D%lld\n",
>   ppp_data.unallocated_entitlement);
>=20
> + if (ppp_data.active_procs_in_resource_group)  {
> + seq_printf(m, "resource_group_number=3D%d\n",
> + ppp_data.resource_group_index);
> + seq_printf(m, "resource_group_active_processors=3D%d\n",
> + ppp_data.active_procs_in_resource_group);
> + }
> +
> /* The last bits of information returned from h_get_ppp are only
> * valid if the ibm,partition-performance-parameters-level
> * property is >=3D 1.
> --=20
> 2.43.0
>=20

<Resending to the right thread>

Greetings!!!

Tested this patch by applying on 6.16 kernel. Build and boot was fine.

Assigned the LPAR to different RG, and with this patch, RG Index and =
active_procs in RG reported the correct information. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.


