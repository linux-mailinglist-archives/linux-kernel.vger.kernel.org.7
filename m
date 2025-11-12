Return-Path: <linux-kernel+bounces-897755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A26C5397A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EAA3BE971
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924403446AD;
	Wed, 12 Nov 2025 16:34:16 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7325342521
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965256; cv=none; b=JQ4puqeeCUnAFN1JQ7BjFEcAefR7ZPApoSsg/6zjh6amVHpQ+OWed86pDqwC8I9SzvK+M1AwRxZosWf/beUR2D1QUj+RNCH9v8vKShztJOCKts7Ma20cOI9RjRVNNUkLXcUKpnU3/6dGzcOXN0NPWtgn5uT6nrvlE3coPVrw/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965256; c=relaxed/simple;
	bh=Fk0J+zK46wIQApbBjlvq2ChgVdufMM6T9AYTaAjGlc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr27Q/QlxFoEmm8W3a36NlzxEMyP9jHK/Y8HuCslv/dXEqgNAGCkjQi/WDPpZknWu6EIkd2gRz1qk6ViPfHrxkI9TRmowWBP6m2xm3yNmgB9wqW3jwlxP36Tl8i1KeqRsuOlxAtSPaUWM3YuaNFQkR9y1/C9AycFrvtXqU3vgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55ae07cf627so159361e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965253; x=1763570053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDEEJFh8t7UvWDMq1bo6nlPggBAlwU9GoyBV8Ur7xmw=;
        b=ErYUn7HkWNj8rcYyd0iF/1hknrIHKTMzVqEWvUojKehcVeMosoUjzBX0zJ/waqrAEQ
         yzrrkP4IeMskszQVk505zQYJG4IPW8GxhmwnIDz37BgpvUwNPMe9PJUU9pH1PhL9v1Ei
         s1fK7aA3S6e12/mB/ipsov3P9t1yDISGVPzyVIYJTs7ISlNmvZixcgFnd0eUn957kl3J
         lvpQp5DoXjIVFGIrUd4ByUE8RmuU0hs9kQqnm3e63++FO76gp7/p67OoVyED+8tEX6BO
         O7R+dMuvhHwztla6GTnHZvDJNM4qQPy8T7tyb1JxLOsGvbbQS+11LE8ZfZhprwptZs7w
         BvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE15bURK42ijJQGGZirzOxCmuwH484k7UO+cvjsUkg9B/T8B8AtNjE9T7blwWzE5Pp45dN7NFOSkYhHUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCzOteFyAZMQlvpjLQDdPMRAXhXwLZe/BNPNWB8Pxt+DWFE/D
	L1YnLfABMDpavYlBZ4WzjwvEg0KmKuEHzoCLfEwFzBArln3XuMNsoqG9wxbLrIzf
X-Gm-Gg: ASbGncutxb4fRe+kONClerc4QvJ6CMaKP4/390i8PxlS7i3Mh0L0VBZDcubRW22ZOGd
	Eyt5D/EsQGmYWj1FwROb9wUA/Kkyoa3K9eSlyJxgcaTUF4W3Rb6CcTxGlmG7D/XVunpg0HIyov/
	Nnt5j9j/tmpK9QCRJnZ7/yAa1OpeaUDDdyIYgXyWzhkoLn0GVPKz6OMUiwIUv+NdrpUCd2nFAKE
	K5u5JrtuGNs55uwJnwq5ePybzY2kcZXv42oKO2oyRo4cPNetfdAxOyR/JO+KEzoEsIKhvGC6+eM
	VU8fG2KPjgk6JgvEioBnwvyk8Q31smh768ssfhOnVQvEzjoP8yFuTLwRpB7F6wT0ir3kRJN3Y2C
	zCTeUED8HCGSH87PtF0nfxjcvMG1eDSlrE+JvYLYCr8iIzqYPoxSeGnXYSjSPCbaQMW2nnXA6gW
	6phfFFIsMJGfzpmA6/Ccuda1VvpwAYfbJlTuAlLA==
X-Google-Smtp-Source: AGHT+IHcZCEQKxkMKFc5Y4phvOxpPtTYaF1NSSksHiZUj6aKCH/nTOMeKhkCXFPgdbi6R0c9QgI7UQ==
X-Received: by 2002:a05:6122:3c91:b0:54a:9927:7ab7 with SMTP id 71dfb90a1353d-559e7c4949cmr1529344e0c.4.1762965253043;
        Wed, 12 Nov 2025 08:34:13 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958286c8sm9991351e0c.17.2025.11.12.08.34.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:34:12 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so333888241.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:34:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUK8LOiZqd4n4NhFh2ekyTeo9HiGdW5KAYd3b2Y+px/S8M9A9evhN2Ka5ammXrDg7NOX+K4UazOO2/6eCE=@vger.kernel.org
X-Received: by 2002:a05:6102:508b:b0:4e6:a338:a421 with SMTP id
 ada2fe7eead31-5de07d0b089mr1033465137.6.1762965251527; Wed, 12 Nov 2025
 08:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-9-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-9-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:33:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVNXqVXsDuMeExFn7AozDKu9GD99XMk7ux=Zuw4qvL_gA@mail.gmail.com>
X-Gm-Features: AWmQ_bkkzAqLKDG_QzADFeNR5gEvcuVzXh2HazsgAbVtmvpBS87jteFgQs7jYog
Message-ID: <CAMuHMdVNXqVXsDuMeExFn7AozDKu9GD99XMk7ux=Zuw4qvL_gA@mail.gmail.com>
Subject: Re: [PATCH 08/10] of/fdt: Use dt_root_addr_size_bytes() instead of
 open-coding it
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, 
	Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Changyuan Lyu <changyuanl@google.com>, 
	Alexander Graf <graf@amazon.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:38, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> Use dt_root_addr_size_bytes() instead of open-coding it in
> early_init_dt_check_kho() to improve code maintainability.
>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But please combine with the other patch with the same subject.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

