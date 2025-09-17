Return-Path: <linux-kernel+bounces-820274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79BAB7D83E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389532A0B24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736C30C60F;
	Wed, 17 Sep 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMFHz4rL"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11475285CA9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098864; cv=none; b=rKD0oOubtM1D8qMb+PJIdXmumXa4u+un5D1EYn9xVj9DpW6C+5Ll1kUWhkulczJXPkbke14Hk3IzsY+1llXG1tHDHvK9+E1Pfmb4NqVaVW2a8Jh3meyG+L5qbSNzmR03huqYnPraQVT5RAJvoV4/WpymxWjmfIsz6WoBJzDZNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098864; c=relaxed/simple;
	bh=mD1dKSaDbFABDNdxhBOrHC0pI1BKnXyc1MHH71Bb614=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZS3kk/thMNGMGY5pZgmMYtRZ2ZiDpiny/SQE5YuDO1qB4iAvVKw8kTHyP6Mroxe7Ezu6ESBURfF1s82upFhW+2S17YG9ftU79ECzDWl5D2DmvgFGg9H5AzDe/Wgf8ojYBoW0IUef5GU8vwICnEFtfz5vfEU46srOb5MNNX203o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMFHz4rL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7814871b581so27014156d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758098862; x=1758703662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSQBwTY7x8IQoxtsTDFfPaHwMvtropOKYFv/BGH9LuE=;
        b=nMFHz4rLjW9HxACLfiGmFUDToCY8xwg3npc15bK5XMjrlNTdzc/sYKlZNyYjkiJfGV
         04709FfI9hX4IQyLJ7g988v3DW+ZR9dju8jlw3jQkKIhABgqSomLxrvzNVlNclndI92e
         c58nFVIiq2itPPGMNki0u2UyFSgm03ZV5JC7j7UrBDtHRldm691Li1IU1NevcMlG+Q0r
         T9ioL2PauUpuY3pdIHhEoGaT3I3lNRfrShFnPUBnQ9xnlme1deOG7y2l5Km5miG10rZT
         Sw7KaDM/c7b4xNktgKwB+rMrN8eNbu28K+KoBe0GdhmPot3yrgFcifmKnCOIdEv/dyts
         l9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098862; x=1758703662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSQBwTY7x8IQoxtsTDFfPaHwMvtropOKYFv/BGH9LuE=;
        b=gXQPs32z8gDtTIt04TF0k1H6YKrN4E4+CLZSU9DwtwU18lIatS5mRgOdOm8bHAFapQ
         nAGWUFl8qbutbJFroFhW3MKcvqNJLqP56EEwqK6BLhUqAe2sOZcYIA7Cpw9Bo0NoZBE/
         XVt1xT0Pt0E3PnDj2GZ1icqlWQmu4JQVRtxM8omAbIldq4a7mPPyU2OMLwHjAhD2oQ8u
         m+HqHYWl/JZYJge7QOuB5872EfWn3jLDWbOjCqvC1uKgs7QftPV3JPAkAfqxpflVitJR
         mdDVzkILaKZMD/K2ZnonBJEN0F8JBNKm2PxeqTwIpl3Vso20QKa2uyD+RAqiqmb7nZIk
         w+xg==
X-Forwarded-Encrypted: i=1; AJvYcCXbB3h+6o07MnJTXfOBbAB1zQPlHTevpRCdtts12owWOCulsUk3vk2vjYjpoHvg/50rjXt3wQzVFTOHTPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8U+8k2b9M26F5E/h+/05rCsrDnLOB/S/r/muCRXxghYCcCnl9
	OyuE4HVpFjeYG1curQAKXB4izPF7kBe2GHc9fFcilSvlDvdSpJtta4SyOd9EtNnrKT5SZ4vVM9G
	2q9F/V8+fJEwBaskcI1VlVL8gc17GQnMuqHopyIdh
X-Gm-Gg: ASbGncsc1de+il+kdrmltTdnI6Dyu4FxBKhN6daoA8u1oIjLoXKvS4PyL1cTeYRPlL1
	LMNq5+lIPJ4yhbUbyWrcky8uBTgZBE1ZZJWaEX5xhZ5h1iN3IC55OwG/s51g2odS515M709aduj
	2ZgvVzaCtbmLTWiIIxu6WjuxRJI/w2FXOspHJbvCzfitf4ZAKdXZblZrnUW+cdtVUbh3kutEAHx
	Bex0900KeHVuMDpzoWh75WFZ+ZfvzFZo1Kh6lDbYdA=
X-Google-Smtp-Source: AGHT+IHQqM5a49OQaZzq5NlAj4f7mo4PVwkO0Od/qpE6zKcTcL2cYsdQMpOPx7K+APxdGyrFaBcGHMy5truFRbrqA1M=
X-Received: by 2002:ad4:4eab:0:b0:76f:6972:bb91 with SMTP id
 6a1803df08f44-78ecc6316d3mr11179046d6.10.1758098861793; Wed, 17 Sep 2025
 01:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911195858.394235-1-ebiggers@kernel.org>
In-Reply-To: <20250911195858.394235-1-ebiggers@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 17 Sep 2025 10:47:05 +0200
X-Gm-Features: AS18NWCHIE1dESGpN9uvlB5H-Nyc3e2nakhbUlwz_P_LJD2Kd7WI7My-Di8UNK8
Message-ID: <CAG_fn=UY1HxmxpkM_YFGbr8W272F_bZgZHKiuvbsUjgFCs1RcA@mail.gmail.com>
Subject: Re: [PATCH v2] kmsan: Fix out-of-bounds access to shadow memory
To: Eric Biggers <ebiggers@kernel.org>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:01=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> Running sha224_kunit on a KMSAN-enabled kernel results in a crash in
> kmsan_internal_set_shadow_origin():
>
>     BUG: unable to handle page fault for address: ffffbc3840291000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 1810067 P4D 1810067 PUD 192d067 PMD 3c17067 PTE 0
>     Oops: 0000 [#1] SMP NOPTI
>     CPU: 0 UID: 0 PID: 81 Comm: kunit_try_catch Tainted: G               =
  N  6.17.0-rc3 #10 PREEMPT(voluntary)
>     Tainted: [N]=3DTEST
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.=
0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>     RIP: 0010:kmsan_internal_set_shadow_origin+0x91/0x100
>     [...]
>     Call Trace:
>     <TASK>
>     __msan_memset+0xee/0x1a0
>     sha224_final+0x9e/0x350
>     test_hash_buffer_overruns+0x46f/0x5f0
>     ? kmsan_get_shadow_origin_ptr+0x46/0xa0
>     ? __pfx_test_hash_buffer_overruns+0x10/0x10
>     kunit_try_run_case+0x198/0xa00
>
> This occurs when memset() is called on a buffer that is not 4-byte
> aligned and extends to the end of a guard page, i.e. the next page is
> unmapped.
>
> The bug is that the loop at the end of
> kmsan_internal_set_shadow_origin() accesses the wrong shadow memory
> bytes when the address is not 4-byte aligned.  Since each 4 bytes are
> associated with an origin, it rounds the address and size so that it can
> access all the origins that contain the buffer.  However, when it checks
> the corresponding shadow bytes for a particular origin, it incorrectly
> uses the original unrounded shadow address.  This results in reads from
> shadow memory beyond the end of the buffer's shadow memory, which
> crashes when that memory is not mapped.
>
> To fix this, correctly align the shadow address before accessing the 4
> shadow bytes corresponding to each origin.
>
> Fixes: 2ef3cec44c60 ("kmsan: do not wipe out origin when doing partial un=
poisoning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

Thanks a lot!

