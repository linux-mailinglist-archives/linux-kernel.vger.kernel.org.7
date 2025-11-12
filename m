Return-Path: <linux-kernel+bounces-897665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86814C534D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FC3D34FA12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BA2BEC57;
	Wed, 12 Nov 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PoiVye9B"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A423B628
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963350; cv=none; b=HiD4Pa7gERJVmApH+x7M/XYmGeX41OILrdAK+C74nHr8TlkyDjlxcA+beZue1q01XNH4ccVlyi3f38gDwlb9oDz8iaZmEeVgZJ9jH2akd2tes15ngNsUmcNl90q9KuM+WxwLzyBZgbhWcKJhatPBOrXZNEkTeRlXqoPOzO9DuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963350; c=relaxed/simple;
	bh=vp/2VJWSfqVh12oPsILpOuMwHd5ZiB+o06aInqUYoso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBu0djJALcSvQItL9ltTcA3P6xgEkojy75ocKo8VldMb93NBseYNcjD1od5HWLsqNgJsPXT249XTmwsbUAr1YfKMAMsl7vDEcZqVohj4AYKr45meGI2dVVMbj1icW1gWOKKNhf00iRJUe+SR3wVHe2+t2HQne/PAlvFhrnNFBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PoiVye9B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC7qtYe017488;
	Wed, 12 Nov 2025 16:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=Ted2njs37hU0xdg6rRLPH
	o6Wns8dlDiyAg/GbhjpzG0=; b=PoiVye9B6+VfD6YW3iA+fO5X/GAyH1czjE07z
	F11Cwqh4XvvCE+++WbkgHre1eJVjV9VvJ9V1jUBarobU51J92Zr+t7X3Tcf9y67+
	GHTk6413iMCzGnVL+Czj+LtSOxQ0YBloCi2yQiUDy776pIHpbByQ3v0GL1mwQIFN
	uu/rvMQ0xM6tb5UgQwMT5JZdPyQHmJ4GunahtYDX8HgfK2MBshWcv4X395S1ZX5G
	61jj4l9ax3zvhB+Eu1qYWWKDj5xKfpSLlVGY2A0XmD4f2/t0/+VVcOYuL2TMGEOp
	Ix+73HiDpHLdBw3B6Mscpoi8fmsFdt97Ss9qB7RmNt3txQbQw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8bds4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:02:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDVFLX011600;
	Wed, 12 Nov 2025 16:02:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1grkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:02:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACG27wH46399822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:02:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E529E20040;
	Wed, 12 Nov 2025 16:02:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D524220043;
	Wed, 12 Nov 2025 16:02:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Nov 2025 16:02:04 +0000 (GMT)
Date: Wed, 12 Nov 2025 21:32:04 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <aRSvfJmQTGfdS0fc@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
 <aRRuvLKvMdxw8bZV@linux.ibm.com>
 <20251112133937.GC3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251112133937.GC3245006@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX5O8UUrcG0Ybq
 egTGybOnec9lr9BG3C8CJNjR2mRRdHzfOwe/rFSsUfX09d6afU+PKnUqghN+E0+oeodElj6rhdV
 cioUYUBwo0ImCiNyhrHnjjt9cOz8h6uvCClRGpo1o3Qx51FnyPAQwH2KQG7mLDczJQjZO7EzsQF
 ad4CnxTXwlQ696CD77Z+kF//94+S4Dsz9BIa999DKzIcOat0e9BccK5GzLjvcsCkyYBbk3EGQ3p
 y9oCk+Fm5k+EJ4I8vCyeygl7kMyNcXwwd66KfMmQc/qmWJ3Dr27oCx/gARMGU0e33NttynNb8gV
 RO4fjYNzTtwlb6HQPM5FK6vM12k6LvhxTCWxEhiZQ==
X-Proofpoint-GUID: 5ceS2ck4-kEaR-Ow9u0u6R9T8Shi7PJC
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6914af83 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=EpNTt7i5sTin09BLJkQA:9 a=wPNLvfGTeEIA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 5ceS2ck4-kEaR-Ow9u0u6R9T8Shi7PJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

* Peter Zijlstra <peterz@infradead.org> [2025-11-12 14:39:37]:

> On Wed, Nov 12, 2025 at 04:55:48PM +0530, Srikar Dronamraju wrote:
> 
> > If the CPU that was doing the balance was not the first CPU of the domain
> > span, but it was doing the balance since the first CPU was busy, and the
> > first CPU now happens to be idle at redo, the scheduler would have chosen the
> > first CPU to do the balance. However it will now choose the CPU that had the atomic..
> > 
> > I think this is better because 
> > - The first CPU may have tried just before this CPU dropped the atomic and
> >   hence we may miss the balance opportunity.
> > - The first CPU and the other CPU may not be sharing cache and hence there
> >   may be a cache-miss, which we are avoiding by doing this.
> 
> I'm not sure I understand what you're arguing for. Are you saying it
> would be better to retain the lock where possible?
> 

Yes, I was supporting keeping the lock and not check should_we_balance() with
lock held.

Lets say CPU2 enters sched_balance_rq(), should_we_balance succeeds, CPU 2 take
the lock. It calls redo, and this time should_we_balance() may not succeed for
CPU 2 (since CPU 0/1 is idle). However CPU0 may have already raced with CPU2
and tried to take the lock before CPU2 released it and bailed out. So we miss a
balancing opportunity.

> 

-- 
Thanks and Regards
Srikar Dronamraju

