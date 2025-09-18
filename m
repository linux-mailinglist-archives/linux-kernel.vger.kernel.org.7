Return-Path: <linux-kernel+bounces-822391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E6B83BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FD61C217EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17E301025;
	Thu, 18 Sep 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hprDUiwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7752FCC1A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186954; cv=none; b=tGpB93pGDm+ANbvljCE/OhtfeLfkJkA46pOgyeQOIBwkzviDciHr91lm3Zj24QmIHlh71yksdV2Z8j9uxghakm7NEvbEU9MLu9vSdE/ZR9oFxw2dKtxa9jhjV9RG/a8AmMVPKkkS1D68423npLbuDkL96KTeJu0l4BX7fH0SLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186954; c=relaxed/simple;
	bh=JioIRjm1pjnSFEX7kz7Gpp5pvAIywxQ+InWZtkW5LD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDY++zcmRr76oz6Qc1Q3IGmOliO8mPVmFYe0VmSeNM/FJbeNRIdjQCoS26+6PIsFjVWWtMCfA88lUCDQNjmCzJokD5iYYDFldbjYFqzecS9S0cSWJTw7/JRretkE1bAX94U1xn1RaM0x+BEbg0E65F4j0SU/sex6lCIwJK9a4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hprDUiwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E49C4CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186954;
	bh=JioIRjm1pjnSFEX7kz7Gpp5pvAIywxQ+InWZtkW5LD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hprDUiwYv7LdajOxcJLYUZ5KvIz2v/73XvDAzrNfrOD2rsMK4Ls91Oz5D2ESoyhDo
	 RB4AqWUSq/U8vykY6JlJjvKDc5IRnah0Izj1sSK7W4R4l2PGpY1kDesE58YcQeG6RS
	 tq4CTAFHirCHo7v9GwKdRt5rWqBxJIMMRNz/b0EtfOMSLcmu9luWi4CE037QHolzMb
	 d5W8dL2zATrabxd71g7LRSzvimrk5/WpjObGJWWViVAHoSM6sDhBtauYBFllO16LUB
	 EZVwtm/Ndd7k28rm67VpDUdXqScwI69gdRSALqWKiTQhCmr9Ldh7AK+lSd99soZfRy
	 KCezaaOgBZwGA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so335166a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:15:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNvW+RRpyQuE82/ATSfESUy1Jh24sxXnK/vvdiAVFqHGjsK64Qnkf0tTRnzV+GgUDIhXsC9AwgYciLXbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJ+L4o+2tYKCgQTx+zB2qvkAc3xRGeQLiE89t6hxsbWDk+qsV
	qYgkDl6LYOBNYjB9du6cTNghVePzROekgIq1Mig4UUAtqtmP+5nWpeV1ftnrGk59iQ9SXf4HfJi
	s6HGnaUoAw+u8SSEkO/y8VZGOG4p+wlI=
X-Google-Smtp-Source: AGHT+IEk3h287uKRDXWVpOeNPDnid/UoIqNqxUIYNyoaTw79op37izNsuKnl2Uvritf8RBvXgz0CzP6PlJss/gHR6uE=
X-Received: by 2002:a17:907:96a1:b0:afe:ad18:8662 with SMTP id
 a640c23a62f3a-b1bb2d10ef2mr581159166b.23.1758186953020; Thu, 18 Sep 2025
 02:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909092707.3127-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250909092707.3127-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Sep 2025 17:15:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4SbWuzBespJmDQ6-vQovAmzORhZXYfvnB7a0nz2AOyZw@mail.gmail.com>
X-Gm-Features: AS18NWAS3bq5ZrmLUExLO-uHtoIDNHHxh0zUM9KG-uSTh03r1aTRf23RcKMokVo
Message-ID: <CAAhV-H4SbWuzBespJmDQ6-vQovAmzORhZXYfvnB7a0nz2AOyZw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix objtool warnings with RUST on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, WANG Rui <wangrui@loongson.cn>, 
	rust-for-linux@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Sep 9, 2025 at 5:27=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> This series is to fix objtool warnings when compiling with LLVM and
> CONFIG_RUST is set, thanks WANG Rui and Miguel for your suggestions
> about RUST.
>
> The second patch uses the option -Zno-jump-tables, here is a related
> discussion:
>
> https://github.com/rust-lang/rust/pull/145974#issuecomment-3236418282
>
> Tiezhu Yang (2):
>   LoongArch: Make LTO case independent in Makefile
>   LoongArch: Handle jump tables option for RUST
>
>  arch/loongarch/Kconfig  |  4 ++++
>  arch/loongarch/Makefile | 16 +++++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> --
> 2.42.0
>

