Return-Path: <linux-kernel+bounces-840462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5DBB47C0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFCA3A516B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733925334B;
	Thu,  2 Oct 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCLc2WA7"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68A2580ED
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421867; cv=none; b=GIZGLaza8dsqBpbSSBqOKTB/n9WbM97i6/ZB9L8XwNIQpH85Dc2+0QH3y5XovUBBx/LsFidKGb5oN1dInr4b+ej5vb7gF/53Z2e2Uq4UB0k31ylnIS0ktU3hoKYdUFikPDFZOxc7GO6BuyaskEfS7xeFw7PiF+hm7tOOGv01eQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421867; c=relaxed/simple;
	bh=1YHnshCqLi+ucWc5M7tP4V4y4kXaMFfeCtQBd/Oa7l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW8MzztJMhe6Nr9sZpiqccPHBi25ivHxB5cOWU3mJEmXjvKhVWFrmS9OyAH7w+N1UJ5CrBIPijpRvJs1kEaXTs4LyA6k2qjlfsbl6VlMevQRwiQTbv/An4ZQBSDcR7KN5PuzHDvB2wyLcEpP51tysa7bCsJ6ASKQwQG3Hq0uzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCLc2WA7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33292adb180so1288982a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421865; x=1760026665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tns1AdvpF6HQZmPvVXIDEXEzdssOYUsqEK8yeD9oV6I=;
        b=jCLc2WA7MgTu4DUwCdWJxV+EknF/ZClgkDG4ywA1pL3E3F0jexbSkw2p6KhpVJd2Q4
         gSxj+hq4lzZ4uptY05bcE1z4SIx1zq6M+RsiJAuMZjcIHhPHCRwRzp512TmQS/cRvjt2
         MoEjj9p9VTdNXTKe6eFk9AyjB79zFFN0x9mOjACgWdpvN1IciJJy9WJLJm8AKE58wRcj
         ae6tZA6BExKiWe/NTlThix2+AiC59GWCa9G3gwvTOGLV4/3LAwEsjYrPGfTnr61zXP5K
         xhxEoqL2qjroLS+ixtgpeOjYrBufAvWOwt+Wj8f/vy0FHF4msVyfJn3Elrav34C+LOfw
         Hp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421865; x=1760026665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tns1AdvpF6HQZmPvVXIDEXEzdssOYUsqEK8yeD9oV6I=;
        b=e269tZxh4Kkm7cn5KhJMYq5DfslurovIW/qxe62AUMiZhe3TOfVTYHOF9AXXQgpL54
         Yavwj/fqFxCnT1WvLaYoNuO9U6eE99lX8wRAlgTK1dRycN+I2dejWUt416vK9QHEWTpt
         cFOEHSJmMbLd5ARGcz5kEHjeZDCeBYQF0xxpggKIu6gwuJikVHguD01FlRXmNuQh++pU
         3yrTPTNIEdYsIj0FE8w3cApBRj8NvNCHNaH9TkQg6vBezbXD65Elq65eVGUcJNv1eoko
         /1HNmE72ATKIZozgcsMuhjstU/MjZzjIWKBkkaxoHXmgFQZBf8R7EbhErY7kik0UqR1r
         hF5A==
X-Forwarded-Encrypted: i=1; AJvYcCVeSsTqRz2V2K4MYdeFqrU2AfnTr57wigLYspNFlJI5rktw2XHa/qwavP6P6D5AjcbUnqJf7gb2EZc0oUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGjWlb2Tc0q2wqRsJATuFJqRg5D5DbG5k1u87dPNaYGdkFi6c
	/G7Dx97yCymSaOKYHuQz+NvyE3AzcLhEjkTjgr34ZzAcmsNBvpiqe1qm3j2tPfwGvbryrWbCn8v
	Ef6kfl9UeO9XPpIFzI52NeG8WqdJNBwI=
X-Gm-Gg: ASbGnctMsZBTfCOe0v4JL6vrzOCQxGsXpCOFAF0ftdBuunOo/ZvRo4cp6vAKyTdxNLI
	AJQbWVOuFwUE7wGKO5qaTIoreM8LimDu1LZOqb91KA4y5LsSL2SI8bDJNvQ+hhjnSerRvCWHb5k
	dkXg3JoLthmjb/iLeR48SwKNCMEbLnh0OT6yDJ4YVsMKP9sOCektIY+YXy0TVZ+i3wFBEPpwVgx
	TkR3c5yuDlO5VlTJftmBmP6B/KmbJs=
X-Google-Smtp-Source: AGHT+IG05j1d6QNHzwDrb/UQJ4gcdVPoLdwBOKbzmCKpejfaOjCLo+ZcRilsDiKUj5p2759Bf2DxGd/yIw9mbP1uPh4=
X-Received: by 2002:a17:90b:3b41:b0:32b:94a2:b0d5 with SMTP id
 98e67ed59e1d1-339a6f93baemr10463340a91.37.1759421865385; Thu, 02 Oct 2025
 09:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822190140.2154646-1-briannorris@chromium.org> <20250822190140.2154646-2-briannorris@chromium.org>
In-Reply-To: <20250822190140.2154646-2-briannorris@chromium.org>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:22:42 -0400
X-Gm-Features: AS18NWCuq-n56JL0W7Gw4m7AvH4B1Hxysibf-Cfy8GzGwnCU1M2OHsorAHULTwM
Message-ID: <CALC8CXeb6smyYpMN2owPfcDBdk344W0pV7MJSYUTAhew9eFE8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] genirq/test: Select IRQ_DOMAIN
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chuck Norris' brotha. Chuck Norris looking mutha fuka

On Fri, Aug 22, 2025 at 3:28=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> These tests use irq_domain_alloc_descs() and so require
> CONFIG_IRQ_DOMAIN.
>
> Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/ded44edf-eeb7-420c-b8a8-d6543b955e6e=
@roeck-us.net/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>
> (no changes since v1)
>
>  kernel/irq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 1da5e9d9da71..08088b8e95ae 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -148,6 +148,7 @@ config IRQ_KUNIT_TEST
>         bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
>         depends on KUNIT=3Dy
>         default KUNIT_ALL_TESTS
> +       select IRQ_DOMAIN
>         imply SMP
>         help
>           This option enables KUnit tests for the IRQ subsystem API. Thes=
e are
> --
> 2.51.0.rc2.233.g662b1ed5c5-goog
>
>

