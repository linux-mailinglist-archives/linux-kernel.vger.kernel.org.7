Return-Path: <linux-kernel+bounces-742358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BEB0F083
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147283BA2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C42BE047;
	Wed, 23 Jul 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bsKEdSl5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35827145B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268282; cv=none; b=p+T7Xu/vi2KaVN1Mj0UtCcbCp9C9OJPz69CPQhctgB8mlJg4QHK44Sln5As+je64Cnr9ZlpXXJhEGcGXZ5Zpng/beUW95LjvGGmqZAyAnmqtIDnGQzj6TjDJD3Su8iruam+HNiA7Gquca/QD4AIDLZ0uvoiBwrHxz8jUhVRuYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268282; c=relaxed/simple;
	bh=yio4bKtCHHxjLZTNZts8ENegqSXZYGTSiXxuL9gIjCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BajEFlDCFaeCEEFhzvPhiF9hgTfzm67Lp1crK7nHoCs9OrIWzAnbjn34Ybxx5jFkffhOkCMQbYczgYvKrgvJQYFs0YHXmRXUgk0lNmT6JY08tv5IIlV0lOBUzH/EQwGETJtHrHnI4AsjMWup4ZFshzZS7Le7+qZmc5Win43QE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bsKEdSl5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N59BG0013587;
	Wed, 23 Jul 2025 10:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HmYZVjbyn/56xbubiO6EhdIVOZXt7s
	+aZl4Zmz6+/qI=; b=bsKEdSl57eXjSxRXLbC6WXb7PobfgV6LDr3jJSPo8JdhQW
	oqQwjkdHB/JH11d1yFsUMKzavXYTntH0aNPmJ5XEEQV+DmRZwoH8QFtEeQGzBsbq
	4rGDHGQdmam/Q0dUfH9L4JUmqmN0bdS9yFhOBRby5/tiyLCBYynQqZUIGP8zV6+F
	pRtDHmWdILJorLjhXsXNJTv0HjavC1TqIRZYDXcRDPQJuXbOf8ljAu/8+IZ9tSuH
	D9A88j10A4Wncuhs9T1SVEZhsSlDplor87oDiEW40EGUho0RInXslJRVjo8oWL8b
	J34XkZkZArkKCJRzgVmIlHqrpUlRCo9Gfkivj9uA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqc903-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 10:57:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56NAvM6O031350;
	Wed, 23 Jul 2025 10:57:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqc901-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 10:57:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N6ZjWN024960;
	Wed, 23 Jul 2025 10:57:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptqmrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 10:57:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NAvJSO29557486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:57:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2FA20040;
	Wed, 23 Jul 2025 10:57:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50BBE20043;
	Wed, 23 Jul 2025 10:57:17 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.210.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Jul 2025 10:57:17 +0000 (GMT)
Date: Wed, 23 Jul 2025 16:27:14 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] powerpc: Cleanup and convert to MSI parent domain
Message-ID: <bbrzleahvv6wliau6nxv2un42yzdmbruwk6wiahxr7mpsijojm@2nlqjklj7rjv>
References: <cover.1750861319.git.namcao@linutronix.de>
 <aH9Na8ZqrI0jPhtl@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
 <20250722092402.uMLOYoII@linutronix.de>
 <20250722203145.Y0vncMx8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722203145.Y0vncMx8@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5MCBTYWx0ZWRfXw8nUqxh4FUs6
 +vV6To2j+iXb8ME+58BT7zCvV14XXcL3C+us9bnlN8eb6+yD+PZS8obDkgZY681j3GLKop88h26
 KepWXzbUdfJoXQU1YKBN+c/bmqkbM/ONWlfnFKTZV3S9NLFcjfHwmWCAx/rmv5wwxSvY4LpdJ1m
 hCrOyJBmsHmP1tc40vVxhiqLlWAaex09ygXHPeNmTHNSOdkYtctKAWUnZrSlVOXGEAeq/iwnXKL
 DzGirn9pxKz7QbIJrGgTVMcMssbMaeR/heClxeW84XsOv2yWyeRURLO7+XPJgNQ6Gry9K50UdyL
 bu+NouPxFYNTBTzlearGaJEeZko1ccSLjj27QGmYkZkcdiuaVE4gTcDqVwrDAf6Bz+yednNqfFB
 PXh4bG0dS2i9wRM9DPo5UDny98zJUVbT5XwsxOyWssWyOzhc+925MY21PntDdXWl7qd5Y5nV
X-Proofpoint-ORIG-GUID: JeA0vygor0IBmuDLrqLzpFZJDUdy0Ine
X-Proofpoint-GUID: EQa5tpun4acodpHEOBmpgq3QMdRwVn1N
X-Authority-Analysis: v=2.4 cv=eqvfzppX c=1 sm=1 tr=0 ts=6880c012 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=i5QKhxP1xTtVzj4-mKQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230090

On Tue, Jul 22, 2025 at 10:31:45PM +0200, Nam Cao wrote:
> > On Tue, Jul 22, 2025 at 02:05:55PM +0530, Gautam Menghani wrote:
> > > I am seeing a boot failure after applying this series on top of the pci
> > > tree [1]. Note that this error was seen on a system where I have a
> > > dedicated NVME. Systems without dedicated disk boot fine
> > 
> > Thanks for the report.
> > 
> > Using QEMU, I cannot reproduce the exact same problem, but I do observe a
> > different one. They are likely from the same root cause.
> > 
> > Let me investigate..
> 
> So the problem is due to the pair msi_prepare() and msi_post_free(). Before
> this series, msi_prepare() is called whenever interrupt is allocated.
> However, after this series, msi_prepare() is called only at domain
> creation.
> 
> For most device drivers, this difference does not have any impact. However,
> the NVME driver is slightly "special", it does this:
> 
> 	1. Allocate interrupts
> 	2. Free interrupts
> 	3. Allocate interrupts again
> 
> Before this series:
> 
> 	(1) calls msi_prepare()
> 	(2) calls msi_post_free()
> 	(3) calls msi_prepare() again
> 
> and it happens to work. However, after this series:
> 
> 	(1) calls msi_prepare()
> 	(2) calls msi_post_free()
> 	(3) does not call either
> 
> and we are in trouble.
> 
> A simple solution is using msi_teardown() instead, which is called at
> domain destruction. It makes more sense this way as well, because
> msi_teardown() is supposed to reverse what msi_prepare() does.
> 
> This would also remove the only user of msi_post_free(), allowing us to
> delete that callback.
> 
> The below patch fixes the problem that I saw with QEMU. Does it fix the
> problem on your side as well?
> 
> Best regards,
> Nam
> 
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 70be6e24427d..7da142dd5baa 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -441,12 +441,12 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
>   * RTAS can not disable one MSI at a time. It's all or nothing. Do it
>   * at the end after all IRQs have been freed.
>   */
> -static void pseries_msi_post_free(struct irq_domain *domain, struct device *dev)
> +static void pseries_msi_ops_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
>  {
> -	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> -		return;
> +	struct msi_desc *desc = arg->desc;
> +	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
>  
> -	rtas_disable_msi(to_pci_dev(dev));
> +	rtas_disable_msi(pdev);
>  }
>  
>  static void pseries_msi_shutdown(struct irq_data *d)
> @@ -482,7 +482,7 @@ static bool pseries_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>  	chip->irq_write_msi_msg	= pseries_msi_write_msg;
>  
>  	info->ops->msi_prepare = pseries_msi_ops_prepare;
> -	info->ops->msi_post_free = pseries_msi_post_free;
> +	info->ops->msi_teardown = pseries_msi_ops_teardown;
>  
>  	return true;
>  }

Hi Nam,

The boot issue is fixed with this diff. I'll do some more testing on
this series and will post more updates.

Thanks,
Gautam

