Return-Path: <linux-kernel+bounces-749341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA5B14D24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF8C189B05D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39A21B8E7;
	Tue, 29 Jul 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw6QR0Xz"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FD1E2606
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789515; cv=none; b=gohLjapq7bSctL56iTL07Hx7tQqTs+oBpu/AE3F3uwawpYkPbUQKDrNLg3+wweY5GauyTUM/gDN/vb8QmarKwx3e8c+a4IbH/2OphUz8267/xUSf17uFPW42LwwVQeoeLUR8yF7nZHo+8U2Jhz9ifeIeMFyhAtM5fcaSYuqPCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789515; c=relaxed/simple;
	bh=CwqCF9KkaIWYMXKQ2dUMouAu7sXBqSPywjtOjPo7Rpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8e6QPsaxaUsdphLAdY00cCa/Tfdyqc9jb6ct13EXEQUaiONtfFRBrvzDd6iqdPfWJhEgvV4cWCF7dfnL1WCY3nmJgEbnvqEyF2HdSE1l45q0JSS0+mV6vfuks2o+JbVX+aHrwx3oFpZG7E26PIhODEX7nUAWrj+pzZ9wvgRRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw6QR0Xz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2ea58f008e9so4018088fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753789513; x=1754394313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=54GN9RZCdtZRrIIoQCXnrksy4ko/oLl8VdGeEOdkMU8=;
        b=lw6QR0Xz1tV72mLu3ZiBSCqQCXjqqwtKT4AxicjfLI5kAF+2TgEKOoFthQdskAchf6
         hs0RzYAUhLHds8qL5PXh24oE/7ErMAGtRfAZ4tQNycHBh/0Y0IJ7k+yQfNDRuB94bV+r
         +pevmlNW0P3lcogdXAHIezeMRZdY6ZNUcF4Gj0detRDihr3vhLHHHDBVC5QsY7h+82St
         38A5jtjPJim5AGoidaZnywCpX7+Rd5BaOD8S7XPo/xB1T1MJ0sCYKmv95PP4FpX0AQRc
         GE3j1RDjD6GPLG0lOFnDwwTqM/6RmhcACiK0ZnVdE8d2eGktK0WxRJR7KbUisH3qpWnI
         YRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753789513; x=1754394313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54GN9RZCdtZRrIIoQCXnrksy4ko/oLl8VdGeEOdkMU8=;
        b=EWaGZi+tSJjS/srWiYzEklcOn1qatQFy4iBb4b5epolCfN8lVEO7vBa8kkl5Enp7Ca
         S68cv2LminGFb9BvHkytHjFmHnTM5tC2f6znynCmD5/CZ1UKGUVwQgcxAHnXu55+EjE7
         IwJH2YwoFw1GRLSgrQ7bCFnKha1GWlxBMMF8lmtnBFnZqAsJXq2NCc2LNGss6Yt6S5gM
         tjaqozu9cAUvrbJJ5VQ70mP87ONVfFuJB7d5zv53PA88qpcT4t1actTHDYWQcLY/tRN8
         gBDtU1DQ7UBTkA7QFo+/igRVwEUkgDJSi2MwgAR0YZaK7J3+JV6Wf4jF1pEYraX0D8QR
         RVTg==
X-Forwarded-Encrypted: i=1; AJvYcCXl4yj9SdEx0TZ+tdqNxjappnMhQfDeWhx/vwh+PqOVm9mmyMyG7FsuGSJDhZove6J0nEvVWnBL01klkSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFmYDVZgH/u+EC1qqFUL1Mq+5v6m4UgMEf/lrG+H7w6tm1DGa
	JWsaCTaBF14rQ4/jTXBZhsPAio1AB4VSOJiZD/5MW4jkH/HYW/nHAml6pNLJi4QvHqz2xmBgaNs
	wmNj20xNUP4l3+P+PqCt79mTRFhDuFLE=
X-Gm-Gg: ASbGncvyGPHu4MrsMLmUJKYo8D3205PQVtQYZidVTkf0YogSTP2JeJZ3F+WmWssgtUF
	p6I3yTneJNkGaKvxoUqARgr1G2OOljsJv5hb0IJe+umxrV19DBWRxndvgGoXxBnC475L2TpI1/O
	f73qhEyyKxkaqKP+me0rE5ZsX8ACHTQu6J9tKbZay3+MHymFwKJwFzamSuF7UNX/12kQbIE3ysg
	gHqDCRV
X-Google-Smtp-Source: AGHT+IF2VoFtEHdUx8olCgcz5kNZJoRqhVc9zCXSwVNqqUEXR6iKIoAe/QSJEdIbOw0bojrHy/bqKCA89eJ36HEwMsE=
X-Received: by 2002:a05:6871:e604:b0:2ff:8bc7:44a0 with SMTP id
 586e51a60fabf-30701ac679dmr9014878fac.22.1753789512861; Tue, 29 Jul 2025
 04:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com> <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
In-Reply-To: <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 17:15:01 +0530
X-Gm-Features: Ac12FXxiNwEvOzCx9tNPZ0SRAhaKaDMzzgk3wtnJmBlGhi8OfuHQjhh1fBGgmJ4
Message-ID: <CAO9wTFhCb7gDEo+q2SAZcn2KdUyVe-fG1E4bR_+US9k2J9DOnw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace tools
To: Joe Perches <joe@perches.com>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 15:54, Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2025-07-27 at 18:20 +0530, Suchit Karunakaran wrote:
> > The checkpatch.pl script currently warns against the use of strcpy,
> > strlcpy, and strncpy, recommending strscpy as a safer alternative.
> > However, these warnings are also triggered for code under tools/ and
> > scripts/, which are userspace utilities where strscpy is not available.
> > This patch suppresses these warnings for files in tools/ and scripts/.
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > Changes since v1:
> > - Create is_userspace function to check if the file is in userspace
> >   directories
>
> the changelog bit should go below the --- line
>
> > ---
>
> This

Sorry I will change it in the next version.

> >  scripts/checkpatch.pl | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7019,20 +7019,24 @@ sub process {
> >  #                    }
> >  #            }
> >
> > +        sub is_userspace {
> > +            my ($file) = @_;
> > +            return ($file =~ m@\btools/@ || $file =~ m@\bscripts/@);
>
> All other sub uses start in without indentation.
> Please move this next to other sub blocks.
>

Yup will do it.

> Please do a git ls-files -- '*tools/' and see if too many other
> files are matched, especially the Documentation/ ones.
>

I didn't quite understand this. Could you please elaborate?

