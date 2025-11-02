Return-Path: <linux-kernel+bounces-881856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A72C29132
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5D73AEC36
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900991F03EF;
	Sun,  2 Nov 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W5/mo3jc"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029E35979
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098197; cv=none; b=IpEwEGfmQvb/+DPFiNAlKwisRaT2tSWtYrXXEPY1sTdGBS/OMH1QchC5MrP+ev9V5gzo4oHbzPEMVyCuux2PmYbe93LjXJmBuU2Tw7hyYqX0pEqC5NgvvX1b2gzhicWXSmqvoJO3SB+dl2chcfh5MnItWsWUyaj+kzsCS37JQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098197; c=relaxed/simple;
	bh=z+74uzTwOyQM+smLB/z8SPLxSH3L8uwlQ61epXaQDqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhUvrlcVV6KmI1zIz+GeGRIDZ/cqVHFbH2cdUsTaZp95iQxY1mRLdJsfsy7p+YSJQGwFnaSE2uJnKjd+kE93s+sq2QIGxaBQUqqg3rKNPiMkIu24eybpNPvqUuX+3fK+7iP8A2vl8QOy4xXI30+wh0I95CVHf/6W31F6TH2INWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W5/mo3jc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b4739538so3647197a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762098195; x=1762702995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR4hLMCuTJEX4w71czl1e00xwifRRggH9ZtmKhZRHec=;
        b=W5/mo3jcV+LLYgNuvlgcKBT/U2DkWk0B4bUxXDKaDSbrVNkK5NKOwxwiWgiJ5CtCJr
         PaiNZkYcZtOkrxMFS63oUHO+0qASyjqxoIo7QP7H+/SX0eSY2eO8kpfzPZlPrSR3oeb0
         9Dl4L2Vne59kpwaC+XYSuIfhGdXQOucIrVB0wwX14HjcnyjNGfNykofC2rRumFBe3NDR
         tC7+jl13DrjNpaBgfB7YJEoXjhQ/yxKSKzmhhU2riamNSikfuecsEKE8gl9Dj9MrUol2
         VyAh9RZdPHCq5C737qxQ8LII1i48RK9Jx1BRp0fUyAdJj81w71rnCmIK1mx6KMqebtop
         XySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762098195; x=1762702995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR4hLMCuTJEX4w71czl1e00xwifRRggH9ZtmKhZRHec=;
        b=v3wKclm3j2G0DTz4AIuR0TTeqyXHxi1IrLPxsAdCQ4UzgyrLtIUuK5GkU4Kwe2csJX
         WopHQViBz6rMLeL7LJhid1vL74a4JlNHL4wAYgFTGoU+yXpswln1vuSOny+CuCbhvu80
         6HdtVqD7RmoXJQrHA0MvWx9wVDEBtWpMHFy/PEwObMjV0+DFmUWF4I4rG6timLIEi6ff
         phsLddQGmdsw/9bGU59H65ld1j/0RbEGqhiKydOfbGUBQf9CaQBbgnaIteQzaYQM9x8V
         f/Ehu64luJAo+dvZJ8JxZWFkspVy4uGsGtoXtLmmSiDyghJu5wnK/G6wAfO01esR17yZ
         nxdw==
X-Forwarded-Encrypted: i=1; AJvYcCU9LYHinsVjFN2sgzQaM1rajM/EFLuE60r/LK4ctmeeBz1lQQamUgS8hHdK4AjF456jy6D1Xh0Ypm3cm9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWm2sOZ11bwiZGHwNSitiI8zW6tBPSIMIp4z6H3lT4m7+3asBx
	wFY9qrTaZTRGCRlbSJoIdOwA2R8aePP53Vg3PfM2l5hfV/6wMSHs8JRkhImJ/jKc90HvWSPJ8UF
	gt8dgyUATvja+yjtPkOil/AIB0zanQrt9x/36OWfa
X-Gm-Gg: ASbGncuBXDeTIt6z7+f3OjmRZbwdJ6mge3gzMRROBuG7NzWPendULb/OVC8/RyaGryC
	hty1VECKCS+slQq/p19eV9OXrS46I2ngWjX6XSqRtiAGqIRJ1RvfszDB4DBk7Nv5kKlDZYWWOSk
	iB/SZJYMZzJdiyyPpLlSnKMQOavhrIxuV1WUgzQvGzZekt0PYUwVQNiWC8GuPgxhO9Bb66wsl5A
	aaug3zdl+tc55DyPochJChAfX/X9nB1FNUHMaClHvB4+6jQWrL5iZVTxmX/
X-Google-Smtp-Source: AGHT+IH+gdQyYqpCRFbM6fBI2tvP8h9njQCEvK/Ytm9+WC6sCBHRr/IlfFcCz6CZrkFk8ifrfaRZlu6u7GUboUGzPBM=
X-Received: by 2002:a17:90b:5628:b0:32e:a54a:be4a with SMTP id
 98e67ed59e1d1-34082fc6369mr10716770a91.2.1762098195358; Sun, 02 Nov 2025
 07:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928030358.3873311-1-coxu@redhat.com> <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com> <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
In-Reply-To: <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 2 Nov 2025 10:43:04 -0500
X-Gm-Features: AWmQ_bkhQmp1JdfxKhTFwi5MkVou1XmV320Ca5zT8aVFM_Vs-ciEtv2q9tc7P2M
Message-ID: <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook security_kernel_module_read_file
 to access decompressed kernel module
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 10:06=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Sat, 2025-11-01 at 12:50 -0400, Paul Moore wrote:
> > On Fri, Oct 31, 2025 at 3:41=E2=80=AFAM Coiby Xu <coxu@redhat.com> wrot=
e:
> > >
> > > Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPR=
ESS)
> > > is enabled, IMA has no way to verify the appended module signature as=
 it
> > > can't decompress the module.
> > >
> > > Define a new LSM hook security_kernel_module_read_file which will be
> > > called after kernel module decompression is done so IMA can access th=
e
> > > decompressed kernel module to verify the appended signature.
> > >
> > > Since IMA can access both xattr and appended kernel module signature
> > > with the new LSM hook, it no longer uses the security_kernel_post_rea=
d_file
> > > LSM hook for kernel module loading.
> > >
> > > Before enabling in-kernel module decompression, a kernel module in
> > > initramfs can still be loaded with ima_policy=3Dsecure_boot. So adjus=
t the
> > > kernel module rule in secure_boot policy to allow either an IMA
> > > signature OR an appended signature i.e. to use
> > > "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
> > >
> > > Reported-by: Karel Srot <ksrot@redhat.com>
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > ---
> > > v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-=
coxu@redhat.com/
> > >
> > >  include/linux/lsm_hook_defs.h       |  2 ++
> > >  include/linux/security.h            |  7 +++++++
> > >  kernel/module/main.c                | 10 +++++++++-
> > >  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
> > >  security/integrity/ima/ima_policy.c |  2 +-
> > >  security/security.c                 | 17 +++++++++++++++++
> > >  6 files changed, 62 insertions(+), 2 deletions(-)
> >
> > We don't really need a new LSM hook for this do we?  Can't we just
> > define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
> > another call to security_kernel_post_read_file() after the module is
> > unpacked?  Something like the snippet below ...
>
> Yes, this is similar to my suggestion based on defining multiple enumerat=
ions:
> READING_MODULE, READING_COMPRESSED_MODULE, and READING_DECOMPRESSED_MODUL=
E.
> With this solution, IMA would need to make an exception in the post kerne=
l
> module read for the READING_COMPRESSED_MODULE case, since the kernel modu=
le has
> not yet been decompressed.
>
> Coiby suggested further simplification by moving the call later.  At whic=
h point
> either there is or isn't an appended signature for non-compressed and
> decompressed kernel modules.
>
> As long as you don't have a problem calling the security_kernel_post_read=
_file()
> hook again, could we move the call later and pass READING_MODULE_UNCOMPRE=
SSED?

It isn't clear from these comments if you are talking about moving
only the second security_kernel_post_read_file() call that was
proposed for init_module_from_file() to later in the function, leaving
the call in kernel_read_file() intact, or something else?

I think we want to leave the hook calls in kernel_read_file() intact,
in which case I'm not certain what advantage there is in moving the
security_kernel_post_read_file() call to a location where it is called
in init_module_from_file() regardless of if the module is compressed
or not.  In the uncompressed case you are calling the hook twice for
no real benefit?  It may be helpful to submit a patch with your
proposal as a patch can be worth a thousand words ;)

> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index c66b26184936..f127000d2e0a 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file *f,=
 const ch
> > ar __user * uargs, int
> >                        mod_stat_add_long(len, &invalid_decompress_bytes=
);
> >                        return err;
> >                }
> > +
> > +               err =3D security_kernel_post_read_file(f,
> > +                                                    (char *)info.hdr, =
info.len,
> > +                                                    READING_MODULE_DEC=
OMPRESS);
> > +               if (err) {
> > +                       mod_stat_inc(&failed_kreads);
> > +                       return err;
> > +               }
> >        } else {
> >                info.hdr =3D buf;
> >                info.len =3D len;
>
> =3D=3D defer security_kernel_post_read_file() call to here =3D=3D

--=20
paul-moore.com

