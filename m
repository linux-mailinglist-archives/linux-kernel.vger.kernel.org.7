Return-Path: <linux-kernel+bounces-853982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE0BDD37B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F325B4F13FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331BE3148D5;
	Wed, 15 Oct 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/qxvVES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A72BDC23
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514817; cv=none; b=D1jFutKEk8f2dXcnqR8DdJFgtvnj6LzcFs6IVpKERcNUAA8m28DAPL9kgUbzrmspoe6wKWHixdrWrvf7tCZocA3hsAD88SadOMfvZG/MRxnpFA479DQdahw3VsLXZgA7FiKCywy28YjZArVR2a4/uZa7Tsu3QUS6x+EDKLB/fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514817; c=relaxed/simple;
	bh=BXvOyevxKfYoxJEXrDcR2Vvt+5aQfsIM3B8CoUKdleI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXIbFLUcAiHMobBrXyANMpaHtSnSSzG3e9C94WubRorVRODWu/zuUKLmij4J2MrtuzqLvnfiz91oEtcuHsKH4hQxzhwnbOwcEqxI/Cp0FjlsuigRQmmoct0n0IDZNMgzmj4w0F3belIoj3koCqM2v4/oQreiDBqrlPPoYOVrlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/qxvVES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F969C116B1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760514817;
	bh=BXvOyevxKfYoxJEXrDcR2Vvt+5aQfsIM3B8CoUKdleI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R/qxvVESojI/jrSmvJMfmHPQ+nB2asAKG+TouvLyltUIAlUlGOyEreXOBKaBlWm7C
	 ujgm1NuxqJIM3vjR05UwRrY70e4jRWRfqnneY1FzdBNmdFNA8X/4gvdO0mn1BPuuIG
	 TlmB7XTP4GX9sSuJuWnLSQcsG4Q3WqM6/Es9sEN4QhaHkoKd7pTkBB63mS6CAkj9Tk
	 NZAdC0bvKrrGKqj4I8jzQPpVgclaisrfC7h5NMd262xJ7n9G9KjE+Y5vXCjQQYm//7
	 uFS0UWDw/wDR2xmq6ZprjMV+a7WEB4sApFfT6a/RaWeza7rhl5Wh9eUbrIjuSfgAcD
	 9f6qUM7xMDGyQ==
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3326497f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:53:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOyccc78scCzUXoszu0kod436L3HVbPQr08u7/JYN31Yk5LF2J1EoaItHDlSGWqoJwUY9GoQwjsU6cDXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbptXro2cB+90cVsR4FANQ/Sc8ucE3K7cclqxNCBwMivqGyX1
	q0oqsTB+jCt9yI5fKuOJLj4S0hGi2gBuU2stGp5WZZSpCjsH0OUpEZkBgDspLj5v4xzilecyUHT
	XTLQI0IOS5JqpNDVpPeenQ5tSkrJfIu4=
X-Google-Smtp-Source: AGHT+IFLEko3zxqnJBBQYMghgC3Bi+KtEQ0BPBa4eVFzxD0JBAF+8qpqRM8uz9NOfmKaFfho5SP9a5sDu6xtu3nyJlk=
X-Received: by 2002:a05:6000:4a12:b0:426:d549:5bf7 with SMTP id
 ffacd0b85a97d-426d5495c4fmr11812293f8f.53.1760514815907; Wed, 15 Oct 2025
 00:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-3-guoren@kernel.org>
 <1cfdf6c1-a384-43ad-9588-284335d073f7@ghiti.fr> <CAAT7Ki9_Vm0+v9RHpa2w-Bg3agJy2Tp4d6+tcPJ=M7XX3GV-7Q@mail.gmail.com>
 <CAHVXubgrbjHXAPSLjk6uZmUoa52fTYBvutk4q0GFYJPQ0swrGA@mail.gmail.com> <6c45ed33-d6f8-d385-8b89-9caf2ec18c77@kernel.org>
In-Reply-To: <6c45ed33-d6f8-d385-8b89-9caf2ec18c77@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Oct 2025 15:53:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR9zriPBtOLx5Kt0hFZveL23uHV4W0SvPFLQrzdDU=mkg@mail.gmail.com>
X-Gm-Features: AS18NWA1yg3OGEsR23zhZBTCd3Fqa8-V1EkK33wNCF_O98hwKc-l8831O0GBPzg
Message-ID: <CAJF2gTR9zriPBtOLx5Kt0hFZveL23uHV4W0SvPFLQrzdDU=mkg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: Paul Walmsley <pjw@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, palmer@dabbelt.com, conor@kernel.org, 
	paul.walmsley@sifive.com, bjorn@rivosinc.com, eobras@redhat.com, 
	corbet@lwn.net, peterlin@andestech.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:37=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wro=
te:
>
> Hello Han Gao, Guo Ren,
>
> Sorry for the delay in responding -
>
> On Tue, Oct 7, 2025 at 11:36=E2=80=AFPM Han Gao <rabenda.cn@gmail.com> wr=
ote:
>
> >      This patch is included in the 6.17 merge window but not in the
> > 6.18 merge window.
> >      Is it possible that the patch was missed?
>
> This was almost sent upstream as part of the v6.18 merge window, but give=
n
> that it adds the ability for architectures to override WRITE_ONCE, I thin=
k
> it needs one more attempt at gathering feedback before we do.  I'll send
> that out this week.
Thanks, Paul, for the effort on this patch. Yes, overriding WRITE_ONCE
needs more public feedback; it makes sense to us. This errata from the
c910 early version causes issues for the community, but some SoCs,
such as th1520 and sg2042, need it to prevent potential risks.


>
> thanks for your patience,
>
> - Paul



--
Best Regards
 Guo Ren

