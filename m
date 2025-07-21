Return-Path: <linux-kernel+bounces-739391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6EB0C5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB11F1AA3EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F32DA763;
	Mon, 21 Jul 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBURffvi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36FD25760
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106539; cv=none; b=bBQvTNhzZpPaqJQnYywVHsNBkCpYzvPRGefY6IttraYvUfPR/JSjJnaXbpSAE7A6Q7QfboIAG3yTvup2dK7KN4O+bsFFSiCNKWd1pa2W5DivumQ1Q5UuZ6WBelE0XconvPy3beUvjdT/YuWFhWeVqfknIhb8MJmTiM902LIDQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106539; c=relaxed/simple;
	bh=dgeFNnJWxSDuj32WVYEQ0D3lVlp/gLT2Av3ogQjFhV0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KKONklvBCsVatpqPZfc9V61n4ScZ5tH79W6DVaJZYwbgGj0PnEbGcZNKMr5whLRL+mlC/emk1CmPXfOoKfJ8DjSw6qewlomiXCSX6EReANiVZRQDoN3LoL2dHIcIdlrt4TPfpx+sb9NQ9al7hXGfnpGTDKwPRUcGezj1be9u8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBURffvi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753106536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQb7d/dif3jmz6OfeZr/Ea3Pv/Zx61WXWnaddmv/VKc=;
	b=fBURffvinQ93pLBzm7ST59Oqw+kyWNjd+LtZ2k/a4nKXKbzkFPn7CGnr9pcZfm68f1qA3s
	gxifetQjxFtkOdi6+pgBQCejYKJ8YRCReM3QtopkkXEdzAZTu0oHIE2LZMMQmJeKmYy3Z9
	ix1SVpt0vF0V5vb55u60ncp6WKjjywA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-b7mo-L0TMzeOSoEOIJ8crA-1; Mon,
 21 Jul 2025 10:02:13 -0400
X-MC-Unique: b7mo-L0TMzeOSoEOIJ8crA-1
X-Mimecast-MFC-AGG-ID: b7mo-L0TMzeOSoEOIJ8crA_1753106531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A96B719560B9;
	Mon, 21 Jul 2025 14:02:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0CA518003FC;
	Mon, 21 Jul 2025 14:02:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <68185b7b.a70a0220.254cdc.0046.GAE@google.com>
References: <68185b7b.a70a0220.254cdc.0046.GAE@google.com>
To: syzbot <syzbot+750f21d691e244b473b1@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] INFO: task hung in afs_cell_purge (2)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4117980.1753106526.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jul 2025 15:02:06 +0100
Message-ID: <4117981.1753106526@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

In this:

syz_mount_image$erofs(&(0x7f00000003c0), &(0x7f0000000880)=3D'./file0\x00'=
, 0x8000c6, &(0x7f0000000240)=3DANY=3D[], 0x0, 0x17d, &(0x7f0000001ac0)=3D=
"$eJzsmLFP+kAUx7/vyg/yMy6uLg4SxcHSFjUuxLA5mogaNwlUghYx0EGYdPH/cHZwdvOPMM7q=
YFwY3Uxqej3oQQR10MT4PsPj+7h313evyXcoGIb5szw+vNyvFe+EAWASaaTU/89GXCO0+tfb83=
Jraj1/OfeUv041robPIwBB8PnnJwDcFAz4Kg+Cwd1p9VuE6OstCCwovQOCqfQeBLaVdkHYVfpA=
042w3jT3a55rlhteJRRWGOwwOGHIDffXPSNUtP5IW2+1O4clz3Ob3yg+ml+3IJDX+tPfV282lj=
Y/GwK20jkQNpVeRao3m2gk2v2nE/H5xg/fnwULFr9NxP4UXBDmNX9KaP6R9evH2Va7s1irl6pu=
1T1ynNyKtWRZy05WGlEUx/jff+lPE9r5/0bUJimJk5LvN+0o9nMniu85rpD+J5CZjfLQ+5Mju4=
nWSe0jqTLGmHKGYRiGYRiGYRiGYRiGYZgvMAOSX0EldIo4GcDZkNVvAQAA///an3MA")

how do I manually extract the erofs image source, if that is indeed what i=
t
is?  The obvious thought is that it's base64, but '$' isn't a valid charac=
ter
for that.

Further, though syz-execprog does manage to extract it, it doesn't seem to
contain what the test is expecting:

[727ms] exec opts: procid=3D3 threaded=3D1 cover=3D0 comps=3D0 dedup=3D1 s=
ignal=3D0 timeouts=3D50/5000/1 prog=3D0 filter=3D0
spawned worker pid 2
#0 [731ms] -> syz_mount_image$erofs(0x200003c0, 0x20000880, 0x8000c6, 0x20=
000240, 0x0, 0x17d, 0x20001ac0)
syz_mount_image: size=3D381 loop=3D'/dev/loop3' dir=3D'./file0' fs=3D'erof=
s' flags=3D8388806 opts=3D''
#0 [771ms] <- syz_mount_image$erofs=3D0x3
#0 [771ms] -> mkdirat(0xffffffffffffff9c, 0x20000840, 0xa4)
#0 [772ms] <- mkdirat=3D0x0
#0 [772ms] -> mount$overlay(0x0, 0x0, 0x0, 0x0, 0x0)
#0 [772ms] <- mount$overlay=3D0xffffffffffffffff errno=3D14
#0 [772ms] -> chdir(0x20000140)
#0 [773ms] <- chdir=3D0x0
#0 [773ms] -> mount$afs(0x0, 0x200001c0, 0x200002c0, 0x0, 0x20000580)
#0 [773ms] <- mount$afs=3D0xffffffffffffffff errno=3D2
#0 [774ms] -> chdir(0x200000c0)
#0 [775ms] <- chdir=3D0xffffffffffffffff errno=3D2
#0 [775ms] -> renameat2(0xffffffffffffff9c, 0x20000480, 0xffffffffffffff9c=
, 0x20000000, 0x2)
#0 [776ms] <- renameat2=3D0xffffffffffffffff errno=3D2 fault=3D0
2025/07/21 14:21:05 result: hanged=3Dfalse err=3D<nil>

Here's an excerpt of the strace over the relevant thread region with the
write(stderr) syscalls filtered out:

memfd_create("syzkaller", 0)            =3D 3
mmap(NULL, 138412032, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=
 0) =3D 0x7fbdf4200000
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
"..., 8192) =3D 8192
munmap(0x7fbdf4200000, 8192)            =3D 0
openat(AT_FDCWD, "/dev/loop6", O_RDWR)  =3D 4
ioctl(4, LOOP_SET_FD, 3)                =3D 0
close(3)                                =3D 0
mkdirat(AT_FDCWD, "./file0", 0777)      =3D 0
mount("/dev/loop6", "./file0", "erofs", MS_NOSUID|MS_NODEV|MS_MANDLOCK|MS_=
DIRSYNC|MS_I_VERSION,
 "") =3D 0
openat(AT_FDCWD, "./file0", O_RDONLY|O_DIRECTORY) =3D 3
ioctl(4, LOOP_CLR_FD)                   =3D 0
close(4)                                =3D 0
mkdirat(AT_FDCWD, "./bus", 0244)        =3D 0
mount(NULL, NULL, NULL, 0, NULL)        =3D -1 EFAULT (Bad address)
chdir("./bus")                          =3D 0
mount(NULL, "./file0", "afs", 0, "dyn") =3D -1 ENOENT (No such file or dir=
ectory)
chdir("./file0")                        =3D -1 ENOENT (No such file or dir=
ectory)
renameat2(AT_FDCWD, "./file1", AT_FDCWD, "./file0", RENAME_EXCHANGE) =3D -=
1 ENOENT (No such file or directory)


Can you see if this can be reproduced by installing kafs-client and doing:

	systemctl start afs.mount
	cd /afs
	mv --exchange ./file0 ./file1

though possibly this needs running in its own network namespace.

I can't get syz-execprog to actually run the test properly, it would seem.=
  I
suspect something it missing from my kernel, but I'm not sure what.

David


