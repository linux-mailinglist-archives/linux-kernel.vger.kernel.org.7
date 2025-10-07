Return-Path: <linux-kernel+bounces-844098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A729BC0FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F0C3C5B09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766B2D877C;
	Tue,  7 Oct 2025 10:22:41 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345562D6E6E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832561; cv=none; b=sKt18H13hpT2mJbcRQaOE/YeJsq/2b0N4+bzhCtOghxJJqzEWSeRZRAl1sgZrLzUfI2rtYU8dMHgn8umQX4+JhNlAYRWoIBJ9MDg9n8c+kEwFtjm0C/Dcc9suGCQAak24O92SyXKpcaPEDK907hISFq84O96RV0gIkmY2h/QvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832561; c=relaxed/simple;
	bh=X08yRMXxYQpEQFN6+DWg0rBxqMjXg4JwaZTEUg+jC/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9+Jhy/Ybp8k2BBpVTBShYQeIMePdRX5qsgF0jQ/D9I6DW7flEriwjp5xxEj+tTFiq6Edjypco2SFE6vBXJ0QX6V5Tpbge/RKwfq/SL/tEttvK/o6VGxlWCp/2q/at+l5kO5qvcIUjV/VhBQZn+3qV2v3poa8I1iPqGU9PQ5bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5523142df73so4356158e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832557; x=1760437357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UyUj3Qix+qDVReFl/Sm439a80dBofMDi/9/TOImgQQ=;
        b=DExSzvkMs/AsfAQ+wOw534Iyk8xwjQBEAVNtRJ1gFMxboJShq9h5X+e7qnle8myCMu
         2ebMU1//LHwUwswdpe5lTMpqSs2ZJenVEUWLVuN9G4XJ+EdzN8HyHS3Tz0F+wYZey7p/
         Z3VTgB3++1MzEIqR9WH5epOx0nE56NCB1Z0WrDI4JWEleknCjKtctn4dvwDmvnKDRwCq
         mKohdqnw6UAkWH1qD8UPzKOTHB91f4yeXiCZPvwdekizXYVRGirmBIyqqbzIKVW9DN+p
         wgfCNJLWlxYBkPJZgYvNISQKzZ/1hWyx4hV07MO+izCF+rEYOKoxQPUh9gyuKkire1vN
         BJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkqxq82exLvjNoXsHLXz8d3ituyoENQ7QLtHDCRB3Xw/32A/qpwjkN6CthhnhSJoZEVNQmYnw2BZyQnh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0G3I7oY9nZgiBAcnbXFH1A2u4ia/fARIG8dkAzHJP+9f/XMRb
	F8D64cBwovJWMve5Yo23hBCOSbSPZ9HexmBXrpJj3IHoI6QMeEQ0aEqJYC7QxLtM
X-Gm-Gg: ASbGncv6B3w9tnFO31riTeU/nPIdjU1oPPGyp+YwU43VAcB3DPF6akQwF/FaBFTCdQ3
	qIdXtAY2oNUEfNSlWLdle40dfOOoa0qxQkY9ownr5AV4S2icHacySnsa1wSNHmgxP9361p0y78y
	hdezK8MGYC2SgOT9txfEr/asxsD+mUSHFBDE4zu5hQxhr9ZMDwa88pvlS1SrKpQHUlCZuwyxGAS
	A7P8dJYEecRMLnAiKBOfpbO7vmJ8AW3lOxgHQByLrJFQwDxYuEIzgU61BIvMEDmblb9RMUjKMxn
	g/kJbOYT/xTAEnxfep/cvOXP1FMsQm/6juPqlxDdsgcZyqzHXdZM9D/i3uLtUzAK2olstiMsyOR
	xS7vL950YqA89Yom/D6TsDZFgRnw66BlMc8HxUJaQhFQ8DLT00wqjIrZiBwZC14s0Ik534kbXS0
	cFeMsy8z/Sxmb2qcbbgbG7Uac=
X-Google-Smtp-Source: AGHT+IE8cUd83lIyI/RNhrN9ZIOTg8BQ+8ERPq7pskuKuqGTr/cVjZ89sEfzAp/iN0ZHnjBLSNnz+w==
X-Received: by 2002:a05:6102:14aa:b0:520:ec03:32e9 with SMTP id ada2fe7eead31-5d41cfb12ffmr6275694137.3.1759832556831;
        Tue, 07 Oct 2025 03:22:36 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39d180bsm646453137.13.2025.10.07.03.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:22:36 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-554a7e98e19so801145e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:22:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr+0KhMd0eOz/onWVAFCeaVgHy8AqQkeylRGI+3IA6nEM1NryG/xcJiwy3Mhsbi61gzrG+O56mnJiGtkA=@vger.kernel.org
X-Received: by 2002:a05:6122:1e0d:b0:543:e262:ade2 with SMTP id
 71dfb90a1353d-5524ea6b0e4mr5683075e0c.12.1759832556074; Tue, 07 Oct 2025
 03:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007092313.755856-1-daniel@thingy.jp> <20251007092313.755856-4-daniel@thingy.jp>
 <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com> <46382bc6cab2196a79780a946bee96dde402ae31.camel@physik.fu-berlin.de>
In-Reply-To: <46382bc6cab2196a79780a946bee96dde402ae31.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Oct 2025 12:22:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUAEoN+KBnk=aY6UnkxXnFp8KY0BV8qQGfGip=nNtfaQ@mail.gmail.com>
X-Gm-Features: AS18NWAPkggXOuJ8Zyug-B_6vXxzZFwJxIAhU-W5_YEhuf5bM649C2kMw_p5v_Y
Message-ID: <CAMuHMdUUAEoN+KBnk=aY6UnkxXnFp8KY0BV8qQGfGip=nNtfaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] m68k: amiga: Allow PCI
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Daniel Palmer <daniel@thingy.jp>, linux-m68k@lists.linux-m68k.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Tue, 7 Oct 2025 at 11:41, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2025-10-07 at 11:37 +0200, Geert Uytterhoeven wrote:
> > On Tue, 7 Oct 2025 at 11:33, Daniel Palmer <daniel@thingy.jp> wrote:
> > > The Amiga has various options for adding a PCI bus so select HAVE_PCI.
> > >
> > > Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/m68k/Kconfig.machine
> > > +++ b/arch/m68k/Kconfig.machine
> > > @@ -7,6 +7,7 @@ config AMIGA
> > >         bool "Amiga support"
> > >         depends on MMU
> > >         select LEGACY_TIMER_TICK
> > > +       select HAVE_PCI
> > >         help
> > >           This option enables support for the Amiga series of computers. If
> > >           you plan to use this kernel on an Amiga, say Y here and browse the
> >
> > This doesn't make much sense without upstream support for actual
> > PCI host bridge controllers.
>
> Isn't this what patch 5 does?

Oops, sorry, I hadn't realized this is part of a series, as I somehow
haven't received the other patches from the series yet...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

