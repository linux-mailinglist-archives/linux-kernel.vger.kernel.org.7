Return-Path: <linux-kernel+bounces-848404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB8DBCDAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE4A5424B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D32F7ADD;
	Fri, 10 Oct 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFLDqTBw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE52F60BC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108562; cv=none; b=qPzdSo7W7hTifUGOQZxHz4xTL/29CKboSnJ2xcm/78uunpk9OaBFKtXrvU8O2Aq2x6Y/63XFzVbC4aZdD/GevknOw7qU//+jZmKrSYSpYouNBI9YTalYbsOYGukQaNzzBn7Ixdi4w+eLzD5qAp+1G0UBey90cON01kXms/k4hPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108562; c=relaxed/simple;
	bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StXXeTwxPXTFKEoeU3MWiXWp3/HsoHG8QyfmccWMfyfWA7PoMhLwjffYWfjzUAyQVuugpWPLqBI7d4DW02sxSikTB0Bq1xgFdxfxkDFZ9IO/aNUPLOJUNgqoq/a2YG0zrEPNnhFrf/MfKVubb90tgKqk6tUXgK6yOX0P7r8COuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFLDqTBw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b48d8deafaeso499244666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108558; x=1760713358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=aFLDqTBwDW9/tslHGMMpz/fDXm/8YFeWeEqOIcghoh/WbHIq4K/0SzxFSFr2C8rGcg
         FzfA6mauz29MwswTSj8YO3mq3cxhh5u7GFdf5ExSSfl6BXbILBg23XGuvlNp3mANuW6S
         eel9qNFJhrnpSPxNuvU8zfBQImKbaXpPm7yI2z/z99IQuraI1weEKXaWKAoKN2dn1Fia
         VeA9V8C1Loi2AzEhqtTtkmVxXU3/XSg2XO66Oqk58zTi4gP34AT/wGmHBqeZyuMiW54A
         2nUtDEww8Cwcun3qpGWQvCqHEXtidVmA+q8Oy3lJypcr/DIo7Im2rac59BUjorWx/gNF
         KEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108558; x=1760713358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=QTNIYr40xZB/a8P8xyP+a3bLRPQMBzmO6TIWjVFNIbZOAEcrUT96YyR4CfdMZVans7
         6IkEiWaOP+zcHtbmJ5kRHIAFOmsfk4/zExW87QBzcDBYlkD/69g4/3w1YZxosrz0ZqxY
         +IYDKUM1bzgWtkTjUw49yADcamLX+QfGJDgxab4/pMqnrV3h7+7jl9ZWU1E86BnuG+/f
         rgtrhPyNzRXuKZH20iGlBVFFjjRyKl+ws2QL2IEx4sMJOZNEGl2aThISrA58XHISV6Zj
         aZAK/x4a7yvxixR5SXtnnLu8oSqFj35YzH53Tq+gi0rxL6Gx5HLvEW5lLWgl+HjrkIUS
         T3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW7DbIIB70NWWBzaL3+bmDf7yyvYnhaPU+hxcOF/u/gbqq9uqDmMXA8j+hjFWD6C2DpdC6MpJrALPGEHfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4n4o+USKDdHVTqClyGGv7Gy58GiAycX+AKOFKANY3cIkN7hg+
	Y5IkiB5qKygSrNrsDAt2TwjT/7javpCyXwlQyYDi8cJM9+ImOLmuMmvu5brCQja/GRsABjxgUET
	IWSGTCa80Ez9pLn7loHj1PGdAqkhsE/0=
X-Gm-Gg: ASbGncubohre25jLfxfbIr+0454RWA7WibJT5QdAztTFCysMEsAcyIZfAhlot2fGDD3
	L7VOzBo0s9S3NkhRywpRWObn3sfzBLmVmd8Qixou2+Uc2qE1491ZOIkoOxikq7D6OO8WTIHdxlq
	J0VgAPX1QtijtoB7rrV/Wv0rVAD4XP0Tetpsv5rutNhtfLiKVDk3V/qsnXTJkPqWfZHWx967zzh
	2rVwHIsI5u+eXB9k6iIs28Y0Q==
X-Google-Smtp-Source: AGHT+IGa/polL6/8Ynsft44cUD0O1NPKwafCC8Smc6nmBnm4TDK7NhR64Y4hIQgBMI+z098vLRzD8f+sU8sdugojvoo=
X-Received: by 2002:a17:906:c104:b0:b04:9ad9:5b29 with SMTP id
 a640c23a62f3a-b50ac5d1e3bmr1407180966b.54.1760108556823; Fri, 10 Oct 2025
 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com> <20251010094047.3111495-2-safinaskar@gmail.com>
In-Reply-To: <20251010094047.3111495-2-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 18:02:00 +0300
X-Gm-Features: AS18NWAoVP5WYC_07QqSXrvsFY0nBG5PiGs9ESaeN2ZfR7dfSMsKUbHhpVYPARc
Message-ID: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:42=E2=80=AFPM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> ...which do nothing. They were deprecated (in documentation) in
> 6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
> "rdev"") and in kernel messages in c8376994c86c ("initrd: remove support
> for multiple floppies")

With all the respect to the work and the series I have noted this:
1) often the last period is missing in the commit messages;
2) in this change it's unclear for how long (years) the feature was
deprecated, i.e. the other patch states that 2020 for something else.
I wonder if this one has the similar order of oldness.

--=20
With Best Regards,
Andy Shevchenko

