Return-Path: <linux-kernel+bounces-861233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC6BF220D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAD91888544
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01DF26B2D3;
	Mon, 20 Oct 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mwZ42Jk/"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53F26AA93
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974403; cv=none; b=AY0dPXfRv0Gp/Bua7FwStxnfeVK9Dr2CwxZ9/rrhpMaoETMx74dSODi4pDvuDUsrjMgPOxRh239eTc2v6eTaSl2+O7UVs4QIpBznd7T64ENy4RAqF10KU+rOOCyV1MiRyeBL9u4XiSM1NMiS7NhCt2Ydjb5B80qPEqQK+tKjhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974403; c=relaxed/simple;
	bh=SjkshpQwLTLRbD+eZtAvctlD+BBhoUWZEtmyD1byVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz/YFCi6I9cixYtyazPhZkJYQKKLR9/SYMF0JHr6LR80ijeY5zmBUu8zX+OImCMjCarKvYM/uPJ+jLxP/avJ+z8hUCoG+bz1TwTvgHnhd3idqQga+SWinJxXiOGrj11T8fIf7whq2CyFgV3QwW7BikGwA1SdMXvRbBAK83+GhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mwZ42Jk/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b593def09e3so3004401a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760974401; x=1761579201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JuL9YY29cMVp873R6ZcsLh7ieA1MFSF5v2e/KTlo8Y=;
        b=mwZ42Jk/XEeKaqBySkCoo9RDfP7GDu922QCtW1vEtzNxOV+q6CYSAjb2z8LkkmWIxc
         glyBT6b7I4jtU9c8PACaGnfENlr/zpcUQrcIyeqcWDeH2ZQQhNZi6rA3rc73VuNYqdEu
         skEW1ytP84IlrMiN66OzFBWU8RtpHR2YWlQj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974401; x=1761579201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JuL9YY29cMVp873R6ZcsLh7ieA1MFSF5v2e/KTlo8Y=;
        b=SnDqyi77e8zH1dDuKIVRkklI9+enxtb/bTkkW7SvajupCwVCjVEcCr0C7G/j/0DGmW
         lE5wL1qwR0S3DBTXqyqyy3YLG08UhcK7lKUMsV2WkjrXAAa55zsobiVGsUPAi4mwEWBb
         ZHrFusm9IlXLiy62Zm8UJyPyeYUDwuLYtRglhW04dWN/59cFS+XcZkm44SnppzWdgeNV
         hT2QjeZyS5jakkp1YEkXFyZpuDCMHIdmZSts6JNjwh81MIBfZR5dKInc5+aHyck7c3cQ
         p3J8f/bvdH7xYcWykVxBzraDzl2YYrWxIMplCrXG/8HON7bt2pC1K9eeC9zxbFvoOLWA
         1t9w==
X-Gm-Message-State: AOJu0YzxkJOdBVChNmQghp88AvZbJ8groukXA6dmuXjUb4otZGO3U9AC
	63UJh3YqdQdD3Xwk7nV4+y+VcljWiU0Q/PiVgSSW70zxiIzj/FF39Y7+PyVhMXVLC9MoctyP0tf
	ytZA=
X-Gm-Gg: ASbGncu/TAF4o6uG2r9xr/CKXc9neKpVncFs8GYH9+k8LjGP/GSk/fo2YtF/yrwrouJ
	MHrHQwHt4UxNiwaTRjwQvdT/LYJmmXBbAOQZeO6BOtyJG1WXZjqw2OdHuwIjK2V4nv7DR6HtSXq
	kzp1ikkyk16DT1+pzzWIyInYFN1pOnaDlogkdJ1XAHEpXBqDUkc2UR0pIlYKjhhWVN7oFEwHygZ
	ihsQvFd1B8pmqXGQiHjiM7b7UDKjh8Ue4dUGIFUOnVZjZ8oaFfKrVZpNHxkz0TkRAJ5lCkb+G6M
	kwWf116kWOrBa22AVhab32PIrjs3xyxpJieDFT9+J4WIqcUlS6fXV2ZDRwivjJaaNCxrZNDBZms
	0tW5r8ug2UIaPQp3t3GazxiOHVgdGrwB4zQCzq+QjkWMPZJcohvar0/ysxLQWskWsrnSw2dsU8b
	JNySdf5LcpacLmtkniPol8jxdUan2J1ZOw3pxO48NW6kVJ8DTy/iwijA==
X-Google-Smtp-Source: AGHT+IH10PR0qy1Jp3DN/pY4JDCvLOAhaPA8pioi97w/FCYMrmvj0cI3Mlh+WzkOHYaNl6KAJ+g+NA==
X-Received: by 2002:a17:902:ce8c:b0:25c:392c:33be with SMTP id d9443c01a7336-290cba4dbc0mr188107095ad.59.1760974401626;
        Mon, 20 Oct 2025 08:33:21 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2b1sm83251895ad.27.2025.10.20.08.33.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:33:21 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290a3a4c7ecso48061395ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:33:21 -0700 (PDT)
X-Received: by 2002:a17:903:4407:b0:27e:ef27:1e52 with SMTP id
 d9443c01a7336-290ca1218dfmr158263555ad.35.1760974400457; Mon, 20 Oct 2025
 08:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org>
In-Reply-To: <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Oct 2025 08:33:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
X-Gm-Features: AS18NWAPBren7rlkQuvdorXHRNqUU6uFYIk47KWN9sTewjNzcUEs0p11g4GStXU
Message-ID: <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 19, 2025 at 3:23=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 10/19/25 10:06 AM, Douglas Anderson wrote:
> > The kernel cmdline length is allowed to be longer than what printk can
> > handle. When this happens the cmdline that's printed to the kernel
> > ring buffer at bootup is cutoff and some kernel cmdline options are
> > "hidden" from the logs. This undercuts the usefulness of the log
> > message.
> >
> > Add wrapping to the printout. Allow wrapping to be set lower by a
> > Kconfig knob "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". By default, the
> > wrapping is set to 1021 characters, which is measured to be the
> > current maximum that pr_notice() can handle. Anyone whose cmdline
> > isn't being cut off today should see no difference in log output.
> >
> > Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> > with "Kernel command line: " and lines that are not the last line have
> > a " \" suffix added to them. The prefix and suffix count towards the
> > line length for wrapping purposes. The ideal length will be exceeded
> > if no appropriate place to wrap is found.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  init/Kconfig | 10 +++++++
> >  init/main.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 92 insertions(+), 1 deletion(-)
>
> Is this (length) only a problem for the kernel boot command line?
>
> What does _printk() do with a very long string?

printk() will cut it off at ~1024 characters. The printing of the
kernel command line is backed by pr_notice(), which is backed by
printk(), which is where the limitation is. Yes, we could consider
changing printk() to either remove the 1024 character limitation or
have it do its own word wrapping, but I wouldn't expect people to be
very receptive to that.

Thinking about increasing the maximum printk() size from 1024 to
something bigger, I'd expect the response that people should, in the
general case, not be printing such long strings to the kernel buffer.

Thinking about wrapping directly to printk(), I'd expect:
* People wouldn't like the extra overhead added to every printk() call.
* People wouldn't like the fact that there would be no obvious way to
connect the continuation to the previous line (no way to know what the
common prefix should be).
* It wouldn't be obvious, in the general case, if wrapping should
happen based on spaces.


Printing the command line to the kernel log buffer is one of the very
rare cases where:
* There's a legitimate reason to print a (potentially) very long
string to the kernel buffer.
* We know that wrapping based on spaces is a reasonable thing to do.

If we want this to be something generic, we could certainly put this
function into "lib/", sort of like how print_hex_dump() sits there.
That function is actually a nice parallel to what we're doing here. It
handles adding a prefix and handles intelligent wrapping that makes
sense for the data presented.

My own preference would be to leave the code where it is and, once we
have a second need for similar wrapping we can move the code into
"lib/". That being said, if people think it belongs in "lib/" now I'd
be happy to split this into two patches.


-Doug

