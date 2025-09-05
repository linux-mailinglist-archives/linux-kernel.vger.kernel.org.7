Return-Path: <linux-kernel+bounces-803780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79933B4651E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116905C7223
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8D2EBDD0;
	Fri,  5 Sep 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuhDmD+Q"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF14285CB9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106237; cv=none; b=MRH/CPtErqvUH1w5LPwqyTTsU3Uf5jvBHFt/BReJhf2fCKEhe+OqIZTgHAGVCwC43SuyTRY3g9d4TzS9Sjyq1pM2j1zU0tJgmoOnIsiaqnMWRJkRDcq4hsP56vnAMdda4dDwZmgxfZA8bE5wk76sAOnGbVcFcKZhYKAOZOfHDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106237; c=relaxed/simple;
	bh=2qxjiecdOA4RF6h3Y0hYloSjHErvoYXsbOiReTTNtXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyvOSAe5xIusMEbWM1l2MFLSl9bERh4X+p/4CHJCcy6Bn6W61oDbztdXPHcnJLkKdzZ1wwJ+kmrtJYWYY9rbwXyMGa6WUq00IDEjTQd21vEMCflMWbNqluR6Kh+tTggBaOqJtwPTd7RsmDAsOITIahepUx/QMiYJeYzHXp5/HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuhDmD+Q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so20725e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757106234; x=1757711034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPyIINiU/ceaI2cj/Yt91Ki4eqt+oAkeBgX7XlUsaZI=;
        b=LuhDmD+QMwq7GfpTab2Bl5qMacvc6ry+gD4v4QelOW0OuQLwkNuzLEslJi5YbGvGQe
         m9hJb2Dn2G2av0vPCeoHkrlAZ089EwEXSzyMPvTqTJHiElTkD2otKOEKW24Hg+laN5R6
         JyGtwLiQBx6Bi2DBE2hn9Srv2omVGNU6Vra3z+8foaR8SAThjaqTlkGpyu9hMMXxI883
         sjTBbrSJ0y/N/fSrSrffaf0xdCtXAEIUJIoe3AteIpRKLeC22tKkgQ+JHYRI7fRPnilm
         ZCLsTygR8nFlNg2QUQyrN0U9WOT4O0NvfFuXBjNGGyE0XCLImp6HntqUBmUE/ubNzTbv
         g7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757106234; x=1757711034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPyIINiU/ceaI2cj/Yt91Ki4eqt+oAkeBgX7XlUsaZI=;
        b=JBQvkSDxRJZYQh61+yP8S3kDp6S8XDdElhAEZFlVgN/KfLAJ6Z141ytSy1LGh9MIag
         7ur+yKhMAgq6t72GEF9zWcdSspOKOLSJHDZe8PZV64IuOyNXNcfqOhkn85Bs9Bc7JwEk
         zbL/mHsN/CmfEkgXWGabb0/qRE17zOITKhF/PaKTTB2EteYRCSxEZREQ6kSrFiF3Ot1F
         WEmw3D03QNou8epnJaQYPvSs1MeuCNwQ20WNdm1IjU36dz0rskB9JYrdptq2RtRfzzQ+
         Yx1YKnRv+f8Z9gPwOTKCJqvfmd2jDHkYCUOs5tS2SEHW3mb04vgJXuWXh0tgTuzOrvsk
         +yew==
X-Forwarded-Encrypted: i=1; AJvYcCXWZTw1vXm0PHieFNBUhPdrMzc/xjFedAXlh0ftUNuIUcKyhTpqVyq7GCA06BpxnWSmFYEXZKpdO943nUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYy69t1JZRguOwKhWGlYCcKf7cESubWLL8iLSY7OtSlgw15SU
	1vD7anNgmo8mUX96fFx37uZrJdQR+w+qzgpt1zCMbuTZler0bF1onxcGh5s3WbBlITcsNgUXzac
	ckrDmpvq9uxV8fu+BonokVsBRJB5agEDMh5kVPOXs
X-Gm-Gg: ASbGnctXzHuepR5kqKbbZiOTmAlYtJtEOE/iVpyPR9P3pm/8oFLsd48QiCG2PThqQlE
	A2yJZ7uqUnLl8wiCWyKtUKhbRFPClsa+xwqxB0Mpz+mY+MBRBpaNlmSo7HW1PW/RN0irY244TcQ
	4IWuw4zXcXMjDiwldV0zj4cObmBm/cjT0v7DYcpBAA8F5buGfabAyvZDUwbeluHVy+Pnvd8AoX5
	OtYblMxqHOGl3/iQr5JPgi6OQ==
X-Google-Smtp-Source: AGHT+IHfnLuS8/hFfgk/YHQsdhLGdiMAZxHIYm7G3lXTwcShqcMGim7FOZX7jFPvq8GAlqHgICGQ/V2KHajcGPUVs4w=
X-Received: by 2002:a05:600c:4f50:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45dddad796amr298505e9.6.1757106233773; Fri, 05 Sep 2025
 14:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903203805.1335307-1-tom.hromatka@oracle.com> <20250904175138.GA886028@ZenIV>
In-Reply-To: <20250904175138.GA886028@ZenIV>
From: YiFei Zhu <zhuyifei@google.com>
Date: Fri, 5 Sep 2025 14:03:42 -0700
X-Gm-Features: Ac12FXz4r5dUSwU8ErtpQOTyiN1SLsGRcsf4tz3TSVCAhgm3LT_uELjv0duJZaM
Message-ID: <CAA-VZP=ZDsEESH0XJLiOp0CEBVR7DQn+dC82PdWzLqVTgSB_HA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tom Hromatka <tom.hromatka@oracle.com>, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, sargun@sargun.me, corbet@lwn.net, shuah@kernel.org, 
	brauner@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:51=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> Looks like the only lockless reader is
>         struct seccomp_filter *f =3D
>                         READ_ONCE(current->seccomp.filter);
> in seccomp_run_filters(), so unless I've missed something (and "filter"
> is not a search-friendly name ;-/) we should be fine; that READ_ONCE()
> is there to handle *other* threads doing stores (with that
> smp_store_release() in seccomp_sync_threads()).  Incidentally, this
>         if (!lock_task_sighand(task, &flags))
>                 return -ESRCH;
>
>         f =3D READ_ONCE(task->seccomp.filter);
> in proc_pid_seccomp_cache() looks cargo-culted - it's *not* a lockless
> access, so this READ_ONCE() is confusing.

> Kees, is there any reason not to make it a plain int?  And what is
> that READ_ONCE() doing in proc_pid_seccomp_cache(), while we are
> at it...  That's 0d8315dddd28 "seccomp/cache: Report cache data
> through /proc/pid/seccomp_cache", by YiFei Zhu <yifeifz2@illinois.edu>,
> AFAICS.  Looks like YiFei Zhu <zhuyifei@google.com> is the current
> address [Cc'd]...

I don't remember the context, but looking at the lore [1], AFAICT, it
was initially incorrectly lockless, then locking was added; READ_ONCE
was a missed leftover.

Can send a patch to remove it.

YiFei Zhu

[1] https://lore.kernel.org/all/CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNi=
Eg0qbD3w@mail.gmail.com/

