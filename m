Return-Path: <linux-kernel+bounces-832996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E697BA0F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159F87A3A87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274530F815;
	Thu, 25 Sep 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqprKkeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EA1E0DEA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822526; cv=none; b=k0JWG2t5cjyz4/LzRcWmd6qVuvE3Sm9HDMcZdywlxG2H7D6yzKsiNhXllXkkkKYgILotPMMy+scZUFv9t2YdgFBp2k1TJKziHp5fUss5yyxQW/NvIahSiKsPJ9SMwimTpDDrDAQLiHSkqL8caxxkpDE6kgTu6mjvcMHs47FsQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822526; c=relaxed/simple;
	bh=7zrdKHhlppiRPY8Wgp0eX6coVCqDsIp1DQXVBqI4RfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZ8fSNRuNupRNk9gH7Oc0z6rOBh5Qx1HUrIPRDAlwnhnJ/gYWUzBtsP7L74ChboS4okoGayVRyKriWc4Ceg62gQKLQp1PvkOD1yraXrB4M20kWH3RhVBFnf9nXrmsuTuJFYSqnElxmHgkeQLYawPmYtMd//kco5G5p/K93GWK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqprKkeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD74C116D0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758822526;
	bh=7zrdKHhlppiRPY8Wgp0eX6coVCqDsIp1DQXVBqI4RfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LqprKkeKQt2/ZeoxfFJYjsigu/PBhu6ueCHbqMZmlewhZwZmNRBezxo80BIxl7wdq
	 Nk71BjGDcdzaOKe/6mCe+cz63RaBtD5/ddt8DnZekA7KPn19rqqJUrLp1oYgCudWX6
	 Kd9QR6npB+h/9uMG/MyS5oTxCIWApEpxvXC9ql3iU2+43OEyWGGmWWmNZbGza9QnET
	 iZPoqilKznGXqwRB5krJSIfsnZR2vbosqiBfrXjs8r8UuLRYnn5crDyAe0++Po3hc3
	 4SJupBUlGOr5FR9mm2gWP7VxLHX6JnpV2D66+fFjcwFLWnzmukwx77XcwJaHbH7rwz
	 r7we0HkCA5RoQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so234808966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:48:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeAAHB9ZjuWl4CYfP7LL9Y5Wv2rO9RM2JqMrTAkc+Lws23HcWP+RqvmM0xzQjPMzYW34sf5uC7pV9BIU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oiDTovbxUo6qrQDCyvuExg9thAmmkIwEFukDl9fSy2FgM5fa
	IQTa7ZqhkICCFeth+l6Eu8W0kZgjjHAQRAkPdZ8re5yrijHVU20/pPyIEEPjNF1i2yBrMgqQ54e
	J6u+hA6IWZipsXU2V6iJXyYRUIdnOkH8=
X-Google-Smtp-Source: AGHT+IER3LKaqqQhCWgv03UaWEfeDgNEu+ODWtuGJMhOfztOvKHFFxQFcOiF/eO1wanfCdpiD5Udn4cS0Fb644bRIYI=
X-Received: by 2002:a17:907:6093:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-b34bad28537mr487948366b.36.1758822524523; Thu, 25 Sep 2025
 10:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925145331.357022-1-mssola@mssola.com> <20250925172529.GA1937085@zen.localdomain>
In-Reply-To: <20250925172529.GA1937085@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Sep 2025 18:48:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
X-Gm-Features: AS18NWAmKAgr3UKJioHbpmnALU4HD6lsuoPSxEeyBqYnyq9OGprJk1M7tZs5i0Y
Message-ID: <CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
To: Boris Burkov <boris@bur.io>
Cc: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>, 
	linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:25=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Sep 25, 2025 at 04:53:31PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
> > On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
> > provided by the user, which is kfree'd in the end. But this was not the
> > case when allocating memory for 'prealloc'. In this case, if it somehow
> > failed, then the previous code would go directly into calling
> > 'mnt_drop_write_file', without freeing the string duplicated from the
> > user space.
> >
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> LGTM, thanks for the fix!
>
> One thing though: I don't like the label names. I think with multiple
> cleanups the best way is to name each label with the cleanup it is for.
> Once you have some named ones, "out" feels unspecific, and encoding
> every single action like "out_sa_drop_write" doesn't scale as you add
> more cleanups, so it's just not a useful pattern. It's already quite
> clunky with just two.
>
> If you fixup the names, you can add:
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  fs/btrfs/ioctl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 185bef0df1c2..00381fdbff9d 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file=
 *file, void __user *arg)
> >               prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
> >               if (!prealloc) {
> >                       ret =3D -ENOMEM;
> > -                     goto drop_write;
> > +                     goto out_sa_drop_write;
> >               }
> >       }
> >
> > @@ -3775,6 +3775,7 @@ static long btrfs_ioctl_qgroup_assign(struct file=
 *file, void __user *arg)
> >
> >  out:
>
> call this free_prealloc
>
> >       kfree(prealloc);
> > +out_sa_drop_write:
>
> and this one free_args


Rather than adding yet one more label, which over time has proven
error prone, I'd rather have a single label.
Just the existing 'out' label and then the fix would be to replace the

goto drop_write;

with

goto out;

kfree() against a NULL pointer is safe.

Also, missing a Fixes tag which should be:

Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding
a relation")

Thanks.

>
> >       kfree(sa);
> >  drop_write:
> >       mnt_drop_write_file(file);
> > --
> > 2.51.0
> >
>

