Return-Path: <linux-kernel+bounces-723558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C0AFE877
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F196188C6AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879D2D7816;
	Wed,  9 Jul 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hAmlTouG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68F293B5F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062263; cv=none; b=jmeh5G/sc4k5RkOei+AVG/ucWb+xckSuPBqVEEA2/l/+3xLQn8I1niRntxEPLhio3c96K1yv+4HTTDeqOg1VrnqQ0Io91LIaVZoYM8F8lduEtvYHW5/lywAgYCU8ZRoHspqpXJV6XHSq300X2lYgIVd9wYTvLdgkSPh3ZE1rAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062263; c=relaxed/simple;
	bh=DfgR30I2lf04DIbq2tD0AhSVnvtEphJ0BGIhbSlX76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj6PPTEJK2BV+GrhsphL+aeMokwM+9+ly48g+WIjyGGNtz0xcdqh/wJT1wU8QvKdY+dP8TOiVHnd0Yui/qvyX3qwIhmojPUNmiHRSzWvp6Vk3Ll6Nmqg6XnaaORKBNEaBjQ19wvejnrtefh1yIMJgwb0fzTQG4JJUJZZkUdVsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hAmlTouG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5690kR6i001435;
	Wed, 9 Jul 2025 11:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qcNCDNtuuW0WLjG7jvwECNlt0GNnOp
	RwRBScQe/vmzA=; b=hAmlTouGRNFT+boMbtrQxwmDg429k3byt4tQYvNAlncnLi
	Oi5Y+pjI4EVnejqVfVxHTsFizrU2lDABr7mQQak1JHCa93WGy3ae15e3GUH7Sovx
	ChpRifycIeFzTf6z+xx4+Z5ZX17TVepO2sjFxtHIQ4tRZpuEOpE+D37rCmaHiZnA
	2BLXcjNg/VAEMJjtJM/qaoTuaOYwM/6Uf8XwsP+rYSB1kNjRo4u2wNivhOYT9qHm
	pXyd3MVETsA/7KCb+8mWIp/m3U+gV8G5tY92Tz/KX7b99vOPbES/gpUTozs8Tsd2
	MmgXdeQ8riN3UJqXIwqlS+Lr+iL6DfT7/hccbgog==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss62qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 11:57:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5698U70m024678;
	Wed, 9 Jul 2025 11:57:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32fpm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 11:57:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569BvWKv19661304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 11:57:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F29C20049;
	Wed,  9 Jul 2025 11:57:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014EC20040;
	Wed,  9 Jul 2025 11:57:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Jul 2025 11:57:31 +0000 (GMT)
Date: Wed, 9 Jul 2025 13:57:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <kees@kernel.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 02/23] regset: Add explicit core note name in struct
 user_regset
Message-ID: <20250709115730.2052203A34-agordeev@linux.ibm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
 <20250701135616.29630-3-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701135616.29630-3-Dave.Martin@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686e592e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=z4glEzOvAAAA:8 a=VnNF1IyMAAAA:8
 a=ADyOPYUCMA7AYZvlguEA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-GUID: ORTEQWa1UO5H9lrAlOVaqlIjnzlNrI2b
X-Proofpoint-ORIG-GUID: ORTEQWa1UO5H9lrAlOVaqlIjnzlNrI2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEwNiBTYWx0ZWRfXymBP60/qHIj3 kXORl4cIyWX1IQPfMQhwe7/Whd68gUrU48xyQCLvqUJEm9OSvj6JUHU//uSR3wi8sKZtQwyAaK6 I7gUs2bcyv1P4s15Elhx0FRXr14GyIrI0IUgLAkwom8X5h8kw1/sAFFR33B1VsjH79VQLzHCRnD
 syE5owtR8WsXhVf6E6T1SAm+mnhjQll3cmHE7Yf0iaV8/ScZjbbBIHQsRdVUGazITWTDS0fX0KQ rkUDbrT+eYIZGJDNawG+s+3phpJu0fNmMf8enf+ZosqKvswEq8Dc+iymL1bb8ssrf1lFE39d9nK FWg1fRjBanRZkRuTwUa1I6ej7wuKoJWhpgLXIyv0+BJd/VsQgJCPOWBxP+yo8uMWx0wFQVpQmSQ
 OEZztL+n4aeSur7rb1WXEu02FVDfAa+/MTX114uNlW4XwDYFP4G0TpDwVwv3pvsz/FquYQxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 priorityscore=1501
 mlxlogscore=-999 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=100
 spamscore=100 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090106

On Tue, Jul 01, 2025 at 02:55:55PM +0100, Dave Martin wrote:
> There is currently hard-coded logic spread around the tree for
> determining the note name for regset notes emitted in coredumps.
> 
> Now that the names are declared explicitly in <uapi/elf.h>, this can be
> simplified.
> 
> In preparation for getting rid of the special-case logic, add an
> explicit core_note_name field in struct user_regset for specifying the
> note name explicitly.  To help avoid mistakes, a convenience macro
> USER_REGSET_NOTE_TYPE() is provided to set .core_note_type and
> .core_note_name based on the note type.
> 
> When dumping core, use the new field to set the note name, if the
> regset specifies it.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  fs/binfmt_elf.c        |  8 ++++++--
>  include/linux/regset.h | 10 ++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390

