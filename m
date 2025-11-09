Return-Path: <linux-kernel+bounces-891887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A1C43BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 11:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E5DA4E4AD1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77E2D9EE8;
	Sun,  9 Nov 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTAzi+ON"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7972D5C6C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683918; cv=none; b=IPw8+fCNxKfTB+YyBTOJUZ92Ctc/kxYkcCBTSMe2CAbBDYFFmtje4mFyVZqT6Ht96LKSC9vL+U6iQCy8XTbxxZuqp87CMHt0AKAoT+Cq4rTlp01FFTkGi/pEMjFXaNW+9yC9ugFKCPiOyIFASDiJk+uCughWwtgZ1Kfg2g9Q3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683918; c=relaxed/simple;
	bh=aTj+xi1dNvcUs59gPpu5k/cwPtbqdjHMItUzYc4T4H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7HXmTZG/0oERaf9SybGo+NSRR9AV7cpafozoUcAzPfY6xNoPmzEEZFbSfMPJAtB2MWcADZ4SC3QEryCdKG/PzARKuQskUPfIqTYf2uw9cNFAPfw9tkyj1Bp8WKPMChESSs9rwr5CdXc/FI6FUORSBWZdf0QzuA/xIInsZhr8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTAzi+ON; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so270905a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762683916; x=1763288716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY4/B0HvJE+qTQFqM/P/T84yDE9f54fdQMk2u26RaLo=;
        b=PTAzi+ONCWCLiiSb+RXZBrDtoEeA4zpt+ZloHAn2PXMpf/iDBkNbEi9vhSCs1l2Uwh
         27f2qwohI9FGUwSZdzuGepkmAwljd5qGp3SKmXyXdG4/kv2F0kXy6u/M/RlAFHi7Ol/I
         JNXa0nRQHPawfdoyLvnR+3dn/gm993WiyTgCDHFz1TDTRHc0BBmWZiA4xOoJwz8VKV5f
         h3kmAD5L67Bmp8GTyezcTW4Dr9sSK7Grok65NwpC6fAfTODNBvewFWFwC8yXu26nergb
         MabqGxOlAuykwGZ+wwxA88JBsPNuuTEWp7D1hMCaXgVCDDW4tBfof7U9oSve5x7ocMDb
         UcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762683916; x=1763288716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TY4/B0HvJE+qTQFqM/P/T84yDE9f54fdQMk2u26RaLo=;
        b=NlA2uFNGIIYJHd2jHJgIW++62WFiVze9JvI6NV0Pu6oc/LoK55ZuUfQSe3/XtD1WT8
         t5RpwCYjKFeIEOc7pCkjGG34sYJL5KkErn+Y7em5unKNQniK3/R+IPDvaJ5YzDljkbMc
         BWzqYJjFPnwDhZ7A4RyK17m4WKzi9tB5EVGRQ7vDcfNWep4PR88URsD58FBHihvc9qKF
         46Q1JWI3qVmGaDmL19VokYTQOXE3IajpUSEIXk49Kq1yDoKVc1P+rXqOzNcDNPI4XSD7
         YS7AlJ8DVkW2X2nossfgVCbcEsX3fRobHe5lIn78MURmdk0Y3ajFmBW65noQHXDGhWlR
         gf8A==
X-Forwarded-Encrypted: i=1; AJvYcCWT3nGNycrBzzAeo2llu0N2eRogkXNYNNszpXS+aB6oSPMQ4t3BrEWqyAYLKg5eQizrOKUgQ2rek5tH+k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzevveUqZXJJG/JszZgkzN6f2+N1kDCVt5pBfj9q4ebro03Yh3
	e70LscPhCcMJ9011CqbjoZW6GDh+pV2t6AwiRKP9wXNC196IHDgNFouayE8iViK+gLxjXpFhTA/
	8PPSH75mhWxCENbNzqi0G9lKfzrH/NDM=
X-Gm-Gg: ASbGnctTfT85fy68kxqmmdjXdTYiV62+eM2M3sz+EcMVIGFLJ0fgXfmxoxAsxTahokq
	h4W+UVryfHYlFGn1LyYCvBC6DYJkG7wmaic3ddgYv6Jhos45SPfdYutoxLhPVuHXgKLUmFxtac8
	whf3wTLTK1g8ZS4IrXoG73jyzHFX0ibXIpyhLOHzpDxlj7YH/5gQO53+pvKjpfJz1Qu9a/de8N4
	e/ZqAZrndZcAF1HqGVsOz8hS1ArzWJN2ZqXZ0woG+uWIfTt+W5BPK+wr2w+IGFmNbZFv0Gzfj3l
	MQPMspzgrddmjlT5ReiJsaEyf2I3Jt4ZoXLrf+EGVnsymSVtfj+a67sNBETdcWD6AXPi2lTWzxt
	wcjLCPDvaj4c+hg==
X-Google-Smtp-Source: AGHT+IGQaikK6vNNCjPVJeuplJDKBJe3N+BOuc4E9oBGcfkuiKRHIvOyik2Rqu1v9UYf81SQNtrIpb/0+IN8q6el/3k=
X-Received: by 2002:a17:902:d4c8:b0:297:fe30:3b94 with SMTP id
 d9443c01a7336-297fe304a7fmr17893915ad.9.1762683915716; Sun, 09 Nov 2025
 02:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027200547.1038967-1-markus.probst@posteo.de>
 <DDVLMBC40199.2BVFYHDGQP4Q4@kernel.org> <cf50c6db2106a900f2b9b3e11e477617d8cbb04a.camel@posteo.de>
 <CANiq72nhhji-cz2T2Cg9y5AwUwcc9q1Hd=-6J=6TafaxcHZHeA@mail.gmail.com> <d0f1effa5352959191ea8525963e84a832026dee.camel@posteo.de>
In-Reply-To: <d0f1effa5352959191ea8525963e84a832026dee.camel@posteo.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Nov 2025 11:25:03 +0100
X-Gm-Features: AWmQ_blh3zXPBDBa2xOppsa0rLUtvjo_85ItJVX54L8bAP5DoouwDP0v002pXaE
Message-ID: <CANiq72mmb7oH_3bj8_EwMA8RGg6M9TjWj+ebbaEQV-RxLx1iBw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] rust: leds: add led classdev abstractions
To: Markus Probst <markus.probst@posteo.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:49=E2=80=AFPM Markus Probst <markus.probst@posteo.=
de> wrote:
>
> Could you please clarify if there would be other responsibilities to it
> than code reviews and adapting the code to breaking changes from the
> LED Subsystem (I assume I will be notified in that event).

It depends on the case, e.g. if the LED maintainers prefer that you
manage your own tree and send PRs to them.

But, generally speaking, a kernel maintainer takes care of a few more
things, e.g. triaging bugs, fixing issues, tracking patches, deciding
which releases a patch should go into (backporting), etc. Some details
at:

    https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html#=
responsibilities

This is not meant to discourage you, of course -- being a kernel
maintainer is a fairly unique experience. Now, how much it is wildly
varies depending on what code it is, e.g. how many changes go through
the C side, how many users/callers you have etc.

I hope that helps!

Cheers,
Miguel

