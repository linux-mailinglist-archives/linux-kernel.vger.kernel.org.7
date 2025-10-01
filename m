Return-Path: <linux-kernel+bounces-838512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18439BAF5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4E22A170E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08623D28C;
	Wed,  1 Oct 2025 07:08:33 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69903C148
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302513; cv=none; b=E/nA8JhMzjJXJqO+V49hI2KtvG3mdxc7ouTLIUeEBq6QSN/cJIVYJ6/Bu8ZeIkudWhnlyPHTtDX5uLnzDYjAz8uaoiVB1bTZgaC8DVCi+U9PqokJYKjDems1zSfJr3Z0u8YVvz2guT3lrzjONVw6kH8JftHt2qNWF/eVQ7yXX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302513; c=relaxed/simple;
	bh=7ANDfXM38Gq8udquxdGN69lHmB9wggZcgP0ai0VsdIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ6oENgIKayLxUbW2nTzUTADeUdXJAoPp6S71CyHvSaOBFeV4eenq/6t6ZUYcTLuXB1py4vcy02C8sTD7ZpAuh8TrieLLepianKL5f16D9WIAFFpnIQC23ZdNF1zVfPbPuSGONd547gdRimkPv8OpC3cvWk7SRWznQlyKHMO9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2931446e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302510; x=1759907310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1Xe/yIXoUfwDHnypUCkmL2agWH96d+WyVy9U6y5GP4=;
        b=voPVc8ywkLMpKHMgDLyluWEIE/Y3H3eJmgFSuZmHiA443ZRiOdDgtiNndNK3ABOW94
         jChwdbzl5LQcRWvawfTyx/tCEAEPys1G9CF6GRuah0RjYLSNrlUl2Heuya4QWrbHcwai
         AufSYsRa9ZnR5ynKS/xBnlNI8KXG36OKAOinEzdZX7X+Qrps5TpQFfPjtwJs2ZhgA5yq
         Tf1WYrtO2rFief7ZDHa6LyIHzkj6ydGu785EmP4fFA9cKO398JItkUJVSlXMSCVLma6v
         RNGwJGdgP0Zf9hOpXxvQSNM28LMT42fn4yWvJeosyr2/l/bILpOvUpIwQGqTHdTtIA2t
         DzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSYSstUq6PzZad80KjP+iw/nS9TDbWk5dARnDUeHElSPU7sDbKccT++u79qegTm5LhH6lparidPetOHBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AM6FGMnP3hllAJOdsghgrp/FhVk5f1SLTHKLTJh4wn+TJgke
	Bxv+tOZQLj6tZBGZTpqyZWVaPt1NjV4/orQy6BR8GbPteAIWsKnEIILin6r9eBUZ
X-Gm-Gg: ASbGncsmM6Dhmc8kONl1qu2Gan2GB30rJ/2Fk+TaKgKuAlzcxL/ZusiVCSAFdn1J4yF
	+QTjaMa+c9fKKqjgRaPfjBOHR32YHobAmDcviEXr02StSvH7y98PdtlPFLjkaJeppiKTCHBwxQU
	DfaeyAUBF0l5Zq0+UaYC2g5pRvC4yU6AKht715OWCGE2XGvtu7fUXNk7Ps1XzM5+HmHlgqjnDFk
	ZMDNkU/fn0RbnNxqQIgAgvYdIk05YdcZ4Pkjkdg4F7Tlm6xy7eW0eLo9DH4ZFa/M/sGYvolaqkp
	tsFcZI964s/Kl/ernSBHroOMZ2zqEgQFBHaBXDyE+/z36pdIzf3hhG9vdU0eyU7A0gocYU6WrbN
	2ZVqt0VpZhvCeDzLombaZAPiJAu5hyTVdDnHboHDLCL58++MxEjhO+D/jM7hPkQk98GwcKKkExp
	i6v/rIQLky
X-Google-Smtp-Source: AGHT+IFX/rkvIDSiQI+ygyzHnXGrcxTzuA19VxFXsMqvySN4ac/QZC+ggboGPpt1nGqxO5z7Ykn7Tg==
X-Received: by 2002:a05:6122:3107:b0:54c:da0:f708 with SMTP id 71dfb90a1353d-5522d38290bmr939797e0c.9.1759302510087;
        Wed, 01 Oct 2025 00:08:30 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54c45bff024sm2302775e0c.9.2025.10.01.00.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:08:29 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-890190da557so1355603241.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH7Cga0+G3nPxKS1om9OEkXI0N33nzqyd0fzEbGn2Hl3KFsj+Ff/eEGC7yCziVVK3kLM8GNR1uWJMpMSU=@vger.kernel.org
X-Received: by 2002:a05:6102:26c3:b0:558:72c1:2762 with SMTP id
 ada2fe7eead31-5d3fe5358bdmr972805137.11.1759302509044; Wed, 01 Oct 2025
 00:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org> <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com> <7c2c4da1-57f6-23b6-dbff-6288ef3f2a4f@linux-m68k.org>
In-Reply-To: <7c2c4da1-57f6-23b6-dbff-6288ef3f2a4f@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 09:08:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwYvJSoAWDTJJYOTt8mgtfa+sB_uevYR3NXFUK2fVS5A@mail.gmail.com>
X-Gm-Features: AS18NWD9LDo6xA5ckwXmlLEmk9kfyHz5Y83hVqr1eWllj9E1zqRP90XkriKsg1k
Message-ID: <CAMuHMdVwYvJSoAWDTJJYOTt8mgtfa+sB_uevYR3NXFUK2fVS5A@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Wed, 1 Oct 2025 at 03:46, Finn Thain <fthain@linux-m68k.org> wrote:
> On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit
> > > atomic operations, for my small m68k .config, it was also necesary to
> > > increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a
> >
> > Probably ARCH_SLAB_MINALIGN should be 4 on m68k.  Somehow I thought that
> > was already the case, but it is __alignof__(unsigned long long) = 2.
>
> I agree -- setting ARCH_SLAB_MINALIGN to 4 would be better style, and may
> avoid surprises in future. Right now that won't have any effect because
> that value gets increased to sizeof(void *) by calculate_alignment() and

Ah, so there it happens...

> gets increased to ARCH_KMALLOC_MINALIGN or ARCH_DMA_MINALIGN by
> __kmalloc_minalign().

Thanks for checking!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

