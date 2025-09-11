Return-Path: <linux-kernel+bounces-812548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33BB5398F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C8A165EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4035A2B9;
	Thu, 11 Sep 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC5dQWDa"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628C35A290
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609082; cv=none; b=OGkdSPUQeyDoMjNyOlWoJg389+L9sJNszcqaVk91nDU38egZYzsQ9+KdiSGiatEoDnyqqMPXGq86HGOdYUwK6y+TaHTqxQ+WnydFQWW4yUQfnIt7lw6KZCF/1Qy4l5U/7T7PO6r6E4lV+o2PTE5JG+5XZ24aRIAeLDac0j4s67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609082; c=relaxed/simple;
	bh=r7zIrmTcH7V0C2QWyQEZI8cLSyj2S0FQeUO8H0HYb/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNmwLNh8qA4PWRfSXfV/z1KdQGEqYEo0tauGxKxW2+KrAv0ltgqVEAWYT7Yn1vQcMSrfTXOttnvhgzRxE/wgoyLeJLz+YyDL2dDch3Twxu9TNO6OkaZV6m/0+lJ7AG2d8ePKe7mDcSJNuxk/k2+rJ3upZLIjtoQNTVUcXD3ghns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC5dQWDa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so1594132a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757609079; x=1758213879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7zIrmTcH7V0C2QWyQEZI8cLSyj2S0FQeUO8H0HYb/8=;
        b=VC5dQWDaIQhecohdCyIF91m6W76hZjyQUcLikkxKSMsyPZYxqpWt/sWoRXtpjM6XZg
         HHMXzIz4iGRdrS/AkoKsr0vG36/jvJvo78pbs/nRsoSqq/wXizd1zfyW8DC8XBjx1dnp
         +YFvTgz/TCUOmPdMnKnxH0+geOZ9iz9taR3xbM9DJdYJljfuz5UjEnD4IFRpdVqBH9Ar
         H9dG4jdaRd8WrTRp4Giyu9cztxlLnfO2jYNWlWNjmu/ginLKGoA++Ifp/EMmqCbcqPRR
         153E83vLAlu2aJnwt32wzsX5awCh8THa6vJvs4O8Bu6m2V8vX57YVHM3UPkeFneUxKpv
         iOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609079; x=1758213879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7zIrmTcH7V0C2QWyQEZI8cLSyj2S0FQeUO8H0HYb/8=;
        b=ZaqVaaZqY7MWUOsZlFIQH35RyIqq/p7LAExL1tIX9mDvRuAxYBcDhYKYU3v9kRtan1
         8P9tIhNeLc0Mkd4cK26bprlcFV8sKCymGPbdqQPnhjoH3DeKFx+bhre7VRNzHOEqXOBO
         CPpO1S5SI94x4/7SLG5WZpEsdpr3PoLFpnQtD2i1phFgTXapKz3OS+EqOLQeVkDffhDN
         echBUzNb7DYC9RvS/LQGOuo9Zg+2qqPldgj9QZEOZ/VCaVkVbvgU97+3BHRraTxg1DVL
         wEMIFUD2fT8oXiEA0DhxTEdcMKbkxLzUbW+Pwy64/1akkjWue7LkY7BFFRBPsZMFRBHL
         ub5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuI5vODnjH3ipqg7cwwuRIjY4JRFyJVW7FDsHa4xHY6NBe8OYdoEuuLdLsfiHuWOQghll+I7gYumWL1ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmbyweE/OXEDr95u8SqslZO8X7r8Dd6Yh+W15XKu+FWTse8bC
	Uzlq4H8pQ5XDI5gwEHp8/3KSbXaKD8Fp4Hq8lswYZlqzsVVlLL6u97wusEmQZBr6iimR76/G3uK
	EwPCM9zRkICcHJpJ9G+GSZ4gUQQy49Xs=
X-Gm-Gg: ASbGncseGZShXgmPO2Ttuv+aYwL6LoRjTJidYYzoFSzbMc1y/xnt4qposhKyaCz6Ib2
	PaiL57FnloF3ci1xnazCCXXEsi2XSwQcM6ad1GTlFnS+ZNKObY+70rcEjEJLNC5vmqr1i4GD/NK
	LLtef+57JkGno2ek60sRT2y3qnQ9CwCkDkdStGGu7hiU4nquMg33vnA7l9KB8I+c8Aw/sm/bwiC
	jBcGgnIqKTTCpWHihs=
X-Google-Smtp-Source: AGHT+IFs1CV3yVVZXZDMGsTeTso3AEuFjceZvzC2pTMX9WT/SD8BBKjIvKtouj4GtucfAqE4OoYOii8QIyUDf/twVIk=
X-Received: by 2002:a17:906:4fc7:b0:b04:9acf:46c4 with SMTP id
 a640c23a62f3a-b04b17376c1mr1933063266b.51.1757609078466; Thu, 11 Sep 2025
 09:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFYUeKswEh54fM5bFEvOfFLfc_GunKwEgr2uND=j-pxixQ@mail.gmail.com>
 <CANypQFYGt3c1eoeytCzw3RKLw+cbtDDPJy8UM=aj8HQMC8MWmA@mail.gmail.com> <CANn89iKkQ_zmdYwFLomcg4H2=4s8f1_2E8UbHhfd9KEPv=tu_Q@mail.gmail.com>
In-Reply-To: <CANn89iKkQ_zmdYwFLomcg4H2=4s8f1_2E8UbHhfd9KEPv=tu_Q@mail.gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Fri, 12 Sep 2025 00:44:01 +0800
X-Gm-Features: AS18NWBS4uG5Gox8DFZ7HZzpk_Vt9bHfh2HzF20kEvBgTQrA8elDiKoDobubpYc
Message-ID: <CANypQFZVc-+E-xDWyza33A=BTmYRQjsK24z3Tny-X3xzoVO0jQ@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] WARNING in remove_vm_area
To: Eric Dumazet <edumazet@google.com>
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	security@kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reminder! I'll keep it in mind.

Eric Dumazet <edumazet@google.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=94 00:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 11, 2025 at 9:29=E2=80=AFAM Jiaming Zhang <r772577952@gmail.c=
om> wrote:
> >
> > Hello,
> >
> > Apologies for the oversight in my previous email. I neglected to
> > include the formatted report.
> >
> > Please find the formatted report (formatted by syz-symbolize) attached
> > to this email. This should be easier to read and analyze.
> >
> > Sorry for any inconvenience.
> >
> > Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 21:59=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Dear Linux kernel developers and maintainers:
> > >
> > > We are writing to report a kernel WARNING in remove_vm_area,
> > > discovered with our modified version of syzkaller.
> > >
> > > This issue was initially found in kernel v6.17-rc5 (commit
> > > 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c). Unfortunately, we do not
> > > have a stable C or Syz program to reproduce this warning. We are
> > > actively analyzing the root cause and working to create a reliable
> > > reproducer, which we will share as soon as it is available.
> > >
> > > Attached are the kernel console output and the .config file for your
> > > analysis. Please let us know if any further information would be
> > > helpful.
> > >
> > > Best regards,
> > > Jiaming Zhang
>
> Please note that syzbot reports bcachefs bugs quite often, you do not
> have to involve security@kernel.org,
> especially if you send public reports to linux-kernel@kernel.org.
>
> Thank you.

