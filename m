Return-Path: <linux-kernel+bounces-813152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22CB54141
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF391C24464
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDF25E47D;
	Fri, 12 Sep 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MHhrxQTm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01F25C821
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649379; cv=none; b=FVl8WIvOL1Fy9mGdIFlzDAlR4gqf9cFVKiM/OVldXrh+1VSip3zytNdU+D1cpPwXvTsqNBlzzgTa9L0XrqXHVPF3OY+WKmKV/u3fUjPwT+2cqtHijnKp33hy4cDY1WxnlHDTQuvbcwTiKQ7zokkrvVmjksEyRxUOjzeMFvlf/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649379; c=relaxed/simple;
	bh=0c8m7z9+swolY2a/x2oZYGjxRDdqpJkuK+VFgnvLnCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7xHpe/7OlBZSmlSklYm7/xVk9p8AxjJJc6mnaiu3LeC2Nv9IOng5uA1GtAUcU4ADCXAsvJFTHZwxIx3hoYbo4lSrKj1UlHdzzF/IRM1nxZZ2lhyqU61yrzW22kWamO13HavE92QbFRLNb3wxXs+PMjN8RLUglbaOveeRzwb2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MHhrxQTm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKCd14021524;
	Fri, 12 Sep 2025 03:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ivlsIQ
	1Z4vfpgTJiSdPajQcE5iwfgbsGPxnOVQmyfKc=; b=MHhrxQTmFu3Sb4p1NSOcyK
	BHeahIXs3MFgT79qmmuLYE6GxQIefc+gKFSX6/LY05rgsPmFWIYWqEEOJOnx38Fg
	sI0ZEztFkPdFCN+pF/CfFG3rgMjA57XfnfR0x/JsY8MLfLVV+pMFXziVVxuFNZFN
	2MYKJ9IPbJSv6ORr/AcJQqPYGsXPSoNYr2rJku3eE3MaKmjPaESf7E7UIb/qe5v6
	v8ABIf45lKpmGRO710+GJZo2T0IQftTRsV9Bon/ep8ObNiCZOwv/WUfm8nsu8Vdq
	6qNM9Q8Kg553+tTCH1xI5/oEjDAaI0imEgDcMQ3/LP4U52K+U/Uthvg+EPMVIcew
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukew7bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C3sbmx023873;
	Fri, 12 Sep 2025 03:56:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukew7bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C0j4Y4020458;
	Fri, 12 Sep 2025 03:56:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp195w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C3twnb50397494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:55:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B441520049;
	Fri, 12 Sep 2025 03:55:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1EE22004B;
	Fri, 12 Sep 2025 03:55:56 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 03:55:56 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: Remove offset in SPRN_M_TWB
Date: Fri, 12 Sep 2025 09:25:55 +0530
Message-ID: <175764920911.610338.14934659683671395907.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <9710d960b512996e64beebfd368cfeaadb28b3ba.1755509047.git.christophe.leroy@csgroup.eu>
References: <9710d960b512996e64beebfd368cfeaadb28b3ba.1755509047.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX0d18NKxZs+Bn
 mvG3HKzGxeuba2qbx8fNReMBZfoRcwvUdnnnQuHjERYAtpfVOctqPEYIpfxelXRs37oQPKK7WP5
 XFOZOZLmPRoT9EH09QealyNNVVq8qVvx3HjoR+iQn89SBQkYblAG4Z5QeXDwPIbOxG6jPLIV0/f
 DM8wxaWUlvnvn4mnXvUd5PsPhQJbbjAQPsKDt+08hEmhV5eXCtw/PIZzSA9yRX7puRLV7AkzrB8
 iCYbSHWiicfgmPJlOp+XpZBUlf36xMjzVdPeIeX+xyPF+n/JbytMp2wvseYNkgiIzxVvw6AZmGy
 6a8axByT2YvTsH4eYkSYOr9YeoZguZPZIl0uJsWdXnCuIeX77r+82WFZ8w8W9S8ZG56E0QTBTN5
 BEEFHvlV
X-Proofpoint-ORIG-GUID: 9Ll-EFkyq9jFXR4K5q64doOE6k7gQwFQ
X-Proofpoint-GUID: L5l0zWZkTlmCejP1dxM3lMC4woylLocu
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c399d1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=ycHeTDA2rj_D5xsyEtIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Mon, 18 Aug 2025 11:24:22 +0200, Christophe Leroy wrote:
> SPRN_M_TWB contains the address of task PGD minus an offset which
> compensates the offset required when accessing the kernel PGDIR.
> However, since commit ac9f97ff8b32 ("powerpc/8xx: Inconditionally use
> task PGDIR in DTLB misses") and commit 33c527522f39 ("powerpc/8xx:
> Inconditionally use task PGDIR in ITLB misses") kernel PGDIR is not
> used anymore in hot pathes.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Remove offset in SPRN_M_TWB
      https://git.kernel.org/powerpc/c/96c79fef228157baddae6574555353535772f109

Thanks

