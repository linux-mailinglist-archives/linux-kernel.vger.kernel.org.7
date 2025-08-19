Return-Path: <linux-kernel+bounces-774801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98922B2B7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5298B3AE274
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6437023ED75;
	Tue, 19 Aug 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N9sAEFlW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1B22D7B0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574579; cv=none; b=HIJtkaNoNzTpzAI1lUmhrIwsYHL+lmwFm/8pN8gYbw3sFzJRwmqLh3l1tQ/sE50Z7N7PgGg/VgVDrXka6jdpLMDOO+5E8XzV/ZbHcVgT2J5idD2NACd0hy8sfMkvijHu6Mlz97ZR7aXpfAPfGRb4G7J5hiZjmkWyHz52s8zL/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574579; c=relaxed/simple;
	bh=XRtna1RjM2DTQni0lMCT0SHGY6+9Ygy0GmujFCOwhek=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=FM9MBIg8FA/NrWeUmNeylJJVhJdFLNOVPlrLnkj3lRQpfZCETWLdJR5G4L+X+XG3NIsw4VZLZaXuokbPzOcf1FfBo7ZXP4kTxfR6LJxPkUodN4LylDk98LCQlyDCC1lK+eRaa70/kILM734ok3VJRzwLMZ9LNhPFNpwbo7P949A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N9sAEFlW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J12Qvv016582;
	Tue, 19 Aug 2025 03:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=pp1;
	 bh=H1O5Fp1ayX5MCwcRDMcMUivVM3md77FsR7ps6Nq+QmE=; b=N9sAEFlW6rt0
	64qc6Td07/wBpq6IgptBzqZnZbMI0Xm09icXXzzLRy+i7Zrep51vKxdwDPjcTHdl
	7asFE/bYXcK7toGb3mKrEmYr9b/WxVY1yxqutnHYGc33TeK8xe66qU+7shvEOih+
	ToWMQw9lOnbPzkiVxJpShxVM5ybdHQxOQ1FC1Vapbqxnd59O+zBetKezql9e7RON
	frEC9rAcR9P6rADzFEXXIna7qfdGH55lxwwdEoOI9YRJVQqIE2xV+id0X1x15weN
	gbyIAuJNUCQzKCMBf1yDvJyYKm2h8NIgjoae1hJ53p3N5xPk0LmqSgc4kLP/Iz96
	6aVPj0uYvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrvjpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 03:36:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J3ZxfX016454;
	Tue, 19 Aug 2025 03:36:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrvjpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 03:35:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J1XSCB002336;
	Tue, 19 Aug 2025 03:35:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k713092u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 03:35:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J3Zt1058392902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 03:35:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45C6B20043;
	Tue, 19 Aug 2025 03:35:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 420FB20040;
	Tue, 19 Aug 2025 03:35:53 +0000 (GMT)
Received: from dw-tp (unknown [9.204.200.232])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Aug 2025 03:35:53 +0000 (GMT)
From: Ritesh Harjani (IBM) <riteshh@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Remove duplicate definition for ppc_msgsnd_sync()
In-Reply-To: <20250813122319.62278-1-gautam@linux.ibm.com>
Date: Tue, 19 Aug 2025 08:50:25 +0530
Message-ID: <87bjocatfq.fsf@gmail.com>
References: <20250813122319.62278-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLiwYisuEdzjke1bXIi87s-7-OvclDfl
X-Proofpoint-GUID: 2AjALPJol3RmTjF4HoyMN-z0cC3QbWCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX1qMawPF5MugE
 uttEhX9/jrLcKNsRVxAdQefQKjCbRJjUbxQvCUL816YwpPaYlBcHzYdwy/VhNSHv6yakEwD+R2c
 GWjubOu7y1LGc3IJnxSzmEqORsJgcMVB9k37kdYTKNzMLl2WjcwaSQ54y1R1Q+lFC+4ZPfR5ijo
 8O8Fnw5PC6KMfDyPTIRGZRwTUrb09VX/JK6DkDkrunlZObf49VSc9xgF6QmXFBu/MKyYJT5Yf06
 aAmBdeX6ghAohqW7+gc7snaVgo8P9Z9WXs2RZgCnpxQZFfsKrn3dN+CbHuEaYmsjCG8QBNDX5Ft
 17Sj3qhAkfjLVsC4Vz+deKFtbT91OnZTT94fA/gCK6dTkjPezDGRzA62h0pyQlNOeuSVrxnU5QA
 TU5gGbPS
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a3f120 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=AjKfnhLaCVDwOzmiWWAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> Remove duplicate definition of ppc_msgsnd_sync() introduced in commit
> b87ac0218355 ('powerpc: Introduce msgsnd/doorbell barrier primitives').
>
> No functional change intended.
>

Earlier this function was duplicated at 2 places i.e. in
#ifdef CONFIG_PPC_BOOK3S and #else block. This patch takes those
duplicate definitions out and move it to a common place.

BTW, there is nothing sndmsg specific in this, so this could be open
coded as well. But as far as this patch is concerned, it looks good.

So please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <riteshh@linux.ibm.com>


> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/dbell.h | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
> index 3e9da22a2779..0b9ef726f92c 100644
> --- a/arch/powerpc/include/asm/dbell.h
> +++ b/arch/powerpc/include/asm/dbell.h
> @@ -40,12 +40,6 @@ static inline void _ppc_msgsnd(u32 msg)
>  				: : "i" (CPU_FTR_HVMODE), "r" (msg));
>  }
>  
> -/* sync before sending message */
> -static inline void ppc_msgsnd_sync(void)
> -{
> -	__asm__ __volatile__ ("sync" : : : "memory");
> -}
> -
>  /* sync after taking message interrupt */
>  static inline void ppc_msgsync(void)
>  {
> @@ -76,12 +70,6 @@ static inline void _ppc_msgsnd(u32 msg)
>  	__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
>  }
>  
> -/* sync before sending message */
> -static inline void ppc_msgsnd_sync(void)
> -{
> -	__asm__ __volatile__ ("sync" : : : "memory");
> -}
> -
>  /* sync after taking message interrupt */
>  static inline void ppc_msgsync(void)
>  {
> @@ -91,6 +79,12 @@ static inline void ppc_msgsync(void)
>  
>  extern void doorbell_exception(struct pt_regs *regs);
>  
> +/* sync before sending message */
> +static inline void ppc_msgsnd_sync(void)
> +{
> +	__asm__ __volatile__ ("sync" : : : "memory");
> +}
> +
>  static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
>  {
>  	u32 msg = PPC_DBELL_TYPE(type) | (flags & PPC_DBELL_MSG_BRDCAST) |
> -- 
> 2.50.1

