Return-Path: <linux-kernel+bounces-859586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9877BEE05E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B69189CD42
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0122ACE3;
	Sun, 19 Oct 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccTdEhIo"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719D22836C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861464; cv=none; b=bCRGXCcRUIWnSA5hoo61HVJFxhBAS2V5XqgL5NvzLviv2aiwErKhOZOVfzdpSozUVujlH77eoCubilVjTME0Ic3vHTpoz9fBpuhxTV9u/RSFcqblB6k09MPuuOEXTKrRBeyb/Wx9rUU+6A/dqiW7rDXniT9BjOEgk7TBRegmm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861464; c=relaxed/simple;
	bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJm9VnC0K0rJxXUkvx8veGGyn3W+wTE3l2gYqtGQ0ybm5JBtQbPjtaxH2B/JFfQEDDu6QEfJH6PkSlTZUO1V4BVwtWPhfnZ/+z/IFwiwVX9ouZCjKmQwOSC2BN1plExZLpluZYWKVNfULnx3jTYP8z7+1G79BdzeLfsDwqPbNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccTdEhIo; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6353e91a04aso3531565d50.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760861461; x=1761466261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
        b=ccTdEhIopdhypwI8L3JBil5M4STne8SmRaQFfCBM02l9LkTDCeY07VksMZS734XIYW
         fSr9E0vMaFgWvM5hpUfvHCdQwXqN1rLdg7uGpCmcE1a8p73wsSFiGM9KgaCUVorU2bB4
         QXlk0k/rKjfCpslj0HWJBncYE9y9o12Mjtf9KUBJxsuzUFBzDISvTP/UdlOzuowk2O9I
         i6m0bPW8oTEyUXCgLGFGHisuLGD8VhQ1MKnYlEu61P8OxgXOJsE/nO9c7FNSYyLg97yE
         4ySn5cXO9k6TDK22f8AGkED3Ks52VuOYFicnSfjIjvJlszMjZfsukHxg61ULY8iC4TUN
         9kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760861461; x=1761466261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
        b=TBKY8OWbGdZVQoE1LG1rLVvPie0NwI1YKRwDZaRXShwXyr/3QlOu08gtToRJxtslYs
         ueAjFMOZTaJE+Lsk6E1wJcpjZTT0WAiVij1AN0LUUKzUmgec6MYnb6W86Y8yf9/uS5Uy
         8fWBq+3coqhW6BPatdWaf5B5uO5SfXfPCWfX2AIbYnl0snYIxUtKHiM+U6IT8i6SB1YR
         Wu0F5GclHMDzdzdofqYVPqgr5v+cKga9zbvd5Y2dOgMYGDA1qkGDaBZGyLWKG0Q+zbjY
         pXTFoT9u1GFE+il3hzmJDAk45gIMhUAbqDgYXSqcicrji1NveN5ZexxYbNUEH0xl24rl
         lhKg==
X-Forwarded-Encrypted: i=1; AJvYcCUS20XWVxu7Ob2goelA8UgsCPjtr9810+qVdko6anVeYkTobN2irO2d1jyZPBPaL9HIgzKrgLGVot55014=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGvmCIAx1iEBe+UfFKmkuLGNmj7vECnMQ4oKX7sCemIqGuc9G
	637FSiC2hrxVWkro5gRZ2OIrH4VEe/wYPOaY6elJXVF5KMv1Tdcca5qzfDQxEAZ1t1jWVsejJib
	Gwk9gyQKotoqifbGyHbj8L6Ygtgnlkjg=
X-Gm-Gg: ASbGncuprGpuWBHNQ7gi1CeGm+YfhhmiWRMY2yabBI5gfRSTuZIFvxGLqLgcBbsKel1
	UlaxRFyUBCzYDYoDQHLafXMwpmHIxySp/w0QJIGViPPHqp8VjBd2ShLfjBeISCdn78nNK7yjhJa
	yTalHaY7xcDN2LV/R2U6NeRIJp8edGTs6KeLsHKSAhxst1HFIGXVZmg+pd7RMCddA3vka4+9IDs
	7Ql5UuTWA64nTAgt0CIk6VaLr3UE/QT4XoivwkSP9sPbWmpdQgSB6CsyvDLul8LTaI5uZ5dxOo=
X-Google-Smtp-Source: AGHT+IEDp/usYEtVSaz10lwwm2/rh8YYcBuxag2F0nuBjSfSMoio/EijPl9t2f1PGKCDHr/mRoxnx6oC2CKJ7h3r2Ic=
X-Received: by 2002:a05:690c:31e:b0:782:9037:1491 with SMTP id
 00721157ae682-7837780ba2dmr109813007b3.42.1760861461100; Sun, 19 Oct 2025
 01:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202010844.144356-16-ebiggers@kernel.org> <20251019060845.553414-1-safinaskar@gmail.com>
In-Reply-To: <20251019060845.553414-1-safinaskar@gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 19 Oct 2025 11:10:25 +0300
X-Gm-Features: AS18NWAhDVf2aU8hB0qWERPwO9zi-ils_dPukaoQchmqqRauvEb3B93Zz-69KFg
Message-ID: <CAPnZJGAb7AM4p=HdsDhYcANCzD8=gpGjuP4wYfr2utLp3WMSNQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] lib/crc32: make crc32c() go directly to lib
To: ebiggers@kernel.org
Cc: ardb@kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 9:09=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Eric Biggers <ebiggers@kernel.org>:
> > Now that the lower level __crc32c_le() library function is optimized fo=
r
>
> This patch (i. e. 38a9a5121c3b ("lib/crc32: make crc32c() go directly to =
lib"))
> solves actual bug I found in practice. So, please, backport it
> to stable kernels.

Oops. I just noticed that this patch removes module "libcrc32c".
And this breaks build for Debian kernel v6.12.48.
Previously I tested minimal build using "make localmodconfig".
Now I tried full build of Debian kernel using "dpkg-buildpackage".
And it failed, because some of Debian files reference "libcrc32c",
which is not available.

So, please, don't backport this patch to stable kernels.
I'm sorry.



--=20
Askar Safin

