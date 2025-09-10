Return-Path: <linux-kernel+bounces-811031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A072B52329
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1812058523E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F93002C0;
	Wed, 10 Sep 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0pjjsP5"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1502FF153
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537887; cv=none; b=fOgMSS0yOVJlcu5ZoGh9TGiB+gUTqec5kvQV+FkhsB6mPGqUXeF5arFPuiY1cWQTJ/xl100k8VeWgULbyw2lITeMcv6lWfLFeJyjLMVL1WiRgPcTDh3O+pA/VNhoBHrW9O9Z1TDh56iG+pb6xutHVyoQ4ekbmRdq4LfF02ma2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537887; c=relaxed/simple;
	bh=BxoYv6ear/flR5rAr5c7A/wGu93sOLIbo2XqrISjEys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uhv7eGpWR2hrdHrNQtHyaMgdHJanQTAO/n5v/c/WgKZhse382eA3cbiPpgz19ULEotTpW4mkV5TDl7HnDfWVvRVKdrAY/84Cz8gC6QYMgfZKlQdYUOfwRS5EIMmUsJs2NCMqOFFCMfPwAiPCVVZNMpUenFi6ee41w8rLqi+VfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0pjjsP5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b520539e95bso1508a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757537885; x=1758142685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxoYv6ear/flR5rAr5c7A/wGu93sOLIbo2XqrISjEys=;
        b=X0pjjsP5yhuBJIIh8KxkB+eKryxWPjMDelIUwOS3qSd7o9ZwonqxHHyivj7pgq03Td
         OXPMmeNCiduFoe4JQyh/Hwh4RTJVGDEJC49/BWv7tUVNpaym4jmnl+AfUn8KztP+cqrc
         DC5Kaq5j5J3+7DuD8giEoouvxRI/42duIFBkbAT9J1s38qj+r35Z7tx/jkksZjOY8zfq
         HcY6R5AraZLnMCBArS7xpZ9hyfIFSBCrJ7nTf4XU4liNxfZoXLGcxSCeSqjCchkblir6
         sA0xAYARY3nOUrS2v4K/Rcr7GewrTOuyUTnza5OQ2U4WneIOWxDa8UxAiqnam1Ub5S6I
         yC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537885; x=1758142685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxoYv6ear/flR5rAr5c7A/wGu93sOLIbo2XqrISjEys=;
        b=vTJykbG1VsK1jVHZXlFxkcP8tyoS7ML0IuMjNsNdKTJqTOes4PhF3yceryk9vsIgdo
         n7FtBEgVEZOohTRv/AqWcIc2iwzBoFmBTnbNXhT8wPQs7MJs5Id96Pjr5m8v/0jsQneR
         +9oFcwJvu+PTHctM2zB0SjBbfv3iVoKOOVPZpztbwYS/MW3NOB4lZXG+Ub3Qwg2kULax
         qsCQoiAqz+zfFu2zYUgGoPvrvERKlQbtKpJXV8622ZMxATcb3mitRr03Db8moSLfJRVv
         eavOJ6Roi4m1Glwi9p0eXe9MJLPdKwvz0+M+0Va4Kn7J3naXlWyjvLu2xT9Y2qnKXDns
         bitA==
X-Forwarded-Encrypted: i=1; AJvYcCVTcLD768TTCAJWkeYwy4sWiVZWP1DZVr/7+QyOrhJK1r+lzkiPBTHNj55cg1n7+2xZZMKHVpRhi0Z1c1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLfCyrJ1uef0ZvNxvvU7iEaR7COaBG2iaImSV3xJ3rW312AhG
	V+JGZnJeEGpKp5v0tvQtQuU+fVhilxVFRI4PkdVZL4LMZYlpPqrRaQNLi0whvDFh+yYD9IqmfW/
	SWAyWSO4fckl7UmT1OsqNp4AZ0E4/ScQ=
X-Gm-Gg: ASbGncsMNUxJT9JrXritLhwZEHS8TPLNGdRNjPq44rhdmRnVn+O1ujFyqg02nXf7BZS
	3+FaifOEjp8Qq8EbAHiJN8PpMC1K3pNOpUMdk3XqtKrHW/HIqzm8h8R+GSe+kEtDQUgAmXsNR/e
	PpZMvQ5A6X9kUipVBm4fgO5mbmniNQxkxiRjjkht6tyGZ8n5MeVOFOUwXRkLUOOWuAAxPGPtHYP
	UmXmpnuzQHmfdFOP61icNlyCI78+J1/byBJqKmz/iJysJdJLrv/8/LXQLuA57hIjJ6Dq/k7wUWE
	9cYq68c3Dnj3/ovYR5CFbUeBBEyJavssvAx+
X-Google-Smtp-Source: AGHT+IHOtyqVloSPxzWiVhs1DHE+nqj8s6NxjWWTZ+mliqirt76YYBTxY96SyGIZl1OENRfeSA3lt8/1dOvRBF8z1YY=
X-Received: by 2002:a17:90b:4a92:b0:32b:87ef:5faa with SMTP id
 98e67ed59e1d1-32d43f91aadmr12103792a91.4.1757537884710; Wed, 10 Sep 2025
 13:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <20250826-nova_firmware-v2-2-93566252fe3a@nvidia.com> <9adb92d4-6063-4032-bf76-f98dcfe2c824@nvidia.com>
 <DCD2VJ1WJW2O.VM7E4PD3DFYO@nvidia.com> <CANiq72=nGbziZCKt=AneE_vXw76i=+td0dSVfbOJ8kJ9eYHw9w@mail.gmail.com>
 <DCOVRI3TVJBN.3OGDSK8HW74LL@nvidia.com> <CANiq72n-q0vdzp=Tb=brue+BMoNYdCTKsqcMYUsvKgvu9ZqGoQ@mail.gmail.com>
 <DCP66O4WE3CE.3P5ZHC9P62LOZ@nvidia.com>
In-Reply-To: <DCP66O4WE3CE.3P5ZHC9P62LOZ@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Sep 2025 22:57:51 +0200
X-Gm-Features: AS18NWDK5sDVUBXgL53C4CuHgNvckurg2KJki-Oyxxcp6gSr_EFeu2funPREjNc
Message-ID: <CANiq72=2VhHBZbTL7mdF9C+eBabft8rpP0_8FjxKi2d_2ZMbCQ@mail.gmail.com>
Subject: Re: Implicit panics (was: [PATCH v2 2/8] gpu: nova-core: firmware:
 add support for common firmware header)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Alistair Popple <apopple@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 3:55=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> The only two options are either allowing user-space to crash the kernel
> through a module with a missing bound check, or letting it tamper with

So we are definitely not aiming to allow that on purpose, i.e. I know
you said "missing", but just to clarify: they would of course be
considered a bug, just like hitting similar facilities in C code.

(In general, if we get into the situation where we can actually crash
the kernel from userspace, that is a CVE with the current rules
(modulo exceptional cases, e.g. the recent discussion about debugging
tools, for instance), regardless of whether it was due to a Rust panic
or not.)

The Rust panic is, as you say, the last line of defense, attempting to
limit the damage. I think that is worth it for at least some users
that want it (like cloud providers) and some parts of the kernel.
Sometimes it can be worse, though, i.e. perhaps the OOB or the
overflow was not actually a "big issue" "in practice" for a particular
case.

I think it will likely depend on the kind of code we are talking about
-- not all panics are the same, and not all code is the same. For
random modules, for instance, yes, we should definitely prevent
developers from writing panics as much as possible (or not at all);
the same way we try to prevent them from writing unsafe code -- after
all, panicking operations and unsafe code are both an statement that
we are sure "something cannot happen".

So the more we prevent APIs that do not need to rely on panicking (nor
unsafe code) on drivers etc., the better.

I also think forcing to have no panics at all (i.e. globally) would
force us to handle way more truly impossible cases than C does
(unsafely so), which isn't great and has downsides too (increased
complexity, for one, which can also lead to more bugs). And we don't
want to go memory unsafe for all those either (I mean, it could be an
option, but I wouldn't recommend it, and it would still be a bug if
hit). So for certain cases panicking may be a reasonable option in
practice -- that is where I wanted us to get more experience to know
how we fare vs. C here and thus the data request.

It will also depend on what upstream Rust can give us (more on that
below). For instance, having an enforced way with carve-outs that need
to be annotated would at least make it stand out to reviewers and make
developers think thrice.

> Thanks, these are great directions to explore. I see that some thinking
> has already been done on this, do we have a bug or tracking issue so I
> can catch up with the discussions that have already taken place?

In general, I do my best to track this kind of thing in the issues
linked from issue #2 ("Rust features" in this case:
https://github.com/Rust-for-Linux/linux/issues/354), and you can see
some pointers for the overflow part. For no panics there is also an
entry for a long time, but I don't think there has been any "deep"
discussion on it -- I mean between Rust and the kernel (there are of
course discussions in upstream Rust, and there also have been in our
side in the mailing list). I just added a couple recent pointers, I
can look for more.

In that meeting I mentioned with them, I raised this a month or two
ago, and I did so today too, and mentioned that you wanted to discuss
it in LPC. If you (or e.g. someone from NVIDIA) have time to work on
this, including in upstream Rust (e.g. writing an RFC, implementing an
experiment...), then please let me know. They are open to the
possibility of having a Rust project goal for the next round on no
panics (2026H1), so it is a good chance to move things forward. We had
today a discussion on potential forms it could take (an attribute on a
function, guaranteed or not, escape hatches or not, lints, an enforced
comment, Klint, the report-and-continue feature...) and related
ongoing efforts (having a `nopanic` effect, `target_feature(enable
=3D`...).

I hope that helps, and thanks!

Cheers,
Miguel

