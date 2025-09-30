Return-Path: <linux-kernel+bounces-837898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E481ABAE007
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4455178539
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE1309EEA;
	Tue, 30 Sep 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OqGG6PSG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0363081C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248282; cv=none; b=J407Bh6yp778IFuccVhEP0uN6PFq0bpRfWXCHhR3YShXG98T3aqqQSqoBi8rHUgOdYIUpmhKWgAD9qdfx2AXdG3cQd4/4oL9po9rDuO0COyxGhHgLHORFyDV5NIRRiz+kpxuE7zKYesO76ayxpF3Ft9U3/ZOs8/9EBe8byHNsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248282; c=relaxed/simple;
	bh=6kEU9kRyMMg05v5vfGWFARyhvnJ2oyGHNgccUeVLLb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=presKmNZuZAgi5TgbhnmVu+QM7SHN+gQM4FOT/Q9pHPRbYM28k67JK2yfolXf4nfKie9A5MXkbHukelJWg4PcuNYw7FndWpXoYnxnSkNfnh8T5ZCGLNCQYnGtYbd9zh8umyiS6aMS3DdZWSMowIbZ7nPym+mx5pqru6QI4qg/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OqGG6PSG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so11311343a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759248278; x=1759853078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSHENZMRnVeUFapxRU95YDUstKUost4pQtLkCBW/Xrk=;
        b=OqGG6PSGtfrgtbSkF0NWxjDjKYa89riiGKImiIrJRs4fMqDONF3ec6MH4SGu91nK4h
         AmeVji9TVuI2tc8gHt2L3KjyDITaK5YE1kKQHvqGSRyw0nhHH2g1ZuvQJUnMtn6TtwfG
         yao6cm0KGzE5TSnk4HPGnSCOgO9Z4fuyUj6yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248278; x=1759853078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSHENZMRnVeUFapxRU95YDUstKUost4pQtLkCBW/Xrk=;
        b=meWb40/ahf9pzmlN6kTOGV02ElbdibHTHdolD9CxIt37du/ViWabbBpRVyNbkNOJdr
         uqsaKw1w2Ii+4puqsb5/uDSIcmgDrdQoaav1czMkgBYo2v+k0c23907LmiQ3BSJueUj6
         5Cy99FXh1fqpnm8O3Comzp9TQOf4X6MRPI7IuQ27LJZOlALbx5Nv2O+RSuR7o5HtzUo1
         rOi86SEOzB1gqJpOLPR4p8TxpwobzZpi8Dm7CrjamvlFDOHoE9JMBvewq+W9kS9bttmf
         KObt2ta3Yfn/R7c48sJSILHE0YCSpeW6xxpZ4GEltR7mauKxGZktgAYdqZDy3SvFKe0A
         Tm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdKDBZDHTe3TxOvE0G371g88eDuoIxMxN4WzBPKadvQ3dtaZWm4YLwxdlA36PVbeU8c0pyMzfk2lJLkQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKffLwthC6GXwzRCVI8/jdWgvpwdJlGueXKnwYg7uT9g5C8Rr/
	Appee0wkN9wqwBxESECAgAJ9C3Iw7smyMH76/4hyqSglbqilf0uZ4eHg71Va4b2C2NUlVLKT4gQ
	TplDChSQ=
X-Gm-Gg: ASbGncsDyi+RzYWvjeNnjhrQJLge4bnY2GSdwbN4aayFuE8VRIAK4H3JoI/e+sl5sPb
	ua2RFSCJRrSber/I+1RRw/3NqKz0q5qgGvmK3zsV0uvwnTdN+vq/vF0Jy31aaCCKisno/AdKCpF
	m9tiDmQ89jZrd/tviCPimXrsEbb9P6ljJ8mfi5qLx5KoflDlWiGGFZy0ZGtWDTAIpCQ+yBAf79p
	uVOSvpd6K9xyjwrKsBoESN8IyfR/Gem47ZVFGeIAEUp12gp6zPwnkAog3a4uyhsI7D4NBpR82LK
	H5YLr5YU125hhIbDtl1pVBZAOmsM+nrw+/4XUA1vQNuaF7RZ5V7FwxIPOXulXWCzWV8PKJDjN/Q
	Sb1kAXnJL0bVVIknp8J11a6aeZSJV5aSnFk8iZuhKg9BY+cspzrfh0qnQLv2nPatiKvaOTvPsTj
	51DNZ1ECoAPfr+ojgESSg7umsfVGZhV80=
X-Google-Smtp-Source: AGHT+IGhF4L7rTkCoEKOXMHLM1QXaU6IM3MhaWu/Z6p05ZTvXCDHqnVuvsyVW2KIg4SxYlAaNMIDWA==
X-Received: by 2002:a05:6402:27c9:b0:633:59dd:3566 with SMTP id 4fb4d7f45d1cf-63678bbadacmr543414a12.6.1759248277842;
        Tue, 30 Sep 2025 09:04:37 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634c28f1149sm7933971a12.7.2025.09.30.09.04.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 09:04:36 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b30ead58e0cso1149506766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:04:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUZeTGW1XYpD7v9ymFz1JKZ4Zs5DpPe+NwKVbhTLWRUwd/MohRfNQWaWpcUp0/Lm/4JEZNZNEkLzkzuzw=@vger.kernel.org
X-Received: by 2002:a17:907:3e21:b0:b3a:ecc1:7774 with SMTP id
 a640c23a62f3a-b46e99537d0mr14481366b.53.1759248275871; Tue, 30 Sep 2025
 09:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org> <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
In-Reply-To: <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 09:04:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
X-Gm-Features: AS18NWCqeDn9EkWAwf5x-TTOiUz0zNTGkg_UlVmAWbsgKTQHGgJnTYZePr2tmYQ
Message-ID: <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 00:25, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> Is there any chance some of the big-endian work we did is getting in
> for this round?

Oh Christ. Is somebody seriously working on BE support in 2025?

WHY?

Seriously, that sounds like just *stupid*. Is there some actual real
reason for this, or is it more of the "RISC-V is used in academic
design classes and so people just want to do endianness for academic
reasons"?

Because I'd be more than happy to just draw a line in the sand and say
"New endianness problems are somebody ELSES problem", and tell people
to stop being silly.

Let's not complicate things for no good reason. And there is *NO*
reason to add new endianness.

RISC-V is enough of a mess with the millions of silly configuration
issues already. Don't make it even worse.

Tell people to just talk to their therapists instead.  That's *much*
more productive.

Really.

             Linus

