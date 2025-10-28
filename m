Return-Path: <linux-kernel+bounces-873018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE232C12D75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC03E4F1765
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49482980C2;
	Tue, 28 Oct 2025 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGOuvM1F"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607023506A;
	Tue, 28 Oct 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624545; cv=none; b=AZYLRlZTELffEX3vslWDMu/hCQ0Zg3+q6X9t2dGTR2kjfGmSaH36Pra89dct9lKM0oHOvONT2Dd559mSTVl3Nc9Ed8wamxzJ6wX16wa4Add3CoeSm+vrRwj92vub3CxCBJl2/YyyBQ83pNwkg2GwRfQmdf+AG3IjC8iDhbl5PA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624545; c=relaxed/simple;
	bh=E0QbIt+4QJ75rruQKtxHwYr8u03hGhhf0nJZzbZqKKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWGjrBUoQhnkYxgtUxD4G9gWILPfzZYtM8MHAYQ4sRWrW5ZopxLzaWN5aG1WwpK4rRirhmS3PlZhwO0j1ybzhNeluZpD/uKYbIO0FtaZvRYJ2C06Ps2tpOTIUMLWhPBOEM7+Odl+7saltnE65B706vANEtBz1EdfAf/RPZBUeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGOuvM1F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RG5CEU018332;
	Tue, 28 Oct 2025 04:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=SfvUBBMcQUBoZiNBe67HK
	jBuK6Dm/ZBmLaWAcaap4mE=; b=CGOuvM1F+T5kS0DOGAA1dVFZvYmeJNv4dyngf
	BrBEdbz9K2zj2OKx4Ht6jZJmvYvZGPPEVzPa65dtaOEqUsJvPhOm0uMPD2jr/ezC
	PWVy7Nlvc8heV7KYnQNp09hgWYmrOMfkrhFI1T9NytswSGLBLD2Z/nLNNdvzRsUv
	4hJ2K09gwwUOoMeNAktJNI5cNAVHFM7SIUzYzYRncK9yXDAQurQ4OwQmwUluVU0G
	V8V8YYY4WSsjT9y/h74T6h1wuTFEpo6XTFULMsjGr6An7OjUxNoXLc47lOWC+i+M
	MrmYdzf/h0Uj9KX6Kevn67aciiN76Ozg22cEwU5RscKcRTvWg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p991xeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:08:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S45hE9009753;
	Tue, 28 Oct 2025 04:08:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p991xen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:08:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2R3o0022023;
	Tue, 28 Oct 2025 04:08:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vs12nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:08:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S48fZK51184122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 04:08:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D08D820043;
	Tue, 28 Oct 2025 04:08:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CE320040;
	Tue, 28 Oct 2025 04:08:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Oct 2025 04:08:39 +0000 (GMT)
Date: Tue, 28 Oct 2025 09:38:38 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec: Enable SMT before waking offline CPUs
Message-ID: <aQBBxlZebkLDhi2e@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20251025080512.85690-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251025080512.85690-1-nysal@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=690041cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=eMohRQ-KdQCHCDRkyAgA:9 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: t6S93ipUKAohD0zxwgjOAjKz4Lz5HzZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfXytRsWE3y5MiL
 cLymIho//XHObODNhoDqSk755gVf/wGRaaB4aw/GKUCfAXOBrxQNL/5U9dmtNjTRc1NusopCVm8
 p5dt/NOKfbSPVJIzXlTdwCMqMlkfdW8AQeJWUi1LQGb6G9a8GjpHCUQCTWBuhAVfSKD3vf9dFHh
 PW662LWPWr/IFJmquAHceEOv2qQG/KykEpcV+TPjxaAeXi9VMS56+OuYraz15aqeNd9dpuQPnT4
 KM7yShxtocfo0nGFsjMuBUc6kZ7P3gLco/JTdNBLyO14kyMFg5b45D/TLFKiscJMdLym+Qs9IVx
 cRYn7Zf/jtRM4wjx0KX61MVnwvcGB1F35Mg1M0TS8WhP2JbTKTi6RglcAK7rlrgBo2TeagMCByS
 Kfo/fbXz0GSObpOBjO1KY3WXS5wHKw==
X-Proofpoint-ORIG-GUID: OAhCU3nbnwm1qIWiPiQBU9lbZaSH1Nz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

* Nysal Jan K.A. <nysal@linux.ibm.com> [2025-10-25 13:35:09]:

> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 222aa326dace..ff6df43720c4 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -216,6 +216,11 @@ static void wake_offline_cpus(void)
>  {
>  	int cpu = 0;
>  
> +	lock_device_hotplug();
> +	cpu_smt_num_threads = threads_per_core;
> +	cpu_smt_control = CPU_SMT_ENABLED;
> +	unlock_device_hotplug();
> +

Nit: can we add a comment mentioning why we do it and probably move to a
small helper function of its own.

Otherwise looks good.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

>  	for_each_present_cpu(cpu) {
>  		if (!cpu_online(cpu)) {
>  			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",

-- 
Thanks and Regards
Srikar Dronamraju

