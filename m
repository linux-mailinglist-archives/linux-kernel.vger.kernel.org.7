Return-Path: <linux-kernel+bounces-856350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F23BE3EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27BA24FB201
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828BC340D8D;
	Thu, 16 Oct 2025 14:36:39 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB82D47E0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625399; cv=none; b=RvoYu6Z9ObNHbeQIHsNypbPc9kNIgaeTWb700l/yukmcFe9fTq4O3S7DejSP9eXY8K9V0B3WIiT2yn0+GEUf8SIAfoh7VL43pjxoWtYx/VwgosvQrcRzef+8pp6zixVWiBOtsH7DOzRzg8+ZfNSufPyynkJbkWcIsgu/JIXnVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625399; c=relaxed/simple;
	bh=JtiFr1lfFip5CCoHK1c9pObM6nRvuG0oTh4JpnGVCOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLR1LJXGvjbB/CAIF83ovG4n3kBmGceybOfwdkBy7IB0b17RXlmXU3K2Fky6N8EUvakTiVISmFJYjRP5OzUBvIsyfj+jmc43AXgyBzWsTdfOQo8JbBtSt4PwGDJieKsJvSaqkAUfLQe3zPElSslOBAo3JtfALQjawVf6oCr2TjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54b21395093so513093e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625396; x=1761230196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVQhekYxGpPKLazc3W0RRSQdJSktpe1qJ4nKjQm0ylE=;
        b=aFC9xD4zEUhpj+eVPBCPjtPUmziUo3QKPwC5ynmcvCv8puSfFMka+kmTtI3sfzV7Q+
         ZUwWKTFYiHYwaYj7JRrYdvOkrkpGs8Ku3tB/K0GszlRijC8vsh2ZzpRWU5f4SBqDYiHr
         lsWCF/UduIW4JTI24EIOlrDogQiNKgvuwiN7Et7UAJoxx0TevaPYFh2SivLEJUAjcaco
         GWzSdxmlTcuLeSBes/u43eHGhXhLfhHF4weKpbw71tZVibRMnjV2fEproZ9197tS56g+
         T+b5S/lGLrRy9mYuZYdNsndrDmbC5dxGl+vhVLaoztQudyW9tl8A6e2IbFRXozHVPfj+
         N1KA==
X-Forwarded-Encrypted: i=1; AJvYcCVqJCOVz64EB47ZD1VA0IDSr9oOuXkbSaSD4jFfmFXoK1z9Y3p8L5PIt0uj9PNh2Sayx49ZC21nPfilmzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+Z7ViC3DBWI9rSHQ8i3cmhg65+gDSx5N9DKigvQezoLaCZkh
	gSbCSYjqUTk+XEKiP5g29SSL5wSZuP4DbTAhM9ZSsCRZs5a0aLnVxLEZSZOnEm5v
X-Gm-Gg: ASbGncvo5NyGsHgUs9zbzeHQHw6sx2RPfIRU4sWckBilj9atQ6cBxHeAWzToocujKEI
	09OGRjyc0/HZO587yHbZgn1pPGPK3RZf838Kp+W4W9UFDDvlsgUXLYGz/RttfhRA+w0cN/+raPG
	LAr4TD+yYHwUABn0Vej+FSscXokPFGE4vnvT3OZgEg/Xm0+/58/7ILU28Yv9cpz5moFz2D/7SrG
	ZtnGVQePKXaoK+qUvkNSNFPEDM39YxSN/HIMgLpzuougHOmykQhWz0hByWCTMMGi6bhes0jvmUN
	mPgZyVMOwUCwemRfgNLyr8S3qusOQcSKZdDDWadIW3WlkBOrZlPytGruydADR6FJO3L05o5Xtcs
	G6EAaQZT68KurrtVfyoSOqCnRMYYVNx+QzLLOesLvuMyUeTA3z2dlc9Wfl89l9HnNxLsMTXeZ5h
	OBuh5MHxJQrW0jbuyUNxHEhrwa0KIUtn902p6bGz3ZyQ1eftJAN4zJ
X-Google-Smtp-Source: AGHT+IFhbwVT+kfarPz+150ZNLTeov/aIJ/kWVE7Ex10YtCvqs1wOf+sgMWuxjaG75oftM7xE8vQeQ==
X-Received: by 2002:a05:6122:1695:b0:54a:a782:47d6 with SMTP id 71dfb90a1353d-5564eee8ab1mr232706e0c.7.1760625396047;
        Thu, 16 Oct 2025 07:36:36 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a38ddsm6022005e0c.16.2025.10.16.07.36.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 07:36:35 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso1751889e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:36:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXK4HvJrCSWayNZctnHc1kP1oROejPO7+dN2kSeZ95P9YaEf/QyFC9krlRPoww1sYNho2q6amoBI1VIlL8=@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:4e5:8d09:7b12 with SMTP id
 ada2fe7eead31-5d7dd561de7mr291034137.7.1760625395137; Thu, 16 Oct 2025
 07:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org> <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
 <20251013192103.GA61714@google.com> <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
 <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
In-Reply-To: <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 16:36:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
X-Gm-Features: AS18NWBYBkPaDTD1IE_FVtvCC_5e0spscrE1gzoktLGiMPWEWcHRJ_XW2mFbbB8
Message-ID: <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeff,

On Thu, 16 Oct 2025 at 16:31, Jeff Layton <jlayton@kernel.org> wrote:
> On Mon, 2025-10-13 at 15:37 -0400, Chuck Lever wrote:
> > On 10/13/25 3:21 PM, Eric Biggers wrote:
> > > On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven wrote:
> > > > Hi Chuck, Eric,
> > > >
> > > > On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
> > > > > Eric Biggers (4):
> > > > >       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
> > > >
> > > > This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
> > > > select CRYPTO instead of depending on it") in v6.18-rc1.
> > > > As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
> > > > defconfigs that didn't enable it before.
> > >
> > > Now the config is:
> > >
> > >     config RPCSEC_GSS_KRB5
> > >         tristate "Secure RPC: Kerberos V mechanism"
> > >         depends on SUNRPC
> > >         default y
> > >         select SUNRPC_GSS
> > >         select CRYPTO
> > >         select CRYPTO_SKCIPHER
> > >         select CRYPTO_HASH
> > >
> > > Perhaps the 'default y' should be removed?
> > >
> > > Chuck, do you know why it's there?
> > The "default y" was added by 2010 commit df486a25900f ("NFS: Fix the
> > selection of security flavours in Kconfig"), then modified again by
> > commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V RPCSEC_GSS
> > module dependencies") in 2011.
> >
> > Copying Trond, the author of both of those patches.
>
> Looking at this a bit closer, maybe a patch like this is what we want?
> This should make it so that we only enable RPCSEC_GSS_KRB5 if CRYPTO is
> already enabled:
>
> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index 984e0cf9bf8a..d433626c7917 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -19,9 +19,8 @@ config SUNRPC_SWAP
>  config RPCSEC_GSS_KRB5
>         tristate "Secure RPC: Kerberos V mechanism"
>         depends on SUNRPC
> -       default y
> +       default y if CRYPTO

This merely controls the default, the user can still override it.
Implementing your suggestion above would mean re-adding "depends on
CRYPTO", i.e. reverting commit d8e97cc476e33037.

>         select SUNRPC_GSS
> -       select CRYPTO
>         select CRYPTO_SKCIPHER
>         select CRYPTO_HASH
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

