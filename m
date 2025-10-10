Return-Path: <linux-kernel+bounces-847714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07137BCB7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE5819E34B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9DB246BB9;
	Fri, 10 Oct 2025 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPjRTN5O"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515C20B21E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066301; cv=none; b=P+NSNyfvXKF60l4UdVnmNYKSjV4O2vIEAC9hfYbfJLwQ7WpcQfGPvoWwTWXVitWlY143KAYNl4D5nMBii4SikD6/vFS7u5957aRmWLFySjFuYnijs+rz4aA6Mvi5zI+B8eR0pwfmjhTu0bERDXMaJjeOQ0zznknmqJFS4g20okU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066301; c=relaxed/simple;
	bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa4oMvv8RyP5HjYuLAWKMemuYgO4v5lq8bDLDd8fakzy6tvQHOM4zhV1bIRnWm0pxvq9UgV7EcV0s+9MbpJc8XnC+ngfBjvpnpuoxSvT0o7aZ0Bj7gpc1xyYBZZgZ7b9eB5b6ireSk1C7GfuMABKC7vjtPu8ZonBEcbTQ73564g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPjRTN5O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72e565bf2f0so17186887b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760066297; x=1760671097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
        b=TPjRTN5OIdK/OXusT04ct2sgaYmzHo4t4RUcO6PdWBlDAfEWtPUI7uWv35B1xXRQxj
         nWDps35hFTHMxr6Vk6M3zzXh9jL55JqC/Vtbp/qJ6kt/g1GOp16G+Bg7LB6bG1r+b641
         2GZAocJ0Y9aAfXmNH7ZbdSlkaY3855X9zXdD9dkM95xNJUS9OJ0kOfTN+fQ/pIQRx9sx
         UeR9ve3br8pXzxG5ySPUb1OPrdiaO3ghhmi6NZfYRnFFgvD4Pi0E0XzWFozMQQbypHnK
         0gPBMHcY8gVSfhZZYOScFt4tOJz4MKXSPhlAeobvvXhPaauJ7QzUiKey4bQvJhfYcTAm
         mK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760066297; x=1760671097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
        b=wOYG0upT7UMv7Z0IXogwPBtqIT3OeiNcwihRHDt+hJX/myK9Bz/9yvSDrya7EpqPqK
         Oz3nW1eqrAqeU/MUbSss2n8H7u+Rw6dMoSITkFEHGSdTvC781SQNwiTLuk7nUtnlGLch
         OwLHkmUXYc4c9lVgGbWuf+5Bx+L4CoSsKGMRB8EzHcB4gINUJRK+ib564uvrx667aqSy
         DPn9zP96C1NAIi11IRDyfa6ra1mldOOp3T22/3+XdJndm5lmLYjpYMllHMhgpnBhcUJI
         xJIZD2Dtug3e9HC8k4/hsB50J9WUiy9O0gBzYTKbUe7yEWCje4nW2I9mPDSeKTRNhEkx
         tWww==
X-Forwarded-Encrypted: i=1; AJvYcCUNWORJUmgmliqN1aHz/3Wcn78sCdccS7mmHBHmkU2m/ETCXEHe5DE9mziwcFAAyl7p5rQBDOMjBQc1GoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmRunLRd484UGpZGSUIs5fWFASOothDC4AJx4erTpozNwW29U
	QWxqNUlpGiGtTKSYMiCWphe8/5FA8pvyKX0Lyn0OVH2BrXuuyaE8AceYZVg077WPPe39/u6B+lm
	C2BcK963Pa3Fg6//NrBUKI8JtTQPwGeg=
X-Gm-Gg: ASbGnctQeGsSoEX2PmIj5ZPgjHu0d9ZRRTH3tK8qMqn04wk5a2tV+BkH2Xm5Dq+tX1C
	ZJbzj2xq4YWOgWiubvSg09vywDKeBbEQtFp3zWzdVb623O5SbsUgnNh5MHbP4epLLJ6JCn2bCEv
	Q3UCBS1AV9rMm6VTdbKXJL2NiTqtOaoA4ce+HBrHpyH62+ITYIHoLXZObMQSZ4OGjXkkAP8BllL
	uRhoC2EMP1ga/d8uYpTzjD7tA==
X-Google-Smtp-Source: AGHT+IFTQdXvlZxDoBIwCyChBgf2ijvKjPOXu3xyloDy3VewP6H31eXx2tdJ5Y2sZs04pWqa6kN09Zh4TAMeP3pYKTk=
X-Received: by 2002:a05:690e:1587:10b0:63c:e90c:a6d8 with SMTP id
 956f58d0204a3-63ce90cac96mr2654086d50.44.1760066297220; Thu, 09 Oct 2025
 20:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-3-safinaskar@gmail.com>
 <053f39a9-06dc-4fbd-ad1b-325f9d3f3f66@csgroup.eu>
In-Reply-To: <053f39a9-06dc-4fbd-ad1b-325f9d3f3f66@csgroup.eu>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 06:17:41 +0300
X-Gm-Features: AS18NWCm5nh3vfq5EIpD-J_OKHQvi_8uVbgLjcXTz6TnQl9pdn9vqNDRLNkppRk
Message-ID: <CAPnZJGC9avy1s=xFS5Tg6obS+RB3zw4yWsUBw9g=Vt09S6j88w@mail.gmail.com>
Subject: Re: [PATCH RESEND 02/62] init: remove deprecated "prompt_ramdisk"
 command line parameter, which does nothing
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:16=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Squash patch 1 and patch 2 together and say this is cleanup of two
> options deprecated by commit c8376994c86c ("initrd: remove support for
> multiple floppies") with the documentation by commit 6b99e6e6aa62
> ("Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"")

Will do in v2.

--=20
Askar Safin

