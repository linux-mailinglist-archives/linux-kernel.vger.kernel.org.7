Return-Path: <linux-kernel+bounces-728332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6AB026DF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981BF541B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236B22129E;
	Fri, 11 Jul 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DnN/go4q"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C21EEF9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272362; cv=none; b=mQzWGlm3ZsHeDcnUGeMluScpttT8EdyLd09vawdfEF6boF3aorAH1qAuVHpRcMFrlzAgb5YDjdlLU40Rnktadj6dRrXfcwa4WF3OrbODoXAbE9IygKx4bcwupLMIcC2HL3714IoK8qRbb/z9jtCwKD3E101mDYJxOtsjjheGq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272362; c=relaxed/simple;
	bh=cV4UcqxxRYWfbmVEzgOiPRHwVxe4uXh/78AqAa2cIOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijWRy5aYyNabvULcokbjwUeqNGWLQoGRzu3dMwbL/a5KruEXonXO53lYq2g++QHzxbavyd1rMlcqLJ/w6P2PLiGZUFa72qsnHsEuVRrz4d/8YbUc6tdKsOSI765TPE7xRltRZqqFOTnG8HaXvmZgLqmkfQ7ZYknbOCEzdMyOQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DnN/go4q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso448855166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752272359; x=1752877159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hD1RvSl+QN1nzm7kw4Vc4aGimUiL6opjjB0+F8WN/BE=;
        b=DnN/go4qj8y+fl6/pBiZsCf40w55izuAJKR4lZ0PQ/5HhhsELvDpmR8YwL1Ya54zCh
         zRs7f2sR6Eny5FkbfL7VIZw6q8pwCalapkioIZESpw1D4tj3MIu6vjE21YD/ojSPV49y
         bHJVbDT74X6MUxreB5HwsjlHuzI3EgZNae7ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752272359; x=1752877159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD1RvSl+QN1nzm7kw4Vc4aGimUiL6opjjB0+F8WN/BE=;
        b=NFBIM8IHK8MNv8seNZ7hUYpiyq1RoxEUysrlD8VRzd/yrDOrkRkBNZUvQltWh3dGZa
         BisJtXAZaKauEE/ir64J7/BpWQc9OFJEilXCZl51+Ou58QxRa3M4pauuVaur7fcMsi6y
         sCrN2v9r1Vpj7FfJfD2H9byme+nKIbJAGTklCFOTaZ3Gy+NoOOtBiXVofUUEAmhq90w6
         eVgpJx+FT0/QVyHUKpY0TVkLVoWGQpoSP464YFZsKTz4ODNAqAENhg4OOsydEkWcM+Vz
         JE5A2bEFow+t9wvoYMvusYgHj6zMn8kE/fEposN3yQDqq/xrmifVowPgaZFtPo4VlFAH
         mIOg==
X-Forwarded-Encrypted: i=1; AJvYcCXNxo4wl111YdXUavJM75qzItKmlxMqsDDYAlMaVD4n+qDalDF4h/I7Ze6RoWRETeYsgYZWzIPY5UwGjqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIREBTJjkJVVP4yRJKuYzOMoOBdYs/Zqpz7vnI7nYwt3V3rot
	nTJsIzDYm1zJtnucE2lrt8v0PB9Fw71bjsYGnmkxOq2Ei8PwKSc3J8QVxGzGnhwvneQ1XGK/xjq
	F3uDvr7M+EA==
X-Gm-Gg: ASbGncuPVubqdCu7OH9kdFlqHs+mW91kaHT+nTj5vRPUzgIZG36YTfVofWIhiU6FXQY
	l5X7Kz72iAYKOsAu8rnPsmq+IU/Q161CB734aQo/WIlXHsKB8nLweMph71MDRJSIx2Oztp7itJw
	dcA31SEPaT0IgjejIfsUPUrh5F7kgoIY8YoygQT9g6jotaIkwAdBoWwMo+6CMg7YNv+ZO5o9Mze
	vszN/NC10/stbhcD4ZG/oYQTS3jfNQHeFrLfYRCwMCnUIvrtLU6XZEw/XLeqyppyIwiDukGs7rT
	JOt9SxPEf138SZCAnL1DSsQQh5B65AqRyH70Zo3cua1Zp/4HF4ZOcmJIiePLSndI2caCQhsj10a
	G4pjaoVrwZZ0Tl4Qc52c5TYWo3ioHrqNSebGs1rSq1Ygm49FZY/R+nBbQ+LtZ9VF27ZKolC2s
X-Google-Smtp-Source: AGHT+IHnljl3EoHr2QJHdNdkGQlGa95fFPzl21njwpGwMPOrhM/LYYxKpAfk8FdqXO0ckUiN86hN4w==
X-Received: by 2002:a17:907:d867:b0:ae3:674a:9af1 with SMTP id a640c23a62f3a-ae6fc3f467emr535050066b.57.1752272358575;
        Fri, 11 Jul 2025 15:19:18 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294013sm365879266b.118.2025.07.11.15.19.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 15:19:17 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so4256304a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:19:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoaT95fWyLYGTGoZdrXCk2f9IateEJD3na/t+DXSv4uB/5bsFrz3/Hts61Zr/uCwslHYR+GiWVA/KG3sU=@vger.kernel.org
X-Received: by 2002:a05:6402:26d5:b0:607:2469:68af with SMTP id
 4fb4d7f45d1cf-611e763864emr3673212a12.9.1752272356713; Fri, 11 Jul 2025
 15:19:16 -0700 (PDT)
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
 <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com> <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 15:19:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMJWwgJ4HYsLzJ4_OkhzJ75ah0HrfBBk+W-RGjk4-h2g@mail.gmail.com>
X-Gm-Features: Ac12FXwhFwpN-9mAZlnlZx9S5volUcLxcJpIoAPgiTJHzwbOULl1vFp-wYR4lIE
Message-ID: <CAHk-=wiMJWwgJ4HYsLzJ4_OkhzJ75ah0HrfBBk+W-RGjk4-h2g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 14:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've only tested the previous commit being good twice now, but I'll go
> back to the head of tree and try a revert to verify that this is
> really it. Because maybe it's the now Nth time I found something that
> hides the problem, not the real issue.
>
> Fingers crossed that this very timing-dependent odd problem really did
> bisect right finally, after many false starts.

Ok, verified. Finally.

I've rebooted this machine five times now with the revert in place,
and now that I know to recognize all the subtler signs of breakage,
I'm pretty sure I finally got the right culprit.

Sometimes the breakage is literally just something like "it takes an
extra ten or fifteen seconds to start up some app" and then everything
ends up working, which is why it was so easy to overlook, and why my
other bisection attempts were such abject failures.

But that last bisection when I was more careful and knew what to look
for ended up laser-guided to that thing.

And apologies to the drm and netlink people who I initially blamed
just because there were unrelated bugs that just got merged in the
timeframe when I started noticing oddities. You may have had your own
bugs, but you were blameless on this issue that I basically spent the
last day on (I'd say "wasted" the last day on, but right now I feel
good about finding it, so I guess it wasn't wasted time after all).

Anyway, I think reverting that commit 8c44dac8add7 ("eventpoll: Fix
priority inversion problem") is the right thing for 6.16, and
hopefully Nam Cao & co can figure out what went wrong and we'll
revisit this in the future.

               Linus

