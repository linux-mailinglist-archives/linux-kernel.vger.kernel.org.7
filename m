Return-Path: <linux-kernel+bounces-827420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613BB91B72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39256425568
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4D1EF0B0;
	Mon, 22 Sep 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="T5tm19TQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF9223DFD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551351; cv=none; b=rXDBNUjl8SD4OnI4Pnxt0JuZqcl019dEg49MDEamL2Af1RkID7xG/k9RKcSi3hGSz2zkDo4GcZodDqplgOlL7MMRTgUeSGHDylVRoVlRvMTMdb6TopFBL+e3/hUye8Z0JFZn+P7WrlDuvQWBidgfGp54FL4vjAF8nt/88YhcKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551351; c=relaxed/simple;
	bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdX7rbLzNZUYZVkNiKvbh7EIMQ2Ae1/+NqHc28lzmTEViFXEGrErJOHzyKMflki4kqkZ/2C/tIdqgUktsmMrSHDXmimI9wN3xFnMBa7zz+9EeSiqr/3HO0b5kReBUcIJM0nzGqI9YKHBTS2frk54CyR59znzGUuJgh+tH5V4eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=T5tm19TQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso1580704e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758551345; x=1759156145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=T5tm19TQZikqjHqoMR54+Q7+U/JgAbrwxCDjAEr+j4BV3oKJ1vYACVblsq/0dgQB3O
         xzcE44eyHkSt3+1/LwS8iG05NDQybwpGXmErJGsX7qf1JoHnxQE/QJKsAyQCq5BZ8yUL
         fZfsv/oGGtZ7K0RaFe8fFXZtm3jS4C5jkLwGskUTTKy01oseY4elZgmJ1wcia/Nwx29N
         /akdQTqyJ1yRSFcBAOKV1BSGnn1RLnJEPHIfsiagl3HTh7OEmakPzgo3DZkunVSmL2Xx
         hH2z75SXfyBjFg0mXpIzvJjI6rXfLJCfOxCsk/r78caU8Q500JO1XsPO5Zy2dD22Jb+z
         2rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551345; x=1759156145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=e/qmO29gJhEFClqnaPmuc4Q9gmMhUaYi6rTspNgzuQifjwzO+lSYgPRpnA9ThDba1h
         bDJE/WWvXbdgKFgXaGQDj0in2hpS6gaXW83kILgE5WdAvxUIaSZ35f2Nvin250anwDlp
         K7KqJPUoei8FlbdKEXudWpkGlDizygofTnrU4lgsnQBi5MvHXSrCY/KovFu54L09HhaJ
         d61enKCY4AyRHxsDAU3HdxeZf8XrL1FTmIwNOdH0pK75dqE0TyhY34YzcqjW2zM9GMsf
         g+qL/mZqFqj5LoMweo3uJyZDCvSF0LayTvDqY8jMjICvxV716X+wNtfMW0qoi2xLc8PR
         pY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMz78K9yEjEHchGl3BJppsvfMArqWtHUCoV+lxFZEYNFjzWhTOAESLPVm2wsh0B2QSwuWkXfMumLyhnko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iswNr4xNBaifdTG//H1V3HVAXtStqB7nrAXhd89BmtU0m2AB
	caC9V0+8gadsyBKiXPcW9bjMFLCotySdpjeaUSnNhty25nrzIZtZ9NkSFNYyqzuOdBkf8yXkPmg
	wufvS6na5Dp+oKRG7OvJGN1qfNan33H3nXA7T34Q/iw==
X-Gm-Gg: ASbGncu6KBMox6ySgg59yZzoUPMoEJHr7yt3pp8wzkHP72jJXzz6Jv+e2SoP6osV50b
	x7mAnnU7YECRVwOkac806osFxDrXMYsqhhBvGs4HNhVFbqF0I0jp1Vg2jjKzo2bwQbxuLtttgi9
	GOpqwEx+DNM9/kzRK7cTWxCZ4j39G6pgV29sWHbf7wsSrYGWmxgfT2dTUqpjjW7+Majd9iXzAEh
	UMrcqnkMfoWY6s=
X-Google-Smtp-Source: AGHT+IF9Kx0YHTgWZximr8IphichwJGTQ/wmiFKfxBKU7xEPIwY53K1eZ5EsUZqb+vcW1xAllqgOcQU2VEEacURTmEE=
X-Received: by 2002:a05:6512:4389:b0:57b:478b:d8a6 with SMTP id
 2adb3069b0e04-57b478be162mr3313173e87.35.1758551344116; Mon, 22 Sep 2025
 07:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com> <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
In-Reply-To: <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Mon, 22 Sep 2025 16:28:52 +0200
X-Gm-Features: AS18NWBjmNA3KBj8cPrgwDAVm5OX9a5odWP7LbRlHvhoE96nP3yo2_PGoZ1JbG8
Message-ID: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending to the lists and Cc, sorry I initially replied only to Askar]

On Sat, Sep 20, 2025 at 5:55=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
> On Fri, Sep 19, 2025 at 6:25=E2=80=AFPM Nicolas Schichan <nschichan@freeb=
ox.fr> wrote:
> > Considering that the deprecation message didn't get displayed in some
> > configurations, maybe it's a bit early at the very least.
>
> I changed my opinion.
> Breaking users, who did not see a deprecation message at all,
> is unfair.
> I will send a patchset soon, which will remove initrd codepath,
> which currently contains deprecation notice. And I will put
> deprecation notice to
> other codepath.

Thanks

> Then in September 2026 I will fully remove initrd.

Is there a way to find some kind of middle ground here ?

I'm lead to believe that the main issue with the current code is that
it needs to parse the superblocks of the ramdisk image in order to get
the amount to data to copy into /dev/ram0.

It looks like it is partly because of the ramdisk_start=3D kernel
command line parameter which looks to be a remnant of the time it was
possible to boot on floppy disk on x86.

This kernel command line allows to look for a rootfs image at an
offset into the initrd data.

If we assume now that the rootfs image data starts at the beginning of
the initrd image and is the only part of the initrd image this would
indeed remove a lot of complexity.

Maybe it would be possible to remove the identify_ramdisk_image()
function and just copy the actual size of /initrd.image into
/dev/ram0. This would allow any file system to be used in an initrd
image (no just romfs, cramfs, minixfs, ext2fs and squashfs), and this
would simplify the code in init/do_mounts_rd.c greatly, with just the
function rd_load_image() and nr_blocks() remaining in this file.

I can send a patch for that but first I need to sort out my SMTP
issues from the other day.

Regards,

--=20
Nicolas Schichan

