Return-Path: <linux-kernel+bounces-883374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C334C2D433
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0494607F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C723B3191DF;
	Mon,  3 Nov 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iju6XUHs"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8331691F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188264; cv=none; b=lWsMKtf68UNR8R/kLunlOQKoWTyiUvayLIweWM1IM/R0z2kOlM88OLj3pyvGgncRgT5IbFc+h5mil0u26j3b2YAPzHB5brVB6Wp0iUx54frUh/TASXHFUsRdDUomMOuJf/StPSxl1s64jBJy+6WVYfpLEqeovDJXvfI1Z/oQLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188264; c=relaxed/simple;
	bh=I59wiwFqkVLbZoOM2bUnRlIlFIr+V9VcFSQ69zg46C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RokAC3eX9hxkCPq7Iy9fLW/zOL+RyNzWI3UlOwX3d1CJMeLOk56uYrvXj7zyKJi2xvJSp9tgRTK93nL5r4wIXVGxSGV1df5d3NlmKps6bT57Ls8CUEShXDiORm0er5yibYOvfdyuFk2PkpXp1EiPTUB7B5vy2X2rowd7WcMYcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iju6XUHs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64091c2e520so3625661a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188261; x=1762793061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM1Mf5XboMaTxjsxho7myGSxuJgsjYFuc/EcT5bM81M=;
        b=iju6XUHsGsTJlvALW5sKs2mOOmBDDPRrZTMNp9jeq1RW6/i8Odc5/ivyLtmKB95bMK
         KwveY7FTVgIdAKGxD4ja1HMF926eAWODxX05YmSwq81AKbZ3StSidHtPULfp+KC38X3I
         yI3VEVySWglQsLtf1f5dWP4SecUpE3yi0I4lRe34lFeJVEbjr4EmXOrfQYqsUaZ8ccSg
         lqXzRth5iRzW/E7bLKLpcbwh+3exiejNEPNzvS/qpGxIcq1jObovJtS6r1iTwoM7am9m
         8S+iJ6ByAf4rU3ZuqTg7BIGhVrnDhSCk8p+0ob0guBVsgmyadRzkR5FgEAOd5hjPMbPJ
         wAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188261; x=1762793061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM1Mf5XboMaTxjsxho7myGSxuJgsjYFuc/EcT5bM81M=;
        b=TwWU/XOy3aW1Ao8Naf1Y11zyD1WlnChlL7wea2/dTimXsOlGVtajpwbgJISO1CJe4m
         Em7KPEPSoTBHDh47MHq+jIgaOLD2e7Ip2gz470T+SO2T/ZE94XtTMm41iSAb5I3mWM0z
         lyP9QYRSj8PzWeF1Xge37OQ6fcJU3aTnxQ54QPQdIGHMjnEjYrmLL6MsTyiz6WSwFMtF
         RvwCs9kZdCUe8x2VoxojuF86IZcL3EcNZP6MGZXMzJsZdZ+RCc4RfX/0zTviDssPIhuF
         lx4dSm1NnkvfWKrEvcIMg4VckVrW17jFncUGyvv2/gcmmT/q443z/qwuLhoU6v5X+dPy
         +WjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZFLd2ciaRx2jW0v08D6WiYNWP3BFnU6DPMjKg70snEMlf0DjMemJX9anFeWA8r+ioAXWCqQ/zGYsBDMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnkceE3E9Sm3vnhrFkfnK035yelImS0l/Vq0IH6JNN2D/+osC
	RbR3MwIDnixesrzOJtdPpskM7Y/wnx/OR44ARNlpqmU8O8XC026ry/YjKOvdxI54sSqch+xTRFP
	fhTEICj/abptRYBShH2/tH9gjRXf3l4o=
X-Gm-Gg: ASbGncuw/JVU6u8/GxBoSXTj0WGPui5qklerQX03pMoIySk8D6wJGdlYrPemC1/2Nyz
	N4n+v8+nzQ01tLxN1AAMMuhSmwPip0fqaK8gVi3/17xF29QIPCLDIFXsMXDGVUKqHCf28OJ6NL6
	kJkV2JwStGk2SfeCc76+w0wjQtuq1lgh+FcEeU8EPjcCTXoykpQHiHMFXuwYV7oLydj92dDDyzQ
	xri9005pjdysN4XS5/XWanTJLmWtvbrI+6MGbwkf+UD0lcmYh+/v/a7LmoffmgweHX1hb7uWPEX
	9zu38aC5DRLhdEc=
X-Google-Smtp-Source: AGHT+IEnNURiDoaBjLpsTWUH9VrYNjPaIOjw8lu0D4XVVYkRaZQT9oThVFEbAAXuncvvQOueIKruSMdsB9DoUHyZ0bs=
X-Received: by 2002:a17:907:7b8d:b0:b5c:753a:e022 with SMTP id
 a640c23a62f3a-b70701dc398mr1186998066b.29.1762188260475; Mon, 03 Nov 2025
 08:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029134952.658450-1-mjguzik@gmail.com> <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV> <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
 <20251102061443.GE2441659@ZenIV> <CAGudoHFDAPEYoC8RAPuPVkcsHsgpdJtQh91=8wRgMAozJyYf2w@mail.gmail.com>
 <20251103044553.GF2441659@ZenIV>
In-Reply-To: <20251103044553.GF2441659@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Nov 2025 17:44:07 +0100
X-Gm-Features: AWmQ_bnRp3G7Ykl903QbbL9ApDC5ofho-uqgihSVxa8bPNXNkVDexslsMax_YbU
Message-ID: <CAGudoHGP+x0VPpJnn=zWG6NLTkN8t+TvKDwErfWVvzZ7CEa+=Q@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:45=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sun, Nov 02, 2025 at 11:42:03PM +0100, Mateusz Guzik wrote:
>
> > Even ignoring the fact that there is a refcount and people may be
> > inclined to refname(name) + take_filename(name), the following already
> > breaks:
>
> Er...  refname() doesn't need to be seen for anyone other than auditsc.c
> and core part of filename handling in fs/namei.c (I'd like to move it
> to fs/filename.c someday)...
>
> > foo() {
> >     name =3D getname(...);
> >     if (!IS_ERR_OR_NULL(name))
> >         bar(name);
> >     putname(name);
> > }
> >
> > bar(struct filename *name)
> > {
> >     baz(take_filename(&name));
> > }
> >
> > While the code as proposed in the branch does not do it, it is a
> > matter of time before something which can be distilled to the above
> > shows up.
>
> Breaks in which case, exactly?  If baz() consumes its argument, we are
> fine, if it does we have a leak...
>

My point is currently the idiomatic handling of struct filename is to
getname(), pass it around and then unconditionally call putname() on
it, which already branches on IS_ERR_OR_NULL. With the previous
proposed design it would be a matter of time before someone does that
and take_filename somewhere down the callstack, resulting in a bug.

The new alien_filename struct mostly sorts it out, but I have some notes on=
 it.

> I agree that 'take_filename' is inviting wrong connotations, though.
>
> Hell knows - it might be worth thinking of that as claiming ownership.
> Or, perhaps, transformation of the original object, if we separate
> the notion of 'active filename' (absolutely tied to one thread, not
> allowed to be reachable from any data structures shared with other
> threads, etc.) from 'embryonic filename' (no refcounting whatsoever,
> no copying of references, etc., consumed on transformation into
> 'active filename').  Then getname_alien() would create an embryo,
> to be consumed before doing actual work.  That could be expressed
> in C type system...  Need to think about that.
>
> One possibility would be something like
>
> struct alien_filename {
>         struct filename *__dont_touch_that;
> };
>
> int getname_alien(struct alien_filename *v, const char __user *string)
> {
>         struct filename *res;
>         if (WARN_ON(v->__dont_touch_that))
>                 return -EINVAL;
>         res =3D getname_flags(string, GETNAME_NOAUDIT);
>         if (IS_ERR(res))
>                 return PTR_ERR(res);
>         v->__done_touch_that =3D res;
>         return 0;
> }
>
> void destroy_alien_filename(struct alient_filename *v)
> {
>         putname(no_free_ptr(v->__dont_touch_that));
> }
>
> struct filename *claim_filename(struct alien_filename *v)
> {
>         struct filename *res =3D no_free_ptr(v->__dont_touch_that);
>         if (!IS_ERR(res))
>                 audit_getname(res);
>         return res;
> }
>
> and e.g.
>
> struct io_rename {
>         struct file                     *file;
>         int                             old_dfd;
>         int                             new_dfd;
>         struct alien_filename           oldpath;
>         struct alien_filename           newpath;
>         int                             flags;
> };
>
> ...
>         err =3D getname_alien(&ren->oldpath);
>         if (unlikely(err))
>                 return err;
>         err =3D getname_alien(&ren->newpath);
>         if (unlikely(err)) {
>                 destroy_alien_filename(&ren->oldpath);
>                 return err;
>         }
>
> ...
>         /* note that do_renameat2() consumes filename references */
>         ret =3D do_renameat2(ren->old_dfd, claim_filename(&ren->oldpath),
>                            ren->new_dfd, claim_filename(&ren->newpath),
>                            ren->flags);
> ...
>
> void io_renameat_cleanup(struct io_kiocb *req)
> {
>         struct io_rename *ren =3D io_kiocb_to_cmd(req, struct io_rename);
>
>         destroy_alien_filename(&ren->oldpath);
>         destroy_alien_filename(&ren->newpath);
> }
>
> Might work...  Anyone found adding any instances of __dont_touch_that any=
where in
> the kernel would be obviously doing something fishy (and if they are play=
ing silly
> buggers with obfuscating that, s/doing something fishy/malicious/), so C =
typechecking
> + git grep once in a while should suffice for safety.

I think this still wants some error-proofing to catch bad usage. Per
the above, the new thing deviates from the idiom claiming you can
always putname().

Perhaps like this:
struct alien_filename {
        struct filename *__dont_touch_that;
        struct task_struct *__who_can_free;
        bool is_delegated;
};

It would start with __who_can_free =3D=3D NULL and would need to be
populated by a helper before destroy_alien_name is legally callable.

The consumer would denote it does not intend to free the obj by
calling delegate_alien_name(), after which some other thread needs to
take ownership.

a sketch:
/* called by the thread which allocated the name if it decides to go
through with it */
delegate_alien_name(name) {
    VFS_BUG_ON(name->delegated);
    name->delegated =3D true;
}

/* called by the thread using the name */
claim_alien_name(name) {
    VFS_BUG_ON(!name->delegated);
    VFS_BUG_ON(name->__who_can_free !=3D NULL);
    name->__who_can_free =3D current;
}

destroy_alien_name(name) {
    if (name->delegated) {
        VFS_BUG_ON(name->__who_can_free =3D=3D NULL);
        VFS_BUG_ON(name->__who_can_free !=3D current);
    }
    putname(..);
}

So a sample correct consumer looks like this:
err =3D getname_alien(&name);
....
err =3D other_prep();
if (!err)
    actual_work(delegate_alien_name(name));
else
    destroy_alien_name(name);

the *other* thread which eventually works on the name:
claim_alien_name(name);
/* hard work goes here */
destroy_alien_name(name);

Sample buggy consumer which both delegated the free *and* decided free
anyway is caught.

