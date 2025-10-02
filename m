Return-Path: <linux-kernel+bounces-839873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE5BB29E7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77DF189680A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760E28724E;
	Thu,  2 Oct 2025 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFeV6LPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09429A2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386428; cv=none; b=EpidmNDb/pAH3Iji1AN7D1TINF8q2zb5VxwTGagkkl+Iqfo1QOzg1qaZf10rDNHGQDOWVSiXYLCYz9v8uHDSq5GHlbsPIUQBRbViQrKBLZIIPVmxCxJdDmCNbDh5VZlntdwpK9I4cFzvFdWtrSX7TEyPFD7LXAF48lnEmAnu+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386428; c=relaxed/simple;
	bh=1DhX8G4AmQCOmJ1vB9My4LM0gaN6w+0SUeKJUVPDlBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HFUT3pWY59Fvwz6dN7ggnOs62oxQudYJUZY381MiJ/zAsrkPozwZx/Mz7Bl4edtXI6DEazmHFPf4P6JeARoHSJeTpve+XRRtUXPY8EFXl+UKwaO2Zn7vNS5I8NaoRjUypmB7zKhAUcyv0i1T0S0QmVFbWVzIpJ9Mjhf7jpbnOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFeV6LPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3025C4CEFC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759386427;
	bh=1DhX8G4AmQCOmJ1vB9My4LM0gaN6w+0SUeKJUVPDlBI=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=MFeV6LPB7S6quC+osEFMIz0yFRZ/gPYadWDyGeegSIBhqa/mcJJSI1sh8lnLrMWh4
	 uZi9WwqTqeDPQ2dJSyaMO43bul85r3waBDp/scEcHIVwCHy1a+fUFUwE0DUjOlbA7J
	 71NfBh8duSA1duLGG6AaWPLArcZz1TdK1ESKL60i59hNVZzygShCM75J/6uhiJy+qt
	 a/l/8HVo9sBHodLeS77/LLMxTa5cww4k2BB7BerGIPeLVTjOenZ7ggQvgybzdOQDRk
	 +oArasp3JtUxEMthqLhenn7YnApOsS0XNiU7XJcywL01Mtei8FWeys4cVBFrhAAOzk
	 zFbd/3heYZ8GQ==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b553412a19bso488396a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:27:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6DlZ4jxdg4VOXMe+Ljp34Ao7QmVt9jjNfG4obwCUVwJWBW6dhVY+lwjCkoS2f8RrAMw9jdE0XkJGRfLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJrn8pq3uf+oSLJQCxvmrlaWKOQ5QV/UT00O/GmkEh7Pex7sb
	dOCxwJmCIO31cdnoNj153qPX+16E0dkt1Vb2f4e/bNGJ3e/JIiBimPRNJw7y7SkG0d6+/77Sb4i
	3uJ8E6znGlC7ARqlTEnHvjN2ousR2BiQ=
X-Google-Smtp-Source: AGHT+IEBLYk86/uoWVqVDFVxsuuHAaYCqIcSDwfTNMYhCdYZvniopfSVQCUKi57uRCuIhyPS1zqvLHtO1RgzJgA/suw=
X-Received: by 2002:a17:903:46ce:b0:266:2e6b:f592 with SMTP id
 d9443c01a7336-28e7f2a3c2cmr78644685ad.25.1759386426550; Wed, 01 Oct 2025
 23:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
 <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com> <CAHk-=wjsMPACg__N37EL8Sh=z1wkCpj+FQKpoVPXzyiVpm1i_w@mail.gmail.com>
 <CAGE=qrpygJ4XgtzdnGACj-6KRiD8r57F4ogNYaA3LLMusBV9fg@mail.gmail.com>
In-Reply-To: <CAGE=qrpygJ4XgtzdnGACj-6KRiD8r57F4ogNYaA3LLMusBV9fg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 2 Oct 2025 15:26:54 +0900
X-Gmail-Original-Message-ID: <CAJKOXPcRw3teqahDc6RBCz8XvqLt2sHqxrOUxpA84RszcsnGFQ@mail.gmail.com>
X-Gm-Features: AS18NWCWo6vnwjd-C2QP8ttuauCGBObIKlzBdGNND_qylV7g0Yxxc3FjzsZeoAs
Message-ID: <CAJKOXPcRw3teqahDc6RBCz8XvqLt2sHqxrOUxpA84RszcsnGFQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/5] soc: dt changes for 6.18
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 15:04, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
>
> ---------- Forwarded message ---------
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 2 Oct 2025, 13:44
> Subject: Re: [GIT PULL 2/5] soc: dt changes for 6.18
> To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>, <soc@lists.linux.dev>
>
>
> On Wed, 1 Oct 2025 at 15:27, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.18
>
> Bah. I've merged this, but this causes build failures on arm64.
>
> I only noticed after already having pushed it out.
>
> > SeonGu Kang (1):
> >       arm64: dts: axis: Add ARTPEC-8 Grizzly dts support


I'm sorry, I should not have trusted contributors from Samsung that
they know what they are doing and I think my CI misses allyesconfig on
particular branches, because for-next branch did enable this symbol
and it was tested by my CI. Also LKP tests each of my branches and
didn't report this, I think.

Issue will be fixed with commit coming via clk tree - Stephen Boyd:
https://lore.kernel.org/linux-samsung-soc/20250825114436.46882-2-ravi.patel@samsung.com/
And git pull:
https://lore.kernel.org/all/20250909183504.104261-2-krzysztof.kozlowski@linaro.org/

I understand this won't fix bisectability.

Arnd,
Eventually you can just mark arch-artpec as broken just to fix your branches.

Sorry for the mess, I'll extend my CI to check this in future.

