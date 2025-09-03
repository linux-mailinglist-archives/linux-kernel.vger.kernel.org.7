Return-Path: <linux-kernel+bounces-798681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E757B42145
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC517C1647
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98D53043B4;
	Wed,  3 Sep 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRP85kCV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758782FFDE6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905749; cv=none; b=DbAt6EnG9AUu1mJNUZh0jug36HMqJ/NvHhTl88CVEbxchxuiRhokFY+vh89l1b6MwELiNdiNlAD9xaV4sndL05xnVsk9Cb4g/UfZPEGij9AIJgz5iiBQrt/trajdTsVFERgA2iw+leldnNpNIyCMnz9pWop1ZpZPy5/wbFwIFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905749; c=relaxed/simple;
	bh=+3/FvEb2tmp04THrfe7Q6R4Z9tV9DSLFC8M+VKKCGW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puIukc4MjPx9ccO/drEU+H7nhT5o66pY6WQpuGs53jdti9GzsFmqc+mpB4jC4mKSQeTlLNw/eY1DIgxM2yp8M2fqKtZlIuPoTAp1q2dYSHI0OoQQjXrjl+mVJqRrENlMmaDDYoXv6yKlH9j8G5kBGENkce5CZwHdQ436Esfc5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRP85kCV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso41727605e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756905746; x=1757510546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3/FvEb2tmp04THrfe7Q6R4Z9tV9DSLFC8M+VKKCGW8=;
        b=dRP85kCV8Jzgp4u56cxurk/9qIs7dxp6kIjAsEeuE8o4HDJbEdo1U30O7KqWdgMYhV
         KxNAcdSQiV8Joomp1lS6I4AB9JvfwnvfY25XDAQlIC70zUwxWQ2JxWkdDdoVkckFcia6
         RGNnbP3n6luxOyDuhDM/UFfsJ9A6Dnn4CK4SlPQByU106uqHGKDTwMb/Z9Old1cUHbO3
         7LVGILDk0vN0F2hNbqXshbRBaGqatHm+PzaQUQzuPi8XHBedROtdz9ovjkeczYfIECWW
         7IcNlk5gmhmSukJU0c/k+Sku2xnN16wmtG7y7/FOHM9CmhZGAilqGGwa7GZS6cpy6SoJ
         rcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905746; x=1757510546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3/FvEb2tmp04THrfe7Q6R4Z9tV9DSLFC8M+VKKCGW8=;
        b=Jn4IQSbYD1i2jEdi0zCNTs81BI/XD4695v6YsDbkrDh2htHavNDMNdt9EUxxvwWX/c
         bPJqUGG+4DVaF5S1/awwjtDUIjYxicWXwY/+rsJzMLO5gWaWrznOlovQwAhFBFq3N8lc
         95MFwyN6dLLv5ejOT2TEP6L4bhEqCbc+EeMUpisyDOe2ANu/GgwRtfXWxz0+fDQNypbX
         7dpNsvkZPaExR1vhQnYKUDRuDkjU+ZWYBFh3XnPvhtmvsr/4k2VRSHwyRmXj56g7R+zh
         DXxp64vgm8kd3keYVAqqrLQZFOwKo3c6fBJ1FjXHk4xFZCOfomOdkjnLijzye3w8ad1g
         nXzg==
X-Forwarded-Encrypted: i=1; AJvYcCUBZ+kI9W5oCdTikVbEm1zBZydSXWJLcA9p2sqoAJgJUWO57tX9oo6GOiKsoBoaFMzLevDCcqi9jSe54ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7DNb4VRpBck8PxTXkF3xMwAFnIjKFQCcfqf+j03rsh+tePkB
	q7ESO3y4rEe0TsXZikl8KKzHav8v/mAUvb/qkRaTM+/c0IJJVDf66/Cwlp5IwtCRuTC83xMjqSM
	ix5bmvCnh23EcFo4feUUk8dN5lCM1uJKWvXxtoTk=
X-Gm-Gg: ASbGncuRkEIbdz23bF25g57PX8eGgH4N6V5O0Xhzw984O0qilCUCmSD1BiKXLY5oM1Z
	JSTW9pa+wxSI5cFPEKeCRw1eT1UXqSJxTOi7khAWiIXzUOU4psgyPy8GkLLFJR9mr3j1SgxFKG3
	k+mbBh8rMPEYOIuDVLocCO1r9o7hPLC0IxkoFMhn1byiBXUvOlMkXih31515q4mQfgf6fVupzoJ
	oK9kRpT
X-Google-Smtp-Source: AGHT+IHTlltZP/PiYSefk4BiHHXMLghkkMyukGhjP2TxeCsHmSWWTRuInnnO1putZr6sen4D8zESFOr8o1LvNPk4oE8=
X-Received: by 2002:a05:600c:c8f:b0:45b:7ce0:fb98 with SMTP id
 5b1f17b1804b1-45b85528677mr134028325e9.5.1756905745452; Wed, 03 Sep 2025
 06:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Sep 2025 15:22:14 +0200
X-Gm-Features: Ac12FXx6JqZw2o7u1Ppz_iF81kfxsSp5T4xMMmvHYDtA-FZpsjtY5aXsfqZMrYM
Message-ID: <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>, glider@google.com, dvyukov@google.com, elver@google.com
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
>
> So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost fo=
r
> kasan.

Continuing the discussion on the previous version: so the unwanted
extra memory usage is caused by the shadow memory for vmalloc
allocations (as they get freed lazily)? This needs to be explained in
the commit message.

If so, would it help if we make the kasan.vmalloc command-line
parameter work with the non-HW_TAGS modes (and make it do the same
thing as disabling CONFIG_KASAN_VMALLOC)?

What I don't like about introducing kasan=3Doff for non-HW_TAGS modes is
that this parameter does not actually disable KASAN. It just
suppresses KASAN code for mapping proper shadow memory. But the
compiler-added instrumentation is still executing (and I suspect this
might break the inline instrumentation mode).

Perhaps, we could instead add a new kasan.shadow=3Don/off parameter to
make it more explicit that KASAN is not off, it's just that it stops
mapping shadow memory.

Dmitry, Alexander, Marco, do you have any opinion on kasan=3Doff for
non-HW_TAGS modes?

On a side note, this series will need to be rebased onto Sabyrzhan's
patches [1] - those are close to being ready. But perhaps let's wait
for v7 first.

[1] https://lore.kernel.org/all/20250810125746.1105476-1-snovitoll@gmail.co=
m/

