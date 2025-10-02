Return-Path: <linux-kernel+bounces-840795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B536DBB5723
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA044822B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF821E0BA;
	Thu,  2 Oct 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP0FPtH+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1D1863E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439091; cv=none; b=T/yrtblfcEuqPki/bAlSCjg7TSwJ18gSqjzYOE4tzKKlskHDpdkCvFGX2/FMhfUM7g0IJYMHfU9jeAL3RIkvjOQdFHtFDm6Z3MuAny4G5V6edPeoZYKk+e0mEaFbjLXkMWcfWuevPaiJbRQ1wWozXc4PWN9jP65ZLdTSAYWuWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439091; c=relaxed/simple;
	bh=kjwa8w5oVwbbm/t1BJe8Ybw1bm90dFT5cF9cCodXMaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q51iWZ7O7qE9TI2PfFKVHnwPhqK+BM3GzT8RMrE2pVX3A3OqoHwBJpBcGba/Exl5icOFWyvf4szjP8tnO408lDnosk/Yb8BolyYqi4pdWKorqkLvfCQQgJw6obIdGnC3O9VTvm3G7OqWb3YYzUIPEB5upu7wVcV8Hrg3Wmu9ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP0FPtH+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b629a176a8eso61080a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759439090; x=1760043890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37tMfYTMjn8K8wVcdlTFYM9SBeVI90QuK8Rc3p4Xplc=;
        b=OP0FPtH+npS/sDk5I0bt7L5/52Tl3PrsBYtgouat/q4lc2ooCyxB91SN8kK9Tx1fmc
         1QJibacw7iNVN4CjsnlIe+L4UumSzx0paOXj7/1Ksa8hQZxffn61WW3g6f/gzlZgLIMD
         vgQqHWAVEA399MqKsRpRpF/3nRur8AVJEHAobElFZgQwQtROqY+l+FxEzptzDvOnyCmF
         3i4BZ/0w8gNvTZbudIwb3aIfcGhFr/BvIVXEoMShWffYW0KcABXqHVL5ze8C6+tl3vw/
         yBAwIu7ENegi2Mo313ZXh2Wjh0UGCH+7PT8joIwAgU2tBpjRq46WRnfESjjmr0wcNrtN
         yilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439090; x=1760043890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37tMfYTMjn8K8wVcdlTFYM9SBeVI90QuK8Rc3p4Xplc=;
        b=A5srS+V7bQiAkM7uIY/XOtLg9gNtlzM7Lab0DsaoBdxKu2Q9XlJoa9QQUeTFQFeTXv
         BkIqRqA43SZwLfWv8/4Yyoj2Cya2ZpGisXdeeqZoqqVXfBMvaJ5stl7n1yhFs10VOR6I
         TlB51WXEwgB7/aVwiftZ8WhuX76xFI8T3rNpB/MCH2gjANwHKWExHO5Fwcfi/KCS2O6D
         JP0wivNC99HJ2FYl97B8EdwaM7dlXM5eaU+Z2y28hvOaLvN6spffBzp+glSVcbf62b4Y
         vQ7owcbqMnVa4A41VRAKfVNi8acJRFB5ixNeRePEW3i2qFzyEKxm3DhVxUfDrI3AfH3n
         F5kw==
X-Forwarded-Encrypted: i=1; AJvYcCW64RJZx2p3TbTpWkalLCVa8EvlLHHb+DBpXlkul0dLxfMoSl+bzaiUaB/VXhx+bDYEVMx6/5d1Uu1xWPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQc5SeJUGNZC2OI41unLbf1h40C3c30tetgJRhACtLpU4oQIFo
	5/Nm6S2Mg9Apfn0uUYwsKe87X7811bkYpj6fQ4GvOxUNEToLH94UAS6uiR9qvKizJ3HvHDv6tkh
	fvMvK7urViTWcRqgvB/eV/H7mTdNsTEY=
X-Gm-Gg: ASbGncvCNsnSh51yl0QZIDTILhFfR6ZBy5JnuKftCzPRHq41FUXb8Qt/wlWIrEdLuBw
	WMAQA0jxwExNhJWQY8de8mMbirHWis3rQ8XxQxiGfGA+M8kU1BzXTSS+OG5N5dU48JTRXBp9bTM
	RglKKdjMfjoGXjqAlo0gzjkVGFfC//BV4DyISfojrOYMqc/h+jhBre1CvEfdsnptkCkoGXsFfS2
	YFzDtqeUd/95YBpMP1iM4K1wxY6FOKxOs/z2LbFB2JtQUp1mVytlC2jba7jwlGoMF5bAV2CrZqe
	q78OVfZogUQOKcw8+6wYbDD5P/k1PaZCw/JNQyJQtHPvlNygVh9KLQZeorss
X-Google-Smtp-Source: AGHT+IGYNWpZSxtUPX4WQVIPhxuGtEH9m6x04uGV7OnoXrmZNKp9X2f5+QQswOXAY1ab1m/7oMOWgsgYf99ozY8oqto=
X-Received: by 2002:a17:902:ea06:b0:277:c230:bfc7 with SMTP id
 d9443c01a7336-28e9a70847amr4125295ad.11.1759439089693; Thu, 02 Oct 2025
 14:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
In-Reply-To: <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 Oct 2025 23:04:34 +0200
X-Gm-Features: AS18NWCocUx_ld7JV3nL_JdXM0io3tRWkZqj7qj38BDJS7FONdnCPeROETACJqU
Message-ID: <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:54=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Miguel, I know you asked me to run rustfmtcheck, but that thing is
> just WRONG. It may be right "in the moment", but it is
>
>  (a) really annoying when merging and not knowing what the heck the rules=
 are
>
>  (b) it's bad long term when you don't have clean lists of "add one
> line for a new use"
>
> Is there some *sane* solution to this? Because I left my resolution
> alone and ignored the horrible rustfmtcheck results.

We have discussed `use` statements formatting somewhat recently
because of that (and rebasing patches etc.). `rustfmt` allows to be
configured -- it has a few knobs for this that we are considering:

    https://rust-lang.github.io/rustfmt/

e.g. the `imports_layout`, `imports_granularity`, `group_imports` --
some people like the braces, others the one per line, etc.

Sadly, those related options are unstable (and nightly-only), but I
can talk to upstream to see what can be done (so your opinions on this
matter would help).

In any case, for you, my intention wasn't that you had to fight the
formatting, but rather that after solving the conflict (without
thinking about formatting) you would run `make ... rustfmt`, i.e.
instead of the other one, `rustfmtcheck` (which is intended for e.g.
CIs).

Leaving non-formatted files does hurt us, though... e.g. CIs check it,
and I think people are generally happy about the simplicity of
formatting on the Rust side.

So if the conflicts are already too frequent and/or painful to deal
with, then I would say we should already start writing the imports in
a way that reduces the conflict potential, yet making it pass
`rustfmt`. It may be uglier than what some may like (depending on who
one asks), but it keeps the `rustfmt`-clean property and eventually we
may be able to get `rustfmt` to give us the formatting we want and
migrate to that.

Cheers,
Miguel

