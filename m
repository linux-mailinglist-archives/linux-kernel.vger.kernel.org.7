Return-Path: <linux-kernel+bounces-824840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D2B8A46A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81AD3AA5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F1319616;
	Fri, 19 Sep 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="xbo3W1UF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2F2F83BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295506; cv=none; b=Fgcca9R476DIqVk/8l0TFEJH6pacnS4xyF+LlWw6mMIorUjPch0uvXC3uqYk1c8BSFpC+i61FywoO/cr+83WPH8kKHk5DQkdb66wSZtKgLEqvUCCgMeiuMWgiQ1lUz8CEn4PwTUOSMu40EORcyh5jVEksprIsETbufcCXjM17Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295506; c=relaxed/simple;
	bh=tIBWHHOOKfm2qL1G0oNEg1lQ/EY8RTTkm2B9w+25Bvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLjiJLJuoHOndvuLIs2yo8Sea5MU5iKRPsLLNu5XcDFdhZMoZ4/iSx44O/s/F9JHssQDbme8GKWu+FK5CA4c/24jL4XL9bU3Eb/elCPwAH0jCbyv1/HYFZRhV19Lf6tck8feXqYdISgI6K+3Jpns0QnRF+A3XPb53N/UgI4QBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=xbo3W1UF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57afc648b7dso342244e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758295500; x=1758900300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EztjVQ+y07YMfegmHOd0VyK62XkODMWu0LdNE29WAS0=;
        b=xbo3W1UFpKFkZ1p3cmir9bHExoubmn+zN65uKZIOYM/VNr4k3So7pYfDI6mX/D9Xs7
         tKrFxrKGsa1OUV4/BaJm81tBW61J4ZGYYxqxZFHL+2WJXFRTEp/mhXDIaLf+cQRcgUXe
         AYqPNZvLbxLN1AyYo7ig5n8eVxO+iPi1huE+4hW6lV7MZkf7YHIdjHXfXdto2VLmATJZ
         knqRg3MYiebrHRGL5TV4krfrv3EaVDwqo3YKPYYlEuRSeFOsywbR4G16hcwfzRVUvkmK
         +8rrea1TuR59LvTS19HlGLqGt+kLHJ+F5+322OVOV6/84SIcgYqHnsi5cc3ulWFd4ja5
         pnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295500; x=1758900300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EztjVQ+y07YMfegmHOd0VyK62XkODMWu0LdNE29WAS0=;
        b=ADMSF+MdXiG6w3zz9wbnoeR/D4WqsxdCm4qYUGWuWsYfJPl7/KjtCJKZjtymp0asce
         cMnThB43Md24ASnOsxKj+VPLhU8nyu/ZmMM0kEYhjgSJVIAJTwjg3N3r0X6STf3ZFPjV
         iD0aWI9jwz99fW7DgsY5stjZNOSoyxE2N5zOA8Q+wr/oAUgmVfPZbZQYsXxvwmRym0EB
         WHrFgIeuSWa22O4p2DGlAzR79FJp8mebl4d4Y3aEDOLSWrI3WTaVFJVyxYv2dTgz3vIR
         KZ1MNzbTeouFqdL/DGfTuc0X/mUBxzNHUZdjy4Uy//tNwMKuWQFCvvncpQM27b/YCaPm
         o7pw==
X-Forwarded-Encrypted: i=1; AJvYcCUBwfz4GyrsnHx+fMxBw12XVJzIMoPYLNXabXKblnmEhSktarWyt4sKNO9fhZteTS4Z6Fy9hyqQutjwhqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1l0vcNbzf0Gen2Cua0/jtXQvcPlKvZeRkQgfv6vABPI2+m93
	9HSWGW16amkagCdeLb3w8daaE8PGWgIl0L8dooUKH66D8msxNOxfcOWY2cuBrIlAQPL02gcFWyL
	wxi4I543qc3oUu65NhN8I13KHkzI+0Hj8w0QEyOE/sg==
X-Gm-Gg: ASbGncvnVpHfRqnMo5pqJ1Qssj74BtrpfJtTe5lmcwc5T2q5cZXle9899iXMvM8dSB9
	d2PuHOWYUKIX/fOBZrpWbF7QwyR21DjK1fntjkSZ923yR3SnSeqTlELa4eciYe1jsTbybJlVY9n
	35eEGff/HSMO6v/JtGsXIZ632paxP8mj3KUiijajg+hnAkGCm7SKSUzY7LC0L1qzFbfgXamZ1zr
	HmZ6rpJbAZxJ3Y=
X-Google-Smtp-Source: AGHT+IHin4gQus9SrkFEog2pTedfunr2Ers950l0f82oxrEtfjemfexmsAorW/Dsqdjvay/GpFMt6pfW/hwC+qBHF14=
X-Received: by 2002:a05:6512:2c0b:b0:571:b70b:7dbf with SMTP id
 2adb3069b0e04-579e2507c81mr1455897e87.17.1758295499599; Fri, 19 Sep 2025
 08:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
In-Reply-To: <20250918195806.6337-1-safinaskar@gmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Fri, 19 Sep 2025 17:24:48 +0200
X-Gm-Features: AS18NWBwMqIXE_dMXDlT0ngUIReSbekPPTszWv5gIfg03bAEg3Id33JL3Yqjedw
Message-ID: <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
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

Hello,

> > When booting with root=/dev/ram0 in the kernel commandline,
> > handle_initrd() where the deprecation message resides is never called,
> > which is rather unfortunate (init/do_mounts_initrd.c):

> Yes, this is unfortunate.
>
> I personally still think that initrd should be removed.

Considering that the deprecation message didn't get displayed in some
configurations, maybe it's a bit early at the very least.

> I suggest using workaround I described in cover letter.

I'm not too keen on having an initramfs just to loop-mount
/sys/firmware/initrd, after all current kernels are able to handle the
use case just fine.

It looks like there is a lot of code calling into specific filesystems
so that the initrd code can guess the size of the file system before
copying into /dev/ram0, and I believe this is what causes the main
gripe against initrd today. What is wrong with just copying
/initrd.image using its actual size into /dev/ram0 instead of guessing
it with the help of filesystem specific code ?

> Also, for unknown reasons I didn't get your letter in my inbox.
> (Not even in spam folder.) I ocasionally found it on lore.kernel.org .

Sorry about that, When I used git-send-email yesterday to reply, the
SMTP server I used wasn't authenticated to google, so all gmail
recipients were dropped. Hopefully this work better today.

Regards,

-- 
Nicolas Schichan

