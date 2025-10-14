Return-Path: <linux-kernel+bounces-852070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB7BD81A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE711922037
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B130F532;
	Tue, 14 Oct 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rc1kw4HY"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A642FD1B2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429224; cv=none; b=RYuuk2p1rGYqjQNWQm145g7rXV+EsmpjeYTGeMf5NJI84mE4l/UyJ6aLNkbmMX8cwhsxixGqM8i0rwsVLxkxeo1G7E/DpExoEaNkiW2d9snvQi2vY+icI56UYU+ON1vqcyoEeo9KFje8HjSmrsivlpeaOIG+0cPL205Q1Se6bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429224; c=relaxed/simple;
	bh=gaSrNFnxGmoWet5IGMWfVxdar8Dax24kjJ0xtMz88wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyWONDs8GUyQHn1K8abZcdcvfUQoFxpqD1lih15Qz0BAto4lWis+ArXnwEKjDLlTlFFIc+air70d4BY0xz5I4acly6seceAthzum/SzW9stoQOihagEtLD31B0PJHJjyWTIcq3Y1l0cmuyHgemMzqWZUrWf47JgriBtCb+3zC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rc1kw4HY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-863fa984ef5so837290885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760429221; x=1761034021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaSrNFnxGmoWet5IGMWfVxdar8Dax24kjJ0xtMz88wY=;
        b=rc1kw4HYUwr0J+7VjLspfU3d24nD+7iHjbbFHa4aJJMEPazlubRP3eBm1wfICIWAtE
         zB19VarqawbMtY4QCSQa2TX8nxHGoGnBWvWswkA3X2ZuQ8ItOY527qDJ1m2kE4GGhh8L
         Fhmoqs55xEDQnMA3i2UcCoiDeTF9QT3qYo4Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429221; x=1761034021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaSrNFnxGmoWet5IGMWfVxdar8Dax24kjJ0xtMz88wY=;
        b=UbbxOf2NpijRghIUGDcA5cdKZvs4SrVQxvGjVJJg63TL0yGUD4C1kGj5z9SCBkIC/+
         tquVg9IrKhtoTGy3SN7LyMdrQCqrwsFkAGIMUG7wP3dp/r+MEx9mDtlNpH3nohPPDKHV
         3btyKT3jiOh/OHp/TTUR6OJhGo54Ie3yt7JRh4f3+DJ6pofDrQ/TtNyF4+Bm8fyR4wdA
         DYox123LBHlLeU+Tlg8Jk3rNzZOIPFJ5eQGkDxpkXrRft0jnajhKie3GvRtL8yQOpvM/
         aHEMBZa/0QCKxksb8LSK26s31SHo7zLudOqI6NOJcW3IZEQnebPIfjbYSJ5oWXBAZC1c
         ha+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKnfNniLE8SGj6GG9KJL8f0DxBjCfsdpsnDKT7hRl/89nmsFaNbDtgZG1ORXUEAAO+r0u24cnMhmz2oo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tODhuoEftksObgxH1eu9miRNLquUt423prOCCeRtFm6yeYD8
	GJ2N9Q5/M+PCpWWXArRQzOQ6/oP6YSw8c2r3OoR4d2sGYAPT2WmQrYpfEtMTLAQz3eJLptUTZ3G
	PDhlPLRMwnGo2ekajEMCgIGgqo2JZ0C9u/6g/xvf9PA==
X-Gm-Gg: ASbGncswgOaVh9/3zU85MysMWPiV1PfiERszVrK5Yv5ClBVQus+fyQm/shxaVGwrSu/
	EYAGLKI6bYOXvjp4kdlb8GfbYtuKX96pWvch5hE3Oaheq+ionpotq0l0PVKRX6v+Fi12+yEGTTS
	KZhT3FTnT6mcU6VsWBsznmYtRxOTdifO3WALMretm9U9yHGzHHIJHLfoTX2WV+bFDbAbfIhMmJM
	RRHuSuoNwl9Dgp7BNDld1ZMhSqjPe8fLqz1P/qsBi3uiFHLunODlvoaPJketPPEuy5XRQ==
X-Google-Smtp-Source: AGHT+IGZ+aeN0K7J2mOJHMpdF50iEHtXyXs8Vs6iTcWHhQxhE8sH0fNPoY2WKEuKSaxfOotYWPF0p7oQCdN5qZUhbrM=
X-Received: by 2002:ac8:5d05:0:b0:4b7:8d26:5068 with SMTP id
 d75a77b69052e-4e6eaccbd0dmr317846191cf.17.1760429221421; Tue, 14 Oct 2025
 01:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
In-Reply-To: <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 10:06:49 +0200
X-Gm-Features: AS18NWCR1GKck-Wej2NUo535YcBBaKeSQhVsfQwZGBEEsJgxvdNEg-fGJr-c27I
Message-ID: <CAJfpegt7WvXZr4D4kqGujD=MXEQa7oRH3gvk90+D7Pha0MJJBg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 22:16, Bernd Schubert <bernd@bsbernd.com> wrote:

> For an intelligent server maybe, but let's say one uses
> <libfuse>/example/passthrough*, in combination with some external writes
> to the underlying file system outside of fuse. How would passthrough*
> know about external changes?

It could use fanotify or leases for example to check for external modification

Thanks,
Miklos

