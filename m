Return-Path: <linux-kernel+bounces-817674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E8B5853D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF012071DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4F27D77A;
	Mon, 15 Sep 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFngsrHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CB212574
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964180; cv=none; b=Z5zaEILgABdSvVbkEnJgLBixDNGPBSsUBq/mZyrkqYNQhN5MLH3drqh+ePTfmfYUuYdA6H1PdmpDEQLOWJsoo7tXyjrNAIbbothRvwtXn9r7XG/wxMA9Vz9DLtKKmKe2J7OinGO2T8bUZz9d34cdb9lh4w8CxMQcDnOeKmz+ut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964180; c=relaxed/simple;
	bh=CfOeBT2uJ2vDN95+a+RmRu4aSC8CMvZMjYlqYp4sVOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdygujZDQ3c1TWMRckS4LkwCHhVYwcfrCuXwN6EGdLroVm8mRU28TFGIK3rYHvvE2VNzEIjwnB+SGHYcClJRcuj5Ihjqv8lr/9+l5RRWx4oX5v1VkWWixw43J/BmYwvR8fnftK81qrVD7HDZ8BQafswmz70Xi9ewxRzUoWnhvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFngsrHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8613C4CEF1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757964179;
	bh=CfOeBT2uJ2vDN95+a+RmRu4aSC8CMvZMjYlqYp4sVOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OFngsrHzH/PyNLbA+/QDpBBcVM+Mxkl+zPrWRu/0vVT3ZTAonZOSzybEUvIIOoAOa
	 uYPD5uH6E8f8zAwOJosdvnoWMdl8sf4vMNrj9Rlwp/Hwl9Xw2P7Dt4hNvChyHkvZ29
	 DnN8udvxJ1DauJGb82hSgLNdKwIO5L+xOicRkSIs9PwIovb9ajHiTXIt+ji1GhGPBw
	 X/HX9IMPgs/ZXDJPEYDKOSVEol+srWJwLYgRO5FbyH/2gdQeA5z3j3KV9gR7LDAZLI
	 NR6SOTGTuiy2iVKMTYeF2vv8k4xW5//qN6BfMXJMMhmu4++og13H3Fo8VKlUJr3Bd4
	 AzsmGBjsfxIbQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-757fda06b0cso942559a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:22:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNytGL6mifkrkiqUAz5oAr/Gf3YyMoVWi34RfTIvrERt1WyXoMV3yQwYgvtx8pgAT2CatEPFWdqiu8GNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFps9og2TAUKBdDjSVGF1zC3b7YxeaMWfauK1fTpfNlvvWutG
	E6aEhi2VO+GTmejw3OzrQjYklDm5ElMagsBaD1QMI9YcFve1qkyAuyEq4T5Y33/+wRL8CrPhp0Y
	xhDrISNdBuS2oaM5XfsdVT2pbLpnesNc=
X-Google-Smtp-Source: AGHT+IE5BuGSJtCD/JKhN8NFKfVoK4ypWod4N5mMxx+YQOBBrCJ3vGoqP0mQmab3oRzwZOv86Bu7xsPKazqJmeI3Y7U=
X-Received: by 2002:a05:6830:2908:b0:746:3226:c68f with SMTP id
 46e09a7af769-75352994eedmr7283951a34.4.1757964179124; Mon, 15 Sep 2025
 12:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903224913.242928-2-thorsten.blum@linux.dev> <7c0ea575-7682-4601-8922-49684d929374@linux.alibaba.com>
In-Reply-To: <7c0ea575-7682-4601-8922-49684d929374@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 21:22:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNP4=S5B-=LGgUMo6vQoxd4VW=nPYyPHP_ZzqRWaU8GA@mail.gmail.com>
X-Gm-Features: AS18NWC7Zoxe_g3bqZf9rXMEBvfqiRhns9aI1KuLaUuO11R6QBMX4GGHOXH9nPA
Message-ID: <CAJZ5v0gNP4=S5B-=LGgUMo6vQoxd4VW=nPYyPHP_ZzqRWaU8GA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Remove redundant assignments in erst_dbg_{ioctl|write}()
To: Shuai Xue <xueshuai@linux.alibaba.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:19=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.co=
m> wrote:
>
>
>
> =E5=9C=A8 2025/9/4 06:49, Thorsten Blum =E5=86=99=E9=81=93:
> > Use the result of copy_from_user() directly instead of assigning it to
> > the local variable 'rc' and then overwriting it in erst_dbg_write() or
> > immediately returning from erst_dbg_ioctl().
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/acpi/apei/erst-dbg.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.=
c
> > index 246076341e8c..ff0e8bf8e97a 100644
> > --- a/drivers/acpi/apei/erst-dbg.c
> > +++ b/drivers/acpi/apei/erst-dbg.c
> > @@ -60,9 +60,8 @@ static long erst_dbg_ioctl(struct file *f, unsigned i=
nt cmd, unsigned long arg)
> >
> >       switch (cmd) {
> >       case APEI_ERST_CLEAR_RECORD:
> > -             rc =3D copy_from_user(&record_id, (void __user *)arg,
> > -                                 sizeof(record_id));
> > -             if (rc)
> > +             if (copy_from_user(&record_id, (void __user *)arg,
> > +                                sizeof(record_id)))
> >                       return -EFAULT;
> >               return erst_clear(record_id);
> >       case APEI_ERST_GET_RECORD_COUNT:
> > @@ -175,8 +174,7 @@ static ssize_t erst_dbg_write(struct file *filp, co=
nst char __user *ubuf,
> >               erst_dbg_buf =3D p;
> >               erst_dbg_buf_len =3D usize;
> >       }
> > -     rc =3D copy_from_user(erst_dbg_buf, ubuf, usize);
> > -     if (rc) {
> > +     if (copy_from_user(erst_dbg_buf, ubuf, usize)) {
> >               rc =3D -EFAULT;
> >               goto out;
> >       }
>
> Hi Thorsten,
> Thanks for the patch.
>
> The changes look good to me.
>
> Since this is a code cleanup with no functional changes, could you
> please mention "no functional change" or similar wording in the commit
> message to make it clear?

Added.

> With that addressed:
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

And patch applied as 6.18 material, thanks!

