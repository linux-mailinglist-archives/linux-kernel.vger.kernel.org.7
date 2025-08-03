Return-Path: <linux-kernel+bounces-754531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8609CB19684
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 23:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53DD44E038C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084621552FA;
	Sun,  3 Aug 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SCC6ged4"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BE1F0E3E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754257111; cv=none; b=XT1/1FIBUcTTsyofajnXoFN7KKVWHt+Z4+/li8FLspkkyLq91ApkDSNLEMdrI0jA1PT7ZKV+A93dK7VhsoFjp3QBfJrwV82tJdf10r9pXorwptZWhjUOq5y4QRiwNR9CUPMDg0twHjhpPO5ECiE0C3NJRnev8aAKBUxgKRw5scQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754257111; c=relaxed/simple;
	bh=v0US7hNDRX895O84Qbligoc8eEIkz8N3QYQnRbFG8pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYn5kdLFnFOp3o6ZnaVbnFgkiYW0GjL6slUbXK21cTKrPIAcOj35RSJeH9f0e1YkJWkXIUC2MDBp09YQN4Ur2FBqR5vUeNvXqu5vDXc93jHh5IMY4c4+GnCwWyTwEnIxXyvPZY3JFLjlucWTqqJf7h5hWEtiuA3CeHefCg07kJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SCC6ged4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso4563832a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754257107; x=1754861907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ii6avcing3YyvuFewaWdQlHHWwHPQIDp1iGw8TuzCow=;
        b=SCC6ged4cedSh1gz/v4/oHm7mT6soasz+6+lJy4D7bo5UEKIrTYrVFVSX3ictD2v0n
         5fTqWniUQ7xJ+8f5sOF8z/iTO2B5JqYUGd2jDRf+ymLQ6F6PpDbaTZ8gcA7I8/KPclHw
         dPVMhr38MXSdxBEEJ3p4PmDyRy+vg+ZplUzpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754257107; x=1754861907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii6avcing3YyvuFewaWdQlHHWwHPQIDp1iGw8TuzCow=;
        b=S8/U7TCHaUntZUl0U3GNkaG8gT0RDTVj9s3fn0p13310tekA+W/MEAK/EqjFetsTKj
         D3rUNKkAzN8QmJBz24wJfRsRpeBU5p2THXAFVuPT/iKqTq993xg2RjJU8LFiKNF8mkV8
         m8CN/EhyG7ibMewbHZ6BYaYRFaVG4jjZh/BNB7TFECluhVrXGo1r27D/9HSsFOxut9vR
         3387SHwTM7UYW4+XcYsieK6WRNo5UrtJ4qoZNQ1WBLaXfrf7YmyhB9XXEMJwMSdF4eXX
         rbTleTvokibYYs4WAa5dbSCVQ2LLHYDBWesjWvPDct6cuS52xtOvyXVmp1KuBk5h6gw5
         I6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOTgjC+EQrA1bSJEuleS96+24/MM6AGtBCm25/DHjVhREOoL40K6VrlSXOjMljdn0Fb96JXUgWGyrh8oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlbshCn74ZMQXx0uXMcDeDnW6odvrwr51YhSpbp5sVN7/dxrf
	oSldtpealbNE+xi9roVZEZscm3ZPWCbILy23KGnfWoTzosmOPMgB0MaaRLRSL/P1uzYv2XZjE25
	RdbOdU1M=
X-Gm-Gg: ASbGnctyRXaskLLfxJ2Wh2CU8gyXaLsFcvRasthoWHEHcUYYNNJB/dKmdFZJ56D3wv+
	EVA6/t7GdMQkNistCvPqby1GYd4AjyGY4pAp0Q190UOlGEAIogxXndJVaL/eoq4m3D3QLAfncg2
	D3U9AgSnZKiQoVXNIF/UuE1sOIKN5oNL1SlQETQ89gFPazWFzfxr3goCmnSRJzoENZ96M/zrXO3
	0nRAjyF8JBynRT+NQu6iffb7Dt14IQazGlm6QA3Z4b8tNvGagJ8+Jcxz75F8srL9/9TQYAEOpD4
	ViGgbZwmlb+a+FbgYo+Y+x9YnexDj78Swyf10jsbglxSBJlfW5Rn/5MTBxGkRqEioJ6mPXQOvl0
	2Dmis8/rFYeEqKT1Dsex5764NNbwgEtVyRGI6F0e2R3QAAlcjl3nsEDXSRd49kQ/GkRpk7GX3TY
	sg0M/5Op8=
X-Google-Smtp-Source: AGHT+IEh08SshcjHLo/4dZ4+4UB/YkJDXZgVj2C0+arHmqtWAP521CiL6psOV7+hFoqVQ6je8I10Ag==
X-Received: by 2002:a17:907:96ac:b0:ae3:c6a3:f855 with SMTP id a640c23a62f3a-af940156043mr760471266b.31.1754257107179;
        Sun, 03 Aug 2025 14:38:27 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766f9sm635834566b.24.2025.08.03.14.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 14:38:26 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so3964277a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 14:38:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlf17FkQk7GFjlxYDBAHh8dWHMAcfAs3DnuJhDQ0JlNjugomN7ES0k6QxRu9yUjogBwS4ummhXhPwtUO4=@vger.kernel.org
X-Received: by 2002:aa7:d045:0:b0:615:539b:7ade with SMTP id
 4fb4d7f45d1cf-615e715bf2cmr4825471a12.20.1754257106181; Sun, 03 Aug 2025
 14:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803131809.4890-1-da.gomez@kernel.org>
In-Reply-To: <20250803131809.4890-1-da.gomez@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Aug 2025 14:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbY2xZpj6c-vWG0qeiDVpGa6SLA8DqqAHP2S0mu3b_pA@mail.gmail.com>
X-Gm-Features: Ac12FXzcOEfC3UC0vHGCKY61V0ncIS09ZdbQ_3DkQm0xwwbNPazHgNkkQrf0VPg
Message-ID: <CAHk-=whbY2xZpj6c-vWG0qeiDVpGa6SLA8DqqAHP2S0mu3b_pA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.17-rc1
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Aug 2025 at 06:18, Daniel Gomez <da.gomez@kernel.org> wrote:
>
> Note that this had a conflict with sysctl changes [1] but should be fixed now as I
> rebased on top.

Christ people.

Read the documentation and *years* of me sending out emails about what
maintainers should do. Conflicts are *not* a reason to rebase.

See

   Documentation/maintainer/rebasing-and-merging.rst

and read it. Read it twice. Then read it again until you really *UNDERSTAND* it.

I deal with conflicts all the time, and that was a particularly
_trivial_ one. I'd *much* rather see a conflict and know that "yeah,
we had people working in the same area this time around" than have it
hidden by a rebase that also invalidates all the testing it got
pre-rebase.

And yes, that "invalidates all the testing" is not just some
theoretical thing. We've literally had situations where tested code
became "oops, now it doesn't work because we rebased it on top of a
tree that had different assumptions".

Is that common? No. But it's just one - of many - reasons not to
rebase, and "it had a conflict" is *NOT* a big enough reason to then
think that rebasing is better.

So "it has a conflict" is real information about the development
process, and shouldn't be hidden.

Yes, there are conflicts that are *so* painful that rebasing things is
worth it. This was not it.

And this rebase was particularly bad. You did *everything* wrong. Not
only was there not a good reason for it, you picked a starting point
that is KNOWN BUGGY AND BOOTS TO A BLACK SCREEN ON MY MACHINE. So now
your new work is basically built on top of something known broken, and
as a result, all *your*  commits are known broken too, even if that
breakage isn't due to those commits themselves.

So your rebased state is all built on a base of sand, instead of
something good and stable. And if somebody ends up having to bisect
this because of something it introduces (or even just happens to
bisect into this area for some *unrelated* reason), you picking that
random - and bad - base means that now that bisection is potentially
much more painful than it needed to be.

And yes, this is also talked about in the documentation:

  "If you must reparent a repository, do not pick some random kernel commit
   as the new base.  The kernel is often in a relatively unstable state
   between release points; basing development on one of those points
   increases the chances of running into surprising bugs.  When a patch
   series must move to a new base, pick a stable point (such as one of
   the -rc releases) to move to"

I've pulled this, because I'm flying out tomorrow, and it otherwise
looks fairly simple and straightforward.

But dammit. DO NOT MINDLESSLY REBASE YOUR TREES!

               Linus

