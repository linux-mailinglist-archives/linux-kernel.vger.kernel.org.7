Return-Path: <linux-kernel+bounces-723896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94473AFEC24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF94189E0FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616182DFA4D;
	Wed,  9 Jul 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QdDNF+Dn"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB142DF3FB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071873; cv=none; b=c0I3TDqK6YTqhz/4h5PJp5WF7U7BcOBSt0CpDtXxxxnns2VWbZmRnzo8GFUGQ3rP2K9+UIxMojYfirSQQAG8KeVDSmkrvt5sAZPSw65FX3KdbOn5+t+zEBkGcAZS7BzozS/AkfEsvWuRDDbOUO3avhl8RMyT21ExIZKvU91zaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071873; c=relaxed/simple;
	bh=IUd2btbbUnzyCYzUfSqqgmCrCxh9pF86Uj9upNCkJQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBSdkL0I/TPZMxQJ+e7vX1g2/mf+FtkT53kv/HtlpyGvQnf00zGw2YgnZErGh3RM2tQw9EQibeS82LhbbLjqPVZAUECGC7ivS9fiFrfDsm2VP+94nHdsNXzCv4JuRu6BBxiP2POo+NX1HYt2gtZYqwd3cRoZmMW0UgGKKVCxQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QdDNF+Dn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5695WvQb003186;
	Wed, 9 Jul 2025 14:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IUd2bt
	bbUnzyCYzUfSqqgmCrCxh9pF86Uj9upNCkJQI=; b=QdDNF+Dn/j1U7+yeT/iL+a
	rk4Ob1ZEh9texCJPQR2BOWsbAAX7l1wYyfBQE8sXx3BVV4Mfap4s+KXpoCm/X46/
	xukgaj+e7yMzc+53fRm4XgvNsSm68V2m8RLv7woWcKWR1OMSHj/2YVglELvDnjo5
	pM756ESU0R7x09e8rKkmHhzGq2H8cszrOJLlmwSBcWKLyPQEWvaXPw7Djiuk4v/6
	z29US3x6QdI0+WbZGUk1tvMqIzkX09W/tNjbPhW1tCmHljwM4yY6nRxfT1kFeea0
	RxPu7LcFNjCjzQWTTd+3vQCNgUwRTtrNKsoRPDku+ehbgYklG8/IpQAuzVFLeHsw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk46xwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 14:37:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569BSthP003123;
	Wed, 9 Jul 2025 14:37:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmggwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 14:37:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569EbfvL18743566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 14:37:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 113942004B;
	Wed,  9 Jul 2025 14:37:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D2020040;
	Wed,  9 Jul 2025 14:37:40 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 14:37:40 +0000 (GMT)
Message-ID: <6a2524c66c6462c94237058c8ab8aa43f2192c87.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] scripts/gdb/symbols: make lx-symbols skip the s390
 decompressor
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Wed, 09 Jul 2025 16:37:40 +0200
In-Reply-To: <3a87aa8d-ce40-4909-be36-24c8ea75af8b@siemens.com>
References: <20250625154220.75300-1-iii@linux.ibm.com>
	 <20250625154220.75300-3-iii@linux.ibm.com>
	 <3a87aa8d-ce40-4909-be36-24c8ea75af8b@siemens.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEyOSBTYWx0ZWRfX5P3QiggGsNAZ t9GPyrUlw2QfsGikPprPt2CmLaxRON89g5eVXT/60yQl+/7qPbVkWogBVk+B9Byf/zzbPRBp00K qcAQDcfRWhyKF5CbGU9gK4vV0hYDHJ9r8KqhdjROcEOw3K85vYOfcYRUD/JsSHhgI8ysjniolL5
 jy0gVIGLmqgWzy4RNKMU1Z0Jdlyq6qgi8uIEKhGDDXyyOuGObbnd5RoO8a7sJ3MwNZz6bCOckI7 bQMyrxMk7MzBzJsvQHK1hAJYu6ey3aT0LObSXfdv8PUPuywCMn8oQdmXXX0HONOW72U9TTPZyvV UupCcjSWTTrfaDvjupTGwgMZgUIQYyZk+TCEwgqGpnYY/xh/VP5NqgdTi7DqBKkWaqF/m9nTl4G
 JE6RK0Fes9dNzRjKVM8uf87ATF2iHGTm8RbLBV14JWVKqofmaunBLmCtONpj4H2pwfZQAo0X
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686e7eba cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=uRi2784WTAWJEODazsgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EtShUvoY_hjPylpPidcckSURjb7y_bKi
X-Proofpoint-GUID: EtShUvoY_hjPylpPidcckSURjb7y_bKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=952 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090129

On Wed, 2025-07-09 at 13:40 +0200, Jan Kiszka wrote:
> On 25.06.25 17:36, Ilya Leoshkevich wrote:
> > When one starts QEMU with the -S flag and attaches GDB, the kernel
> > is
> > not yet loaded, and the current instruction is an entry point to
> > the
> > decompressor. In case the intention is to debug the early kernel
> > boot,
> > and not the decompressor, e.g., put a breakpoint on some kernel
> > function and see all the invocations, one has to skip the
> > decompressor.
> >=20
> > There are many ways to do this, and so far people wrote private
> > scripts
> > or memorized certain command sequences.
> >=20
> > Make it work out of the box like this:
> >=20
> > =C2=A0=C2=A0=C2=A0 $ gdb -ex 'target remote :6812' -ex 'source vmlinux-=
gdb.py'
> > vmlinux
> > =C2=A0=C2=A0=C2=A0 Remote debugging using :6812
> > =C2=A0=C2=A0=C2=A0 0x0000000000010000 in ?? ()
> > =C2=A0=C2=A0=C2=A0 (gdb) lx-symbols
> > =C2=A0=C2=A0=C2=A0 loading vmlinux
> > =C2=A0=C2=A0=C2=A0 (gdb) x/i $pc
> > =C2=A0=C2=A0=C2=A0 =3D> 0x3ffe0100000 <startup_continue>:=C2=A0=C2=A0=
=C2=A0 lghi=C2=A0=C2=A0=C2=A0 %r2,0
> >=20
> > Implement this by reading the address of the jump_to_kernel()
> > function
> > from the lowcore, and step until DAT is turned on.
>=20
> Why do you need to stepi until there? SW breakpoint will likely need
> to
> output of the decompressor first. No HW breakpoint available? Or
> missing
> <end-of-decompressor> address?

jump_to_kernel is <end-of-decompressor>; the code from this patch puts
an SW breakpoint there, and this works fine.

However, the problem is that once jump_to_kernel is reached, even
though the kernel is already in place, paging is still off.

jump_to_kernel contains a single "lpswe" instruction, which both jumps
to kernel and enables paging, therefore, we must "stepi" over it. The
loop is there just for future-proofing. Everything happens very
quickly, there are no thousands of "stepi"s.

> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0scripts/gdb/linux/symbols.py | 26 ++++++++++++++++++++++++++
> > =C2=A01 file changed, 26 insertions(+)
> >=20
> > diff --git a/scripts/gdb/linux/symbols.py
> > b/scripts/gdb/linux/symbols.py
> > index 2332bd8eddf1..6edb99221675 100644
> > --- a/scripts/gdb/linux/symbols.py
> > +++ b/scripts/gdb/linux/symbols.py
> > @@ -84,6 +84,30 @@ def get_kerneloffset():
> > =C2=A0=C2=A0=C2=A0=C2=A0 return None
> > =C2=A0
> > =C2=A0
> > +def is_in_s390_decompressor():
> > +=C2=A0=C2=A0=C2=A0 # DAT is always off in decompressor. Use this as an=
 indicator.
> > +=C2=A0=C2=A0=C2=A0 # Note that in the kernel, DAT can be off during ke=
xec() or
> > restart.
> > +=C2=A0=C2=A0=C2=A0 # Accept this imprecision in order to avoid complic=
ating
> > things.
> > +=C2=A0=C2=A0=C2=A0 # It is unlikely that someone will run lx-symbols a=
t these
> > points.
> > +=C2=A0=C2=A0=C2=A0 pswm =3D int(gdb.parse_and_eval("$pswm"))
> > +=C2=A0=C2=A0=C2=A0 return (pswm & 0x0400000000000000) =3D=3D 0
> > +
> > +
> > +def skip_decompressor():
> > +=C2=A0=C2=A0=C2=A0 if utils.is_target_arch("s390"):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if is_in_s390_decompressor(=
):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # T=
he address of the jump_to_kernel function is
> > statically placed
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # i=
nto svc_old_psw.addr (see ipl_data.c); read it from
> > there. DAT
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # i=
s off, so we do not need to care about lowcore
> > relocation.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc=
_old_pswa =3D 0x148
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jum=
p_to_kernel =3D int(gdb.parse_and_eval("*(unsigned
> > long long *)" +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > hex(svc_old_pswa)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb=
.execute("tbreak *" + hex(jump_to_kernel))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb=
.execute("continue")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 whi=
le is_in_s390_decompressor():
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 gdb.execute("stepi")
> > +
> > +
> > =C2=A0class LxSymbols(gdb.Command):
> > =C2=A0=C2=A0=C2=A0=C2=A0 """(Re-)load symbols of Linux kernel and curre=
ntly loaded
> > modules.
> > =C2=A0
> > @@ -204,6 +228,8 @@ lx-symbols command."""
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 saved_state['breakpoint'].enabled =3D
> > saved_state['enabled']
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 def invoke(self, arg, from_tty):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skip_decompressor()
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.module_paths =3D
> > [os.path.abspath(os.path.expanduser(p))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for p in arg.split()]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.module_paths.appe=
nd(os.getcwd())
>=20
> Otherwise, this series looks good to me and could be picked up if
> there
> is no better way to reach the end of the decompressor.

Could you please ack this patch if the explanation above is
satisfactory? We would like to take this series via the s390 tree,
if possible.

> Jan

