Return-Path: <linux-kernel+bounces-764557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99185B2247F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6601AA6171
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38A2EB5C1;
	Tue, 12 Aug 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGqKtaHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA892EAD0E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994127; cv=none; b=pDN2DPJ8lUe9GfiVExaVjSBkVjxu3jP2zzgWGaD1rI0BoOpUEl9boikbjAkCsA9HxQh16LZ7LEfo1KYK6/YPnoEf/w9bNPD7dtWVbvW9tN/WBd9fnfd4YBqsVxRTDXtkogoNVq3Qnbb3QeXe5xdmK6452sQlKSc2s2EQyG/fEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994127; c=relaxed/simple;
	bh=E+SNuixBGMsLLis/Y2e4FQt/DYqoQuQqWyZPZSgElaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFf04eJqSZWHaqt0MKvyD+brWF1xTrfY4xuKN8rye1FD5WXLBjkq3W123Sl84wImvBvp2Wv+pYbmnAQ3v1o0x0am3TNm/OWqU+Wdz6OGluzHhwAbxYE+dSHgQyFDcx480He6pZmoc/eaVvaJOpXHdxuDl9bmH1RHI796xQgxMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGqKtaHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725E3C4CEF8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754994127;
	bh=E+SNuixBGMsLLis/Y2e4FQt/DYqoQuQqWyZPZSgElaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PGqKtaHag4QomcPelsYeyxh9qQPOmmh4K3KLW5vE5JIQGkm2NbGa3ixwo8Xb6yB0N
	 q4rKWVOo35/c1Y6EAVL9ySbCZBDwuQpseNWKWmF9WNGg0g4OTfwp833zzlBOr9ANPA
	 8EkaermCNp9lN+DviIjq/FudRb21lnksKImiqqqwlDdrnKyO/LlfsCQDTFsKhWc4TC
	 YHSev69SO0CFHZsFBj4TYkdT3YNY/6BmwHEJshqS2M9mONZZoE/mECpmoWWT6TTd2m
	 yyPCT9daoEUQi9ohWgw/WLWvJVqpdIyDoapwqysYkMMoZBZm1zvWr4pwlozKOUUNLI
	 mqJMCg++jc4MA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so6173464a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:22:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURsfCy8w5Ah2wOEb8XVEdzHWfpRiNJgd/iBKVMd83JCwBgt37tGUwp/rpJ/BON3rNvNjTugvWxZwB4VQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UVxoHFuUpAEtmBvaLzdOh6qHSsgRt47V/Fgmvfk+psAE/2nu
	aCEqFQwLrwmtJYnJOmflQtazoRinGC/MkS5UyJqcObxxHHIijmav49jiAy+setDh9hHuhGjW9ET
	QlXJu1ardpwkZLtBurthFdcUDl3HAyKQ=
X-Google-Smtp-Source: AGHT+IFkNjupZpdoLAlT0oq1OmgQ4HoZcgBQsYKtIDHfAAJjJ/DCJE2S+arsIN71eZtIMvsKYL+oYVksF2s9xGDUEb4=
X-Received: by 2002:a05:6402:2808:b0:617:c6b1:70f9 with SMTP id
 4fb4d7f45d1cf-6184ea28f5bmr2183682a12.4.1754994125996; Tue, 12 Aug 2025
 03:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809130419.1980742-1-chenhuacai@loongson.cn> <aJsHNUrMdGg3rq84@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aJsHNUrMdGg3rq84@jlelli-thinkpadt14gen4.remote.csb>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 18:21:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5TPNJur6Puebo6Y-FpkXu73-5eC68vXHm2zFibDiP0AQ@mail.gmail.com>
X-Gm-Features: Ac12FXygwpryiw8uym2v4aRt2vjfVeEnivl3McwQ92yWt9KGaprD6NnHBAYNkck
Message-ID: <CAAhV-H5TPNJur6Puebo6Y-FpkXu73-5eC68vXHm2zFibDiP0AQ@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Fix dl_server_stopped()
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:19=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hi,
>
> On 09/08/25 21:04, Huacai Chen wrote:
> > Commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling=
")
> > introduces dl_server_stopped(). But it is obvious that dl_server_stoppe=
d()
> > should return true if dl_se->dl_server_active is 0.
> >
> > Fixes: cccb45d7c429 ("sched/deadline: Less agressive dl_server handling=
")
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> This looks correct.
>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
>
> > ---
> > I found that after commit cccb45d7c429 ("sched/deadline: Less agressive
> > dl_server handling") there is always a message "sched: DL replenish lag=
ged
> > too much" after boot. Then I found this bug, but unfortunately this pat=
ch
> > cannot wipe the message.
>
> Does
>
> https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.=
com/
>
> help with the issue?
Yes, this patch can solve my problem.

Huacai

>
> Thanks,
> Juri
>

