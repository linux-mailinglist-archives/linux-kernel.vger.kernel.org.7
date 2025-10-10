Return-Path: <linux-kernel+bounces-847760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C619BBCB9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A7E14EB753
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07D1FF7C8;
	Fri, 10 Oct 2025 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDuL5tqL"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4A1E5B70
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069383; cv=none; b=SK8cxAaLtUnj0i6lGq00zx3YdNEqdFHXMpbIjoqETTRTyiQWD9+Ap3u3XuaxKuxMHapCRvKhenq7HeszxT5XVIAmPwDDMmjS+Qni3EmHtYzzGPHbqtWGAkWVj9Ye97ElggKBzEOk1vLljsiwn0gfnAXv37tQLOsjyYNoOnYb3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069383; c=relaxed/simple;
	bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAzb1aUX5x1pklch6k0egCX9K+higcPLyBu9M3v6ERGUAfM6ui/NBLi1o034Yxu8OMDTyyeKUG4tk5J0nYavs+rM0v2lXxbAIKByWAUcugqJ/sL1EyAuW9qSMNG8zWLa2bEkN4k8Jc/6hAMlUuq1Sl2boRnHTlotbmXyEPtMH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDuL5tqL; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63605f6f64eso1461986d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760069379; x=1760674179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=nDuL5tqLs6F/bqWcdATCSw3q6sR4xH9PojO9qOD+5CVFhCKnIdXYLqb6N9qP3a90AK
         XcWKwh2rGBNpBKIw4DXxov8U2qs0Dzy6gXk8vFfvDusYiZmPGdnri/OyTQj/4/Q9hjBA
         AP9cRpfxElOVTqf47iRfDxq23HPr72skNOU/r2V/uYwO0u5rdlLaDJlfE0FHTHhwxXRY
         CxV+l2MjGbd2BdsN32iKqGDmRkhB4tNQBtMagkevAiwpNidXH4OagDZ/3oHz+Ju9tDVq
         V/7yZAk0s3YGeHhlLGi653f8C0CT7tXpjc3Ab8zbhGaCEogKGwXedDHs/+NW7Be9ThrK
         SjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069379; x=1760674179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=NJ5u0ZDlTWC/LJoTIN5d0hQPRH5kdw4mjYXU6njtfTVN68lTPgFKPwB8jcmpiQYUKj
         wfJiPhelvvtuEejrG9I8Oo1ESMQNWo3RWGwZyoaEOha6EVAgWHg5q8lzHLUeVoYJU83R
         FFi9I7ze3fHoEL0QNxVLSu1OrJHIpLcM9/jULzpL48n5WgwwjzfgWOsvLFoyD0R79pzR
         IZcig5TBefN+RHgTNh+QN0UMig9n1aSd28sPqCg1glSFmUKPjapEyp2aGO9P1zhaOI/k
         l8ikqKkujF2WtMg05HiRE4kn67bh7HwhRXGVwGzynoPYj1v0ozKi/4XwkkGcBzCkBZg6
         GSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHLQ+cEIJmyO9fsgpxnvTc/G2BvVxIa4VKaXj87vGoBrSSgR76tRYXi08ghJ/0t72NxqpmBebRh4r5c3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7xdTUfdrH1EYoWkyszgeONCnErBZ0ukuA7jzKjTPS3JMPPuh
	ISluvLWTObmqSiEO0A/0eYhPCOP7imf5DnQm46Mv3PK7VWl9z4Kjd92Lg6Mum3dGBcvEQzona8G
	0guOX5nBKtNibWuvZym3qwy2P3hZCK64=
X-Gm-Gg: ASbGncs27sDHQf+sU570WAan7XAARdSCt1UvnkHsx8+dYWgv4zuNGyJiMz77mXN5uSl
	3BjltdNDvIDJ0UoZAWbtXYPb8GLld8dFjnFHZOHF5f8VrabvvDKYC6TjEgdrI8iRLG8UNNd0rPj
	uu1ez4A30carqkv1X6g9O1ItqD/oXAazV7aQD8ZF1DCa9Yah74MdlVyOx6EuSrzP2NznMeM7mmm
	3CSEBMTpbuQLGhH8zVopuhOjMddiZmTyHyI
X-Google-Smtp-Source: AGHT+IEKzDZJ3mg1FFWOqowFJqWLj/+dmJPdM199pmmtVcavFH/YLuoH0hEdsvn7dHSOiTNw/3Aomiv0DcOjJivXzrY=
X-Received: by 2002:a53:e946:0:b0:636:17d6:a30 with SMTP id
 956f58d0204a3-63ccb82410bmr7618496d50.15.1760069378763; Thu, 09 Oct 2025
 21:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
In-Reply-To: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:09:02 +0300
X-Gm-Features: AS18NWDxe32nrD4BfQQFhIe3tEEfxrwgJsYQo_BWhSUPsy5CceSv7QOcZ20roI0
Message-ID: <CAPnZJGAKmgySY_RK0kmGTgwUh9hw4FSrVR+LoJCbD_RmJZe6RA@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Jessica Clarke <jrtc27@jrtc27.com>
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

On Tue, Sep 16, 2025 at 8:08=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
> I strongly suggest picking different names given __builtin_foo is the
> naming scheme used for GNU C builtins/intrinsics. I leave you and
> others to bikeshed that one.

Thank you! I will fix this.

--=20
Askar Safin

