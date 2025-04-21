Return-Path: <linux-kernel+bounces-612373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A3A94E12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E543B1C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6C20F069;
	Mon, 21 Apr 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JEEzeF9v"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C533C9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745224012; cv=none; b=nvaejPn7VqV06LSVyOz0CHU3Wp4+v1XCNDlQ9O7BzHs0BkaZ9UXC7nrJjiYK9oDtC22NkHeFd6TgxjJsl4r+1CILE6QwsMwC6TTvjiycLarVGMSqv4sA1nRjNVn62SIG26gDRoNhPOxP+4vEJV1j6yWrSoJ8NwZIg/Izx6jn4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745224012; c=relaxed/simple;
	bh=CzThu7Zlo7b3oIekyYQKhCWqE86A7zL6cEwXqrAY2m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPP3V9MATTrhrxfEtRiYrfW0wdfRf6wjvItY2PVblUn/p5dgkyZhLDU1v3RCD0OHPWeT6jrQG9qFjWxYRQGXrDkFIdPFqR8h/Nwvi/PBIzgjL9olWPDxb/zIyh73JVJnqNdHQoEHZYp/SBEDR7eCNSAk/hgHrE6ot91q2tU8TMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JEEzeF9v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KJnVNl013827;
	Mon, 21 Apr 2025 08:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rMB3uO
	Pd33ZrkG9E7Dm6xG+7/MjPp1n+kwqCvWkl0+M=; b=JEEzeF9vD/cD/m7N3ZD8JN
	VmRwHFUIfy4xd26qdbfoyJ1BQvReQ7j76NM2I2HBwJlYUOcECDBhWGvhrlJ0QSFx
	Gp8SmuhQWpDn7Wc9qsmhCXUYO4Da2duZM3RVJhvWQ9YrkuETlJ2NByORwmGmO+Ae
	eGxf2Mur4lnUO68OZT1KhHkK3GGzfoag+gqG5x3rqNihVZ4I6FsElhrdAemXWpk4
	jaZUwKwvOCpSKceS09/CEby8pjwT8CwtVMrEtlnZhTIi3XVZ78laIT4+CPodDqI3
	q1phhnVaSlMuzrCN2QULGGrBYLutBpxh5I9zoL0IYE/4geEGLvj0GFWhOYboF+qw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464xuhugtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 08:26:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53L8QOu5023367;
	Mon, 21 Apr 2025 08:26:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464xuhugtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 08:26:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53L4NNNr027744;
	Mon, 21 Apr 2025 08:26:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv1w5ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 08:26:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53L8QM8Q52756908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 08:26:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 293732004D;
	Mon, 21 Apr 2025 08:26:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96CF20049;
	Mon, 21 Apr 2025 08:26:18 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.124.216.6])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Apr 2025 08:26:18 +0000 (GMT)
Date: Mon, 21 Apr 2025 13:56:16 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: Fix build with gcc 15
Message-ID: <l3xcl2rnzgor6uxsnhzlp3pceg62n256fbzaguhvktuwq3auye@spar6ml5kecp>
References: <20250307092055.21986-1-msuchanek@suse.de>
 <fo7xb3bqk5h57mqgfrnyfpweitkr2l5vk3tomu6zgxgqlivwpt@afm2n3c2sxke>
 <aADfrUcNqBejcdrR@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aADfrUcNqBejcdrR@kitsune.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E-Y5woX01FJWD-O40TfIUk9wMglHGt1o
X-Proofpoint-ORIG-GUID: oj0DCEysWvjKndr2tqegI6IBgnJfUgtj
X-Authority-Analysis: v=2.4 cv=LbY86ifi c=1 sm=1 tr=0 ts=68060131 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EjazUNRJd03PLXMeH1cA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_03,2025-04-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210062

On Thu, Apr 17, 2025 at 01:02:05PM +0200, Michal Such�nek wrote:
> On Thu, Apr 17, 2025 at 11:37:09AM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Fri, Mar 07, 2025 at 10:20:52AM +0100, Michal Suchanek wrote:
> > > Similar to x86 the ppc boot code does not build with GCC 15.
> > > 
> > > Copy the fix from
> > > commit ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
> > > 
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  arch/powerpc/boot/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > > index 1ff6ad4f6cd2..e6b35699c049 100644
> > > --- a/arch/powerpc/boot/Makefile
> > > +++ b/arch/powerpc/boot/Makefile
> > > @@ -33,6 +33,7 @@ else
> > >  endif
> > >  
> > >  ifdef CONFIG_PPC64_BOOT_WRAPPER
> > > +BOOTTARGETFLAGS	+= -std=gnu11
> > >  BOOTTARGETFLAGS	+= -m64
> > >  BOOTTARGETFLAGS	+= -mabi=elfv2
> > >  ifdef CONFIG_PPC64_ELF_ABI_V2
> > > -- 
> > > 2.47.1
> > > 
> > There's another patch which fixes this problem by version comparison.
> > https://lore.kernel.org/all/20250323163607.537270-2-misanjum@linux.ibm.com/
> > 
> > In my opinion this is a better solution as it will use the features of latest
> > compiler.
> 
> No it's not a better solution. It's documented that the kernel is built
> with the GNU dialect of ISO C11. When a file is not compiled with the
> documented C dialect that's a bug.
> 
> If newer C dialect features are desirable then they should be enabled
> consistently across the tree, not individually for a few files used in
> boot code.
> 
> Thanks
> 
> Michal
Oh cool.

Thanks

