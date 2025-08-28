Return-Path: <linux-kernel+bounces-789318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E537B393DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9691BA3AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D90279DBC;
	Thu, 28 Aug 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MtdLzpnR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92B27FD75
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362816; cv=none; b=YyrvY8Ngv9eYONOiHdrZxlFHoYP/ua+6cqVsz20zRccSGOAkK9Zis0DT0optzwyeHQFuSEOK1Di+zYIUzbYg5I0YLkJSxK/q9xQkDo9DejD8T2aUu0ehnY+S8De6JKS0yftQspSvUHPzjC/mB76Tk813noz3+Ij9V6NtybgHTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362816; c=relaxed/simple;
	bh=uG2hpfI9x2H0P2ZszyWEeqzl3Uxjvs/nH47fSKJ/dmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSYz33MRRgTeTHUKObXldsgjDXU8XN6VAKROqzHSBydhS1oSZAv6HgBrNg8auJrAo+jmad7VKTYy+gcRn6Vc5FfwGvZOB4ciOap1GECbXkPXl9HHD9zeCXY16OEbnYLsgPsORyWolJdAHqMseD4A3gfZk0oHi6WOF0PJDOP9fX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MtdLzpnR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5jvgd004119;
	Thu, 28 Aug 2025 06:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WewHb0
	G7p+TfHjPAe2pbPhcWmEOiO7ieeExDAA3U8ow=; b=MtdLzpnRDa0nkT7SX2DB9q
	uMJUx/a7FJt0MWpPjfyceGk4GpuN8DZ1IlN3WCRQJquXn+husqD5Amb3YhfNJRvT
	km081JqvK1TQNOc16uCI0Il1rEhhXVw/7y+g7D1VfLOIn6w1NWvpewB993mftGOT
	9JuKCh6tAniuaI5PUII9v264VIxoRHHSu0L7arGdMPirH4ZuDmk8q4+LWSdcg8xA
	JyoXG8A7LhArc3JA1UazI1kNP7HLVeqA0V5TsryvNcR98ynAY9vgVLgTJyAcfYqG
	Gp1mrQDgKcc31nV1M7pwtVZmTlaADC8HKsg4zyC/309DJISaG73Cn67pUWpOmj4Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558886s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 06:33:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57S6VQbk030110;
	Thu, 28 Aug 2025 06:33:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558886p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 06:33:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57S3rudM007813;
	Thu, 28 Aug 2025 06:33:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyuktvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 06:33:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57S6WxDw52822398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 06:32:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD9A120043;
	Thu, 28 Aug 2025 06:32:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC9F20040;
	Thu, 28 Aug 2025 06:32:57 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.64.161])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 06:32:57 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -resend] powerpc: Use dev_fwnode()
Date: Thu, 28 Aug 2025 12:02:56 +0530
Message-ID: <175635911050.1554354.2788619788744225581.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723062842.1831271-1-jirislaby@kernel.org>
References: <20250723062842.1831271-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5aiVQFuLFuy7wIBUCu-Uday2szU5L5Ty
X-Proofpoint-ORIG-GUID: DpWR1_O5Y7bjye9EvgacAspuQAcGMnCp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXwAmwZwosf82l
 00MlQikWZpzaVdVBiWqRXvpuDCd5NUt5PbPQVIvfdncEBAMpUaD8CuENBSAd4Pxo1qmTmAZ38wF
 iSvXTI9uQoNKRKaUiKKhyE4QFyMUX27mRBNl0p2c9aELQI73qBPvDkMP9MRgFg6Y9r77IL3QW7T
 S9ABP62ln62r1fr4PtQiSQg7JlkDqiZRT6ZwkewjWrBoQE9gUa+btfV4FG51XQX0DlopIJiftHT
 3RxTqmYZpiJuEf0/jcdNZUO4LXo8BWqB93vLvxljo/48eDyi4JIEXYhWrqobuOgYNXiDB+ha6+x
 HXSdsgSrMf6Qb91QwuaLK9x2CNhlNmNZKuxrED7VExsuVm0kJHxhLSVwJNFuo3alGx0d20f7woh
 iiBT9bgc
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68aff81f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=aJsWLRHQfULh26m7tKQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

On Wed, 23 Jul 2025 08:28:42 +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Use dev_fwnode()
      https://git.kernel.org/powerpc/c/b018bb26c42049e05d3d65b057cc1250d17d9b0a

Thanks

