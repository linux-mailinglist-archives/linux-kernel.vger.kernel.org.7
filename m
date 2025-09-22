Return-Path: <linux-kernel+bounces-827662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7277B9258B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53B27A76AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668923112C0;
	Mon, 22 Sep 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="pc8rG64G"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B34C311C38
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560804; cv=none; b=kuGLtI3LCo2kvO/Y7lxB+N80xBE/LU/1FJhvxYWWgCLallhQrVrXfLzNAP2hvuefmEu6bEEry6/o7FKcwBzJAyDx1xgWqHATiigjYdAbT/oZnJCDH2R9nu++/gz3unwfVeJzo+/Ug46FERrpzhSeXFcz8aMqv1GtKJZc3U/2dSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560804; c=relaxed/simple;
	bh=mfTxy/VfoZLfkD3A3YneqkiMYF042jvaQsyUPhITHp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXlRb6cVIYf5PFrjyPHf6HfuHGqUa0tLNSVjZH8R7dO7KsowVVyOU5TygEm2Q1qHEbhD7b4rr+YmNmCV2xs3W4ecuj9t10sL3xdDwVGFJflnFdI6fzFDdoi7mhE0X6lGA4IBdPdga3EmlAfv2TLeLzWhyNkpbc1Lj+V/x9MEeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=pc8rG64G; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57eef777d3eso1128219e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758560800; x=1759165600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Et/xnvrYuQUk0byB46PUmXIo7392F/K55Vqq2WX1kEA=;
        b=pc8rG64GUmAKbICW12M2OBZMWFNJNh0OeC3KVRY+EitZhPxW6wHcgYPdVLDZd3RDeW
         LLobb0GWElRvl3qAk9/il8IbYfDDZ/maImNOUe5aOLqIiUCNAC4Z0NlUVqJ4V2uWf2un
         pRXLvF7gHjO9jFdeg9iZtGMAUgJOx4e224RchECbFmwlm55wJ6Pz3kHHTFDurpiVaJvI
         VlKxfREEU6VqgpOUzvL53Vt/8MlTYU+RMqKm5f+5K+eCbjVZeWNJNviuhIDOvV0n0PKf
         4YUDHvptiF704Bv30W8rDQun7UHOXr5tA/KeU37uZS/fj0VjvVgO9pQPWtfgHvjCRPGG
         KU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560800; x=1759165600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Et/xnvrYuQUk0byB46PUmXIo7392F/K55Vqq2WX1kEA=;
        b=ZrSVCZZ8f8CEoWdI37AVkdb25OXo3gDvRpv8ZZkCpbvWGQ7AYnJPhoQA4eCoN2SbHG
         KOxb53E9NtLAegznCNwto/ldPFW4Mf1QFMNcicJrq4Jiy39G5UKlWumcRB0AVgbMqJJ7
         kgDKOJyVIvOJkEowF/EUanfPjx/GlgnBJEjc/Gx0rGcVm3BkNTzT15FJHqNuleIuw2b+
         XLWBSNzNNOWwrJWgWyQqbFICVDciK7MYPlCm8wCcB890plR0Ezo69o97tH38nNQ0DQB6
         t7q4LMdw6hkgh6UveX7+V+Qtd3aHdFqDvw4KuVWROXNjVPyXdUbzTYtye2UpKftd/usT
         Vj3w==
X-Forwarded-Encrypted: i=1; AJvYcCWOC4AzOIPdpW9w91ibsaaTK8p9UOnjp11S5GR/ptGpTuEaeE7z36N3Ul363XMnvldFxizWXCrYlg6Y1nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55Q+C/fdgOcUMhVQJb3xX9rzGUCvBLdcJWH674D/vJSzyfiAS
	iEBqMN92cxEDJmfkjOW6p8+4lFjM0LqXSTgxVORy79sn/mLoUgUutWqXEpiy8LCYzGctrJ61snR
	BfvMnjMUYy7QFA0EGVUwCrw7o6OsnmagT0aRam7vLqA==
X-Gm-Gg: ASbGncuL2GzBAu1EslpHJsvmsQmH+MC8QfcQhfWoKoeD7vWHBKWBXc33ARvt4Ctl0yi
	qrUG3AmKO39/U42S1QI2DVuKPMIj4sH2hDD/jZAO9PpbyZIYvqZyXfRfdc46sHQ1wrl2Yt8EtXk
	FkJbnS7nSVEsD3ppNbxQ3L3GYRf4FZgPwD+hmU35U4EcKNk5t6Gs9q34EFjpDp5y9aSVh3v1ZWZ
	cLJ
X-Google-Smtp-Source: AGHT+IGGtpp1dzmc7QwuqgW2pSLIm4mtcBhZLeu+2i3+Ni9prtVcG/n56U1c5SPCEyTQDr/U3BLl49JsojBTLduSacs=
X-Received: by 2002:a05:6512:4013:b0:57b:aff6:68a2 with SMTP id
 2adb3069b0e04-57baff66a5amr2706206e87.26.1758560800251; Mon, 22 Sep 2025
 10:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com>
 <20250917125951.GA1390993@nvidia.com> <02b0f383-1c43-4eeb-a76f-830c2970b833@app.fastmail.com>
 <CAMuHMdVecUeLZ2LPpa457C0a=uduvDhQ4KZJx-++dEFJraRi3w@mail.gmail.com>
 <547dcb81-434d-4910-aa7c-1d69019fcb3d@app.fastmail.com> <20250919143436.GC2132010@nvidia.com>
 <44f910bf-ac2c-4b2f-8e50-5cfc7dd0761a@app.fastmail.com>
In-Reply-To: <44f910bf-ac2c-4b2f-8e50-5cfc7dd0761a@app.fastmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Mon, 22 Sep 2025 19:05:49 +0200
X-Gm-Features: AS18NWDJSAue7YE7c8rlG0jvR5lve033dTh_Rnu2Tx6e392cgPO_ZPu-mU9r2No
Message-ID: <CAHNNwZCsBY+ta2-OqD40K0-C8N25PLMYfOJowiVeaEMotqR1nQ@mail.gmail.com>
Subject: Re: [TECH TOPIC] Reaching consensus on CONFIG_HIGHMEM phaseout
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Geert Uytterhoeven <geert@linux-m68k.org>, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	imx@lists.linux.dev, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Richard Weinberger <richard@nod.at>, Lucas Stach <l.stach@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Ankur Arora <ankur.a.arora@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Ira Weiny <ira.weiny@intel.com>, Nishanth Menon <nm@ti.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Sergio Paracuellos <sergio.paracuellos@gmail.com>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"

> On Fri, Sep 19, 2025, at 16:34, Jason Gunthorpe wrote:
> > On Fri, Sep 19, 2025 at 04:22:20PM +0200, Arnd Bergmann wrote:
[...]
> > I am right it sounds like we can drop vivt cache support with highmem?
> > vivt is alot easier to understand if kmap isn't running around
> > creating virtual addresses aliases!
>
> I think so, yes. I've prototyped a patch for it to add a dependency
> on !VIVT and the drop the code paths that are clearly no longer
> needed without it. This obviously needs proper testing, but the
> diffstat is promising:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f14bac913d50..0a31cfaf3818 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1214,6 +1214,7 @@ config ARCH_SPARSEMEM_ENABLE
>  config HIGHMEM
>         bool "High Memory Support"
>         depends on MMU
> +       depends on !CPU_CACHE_VIVT
>         select KMAP_LOCAL
>         select KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
>         help
>  arch/arm/Kconfig                    |  1 +
>  arch/arm/configs/gemini_defconfig   |  1 -
>  arch/arm/configs/multi_v5_defconfig |  1 -
>  arch/arm/configs/mvebu_v5_defconfig |  1 -
>  arch/arm/include/asm/highmem.h      | 56 +-----------------------
>  arch/arm/mm/cache-feroceon-l2.c     | 31 +------------
>  arch/arm/mm/cache-xsc3l2.c          | 47 +++-----------------
>  arch/arm/mm/dma-mapping.c           | 14 ++----
>  arch/arm/mm/flush.c                 | 19 ++------
>  mm/highmem.c                        | 86 +++++--------------------------------
>  10 files changed, 27 insertions(+), 230 deletions(-)
>
> I did get an email from Nicolas Schichan (added to Cc here),
> and he is still supporting a widely deployed Kirkwood based
> platform that uses 1GB RAM configurations. He should get
> a chance to test that with CONFIG_VMSPLIT_3G_OPT, but I
> would expect that to continue working, possibly with minor
> bugfixes.

Hello Arnd,

We don't use HIGMEM on our Kirkwood platform, we are happy using a
2G/2G WMSPLIT. We don't need a lot of virtual address space for
userland, and with the 2G split we don't waste physical memory.

I'm happy to test your patch serie with VMSPLIT_3G_OPT and see if it
still boots with it once you send it.

Regards,

-- 
Nicolas Schichan

