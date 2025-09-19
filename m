Return-Path: <linux-kernel+bounces-824103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5D6B88223
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C917B520A90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D22857DE;
	Fri, 19 Sep 2025 07:17:55 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A731862A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266275; cv=none; b=DhRMT4EMpNTvCGfHONafeGPAtvDddhFKxpJgG04ZrKuEv6+Io1F4MJUeC5KdKEtyr21xid7gQe9jft9pAR/0Rrjp2dPfPVyf/6hwt3xrxS+iT8AwuWCnNDKsoyte3BxLaE+X9mdfNkBg1ApI8JjuwbDRgAdeNFuZ1vHsdsdQpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266275; c=relaxed/simple;
	bh=wb2qdIEva+9wMnDjLkyVGNO79u5HZMke8qdhK9b51SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji+fq0VRTC5oc90xxtabIs/4OkKJVXUN9OxeU27m+fviNWvn+fQcIWhcCQlTKgbIvfq5HO7aRMp3d6zFEbl/Yrz0V+05Oj66oSVx/RusdC27p4fXZsQ+8W6D3oXwjerzVeaQKoUP+OgWXkRDPzGEaDCmMu8WAkd9SHbDmvmZ6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5910f37bdffso14588137.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266272; x=1758871072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN8ls4Umh9EIXSEQoAkCyXxQ8L8mjN2Gdzzs4J/riyA=;
        b=Pdps3EvpjSSLSRCjeakbuCqShndH7kib0J+/tnKCZiT4rGifo8Nvc9Ay2KJdvnKp1G
         IjMmHJBScJIy0fqpttnd9rY9azPofKkLxTvTng/COVJ6kR7ThW6ccLKhgbW4hdcZ5gOX
         B5ks4AdHMjQ8/3DTH/2QGMLOPb9EdFHzoCda56bhJvCkSWt41oRwniJvvNJ31NVgSj42
         M52Kym1ud/veeBD4/TOyVpggD2BlbepoleLLOW6Mq4uiu+d+KuVFlsTKefaPx8hQwAE2
         e+s149FuVWeO/UWXlW02iBw2jchgnZodraBmnYknYrNs2BWdNMRuyAV8AJnXwRtXCGPz
         Ivkg==
X-Forwarded-Encrypted: i=1; AJvYcCXBXQFYjLixnhcMRdEqEIqkKkgH9Gv/jJF8yifrzhAvZP2f2PDkmZPE4102Gcee+YfcSF+aWVSxCLhX1DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywru38uXtJpQG9jvcdWSfR7YglipGoobSmWQhvwWIF8D1GndAXG
	HJdIMs8K7xsWsN5iVDKOxA3Nm91Ps5vATCZntGoNPnwCtOXzd9fUchPgpcha5B9W
X-Gm-Gg: ASbGncsJJfx1xBZPJuFOgsD5qNZ81LRY/5+blbDSwIt1SQVEr28HVAJ1HP67nWL5TWN
	ZYN6DTCMp4lTI69nvv4ThH64mAmzM8dLtj3VUkL0G/Yc77GlWO0kJyc1f93T2O8SbMns8FldT26
	mnHbDa7HP1dFuxPfxAbTURakxYxa7jS1tGBMeHCbfIyI1CqSjBsKRTXboO2Tr3N5YWsdwoFMRh1
	roYVil+uqZHyYMx5jVQt0eKr53Kl7A28g0f2EjooNOEoxExsmC93P8Nw9Z6jaUbdAicIBG19j9K
	pWxZJUO+715PsMxASUcZtORgppUF/8QJQ1rw6GPa5+d5shj0t7PQteGSkF1CNKBBzmr5eH6CE47
	2x4Uv520M6BpXEFTXZ7Ir4HbQyclHAxefTwYiNnHFL4DbIwYZY777anziWLzq
X-Google-Smtp-Source: AGHT+IGkY5juqPWgGjRGCNoOCd+AwP0/WmLURcr11zwIFzoL3NJVxcwNHfQcYPGAAyV164uNHAT7Vw==
X-Received: by 2002:a05:6102:304d:b0:555:ef1e:49bb with SMTP id ada2fe7eead31-588eff69ae2mr571364137.21.1758266272222;
        Fri, 19 Sep 2025 00:17:52 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-579ed35f674sm1178562137.7.2025.09.19.00.17.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 00:17:52 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-529da1b07b5so331243137.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:17:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgmQC2XX3rVzUKCGgZHfUtHRapPQpM11mDLlvq1Pb0fKq95CMRrnpqsHlKk3eTgoXt4XipnIr/mG4ghs8=@vger.kernel.org
X-Received: by 2002:a05:6102:534c:b0:55d:b35e:7a58 with SMTP id
 ada2fe7eead31-588f3357b74mr639278137.23.1758266271934; Fri, 19 Sep 2025
 00:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com>
 <20250917125951.GA1390993@nvidia.com> <02b0f383-1c43-4eeb-a76f-830c2970b833@app.fastmail.com>
In-Reply-To: <02b0f383-1c43-4eeb-a76f-830c2970b833@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Sep 2025 09:17:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVecUeLZ2LPpa457C0a=uduvDhQ4KZJx-++dEFJraRi3w@mail.gmail.com>
X-Gm-Features: AS18NWAI1tRNfDFQjIFUy24j2rmv5VjIZdZQpBy05JHeqlSMB-7iVf4odZQDlmM
Message-ID: <CAMuHMdVecUeLZ2LPpa457C0a=uduvDhQ4KZJx-++dEFJraRi3w@mail.gmail.com>
Subject: Re: [TECH TOPIC] Reaching consensus on CONFIG_HIGHMEM phaseout
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Richard Weinberger <richard@nod.at>, 
	Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ankur Arora <ankur.a.arora@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Sergio Paracuellos <sergio.paracuellos@gmail.com>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Thu, 18 Sept 2025 at 15:13, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 17, 2025, at 14:59, Jason Gunthorpe wrote:
> > On Tue, Sep 09, 2025 at 11:23:37PM +0200, Arnd Bergmann wrote:
> >
> >> I'm still collecting information about which of the remaining highmem
> >> users plan to keep updating their kernels and for what reason.
> >
> > On this topic of removing some parts of highmem, can we say goodbye to
> > kmap_high_get()? Only ARM uses it and only for
> > !cache_is_vipt_nonaliasing() systems.
>
> Good idea. I think we are almost there, just need to verify that
> there is actually no impact for existing users. I already knew
> that there is very little highmem usage on ARMv6 and earlier, but
> I tried to recheck all platforms that might be affected:

> * Microchip SAM9x7 is the newest ARMv5 chip, clearly does
>   get kernel updates, and the only one I can think of with
>   DDR3 support, but seems to be limited to 256MB total memory.

Are they limited to DDR3?

IIRC, someone (you? ;-) told me at ELCE that Microchip keeps on spinning
new variants of old SoCs, to accommodate the changing DDR landscape
and market.  So perhaps they also accept larger RAM sizes?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

