Return-Path: <linux-kernel+bounces-882067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC7C2989E
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04C13AEA06
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13E235045;
	Sun,  2 Nov 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnDb2/S7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D51A9F84
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762123344; cv=none; b=o7slIbUPf4HWPeO9tafpCYZ7z8byzDa+b5QqoJAG4k72k+rZ0hJTmHsJg0aQPqB9GXCOempnbbjt7eTdXUVxOe957tdsy2K2sHfPXUBqih229/NNzdKo6mocrbM5F1hCVmYtPJeU/EvAnptqEFiwz+KYjwXpp6iPsAzEcB/lAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762123344; c=relaxed/simple;
	bh=M4DLyPtKAG4hUy09HpTn7RAH0C/FAWWfO+9/yTnCGo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYI/i82eqWJMSRJWzc48LPolkRnUJyqluN3djbbd0SHNWOcOOLJtC7pERLMN6wPcMsCeX4QZG+1xDGhalCGh1R5MnWIjdn0h2Sj6GsDZ1YZOUUqUP3+o6JN43mWdYmdnPAFQ9bEsL4iX9pUqScnJ5UoJjx+4u3S4x73LQV+JJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnDb2/S7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so528366a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762123336; x=1762728136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo2OFYV/wEp3t0RjDyHu79SQW6Mhe5lX0Ph2SYlbthY=;
        b=BnDb2/S72ph7mh5k5H6Yh2XkW2Noodkaf2s/9GlnMvSv9tSTEGNMEyQ5Pmy2iSgvo9
         MQ+l5MxEvEG71ITjEhSaWAXKaJbHlStQ0clATs7+N2m+m3+srsXYhEoZ9Btu7PU0Q2/8
         qpm5kxcD2WYtK6vgRAPQVK4JN+/ROUu8B7j1odPFQ7IAE/J5oqp9KuK0lL8w2h9HPpcL
         Pnfu0yW1br8dsXJu3itJthua7x9c7ygO2+uoq+9TYmrq/ijEDfIJtUjI7kvcT1gFZnXz
         4+nH7QYeSzOH0vwoQ45f+Uq5UTlOpxEOB07tEJGEPN5IzgtOn+Tnmf6C0fy7fYfec1nt
         Dx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762123336; x=1762728136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo2OFYV/wEp3t0RjDyHu79SQW6Mhe5lX0Ph2SYlbthY=;
        b=B9fXmuBoo2x1sHNGZ4xAWwoN1CA3RMEGyUNlTRgCq74spdgRW709HBFOPHMSInMKr4
         TtEjgCDiy7BeIPNfZyHxokfAcfRI2ZwxdXi63WmGMfZ9UIG9TMo2ZAYJKntOOmN50csw
         W/WIEZzdMS3W5LR8p3dAJlFxsL84uOCq+SXCIIbHo+LDk872vuBbypYy9CzrhQUTp27C
         Vm4DJGLLB2jC3zwff+fjsyaRvV1wfEefztIK0sXa1PNNtpPtg6voTlKGYYmuZ/niC2EN
         +UhHv25or2cew8W171Kl/p+8jhy5aRy06A7lEV9PIbN0fLGUI352MGw3+Do6pBR59vGN
         q6hA==
X-Forwarded-Encrypted: i=1; AJvYcCWHdu5i1pFsivCZQWAPAKk4fo9jSFJpSR5yqaeH1R9dE6R7/3BOY1GcJx/x/VJ5tZXZtW1agYl9TH74hPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlv0sEdKKhVTO/LQnNjNe3XD9RdxQ0tp10XFlWMsZSUaYfoQDP
	E1UaEdMNVFaPqHvWTCglALXzGVCfzhAPo7aXDpEXFUCq1lCNO5sLB3yhNcDMetHWuxVUdDcMqvD
	9fEJ01UatCDXR4rc0/uvQtkOIuaqPQLY=
X-Gm-Gg: ASbGncv3dWpWMLvqftNP4vtt5UnrokTpuv3gvIuaFmhfDWFfHvkFvchFrQuhjxltPUm
	A5T3C+3P9sMsaFEQhV5W2mxtaazoBrf465QD3xrBP6h2hvx5ppOjxjKLYKyWBIVvRGXwqwnsCOa
	zCDBE4NIF34PRFUEsiF5vtiXEqtpTnt4NIbdNqWMzJqTSJLnw5rNnarr+jKaC2JgC1tfFihs5Ug
	9fTK6E7m7e/t8E0pDKswa2g0qr/4uKMeNVGH2qukYDhsSfcMsN1CoJS4TDAPQhrxLGFkRd/lw+B
	3KR4e0tlFJ8f4KGOcfyqU6/Ptw==
X-Google-Smtp-Source: AGHT+IGW2RmYQH4CiK5DjHuoP9I+feAku0BV6oGxWMBtYtdC7DiABnzxoNVKGDIG+p+H/ZDBw7z59EZUNr+SDNhbEy4=
X-Received: by 2002:a17:907:7e9b:b0:b70:b98a:79 with SMTP id
 a640c23a62f3a-b70b98a0359mr172851466b.35.1762123336347; Sun, 02 Nov 2025
 14:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029134952.658450-1-mjguzik@gmail.com> <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV> <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
 <20251102061443.GE2441659@ZenIV>
In-Reply-To: <20251102061443.GE2441659@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 2 Nov 2025 23:42:03 +0100
X-Gm-Features: AWmQ_blxU-3h6xM1s5XbBXMknB2-7Awn4NFuGm_9MvHWgFSeOlSGF0oFXfLbeKk
Message-ID: <CAGudoHFDAPEYoC8RAPuPVkcsHsgpdJtQh91=8wRgMAozJyYf2w@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 7:14=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sat, Nov 01, 2025 at 09:19:21AM +0100, Mateusz Guzik wrote:
> > On Sat, Nov 1, 2025 at 7:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 08:17:53PM +0000, Al Viro wrote:
> > >
> > > > 0) get rid of audit_reusename() and aname->uptr (I have that series=
,
> > > > massaging it for posting at the moment).  Basically, don't have
> > > > getname et.al. called in retry loops - there are few places doing
> > > > that, and they are not hard to fix.
> > >
> > > See #work.filename-uptr; I'll post individual patches tomorrow mornin=
g,
> > > hopefully along with getname_alien()/take_filename() followups, inclu=
ding
> > > the removal of atomic (still not settled on the calling conventions f=
or
> > > getname_alien()).
> > >
> >
> > Ok, in that case I think it will be most expedient if my patch gets
> > dropped and you just fold the updated predicts into your patchset
> > somewhere. I don't need any credit.
>
> See #work.filename-refcnt.  I'm not entirely happy about the API, if you
> see a saner way to do it, I'd really like to hear it.  Stuff in the serie=
s:
>
>         * get rid of getname in retry loops.  Only 9 places like that lef=
t,
> massaged out of existence one by one.  (##1..9)
>         * drop audit_reusename() and filename->uptr (#10)
>         * get rid of mixing LOOKUP_EMPTY with the rest of the flags -
> very few places do that at this point and they are not hard to take
> care of (##11..15)
>         * take LOOKUP_EMPTY out of LOOKUP_... space entirely - make it
> GETNAME_EMPTY and have it passed only to getname_flags() (#16)
>         * add GETNAME_NOAUDIT for "don't call audit_getname() there" (#17=
).
> Helpers: getname_alien()/getname_uflags_alien() being wrappers for
> that; io-uring switched to those for filename import (in ->prep()).
> take_filename(): take a reference to struct filename, leaving NULL
> behind, feed it to audit_getname() and return to caller.   Used by
> io-uring ->issue() instances that feed an imported filename to
> do_{mkdir,mknod...}() - the stuff that does actual work, done in the
> thread that will do that work.
>         * make filename->refcnt non-atomic; now it can be done (#19,
> on top of merge from vfs-common/vfs-6.19.misc to bring your commit
> in).

I think the take_filename business invites misuse in the long run and
the API has no way of pointing out it happened.

Even ignoring the fact that there is a refcount and people may be
inclined to refname(name) + take_filename(name), the following already
breaks:

foo() {
    name =3D getname(...);
    if (!IS_ERR_OR_NULL(name))
        bar(name);
    putname(name);
}

bar(struct filename *name)
{
    baz(take_filename(&name));
}

While the code as proposed in the branch does not do it, it is a
matter of time before something which can be distilled to the above
shows up.

I think the core idea of having io_uring bugger off from freeing the
filename thing has legs. I *suspect* the way forward is to implement
audit_delegate_free() or similar which would assert refcount =3D=3D 1 and
would denote with a flag that audit takes ownership of freeing. Then
the regular putname() yells the flag when compiled with
CONFIG_DEBUG_VFS, catching regular misuse. audit itself, when done
with the buffer, would clear the flag and calls putname().

This is from top of my head, I would need to dig into it to validate
the above is feasible.

