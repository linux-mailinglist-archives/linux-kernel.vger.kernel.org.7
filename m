Return-Path: <linux-kernel+bounces-737343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CDCB0AB27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E303BD40F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843421ABC8;
	Fri, 18 Jul 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8itxYzV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CED20FAB6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870766; cv=none; b=HOhflxBPT5Jl0PxTT1uYhlziF5KOw4oJcJkyCTVrD99A5qh+wmy7aSZ/N87yNrb5bbaEyI7mDSfH1VQRDsjpHCBr0zI9YbeasHGisYOvXafSCFItXx7Hd1oSJOwCCcmbvF0wuPBTeEhjMdj9HQ250urz2HieM11dyah5qgasK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870766; c=relaxed/simple;
	bh=VYLFPInX5wYDsdSBLHlW5bQbgZ8bMLX6OLJt3sa/vVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvJbioF2fZcoRlbaGYf0TJFKVBqLSnRhAI27/5y/U+79XrhQOd36ttajBByrlgVwIIWbhh9/gvkXc5sEYffcaKMwypLcdfjZfVWzgpnZKGS+0hJ1PKSy1CgMexMalQpWq3cbJcOB642ULLBqRSiE33SdUSOz4h74Gg+3i32P/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I8itxYzV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234f17910d8so23302635ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752870761; x=1753475561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKZtbK4lVu+Fa2vzfgm/vl63kukiWlzYzbXwLbRXVPM=;
        b=I8itxYzVHzQwdBhRTNS4RfpHY4+ttbKbzKb38RDKuY3Y20TX4vEZ6t/1aDuWrtjxzu
         tpa9TZucOQGRzGaEpVHdmNf7Y+/8wj3H72Hkm9mfXX+786li/DoNHO7ig/bracc+1VDx
         DRRg4VWA0zCJtVmU6IaazxwosUEgpHqq5GGAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752870761; x=1753475561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKZtbK4lVu+Fa2vzfgm/vl63kukiWlzYzbXwLbRXVPM=;
        b=aDKc7/pDblFgBWcRcNzz/aPIEeHf8gQa33LRG+UlA1P0MhUiB3OB0bO55tKAqOQJ+6
         +reu05Lt8aiKG1EEPhIQaWutFN7jiLYqlWhw//sXZc0mPsm2pLmOc/tMu044Jiq0TgxA
         wfNoHz6QUuu2LJ/r60eP32uf0caFZ5G9N7gLxtUPjvBpihB39m75zqFB+8VNCXncb2aN
         aPAbZoExO1oQxXTztQkdwW2mJEajehIXPEGdDWhYiFulHem+7zfp05UMmcCkKs7/28CB
         I1/5cLWkAKkgL/b+JbHJM6HpzTBDftjRA9FrKF9aa/9gfKxxY8I9buSWqzSd39xajbb7
         C9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ExTBohVAn03UtgvtNE2G/aMkbz4CWUdNAa8ZzVKWiKLJe99oYGu9S1QyU5L1abqjXdVq/kwMYe8x0s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQmxYPuxtwJy7XtWBKQ7JIr11RPg3lhSiLK6Iy6Jz6hvCf6PL
	O6D5PC358VxX7r3q5L3rTLn89/rLWalX/TY7oEUjtlEB1jR6M9A1gpBJ+FwDcT178vSsK40DA+U
	SeNs=
X-Gm-Gg: ASbGnculY4GPfLXtWuFDwzj535zVj5gDd6UjEA37oTk1YO5cPyP/tlWQmfDDaa9Ghml
	QLA1JOV0aDStWOC9u3sF4MwjJh5qST+V4WCWpb/cFAqTd938chtj8o3kuJMPsI2KphU0YJzD3fd
	v1JVUM+JfFHsPG+CJ8irT2hjr6zJ45kFtkSiZRiVtxFONPnSrEYHb4lAEdTMtO4/GPoMOWA6HEE
	9p6bZZ1I+XMU328Zbi13v+fAH4dCuw15dv8nW+zKUfq9mgjIX7lFA0xbNw/92DvJfj6xoYUfHbh
	8Zi2x6xNllI9lQkS4zTuz9NUsxoP4kh9p0MAUCop86YXa6GVCdC77uWwIImhulgHkAFEHN36YiF
	j5h458fYiNgPbnmL4SD1bk3EH5gw2P7+R08DN45mjcg5m1mIGPgqR5Nu/xIwyYFX5Fg==
X-Google-Smtp-Source: AGHT+IEQrerjd8Hmd+opRclE8M36glh82PHWhRHyvW+fPCAUDAtdDw5sJ44pUAkh0psLhWxuFLIYGg==
X-Received: by 2002:a17:902:e852:b0:234:f15b:f158 with SMTP id d9443c01a7336-23e3b78d404mr50540735ad.13.1752870761508;
        Fri, 18 Jul 2025 13:32:41 -0700 (PDT)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com. [209.85.215.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4addsm17647415ad.128.2025.07.18.13.32.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 13:32:40 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3508961d43so2282541a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:32:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBpaL3w+gPAqRAKJa1KbFKGSqD15pZ4fB+f3NTGvNfJe1DG2xuT1yvNYyUPAKZl955XQp+2NXc93JPlVA=@vger.kernel.org
X-Received: by 2002:a17:90b:2e06:b0:312:e49b:c972 with SMTP id
 98e67ed59e1d1-31cc256fb86mr7355028a91.15.1752870759183; Fri, 18 Jul 2025
 13:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164053.284969-1-me@brighamcampbell.com>
 <20250717164053.284969-2-me@brighamcampbell.com> <CAD=FV=WYBFrm-J55BTEJ7s=Jk4EFuMVAkahVZfdzW6V8mxE7Tg@mail.gmail.com>
 <DBFCOJFGI5HB.1RNJBDPNTEL2U@brighamcampbell.com>
In-Reply-To: <DBFCOJFGI5HB.1RNJBDPNTEL2U@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 13:32:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZUr=cwAQyPFWVDXg4pRavLWChpR4dOOyUywQN4GdE-w@mail.gmail.com>
X-Gm-Features: Ac12FXzSqdFPsH4TrONq3wFHu-HzqqxZ5pwzD4g92X8kRwKlib7OsOrk_7f6tnM
Message-ID: <CAD=FV=VZUr=cwAQyPFWVDXg4pRavLWChpR4dOOyUywQN4GdE-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm: Create mipi_dsi_dual macro
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 18, 2025 at 10:17=E2=80=AFAM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> On Fri Jul 18, 2025 at 10:10 AM MDT, Doug Anderson wrote:
> >> +#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...)           \
> >> +       _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ##__VA_ARGS__)
> >> +
> >> +#define _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) \
> >> +       do {                                           \
> >> +               (_ctx)->dsi =3D (_dsi1);                 \
> >> +               _func((_ctx), ##__VA_ARGS__);          \
> >
> > nit: shouldn't func be in parenthesis for safety? It's unlikely to
> > really matter, but just in case it's somehow a calculated value that
> > would make it safe from an order-of-operations point of view.
>
> My assumption is that wrapping _func in parenthesis would cause a
> compilation error in the case of _func being a macro (more on that
> later...). I'll test that later today.

Huh, OK. If that's the case then no need to do it.


> >> +               (_ctx)->dsi =3D (_dsi2);                 \
> >> +               _func((_ctx), ##__VA_ARGS__);          \
> >> +       } while (0)
> >
> > Can you explain why you need the extra level of indirection here (in
> > other words, why do you need to define _mipi_dsi_dual() and then use
> > it in mipi_dsi_dual())? I don't see it buying anything, but maybe it's
> > performing some magic trick I'm not aware of?
>
> I mentioned this in v3 after the changelog and prompty forgot to include
> that information in v4: The extra indirection between mipi_dsi_dual()
> and _mipi_dsi_dual() is to allow for the expansion of _func in the case
> that _func is also a macro (as is the case with
> mipi_dsi_generic_write_seq_multi, i believe). Compilation fails after
> removing the indirection.
>
> There may very well be a better solution to this problem. I'd appreciate
> your thoughts.

Wow, crazy. I think the C preprocessor is one step away from magic.
While I know there are rules for it, I often find the way that it
behaves to be counter-intuitive. I can't say I've followed exactly how
your solution is working, but if it works and is needed then it's OK
w/ me. It might be worth promoting the note to be in the commit
message itself (or even a code comment?) so future people trying to
understand the code will have some chance of stumbling across it...

You might hate this, but one possible other solution would be to make
a custom `mipi_dsi_dual_dcs_write_seq_multi` (lifting it out of the
novatek driver) and then say that the "_func" parameter can't be a
macro. If you did it correctly, it would be a pretty big space savings
too. Unlike how we did it in the novatek driver, I think a proper way
to do it that would save the most space would be:

#define mipi_dsi_dual_dcs_write_seq_multi(ctx, dsi0, dsi1, cmd, seq...) \
  do { \
  static const u8 d[] =3D { cmd, seq }; \
  mipi_dsi_dual_dcs_write_buffer_multi(ctx, dsi0, dsi1, \
                             d, ARRAY_SIZE(d)); \
  } while (0)

...and then mipi_dsi_dual_dcs_write_buffer_multi() would be
implemented in drm_mipi_dsi.c.

With the above implementation, you only have one "static const" buffer
(maybe the compiler is smart enough to combine w/ the novatek code,
but  it might not be) and also only have a single function call taking
up space in the panel driver. You'd only have the "custom" dual
implementation for the "write_seq" stuff since that appears to be the
most common. All the other DSI calls could use the normal
mipi_dsi_dual() macro...

I was thinking of suggesting that as an optional followup to your
series anyway (for the space savings), but it could also solve some of
the preprocessor woes. :-P

I'm certainly not dead-set on this, so if you want to just keep
something like your current solution that's OK w/ me too.


> > Reading this with a fresh set of eyes, I also realize that this macro
> > is probably vulnerable to issues where arguments have side effects
> > since we have to repeat them. I don't think there's a way around this
> > and I think the macro is still worthwhile, but something to go into
> > with open eyes. Possibly worth noting in the macro description? We
> > could probably at least eliminate the need to reference "_ctx" more
> > than once by assigning it to a local variable. I think referencing
> > "_func" and "__VA_ARGS__" more than once is unavoidable...
>
> I'm using _func, _ctx, and __VA_ARGS__ more than once in this macro and
> I don't expect the indirection to fix the potential issue of unintended
> side effects. I believe we can use GNU extensions to eliminate side
> effects to _ctx,

I wasn't thinking of any GNU extensions. Just using a scope-defined
local variable...

#define _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) \
  do { \
    struct mipi_dsi_multi_context *__ctx =3D (_ctx); \
    __ctx->dsi =3D (_dsi1); \
    ...

> but especially since _func can be a macro, I don't
> think there's much to be done about it. Not sure about __VA_ARGS__.
>
> I fear my inexperience is made sorely manifest here.

I think it's a rare person who fully understands the dirty corners of
the C preprocessor and I wouldn't count myself as one of them. I can
sometimes make it do what I want, but I think we're up against my
limits too...

-Doug

