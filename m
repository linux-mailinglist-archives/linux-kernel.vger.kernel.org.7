Return-Path: <linux-kernel+bounces-779096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD7B2EF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA61A238BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F61261388;
	Thu, 21 Aug 2025 07:05:20 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABF24336D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759919; cv=none; b=YKKpLKGsooqv/r9JKG/i6kGD+aE2i3g9Pmt6fdN8n8Qt73ZomgKAO2Sw3s8DqcSXNVYu4qm58ATwXQIsxQOi42xFoeccYSC2tUesFLqUkRZdjTjra5etvFDCC5JOEIKQOKsH44zrV42KxEEOlMaN0AZwfTNfdxY1v5vhg1U0M3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759919; c=relaxed/simple;
	bh=tXfwFqtDaxV69nWGrX7XiWplVf3jqK8wUUbcjRt0Be8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9Bz1Ipaot1Tb5MxlxvmtqZ5EX9iOwrluIaGTf/vZ7q8T4x7NAat3Tnzp3gFr5wpXDgFvtmLH3uZSeJSq/9RV1WsXeLURfJeMxB+TlbpGoFVyv6ONh7a47WnaXiIeKlHF3Z+7Mzzzsk6i0OOSkczr9XCIRW4bATPY6dcLg6dYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89018fcdcd4so408210241.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759915; x=1756364715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3NApPXZlqcdx05JQB+DovalTLQu8iPqd0lv2ekKU+w=;
        b=CCKG7B3xQE2lfkDM4nYKPbsQiYB4GGlbDtJpV7uTKDrdlsiCxiGb86O6pAd7a43m80
         6lQSOMrGUsMdOYFYAfs0OAeeqcMo1N5eiX3UbCpCaR6nVxByL1vPDJx4//r8/zekYMPJ
         9rmX7j3DrsNYrSBP+xf3EhXADjyeja9nOoO7h8p3lmeOw9y8KCezX+8vtNomhBqv29ic
         9rM/dxdMpLQRny7oFwFfkVlSlYIk0N3RUzmyqONsZVc9I12wrvf/PEeelQpYZ5ccIGRD
         QFohqAmTJsCNxnrEucoFWMIczG3o8SX90kffiRmOLg5gBNJQOs1TVo3JCCI8P/VcCmRo
         pUcg==
X-Forwarded-Encrypted: i=1; AJvYcCVN1pIkNdmPH0LO38ibbIbCfJ7+4vB2bcH+Gy+KOJFABPohbBr4XDy+Sng+UkWHSf9Vb3TS4yJ1Gt0qf7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznytEjuNTbd8WCTtLHUcX0pYGY2J8vw8iTpIAIMnAcoJje9LPv
	vEUAys/NzuOjddEyGuFuAUuOU3XJtoxiAlSCm1qVyPxe4zs7IoOZQ4b1jTpFddUr
X-Gm-Gg: ASbGncs3JL1TAyl8cWMf0+zyHv68O2754Lr2K76TAoorMbIhJbluBhXsP+41GWbg3t4
	SCWXOqes+L7Q91XBCifbZFltkFM0Yx5NKS7LuUa/xQAZvEBLPHluaNSsliKW3Opt8XtYo6Tz1tV
	YpxQJn8sQ5av6m13rNP6OLyZwEIwQAwa16M0sdu8OgreBJf1ZmIY3MDbxKL3AQzUlE1BkpKIAZS
	wU2wdON5I1pGx/Ue5a8Vsmn1PO0HAf+gpsvt05MEPDoJ+NxfgOAoNx9K3x3nXZbS36vaZlp9VFm
	wP5nH1v07+m2xOHmz6rJAS1XCVVs1NWjTHf928N1H2WilLBkuqIKmW+0q90MjaQHGZgGKA41PgA
	Zy+7bPbJNAo+Cqwwn7yAgtOzy4ZCjjqZIxDjYp6lObD53ZgYTyueG96CrXPDS
X-Google-Smtp-Source: AGHT+IFM4e6z/z7MEtqrWQTmh2o9/Y45RwpL43E9FsJ9T7arP7HhoZ3TPZxmkcZYs86lBCBKVT/5iw==
X-Received: by 2002:a05:6102:c50:b0:519:534a:6c4a with SMTP id ada2fe7eead31-51be0d58294mr400953137.28.1755759915059;
        Thu, 21 Aug 2025 00:05:15 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-892226677efsm18032241.18.2025.08.21.00.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:05:14 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-890191551b5so370820241.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:05:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0elUbCYG53kiQw9joOZqk+JDJF/D/KE5We+aU7s4fDO+hqr/cylHG/ceimYv92soLZ1+N/x3mK5euzYA=@vger.kernel.org
X-Received: by 2002:a05:6102:5125:b0:4fc:1987:fc5e with SMTP id
 ada2fe7eead31-51bdf74bef8mr403806137.15.1755759914262; Thu, 21 Aug 2025
 00:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818192800.621408-1-briannorris@chromium.org>
 <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com>
 <aKYEVTRhzbXvwlbD@google.com> <CABVgOSkfADJGnMekV9Zz4x_Ana2uZYMnca1SDXoJnWjvPRGv8Q@mail.gmail.com>
In-Reply-To: <CABVgOSkfADJGnMekV9Zz4x_Ana2uZYMnca1SDXoJnWjvPRGv8Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Aug 2025 09:05:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVichNH4VKGEfDJWB5MTBZMFdh4HXtusb2N_-97RARrbA@mail.gmail.com>
X-Gm-Features: Ac12FXwGbCUm4Z7MJxAYegE4JzaTUsEn7hS12e1dnvNs0FAfIe0WqdiayilOnlY
Message-ID: <CAMuHMdVichNH4VKGEfDJWB5MTBZMFdh4HXtusb2N_-97RARrbA@mail.gmail.com>
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
To: David Gow <davidgow@google.com>
Cc: Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Thu, 21 Aug 2025 at 05:45, David Gow <davidgow@google.com> wrote:
> On Thu, 21 Aug 2025 at 01:22, Brian Norris <briannorris@chromium.org> wrote:
> > On Wed, Aug 20, 2025 at 03:00:34PM +0800, David Gow wrote:
> > > Looks like __irq_alloc_descs() is returning -ENOMEM (as
> > > irq_find_free_area() is returning 200 w/ nr_irqs == 200, and
> > > CONFIG_SPARSE_IRQ=n).
> >
> > Thanks for the insight. I bothered compiling my own qemu just so I can
> > run m68k this time, and I can reproduce.
> >
> > I wonder if I should make everything (CONFIG_IRQ_KUNIT_TEST) depend on
> > CONFIG_SPARSE_IRQ, since it seems like arches like m68k can't enable
> > SPARSE_IRQ, and they can't allocate new (fake) IRQs without it. That'd
> > be a tweak to patch 4.
> >
> > Or maybe just 'depends on !M68K', since architectures with higher
> > NR_IRQS headroom may still work even without SPARSE_IRQ.
>
> I'm not an m68k expert (so I've CCed Geert), but I think different
> m68k configs do have different NR_IRQS, so it's possible there are
> working m68k setups, too. (It also seems slightly suspicious to me
> that exactly 200 IRQs are allocated here, though, so a lack of extra
> headroom may be deliberate and/or triggered by something trying to
> allocate all IRQs.)
>
> Personally, I don't have any m68k machines lying around, so disabling
> the test so my qemu scripts don't report errors is fine by me. Ideally
> the dependency would be as narrow as possible, but that may well be
> !M68K.

M68k indeed has different values of NR_IRQS, based on the system(s)
support is enabled for.  These values are based on the IRQ hierarchy
of the system(s), which is rather fixed.  Hence this does not take
into account any additional irqchips that are being registered by
e.g. tests...

"git grep -w NR_IRQS -- arch/*/include/" shows m68k is not the only
architecture having that limitation...

> The other option would be to try to skip the test if there aren't free
> IRQs, but maybe that'd hide real issues?
>
> Regardless, I'll defer to the IRQ and m68k experts here: as long as
> I'm not seeing errors, I'm happy. :-)

kernel/irq/irqdesc.c:

    static bool irq_expand_nr_irqs(unsigned int nr)
    {
            if (nr > MAX_SPARSE_IRQS)
                    return false;
            nr_irqs = nr;
            return true;
    }

kernel/irq/internals.h:

    #ifdef CONFIG_SPARSE_IRQ
    # define MAX_SPARSE_IRQS        INT_MAX
    #else
    # define MAX_SPARSE_IRQS        NR_IRQS
    #endif

So probably the test should depend on SPARSE_IRQ?  Increasing NR_IRQS
everywhere when IRQ_KUNIT_TEST is enabled sounds rather invasive to me.

BTW, given the test calls irq_domain_alloc_descs(), I think it should
also depend on IRQ_DOMAIN.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

