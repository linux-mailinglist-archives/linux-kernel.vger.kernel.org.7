Return-Path: <linux-kernel+bounces-770606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C266EB27D10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392F51D2353D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A425F995;
	Fri, 15 Aug 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CtjDwxIf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B4263889
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249651; cv=none; b=PD8O05e7gifEbr0VQMl2Z804IvJvHW+ASLcE7nN9WTyEDUefZSRYs2ruiTegtdEjYjsIR88d0f+BHC5Dlle7KQh1Y4Cq2/0TUZH3MxyS/n8e9egoISznsc8D7ej2JAFRcDdai2anN3JKPEnRkfhjyMTw3TrjxVE2bIHbr+enMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249651; c=relaxed/simple;
	bh=LpPa5rd9WJrdBqkLu7w/G32ULzNAg3KUFgXFQr+w1sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZuYoB1iG2WroI0xstt4fXbaw5XTUqL2AI/zR0Ln2WwJHj9DbSfkSSBcbE2ZBPzdmLUL2b9+C3Ru9jkH8L6UR7j3oJfRt+KzmOaXF7Bx6g7mtFknWwg9lXk4JRWDz2iNpYDq7Eq/BXWcVJZ3hfR9bjZtjinYcvDrPP4Bx1DbF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CtjDwxIf reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6717D40E00DC;
	Fri, 15 Aug 2025 09:20:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rJyc6zH45y3x; Fri, 15 Aug 2025 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755249638; bh=kMRxJ6TBaw4t9VPBEFReqtTBCsu+abZh0Vxuyuw9rEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtjDwxIfz+ywyHT8ntixP1JZ5pQwKChOYigK9XOMRsppZMwu9QX7BweKFEzMHaZO3
	 ae/8JbxMfI+mkjwq7YfvH9G08CsTZHstDhT/pP4XIJljL1aeyFC3SrAXmh3Y9ITpJB
	 I+D9HTlAwBFHX3RC4mmMRNGHaK6mFJDS3qEhhk6Jx6AuNxGSt20/OGI/LUiR9Dqqta
	 IxV5lrq5b1yutamsEFk0Rufzb9Osyy5vWB/OLsji7CeecCxCrFdbD4rJa8D+eRI2ff
	 WBRCeAXghBRaVDer9ArblkmhGlir9wsVNZyz4r51lz5uq6CRNHloEIpbh6QBeBMnR0
	 qRgB/q3SpqesOyFAyPB8hh7WEseicI02M47Tq4xNxlRPjXvwrvW0yhQnd4iTdhGc+d
	 2eKcbAeaKcJUbq09Yk0kpgZ9mvOB93EHPAvkG6bkgfu1xYz5XY35HSDptzKCbgx1nS
	 0LekMv7ZY49y5GP6B0MYGjTs8xxeZOeNeKVnaa+xeo8gVVGWMpgTTsaOu5SS9fM3eU
	 oPStlnfyjiOsaXNzTUdySnKHYrzccZZNAUdXOElmmOhucH8YI4vEPJDYmJqQQAuPmp
	 ZY14kAps1YtyWSlFcyEpyIFCxUl4JDr6rvS55g9bAmKpLw3Z6sB9aSKctLAHgdOqFV
	 QrLbHdXM8x2FJG68DQM9RKOA=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D95540E0289;
	Fri, 15 Aug 2025 09:20:34 +0000 (UTC)
Date: Fri, 15 Aug 2025 11:20:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
Message-ID: <20250815092025.GCaJ772U9p_UpEasfa@fat_crate.local>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
 <6b345bdd-d5f6-4967-9f2a-15c2d371ef1b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b345bdd-d5f6-4967-9f2a-15c2d371ef1b@intel.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 04:08:57PM -0700, Chang S. Bae wrote:
> It looks like microcode=3Ddis_ucode_ldr is also supported.
> This could be added here:
> 			ldr_ucode_ldr
> 			Disable the microcode loader.	=09

Done.

> I also noticed in arch/x86/Kconfig:
>=20
> config MICROCODE_LATE_LOADING
> 	bool "Late microcode loading (DANGEROUS)"
> 	default n
> 	depends on MICROCODE && SMP
> 	help
> 	  ...
> 	  the kernel command line with "microcode.minrev=3DY".
>=20
> This outdated has been there already. Perhaps, it might be better to fi=
x
> this typo with the new one while updating the option.

Done. Good catch.

> nit: s/64/sizeof(cmd_bug)/

Done.

> I think the behavior here differs from before:
>=20
> Previously, the minrev requirement could be enforced by either
>   (a) Build with MICROCODE_LATE_FORCE_MINREV=3Dy, or
>   (b) microcode.force_minrev with MICROCODE_LATE=3Dy.
>=20
> Now, this requires both. I don't know this is intentional, but it=E2=80=
=99s like
> asking for more from the user.

Yeah, you're right. FORCE_MINREV is not a CONFIG item which enables
force_minrev support.=20

Ok, here's a diff ontop with all the changes I've caught up until now:

---

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index fc002b1a9f57..e7badf2aba63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3770,16 +3770,17 @@
 	microcode=3D      [X86] Control the behavior of the microcode loader.
 	                Available options, comma separated:
=20
-			dbg - Format: <bool>
-			enable debugging mode when run in a guest
-
 			base_rev=3DX - with <X> with format: <u32>
 			Set the base microcode revision of each thread when in
 			debug mode.
=20
-			force_minrev
+			dbg: enable debugging mode when run in a guest
+
+			dis_ucode_ldr: disable the microcode loader
+
+			force_minrev:
 			Enable or disable the microcode minimal revision
- 			enforcement for the runtime microcode loader.
+			enforcement for the runtime microcode loader.
=20
 	mini2440=3D	[ARM,HW,KNL]
 			Format:[0..2][b][c][t]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 462bf03aeda5..77f72f075d89 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1340,7 +1340,7 @@ config MICROCODE_LATE_LOADING
 	  use this at your own risk. Late loading taints the kernel unless the
 	  microcode header indicates that it is safe for late loading via the
 	  minimal revision check. This minimal revision check can be enforced o=
n
-	  the kernel command line with "microcode.minrev=3DY".
+	  the kernel command line with "microcode=3Dforce_minrev".
=20
 config MICROCODE_LATE_FORCE_MINREV
 	bool "Enforce late microcode loading minimal revision check"
@@ -1356,7 +1356,7 @@ config MICROCODE_LATE_FORCE_MINREV
 	  revision check fails.
=20
 	  This minimal revision check can also be controlled via the
-	  "microcode.minrev" parameter on the kernel command line.
+	  "microcode=3Dforce_minrev" parameter on the kernel command line.
=20
 	  If unsure say Y.
=20
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/m=
icrocode/core.c
index 3a4e210f6cf3..f045670a1fae 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -45,7 +45,7 @@
 static struct microcode_ops *microcode_ops;
 static bool dis_ucode_ldr;
=20
-bool force_minrev =3D false;
+bool force_minrev =3D IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
=20
 /*
  * Those below should be behind CONFIG_MICROCODE_DBG ifdeffery but in
@@ -142,7 +142,7 @@ static void early_parse_cmdline(void)
 	char cmd_buf[64] =3D {};
 	char *s, *p =3D cmd_buf;
=20
-	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, 64) > =
0) {
+	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof=
(cmd_buf)) > 0) {
 		while ((s =3D strsep(&p, ","))) {
 			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
 				if (!strcmp(s, "dbg"))
@@ -155,10 +155,8 @@ static void early_parse_cmdline(void)
 				}
 			}
=20
-			if (IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV)) {
-				if (!strcmp("force_minrev", s))
-					force_minrev =3D true;
-			}
+			if (!strcmp("force_minrev", s))
+				force_minrev =3D true;
=20
 			if (!strcmp(s, "dis_ucode_ldr"))
 				dis_ucode_ldr =3D true;

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

