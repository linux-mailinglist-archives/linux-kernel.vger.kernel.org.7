Return-Path: <linux-kernel+bounces-754769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97591B19C08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B885316ED2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7C235BE8;
	Mon,  4 Aug 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHOkOeDS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D8233722;
	Mon,  4 Aug 2025 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291660; cv=none; b=gX7ZIwVctqsGZNEqJQyL3z8eotti+y4xaYnEx1dUHb/arJmE6xFBrSNfxgGsSinp4IJ41TlxqcJHFMWlRaaoLbgHOQt/Sw8H8Sp6MM3ePiBwPZwtEQoY0AjFUmg2Dl9jVss7G36tUOV4v/grsW4opCTEIvDUq7l8lHOdI3nKuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291660; c=relaxed/simple;
	bh=xr8kw9SPRhmPcyvP07iadh7wDKw/SKfseN599kJfH5g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SwINvH+HnUGakd4z4seXMm3RtcVB1VbEyflVST4Zi/4ngQdYpGipPC4k8wNkQTdTI0d6Nr8cKpRjUaRNbpnwIP2vBe6CbskGpohVUKzFtSAeeZ3r9G8FnVtxRammgmVX3bRwLTFcMzYeDtBajVicF5DcrHfeWbtwWhMKJCbLov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHOkOeDS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573Mudbo026927;
	Mon, 4 Aug 2025 07:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F6jQGh
	MZW61d7WEkgsZIQPa0r0occTXzdjKXqmPa2no=; b=YHOkOeDSYR+HLAZqVziAR+
	E8L1dK09eFngJM7cR5j9z0rd2/q22SmArlipwJljAuF3/yMCvxVl4+eA6p1iK9Ge
	pS7Qf96o/CqgJzacUE9YXH7FMhmILwRMk0m3srOSP2UIqcKMwC+Ln8GeUjIqwzUm
	G40nF4PkNTontNll1OmsRyWtFi/ugzn0zIsd2+oI8ycKZEWdai5chVMKY+sRw+Bp
	NiHYImAhK4HWzwx6QHxTKuwxzPf4F7BHIzqo44BAkwGzHDfRM3XX56k7+Qt6jleW
	3a6JSqE6ul4Qu19p8uFk6c5cmMglsBIzkSmtVaAYuWjAytuoOsfjuLgHDOJOVQWg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9udgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:13:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57477qrI009330;
	Mon, 4 Aug 2025 07:13:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9udgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:13:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57479ASd001597;
	Mon, 4 Aug 2025 07:13:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7kmchu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:13:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5747D9Iv17105536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 07:13:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A6745805D;
	Mon,  4 Aug 2025 07:13:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B683358052;
	Mon,  4 Aug 2025 07:13:05 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.249.29])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Aug 2025 07:13:05 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 2/2] powerpc/fprobe: fix updated fprobe for
 function-graph tracer
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250722085648.1640-2-adityab1@linux.ibm.com>
Date: Mon, 4 Aug 2025 12:42:52 +0530
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, maddy@linux.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, Hari Bathini <hbathini@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <171B1AAA-89BB-469C-B428-B427A80E07F2@linux.ibm.com>
References: <20250722085648.1640-1-adityab1@linux.ibm.com>
 <20250722085648.1640-2-adityab1@linux.ibm.com>
To: Aditya Bodkhe <adityab1@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9BtadrcIop3oReSnI28SI8LIWgdtsZTr
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=68905d88 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=hjLnkWndKg4kFgHkvr4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SvnqpDKFKwJw7eSiQsWR3P-b16zg--4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzNSBTYWx0ZWRfX+xr3gp2d7JyE
 fl2RZ/g6/v5AM5NSlByFxtbSOQCGmIx2bG68OWNrZ7VENe2JRwrono9f+zn3fFBjKpTIlQRNIw7
 PiGdGDGzUNp8FqaDhEDW25m9rN/6tnRyJkH/CMMMsVSawIZJe+ZX9etM1Lc8T3B/P6FWChl5buy
 T8IoymChSIIws3i8QaQ6cZp7nDTiQL76aG/zqv6KZqLtXIHgUnE6PQGjvo0L/e0C51Wnz8cq4T7
 VjbhAJw2xe2pvgsavX+LyktHbqTlPf3m/RYN6MDCUowb5Bvw5kpil9iCaVrHZJcbQ9m56tQwh3Z
 Ao4yjBoVQ8v+ZU2ZMW9FONI3/XOAEHygfe5AaOdwr0oiO1IA8eiCErnfcpe2OK5wXjPwzOInpcj
 nZV/COt3BZE4eh3JJwYotztfTCxdXZwvIyPtVvdFqzlSF7/3i4o94vlR01gMy7WKlXYVaZXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=829
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040035



> On 22 Jul 2025, at 2:26=E2=80=AFPM, Aditya Bodkhe =
<adityab1@linux.ibm.com> wrote:
>=20
> From: Hari Bathini <hbathini@linux.ibm.com>
>=20
> Since commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
> tracer"), FPROBE depends on HAVE_FUNCTION_GRAPH_FREGS. With previous
> patch adding HAVE_FUNCTION_GRAPH_FREGS for powerpc, FPROBE can be
> enabled on powerpc. But with the commit b5fa903b7f7c ("fprobe: Add
> fprobe_header encoding feature"), asm/fprobe.h header is needed to
> define arch dependent encode/decode macros. The fprobe header MSB
> pattern on powerpc is not 0xf. So, define FPROBE_HEADER_MSB_PATTERN
> expected on powerpc.
>=20
> Also, commit 762abbc0d09f ("fprobe: Use ftrace_regs in fprobe exit
> handler") introduced HAVE_FTRACE_REGS_HAVING_PT_REGS for archs that
> have pt_regs in ftrace_regs. Advertise that on powerpc to reuse
> common definitions like ftrace_partial_regs().
>=20
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <adityab1@linux.ibm.com>
> ---
> arch/powerpc/Kconfig              |  1 +
> arch/powerpc/include/asm/fprobe.h | 12 ++++++++++++
> 2 files changed, 13 insertions(+)
> create mode 100644 arch/powerpc/include/asm/fprobe.h
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9163521bc4b9..2203e4fb64c1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -246,6 +246,7 @@ config PPC
> select HAVE_EFFICIENT_UNALIGNED_ACCESS
> select HAVE_GUP_FAST
> select HAVE_FTRACE_GRAPH_FUNC
> + select HAVE_FTRACE_REGS_HAVING_PT_REGS
> select HAVE_FTRACE_MCOUNT_RECORD
> select HAVE_FUNCTION_ARG_ACCESS_API
> select HAVE_FUNCTION_DESCRIPTORS if PPC64_ELF_ABI_V1
> diff --git a/arch/powerpc/include/asm/fprobe.h =
b/arch/powerpc/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..d64bc28fb3d3
> --- /dev/null
> +++ b/arch/powerpc/include/asm/fprobe.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PPC_FPROBE_H
> +#define _ASM_PPC_FPROBE_H
> +
> +#include <asm-generic/fprobe.h>
> +
> +#ifdef CONFIG_64BIT
> +#undef FPROBE_HEADER_MSB_PATTERN
> +#define FPROBE_HEADER_MSB_PATTERN (PAGE_OFFSET & =
~FPROBE_HEADER_MSB_MASK)
> +#endif
> +
> +#endif /* _ASM_PPC_FPROBE_H */
> --=20
> 2.50.0
>=20

<Resending to the right thread>

Tested this patch by applying on top of mainline. Build and boot is =
successful. Also ran ftrace selftest, intended test passed and no new =
failures/errors introduced with this patch. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.


