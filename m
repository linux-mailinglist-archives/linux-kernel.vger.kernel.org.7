Return-Path: <linux-kernel+bounces-866429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E07BFFBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9813AB2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42C2DCC03;
	Thu, 23 Oct 2025 07:55:41 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070CD2DEA79
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206140; cv=none; b=Ab0i/mlZBSnkWCruUppYtTXjX7GbbSGWO6XyLHPHAvShMdpwmjVfSUbwKdW80xuZKbKygOTsqET82cqCC4kDNHB8nv+wV2BvXuq6jj6uQHPUIiEZfHoVhu+sOkjAciLQ3SHPJrEf5rdxqomxKfgsp98rjKhd0HvS9IJijOjBDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206140; c=relaxed/simple;
	bh=+fB56hRZm4s/9A94T+9AsJSw3DZkXg6RPZ3NqE6zskM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eg5yjFSbKyo0Gi40tyAnj5QaPFTqaIQw+wPvDIoD91IdnSXtY+3GrK+XTtbEvJ8HVaiIdMqfHK8nCUVGqqkAqoAbpFJFnDmenL2IXqP9hkRrWAS8ijuc1VXFGg2nFI4YyMaZ6RUklREeBd+Mr8HCtHTCpswrhg05o7gCJbz0YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso259499e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206138; x=1761810938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1VWeQnGLaqOMfwGg5f7EVJzLAyxDuT3Je9LnDxvdps=;
        b=D02xpdPhD6hPv6sZmuHac0I5E+ZclWrtqlMz6obH/RD4323Y+QXXqfCv1bjdpjf59Q
         0q5yEMJYbnJ5qkLTQhM9/8Pmkdpl5TLcRnkSmWXDgCHzzRi0yQG1m0LaWxqaf9OR2t1V
         5kKD7DsetlPZKkAOYTVQt/hGKZ7VaWXhs66s+l9MZXKSVxCbzIX8GTi5er9dEsZHKt3u
         El8AFNFjL6YmdbtPjvIUR6MG5ULqfnZIZh+iuMFhY2jfpEKJI6+5vnjPQ5xnstq7mUsF
         zfwzANrFWOq0TWWZaLCQnHRYhSn2JYxqwqAEBbCaDrsSYHgoAA/6otvPmqDu/2wOD72Z
         PVIw==
X-Forwarded-Encrypted: i=1; AJvYcCVj2Dl3i1bgOC9DivZr1pdjPqOeCoAF0MCAC6aAGf3VAKDRilHwp1k5BGASD576fGfcXjNy/kilH/1c41U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboH9Yp3tFzOiZLvQnjz3/Ww0vAAO/qY1127A4qh1fxSgIAnOl
	LS8Q9RCfjioZZEjn5jK+YaqEFWCgasRC03V8TS76kcuqcRJFr3t+dJ+4q/YQharw
X-Gm-Gg: ASbGnct1v3aRvKCZLE/K+XcXTbPHD6qEFdz3ecvFN0UoEoPy4ErgI3AktxKKG5bvW85
	lPm+nwUAhXE/H9c3CE+uBKk3+0OBpwklOc2k9rqUMo1jDO/sM2vCW9nM9YYJCZdt+3HAgX0hubh
	NhoaagzdyoxiYyphhP1mSvXT39n7SSw/6ZL7w+Y6h8dPGXrHTi9ikOAbfgtbFzk74ntrTPYVjSu
	vtoPSjwp/Auw6Ntue7vLRgre9MYlIBkGnDuuRiEr7VpukU9/UskkBYu98pNdicFkBPGJZJEmiF9
	kpZb5B7e7QYJ2tsyCdZrQ7/C+OOJpKbjEYakBhXVHsRzBi0YgFIeD8MiRbL631uOnZmHD6aCB7A
	5RvyG2Q92XEX1Gjj1/WfgHYC8ILugViL9kDlgx9z3kPvWIQKZqidDrER1l4Je3+CllO3f/eA9tK
	MP5R89WrBo3MDoyI5/y7QVq+ljlezJJ00maPh5TEje1r/Z1mIt
X-Google-Smtp-Source: AGHT+IGhkVW8XK4ZX8WYQpOm/wHemNcuR2lfd6rppYCXkIwDNSbKhRVdG8nFJkhA2sQLhEAjLrBmUQ==
X-Received: by 2002:a05:6122:2206:b0:556:3bd1:85aa with SMTP id 71dfb90a1353d-5564ee4997cmr1328783e0c.8.1761206137628;
        Thu, 23 Oct 2025 00:55:37 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbbba23sm506135e0c.13.2025.10.23.00.55.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:55:36 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5db30731362so352727137.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:55:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiTj5aMA6mQGClSmWx9jVPPVDbTMtp+iPXu5WqtN7Ifo0bk02ArDC3ExBX5hFbthCFS6ipOSwzCNiabw4=@vger.kernel.org
X-Received: by 2002:a05:6102:38cb:b0:5db:337d:65c6 with SMTP id
 ada2fe7eead31-5db337d6988mr173700137.23.1761206136224; Thu, 23 Oct 2025
 00:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com> <20251022194939.GA1223383@bhelgaas>
In-Reply-To: <20251022194939.GA1223383@bhelgaas>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 09:55:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLXd-eVX0UBPYtrzVPbA6VkdD1rHBAWMKgrYKE+Aa2bw@mail.gmail.com>
X-Gm-Features: AS18NWCwdsxUw7zogPqVrxEDzYqaWGHMFOcHzYZ5pvVfO4qa6VaOrBUa-VfGcUI
Message-ID: <CAMuHMdVLXd-eVX0UBPYtrzVPbA6VkdD1rHBAWMKgrYKE+Aa2bw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Wed, 22 Oct 2025 at 21:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Oct 07, 2025 at 04:36:53PM +0300, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> > Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> > only as a root complex, with a single-lane (x1) configuration. The
> > controller includes Type 1 configuration registers, as well as IP
> > specific registers (called AXI registers) required for various adjustments.

> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>
> > +#define RZG3S_PCI_MSIRCVWMSKL                        0x108
> > +#define RZG3S_PCI_MSIRCVWMSKL_MASK           GENMASK(31, 2)
>
> Unfortunate to have to add _MASK here when none of the other GENMASKs

Actually the unused RZG3S_PCI_MSIRCVWMSKU below would
need one, too:

    #define RZG3S_PCI_MSIRCVWMSKU_MASK   GENMASK(30, 0)

> need it.  Can't think of a better name though.

MASK is a good name, as the register bits actually specify (part of) the
window mask.

>
> > +#define RZG3S_PCI_MSIRCVWMSKU                        0x10c
>
> Unused.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

