Return-Path: <linux-kernel+bounces-833030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A311BA10A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161E1627485
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A7319870;
	Thu, 25 Sep 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7afA9uF"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4199305E2F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825355; cv=none; b=VtPmkafpQUtemO3pH25KHuQorgxkPr4u6ZUkiolTNc8onGpdVWN0T2YBEPkZezgIN3j+2eydkWrgCygrPxOmnLtilEzyjiYCI8VUBLc3+cXS2BFrTbrF3OHXr/KTtc46cw7Uu1XYgbI6I+B0TO8PCbZpBC623xTJItR2TxUlirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825355; c=relaxed/simple;
	bh=Bi1Uuo53Q5CXqwh3RsmaCHmWXceXypMlgALV1Rp/tuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1MiJ1NZQx4AKL6Sa2HJLpxkI6Pb3AVWmkFlUppQZXH/KA8eQQEBt71eXnxpZ3ERNrrbdmEKDiWEGBpZugqelv5//TcsLZnaLZlZZMWFtWjxEO62D5JymNBx/1T/oSnLcBc+LUMOF2hA+8FMc9mRclnBzC3KZWQX4Qh5K5xg/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7afA9uF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so2441682a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825352; x=1759430152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi1Uuo53Q5CXqwh3RsmaCHmWXceXypMlgALV1Rp/tuY=;
        b=H7afA9uFeIAIhDnir7CGNnDLGMYJXs7ZcRF4sZVHzVb1PFoMyA0i3HEq4O8hNfxSt2
         kYQ0tPuSfoazono6vMGkUTph/p7qcfI0yf0jmpWjOXuLljeOHIuZHIzh5+wZZN8FigeZ
         mEdjJRP6qhKgl1HNtzS6hBhGIUu/U6zpyEc4RRGT5zxPOJr73VR5PMpp0T1sMZh1p8BI
         5824PYvqeNv9j7TOGwPxXR4Csp8bKEdQqZVWu426kc/rXgGPat1c1naVmxwineNu/Uyj
         Rc0ip0TgCLQb1xTVxil+HI31/i7QDF5a5tnNKrQOe8HPcE80zAGAgz2OF+Epwqzims08
         DEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825352; x=1759430152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi1Uuo53Q5CXqwh3RsmaCHmWXceXypMlgALV1Rp/tuY=;
        b=aKJayx0/ATlXsBRI202/5ka7MWzJ1QZNlZiSQi74ZzAF7yXu1eIWCNN0bUtvhjNiRX
         ImXhpidCZZtptjIoIJ1j1NVOvQgFgx6UfHvdQ67HkRtBi7p1AkGHTyLlCLvKiMZlxPQ+
         bHOvUz35sRmlGyQRa6m7pgcb9HtEngvcb7DpXCj+rPzwhSq61p9bkiphxRHq2cO7k/sL
         E3LuucWcq4nc/RAXnZzPyHuM5ssUiNr1uhLkUWXjTpk1gGI04SXugzUKB2mKqPKjWtji
         9tURnOSJkT73xJU9gUFvFBinOupC8qDxFaC5p2HEHjMCDaFC0BvkM+ySb3NtamcmQm6c
         zCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUQyP+0ZLiAxIJoMWLEKtCKLCRZUkJGxgACRvGTjWqWygGaNk9HPFSBpPWVsoXztEdRM212AqUvZVHCQPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBi6uusge0IbY9JwvivCXuIhp64cfYcxjLx7WDXUG2Sgtyj5kB
	S/BIiDx8MhjoNKDmhVQxV5WHhyZVLvA5CX0y39hI0GU0ce6oEfeIEJFYgJARnlLrsjYqAmIQ/be
	gO+vjKIEBFqW4EK/4dSRjRmqCsDnX8YOHm5FG
X-Gm-Gg: ASbGncsEgu80cbt15wfPWknzp1axAgKDQ74amuRfqCCgTK6eOQz3cRgSvb0tAKgLIx1
	P3MrnPjWb7x2I8/nlq6T5UUywyf3htMJ9tZvWuLhMfyz/C+QrWBL5TE7JnKIl/vbB9hHwyasu3c
	GWSedtb5ztRbh7zgXFknnKShl1awb2v11OP0OzGrC4jxpeLZXVTY8FBSfVyGc8YdgiZqfJOt0/2
	/n94qiF+cyFikKEDDZqUMc4ELzl5cHZY/p3dw==
X-Google-Smtp-Source: AGHT+IH413xX0HEBq8HeJ0623YfA3SWPRb2Ewtd8iVR1fSYF2CuXZlC3B0kzlJGqzC75xqy66MxFQdZIAALwIXFJtBw=
X-Received: by 2002:a05:6402:4308:b0:634:4e56:ba02 with SMTP id
 4fb4d7f45d1cf-6349fa7e715mr3780736a12.23.1758825351801; Thu, 25 Sep 2025
 11:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com> <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
 <20250923120344.GA12377@redhat.com> <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
 <20250925162759.GA25838@redhat.com>
In-Reply-To: <20250925162759.GA25838@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 25 Sep 2025 20:35:39 +0200
X-Gm-Features: AS18NWB7BtNUEI1wJTPWnxplTD27NCLDlN24Y0bXsruylwfHC3OfXRKF7JxKgD0
Message-ID: <CAGudoHGiO8vfyzuRmVHePR_TCeMSXjOv1TFpQ3i8Jk9+RMmTtQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Demi Marie Obenour <demiobenour@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It struck me that this mail thread is perhaps a little rude towards
Demi, so I would like to state the reported race is legitimate and if
it was reported against come core functionality it would count as
"good spotting". It just so happens this is a corner case to something
not-that-imporant and the proposed fix is rather heavy-weight (despite
being perfectly sensible), so there is quite a bit of reluctance.

With that out of the way...

On Thu, Sep 25, 2025 at 6:29=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> > That's very
> > nasty as the full fence is quite expensive.
>
> Well, the exit_notify() path is already heavy, not sure smp_mb() or
> smp_store_mb(real_parent, reaper) can add a noticeable difference.
>

Well the tasklist consumers already suffer a lot of avoidable
overhead, but I'm going to save the spiel about it. Maybe instead I
will post a patch to remove some. ;)

I realized I never checked how often processes are exiting while still
having children -- for legitimate workloads this is probably not that
common either, so the fence would not even show up in typical usage?

This could be answered with bpftrace over a bunch of workloads if
someone cares to investigate.

> > I don't know if makes any sense to add this.
>
> Neither me.
>
> OK. I won't argue with this patch. At least the usage of tasklist_lock is=
 well
> documented.
>

ye.. avoiding smp_mb may be a case of "premature optimization", except
it is also simpler, so that's a really tough call. good news is that
it's not mine to make ;-)

I guess if the lock acquire goes in the sky is not going to fall,
worst case this can get revisited later. So fwiw I would be leaning
towards accepting the patch as well for the time being.

