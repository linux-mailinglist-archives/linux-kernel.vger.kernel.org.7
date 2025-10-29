Return-Path: <linux-kernel+bounces-877154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54506C1D52E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFCD434C7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415C9312837;
	Wed, 29 Oct 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hk0iIWun"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40D026D4F7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771469; cv=none; b=Khexe96T3TpFAGzS9dVkBeOW288NNk5QsvXaTJ0OyD4qxx3C9drEajGoGlrEuCtgfEx7tUIBI2Q3wQxQZezMT4EZHRl7FoMmt+6Ooeysvc+KizVOlsfVD15mXty27VYxAU6NCq0mPe6DGL2vBrzohmmDUdP2l/5zPf6UtiHOIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771469; c=relaxed/simple;
	bh=kVNbgrwJqbn7N+8Q84bXyTlZt5UuYWGOW5gvGcx+ks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoB1q+CSKf9Van9o2+Dt64Utpv52rwlPIT3s2f/W00lR9Df1KjFMBeBeQwb0uwsvFiVhcP135xUDIygtkOMCTm9xYt0aiSpyUbVWnMgGKv+yuQ1Rr4ytM1jot+WyxvR5o9NBbqjrzFr0dN1zbnQbw2lM4Hhqa9bqUBOJU95YEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hk0iIWun; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so525087a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761771466; x=1762376266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuiAC7OKtA+UPyYMr+UMd+A8BNjdLWXyrqC7LzVZISg=;
        b=hk0iIWun7T0BHLLHJJOZ0GzYo9fP4fQe4pLx/FoT0IXyb9+F33vZSZJK+Cq7748k07
         5O3cfoFIlj5ogkNxfyjudSnK2wi802y7GEAuQOImtX9Y4OFzWKHchiT6JVP2a+KZCEH8
         cSjU95CyZY4/J63wzHlqIfQhCJCnAcg+1EVZxIXa26grdk2QDG63VtsaJJHGREmiZlk/
         B5mmEpZtI34kWoq3MZILtjUu6Uk+NIGwLGN+5cnpZMIcX/8VOHtbRlXBNnBverIXmY0h
         KUCh1gQqw2RZiTndB/MBypT2DVxDbDDDPYq73ZDmGuMzufGZi3rCpKC9G/4d9nO3BeNJ
         PVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771466; x=1762376266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuiAC7OKtA+UPyYMr+UMd+A8BNjdLWXyrqC7LzVZISg=;
        b=c7BeFD4e3in5VaiBhYsobgCbTYGULrMHGP0SencMzi6po2BqTwHOfNpnNvSpLWtA7x
         kZbpIhdhQSJVZKGzRpPmDC2WyQjA6OBNn480dLhibp0e8or8+7pNGoL2vwOo9pgNfepE
         2GI0C7o+S3C839kKRC4WeCoTA0atlKCpzaWe8PaiN2qcUTG9L1TuKhkANl9DcbYcVSRl
         U/AGu5SstJT8v/cBJP6RX7Ax+alq9b3fJ4OWnTfiM0VOtzkuy6Nk+rHkJGtvHhL97bZU
         Lc1L/k3BtZRgpoj4Apho7QR4+xO4y/J0DTf8VMbF4oi/8nKBPv/RkjrI5kTOnqEW5BoX
         VD6A==
X-Forwarded-Encrypted: i=1; AJvYcCWvMZscmJSsYV3brFniA9IwblSf0XntK4lUMiGm/Efdqa3jkHKFn1LQtm4lqvn3RJADKOs6yglanBptejg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmVaIFcCrccY2QK5sFCE+HijLrKZBkOjaMs4Kp3VSay6QS1dh
	dr6n6YEeKG6Ab8VYxa/ZXosCm2DRZfJ4mJEr8Qnh7Md8n5CiItV5d59Q4oDY9DYy/pi4in6g00F
	r322KzXGHTyS4FbVTD/zZxGnuP+ves/C4+YTofcC05Q==
X-Gm-Gg: ASbGncuOjMSrcekfDtzO9V012wYqIO9lHo8vt2+xrU85qvrG/zq85sy2cJa1v9wzECv
	sFID4tD9b2B+8WtkTNNWOE8lH7S2Wm53eghbwTyVAVqd1UWXWa7Tt0pdrE+NPjljiO0DnD12CcB
	waqPcbCN34cKJ8gPmzZAQogx67q310k5xyLEXVAeZ1gUguJTAdOBOj8YpAVeajAUbL1AOCMJJKJ
	RXGAnAsj94QHqUxupNHQ4dBgOmBP3MW0oL6wZp9oHZhO1rN9Acpxl2HvA==
X-Google-Smtp-Source: AGHT+IG1L1CklcYrT3HJAsT3NVI2g7bIUPxqqj/65m77k2dZAOZ3fC4M2LmVzxUPHERR8OTwMl8fTbOBKlBu6jPbapM=
X-Received: by 2002:a05:6402:43cc:b0:63c:84e:614f with SMTP id
 4fb4d7f45d1cf-64044254e3emr3585778a12.18.1761771466076; Wed, 29 Oct 2025
 13:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com> <CALzav=d_Gmb8xKCwWCGsQQrdxHJrnk5VP-8hvO6FugUP7_ukAw@mail.gmail.com>
In-Reply-To: <CALzav=d_Gmb8xKCwWCGsQQrdxHJrnk5VP-8hvO6FugUP7_ukAw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 16:57:09 -0400
X-Gm-Features: AWmQ_bmg8lfgTlZTUn7wdsm2doiok4izVO4pilRQtGY6Hx2FX2qYt9rGJfmSrxU
Message-ID: <CA+CK2bDMcCtDom1XQOx0U6yTg3Azr4jzSTpUo=WKgvTVOh5oog@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:44=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> > On Wed, Oct 29, 2025 at 3:07=E2=80=AFPM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> > > Also, I think the model we should have is to only allow new sessions =
in
> > > normal state. Currently luo_session_create() allows creating a new
> > > session in updated state. This would end up mixing sessions from a
> > > previous boot and sessions from current boot. I don't really see a
> > > reason for that and I think the userspace should first call finish
> > > before starting new serialization. Keeps things simpler.
> >
> > It does. However, yesterday Jason Gunthorpe suggested that we simplify
> > the uapi, at least for the initial landing, by removing the state
> > machine during boot and allowing new sessions to be created at any
> > time. This would also mean separating the incoming and outgoing
> > sessions and removing the ioctl() call used to bring the machine into
> > a normal state; instead, only individual sessions could be brought
> > into a 'normal' state.
> >
> > Simplified uAPI Proposal
> > The simplest uAPI would look like this:
> > IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> > LIVEUPDATE_IOCTL_CREATE_SESSION
> > LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> >
> > IOCTLs on session FDs:
> > LIVEUPDATE_CMD_SESSION_PRESERVE_FD
> > LIVEUPDATE_CMD_SESSION_RETRIEVE_FD
> > LIVEUPDATE_CMD_SESSION_FINISH
>
> Should we drop LIVEUPDATE_CMD_SESSION_FINISH and do this work in
> close(session_fd)? close() can return an error.
>
> I think this cleans up a few parts of the uAPI:
>
>  - One less ioctl.
>  - The only way to get an outgoing session would be through
> LIVEUPDATE_IOCTL_CREATE_SESSION. The kernel does not have to deal with
> an empty incoming session "becoming" an outgoing session (as described
> below).
>  - The kernel can properly leak the session and its resources by
> refusing to close the session file.


I was considering this. But, in AFAIK even if close() fails, the FD is
still closed, therefore, I am not aware of any existing api that
relies on close() to fail. The finish or (set event if we decide to
expands events in the future) should be a separate ioctl() and close()
should release FD unconditionally as it still would do even if return
failure from release()

