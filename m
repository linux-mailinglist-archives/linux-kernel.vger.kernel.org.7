Return-Path: <linux-kernel+bounces-740651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D3B0D744
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6021C2311F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839028B400;
	Tue, 22 Jul 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcdjoWrX"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15F23CEFF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179899; cv=none; b=pehf+yxdEYDVYxA1NhDmM4TErHZ0Xm+Xl+FMKYMLT40EkQX0EJjAg61aKfYDiGJkDXqufu8yUB+qxsJycfko9ucbein4P2XSQRWSiJC+3tcJ/IWPabWkUhR/49TjDJEQYpLkCuh7saoAz2/Yr50oZ2EFulUeb1EEaRhcoD4NWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179899; c=relaxed/simple;
	bh=x1EmevJHHSzjWxhFuCNXDb9xmI8bRp167e5+cwIXvVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gqn4DSIAK2a2tbGO8LSvgp9UrNBuHMMtbqHqTvbZiX34MO15CFVckVyIHImyOEXsBtmRetBBIQz3xObt+1hBRFLA2qhAwdPp7+VSIVjGYqqf+l/bK8etXSveKaOshrTI4JpxHp3XjAsFTQmUvhSiHH5E6LSwgZ64x6Jkyuk59zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcdjoWrX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso7243a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753179896; x=1753784696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33XB74HPhFwcjRRLvueU8G9hXMQh0Pw0WGRpEoj9zY4=;
        b=tcdjoWrX7dc/yZCmGx2KrsRJxv3+dpPTFWN0VqNdpG1DaCg+u+raCY/O1BLNyhce1b
         /juPfmTDHglFlv5wXx+yd0i58sKWBk7JUIi816DzhKUqaH2RC6a5etdZKZPeHDkypFSp
         zn+w4cu4tIfJD0qqvNnWJfLCqIu5nSQFqg9ObyX3S438o6KUTN7esFDAD687hzjiawmV
         04Y+v4z8MCXCdZeXH8tawzTRfGX5jiAYB0qpiPdBvwHWo0MMhMPpQpF7zrSb5MyHx9wZ
         UTsjWJhYB2xWapsWPpMnOAUibiRpj39V3PxPM3YI5ASLyOXX6qq4Ko0CK3IrMbv01MJL
         Ja0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753179896; x=1753784696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33XB74HPhFwcjRRLvueU8G9hXMQh0Pw0WGRpEoj9zY4=;
        b=uKgC/QOeWzz03mfsTLmA1qVcaTzAXbTSG2wTRTBv4AOGsHcu3tooQYI+JShiPfFHB8
         yWA9tOR1e2UdP2CIh7kXf7SqOnhLmLF/6qXFQI2OtVY185tKJdiAksTCbScOPnkmu2+q
         TT43cG3fik+zj1IoU0AZp7LWl7Q88hb3nQicmB4TvhWfGkeRBAhtVrdIH3Yhpoj/emeT
         HADDZIZLFZloI+EXciqMZ0o1QZ66jjhMHHHMVfjMpsP0eS7OEuLEQxzxvV4S0C5HLUxI
         ItkPj2A3bhzNIpiEd56Ut3J83Z9thI7u1SKyGx0F2a7NPMLGWnJ/lAgwVHN+Vf5EBWXx
         y+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoMc8p7SH6+unkFTATRLX0gW0n88nA6GxN9mEyO+UnS9PxRZJsdn54UWz+w+x1i2eykUyCcS2QbMYjaCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSRiYlrUFuZ/2R30lJZvcQsxJlZ+vS9u0OqyIllYYc85aPQMy
	mkJbLtXcfiCPs2o67IOAyd7sB4P35yX5j3Jcg66nxlhQgBPS9plHe+VybqympFbKSOtVagG6c8N
	YGaZ8H0wMFUM01Qu2CbMfMPJYBpyEzp3gyf4XZzQ3
X-Gm-Gg: ASbGncvMeR7CkV+5nWmj1keUmVBDRoldTMAWm3HC15Ghj7Jpu3aowNPiKSo1AFJxJNI
	mhcIh2UYJGXPGzKNtwKYh+Fk0cv5q2/7eF05osQGWsYRdBOWRrfGrZRsE/J5iJJrgW4LCWeyDlP
	JTFOUpYbxkVtSCwsEzTils6apZ+Xum4+M68g6qxvnwLX0atFUA74JFRcqc4YNSmbpl6diDVxuio
	ER/Z039y85tr7p+RNRPW4af8qZbBwEXu54h
X-Google-Smtp-Source: AGHT+IG03V+yzghRURs8YdytmvIJHF5yr+WXRATyvIvO3+HoYcZiNehpR1ls15DCd5VKlpOc3HjceWHMlfX18OINB3k=
X-Received: by 2002:a05:6402:5191:b0:611:ff6c:50de with SMTP id
 4fb4d7f45d1cf-61348ee0a07mr102263a12.4.1753179895656; Tue, 22 Jul 2025
 03:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717173655.10ecdce6@canb.auug.org.au>
In-Reply-To: <20250717173655.10ecdce6@canb.auug.org.au>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Jul 2025 12:24:18 +0200
X-Gm-Features: Ac12FXy3Wg8RO93ommd0k5kc23jSfedk795eUdOqzg9aTFqA0BK54fd2Bl0SLJo
Message-ID: <CAG48ez1ZpL0L0-8ZZe+RmL51YShmoHU90PnO2jq_nU=UEYbg-g@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:36=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
> After merging the vfs-brauner tree, today's linux-next build (htmldocs)
> produced these warnings:
>
> fs/eventpoll.c:2197: warning: Function parameter or struct member 'ep' no=
t described in 'ep_get_upwards_depth_proc'
> fs/eventpoll.c:2197: warning: Function parameter or struct member 'depth'=
 not described in 'ep_get_upwards_depth_proc'
>
> Introduced by commit
>
>   f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")

Thanks for the heads-up, I've sent
https://lore.kernel.org/all/20250721-epoll-sphinx-fix-v1-1-b695c92bf009@goo=
gle.com/
to address this.

