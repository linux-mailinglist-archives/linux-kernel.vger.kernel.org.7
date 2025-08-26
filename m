Return-Path: <linux-kernel+bounces-785855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2177B351D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D89A5E75EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A27275B08;
	Tue, 26 Aug 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2BJeiOA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D6274FC1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176187; cv=none; b=mrvx+rMpjG+2HniUa3e6b7vQ1nBSqwr4GCOzWZqwVelIsEYtMi6GtJTcVI0gAL5P80wXYPMiRoiDjCgDLqnqzXuP5zyaHYDj2FaTkVhqDBfl6cS7I3A7Rq8vKxCWonaAapebXj6dnhqu2RveX0DW5Mq4UEn02ycjxyX5JlTHMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176187; c=relaxed/simple;
	bh=1zDaGs/kld2uTzaCMclVfOGPgjO6KdKJRsGrRbmQ8E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHMcpbjdwDam0KP+qbv45ic9wBiTzCtP7CVJBFmaTRFaIjI0coX1Im5TG8NYeUwuUdh6Fn9ZskfBE8IE1GExcp6GqvNcj0AaU02DhDbXL6fpFkcDwWSf1ucIRk3Jmonbb3Hac7aPelE+NbR0NvR0mJIMR9z8N86TxdAVTaZcr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2BJeiOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7863BC4AF09
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756176186;
	bh=1zDaGs/kld2uTzaCMclVfOGPgjO6KdKJRsGrRbmQ8E8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O2BJeiOARaSX85Eu4LAKke2b4qea2jb9uSRulr5o7pYBqY3xuI4vFfTNjXa3IwUFl
	 lmTdVG2Gduwh3TI7oTAX6we/c8qXeDxfwuDxI+sHyUmr/0otlsiM33r0IFrJsnFC6s
	 zLpcBQmtWb9JRdZS5yZqwjBYFOmkta+KC1U1JACboo/BxFJrQOZTL8H+IlEzwNFOUT
	 6iJ5Xwfe/M9Nitj+7jAPLtg8DZKmYjkmKiOdcCmZLK6U4brTYIzeY3QAT/o+X3O5Fr
	 cDstThcSuRHycFDxSzolkRHhwKq49yh/72N/2a8L512aVhk3M9iyvG9xRiMjOhaXCn
	 oIUoOiz+eR+lg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78f5df4so864356166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:43:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW8h/C1+TfUHO9cJ/R5xBhYNUWeZHHnQBRs50GeDppusdyK921tyBeHylKmWSb0KB2Iv8K1OAjJKWtfn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIpSdwDisKCaj8BYQ7kZeIUZ6PUBKu/Ys6kaOy8aIM9NuXqtC
	Lbnnj1HW18vpeTt6+YR6rJiOKrfTjBKRbUkFqBNxDDWKctDLkb/FKQvl7mQ2vJSZNoTuXl/C5Vw
	oQEwF6R7GGWzPoffOV67LMUO7QAUxTi4=
X-Google-Smtp-Source: AGHT+IELGBSyn4V3YUSxBGtgNqVVtTLJrlf9PVG5+RizB7KX2mtoSIrTmH5IxGkcvleBYBDU5dVxI9I6kY5sBsZO1L4=
X-Received: by 2002:a17:907:6e92:b0:afd:d9e8:47b with SMTP id
 a640c23a62f3a-afe296e50d5mr1063421366b.64.1756176184988; Mon, 25 Aug 2025
 19:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805110754.3243432-1-chenhuacai@loongson.cn> <175615793761.2150029.12607347712708724677.b4-ty@kernel.org>
In-Reply-To: <175615793761.2150029.12607347712708724677.b4-ty@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 26 Aug 2025 10:42:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4eDRUBFyn8Wny1o7uFHHWKF__Vtu+m0bhmUP2rFHkZ+w@mail.gmail.com>
X-Gm-Features: Ac12FXwj1ylAMykS5rHMW9mw_TXtIO885LHS0_iY9W1N6CdaauP6rPhPTYU5hnI
Message-ID: <CAAhV-H4eDRUBFyn8Wny1o7uFHHWKF__Vtu+m0bhmUP2rFHkZ+w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Rename GCC_PLUGIN_STACKLEAK to KSTACK_ERASE
To: Kees Cook <kees@kernel.org>
Cc: loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:39=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, 05 Aug 2025 19:07:54 +0800, Huacai Chen wrote:
> > Commit 57fbad15c2eee772 ("stackleak: Rename STACKLEAK to KSTACK_ERASE")
> > misses the stackframe.h part for LoongArch, so fix it.
> >
> >
>
> Applied to for-linus/hardening, thanks!
>
> [1/1] LoongArch: Rename GCC_PLUGIN_STACKLEAK to KSTACK_ERASE
>       https://git.kernel.org/kees/c/351b51dc16a9
Unnecessary, it is already in 6.17-rc3 via loongarch tree, thanks.

Huacai

>
> Take care,
>
> --
> Kees Cook
>
>

