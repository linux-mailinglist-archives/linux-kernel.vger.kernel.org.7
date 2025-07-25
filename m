Return-Path: <linux-kernel+bounces-746152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C900B123B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E9A1CC75AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE55242D83;
	Fri, 25 Jul 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3URGN9S"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617858F6E;
	Fri, 25 Jul 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467749; cv=none; b=M/fBGujy4pgLojnHRX+u+OiFWVSTjFZp3qypZnA7Y2+sNvdaFwvlK2WzeI21kk80Z7ocLpCn5SC218XQ6IjKrKvJuDvtHOltVbXVe71+mN2pHo2j0hJgPt0SiwJnFZ37M7WSESNO9K+BcMmXnc2KboFn1ek2JiafApuzp6biPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467749; c=relaxed/simple;
	bh=mav+SN8G51+FKZ172ZyrH23tzjpXQF7aNwFTGdrDGa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxPOxUwx/CKIGiSizoQ4REQNX1QAJw5bPGayLZyWWXAzWGkbeX/vKX9j9cYoZHvRbc7JgL17vKrSg2U6U+LQOmBsWN+zPgQY5kZyAWvqw55UPdQG6U48d24wqlNer+nHn1Xj+PX8+53/FLauTxJ65OMQeZDTr8RjPwHxDpCyNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3URGN9S; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso1565411137.3;
        Fri, 25 Jul 2025 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753467747; x=1754072547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDdrXU0H5darvHsz+EX2SqTmuwLmazQOdrWR9KxJ/3I=;
        b=Z3URGN9SXaUSNilekgWsHJfk8wJl+e5iewIxZQ55lw7Ltq6XbHR/GKb9csrREXRaiE
         hSwCstv3N51h8MeaERpoVkSIA4ScF1uxPFT8rivZsNw1AJ7CBPi+9HLQraF5hWj+pjfS
         4wLwbB2k3CbiRN9VzQAyPr6J7brW54dHQp9F1JApaXxeZ9aP2CNE2JxiRJG7g7W2AYvW
         KqY6xFDvS0/nf4jTeYxjMsRslUgrLJ4xYBZldwhY1+lnPyDZu95kDBx/s84JZPeJ0hCv
         51h3MHFFPec2mXE5H/4ymlPaVCt5pYLVdmrbOauMlVE93rZYCgI4PKoSB0FQOGm3IYv4
         8E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467747; x=1754072547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDdrXU0H5darvHsz+EX2SqTmuwLmazQOdrWR9KxJ/3I=;
        b=NyNLKsWc3dkQBDXY5QxuvYlcni2etxWYDXiALOEtlgYjkwJzCSCXqlUGLKAbYHIrYD
         fR48wshyPl3wMjz3Zo0c75ItzYFgQ23Opd2DQwWZoIhMbjpnwA6om6MJ6Syg+oP57ikS
         BO+51EKdrjZpAfmXWAho0Uj6Ab2VCeRVakOzSXzbJCrn/rdI7XsOkVz+Mwp+cCNw7Dvk
         AJL6UaC7M/uR0C75DQcHynMF12vCQDOrARaFbAdM5A0GMF40lHQLp7UXf/fVSujbn8p4
         +2r9qCogZSQzECTnNfPHuM0SlI5NyKg8wDxBFeyJpHeQzDShjFl6k3aPmjVv0LWvLHl0
         PdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMDtTEho0BnMAOKCdTb4BRoBITu6VsjdRvfptipigHA1cgnrNX3RLSmvFIBr6cHb821oOcGbMC0jJ8aos=@vger.kernel.org, AJvYcCXxRdnp0ZMJvmqehVq5KmfFJGbajeIPSPmpkcMmnzluy/2dlsuGK2QQzwgjCWqfapzyoS1KCZ011NMPN8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5ZG9E6bLR7EOgd4J7HuGR/YcY9Xia8ILULPdhJih/4VicYOw
	RMiJRKV4uA1aArszJ+1aKfIbq4jJMtjbaddJG+8Gp5noxTybSAugDt4DayP4n29c5Q9giPB3Wo9
	1IEjAdx7fTeq4YGKF0eiA64qqWToe3vs=
X-Gm-Gg: ASbGncv3PZPiDuQ2qhY2NWC5lonSUTS1otuuNgyA748JEeip07v2trB4e12Yz4Efy9K
	7wYwt+XahqEHtyayXPobgyw8z03jpE2jNuZV18cyhHbo0221zqWdMTVJxQOKvLGOS8WD/lvVKb2
	57Xffs//e9IXD4w53PmQLrAWBJMwt4lsOBQ8kaAkdJ3SaV29ijvnxonuGMWl9GSDLh60znCFEVD
	rERKVXimI54MTjhAoTIY4lSYfvwrDfgzkohPh0=
X-Google-Smtp-Source: AGHT+IGVL44bVMfh/XTRvXgIEQR9AztKLyaZJXURVCJhhoUvvp6/9jZx5/Fg9QIlXvemUbw3WOW4FaC6NumapJjWIyA=
X-Received: by 2002:a05:6102:6cf:b0:4e9:b60a:441 with SMTP id
 ada2fe7eead31-4fa3fd91775mr1534186137.13.1753467747115; Fri, 25 Jul 2025
 11:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723230927.109534-1-sperezglz@gmail.com> <87o6takqd3.wl-tiwai@suse.de>
 <aIICZmB5-7gj1M6W@vaman>
In-Reply-To: <aIICZmB5-7gj1M6W@vaman>
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sperezglz@gmail.com>
Date: Fri, 25 Jul 2025 12:22:16 -0600
X-Gm-Features: Ac12FXwNXnWPJjUUGZtf0PogYHGSrWtcK1NvRZlNPLdVDy5GL33fmT2YmaY-a7M
Message-ID: <CAMCbnuYVELzWU0jZm8LcSEVRigOz+P1Fmk9suunr63asFjMFiQ@mail.gmail.com>
Subject: Re: [PATCH] soundwire: sysfs_emit() expects a buffer of size PAGE_SIZE
To: Vinod Koul <vkoul@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, yung-chuan.liao@linux.intel.com, 
	pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All right, then, this will be handled with a different approach.

Thanks,
Sergio

El jue, 24 jul 2025 a la(s) 3:52=E2=80=AFa.m., Vinod Koul (vkoul@kernel.org=
) escribi=C3=B3:
>
> On 24-07-25, 09:19, Takashi Iwai wrote:
> > On Thu, 24 Jul 2025 01:09:25 +0200,
> > Sergio Perez Gonzalez wrote:
> > >
> > > In read_buffer_show(), allocate sufficient memory to pass on to
> > > sysfs_emit(), which expects a buffer of size PAGE_SIZE.
> > >
> > > Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?sele=
ctedIssue=3D1648019
> > > Fixes: 35323d8ab811 ("soundwire: replace scnprintf() with sysfs_emit(=
) for sysfs consistency")
> > > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > > ---
> > >  drivers/soundwire/debugfs.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.=
c
> > > index 825f7abbad32..08fb1e29026e 100644
> > > --- a/drivers/soundwire/debugfs.c
> > > +++ b/drivers/soundwire/debugfs.c
> > > @@ -306,12 +306,12 @@ static int cmd_go(void *data, u64 value)
> > >  DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
> > >                      cmd_go, "%llu\n");
> > >
> > > -#define MAX_LINE_LEN 128
> > > -
> > >  static int read_buffer_show(struct seq_file *s_file, void *data)
> > >  {
> > > -   char buf[MAX_LINE_LEN];
> > >     int i;
> > > +   char *buf __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > > +   if (!buf)
> > > +           return -ENOMEM;
> >
> > IMO, it's better to scratch the whole previous change.
> > It makes little sense to allocate a large buffer here just for the
> > temporary formatting.
> >
> > Moreover, *_show() functions there take seq_file pointer, and you can
> > just use seq_printf() directly.  The sysfs/kobject show callback is
> > with the a fixed PAGE_SIZE buffer, hence sysfs_emit() is useful, but
> > in this case, it's a completely different story.
>
> Agree, dropped now!
>
> --
> ~Vinod

