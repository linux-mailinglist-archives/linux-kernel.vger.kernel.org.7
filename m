Return-Path: <linux-kernel+bounces-828926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63CB95DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB99176CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F110F321457;
	Tue, 23 Sep 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="goYoeCzg"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10079CF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631659; cv=none; b=lu886cOJT6Niex8kmRTeUkig0rxIqGwz9gScXcRMfksxJIhUk5yznd2zJ8CzmmCF1pN/eDYWXJCca+LGkHYaSfVmO/Gu0VCrQL2PcqV8R5O3ZqkcBSwdVPtRh9tuzdZhW9PY/IVGujxtbwkkZboD4WiXn7gSJTbPG/ZwW5xLHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631659; c=relaxed/simple;
	bh=kPBgF9+dGUn8iMRaO0MtnLkZR291typ9muRvNpWVJqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdoodyjKwjvdp0S7v6WA6BFLC4KClvVknfIyutRG/tIcTAcoVZh7G2Jr1Z57n19PExeTzbTQYwKeuGHuAhlPdfCiT3vM09h9Rmt0UDUX2B2RMfCXWX1BzF7d679iib8winL9N41JU0UZ5bKC5Bp6Sjt/YJtw0+8unkqbKTJbURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=goYoeCzg; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1758631172;
	bh=1E/bD/YdbQ9BCpVoRqiOFmrcUTyMSHC8nob/1oH7+Ho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=goYoeCzgwGQSGcgxjY0a+p/oetBkUsJjgVO2Y5jfdQ90V+6dFaabUMzZ4kjI4QO+C
	 tX6blgtuhvRURHeY5/j9ifhPm7v358M0Ns8r14qShxWM8FIXcaFPAdMEmfi/R4sgQu
	 k/VwTYfcxLLnRY3+uNotHBhjsevUKbmythZiMcsE=
Received: from [IPv6:2408:824e:30f:9ad1:c427:8c70:2426:3] (unknown [IPv6:2408:824e:30f:9ad1:c427:8c70:2426:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 177B66691D;
	Tue, 23 Sep 2025 08:39:29 -0400 (EDT)
Message-ID: <53b3b0e4c12f048d17e95111ac97b59fa35dea23.camel@xry111.site>
Subject: Re: [PATCH v1] LoongArch: Add
 -fno-isolate-erroneous-paths-dereference in Makefile
From: Xi Ruoyao <xry111@xry111.site>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 20:39:25 +0800
In-Reply-To: <20250923061722.24457-1-yangtiezhu@loongson.cn>
References: <20250923061722.24457-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 14:17 +0800, Tiezhu Yang wrote:
> Currently, when compiling with GCC, there is no "break 0x7" instruction
> for zero division due to using the option -mno-check-zero-division, but
> the compiler still generates "break 0x0" instruction for zero division.
>=20
> Here is a simple example:
>=20
> =C2=A0 $ cat test.c
> =C2=A0 int div(int a)
> =C2=A0 {
> 	=C2=A0 return a / 0;
> =C2=A0 }
> =C2=A0 $ gcc -O2 -S test.c -o test.s
>=20
> GCC generates "break 0" On LoongArch and "ud2" on x86, objtool decodes
> "ud2" as INSN_BUG for x86, so decode "break 0" as INSN_BUG can fix the
> objtool warnings for LoongArch, but this is not the intention.
>=20
> When decoding "break 0" as INSN_TRAP in the previous commit, the aim is
> to handle "break 0" as a trap. The generated "break 0" for zero division
> by GCC is not proper, it should generate a break instruction with proper
> bug type, so add the GCC option -fno-isolate-erroneous-paths-dereference
> to avoid generating the unexpected "break 0" instruction for now.

I just proposed GCC to use the same "documented undefined instruction"
as Clang:
https://gcc.gnu.org/pipermail/gcc-patches/2025-September/695981.html.

--=20
Xi Ruoyao <xry111@xry111.site>

