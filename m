Return-Path: <linux-kernel+bounces-843001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B76BBE2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B94EE8BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BE2C325D;
	Mon,  6 Oct 2025 13:21:09 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9682D060E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756869; cv=none; b=c99aXz1f56tB1ZFTVLn8pNRterJ2m/18THAGIC+BjonaYLc7M4+JKUhCRy/8NwoUxN7ikwmIE173AR0+2aFc1uQH/3qew4HfJR21g7Psllm6zmnV4QTPrRD3FzsPeIM3jjBt1r5zOCXlp2xoH0CblzBGSWNFPeAxHXmRLBD/vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756869; c=relaxed/simple;
	bh=KMVP6+NUbnV92gLmdFQjNvr3c1BiPckine2kLw4OB/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVQkerOZWvsW3YazVoZNOuajNy2lv6oSGyTj/3zCaGdj2h8UXiR7wzhCCsOM0g98yYS/8iiq1/jCwCE/axV6lBcOGZRVFsGEgfcOxGCgBbJhTA1ZC5ffu2+wc+3UKF2cNefkumUMudUZEYcD0YLrXlHJK/eLVNo56zZccGY91ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so1549947241.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756866; x=1760361666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuRqoxklPAOlbd1RPrmnGLCYcdAv9gdZsGWxssDdsVg=;
        b=rs8Cbqoc6UA3RLvJ24/35OCrmzzIfZInKYN5l4aQ9i1s7FHEKj5J6Umc2gUd5R/yDg
         8KlJwnuhv0uxAGWKpl+No5qCNm3q9MCmzsNNpJw90DFqCFNHUtEQOrXMj7gml1ntrrJE
         fJuhoZcjRMPm62qzCaBPKNCfKFefN7d7LO2w5VXMrjIPXtEnqu3S2XpKtOO0go569Nz2
         QLTlkUQcdIbJKfjjU3DSa9pss9x20DKBjFmHHTNUxL/iUxcB9JvcYJSBQ26+spBpChMQ
         4PX9nnLFV48wMoEvcBwRWwCi7Yo8SdWLMkUm3v3RfvY/aVR118yY3YDtJULqdUAKVUTp
         IGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZU6Hg1p/u4BDJsgTuo0dt/v4pQJem7DEnh0E80XsUdcxKwqfOXvciJ8W0NZ65FWvZqTLqGY/AVNukI1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBobtutK07jJtF97ZO/aJDStwfGER1nwSae51+eRwcijVqWIBk
	8UqKleTA5KEcqmdBwlEsMn8SCVpYi5OGpOcDux6RVPnNRzN/idueRZxQS0Cg51gT
X-Gm-Gg: ASbGnctxK02XwG34OOHjgDfz/pszUpQpVLWkQSZtsgQ4ITolGI2Czk4DUZMAF8RbbVQ
	+ZneKmGC6CPsKPw0WGeuAs/xJTcohl4+S3bvXalg6KMTrWavmONuzCEgjCzbbVX4SMFFbUU0gVB
	esS4+Pyz/u/vfaJkSDFbngEW+jsLFECNqzk+9PJSoJlItLc9Mi2NdSUv6XgOpGKcJqs5ZbfEmng
	UlBRexc5sJbGBzGUlZ5CmvYnoO35BfyB0u6BZn4mJ58Fk+OXYQvz6Xm/3PwhYPAYO6ePpglJFQe
	pSTR4gYlJbRuoOn2qePzogJmzKY8V2nMyMt7El7vmXwp/3MbduoMlwj14jPJiNaIyYl7MNoP+v+
	16au1cjG5Lbonudam+gnsUZXUkQlpkgj8OZcpGvpx4JPKONRpvnxxgt/oFaQvMke4MgmEWBh4M7
	Bex8y8IBUM
X-Google-Smtp-Source: AGHT+IF/zTR1WPQRmV5t9IXvuo3KHmewRzJ8mcYtP7JQDDif4hhATLmvwfEZ50F1D2ETUGM9RqhTtA==
X-Received: by 2002:a05:6122:4f82:b0:53b:1998:dbf5 with SMTP id 71dfb90a1353d-5524e85f1dcmr3297640e0c.1.1759756864985;
        Mon, 06 Oct 2025 06:21:04 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5549ab319e0sm660468e0c.0.2025.10.06.06.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:21:04 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1647912241.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVm41d7VuL28sJjKVrrDRBKRynnO/bzwVTtt+bBtDQ+LxDUgu6WjrZKF783EmM1W4bJ2weNiVdSUI1XX54=@vger.kernel.org
X-Received: by 2002:a05:6102:442c:b0:529:fc9e:84a0 with SMTP id
 ada2fe7eead31-5d41d17bfd3mr4212837137.32.1759756863544; Mon, 06 Oct 2025
 06:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <949f096337e28d50510e970ae3ba3ec9c1342ec0.1759753998.git.geert@linux-m68k.org>
 <mvm347wjj90.fsf@linux-m68k.org>
In-Reply-To: <mvm347wjj90.fsf@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 15:20:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdeJ6Bq=zA7QcN82YNaZW3R8ebeXpGzqHus-KPkSj5XA@mail.gmail.com>
X-Gm-Features: AS18NWBaXdKwIk39XXp--4bSlHAuBircfzV6tgtSqOZ0QwIv2ppBEo2LZ9edH4Q
Message-ID: <CAMuHMdXdeJ6Bq=zA7QcN82YNaZW3R8ebeXpGzqHus-KPkSj5XA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: uapi: Strip comments before size type check
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-m68k@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

On Mon, 6 Oct 2025 at 14:40, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Okt 06 2025, Geert Uytterhoeven wrote:
> > --- a/usr/include/headers_check.pl
> > +++ b/usr/include/headers_check.pl
> > @@ -155,6 +155,8 @@ sub check_sizetypes
> >       if (my $included = ($line =~ /^\s*#\s*include\s+[<"](\S+)[>"]/)[0]) {
> >               check_include_typesh($included);
> >       }
> > +     # strip comments (single-line only)
> > +     $line =~ s@\/\*.*?\*\/@@;
>
> I don't think you need to quote the forward slashes in the regexp.

Thanks, you are right!

So far for not just following my instinct, but looking for similar functionality
in other scripts like scripts/kernel-doc.pl...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

