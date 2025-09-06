Return-Path: <linux-kernel+bounces-804149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2304B46AC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07991B248EF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E92E88B0;
	Sat,  6 Sep 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bJCMsvT9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC452E7BB3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757153269; cv=none; b=CMhbS3uoH/59tbIgcw8O6Tkt8aCKt5u908rP3VOVEh+iFjysN9JMNVS5GEJA+EJn6068oFnMFSDPxUo3L7hOT/t/bwFrtrpZgMvi9GSnyQJF6R1YM5Ma+ZW0l1rYnnbYFXubt08c0kaTTyR3UBOB0OiE3AcrWCpKLuJ6gGGnBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757153269; c=relaxed/simple;
	bh=ZmlTAbj/XvyT1D0pIV86Hy8/es45ste3sS8ZUnTvr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTOgvRVSFuyJ2WAs5wsAzbPCHfmYZ2w+XOR8Y4vpNrkBBPV4SGbKAgI5CRhdQIQdasxmeCqXZ6KlT8gCzq6GiZyfohyh1jxQY4jYUlyZRngXoj2wqKy6dvuGdzNoaa8IsehE4Pspuvb4D+3X9oploYpA8V5TAbbvkUD4Z6gLlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bJCMsvT9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5866PDEU007971;
	Sat, 6 Sep 2025 10:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gWEI9L
	fhQsIboyF/Ltia7zpaqQVehiDaj7KwZHU8ttw=; b=bJCMsvT9M+qRRKhgI1/6SF
	yLov/Wos91KNe0xK3TxIQvMDPAxLdlo72iLxCzwCKYu86/nbuAtjyNwBHzAJTmK5
	zPJ2UHj6w5mdDyjbIVs88YlCrZwpg8Qxs5Bix2vqfkt1NDX8BjYvAljT8t7xBe+9
	p1eq5TDEqA6wm3Ys5IMdoCT4+fIUm7aDKZzaTZ3zVwfs9XGTH70Q57LI2nr7dDMS
	nNyYQPymZ9lAujZ91opEjoVdcViSz/vv9+QvC9gnVzJPyYl0R4LBIdjCeS68ndip
	MPR6HxE+11puDEcWopWg7KsE+kJYR/rHNVdsJpHBsZFUrTwVPTUj//ilPjrYF//w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqhdds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 586A6kDi004152;
	Sat, 6 Sep 2025 10:07:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqhddq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5869jgTP013941;
	Sat, 6 Sep 2025 10:07:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3w4fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 586A7ECt19792154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Sep 2025 10:07:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 385E420065;
	Sat,  6 Sep 2025 10:07:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 841D92004E;
	Sat,  6 Sep 2025 10:07:10 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.107.45])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Sep 2025 10:07:10 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Kienan Stewart <kstewart@efficios.com>
Cc: linux-build@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas.schier@linux.dev>
Subject: Re: [PATCH v2] kbuild: Add missing $(objtree) prefix to powerpc crtsavres.o artifact
Date: Sat,  6 Sep 2025 15:37:08 +0530
Message-ID: <175715312007.95031.8468913584527306760.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250218-buildfix-extmod-powerpc-v2-1-1e78fcf12b56@efficios.com>
References: <20250218-buildfix-extmod-powerpc-v2-1-1e78fcf12b56@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g4YSL7huyk16v9jAqfiH_KERRR7DS0Tv
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bc07d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=vlK03AKjUHhg1YbBJ0gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HJxQpjmQ9fWLsOOrNNeh3WYPTBElUZrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX3o8wyxKp9TDc
 4zia7TvW204hIWYvkULqrp7FT8qm/HDlByN1tvVCEDFiq+P28a8VNHejrppLkgeceWjoFHzjIe1
 IRiTyQj7GwevnbISw1GpFta2hPA+7mHjwJIFZ/eELrO38ib6hYyiN3eyeV1xjkHNogOZ5Pqs3ek
 aSih80YMxU5zLHzySmzm9zh63Qtrx2NfLhgo2hICEqLygFhiRxxROyZZOIoSDj7Ber6j4n3BHQo
 47wOpSrNvqIHhTN375Ip8gbcxg/4fHGHyphfoVctOyWJv9t+IwBMgzAAhcPX7JgMRONSyChhzPL
 gVYbG4daRqOyTBSMU9eF5Xr0V8Rm/NkVC9U8Cns8yswZM7X9XU7fHs5CpDTVrKvOi5ujTFoawPo
 qLUfVcOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

On Tue, 18 Feb 2025 15:26:39 -0500, Kienan Stewart wrote:
> In the upstream commit 214c0eea43b2ea66bcd6467ea57e47ce8874191b
> ("kbuild: add $(objtree)/ prefix to some in-kernel build artifacts")
> artifacts required for building out-of-tree kernel modules had
> $(objtree) prepended to them to prepare for building in other
> directories.
> 
> When building external modules for powerpc,
> arch/powerpc/lib/crtsavres.o is required for certain
> configurations. This artifact is missing the prepended $(objtree).
> 
> [...]

Applied to powerpc/next.

[1/1] kbuild: Add missing $(objtree) prefix to powerpc crtsavres.o artifact
      https://git.kernel.org/powerpc/c/46104a7d3ccd2acfe508e661393add0615c27a22

Thanks

