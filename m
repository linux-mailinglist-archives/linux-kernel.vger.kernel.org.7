Return-Path: <linux-kernel+bounces-875087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265DC18312
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC425353B59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF71D63F7;
	Wed, 29 Oct 2025 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zja2bjye"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0221D63EF;
	Wed, 29 Oct 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761709024; cv=none; b=WLu5Y2tKKocvNW4f9C13XzUCprEJ27PXZ9SdHpOLvgPRSvWB7l2Gf06TO3ONzl+dtZO2x97CO6tN/JFrzlkLXfCFd27P/JVuBqBnu0rsAOnTuCyKvA5F65kWJkWmt/gNaj7KPdPfPnRhd57BP3RDNXCRAFnTVwyqvyPlIzwzc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761709024; c=relaxed/simple;
	bh=JsCEz7SzYUh8SRB7/FN7skKARlT8LKYCZc3aWMrN5Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yai2dWO355ueA3Xfj2clLYWVcuqY1Dwqzcz92X+Ffjvvoqs0Ah6y6+2M7GNra/nCTr+tJHdwhlgiSuFOT7CGMZbnSgG0hP9cA/v0PAgbkXj54vg3WLNf95lntPLB6eNXndIR9iTUAso1gD6xn0vVHYiFoJI7AxoYa781bwNeZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zja2bjye; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SNNCWH005139;
	Wed, 29 Oct 2025 03:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QzMvpTHaJmVKbIXvoFw0cw6ZziWr5D
	OyEsikXtCGN78=; b=Zja2bjyejZsSyWZU0YbnY+z2mr+9BRh6vlNvXfIw56P4Mm
	0sjNDYDdovzSqLzkL/L/GfyF4OnGDdiMnt6iIfLbPccCGN25PFKaRRgV5r3tjOkZ
	Mi1C2Td78Jnvy8QafBojMaK8eWJcmyxVeAuQRxk5A5t80IKkvCFRxYTEX8b795W4
	kmD4SRCo6wfW/bm4SrLO0H36El5KJK8ir5oURJ5ALSAkshleyZcqNMhmwtjYp2LZ
	4Ur1KBUbax30eJtCrlPLbfkedtUefH8XpVXNXLVBb4NWCMM2gQcwjueZoiR3mIBI
	+DWCHylNIARRxe8ASetpgHZicDrvZPPOUzQ3gbiw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajh6v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 03:36:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59T3ajCS008179;
	Wed, 29 Oct 2025 03:36:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajh6v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 03:36:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T02Xwo019157;
	Wed, 29 Oct 2025 03:36:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy1f7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 03:36:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T3ae1m60883382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 03:36:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43D5520043;
	Wed, 29 Oct 2025 03:36:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D331420040;
	Wed, 29 Oct 2025 03:36:39 +0000 (GMT)
Received: from localhost (unknown [9.43.31.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 03:36:39 +0000 (GMT)
Date: Wed, 29 Oct 2025 09:06:38 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
        Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/kexec: Enable SMT before waking offline CPUs
Message-ID: <knhs5gainynhozku6kb2ygxy63gyy73sbnqg3vcizk45oatzry@uig2z3mlux5u>
References: <20251025080512.85690-1-nysal@linux.ibm.com>
 <20251028105516.26258-1-nysal@linux.ibm.com>
 <f19a9080-8d6d-492b-b5de-88f24ce5c015@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19a9080-8d6d-492b-b5de-88f24ce5c015@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=69018bcd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pdyEjUt-03yZH7Vt8f0A:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qGox9TmZr_I6z2dz0QchiiIJ8wqnTGgu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX22qf3S+UnQPN
 So4IyXKzEu1wspyocduwEdhAEGFLdlo51zS10xNVniKwDVmrfQVQTBRxIDe45Fp2JZoUc9V4KyK
 WDov73i8L/xRVe8349Vpn2AKUM0WWaEVHp6Ss0YcsNcR8i2bzQhfROm3Mr6hx3tCxLSNytuAOdu
 GKtfd3TRWEKD71KAcfj/48sObrZy51dlRM4/iOQu+iU+cnP+R+KnuoyMIsnYE3CqlcXqGVcbgKl
 Y3I8FpKN82HHkxHw/TH/wrhZe1XmXxrgXJNNJyhs6yTp4GeG52SmRQOy06vpagvDudThhvY6Wuh
 OFkVjdu3q759X7ZXw2Jgt8zuS3l40+9Lqi9HgS4SFJAHixDTTrWk3sE6vkyuewRJnHEWW/JXp6E
 f0NHcYnexMButBwO7mm+zfnTnPsvpQ==
X-Proofpoint-ORIG-GUID: jQY3FGIrBfmGOWdrz3YpfNC3vzFNxcKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166

hi Shrikanth,

On Tue, Oct 28, 2025 at 10:56:05PM +0530, Shrikanth Hegde wrote:
> Hi Nysal.
> 
> On 10/28/25 4:25 PM, Nysal Jan K.A. wrote:

[snip]

> > --- a/arch/powerpc/kexec/core_64.c
> > +++ b/arch/powerpc/kexec/core_64.c
> > @@ -202,6 +202,23 @@ static void kexec_prepare_cpus_wait(int wait_state)
> >   	mb();
> >   }
> > +
> > +/*
> > + * The add_cpu() call in wake_offline_cpus() can fail as cpu_bootable()
> > + * returns false for CPUs that fail the cpu_smt_thread_allowed() check
> > + * or non primary threads if SMT is disabled. Re-enable SMT and set the
> > + * number of SMT threads to threads per core.
> > + */
> > +static void kexec_smt_reenable(void)
> > +{
> > +#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
> > +	lock_device_hotplug();
> 
> I was looking at usage of lock_device_hotplug, looks like a good candidate for
> guard() use case. Could be done on its own patch/series.
> 

Agree, we can look at it as a separate patch.

> > +	cpu_smt_num_threads = threads_per_core;
> > +	cpu_smt_control = CPU_SMT_ENABLED;
> > +	unlock_device_hotplug();
> > +#endif
> > +}
> 
> 
> Will this work too? It might be better since we anyway going to bring that CPU up
> by doing add_cpu afterwords.
> 
> 	cpu_smt_num_threads = threads_per_core;
> 	cpuhp_smt_enable()
> 

There is some reasoning in 4d37cc2dc3df, which made the switch to use the core
device API, against calling cpu_up() directly. The other issue is 
cpuhp_smt_enable() can skip bringing up a CPU in certain cases, for example
when a core is offline.

> > +
> >   /*
> >    * We need to make sure each present CPU is online.  The next kernel will scan
> >    * the device tree and assume primary threads are online and query secondary
> > @@ -216,6 +233,8 @@ static void wake_offline_cpus(void)
> >   {
> >   	int cpu = 0;
> > +	kexec_smt_reenable();
> > +
> 
> If we do above, just change the below logic to complain if any present CPU is offline.
> 
> >   	for_each_present_cpu(cpu) {
> >   		if (!cpu_online(cpu)) {
> >   			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
> 

Thanks for the review.

--Nysal

