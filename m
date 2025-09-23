Return-Path: <linux-kernel+bounces-829258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D3B96A14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90502486335
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ECB223DFD;
	Tue, 23 Sep 2025 15:43:12 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EF1F92E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642191; cv=none; b=eiszdTO/U06OprQCTOFFMaclDYZrkwpHrIVZIKrN1/jNeYIBboO7XUjr/+pKtshSjMpZR/vZ3/criKCnt3eAFOtPxovbl5GJGQxLa93BrDZPqPc2QeAvB3v3smwXAa7ou0By7YjqUnt1X4lSInUXyNgfLtK/mS6svCXMi6WV3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642191; c=relaxed/simple;
	bh=Yf+3ASN03fGU4/kJvLlEV7wjNVUej5+gmHMkT9Ln3Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvDsSFk8TKB4jTfw1bT/3W9cOE31QWqZoneFLOd3QSzOnKGkVwD1JEIpMulAFA1EuRrcvW9QShdHONiyrElFbjD1IdIZZn7IiFDbX7uUWH/RSiPTka2UQyQp1nj2II7hQjQ4liBO3ZCOax/YYHnMuJvtsDBd85PkEbq69quAK+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54a880e2858so2412128e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642188; x=1759246988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r122gbb6KUA5XSddGivsEIWOLIrHYjHok4r9kMcR3qk=;
        b=QR91LRBZU9oVhJU9Uv+YtK9Bx1mcQAOpborwrBjeGLKkp45LX797zFmA4ifOYJmofy
         k4IBafUeCKSBHw51SJ5wdw2MiVmuOhTVZ+oskd4JoYPgsP68LJUngyAUYiCe+9d0D9ix
         L7vom5imt44nabsBOwoxJrJTf6AO2Oy9PKcS4543qNjJNoyjxTxn2lbmIz0WFd01XDfo
         W2wuov4PBN8vT9P7dk6Mz2DofkLNEFA8LTkakOX0cA9/1dZjMaxCgISo9M2scQahBg55
         +RBKyOQ38G89MemsvpuBbTu0RdMSAlq5pdx3gzGZyap6OgSVnBwuHMIAPDEiZROr8lO3
         Kx8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBz4oY0gafZz5KJZz+SJmBwVVGp6hcp5a+87Dn/iqLu0yPN6R42XXchPwcFVzUyu3LlY22QmAaJUhuZ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJPc1KDwRonpIAHRGgiYX5GM1/kBD2Z2kGMbpeD+swcLpucej
	1o9znRtC4rJ75aoL9UzE/884V9qqqP20XsvOWr/0rpKqu82Hs6b5Lg93Y0ZotzXt
X-Gm-Gg: ASbGncu6BVeVbGNPAhIFcXjaO/bdT62aOmJufjKoCjLRxqnid1AuUdxakojG+sZ48f4
	d3kPYdT+tmkR9CJ4crk5AnD1qAO+Q0WUchx4uqvE3Gh2zddzRH4OSXtxI/gjY//N+E4CWkNxN3m
	gKQPi8WL1XH8SzFHWA0no15wR0695PDFughA7Y85by5/0vjzGN9he+UoSSlisHEsGWfcaB9nD7W
	xy21SUY/99igJpTFJRpHjtSSQPHLJLiml9Y1E+87GTYxh89g674pDYFqcb3pqwtVEyQhLMtDSRa
	IhuBfZatIPAygbduvsRtiDFjzUAT6sWU++bJTTrId+ervdrwbgzulJsuDV7Vhc++qjNHrbXnQTV
	5/FxkesXH+t1aORMjSBLQ8QNA870qlcqWGCzrq0N2c3RYSD4/vvort4wx2WSF
X-Google-Smtp-Source: AGHT+IGdtvzhk/i4JFhHIoxrZFsRskaU8QgdJdZE3mZzm8avKzZdMHd6wxIhi31a7dvlSN+W0eUn/Q==
X-Received: by 2002:a05:6122:218d:b0:54b:c080:a55e with SMTP id 71dfb90a1353d-54bcaf50e77mr1039269e0c.0.1758642188002;
        Tue, 23 Sep 2025 08:43:08 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a8685e515sm2755371e0c.21.2025.09.23.08.43.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:43:07 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso3651802241.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:43:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPAgYQd/pFDj7rhUIUiH3NTIF6iPWvy7aLbKiPvkAu7xDq1Huk5yzRTSpRfaubrouI9GvpqfML6zLVpCg=@vger.kernel.org
X-Received: by 2002:a05:6102:32c1:b0:5a3:eb34:6105 with SMTP id
 ada2fe7eead31-5a57b993f3fmr1081977137.26.1758642186984; Tue, 23 Sep 2025
 08:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758181109.git.thehajime@gmail.com> <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
 <m28qib8g1r.wl-thehajime@gmail.com> <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
 <m27bxu949d.wl-thehajime@gmail.com>
In-Reply-To: <m27bxu949d.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2025 17:42:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
X-Gm-Features: AS18NWDvUQG0XS9HQf9KIlOsuvRaqQEDSSkgXS1FNduECZbOVkvTaW7-DLJb-WQ
Message-ID: <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, 
	ricarkol@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Hi Tazaki-san,

CC arnd

On Fri, 19 Sept 2025 at 11:32, Hajime Tazaki <thehajime@gmail.com> wrote:
> On Fri, 19 Sep 2025 16:24:07 +0900,
> Johannes Berg wrote:
> > On Fri, 2025-09-19 at 09:03 +0900, Hajime Tazaki wrote:
> > > > This doesn't make a lot of sense to me. Why would we even want to build
> > > > PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> > > >
> > > > It's not like ARCH=um with PCI and NOMMU has any value even for testing
> > > > if such a configuration cannot exist in reality?
> > >
> > > totally understand your point.
> > >
> > > now I see that we don't have to have this work around by using
> > > --kconfig_add option to kunit.py.
> > >
> > > # like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n (in addition to
> > >   --kconfig_add CONFIG_MMU=n).
> >
> > That's not what I mean. I think it should be made impossible to build
> > the broken code.
>
> okay.
> # I think now I lost the point...
>
> currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> so we cannot select it when CONFIG_MMU=n.

That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
dependency, perhaps it should be reverted, iff you are willing to take
care of the casual breakage?

>
> but it's different with kunit when using them via kunit.py config,
>
> it first adds
>
>  CONFIG_VIRTIO_UML=y
>  CONFIG_UML_PCI_OVER_VIRTIO=y
>
> via tools/testing/kunit/configs/arch_uml.config, and then add
>
>  CONIFG_MMU=n
>
> via --kconfig_add CONFIG_MMU=n.
>
> and then execute make ARCH=um olddefconfig, which in turn enables
> CONFIG_UML_PCI_OVER_VIRTIO.
>
> if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n" to kunit.py,
> it will overwrite the arch_uml.config.
>
> # I don't know how kunit handles those appended CONFIG entries, though..
>
> my goal is simple; to test !MMU code via kunit.
> my original patch or the additional kconfig argument (--kconfig_add)
> satisfies this goal.
>
> > The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> > various PCI code, but nothing depends on PCI in the first place. Which
> > it should, then?
>
> I don't understand the 'nothing depends on PCI...' part.  care to
> elaborate ?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

