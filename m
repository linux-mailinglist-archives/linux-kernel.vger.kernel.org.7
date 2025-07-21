Return-Path: <linux-kernel+bounces-739558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C7B0C7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C4F3AF160
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11852DECC0;
	Mon, 21 Jul 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnqsLHzo"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2974170A2B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112486; cv=none; b=PpS5IMz63lNj6ANDXAQel3Rq8SlmLy2FcpWArkRCqODg2AL9GkGoaki0OMKtggZzZ7eH+vGuwzchiy24jaQQCmDyQSBjuNJHGRfsxszvKx0DSbzKzqzT6m9FpLtYu0ceIG6q8F0+du1Uhi1zsLgCdMZU3FD2hm2vAmSafSzeiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112486; c=relaxed/simple;
	bh=2o9+C79sHWHnm28cVIvxm1VXz4boTY06Y8oLYifpGRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDHx62zX3Vt8WjC0PO+Dr6zDDD/fI5fQEbM3TA78zxMq0/5CYevUZ2qSWN4rQjM1YheSmZ5M6aZDRDE3eYNTyV1saNdvpbbWdlqrGuGA2lY0RLSY0IxGaJ1DGvKDELjBP1YLb0ifGawVV6HkwBtsIrtwQbMOhgWagpO7JhXdaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnqsLHzo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso4664448a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753112484; x=1753717284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJyKiGyRBL26HASXyaOaTTKSeeWhDpH++Zw+V8xljqs=;
        b=JnqsLHzozLkiwv27MYurtfZS0GO+L2Kq+ZXr7hG2/JltLsn2MsATJvBa9XKiYqmlqQ
         o3weWQlC1HCTWfYY1onn9P462Jue4VhJNL0StxFu0EREZlu9N9RSFvkbv6J6Zxt4qEMe
         cSp4TH2Q9nFaqnCqm6s2d2s5a1i80niQB85LR5nHubdHOCS2Kt3xGcVgQYKc9mkd0ajE
         f+LkrIlNGv0pnWA5w673Y4zS+EvBmPzGo1Lpia1n8GktcjhGvNF4yOvQ2i9R6HaSvVzN
         cMvB2PjT1xoITfFdmFJoxO24EwvYMHslMuXhtci62Mb8KTSvPXLzFZPT/gUujAqVDpeB
         GmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112484; x=1753717284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJyKiGyRBL26HASXyaOaTTKSeeWhDpH++Zw+V8xljqs=;
        b=DPRPAW30PwXDVVgoTFwVcwa+4q9UC8G3bMsQWqOgt2PdYIdcOFn8OUuLFuH4CLILBO
         qI1LHVdtB29fGkIrClvFh3dgVcUQaEVWoXa/A6r/MjG7ywiWF5bG3C7RDt7FaJhZbeOw
         zgHhh3+7emxezQIBcbVrQI1Jz8y92YmbD1b6OJoSd4twRQ+/ywFZO1R0gTU8PrEBvs3L
         AkW9pdKhFOQS0OLfDvhcE/DPJuePQsPmyHedu4vhttur8r5zV21gatxFBVwLcem1nknx
         1n5kbu8tn7WNs0NMsDpkmy+Qk1sIjAwzWd/TJDPBDiAPdD1BEgUbyQ7j7voz2yO8v4av
         faYw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjq36TQioFgH4fwpsaf1MbSxzxX5DvG0RspKIUDB9dIUltQ9nbrX2Ww3PCcOLwi5yGoW27k8LfiDtffg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MM6PqwFimxDD48obZIyT9Ge/v9dSutrI+gx5yNnurYMVkfC+
	a3W3YGsaIzowKvHefE6PuA2iYVALufwFTtCggsRLb0nni2nj5M/RU9pO+7MzpTkxVvDhrn+vopO
	4Z2HEyrzzrKnwykIPCVgz7YGtPuMqgUysDPDaLfK91hm6KtUmU1P0m5kY8FE=
X-Gm-Gg: ASbGnctyPDqd6kpRueRry9RoahoP6idZCA3fYjfwEg/Au6zhzMNgrHTSdwqFHBDIeZ1
	53PISY8qa4q4zZZ0QKCXKuNXWYxH4nmkfjweQiOXafUUNI0pvMh2NRh1OMjN6gDe+K+XItPrmJ/
	Yee19Rsw1r2HF/P+qI2B9kopkAUxT8PjM6679zdV2wpOWQF1BIkg38KYAo26b1yd/Cl3THJ6x7r
	mi0ooOjPUwmc1H41M+iDC5YDCzMUBupTtmxig==
X-Google-Smtp-Source: AGHT+IEDvyqnSojvjostQgIgnB31v9Viyhv3QQlj8Tatp0d6+QYht+tblxcvmRpC5pwWv3FZyGnpA7zj9+lBThCC838=
X-Received: by 2002:a17:90b:4985:b0:311:c1ec:7d12 with SMTP id
 98e67ed59e1d1-31c9f43718cmr29119991a91.23.1753112483889; Mon, 21 Jul 2025
 08:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68185b7b.a70a0220.254cdc.0046.GAE@google.com> <4117981.1753106526@warthog.procyon.org.uk>
In-Reply-To: <4117981.1753106526@warthog.procyon.org.uk>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 21 Jul 2025 17:41:12 +0200
X-Gm-Features: Ac12FXzGcr8D64AD10U2rsuLsZ9reizVpAetCIxrUhEEYOvUKoPOMgfRhfl3laY
Message-ID: <CANp29Y6USOF9+=2zyhkKEn3QfSRBJbK2ssFKtyLavhZj5-PA0w@mail.gmail.com>
Subject: Re: [syzbot] [afs?] INFO: task hung in afs_cell_purge (2)
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+750f21d691e244b473b1@syzkaller.appspotmail.com>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Jul 21, 2025 at 4:02=E2=80=AFPM 'David Howells' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> Hi,
>
> In this:
>
> syz_mount_image$erofs(&(0x7f00000003c0), &(0x7f0000000880)=3D'./file0\x00=
', 0x8000c6, &(0x7f0000000240)=3DANY=3D[], 0x0, 0x17d, &(0x7f0000001ac0)=3D=
"$eJzsmLFP+kAUx7/vyg/yMy6uLg4SxcHSFjUuxLA5mogaNwlUghYx0EGYdPH/cHZwdvOPMM7qY=
FwY3Uxqej3oQQR10MT4PsPj+7h313evyXcoGIb5szw+vNyvFe+EAWASaaTU/89GXCO0+tfb83Jr=
aj1/OfeUv041robPIwBB8PnnJwDcFAz4Kg+Cwd1p9VuE6OstCCwovQOCqfQeBLaVdkHYVfpA042=
w3jT3a55rlhteJRRWGOwwOGHIDffXPSNUtP5IW2+1O4clz3Ob3yg+ml+3IJDX+tPfV282ljY/Gw=
K20jkQNpVeRao3m2gk2v2nE/H5xg/fnwULFr9NxP4UXBDmNX9KaP6R9evH2Va7s1irl6pu1T1yn=
NyKtWRZy05WGlEUx/jff+lPE9r5/0bUJimJk5LvN+0o9nMniu85rpD+J5CZjfLQ+5Mju4nWSe0j=
qTLGmHKGYRiGYRiGYRiGYRiGYZgvMAOSX0EldIo4GcDZkNVvAQAA///an3MA")
>
> how do I manually extract the erofs image source, if that is indeed what =
it
> is?  The obvious thought is that it's base64, but '$' isn't a valid chara=
cter
> for that.

It's a base64 representation of a gzipped disk image. Syzbot does
extract the full disk image and share it in its bug reports and on its
web dashboard. See these link:

mounted in repro:
https://storage.googleapis.com/syzbot-assets/9edd5a22bff1/mount_0.gz


>
> Further, though syz-execprog does manage to extract it, it doesn't seem t=
o
> contain what the test is expecting:
>
> [727ms] exec opts: procid=3D3 threaded=3D1 cover=3D0 comps=3D0 dedup=3D1 =
signal=3D0 timeouts=3D50/5000/1 prog=3D0 filter=3D0
> spawned worker pid 2
> #0 [731ms] -> syz_mount_image$erofs(0x200003c0, 0x20000880, 0x8000c6, 0x2=
0000240, 0x0, 0x17d, 0x20001ac0)
> syz_mount_image: size=3D381 loop=3D'/dev/loop3' dir=3D'./file0' fs=3D'ero=
fs' flags=3D8388806 opts=3D''
> #0 [771ms] <- syz_mount_image$erofs=3D0x3
> #0 [771ms] -> mkdirat(0xffffffffffffff9c, 0x20000840, 0xa4)
> #0 [772ms] <- mkdirat=3D0x0
> #0 [772ms] -> mount$overlay(0x0, 0x0, 0x0, 0x0, 0x0)
> #0 [772ms] <- mount$overlay=3D0xffffffffffffffff errno=3D14
> #0 [772ms] -> chdir(0x20000140)
> #0 [773ms] <- chdir=3D0x0
> #0 [773ms] -> mount$afs(0x0, 0x200001c0, 0x200002c0, 0x0, 0x20000580)
> #0 [773ms] <- mount$afs=3D0xffffffffffffffff errno=3D2
> #0 [774ms] -> chdir(0x200000c0)
> #0 [775ms] <- chdir=3D0xffffffffffffffff errno=3D2
> #0 [775ms] -> renameat2(0xffffffffffffff9c, 0x20000480, 0xffffffffffffff9=
c, 0x20000000, 0x2)
> #0 [776ms] <- renameat2=3D0xffffffffffffffff errno=3D2 fault=3D0
> 2025/07/21 14:21:05 result: hanged=3Dfalse err=3D<nil>
>
> Here's an excerpt of the strace over the relevant thread region with the
> write(stderr) syscalls filtered out:
>
> memfd_create("syzkaller", 0)            =3D 3
> mmap(NULL, 138412032, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1=
, 0) =3D 0x7fbdf4200000
> write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0"..., 8192) =3D 8192
> munmap(0x7fbdf4200000, 8192)            =3D 0
> openat(AT_FDCWD, "/dev/loop6", O_RDWR)  =3D 4
> ioctl(4, LOOP_SET_FD, 3)                =3D 0
> close(3)                                =3D 0
> mkdirat(AT_FDCWD, "./file0", 0777)      =3D 0
> mount("/dev/loop6", "./file0", "erofs", MS_NOSUID|MS_NODEV|MS_MANDLOCK|MS=
_DIRSYNC|MS_I_VERSION,
>  "") =3D 0
> openat(AT_FDCWD, "./file0", O_RDONLY|O_DIRECTORY) =3D 3
> ioctl(4, LOOP_CLR_FD)                   =3D 0
> close(4)                                =3D 0
> mkdirat(AT_FDCWD, "./bus", 0244)        =3D 0
> mount(NULL, NULL, NULL, 0, NULL)        =3D -1 EFAULT (Bad address)
> chdir("./bus")                          =3D 0
> mount(NULL, "./file0", "afs", 0, "dyn") =3D -1 ENOENT (No such file or di=
rectory)
> chdir("./file0")                        =3D -1 ENOENT (No such file or di=
rectory)
> renameat2(AT_FDCWD, "./file1", AT_FDCWD, "./file0", RENAME_EXCHANGE) =3D =
-1 ENOENT (No such file or directory)
>
>
> Can you see if this can be reproduced by installing kafs-client and doing=
:
>
>         systemctl start afs.mount
>         cd /afs
>         mv --exchange ./file0 ./file1
>
> though possibly this needs running in its own network namespace.
>
> I can't get syz-execprog to actually run the test properly, it would seem=
.  I
> suspect something it missing from my kernel, but I'm not sure what.
>
> David
>

--=20
Aleksandr

