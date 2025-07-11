Return-Path: <linux-kernel+bounces-728318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71BB02685
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819DA171B77
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5021B9FF;
	Fri, 11 Jul 2025 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HwfEjbRc"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2D155389
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270385; cv=none; b=gr6c2Rp6dEZ1NUxvt7wTmpfA3Xalx2FOO8Nk4Njf3HobcIW0Dtpg+qApspIj7+DIZQlG+etKxnC/xqVeuV4TI8I5INvyg5TBzWVAYmtNUlMGSVrVTji7cl5J3C4tPWVdebdC6MqkW/uxi21EjEym3tR+k3iVkxMTp9RK89DL2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270385; c=relaxed/simple;
	bh=H/zPEzC8h/rhWeEV39tcr+XT+TN9zJHsawYYmLNzQ0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hayh28V7tTsPgxHEgqs6sUwSPfd2NhROmFi+KVOqcEqPKXlVEAgEwIu7hredeEFqaOCw+WnB90QbT2jiPmmG8G9+NcPcm5Bcy3M0HvsZOf3YkVkzP7Y3MPydFWNuKzHxrccbLjbrtXmMeb2pvAP0h1XYw3FQdd4TeZ6Z7aliB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HwfEjbRc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so4783649a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752270381; x=1752875181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWl0ZCeXiXBuL5nfGt864S3rVP453Egy/lQ9GBy3dco=;
        b=HwfEjbRcPHf1GqZOgi3MjyDkDYhUUjOSUY6tizY8ZcgXyxEw8+7AewG3g9qb6VFSHC
         vUsOqyWG/1wi/fC7S6L3iInETF3jo1kanvkg3NsVQXalVpC5qzRBs6faxGOt90+TaHK+
         xg/bi2SSgUAF1R4k0MvYXMG63sbdZtkieMeXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752270381; x=1752875181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWl0ZCeXiXBuL5nfGt864S3rVP453Egy/lQ9GBy3dco=;
        b=EBlAz4dMXa98p5+RAOmFiygEqdHrw/eIDjTZgvCkkOEdB1SWWyHx/6Hj6rXQlnk6+Z
         V/Gt7t+2bQFwkx9W04hHrRpaqd5xbal1yhLST6DczOyyOnIRq2ZrIyZesj9bLbB9Ce69
         nS8FBqI8D//geRuqfqw34lHDTil/SwioOkWc3Xd9BDGuCOFP+sYTw4RdxHbjUsaWUvJY
         Hfn/WcUp9uea9ot4pqLSCP7tSfS8aUwx+Ila4boNmcgQkIDhgNTguCT3/stvSTrAX7xD
         wuovvyLgndgY8Tpi0ekIgVgSvvnHWrW21u84VYhC/w/pOYDp617RD600hvTEzoXzPkR9
         rBug==
X-Forwarded-Encrypted: i=1; AJvYcCXC54IFiHnjW8oZTaQD4HaGvrBUMynfXac3zqZWlJ1HYLgI+TeOre7mv6s7rjqiHgcXEwcBmfqs9OCtLS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9XC5DxgOG6fg4txstD3AebsiuzbF3IdMvX8vGhPNVinSZi2d
	YzYR16LpP6zDjEbWiP2HcUpjTFEHdEXXTUAQpYSQOsg3Tr2guXNXMWRr2ubbBAvW92wndvz60IE
	VbsAtHhbcSQ==
X-Gm-Gg: ASbGncs2TH0Iu6CUITXSk4QgnLGUCXpfYayQY6uDUoijyv7ttbnkdrlXINv2zP9WOiA
	Zif4+ytAD5D9R1SL3w6ZVHg3oMxakTzWu5GCmUi/RywYtzSbprZaCDsfWiLcE2DJfw0vuVdRHT1
	hZ9vhGq5Mduu7dcrFyDmtwarUbTmVaaUZw2F6VrxmUq4MDhrp3SYoSXI9rvR/7HlLXLgmUS7J71
	mM3xoZBdFBHJ85OXBTdr8DRugDDoHHvb+/St1JZveAE69u9zbKyBQiA7+AbuqAJeCag9Pl1mdcO
	RFMzII2cWukKFkNrfcO/HnhQcN3vSrIWZzfbJp4GhlClNmf2xuHBsZbrv/3GbPXrlwu16Tr+32I
	I13tGHXD+zqMsWZ6e7XkYCqkryPHu1rjNypMJagC2Zhx6a0AoqFx4gXAQc7ZK3dyPUb6AH3tOvA
	/1/Uju12A=
X-Google-Smtp-Source: AGHT+IFbRjSrhOXTvzRDWg9bRND+oxJ8OCWBne1XsPxlqL1uxHXAtZSz5ScRLKSrnQzaK42l8w5pjw==
X-Received: by 2002:a05:6402:5252:b0:607:ea4e:251c with SMTP id 4fb4d7f45d1cf-611e62da804mr4442417a12.8.1752270381487;
        Fri, 11 Jul 2025 14:46:21 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ec04sm2677088a12.60.2025.07.11.14.46.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 14:46:20 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so6198083a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:46:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqQVf2E930xsT31tcqRlwYJlEvp40Z5eBBqbaR8iv+wh73XLiN6LkhXTtxWnwyJ1nWjj7ObNKzQ1Bk2bg=@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:608:ce7d:c3b8 with SMTP id
 4fb4d7f45d1cf-611c1df53aamr7638873a12.17.1752270379368; Fri, 11 Jul 2025
 14:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
 <20250711125349.0ccc4ac0@kernel.org> <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
 <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 14:46:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
X-Gm-Features: Ac12FXz-E7TSeMs6PS6FH7HeMIkvC5P9gc2EaFCqanu5QU51-la_uVcLprbUluM
Message-ID: <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 13:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Indeed. It turns out that the problem actually started somewhere
> between rc4 and rc5, and all my previous bisections never even came
> close, because kernels usually work well enough that I never realized
> that it went back that far.

It looks like it's actually due to commit 8c44dac8add7 ("eventpoll:
Fix priority inversion problem"), and it's been going on for a while
now and the behavior was just too subtle for me to have noticed.

Does not look hardware-specific, except in the sense that it probably
needs several CPU's along with the odd startup pattern to trigger
this.

It's possible that the bisection ended up wrong, and when it appeared
to start going off in the weeds I was like "this is broken again", but
before I marked a kernel "good" I tested it several times, and then in
the end that "eventpoll: Fix priority inversion problem" kind of makes
sense after all.

I would never have guessed at that commit otherwise (well, considering
that I blamed both the drm code and the netlink code first, that goes
without saying), but at the same time, that *is* the kind of change
that would certainly make user space get hung up with odd timeouts.

I've only tested the previous commit being good twice now, but I'll go
back to the head of tree and try a revert to verify that this is
really it. Because maybe it's the now Nth time I found something that
hides the problem, not the real issue.

Fingers crossed that this very timing-dependent odd problem really did
bisect right finally, after many false starts.

                 Linus

