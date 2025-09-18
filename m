Return-Path: <linux-kernel+bounces-802171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51937B44E74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1155A54245B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD62D320E;
	Fri,  5 Sep 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VoXxllUZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7792D0C62
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055464; cv=none; b=dvI3I1YCU+vQnzlTrq3k/ZSxMYsoJeBtUVcX5NjPGhZHpbIew5OGywcYjhPxZqJvaoxIg44ZH4vYPl8eKSTbtksmi4p5v3prIeo/As106SeDcseRlvVlz29iague4HoFLKai7Bm/tkDJ70yn9OHyeVvE1CeNJBhUcTxJK0W5Nyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055464; c=relaxed/simple;
	bh=symcSdEcMgL3wu1d4IhrGnXzfSncHVDnyjcq9WEZlVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1xnJ75GxXyKmv8eonPYgf7kYvGkmo7JRUDpbT5M46Su+K+PdSe6U5jNTtg2xNC4ozg0FJycsWxEi0jcibipvcpXyWpH168UYF5ZlZ7MISetAj63J+6/fmT22ZKrZ7py0nYjGDDHX9WHjH5CZOHSjt6//xCuxnZmY7nQoUtlDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VoXxllUZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584K5SFc012012;
	Fri, 5 Sep 2025 06:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i6iIRw
	lL08m7ddD00gWRDzn7fpP62voWSOHllYdsQfM=; b=VoXxllUZm8+7DgckRp/NLN
	zPYc8QI+ZJf5ogWCoo7J5wJRm06a8olnHUjPs5I4lnlQ1pJ2SVDXYCMOnl1yfuDz
	IRdUBU3ovvzTd9CfzMYu9JseXs2+QDOMHsAXJERd+pwKPw4qWWv5Nh05Lk0kuKMb
	46dkr7qUULAlXRms5uaUgiq6a+zMEoSr2LXCiAxDfEsdKasNhfI/FN9cYaw285Ob
	x34bbjE+AK7fRdORJ6RsxSgN4iQ9EKI6yPsoJfx4kQHbj3BEegmP0XJr7zU4h6BQ
	G7S/9kusQKbeFzhqa1bl7UvW7gePEjBse2wfS38iWiCCFJxDKgV/m2SrjoqE+biw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurerb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 06:57:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5856vGnm000584;
	Fri, 5 Sep 2025 06:57:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurerb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 06:57:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58567HMB014052;
	Fri, 5 Sep 2025 06:57:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3qy6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 06:57:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5856vFrs27919074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 06:57:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4191558054;
	Fri,  5 Sep 2025 06:57:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D502158060;
	Fri,  5 Sep 2025 06:57:12 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.90.171.232])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 06:57:12 +0000 (GMT)
Message-ID: <977ad5eef4f8726e9d5bff31b758918f0341659d.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup
 failure
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman	
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan
 Srinivasan	 <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard
 Furtner	 <erhard_f@mailbox.org>
Date: Fri, 05 Sep 2025 16:57:11 +1000
In-Reply-To: <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org>
	 <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfXzvkHakOeeGWc
 xIxAT6pze9qsFX2mdazJPm3UogZYYT8H/DDeR0e3NxWMqNV+L/KW/42Mqwo+Vj4yLHIwlNsxCRw
 y4Cx1kEVZuv6j3lI0TcUCBHkL7YnImsOkm/1JuLhTws//g8cUABTtC8ph+r1EC+TalhoX3WG9v+
 pvrcoWem1opzF2XFSOCtmMEht2oey7X0tS6pHW7HV47XoRLT4jer/ihdax65sHV//YjCa1ADgP9
 qtuClyebYb4sdNW+ig9lIGnicxh/e74/+EmIYPkG1MmVz5u/HtnuamGZuCVlzOn+BTdTWM5DVrF
 AAuvR8dr4sH6JcM8jC3uKEAH7/Fu6+vDPPx3x/OlXoNOAP7Eci/sRHqssn/lmEp2fs9aBD5TIuW
 M+MFTaX+
X-Proofpoint-GUID: HLJBueF4UV6soL6npRI4I6Onc-nK5ppq
X-Proofpoint-ORIG-GUID: O4JRA3B6Hh-HfKmWIdX2yTs_2TdtcoRY
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68ba89cd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=b3CbU_ItAAAA:8
 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8 a=kZQNDw5qEIdUIES3TQEA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

On Thu, 2025-09-04 at 18:33 +0200, Christophe Leroy wrote:
> PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
> kernel text has to be mapped read-only or read-write based on build
> time options.
>=20
> But nowadays, with functionnalities like jump_labels, static links,
> etc ... more only less all kernels need to be read-write at some
> point, and some combinations of configs failed to work due to
> innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
> we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
> access to kernel modifications.
>=20
> Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
> possible options that may imply kernel text modification, always
> set kernel text read-write at startup and rely on
> CONFIG_STRICT_KERNEL_RWX to provide accurate protection.
>=20
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes:
> https://lore.kernel.org/all/342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.=
org/
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

The original issue that Erhard and I were investigating was why the latest
version of the PowerPC page table check series[0] was failing on his G4, wh=
en
built as part of a config with many other debugging options enabled.

With further instrumentation, it turns out that this was due to a failed
instruction patch while setting up a jump label for the
page_table_check_disabled static key, which was being checked in
page_table_check_pte_clear(), which was in turn inlined ultimately into
debug_vm_pgtable().

This patch seems to fix the problem, so:

Tested-by: Andrew Donnellan <ajd@linux.ibm.com>

But I'm still curious about why I only see the issue when:

  (a) CONFIG_KFENCE=3Dy (even when disabled using kfence.sample_interval=3D=
0) -
noting that changing CONFIG_KFENCE doesn't change the definition of
PAGE_KERNEL_TEXT; and

  (b) when the jump label ends up in a __init function (removing __init fro=
m
debug_vm_pgtable() and its associated functions, or changing the code in su=
ch a
way that the static key check doesn't get inlined, resolves the issue, and
similarly for test_static_call_init() when CONFIG_STATIC_CALL_SELFTEST=3Dy)=
.

I don't understand the mm code well enough to make sense of this.

[0] https://lore.kernel.org/all/20250813062614.51759-1-ajd@linux.ibm.com/

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

