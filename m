Return-Path: <linux-kernel+bounces-888572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63253C3B396
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE937425157
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A964330326;
	Thu,  6 Nov 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPWslVu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB7329396
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435162; cv=none; b=TZoytXAXXP5hoG8VYUrvH5W833deovBSBqObb4plQwVdHEBQkU/LxXrN/ihsTSOAiWzDNpRg1wpDmvfYU50j2yYAl/GM75GM8sQY9dmtBMWlNtv/nFc9BpI8N41T+VJTvdOHRTL/h1E5xhflpSG5x+hl8e7L+boLeSbQLqVAg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435162; c=relaxed/simple;
	bh=DeEJsga8X2O3ZMGaj85I+rgHyhM9Q10HpKR+YWn5rS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2pS03D5sIQrcRUgumJNAKFmjvtbBN2i24wKF8vTw8T4+OPBuCvAJ699kcwWzqwxkZn+dGtzFb5NAptwiIVjo+KlJ6WILi+nf2Jv6Zo7KEW9MooSpMc3d3Nmvgq0nJ3XL8LW1YQaahWdNZFl8++slaoOz2VnDYgziIVN8xNTRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXPWslVu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso1599079a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435159; x=1763039959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeEJsga8X2O3ZMGaj85I+rgHyhM9Q10HpKR+YWn5rS8=;
        b=mXPWslVuBQVVKJHqjsCQ90hn2UIUrTPyaL6lzw1gKGOqWAmH2gIiR3Y0kNYyy0hE3V
         ueHEoPjqeKiElyWfcGkhqWZLXhDi82p4WX48Zl6fK+3pmwnaYks3RTfiMtUwB9hwXwEd
         8O5jopzFO8RWZBwhUI/qlN372IwPFoujdgVFdqjAEXBZ+ZXMD2JySdbEUEL2ZTxO7x2p
         yTfhv0UW4oNKrQ/eeuw77xm8pPjLb5aWb6/c/tS8OHg0n15paU/+z0JTlSFzRDK1yE4d
         wJZJ5byPQJIVVreXQPBx5vOSaB/GEjfKJtgq7NbanZpn1rIHOn061OPJOZl7m2dBC22b
         bzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435159; x=1763039959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeEJsga8X2O3ZMGaj85I+rgHyhM9Q10HpKR+YWn5rS8=;
        b=gK04AXqji8hu+Vyc4v6sK+lCd97/TuoC30FI9IKsIU+TPmGpsE4UeYAbQbovwc+Bdi
         39aKYH7J/eFcyyXNwpV9PfYqdJhUIE8ahJRfJEtsTNva3qVoWpQzKtd0QHzBr8qpMZ/w
         knOwtre2cRyCfG5wxBWGJaRsDdaxrL8676PLNhdRGdca0FZm3zdSKLC66Rl4EmSogViO
         hhtSRAjFUAJDjgQMArN03fG878dOulH1Lol0ma2iLJ2D8iBwLSUSaXlIzdeNbnbdWRzm
         PrM/GxhwEPSW1DUHXi4lrL094gBADhpcMJZwgf3UpsqtZ0+TkEzqR052F1dBUwY6RmJn
         m0dw==
X-Forwarded-Encrypted: i=1; AJvYcCXPct41Wdok/RCMJ3jvne82bsjPAoM38QDQmhDFewB1LlyISuzuvvhd6ccBjDT6sAJGiTx1AUyjmNlAq48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3/tHGLyOpETBiQTaiYP9GdzXpX/w6Yi8tHMhdB8zFqBOv7l1
	dY82+CeNmOvd4OQ+BN7dSCDxd0HnKsOqB6/YjO2uDSjm2nvTMvp/OhtOUarb42OM0P5RBDCNUKe
	As7Cb6q6tuD/Fyn7O/3j6+H6kjIz36sE=
X-Gm-Gg: ASbGncvNJxZnvzU6tUJgtoyI+RPOjk/pmJLuVntL1z+GXRTSpOZa4vYaLT7Ew30uBZM
	Rp4SivwM5Dt7lNZW6EpRLrUMLa1htRZd3VoBuSg1fj+fposbuNpn8fAISFl1vllqN7dUiqcs43b
	5aJc6ofW9xCZgus5DOVBGkHuZE1PRAjEuk3qK0HdPr0/yMiBt61u6wIZPSOldjIwqYLt/9lACz2
	WF6Iq/m8PGaW+VAo5ve2aP8telSAnko0K3oY2YWAqsxNEwF1hifCRL0BedL/Pn5DrBQvzM34cQ6
	gceRmiwoCi8ALX72X97LTheqhA==
X-Google-Smtp-Source: AGHT+IGxs+sian8Sm9s90Hy3ND6mTfZ+z8i6/WtEjUDe9ivLlS1ryoHlAEFf7rvbGl8JcDIgKKkxWD6QKWjAKZ8vedY=
X-Received: by 2002:a05:6402:1d50:b0:640:c807:6af8 with SMTP id
 4fb4d7f45d1cf-64105a582f8mr6791886a12.30.1762435158807; Thu, 06 Nov 2025
 05:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local> <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
In-Reply-To: <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 14:19:06 +0100
X-Gm-Features: AWmQ_bmyw0pNYHXADFAd6fmPUn7Fnskg_NMC8tjfXErLEc176QKVF8M0jsu-KY4
Message-ID: <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Thu, Nov 06, 2025 at 01:06:06PM +0100, Mateusz Guzik wrote:
> > I don't know what are you trying to say here.
> >
> > Are you protesting the notion that reducing cache footprint of the
> > memory allocator is a good idea, or perhaps are you claiming these
> > vars are too problematic to warrant the effort, or something else?
>
> I'm saying all work which does not change the code in a trivial way shoul=
d
> have numbers to back it up. As in: "this change X shows this perf improve=
ment
> Y with the benchmark Z."
>
> Because code uglification better have a fair justification.
>
> Not just random "oh yeah, it would be better to have this." If the change=
s are
> trivial, sure. But the runtime const thing was added for a very narrow ca=
se,
> AFAIR, and it wasn't supposed to have a widespread use. And it ain't that
> trivial, codewise.
>
> IOW, no non-trivial changes which become a burden to maintainers without
> a really good reason for them. This has been the guiding principle for
> non-trivial perf optimizations in Linux. AFAIR at least.
>
> But hey, what do I know...

Then, as I pointed out, you should be protesting the patching of
USER_PTR_MAX as it came with no benchmarks and also resulted in a
regression.

