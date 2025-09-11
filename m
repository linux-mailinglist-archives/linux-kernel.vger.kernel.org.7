Return-Path: <linux-kernel+bounces-812537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B968BB53962
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BED5A2F28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE235A289;
	Thu, 11 Sep 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxhAQsYE"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B833A03D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608438; cv=none; b=Bv2oBAGgWnV6DiL3R0d2m81cALHfpNwHfRCankh5QOzRWZrSj9LvwSD9xLuAJ2+zfYDpf0orqR1auIlUXZWGIp8XzxXl5p/fci6MHhFCJDL4MrxINBf2pc8ziOS8uYSd949qCV0LhVIsZnQ5FxT3B83mwtj9zaaE8VZJK+2A2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608438; c=relaxed/simple;
	bh=XRpc+knh/XAGoMqBcH6aN+Qn2be+thMVYIuV1pFbNDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbym0a8hMzGb7jSDl+4h9eMHSxNnfqJwkcld0dP3v+h9r/e5jRh9NN13Fod9z5Z8sq7knTjcoTHiVNGBAz/t9b9HZm5pFHmXgc+T5nRlkptLkneBJ+0tTli7FhhfV9MoiG1yTFXWWSLHlRYF3dLhT/BQNBpyXmwLcJY6D0i4YRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxhAQsYE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-80b7a6b2b47so96003985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757608436; x=1758213236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRpc+knh/XAGoMqBcH6aN+Qn2be+thMVYIuV1pFbNDg=;
        b=bxhAQsYEAkDWSwLT0pB9/BQLJ0RyCYomKP7sHMcs8ePjcFxCNLnv+604hKj7rMzv9i
         Z/lnZtdq1Dq3nsIi9lMlMCX45dOU4tK0I4JNKgF4ahOtK3g9YM83car4yOsHLccLo3XZ
         vTtkEwnxLTa+BaiAs2MFIL6C2vxd3+7FY4rqPGJQPGaummjGhCD98CV0SbYJ5a3uc49S
         InHpZOjUj2XjTY99PzhWy6kbRbCpPg9ryx5N7BSO7VGnRFmIrs+9zxo8hG2LmDagZgCs
         PYr3Yc1zJehERBv4ja5EXsgZKxAoshiMVlmBvFnwNbT6C5RWM6fEdNFXKhxlyvwAuu8d
         ZQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608436; x=1758213236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRpc+knh/XAGoMqBcH6aN+Qn2be+thMVYIuV1pFbNDg=;
        b=GFY9v5LkFssKEQVJoDi01JfEGiLb01KWsINgrS+ZEcItnv8fnsjWzsJr5LYIFAKEOt
         ng1m/p3XYF4U9z/WOQQyE85Zu5w3SzgB5pcqIPJwRQKJEa99+1zmAKknNbmP2W66f55l
         PTjNXKbOBc/RWC9cbOODNAj/1i0dTdSrXmeWLCcjtEt0Jp1myGia29Jc1DnedE3PuQs2
         CnxlhsNFqvMIPbHPWil45eoc1hsrgWg/gDyOF08sGp4pr6uP0FSRGarXovK4Bhzodof7
         l2d1l0UvtFmByneJBgAAjtoZ6FBoHBNhUnvb/kUmbRcDFmu9B/YoXPcGDesUo9JXHyO0
         sMJg==
X-Forwarded-Encrypted: i=1; AJvYcCU/q0205a+lH8ugs1Yosu0X5m/fqG+o0tkPWjOK5z5gylM3jY87kjf1t106mwcUMRgA7Los4gx4e0wrY44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhWnDFp0aZ0dpEaginLjeS91xuxVqV/fmTrZn3OLaChrC/N5z
	bvJn2V6ITUxhrm3f9i37AewtkAqRwokjN3jkTEqpfdZJgE7aOYXaU2K6AWUsoPpUSiJOBrpqCcx
	ok0pVGZRAMIJqKJ/mL7RHIhnBvl7E1YsxUydlIclf
X-Gm-Gg: ASbGncsPxWJ/F0SWA+IekIvKSJeTg5k8SbBGs7Vlrjgmd4KNbiMBHS7BtJkq7Q4tKXo
	mzovgt2mkaweWnxw+x57sRyR4xTHiFCfTc5G/Ur38jYSc9eRqBxIW3UZnF6Ys6aR5pVpDtTN8gf
	7YKJT0qU1jjf1Mw4G6XJEB9kopsS0DS8zpmZlw+ChZZIN1qOxRNjEHcK3fBSwzNQ4HTjF0WiqI2
	8RGBInedcs9obUaMJgzJNIlBw==
X-Google-Smtp-Source: AGHT+IEaFA8tsNcJeHfx5qLmIH0MNFjzi/To//8aF+L9OoKjWM1WmelbHtAWtohQ9HZ+iZUhBysXGLmTj5pKgg/s0xg=
X-Received: by 2002:a05:620a:46ab:b0:80c:e95f:8a54 with SMTP id
 af79cd13be357-813c0d0e13emr2025336585a.29.1757608435516; Thu, 11 Sep 2025
 09:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFYUeKswEh54fM5bFEvOfFLfc_GunKwEgr2uND=j-pxixQ@mail.gmail.com>
 <CANypQFYGt3c1eoeytCzw3RKLw+cbtDDPJy8UM=aj8HQMC8MWmA@mail.gmail.com>
In-Reply-To: <CANypQFYGt3c1eoeytCzw3RKLw+cbtDDPJy8UM=aj8HQMC8MWmA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 09:33:43 -0700
X-Gm-Features: Ac12FXww1fFqS3jtWKre_Swiw10hdYzTQtOJ2Z6Tvjkjgn8O4Kb4C1yBFhEel6s
Message-ID: <CANn89iKkQ_zmdYwFLomcg4H2=4s8f1_2E8UbHhfd9KEPv=tu_Q@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] WARNING in remove_vm_area
To: Jiaming Zhang <r772577952@gmail.com>
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	security@kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:29=E2=80=AFAM Jiaming Zhang <r772577952@gmail.com=
> wrote:
>
> Hello,
>
> Apologies for the oversight in my previous email. I neglected to
> include the formatted report.
>
> Please find the formatted report (formatted by syz-symbolize) attached
> to this email. This should be easier to read and analyze.
>
> Sorry for any inconvenience.
>
> Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 21:59=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Dear Linux kernel developers and maintainers:
> >
> > We are writing to report a kernel WARNING in remove_vm_area,
> > discovered with our modified version of syzkaller.
> >
> > This issue was initially found in kernel v6.17-rc5 (commit
> > 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c). Unfortunately, we do not
> > have a stable C or Syz program to reproduce this warning. We are
> > actively analyzing the root cause and working to create a reliable
> > reproducer, which we will share as soon as it is available.
> >
> > Attached are the kernel console output and the .config file for your
> > analysis. Please let us know if any further information would be
> > helpful.
> >
> > Best regards,
> > Jiaming Zhang

Please note that syzbot reports bcachefs bugs quite often, you do not
have to involve security@kernel.org,
especially if you send public reports to linux-kernel@kernel.org.

Thank you.

