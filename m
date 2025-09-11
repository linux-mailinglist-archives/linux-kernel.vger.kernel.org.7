Return-Path: <linux-kernel+bounces-811883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD43B52F17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9AB189EAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1B310627;
	Thu, 11 Sep 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H2hpCL6e"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F172EBB8F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588622; cv=none; b=q4SjviUb3f3gKniq9Srz7Pc0Rj/iDJlCMIk6YuNZyW1HA7TNuW/qJWrOAxPtoH/aTOw4RkW8Q9RJdoFOIUL3yameLiTB+PK74KphrwH58r1l2YqGVs/vWauaDlZUlIPoF4AgdAJpWY/mmOqYrXlrv0kKT9+paYsVf5I7Fi0KDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588622; c=relaxed/simple;
	bh=XJ8vQsg6Pqet5Stbaps6xoWzycQyXkR/4sZeFwy7WNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQhhGwtmEwMQr5amLxzxuNxMXkvLnS96OUCGdjTUrswYgxG2IGPT/Z5zHB1q6ZX1ViTnhlNeEYKxj2G194IxgPQGHP8BYsN8ecvlIVxSMH0qOzZo0PjW8987jhRgAfjoxu6q1ZrD4zfweM3vp0c9HSt+IUuKz8RzJ+8WNOmW4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H2hpCL6e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7MOxb028317;
	Thu, 11 Sep 2025 11:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cKfvQERdgyV22QrYFwNzkGwvJr1ENg
	4WJVjPmFacFfI=; b=H2hpCL6e3L0MAaiDiLaUZT7Fe7lZ3XrAzSEZ0GUBCEIReD
	yTlFBrpFX//1OOC3SGh62Y+jQjVTVZR3G7ltjeIoOoJEDYz1zY7Ofb10Wd/pVEti
	aw1R0u4igPdRLPORJsjZwTfqAuDXOX6U/CAbA2v7GdzC2IFGJdTXG+2G4cyWIaGC
	dLaky/q4ux+8YZJdyCaKufkvCCMqfhTGcVp4N0MAyGyZfxxfcvGvKcob2L2FXKG2
	ulyXvGkRiSG5nrc9mrKyti/lyHb0uWOe0iw8wiuk3BH+fLt6XqwaOLHfIgwGpn9G
	y7PmmhewUpKm3HJxfeLmIXbtTJSs67EefCa7GNKQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx45dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 11:03:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BArk0Z009308;
	Thu, 11 Sep 2025 11:03:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx45dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 11:03:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BA6cKV010613;
	Thu, 11 Sep 2025 11:03:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn5c50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 11:03:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BB3E0H57278736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 11:03:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5161A2004D;
	Thu, 11 Sep 2025 11:03:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F74B2004B;
	Thu, 11 Sep 2025 11:03:14 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 11:03:14 +0000 (GMT)
Date: Thu, 11 Sep 2025 13:03:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 33/36] s390: Use generic TIF bits
Message-ID: <20250911110311.8894B08-hca@linux.ibm.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212927.373210812@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908212927.373210812@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xf-QCEe1Us0KQNKCgjmNJN5l6Yn9ZNy-
X-Proofpoint-ORIG-GUID: cRVhD-_cUFqI-TbPRQvMb3JpCXfLTj56
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c2ac79 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=IVuv_wK79--HeSKagDUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX2nqTbZQ9Dya0
 /Nt15FGtNZiUavOEBhuHtOYkrXkob/PEMcMVEYtX0KAld4bfv+NydOwtNJZ+ywo9wyVWM+bvhkR
 TlsXCVAd0jGWxRMRKC7zXTEZsX3ea5OiRPacM7uz8CfoYlUQNqa4f1j0aGSi+ho51mLNhU1qvw3
 xOtbiyLtPx/92ggD7TSnB12AdrhyTK6rwAl9KHhmiaKM4OlznzvEfduf5wq8QiqFYBVx5APtRcq
 P2jOOvHrGOrn1dN8AlR73WpqUFig5cnX/sPZj0Ewm5Cpmwc/NyPBy0mZ3VbMfySL/nwPYBJ2Avr
 BmcGTGEBHooJEmf9kw6Ejz31rRHIDxtrEy1qbprsYYI+AD75b+W5kcJ/PUC83hi5ZVmvYaA+iak
 PmI/TkiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Mon, Sep 08, 2025 at 11:32:34PM +0200, Thomas Gleixner wrote:
> No point in defining generic items and the upcoming RSEQ optimizations are
> only available with this _and_ the generic entry infrastructure, which is
> already used by s390. So no further action required here.
> 
> This leaves a comment about the AUDIT/TRACE/SECCOMP bits which are handled
> by SYSCALL_WORK in the generic code, so they seem redundant, but that's a
> problem for the s390 wizards to think about.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> 
> ---
>  arch/s390/Kconfig                   |    1 
>  arch/s390/include/asm/thread_info.h |   44 ++++++++++++++----------------------
>  2 files changed, 19 insertions(+), 26 deletions(-)

FWIW:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

