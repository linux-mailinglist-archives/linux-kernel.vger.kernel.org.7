Return-Path: <linux-kernel+bounces-750389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54913B15ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFDC1883429
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69D2652B2;
	Wed, 30 Jul 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sv3nk2Ab"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143635971
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864434; cv=none; b=HqxVLs2dz0Vu6J4vgHZB+1sJFvqv4THFWiNQPvC3hGgc3ZKG3sAZsss5OblOgGP6bFzblbYP1GEmh9HOgnFigfFlDwjCTD2OkRVEyCACtHeegsDXkFdy7hd2H2KmaDbJtUA3gLwXtaVS6UP8qVN90/GNDWqlp5DqiiHArAfTHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864434; c=relaxed/simple;
	bh=/CEhQOAat7v5Jg1zBNfpQKa6ptwQ12A6UPlGCTUsMqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8LhWt2XF0zOT56Y5NRP8xZNydd7w5JBUSn+gOsYcDBDIH9K5eFZUikjKqNIIlVOwHHv2gxrJpDMd/nKXxwBY4etbfK99bbe4Vq0xtcDjsVsvZVwHCFVEbuI9iDF/NnlfizYE6QdQkcl/6e9QukpDsNkDerkh46DV85ftfxc79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sv3nk2Ab; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U0knd0021843;
	Wed, 30 Jul 2025 08:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dt9jR8
	QiUK88lCjFXNLtmxPAcSGZTe27UFLY4HQiQM0=; b=Sv3nk2AbHUaa4pHvc83BEu
	qzrjgECrFUfSIawSgc7+lV39ijm9wSXgylGc0fkPADxrQhJXtzE5rbmg4JnQ1SIr
	babAWeZcG315Pvnr5X00G9X0uBPtigCY94dbns72CiHHmEFwqCJZiQhhir7zSpy7
	svhjTR4ewgzxifdzS7/b+n3HaqOusd1TCo2rGxl/iPGLyPZkZ5KXrjjVEEdRV29o
	hitcMrjtfVChYdcYyap2uRH3tWJzkngGKPCRbOQMVUUGguSWsn35NfKrD8X2gPRr
	RKa1ZvMMtV0NtiPo1eQyBk/iViCq27thHU+Wgp6Kf26bkMaLTHjGYQvFssOFmFOA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemuj71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:33:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56U8PIDp029649;
	Wed, 30 Jul 2025 08:33:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemuj6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:33:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6NAln016005;
	Wed, 30 Jul 2025 08:33:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumpfpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:33:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U8XZKj50725344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 08:33:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ACD220049;
	Wed, 30 Jul 2025 08:33:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1C9920040;
	Wed, 30 Jul 2025 08:33:34 +0000 (GMT)
Received: from localhost (unknown [9.39.23.62])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 08:33:34 +0000 (GMT)
Date: Wed, 30 Jul 2025 14:03:33 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/qspinlock: Add spinlock contention tracepoint
Message-ID: <ajtwxjuidgib2tixuhtykeucyqflyn4ta3f3vdedjbzqsbpykn@wty7zcswiqyr>
References: <20250725081432.1254986-1-nysal@linux.ibm.com>
 <7bba99d8-b171-4ac1-a33c-4c086f3684fd@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bba99d8-b171-4ac1-a33c-4c086f3684fd@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yVW7lf3hsXfnMlGiQ4q_yGmx2SGhCOK1
X-Proofpoint-GUID: 8qpdR_IPP_Se6ZLvBjWXR6il40gX1Jxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1NyBTYWx0ZWRfX0g4DzMTmSu8S
 gmAQ9uzZH5jR1Su8Tdxy9KBFS15bUPDVJJOlnokpMlWECA025fptdifa3fIKN+4iArW7BNK0Y8N
 E4yU1u9unT6HtIQU6k4OAAz39qk6OoggQLMtFTsMISEo49R17VVwm8K87hXhtSbd8BkuG/FHGYL
 EsvRDBKcNEDC3CaC4Im4XjT/6H97Dd0ISSNModvT6xTID4zdv4mjJXH24kZ3NjM/y007E2KJaNF
 j1crjdahufZL5llyHFrBIuSaC4t6lWR8cRHPKBOcPWYrKRLCP5WaZH+O/C8dq/6l+Uq6s1Q1ocN
 LX2p6Oow3b9q0CfDAzhrVK48AIfNdTW/06NJx9/QfQlflCVtr3vZunqkD056aoVdJdRl89Z7vhg
 gGGpzI0ATKYAL64L69NpsD8PIsRw2lVoAwsWjFp9Q+XNa3ycRAVsCGBruAf0/xQN3+sLYcqw
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=6889d8e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JZGb1Hen3STrfkKHDJAA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=mDVER0IZTAoA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300057

On Wed, Jul 30, 2025 at 08:46:28AM +0200, Christophe Leroy wrote:
> 
> 
> Le 25/07/2025 à 10:14, Nysal Jan K.A. a écrit :
> > @@ -718,16 +720,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock)
> >   	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) && is_shared_processor()) {
> >   		if (try_to_steal_lock(lock, true)) {
> >   			spec_barrier();
> > -			return;
> > +		} else {
> > +			queued_spin_lock_mcs_queue(lock, true);
> 
> If I read correctly, now all this is single line so you have to drop the
> braces , see
> https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

Will fix the coding style in v2. Thanks for the review.

--Nysal

