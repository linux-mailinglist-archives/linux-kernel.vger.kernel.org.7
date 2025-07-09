Return-Path: <linux-kernel+bounces-723595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8899AFE8EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284713ABA5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2C2D9EF5;
	Wed,  9 Jul 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiqhXepX"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44C2D9EFB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063951; cv=none; b=uUl0xxUz5zRPxVU3J4XNRUNCcz/PnYKkn9VMVONOJTheUkLsDHWeUvuw66dZCpxv/GEnIP4DTlPoEi/d/VWHXEL3RLuISL7JRn2+I1heDXLXx2FzCzIMiXcBSZEhyvpbbSVjMYQ0OkYxbDGJsYiBqMdeBinEQQz2PgbNaU/1GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063951; c=relaxed/simple;
	bh=wb22XIikD2qATxWdRxTA3iHhTy4uPTHwNH1Z3aIBhaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpWASnL8qUNBeOHzG+8ATjXXOSEd5Lai/ftDXcSBNdGINMSQGXNOI43QS0Ej2cycmJJ1X/Cl8cRezFyEdA45Lxs2Hd1PI9KiMXeBsLUzOAi8FgvghRLvsKOA93AA6VYJgrKzo5P/zFfwnOp/+ojsE79WHIj2uZjXr3i1jbLgMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiqhXepX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so5038344a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752063949; x=1752668749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/q7TshKKoT7nXGacRLVg39PUcU9ha1HeRSUxDk9nqI=;
        b=XiqhXepXn0fEjeU4tmuOgqv7YqcMSaCduiCGHfcqz1fz5fjbftcgf3429eZyTDgS+D
         gwBpwOgam1U3ucJmAXuO5udqNNKxhDahphTW7AFbFLJ2ZTMhq674zLf5z9YkDJKjJMMf
         PrUeSYWx5s+k814p8EOOwOogGiaqg7mtDywz8O5TzZ9i+8Qsrlw+kdciiaHTvPh6L/Al
         Apv5R2yVvqTfthL5UK85FSrY2Xsyj7yj0C9sgrbY3huWMv3eizjAOSR1UiZL5ss/hNhG
         U4Fngs16HQl8pB2jdFZA6gXeR7DmHWZK6/75Sz27Pz2oMTpRbqv0IIHtOOu51IpLbnP2
         fxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752063949; x=1752668749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/q7TshKKoT7nXGacRLVg39PUcU9ha1HeRSUxDk9nqI=;
        b=l5Wv4WG8RkudcMzmHLxxA6mInhrzt4ZEk0ddJhMap5Tt9WamxdN8EE8YR0K6swALsd
         87mly+MRGPcn68xomcpDDfyiqTnH3g56X3WjNPQSR9Pf2zK1cahQbS7WXrZwlb/imP5g
         7oNptZxnyrOhQpTNeWBlEg97nIN4fEWojkGZT+XNWvolUbjHAIrCAMldWvMQOsHNoq4y
         8ZpJN7Z/tSAEUmS4tJJ7eJMauzuMqgSnEB/1U1FKQFzR3qDcn4E7tpf8WYnKWQf8beQj
         sIYT/wYtebfwl4cjFuun9VBnTyhw6V+bvTVuvs7rIdlZc4Ut/Q+xY5EFPJsudJxMOh3W
         Ko3w==
X-Gm-Message-State: AOJu0Yw8DupwRlbEXx+L6zbCFRTlJpU+GpHnoYMQqQavvCmjcnQdyb9Y
	9cbKqTE7gmu/AUeHHOyeV2t0oh2+jG9WXHHfF96mrz8+KjPgR+Z+UQrrs6/m7+Fz/X3ggb6Kkeb
	FmIl9VHWsARHTpXB7VXwhc3xBfOGvr8yOtkD5aZ3gZA==
X-Gm-Gg: ASbGncsrepzpkxkyrwiqGkWhgUets+md3Any5Ua8sOvQsXcs/FKs+7spGwGYr8hRkVg
	nWb61WSA1GXTZxrT0hw5fFkSTPa9icRzyNt+4Z3Zm0k14Pk8+nPhKAiak3f/gWsZrRdboFgij7X
	Q1iu+ly/Gm/LL/dqqupsPgKb/j52dV0sfnZhmvPwnIqfS0EmU1znE6h7TeUKIf3TLT5HNVlF47Q
	M4N
X-Google-Smtp-Source: AGHT+IFcpLtOMbOqJ/FkYbFJ6ZieYCRLYBJIVZAFvoK2D08JwArVwDsz9XqCBlbkUqhACkrjBfuJcYeD1mdTmH+qlOM=
X-Received: by 2002:a17:90a:f6ce:b0:312:daf3:bac9 with SMTP id
 98e67ed59e1d1-31c2fe15c5cmr2399918a91.34.1752063949445; Wed, 09 Jul 2025
 05:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtK2TLbpo-NE-KUXEp0y8+5zXNVRFkqdMjaGgcNFFG77g@mail.gmail.com>
 <2025070924-slurp-monetary-a53f@gregkh>
In-Reply-To: <2025070924-slurp-monetary-a53f@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 17:55:37 +0530
X-Gm-Features: Ac12FXzBT0KHq5ReF1wh3qeMehbB0fUcTYzXrsEznaZ3aV6CJ3ajCFVqPCFB3rg
Message-ID: <CA+G9fYurLq9o_PSbQKCOmSkQfa5-qtAu2HR1PzySBmJM4C4F3g@mail.gmail.com>
Subject: Re: v6.16-rc5: ttys: auto login failed Login incorrect
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-stable <stable@vger.kernel.org>, 
	Jiri Slaby <jslaby@suse.com>, Aidan Stewart <astewart@tektelic.com>, 
	Jakub Lewalski <jakub.lewalski@nokia.com>, Fabio Estevam <festevam@gmail.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+

On Wed, 9 Jul 2025 at 16:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 09, 2025 at 04:26:53PM +0530, Naresh Kamboju wrote:
> > Approximately 20% of devices are experiencing intermittent boot failures
> > with this kernel version. The issue appears to be related to auto login
> > failures, where an incorrect password is being detected on the serial
> > console during the login process.
> >
> > This intermittent regression is noticed on stable-rc 6.15.5-rc2 and
> > Linux mainline master v6.16-rc5. This regressions is only specific
> > to the devices not on the qemu's.
> >
> > Test environments:
> >  - dragonboard-410c
> >  - dragonboard-845c
> >  - e850-96
> >  - juno-r2
> >  - rk3399-rock-pi-4b
> >  - x86
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? 20% only
> >
> > Test regression: 6.15.5-rc2 v6.16-rc5 auto login failed Login incorrect
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## log in problem
> >
> > runner-ns46nmmj-project-40964107-concurrent-0 login: #
> > Password:
> > Login incorrect
> > runner-ns46nmmj-project-40964107-concurrent-0 login:
> >
> > ## Investigation
> > The following three patches were reverted and the system was re-tested.
> > The previously reported issues are no longer observed after applying the
> > reverts.
> >
> > serial: imx: Restore original RXTL for console to fix data loss
> >     commit f23c52aafb1675ab1d1f46914556d8e29cbbf7b3 upstream.
> >
> > serial: core: restore of_node information in sysfs
> >     commit d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279 upstream.
> >
> > tty: serial: uartlite: register uart driver in init
> >     [ Upstream commit 6bd697b5fc39fd24e2aa418c7b7d14469f550a93 ]
>
>
> As stated before, those are 3 totally independent changes.  Any chance
> you can nail this down to just one of the above?

You're right, since this issue is intermittent, it's challenging to reproduce
consistently. Pinpointing the exact commit would be ideal, but it will
require more time.

>
> thanks,
>
> greg k-h

Thanks,
Naresh

