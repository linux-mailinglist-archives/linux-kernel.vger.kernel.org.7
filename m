Return-Path: <linux-kernel+bounces-850319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE4BD27F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BB3A4F0683
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942F2E2EF3;
	Mon, 13 Oct 2025 10:16:10 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36B2FD1D6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350569; cv=none; b=l9RlfF0ouAjPtTA9uCADGJJthNHxaRxnPFfK/m07AZCkrTZ2FHA/sXqcEj4jsomvsrG0oSS2GLZJvx/gN9EHBTmG2c48ZWk+OgV9xDw1iauwNVHd8fbTPqvyFptHfrHOg4N90lNvbeV2E6F4bAu/2OQKBcaLv02zL+67flfK/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350569; c=relaxed/simple;
	bh=/dclAOZ1wcO3wJHRWYPxOk55bJ0h4fFw7TEM3TxPSYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1QYn5hnYPzWiLss68fjbwIl7DXQtxbch2xUrtP7+687bPO/62xMZmwScFVeVv9y6bXmNB4FV5nbjuDxWIV1a4rhc6LvX7bVXyadu3m2Eabo2Ca6oLLcxh1VEyPF1JZZ6cNmf1wxUgEjgjEwNcb+nCCEsn+xzN6xRfCFguzauBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-930c304d1a4so462496241.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350565; x=1760955365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxBrW+9YUunZwvYGyVKGYyAsVgwAT/0jNiWc372U3Fg=;
        b=oJ5bGcl7asd4zRA2jSMK0iXC5eh6rmWSegaH6sPYg7v76HMJZ3V1vTMzOp1IJd94GB
         jFVDaMmPNbV7svnYJ/WVfOKVuyjoAOSYPpEXXC16ffoQYKTgGemkVunZlFJLIgx/HBoT
         Dh+2RGq4RwgIsoYgEuzOz8y55rhR39v86oUvHPeLgXVzkSeduHLS6njDNDQIsywnwgWp
         nZDMCbv8nl3xR9I/CBMVQRur2jk/goTTUabDCBUz6fmZrkRQqs0CbRGU/e1hmGXSc33t
         B3ob4EJD2/G+ePpsTCibQYHpvonM7Gmhuk2ETb7193bzzJNDLmV3BT/fCGjuFDewT1do
         cxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVGWMkq+9jMfUtWTlNyQsNnWb8SdKYIBYBXtm/0Ja+SjenaZxGhk/eKWaN00HF0KVKTe60JrenT5ZF+Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuY/MUFQXt6b29ozsxat+xssSn4hAwdLEa+0A54/vBi+smF/2L
	rBqGdyh8QZgQXL79bkxLAeMn2zx/eKzTAxPx6aBUCpIfRuS7Hc4RtkUnFd7rgrPE
X-Gm-Gg: ASbGncv14iyqktG+3OhJEzYBYD4Qaro9Yos+KArVuZVFmsuk5Gc3aFipjYW6oteJaXf
	vKDQL3OrDCCc12/TeZIMzGMcGSx84QtFtMCj8af551XUHWqG9wrORO0SwtZI7KLxZbZe7E1sKmm
	EO1yxDxuIFkL1pHlk7rSjmq2b5svhyrlZem8zJPJVEPSQd68Fzw4960IkYKLPsEybmSCBzUzXB0
	mTmSCEP1mShcEIHLGd4wcs/2X6mbGvmEw/rL99xx3Ru1mf/WjHEEb5Bmp2wLU4+b8GZjSF+bskQ
	TwIo7EfCw/k28SbSU1JPpSuNg1yE5/S8BEkFumVBig21OcKR/vB2yqeY/ugJ6rRPFzbcCY40Vbr
	i9+tOdwrk6o2lxBnIJvJ45y2JA7biSzZcsVu8s8oiX7P9dP8XNpV2MeA3NcWlavJdVHdu8HHl/1
	5S+72QolSFK8qtuk0Ie4H9sKVcXPvt
X-Google-Smtp-Source: AGHT+IHezqI9tWHyrrnqYzxEx+bR1+Fzm4dWCn4SF+HNJzujZoHReNvKfMlP/EHiiTQINE/XAmRQyQ==
X-Received: by 2002:a05:6102:38cd:b0:5d5:f6ae:38d3 with SMTP id ada2fe7eead31-5d5f6ae3c87mr4319263137.40.1760350564752;
        Mon, 13 Oct 2025 03:16:04 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf6cec14sm2661553241.8.2025.10.13.03.16.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 03:16:04 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-91bdf1a4875so727235241.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:16:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCSzvkRDmjbsZEdofayKK9u/QynDfgHsq6WU7FKWvKqq85Uf2nCtBqS/qbnLB8Cd68iiUiVR2dXux/Zv4=@vger.kernel.org
X-Received: by 2002:a05:6102:4bc8:b0:51b:fe23:f4c with SMTP id
 ada2fe7eead31-5d5e236b19cmr7934369137.22.1760350564013; Mon, 13 Oct 2025
 03:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org>
In-Reply-To: <20251006135010.2165-1-cel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 12:15:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
X-Gm-Features: AS18NWC70YQ25pmV_8TDIyg3Sza9lycmcIj-QBQA-wQOcH5zOHgpO6WjHd-A4TQ
Message-ID: <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Chuck Lever <cel@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Chuck, Eric,

On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
> Eric Biggers (4):
>       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it

This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
select CRYPTO instead of depending on it") in v6.18-rc1.
As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
defconfigs that didn't enable it before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

