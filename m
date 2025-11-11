Return-Path: <linux-kernel+bounces-894722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF7C4BB03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A54E2C63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441472D9EE2;
	Tue, 11 Nov 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaGwOJsU"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D92D879F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843124; cv=none; b=UBS64+ogCvUwvnVrmHtpMb2TT6HkUnOALV8LKF454yfEVk7s3wogcV8GlSzJtMOACGWqm2Q0EDAsKWfDNcE4PJMrk7P2CydTgJoSe/3WQtbHvFcBAMZTtSR6YJ9KC/UDxWEEAeEpocinwpDa6SjtUrCk99AKhSFR6+1XmVDHhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843124; c=relaxed/simple;
	bh=Xl+bV7FTMz6YY5XMNc5QfCxFXt9tSNW93X8te6PCvC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTOP/PJSAoTM+aFX8OY21BzQXNK7M3xU/HZQjJBzQqbvCdNiF79boBytYw7hQNkcrTtuzFKCa39RMlHtk4r0tXTH/aHn/dcics5jtGu9nyF4fqfotHEcN7jqIEFsEAN/6AQy0l0cSe2YEUhXNQMZgVDnp9g8n1mLK/as+yVFvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaGwOJsU; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so154328439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762843122; x=1763447922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euqY12f4XAJaMQMQzg4Wpf+lFNr4mTaEKvgVSPURHhY=;
        b=jaGwOJsUZMZr1jiRrsNHmVqy35q7rOI6W5pkzttJjG+ee6JzphMOKTWsnG3z/6JdI1
         s+PlJv4caLqJcShxCZ02E61LBBmFQoKbEjjtmJR7IAsS4K5y9+0Mol3It5UwOfx5SV50
         QOsdgv67VmyhaaMBJmbPZ/8CI2eP2ZrxN8V/pmtaf7lRd8zydw2PziEHTDsWn+vpETQm
         rV8r6IfbufZZi/QxvbJvsWr/MKxNc54AIqKnOT7WyOyHD6YPjRspW09euP1sEzqXtGGE
         Yjo5nvpzEAm6kpLoouxSBZpjDHgaRdNtfqzc2PQ6DDF0mE4pb11InpD+ceyukQUnnHly
         6eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843122; x=1763447922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=euqY12f4XAJaMQMQzg4Wpf+lFNr4mTaEKvgVSPURHhY=;
        b=TAJGScLoZqA+hqjq6CudxhAPSi4ofINQdUJzrFtpSaXLmVTY1hOsENRc8jCvyps7dp
         LjHF58uBpbs9KgbkZSBP7GoKKTlHKCmwmE0TpjtjY6Qhd97mHPAqVBRJann1VwLe2KEI
         C0aE7EGVGmS3XXkILm+IU2/6oLUQN0CXOG2vzhY/pWnUcv94912vmbapwv7mMuDALFdP
         WhmWbZKKiCCqwe2uNq0MCXG26Wp+t4zkpvWyK3JJhsO7ZPnbWfpZ6hc3p//wZkb/vaaV
         xVHi95lnO5imiQyrgiAqqZAdZxXqg0B3mguWKLPp0aYBj/BRzG7OuvyWy2Tb5vFlFop+
         eKSA==
X-Gm-Message-State: AOJu0YwhdU8/+B6xMutwxilFCecsrURYer8cRM2D7AhEG11gMztKSCBF
	xVlEg04RismIUuB7Syf3prGDP0xCtRvGvqDfTQv+tqi5P7lzR3Xy6MpLXiq44rnBNMnqIpYOY3E
	RDkVPuiPx8q0gz9LnyDfOjuL6kwEmgcs=
X-Gm-Gg: ASbGncueLTQK9HFX5Q9t2KhtyYV4hqWEbQQejpxMmYVyQ5/iE80s/w2G9Ff3c/26oNi
	btwWDbwYBy7EqgJecvlGSAyXmePpWJiF3k8tlM6/mzaGksR/7f/aVXu8naatH5CI8cGRafuntQo
	vtkbRzDqGRsLPB8TcUM8YILlt715MKMzvEEPoFg+nbZ9+tkBoa+6dMoOldKMBjR3A8LMDM5bK94
	Denr/exEbcGDdAGR40AMl/I7tAGuunJMYzLH+7QFaQ2OHwco0GTMAeaNzL6GA==
X-Google-Smtp-Source: AGHT+IFeRoakPRE8zi8k/oOfrR5pGfeZ4LbIVSqGrdkQqduDKfojeT6f0hQHugs1QFF1bO+YSrrqClPiCfH+kAuQvdc=
X-Received: by 2002:a05:6e02:216d:b0:431:d864:366a with SMTP id
 e9e14a558f8ab-43367dda177mr162444325ab.2.1762843122159; Mon, 10 Nov 2025
 22:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015094117.535157-1-rk0006818@gmail.com> <CAKY2RybBidcyMtUY8mwyT=F2e5f=HT9HR6JXmgz+UyU6_S3kUQ@mail.gmail.com>
 <26032cb1-53c6-46a1-b3eb-e1876142bf1c@kernel.org>
In-Reply-To: <26032cb1-53c6-46a1-b3eb-e1876142bf1c@kernel.org>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Tue, 11 Nov 2025 12:08:31 +0530
X-Gm-Features: AWmQ_bkXO6wyq1jlR5vqIwoGltTDZvA3BFaS9rpCJPD8ZK7lPKgSIKGBD1uL6n4
Message-ID: <CAKY2Ryb60yKh1ooFoF4VSTwSdR2srBVMTvFAy7PwVmxE__+SDg@mail.gmail.com>
Subject: Re: [PATCH] firmware: stratix10-rsu: replace scnprintf() with
 sysfs_emit() in *_show() functions
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:15=E2=80=AFAM Dinh Nguyen <dinguyen@kernel.org> w=
rote:
>
>
>
> On 11/2/25 23:55, Rahul Kumar wrote:
> > On Wed, Oct 15, 2025 at 3:11=E2=80=AFPM Rahul Kumar <rk0006818@gmail.co=
m> wrote:
> >>
> >> Replace scnprintf() with sysfs_emit() in sysfs *_show() functions
> >> in stratix10-rsu.c to follow the kernel's guidelines from
> >> Documentation/filesystems/sysfs.rst.
> >>
> >> This improves consistency, safety, and makes the code easier to
> >> maintain and update in the future.
> >>
> >> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
> >> ---
> >>   drivers/firmware/stratix10-rsu.c | 7 +++----
> >>   1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/strat=
ix10-rsu.c
> >> index 1ea39a0a76c7..53c896ceca9a 100644
> >> --- a/drivers/firmware/stratix10-rsu.c
> >> +++ b/drivers/firmware/stratix10-rsu.c
> >> @@ -454,8 +454,7 @@ static ssize_t max_retry_show(struct device *dev,
> >>          if (!priv)
> >>                  return -ENODEV;
> >>
> >> -       return scnprintf(buf, sizeof(priv->max_retry),
> >> -                        "0x%08x\n", priv->max_retry);
> >> +       return sysfs_emit(buf, "0x%08x\n", priv->max_retry);
> >>   }
> >>
> >>   static ssize_t dcmf0_show(struct device *dev,
> >> @@ -632,7 +631,7 @@ static ssize_t spt0_address_show(struct device *de=
v,
> >>          if (priv->spt0_address =3D=3D INVALID_SPT_ADDRESS)
> >>                  return -EIO;
> >>
> >> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_addre=
ss);
> >> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt0_address);
> >>   }
> >>
> >>   static ssize_t spt1_address_show(struct device *dev,
> >> @@ -646,7 +645,7 @@ static ssize_t spt1_address_show(struct device *de=
v,
> >>          if (priv->spt1_address =3D=3D INVALID_SPT_ADDRESS)
> >>                  return -EIO;
> >>
> >> -       return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_addre=
ss);
> >> +       return sysfs_emit(buf, "0x%08lx\n", priv->spt1_address);
> >>   }
> >>
> >>   static DEVICE_ATTR_RO(current_image);
> >> --
> >> 2.43.0
> >>
> >
> > Hi Dinguyen,
> >
> > Just following up to see if you=E2=80=99ve had a chance to review this =
patch,
> > or if there=E2=80=99s anything more needed from my side.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20251015094117.535157-1-rk0006818@gmail.com=
/
> >
> > Thanks,
> > Rahul
>
> Sorry about that. I've applied it.
>
> Thanks,
> Dinh
>

Hi Dinh,

Could you please share the commit ID where this patch was applied?

Thanks,
Rahul

