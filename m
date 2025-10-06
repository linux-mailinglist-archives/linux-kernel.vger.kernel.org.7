Return-Path: <linux-kernel+bounces-842722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F167BBD64A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24F23B90B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB2262FD1;
	Mon,  6 Oct 2025 08:53:19 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053A1E5215
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740799; cv=none; b=r9ui+nxY+d/DBbwypln4T96JV50j3pTZ6d3NNsuSKaaeTAadPrJxR+430nTfX9r1vClGOUilHdfgwf+kHCn0HTmUi7lIrNpwpj7pJ2mUJEj0D0CCYx+mkOXOmuGjeJE/Pz2MAREkREuQLSXKISuWzhnyZQzSp9e5SgOWRakyFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740799; c=relaxed/simple;
	bh=vvGQ3AOEp78e5lN14Go+QxLRLFjUb+VFpeq/hZQsw8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY5U0McDO2kBtQVZ9FccQ6L/KxkECns0bw2MqIPAO8dLRyckeH5HwKi+uuJvoOYSpznqaRKDS6L9t8I/+SNdQbjqRpLfc9YXPnvntnBeuW/0F8v3abFibRfjXbs1XVSaJdsvltm5lgu51r/61VneljbSsw5L+6Z5zSEmThmEfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a0d17db499so4508787137.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759740794; x=1760345594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9r4pmCW2atY0hYHJFbkWjzhWu2NPZE5D10ci+sfHj4=;
        b=C60EwZ7bj3ap8TVwYX6zQ2RY49VDmIWl2goSUIK/4lMCrHQRzQAdZ4l/5OC9NMd8u6
         qArdfCjNSH/ByYaudA7Ccgtg0ajbRv9ksTdgtc7kzUQVMIerFdaH16i30v9iFw2mULrg
         DuPlY2EbK0Z5Aun/5G9uzEWQrjS6IkSA6acDUq85lW3KZU/6PXJir7piNZ4Z/S1QqBRN
         +kjodDm5YAbCiPbW0FwrxY++p9XaxA1sg83I+SadZrZzX4OrBFC76r34+MC9UrBGCq/e
         GepZxkSeWEPMPxORyWNYdEBt1RB7DE7IjnUL7nJWPlSB4Jder5oWrdsVGSk+My5MI6bX
         fttg==
X-Forwarded-Encrypted: i=1; AJvYcCWIBeNZbtC5HGtvYJeCwCtwY97XLwPOseulROFzjjVZlGaJzkyYJcaRgYwHwpV8afO+El6HTj3Ef2igM4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEy6gFCIVS5OwdL76R33QMbWHuBxtk+x5tgcxrTyXnikMvJaT
	gMSjRA+3/8e8i5EkeDbSkVO2sSAR4ZRgWj+TWKHACMD6RQVlVMOCyKl8KN7qC065
X-Gm-Gg: ASbGncu9CAbUkk7E1Jn+wiLf8YgofwVAO1yXWRUgoNe1aeYqAHCL9KN8SwZtinvCDNh
	7NxRg3+Glmtv+405Xa5ot9e18rb/wijcp/mxzMsTHMlBFo6Fe2NUbqJLcOlRrHpeR1hbqW0+vb+
	22gcFTmsm5aht1csWWoeFbfxh879tirI6bnYFdDLxj0NxrACeeOr5ZLYnMwKOJpUgnnMpBIsT+I
	UKTywRfmHdBuxvLCDp7y2Kd+YRkTR/bkgHNE25ofr/ZAMAncHh09lXEjGrWOXrNbwkGf1duWNyS
	URK89D/+nvm89wRymxY7ujDbAcUFgIT8JXbLnadBGrAT8RDF2dmrHH+BNev03ln774XAkPhnUnr
	lXPet3Wppo3ilyNWYi3InYISLlwPTEwKCdY65cZiGSx2ff2Or9iUsZi9X/03xPFgX1c+ze7RkmR
	flljmj/U1kyBkljcNjpLQ=
X-Google-Smtp-Source: AGHT+IG8pfpCoBsOjrnOblptR+9W2bb9HEyfTm6ZK9BsgHjhPrXxFuiCugDiECF25pZ1+Evz02bSng==
X-Received: by 2002:a05:6102:2acb:b0:5ca:a978:8a with SMTP id ada2fe7eead31-5d41d1728f1mr3926640137.33.1759740794537;
        Mon, 06 Oct 2025 01:53:14 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4d83b81sm2837340241.3.2025.10.06.01.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:53:14 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a0d17db499so4508776137.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXd8vqAT4FAfMkpGV2Ch8dGNWUCkv2XFAsqpFwZ/30YXPHII3PDC85yEIYoc/ppIFxd7JZDI4n503/YInw=@vger.kernel.org
X-Received: by 2002:a05:6102:1620:b0:520:c4ea:4bcd with SMTP id
 ada2fe7eead31-5d41d055f58mr4085607137.9.1759740793940; Mon, 06 Oct 2025
 01:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-kbuild-hdrtest-fixes-v2-0-8a7921ca3a03@linutronix.de> <20250813-kbuild-hdrtest-fixes-v2-4-8a7921ca3a03@linutronix.de>
In-Reply-To: <20250813-kbuild-hdrtest-fixes-v2-4-8a7921ca3a03@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 10:53:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUypDox5PRJPS1HBvQP=8+C79fx1-zS4w89aYGoM3PY5w@mail.gmail.com>
X-Gm-Features: AS18NWAmMoW487-uzM8xW8F4Sp_8IsJYBO5PJqrfV0D4Y_cOQNM9JCgQ1kpkdEA
Message-ID: <CAMuHMdUypDox5PRJPS1HBvQP=8+C79fx1-zS4w89aYGoM3PY5w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kbuild: uapi: upgrade check_sizetypes() warning to error
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, 15 Aug 2025 at 03:26, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
> No problematic type usages exist anymore.
>
> Make sure it stays this way.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Nicolas Schier <nsc@kernel.org>

Thanks for your patch, which is now commit c3a9d74ee413bdb3 ("kbuild:
uapi: upgrade check_sizetypes() warning to error") upstream,

> --- a/usr/include/headers_check.pl
> +++ b/usr/include/headers_check.pl
> @@ -159,7 +159,6 @@ sub check_sizetypes
>                               "found __[us]{8,16,32,64} type " .
>                               "without #include <linux/types.h>\n";
>                 $linux_types =3D 2;
> -               # Warn until headers are all fixed
> -               #$ret =3D 1;
> +               $ret =3D 1;
>         }
>  }

Unfortunately not all of them have been fixed.
On m68k all{yes,mod}config:

    usr/include/asm/bootinfo-amiga.h:18: found __[us]{8,16,32,64} type
without #include <linux/types.h>
    make[6]: *** [usr/include/Makefile:89:
usr/include/asm/bootinfo-amiga.hdrtest] Error 1

As this is a false positive, I have sent a fix for headers_check.
"[PATCH] kbuild: uapi: Strip comments before size type check"
https://lore.kernel.org/6e68ab921a728caea4f3f37bfae9b1896edfa97a.1759740354=
.git.geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

