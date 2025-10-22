Return-Path: <linux-kernel+bounces-865542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B32BFD581
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EF919A06F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192C34D4DC;
	Wed, 22 Oct 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcCo87Yq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE72D47FE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151316; cv=none; b=LsAXA1fko2suaHykRO7hd+ZknRILHzxT/p5Y07fkPwug9Q3pZIPO9qX62A9zhtpJ2yQl2bcPLpaLLJCAhnrwikFfU7ptuTrlUyuTVI3sCA62ykZKZ4aY3upTmntqmaffoUdYZd0IldLqQSqWcADC7liWxu4mYR2UMoUfkbl7IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151316; c=relaxed/simple;
	bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae6JgjoxnKqFr/wIOFYVmQ6ql7JD7icBZhvD9FpGZ+xyvZZbSV+5KRywlSQM30tH/swL0/GiwbAIC+Vw53CXlhZWHO+qeJ1CiY7AwRKcd0ZqgqDIeAg6Kwb/Tn8sXQFvnhlT4+4mWcc1B2PWEF8R9yMhe6psKv2BCrQjXh4jt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcCo87Yq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b456d2dc440so1161812866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151312; x=1761756112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=TcCo87Yq/iqTvWnBnXr1s/sb405+ysTLf/84TAuBDnKBBDUXPhVcnrRzwWKSmvJPHM
         sHvLDJy4H+au5p0MkDVRxE9dBRvvR5TXtEajr8oGykSgG9bDfoNc0SlJdAn0+tOvZfUF
         nDkYKnfeNYvxMDaPVIu7RTFhe+JFog3XitWtISUFtnLJq8yv/Ie79MJmif4ot1haGFCd
         eahrAgwlG3DgFuB8g1YM9qlrtpgocKryspGEc8RduAwwVtt+k5wKIBMXCj03ujxrfucx
         vvNSnbdMyBfFKGJkyK/ZXqMenwgzukXmQnWfk2h2YtnVuv+LJSuNRCoU/aN8C5Nys+E1
         YxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151312; x=1761756112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=bnd/wpuv9j8ElRuhURYWoeSr6NwB/aZYYRTez2tVMZl+KWNZKebGb+qZBKf3Kp78a6
         sfmF6oE2OFLyER2PVvC5xvuyM8UOQSkg8GE79/Gl7XL1tJ+OiPIObmYBLhRSyeqCe6xH
         3GvXpOxcZuN2C3VmiyTGUhBLpSpVOK4vDgeBH+0T2I98Cu+2mZIZJ+XK4Y9MqqOEN7iT
         1u0b8Rf9v8dtD8BZtzO5UdeDSR14Qy1fTHtYps/keMFQMI7covtM+MaUhR92+vlBg/Wh
         uC73FmyWPSiC3WHw5IkpaUGRbqGEbdLNAdfYY2goigk772FhXr/z1F1uVq/VUQ0QjcOj
         WWSA==
X-Forwarded-Encrypted: i=1; AJvYcCUw9eemOmzFsi9UTYS5+UNdaqGa+bz7GW6BQfLzvAEZRRaDVPZCiRaL7fRiCUHeTrMeQWHNcPHgKCiiCY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXhb9Sq2hEDnIJxO+FQCK+hYs9jRJKAkwDMq+Wsk7R4qUYUGY
	RPitI16S5Sgjsj/MEIonR5qqxIEw0N6IXkvdle5vx3JAuVJGfw51Vx9Ph8N3Hi150MVlnXwYJw+
	GEfzAS/E9HVOZgqNnKUNjGmIvmoxzJaY=
X-Gm-Gg: ASbGncsG4dnStGi28De8DuGeEiF5+prBClYK4Fb3vYavLIdjAcetjYhIj41FTAbb7Vf
	gs2SU449VcDdCLoYZc1KDKM2nkutuPl2vmExfkptwtEokd1VENjb8oUXShmWmFSyX/nyr+mpRVL
	A8RNdryhImelLRDlvwp3J0JRqFU7gJZo64VUfGyL0PDHF2CTS8tQ2UWy1ZzHYWx3Z9OpkYm71Ol
	bLJ/0mQe6QXF7BCE6UJbzQs6xi7W+IxN8XOfBvyhSPCPv3qpjCucy2HZoO5XuylRNdaMZhJ
X-Google-Smtp-Source: AGHT+IHkWGnG06JOtYFwx6WKEecUCCr1fs/y3xfoAi4lziINz4JBVkxPbzc5Y9qrcmqbPId7dzqQXzuYY7OGWY5xDrg=
X-Received: by 2002:a17:907:c11:b0:b32:8943:7884 with SMTP id
 a640c23a62f3a-b647500ee9amr2300275766b.45.1761151311555; Wed, 22 Oct 2025
 09:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPg-YF2pcyI-HusN@archie.me> <20251022080626.24446-1-safinaskar@gmail.com>
In-Reply-To: <20251022080626.24446-1-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 19:41:15 +0300
X-Gm-Features: AS18NWAouNqJg7toJrl3zFJYl4AxgHZN6-E0xEGlNVrmOGgNKVxnzpVBWI-jPi8
Message-ID: <CAHp75Vfb5J9P1vhSWkGy_j+ter_774ThBJHZuSp=r583xGP8Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>
Cc: bagasdotme@gmail.com, akpm@linux-foundation.org, arnd@arndb.de, 
	axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	christophe.leroy@csgroup.eu, cyphar@cyphar.com, ddiss@suse.de, 
	dyoung@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	jrtc27@jrtc27.com, julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	krzk@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, monstr@monstr.eu, mzxreary@0pointer.de, 
	nschichan@freebox.fr, patches@lists.linux.dev, rob@landley.net, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:06=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
> Bagas Sanjaya <bagasdotme@gmail.com>:

...

> > Do you mean that initrd support will be removed in LTS kernel release o=
f 2026?
>
> I meant September 2026. But okay, if there is v4, then I will change this=
 to
> "after LTS release in the end of 2026".

No need to mention "ater LTS release", we all know that this is the
last release that made the year in question.

--=20
With Best Regards,
Andy Shevchenko

