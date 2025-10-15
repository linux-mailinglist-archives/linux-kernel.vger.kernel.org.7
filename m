Return-Path: <linux-kernel+bounces-854473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE813BDE77C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51D74F908D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A3F327783;
	Wed, 15 Oct 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bAAGjbmu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257592C21FC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531316; cv=none; b=djQeL7A+agoV/94r09J3tzY1b1mrNmLy13p3LxUxNBFIa4fa3c0vZOX0aVGDECV9noL6UVRi3KDAhuAgC66xc175jfuhWWzYKj+p93Elh4kTtVBe0ufHdiRQBYsIy1Io04Qpp809lviJCQ2SwVCgLnOikHu/8nNc+XujThdDW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531316; c=relaxed/simple;
	bh=afCqx+CQdwNgyrn3VQMC5E0JpWv9LcUIgdXKfpYJL34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdlFBbHew/JPOZr0KXbbBHJCLn4OM5FgzCpvr+uZNqQKPrEAKco9s+DTrB8htBO85wkU1LPuSSyufDXZmwrUmI3F52NBIba5QneHFOHL3WQgUm+RPbHeCbBYQr+Onn5rCV6qq9sSFnatSvt7JpZCu8bluoI2zMasrJdtWD2nduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bAAGjbmu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F5v1N4014420;
	Wed, 15 Oct 2025 12:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QAcHt1
	dapQ840Ot11Ijs6OU/pMU2QO8FW6tPLQhHtAg=; b=bAAGjbmuT1IDIGkly3yRks
	eQbNqM7L76cDvCOCYZEQZzp2igyVW2n1rYXipXHIQUhBY9GTJjf4CE6Z4TqSWzqz
	WhHBQapX689ColD4op2WTmI4R/fj92pFolFMWOsbbv9EP9MQ3HWAsoLOezWySaAu
	vSRLGEYmFA3NDPfMnp0cdmILGUGMIuhCYUYkrUsHnzIoEe/tVdFWuBJKKZdkloI1
	jXIjd8RtEDChqEPFgMkkyWHA52xHPg43WZ3pBIsSv+yIxCSUogEeTXpOqxFVD333
	V0Ze8yVQUSSTHHuQ1pqqDkM40ikAMVYNCsPxipZW6K7rR25DTLweKQIbbDnCZwug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrbwdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 12:28:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FCS8s5007728;
	Wed, 15 Oct 2025 12:28:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrbwdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 12:28:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAb0aH003626;
	Wed, 15 Oct 2025 12:28:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy0cfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 12:28:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FCS6rC40632730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 12:28:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31ECD58059;
	Wed, 15 Oct 2025 12:28:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46B258043;
	Wed, 15 Oct 2025 12:27:59 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 12:27:59 +0000 (GMT)
Message-ID: <5af4bc20-1809-4389-afe2-987f547cc8f3@linux.ibm.com>
Date: Wed, 15 Oct 2025 17:57:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drivers/base/node: Fold register_node() into
 register_one_node()
To: kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Cc: oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
References: <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
 <202510151130.JYajIJuM-lkp@intel.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <202510151130.JYajIJuM-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ef9359 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=qCTGczElb8rRS6Tj57UA:9 a=QEXdDO2ut3YA:10
 a=mmqRlSCDY2ywfjPLJ4af:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: bAX_B4dOnV7v2Y31hobP-XuOn-6zcZlL
X-Proofpoint-ORIG-GUID: Q30cX-kcGhGWVz-Y0VR0bYuPk7QQATV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX3hkaKjg3bS+B
 VeTAzgD+CRnKJnq40pTHKqA7X9Rp8T+290hlMDS1zQnTI0ADrP/Glw4tQdau7VTmSyPeU3DQFpE
 5TgrLDc0oKaAtDO/6MzyFIptSKEGqLiJh6LDc0B6+7xucN9akBdVjOeKKx3SBni4qQNEhja7GZH
 r2g670bIVASNqqHZcrJ33EwFaSlNmokBQTIwEVXyrwAld0I9zjXqDC7ZaJx36s92+9QwJZZ6RIJ
 E8E+oXuFNqaRH8pFeW00ek959q3xXYSSQU+8J/xr8Bx6ODymUFtVpA1mszW13wwKaDsuNuiRA2k
 iUz9ImSFJzoqFe2qai4fwuLBZxg/jUy7yGd+XKScdeOkK+PGKZ2+Mk8LeMpWR3k4a7GPl8Ka25T
 W8nOA1pMxMKafEosuADFS6Hb57R22g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140


On 10/15/25 9:23 AM, kernel test robot wrote:
> Hi Donet,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on powerpc/fixes linus/master v6.18-rc1 next-20251014]
> [cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus powerpc/next tip/x86/mm rppt-memblock/for-next rppt-memblock/fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

This patch is based on the mm-new branch. It is not applying cleanly on 
target branch because the target branches are missing some patches that 
are present in mm-new.

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Donet-Tom/drivers-base-node-Fold-register_node-into-register_one_node/20251015-000850
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom%40linux.ibm.com
> patch subject: [PATCH v2 1/2] drivers/base/node: Fold register_node() into register_one_node()
> config: s390-randconfig-001-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151130.JYajIJuM-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151130.JYajIJuM-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510151130.JYajIJuM-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> Warning: drivers/base/node.c:889 function parameter 'nid' not described in 'register_node'

