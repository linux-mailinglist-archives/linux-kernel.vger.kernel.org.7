Return-Path: <linux-kernel+bounces-757343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C5B1C107
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919C518A604E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E89217F27;
	Wed,  6 Aug 2025 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgUeAdVw"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0C217704
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464304; cv=none; b=JsYpbWkgxY1oI1mgsWSwYM3fwR2Aa3wuub4lhkMIzCbMGPp0Z4dxwVgktDIzf/KqB/cCbqC6R5Gbhbko6H55TRmcpnbfk5C0uS5uyApURkwhL+fpjgLk1rF/wliIdFX45tu4u1FzgMU2BGjKHIrVyq9nktHw3RrNghgG2Xh2WZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464304; c=relaxed/simple;
	bh=IzQybyhb++OiGTtfC425Ff0Z5Ry7KlBF/YXvukV60rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2Tr/eoJdGctwHIT6nNbCemuZxKJwf9yVG40+Lkh8TiZORNY8WKSTr31I8LrS7pKQF+3XteE5ZvRW0EWgv2WC4v1nduaWM0nK786OLDcf2Cil8vhB45KbUUOyBH6WWe39F1WZXXBk+yseKtIWYVXdlpwtk8ryfROEJhgC4KgTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgUeAdVw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3220c39cffso5074609a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754464302; x=1755069102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CIQROcvGNDvP322fenFV06FYLfCBAUlOFBfGGGTH+sk=;
        b=JgUeAdVw0zu0Ugab0FkGkD9kw4QWO63ZNc2BljaAZK+h/JagTkoFyQD/jZcVMUldMU
         4WvyCMS8rRHwNoY1YojU0aGzfOZqaYsdxwJNQhLTPPw62b38sc2pRlkzkSZCTC36SEU6
         Z0j0suwDiJElnpFuVdrJ637quBdNixrLRVtVezE8PNS0r9bEihLYxKi3/jTbnydpcfHp
         LA3cRIrw6sndAdSdyvGGXEm3FQASVhTQnxNuVjWWNkj2Xaw3wxesLLIMEqkKPxeRVmVF
         nWmWgDoOwjwo2VlX2ete9PCSFIl1k42GIGW9z4/XrRhV6B+Ns0pOKSWZsDoBF0hkxl5m
         +gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464302; x=1755069102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIQROcvGNDvP322fenFV06FYLfCBAUlOFBfGGGTH+sk=;
        b=IpMAR1dYsuBRuiz6jRFzqhm6IwAQeHFIUg/uDEQijMpiTkSwyDGYi9pYO6s0V4VlrM
         uvji+L8o83gu78ytqxOmETwHNJtrewPbYPn/jPAZA9gAUYP26ubKbXiTJiPFj6agxMjk
         BmqKB2Fn9s9wpSZy46cheSQPqB8IkvIz712HIo+rSQkB1kKMN/WO0AnLZu6C2XdyYu9p
         iyBXpGzFe0H51LZKz88MK86l6fwEGFJ6M+F97faSrxm9n2izBObP2b/vlJtzPPIgosu9
         kYan1ELAOY1tANC5yox4P2QK1CbOmzrWqaGmfwu6Q3z2/dC+uqi6Un48x871fBgo+935
         S14Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4l+M63N7LOjCMU2xmkC/u74gWUT8D7qNJemCrBTvOW+E5p8WKimS/SmgH3H5oqblZf5k72t4U7F6odAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mK/1LhaKT7ZTsc5G6xNuPHBPQ9Y0+HQorbllvIvUyLJysrA4
	4Elgv/Gw//sCGqREa7q7OL1fAx5tcJo74q11WpXxvuAGTgcJeBv9D6kZMXMlVNJKOLxnZZUPWB2
	mPYN1+Edh4qrJz6YV7hDnH89db2haNctznSRPFHBa
X-Gm-Gg: ASbGncsZKberPsyleA2G9OoPIqq+QNCFARAsgscujYfad1dOkAz9dRiis19pDEhb480
	9TXESt3ov6Vwz3HP23PVMuxSqU/T0RL4c74NZvZYIN1nc2qVDY4b54Wp7Ezi9m3CzlDZPUEbcVJ
	XzFn60VJa7Jp55kRumNZPXpwATF1y+KTw/kv6m/t5l8XKZlvECFW33PD9xX4T7Hh7jT5Auk1ZHE
	z0rkROBcNcnKOXUUbkx8x8kny3bTKTM9jbnbXI=
X-Google-Smtp-Source: AGHT+IH4eNRLMKya/4o32tlSQWOb3//29rbV7XojFN8jVRMxJhB+5q+ILE/Mwm5nN4R+52ElrJ7C6Z2zf+YQwxTewsE=
X-Received: by 2002:a17:903:3c6b:b0:240:3bb7:fdc3 with SMTP id
 d9443c01a7336-242a0b6eac4mr17702345ad.28.1754464301762; Wed, 06 Aug 2025
 00:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805062333.121553-1-bhe@redhat.com> <20250805062333.121553-3-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-3-bhe@redhat.com>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Aug 2025 09:11:05 +0200
X-Gm-Features: Ac12FXwvxDclvgbX00BaC4VbF0Z298SA2kuazPxeIBtYynYYBydJBukUdCOs9jk
Message-ID: <CANpmjNNr7e6DXQrZva8k46jELr1JSkjExWvQOyrkY5VD8mOadw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/kasan: move kasan= code to common place
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 08:24, 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> This allows generic and sw_tags to be set in kernel cmdline too.
>
> When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
> variable. And expose 'kasan_flag_enabled' to kasan common place
> too.
>
> This is prepared for later adding kernel parameter kasan=on|off for
> all kasan modes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h |  4 +++-
>  mm/kasan/common.c             | 27 +++++++++++++++++++++++++++
>  mm/kasan/hw_tags.c            | 35 ++---------------------------------
>  3 files changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 6f612d69ea0c..32f2d19f599f 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,10 +4,12 @@
>
>  #include <linux/static_key.h>
>
> -#ifdef CONFIG_KASAN_HW_TAGS
> +extern bool kasan_arg_disabled;
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +
>  static __always_inline bool kasan_enabled(void)
>  {
>         return static_branch_likely(&kasan_flag_enabled);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ed4873e18c75..fe6937654203 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -32,6 +32,33 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +/*
> + * Whether KASAN is enabled at all.
> + * The value remains false until KASAN is initialized.
> + */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +EXPORT_SYMBOL(kasan_flag_enabled);
> +
> +bool kasan_arg_disabled;

You lost __ro_after_init

> +/* kasan=off/on */
> +static int __init early_kasan_flag(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_disabled = true;
> +       else if (!strcmp(arg, "on"))
> +               kasan_arg_disabled = false;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan", early_kasan_flag);
> +
> +
> +

Why extra blank lines?

