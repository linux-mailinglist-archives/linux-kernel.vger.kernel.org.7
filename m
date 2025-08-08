Return-Path: <linux-kernel+bounces-760347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FDB1E9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E146A18852D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D1727703C;
	Fri,  8 Aug 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="LyYiXI2Y"
Received: from sonic316-33.consmr.mail.gq1.yahoo.com (sonic316-33.consmr.mail.gq1.yahoo.com [98.137.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270835898
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662022; cv=none; b=hHJ4TfhCiQpJgkra4deh0kcBxqzbyoboR/DSpRekVtS2UG3KzNByIfXWgztKLchVQgeaFJhBQzTdM4gaWaQaxos6ZX7Hh/RWtPUfgx32fAaiEPtpObIS9kLEwYoZbOfzpMCFnyav5DsZpL+Fx6e0kQ6bhPdMIwAPaDS2qoSUhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662022; c=relaxed/simple;
	bh=EooGbwPs+v+2bHAWjdJXN5r3lizWAhjM5/u1waLqsHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O92PGIIAn3dLTF0NOpSiPrqhgXUaBMcOwO5SlWHHnSzkCfq5Y1lZ/Q5O8cElmUwBrQc9cr0s//vnX4LagEiz9q1b9TLEfpDC8SZgfbD+6cBeepbtQQUn8eXX0igzqDeYwRLQutgU8YSDDKO6095Ca7TsmRSr2Ex+r+UWXsJ3QQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=LyYiXI2Y; arc=none smtp.client-ip=98.137.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1754662020; bh=EooGbwPs+v+2bHAWjdJXN5r3lizWAhjM5/u1waLqsHs=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=LyYiXI2YZT1CO1D9bHf9D9zdx40Xztm2Idic9WiBfuefN0JqeH413YNb4R+irhi2MzR6iS808TCjM373rLn1Mal03aP9GzevPbX+4KfZSktWVkfxNcf562HcMPVF37Kalz2K7DQ/0OHUCDYtsZ2fOUFV3S45bj310SHoij4GyOC3+swAn/6WKIhhaam5SXtJ2/ey+PKTQVsM1/QUUicKi/jcBaltJjc0CTN88XUJimYJ+Ew8RPyg0rcTkb/68nNYQgfLuJK66XXgmISoDoz/zeQVM+PuhMr5KpRgcqNIseBfAQPSV3eBL/3/k/UkBlYEeoSXCcFLZzfmHp9rLwbwtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754662020; bh=EX0wBVMhw3eSgG+cuZHrlxvFTJrb1LBjsPowbzUMCRf=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=Nd5+Cb8xMMkBKTuZA9dQIr7aalM73sRe3eYMOEQCFM1UL5qXBqHLl7+g64WcS3G4zF1Id8kZz2xO8M9ZqkkF8hOQhOpOk9rsNhJ1kkhlrNQtKCvzFwKzXZGCL/oN4HdwShJyeEWF5Eh475WdONqal1Fr03utTQpQxk2H97Empgw00UHF1merPmpWT6hiszchiFEhv6+6dJBGk+Amtp7uRB3ha4UPJjY0EGp+pJpdNP7CAriOq7EfPAIEwRI4ra4bJBLQJkd8TWPRRmGuPOlM7p189akIkJf0u2IRKAzzM6Cs7glXY8H2I8i8wA+wrzMlBWK+o6rdle8+P/V8FY31LA==
X-YMail-OSG: Nar9BHYVM1mgAR3RdcPkbl9hdOVAdZ9Nhrgz8rsVznhI9FhmhfQ6pyZ8nsC745o
 Cb3wWMdIJeOJEnG4A2pFKvqsw6tNoHXKUfqCoplZUKgFEI5nlf14FRrtJL_l_zbJC0w_rnEyVFy_
 9a2rho4kF1NCsTkkTS64.peNg2S_U6T1h9OT7rAuP0A8xRbC6AlR295TXJL_THnfeXSgLxBUmtVt
 5tzWg4CXSBDVDePDpk4Jx71kuva6s5FCuHUAXygvW1aCAw29_aSZc63.tTtzHdPtfZ2.qPgJ3r.c
 vNx8pcJ.S1B06BDGvm2LynSRV0ihpDgM4G8lTnQ4VMKMF.Z2oXqHd8zOeMaHn9dqa8.8vpx1_41k
 qaDIb6HKMdAsXrks5yIoVrQuOrsCt6GMU9mcrEacTbqcxRbe99x6pJcTsjCzpFGWOy_VfBuyPbB7
 Yr.xsl97h5MPiFFNY2MHVaU2nBXz_GbPTiMSQkJ_HMRXyAMhByk6_OrzL.3hakfnhwYx8Ksg2wlt
 1oN5J0Hbv.QAQADMA2khjKgrn7LXbAL8B96JmXYzkA7bnPrYlPDEPxciK8eFsF92MT6ggqqRfFQk
 YMsE6BZqwNIQJCklrfk3SaQSkEzW8lQ.iAMvuVUyfT3aK4oOOMn8CmLX7uWJm4bMAjNMfan0nrMK
 LagnsAk.B8jyj.LqaD7oNqcCMMvgpKj6bMq5AkmqP5vgwGst0jNv0qwj4P7xhNUzWSJm2Ledz88k
 xAA028UNeT0CkOeOi1GrCNxFz0dNFHzgxYAHUHH4lwquxp6gB1x8d5xTHkuGmkgF3KIaBHgvFv7p
 c419xzd8_Bw8FylAyCWxczOhqK4xD_wigxrFMc8JkTZ8dChigObwMuI3Ds4nxxnoQkmojO6l00DO
 gXtnEW2V9uJZSj_O5lFvygYM9VkiCfVyb5NGg78i.A5EtiQwit2vPj4nxJnUTIER9w2ttD2Uxo7P
 InNCo7BsqKWzD37yIFTy.Pgqi7gxlkFnShvhP3lC.amR10N44qe2F8gL537M81W4fujQNUE0e4Z1
 W2CbJRxH5h..WC_vaaZc6RsO41pHc4qmIpjvGjgHOoAypTG22FJtGOcwUjGNnMjy0POuDGn8RNKr
 M5CPWNe1aZiCeDyXyIGQ1_oI5wHeUlhplZaAgXKyC64Y6Cdg2WlZkc54vxI3913IwBvKgdH3kzjb
 Vn.YIAhoBPHh44ZEfENRkasmdsW4WeCg6bq_4hJLv2Lwy3lG0LOkXk3.Ao19HRPRTYVLQK1wSWj0
 dCEINsOw4g1gU.k.hxoiKbFs5hF9brGT24CyYQh4aIsHduSMNp0GbS4H.IX6WA9za0fsR.7LvlaW
 av575ItzDn8qsRD4uXPnrJFjSE4Kd..pVlVU_wusT5xNv46521IKg423hoa1ie5KyjTH_2ShOn0C
 dNI7sPTZ.x9LieyhaGlNT7igJo262uqFC_oZsMGgSVmLoiUcLwVnvG1c_AYeRmMNwRUmobEeQOAC
 HCWhJIlb6Gzv5_5.iiBBfCvL5W6_5S1L0ztNsVwpnY.GqnmtwEpOuvSucJYhhsKprSR99z78zO5P
 _l1hTYtYviMp6H8De3tlXi48J13DXALOdFiQplrFzu71jdPs8oh1N039zpTcd2v4MxnU6i2mYI0M
 G79rLFaGam.Mw6o1yY98DIyBHqjD3df7l2aFBGEGpQ4B.OXgg0nfcvwp8zCDG97.2pICX3lWqAGS
 wy_w0s7lYFgn3GiJrw51FQOKIP2XGwNCXCxwS_N8AD5qt_Arlxuxxc9nhDMzrVXWTewoh3XU.P2f
 vd5G_rJ0v8P6UgiX6drz1e3JUrKJYteevHrCuxjMK2FyiBIL_loq8Beu_dEYg_JSqYEhS6l6bmaK
 jxaFrepGV2qkn_3itt0hUgrpXTDIuSEuM5TYAPzsXFzu12_Kdixa2sejQkaAY_a4cBIdXNfaKP_B
 KV7iiFld0gDT5HCCOUoEToR3W2PTVtThE2UazqAGpJU4UNzcYJ1rC5S5mj0n0hQaBXmQ24cNXdWs
 cSOxr.bIsjbLCH1Q7pto_Qs24BPptQEBxd5UYNqYtxY4Z10v4DS7gz2bH8W0VZu_M_Bw0XcfPCLW
 SW34tyBQatRhw27oEmc04aYubqlS0c.TJsxn1LTM86699Mb84itoWiMCfhW60MhEPtGl3guwStj2
 3HKT7IM1bOvHyvDKnpObmCIBSqCcO0lJ4bfacjLLKqbVgRb4JLqPGHXAx4DD079._GuE1hAdNysI
 2GJP4dtQbzSXPb1wfpvUxHwYbyVAlMD1lpa1T8IZpPmIO3Ova1uRh51BEwFfGewNMEr_xzPL61Ql
 iovEAGE3GLl5doMB3QLJo
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 8be475bf-9be6-4332-bdbe-567bf5fee304
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 8 Aug 2025 14:07:00 +0000
Received: by hermes--production-ir2-858bd4ff7b-w59v5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed84e5f4b215a994529c6b9786431bc1;
          Fri, 08 Aug 2025 13:54:49 +0000 (UTC)
Message-ID: <60ab8434533d214b53af15bb51d830e5f07d512f.camel@aol.com>
Subject: Re: [PATCH] powerpc/xmon: replace sizeof calculations with
 ARRAY_SIZE macro
From: Ruben Wauters <rubenru09@aol.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Madhavan Srinivasan	
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin	 <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Fri, 08 Aug 2025 14:54:45 +0100
In-Reply-To: <8381a142d72f3cd0e92de4dac6acfc0241a87365.camel@aol.com>
References: <20250719225225.2132-2-rubenru09.ref@aol.com>
		 <20250719225225.2132-2-rubenru09@aol.com>
		 <62aa5231-ed31-43e2-84b7-d6b6ec86e78d@csgroup.eu>
	 <8381a142d72f3cd0e92de4dac6acfc0241a87365.camel@aol.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Thu, 2025-07-31 at 17:40 +0100, Ruben Wauters wrote:
> On Wed, 2025-07-30 at 08:14 +0200, Christophe Leroy wrote:
> >=20
> >=20
> > Le 20/07/2025 =C3=A0 00:43, Ruben Wauters a =C3=A9crit=C2=A0:
> > > [Vous ne recevez pas souvent de courriers de rubenru09@aol.com.
> > > D=C3=A9couvrez pourquoi ceci est important =C3=A0
> > > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> > >=20
> > > The calculations for operand/opcode/macro numbers are done in an
> > > identical manner to the already existing ARRAY_SIZE macro in
> > > linux/array_size.h
> > >=20
> > > This patch replaces the sizeof calculations with the macro to
> > > make
> > > the
> > > code cleaner and more immediately obvious what it is doing.
> > >=20
> > > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > > ---
> > > =C2=A0 arch/powerpc/xmon/ppc-opc.c | 16 ++++++----------
> >=20
> > This file is mostly taken from binutils, refer commit 08d96e0b127e=20
> > ("powerpc/xmon: Apply binutils changes to upgrade disassembly").
> >=20
> > I think your change should be done in binutils then backported to
> > the
> > kernel. The more we diverge from binutils the worse it is
>=20
> While this is somewhat reasonable, the header (linux/array_size.h) is
> linux specific, and is included through kernel.h
>=20
> I can probably see if binutils has a similar header, or if they would
> accept an equivalent header to make the file equivalent, but I'm
> unsure
> if they would
>=20
Hello, I have checked the binutils source, and have noticed that
binutils already uses the ARRAY_SIZE macro, and this patch actually
brings the kernel more in line with the equivalent file in binutils
(opcodes/ppc-opc.c)

As such, I would like to request that the patch be applied as-is.

Thank you

Ruben

> Ruben
>=20
> > Christophe
> >=20
> >=20
> > > =C2=A0 1 file changed, 6 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-
> > > opc.c
> > > index 0774d711453e..de9b4236728c 100644
> > > --- a/arch/powerpc/xmon/ppc-opc.c
> > > +++ b/arch/powerpc/xmon/ppc-opc.c
> > > @@ -954,8 +954,7 @@ const struct powerpc_operand
> > > powerpc_operands[]
> > > =3D
> > > =C2=A0=C2=A0=C2=A0 { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
> > > =C2=A0 };
> > >=20
> > > -const unsigned int num_powerpc_operands =3D (sizeof
> > > (powerpc_operands)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 / sizeof
> > > (powerpc_operands[0]));
> > > +const unsigned int num_powerpc_operands =3D
> > > ARRAY_SIZE(powerpc_operands);
> > >=20
> > > =C2=A0 /* The functions used to insert and extract complicated
> > > operands.=C2=A0 */
> > >=20
> > > @@ -6968,9 +6967,8 @@ const struct powerpc_opcode
> > > powerpc_opcodes[]
> > > =3D {
> > > =C2=A0 {"fcfidu.",=C2=A0=C2=A0=C2=A0 XRC(63,974,1),=C2=A0 XRA_MASK, P=
OWER7|PPCA2,
> > > PPCVLE,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {FRT, FRB}},
> > > =C2=A0 };
> > >=20
> > > -const int powerpc_num_opcodes =3D
> > > -=C2=A0 sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
> > > -
> > > +const int powerpc_num_opcodes =3D ARRAY_SIZE(powerpc_opcodes);
> > > +
> > > =C2=A0 /* The VLE opcode table.
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 The format of this opcode table is the same =
as the main
> > > opcode
> > > table.=C2=A0 */
> > > @@ -7207,9 +7205,8 @@ const struct powerpc_opcode vle_opcodes[] =3D
> > > {
> > > =C2=A0 {"se_bl",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BD8(58,0,1),=C2=A0=C2=
=A0=C2=A0 BD8_MASK,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PPCVLE,
> > > 0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 {B8}},
> > > =C2=A0 };
> > >=20
> > > -const int vle_num_opcodes =3D
> > > -=C2=A0 sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
> > > -
> > > +const int vle_num_opcodes =3D ARRAY_SIZE(vle_opcodes);
> > > +
> > > =C2=A0 /* The macro table.=C2=A0 This is only used by the assembler.=
=C2=A0 */
> > >=20
> > > =C2=A0 /* The expressions of the form (-x ! 31) & (x | 31) have the
> > > value 0
> > > @@ -7276,5 +7273,4 @@ const struct powerpc_macro powerpc_macros[]
> > > =3D
> > > {
> > > =C2=A0 {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-
> > > (%3)"},
> > > =C2=A0 };
> > >=20
> > > -const int powerpc_num_macros =3D
> > > -=C2=A0 sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
> > > +const int powerpc_num_macros =3D ARRAY_SIZE(powerpc_macros);
> > > --
> > > 2.49.1
> > >=20

