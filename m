Return-Path: <linux-kernel+bounces-737969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400E4B0B2B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566D43BA9F3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490B2264B7;
	Sat, 19 Jul 2025 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aol.com header.i=@aol.com header.b="i4C1XFGb"
Received: from sonic310-22.consmr.mail.gq1.yahoo.com (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB1176AC8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752966201; cv=none; b=b6xNhYxgeDcD84e34lR65pmOCnp5Fa5sVe7cgeSt6zVPuyw8jKGkXDgbqAnwVFZFwSYFk5XEKi5nVvCM0CKeFuPcjdkzWBGNR2N5EdM4LiVS0Lk4n1divM7yC6ko0UJQx7qh5oUk4zDJLfkEVmm+5JWDRJ3hPNC3tMYhGDxHoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752966201; c=relaxed/simple;
	bh=8hdbAKwnFmTXx4szhbKumxlLnhZDQ4snGBbnChoqlzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=c5QO5xhXIbHpiGQXYexL3UNxT3xYry/ZdF6yHQ6oBNvPCNJJbqWjDb6XDJWGgeAL3is54Gi9+wiEaEMn2aIjBD2Nb6DaHxBVv+eGmBLfVJiXYERKOI/ZgWHN2PYonypBFJazpQQqV8Ey24LKaHbMMB+yEmXmmDyqRHJ2YqzFkD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=fail (2048-bit key) header.d=aol.com header.i=@aol.com header.b=i4C1XFGb reason="signature verification failed"; arc=none smtp.client-ip=98.137.69.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1752966198; bh=Ce6Dt8pLkw9UGkCntDHrb1L0yj8e9KlBmSuxz9VENrA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=i4C1XFGbvfWH4KAPcR2WgKQtZSynQFUInpnQNMLUTjuU0AHB6IlTvv9qVkDih+3ZBjLCcMi+AL88aKCCBLI+xpyIHrg4q33sIuah8mrhnuKJgIm8GPo6A1KCscYXwJgtLP7lCZ4wzibQJubz+5V5+7UGQUaXvLczl4Yqd1/2BDoFEIdD9v0/sn3ee+YmgJ1sckiTeBtfVWiarW4zTgkcQtjfAeniUxblQ7A6Pfipowiw18Ed6q34dFRUt+KBUx/mbRSyR2mTF52sU66o6BSut7F6oFtj7YbkibmaMNztk0txOILJClHt1zvP55A5lQNqO/k+QoS5pzmK11PGIjuP1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752966198; bh=32ZjcdF0z+MPoka80O0aEUjO6pGezSXcdEV3D1srxmp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NOTRMuxLM0kvKL07S6dieGKZzMd2Fxz1mjV+EuSi7cwJkkf0JS2KpooHY07pHa053gbnwhuRTS3pCtKHGdgjzVx0oLwqEX5P5US1iLsU0PqHlivqyxz4kF6wxxSlo3Uw17ksPO7EPA1xZKS8kBMuFANEkSXgiViJcBtr5GxSvehPgacZoQ/pKAZGNBhJK9qNBBtuj3e+lMHYYr3d7u/eczRKWFOIJtgMV/GMCMVdIgTufrGJlARsqQloqrkwZPoVCVKydr9EjoeL0zXIj4H+C6zrASTVNH+GQbp5rX2B7MlWUwZt56fKua/cJv12soNjQyv8c9Etc+sXhpZkc0ocTA==
X-YMail-OSG: GgHGVHsVM1le1GpABCKtwqX3OS01ervBkTlED5XMfdsnHr3RMJF6oFAxjLDW6g_
 KRhlBdWsrojSjC.kHno0xJL063g4cpF5eL5rUWB74i2bTjSUd6D8IqPeoWsoyqf8xlfNrVUCsVHv
 p7U2KxlkDZEoKBEkzLxuM_pTiIGES1DfvEqYcZh8wL0Uf1Qj0Uf2KH7rB4zFwSHjCluRYHmn2IMV
 Jt31W9fM0UH59k4n1vYfl5rXJVPa.mF8VroMWLWM7Q3IonJbRlpP0ZRfmDIJbkWQSHnqeXMqXpRE
 cmQvrtQsTf7qidtLYLyHWzzqa4ZlSDRLAXnNGD0I6Acqf73PZ6byyvn9rRgF5ENKYMX.keLeFUw8
 ybuGvCPTFWjEpo14U8dCiAg850l4d9NywWW8EnOa5fk7AKrCaa2F3Z8HcASJ0RZMaAMvtVtcUI_s
 mKeNa3HJTPBsDiIN5Ov8C_fOMWLuz655QL8t8w4U.Oi0riyTGpi6W8MqwL5xNQLi5BKwUrY35qhc
 npi1XhrJVobRxuUqyiX0WwqB4VhQ_1J_Eerjat5hx8PEELjqSdPLVvWC5jASzQd1ndCacrxE5Nfp
 _W5FoGMZVw75W_Rx.z3ZDaS6biPoGnTi_UQo6cQw2QbADbtb4c0haxg_i7SyUeIC5hYI0UY7RTQs
 19S6KcPHjFAKzza1a0qlqizNoUcPZuZVYq9Z6tEmJ_2IX9c43iGFZ34sWOB7Zr82DIzRlx7PSVaV
 7_2gM.lAHU3zcV8BW0PbFNBTmhHXFlkupnVtUXdbS74_YW9WRzRiq2Nvsu7Iv1mA.g8ED.JrT17j
 CKDA0KDYNf7Hn.srBWdcKMHoUMOZeztRfUBonQCcmZi.lAfS.AEunFXJog3Xz.M1f5_qXO0GISx0
 UX9B6O7WhvEw6yzyxCyIFpoSx0YfvRdHRMw4psRJfhibOHPPrqlVf2bwjCElQQkfGBlUGtOYFlK3
 gio4UaSvGTNqGyBw9USMdtoysm0b1dG9qTnT_ex_cUY2HjMYkWbkSxEHSU9YUF6Sr.3BxQSaXJ7R
 Usx4taPFR7YJQDFUwM8xagG_MAm_yKve5CIX.GX.sfn1N8cgWuP7hOsqtYoaWKhiEOnNQyhZtqov
 TdUsxY.q.KouB4DNZGZKfQW5eJaTdZxj59H.6ZsFaPICXFPlPkfLtUuS1dWhYlJxO2xjQeLsP5rr
 aubhwCGF0TXH4hdGHg_uC0963xhVrp4rU8EZbePUjio6G8LYtYPc.2wWhv52cWz4A1L2rJr6.Hlz
 WlR4muIOkma9gI_niUNgfuElPrwLazOruia6TbTITQK53i2j8rD.NyvgSvPBf6fgA5DWtqmAs4AG
 UNQqoeM7r7ychG7Q6f6AtF9vAhREIRq0XFloYD0NA8ZXWInNlFODKQxIte2Of3fbsbseNdujtaCv
 DbEtt4u8xCoUqv83VwehJME6EhcpjS0uODXGs8EWn0dAAQkbb.InQDMD1aEJPS77HZr7z9rdvocA
 EjAWOqUM4WTfu2vEajZ_RlR2xQi.rrHAwovU.H9TG80HT8BQjJsykM.ELrP7sUXDh4SSJMc18Ktx
 .Mxc9lUjFBDXgGNf_4qEsyfVOEwaCohE5Vc8LyVcmUoO0vXr3MTB5gR8my1ummIIWaH1p.P9L0qb
 6RO7Wz5bbI1kD6mXFqfISlcj8y1XhzX0ThUO00BGFjbGPrvLSxLW.1NfcwVbHfJhTyCh40s4eQ9G
 0ChNcKzSDb4rK6Clw5LBDwH8NYP_GVVlOElhgOXRxOmUvdJxJoMI2tWDKt56hmIIyEQcvPYF1Nug
 FEUA87_xGFIiCtvBP_SJbZcnxldpGGXkFXpMm4PiBRodwhIuf9UkBCZSOc1BJPFt5Wh47JbJkt8s
 ma7Cjk2M34wr_NlLclR27OtnuitXH66YxBBJjd.GIsmAb6BPL_IJvkGPmW3v05BzSHb8U5N_0lXZ
 fumvA6gFQTpEJG_P4DkbEChy5lDaup_16KqJn4Jt2QM5vZ3bZMsrDF7QmrHwgV67HGn3sl5feqZ_
 nJPs08eTERGgARJaEU5hL7AoDE.oy1EELIajodW5bD56YqLoohB8O5eXlwgN2jmu83RTMJklO.ZD
 JuMk9_Moy7liZiHSIzwcTw2UWvr0tkwL.JVvFAxj8nf3Ep8VmEF3xNhOrn6RcOrQQv2INYnmwtLe
 GLfQgi_cIGBLv.l6olIlDqCTkK1d8o8nd3nzVDjSVWbzNpjXuSlRcSDo8ixOhQ47QInNRVs3N1H0
 mn2Q0cJrcJmKzbG97.sBJgY2CuoYvYMZNj5CHK7p4iy7A1hF4wFxCRV3MEJZrJBI1Gjg6WNE-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: fa017355-6ef2-460f-a50d-35f54d9307d6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sat, 19 Jul 2025 23:03:18 +0000
Received: by hermes--production-ir2-858bd4ff7b-q7k6m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 320ab1abfa6527764d3740cb14f93fe5;
          Sat, 19 Jul 2025 22:53:10 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] powerpc/xmon: replace sizeof calculations with ARRAY_SIZE macro
Date: Sat, 19 Jul 2025 23:43:10 +0100
Message-ID: <20250719225225.2132-2-rubenru09@aol.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250719225225.2132-2-rubenru09.ref@aol.com>

The calculations for operand/opcode/macro numbers are done in an
identical manner to the already existing ARRAY_SIZE macro in
linux/array_size.h

This patch replaces the sizeof calculations with the macro to make the
code cleaner and more immediately obvious what it is doing.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 arch/powerpc/xmon/ppc-opc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index 0774d711453e..de9b4236728c 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -954,8 +954,7 @@ const struct powerpc_operand powerpc_operands[] =
   { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
 };
 
-const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
-					   / sizeof (powerpc_operands[0]));
+const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
 
 /* The functions used to insert and extract complicated operands.  */
 
@@ -6968,9 +6967,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
-
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
+
 /* The VLE opcode table.
 
    The format of this opcode table is the same as the main opcode table.  */
@@ -7207,9 +7205,8 @@ const struct powerpc_opcode vle_opcodes[] = {
 {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
 };
 
-const int vle_num_opcodes =
-  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
-
+const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
+
 /* The macro table.  This is only used by the assembler.  */
 
 /* The expressions of the form (-x ! 31) & (x | 31) have the value 0
@@ -7276,5 +7273,4 @@ const struct powerpc_macro powerpc_macros[] = {
 {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
-- 
2.49.1


