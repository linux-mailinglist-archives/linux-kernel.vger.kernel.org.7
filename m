Return-Path: <linux-kernel+bounces-814593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D4B55636
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71D83B5B48
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECA335BBB;
	Fri, 12 Sep 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWmgwAtq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0D33439D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701828; cv=none; b=LIq9BlazJWwQtz6sflzQalSAGCdxVcGmblE2wB4UJa7Q3YWZ2+qQOxoQFzf1KW1R2ddAnNV/O5E3zxJKYW3ZoOaMUE3lVgWkaQy4Kfk3xKA3tbN2r2UYLugpaORp6pYZmSy/OyROObUk5R9HZlLIJwQoWKBzWpFgu3wW0/cH0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701828; c=relaxed/simple;
	bh=ZBK6INSF8abS5w/Gb94TA30BsU7/QHkDz9+MKFLMT/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKIgE6FsE5OmB5KpXHiyR0EGOQZ2PEVCKPc+ctkWPYEgjLkHD2IW1fPM6tg/fXzUzjA4bMvGxIpHk7k5HiPTf3mgZ0cPEbGx/2UQ46DcxGQKYgdTENc9RNouhOl7q/VqoW6xU6UaDw0KhPnKWFtTE0EmFh1WZrHYTWyh/FpSZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uWmgwAtq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5702b63d72bso1331e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757701825; x=1758306625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBK6INSF8abS5w/Gb94TA30BsU7/QHkDz9+MKFLMT/o=;
        b=uWmgwAtqIbhe4x8XzC7JUvswbAulUb8HiDCAkYjWOzBgEbTWiU3JwVMv9StJEG0Zi5
         kCRdZd1WbYuZYC1Pv5If93s/O7+Fv/02LWNc2ygLfmDYDovSfLzM/7PjdyC/lIn2g5i4
         Q+UKTidWv9GJXBfdk9N/PznLD1i/vEargBV4ioiBdQIACtTTtJpwFop9cjUe2qu9wYR6
         YsyKVasFBc5MdGI0HnP+yQWXFteC/4kdODT+ckKs7EU4VboKmFTxYTuH+/YY1Diawzxr
         +F2v1f/k3ANolwfPs96wRrt8vJ/1X7D82hSxjXwChMqEMQlpUYJWUmWyHjohjE0j8HuC
         nT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757701825; x=1758306625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBK6INSF8abS5w/Gb94TA30BsU7/QHkDz9+MKFLMT/o=;
        b=q9TaQke0G6oueW8YlzLcjgCUy4arlUJQUg0ncmq0gP/IFjAYAg9cClxxx7yInRaXbR
         OPgpZVOWLACRhVCfzkWLRqDeRUGCfeQ1uIOxbNZxLQto6Z6ZI95UzuZVsa+K13a5txT6
         8OwmPa6EUcZ3dcNgz7IlhpcUZSMwcyN/dRfEJUz+7seIDgIglgvkur5GTNyDyFbP1Vms
         Jib1YgJzSeRTORZRXI2KHrMZGW6fLH6Z8gHg2Ho85/cDb9ADt4yf4fBMwXTtS4lmhySH
         4cl4r3MSUIv/hG4pejUBl+4oFpxDKAg4F9IrkijbLzeugKFXn32xF00zw2Go/T3K7Im2
         xBUA==
X-Forwarded-Encrypted: i=1; AJvYcCVT8u/NGZ3NLaJ9ufgqjINIMAX+JwYj6DydG8dpVN4qSSno3dMINytJzr+RZWzWjf94uUSTAYI6C6EpBZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBMT1WojC4yn5KAntjdMapU+o0wScv6xJzdYuVQAuyCp7eBES
	1GMGfBv6IzfTLEsqR+AUsOGxMnQrgRPgv2g//o8o3vQOHyr7j6bnjyPbwnmptqkCgZkF15j/gBP
	Gyvqp4Ao22iyVYgwf5kIaswybYw1/R4D1YWoL8Dim
X-Gm-Gg: ASbGncvLGkIRrcTY0n/kmnnsNhbVOT4nlcyrPEb6/+H8fOXOyVIdPZaE149Az5an6hX
	y/6ykoIA9qHfOlMWC/rHeXQXjLhirBG1+EMvKVN0vMJQwoZ5pT78WRSwddqyFuyobOHnmshmQpA
	x3NqXXrglIGiHA9riIfD2/L8vi2RMxC612Re/f668EHdFBhR5b2rbG9IimyXJ5zpioUD0Pv8kcg
	er5jJgCVpGAa+MsV/iY29j64Lb4Cj5b+uN7NQsBTrfMsbMzO0G21io=
X-Google-Smtp-Source: AGHT+IEueAM5ZvPlNpUmbSAWOcXOSzuSYZGsc9dYT5EAGBdPP7lLvMMPzZwm/ASZ2J9qXzs9PYNF72nMbByIJuEiG+g=
X-Received: by 2002:a05:6512:3d16:b0:55f:6a35:dd47 with SMTP id
 2adb3069b0e04-571d0fcfcdfmr17413e87.4.1757701824277; Fri, 12 Sep 2025
 11:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912083930.16704-1-zhoufeng.zf@bytedance.com>
 <58ca289c-749f-4540-be15-7376d926d507@gmail.com> <20250912072232.5019e894@kernel.org>
In-Reply-To: <20250912072232.5019e894@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 12 Sep 2025 11:30:11 -0700
X-Gm-Features: Ac12FXzOnZNg9pH6OLjiPOEStlyr4LYxuJeCcrCbZRJNmgkdxO7NqDSHI7y1rOU
Message-ID: <CAHS8izOCc9-MydM6xDO8SsVs1bAZWuKcCWSJv_t0AsJznGnipA@mail.gmail.com>
Subject: Re: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is -1, get
 dma_dev is NULL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Feng zhou <zhoufeng.zf@bytedance.com>, axboe@kernel.dk, 
	dtatulea@nvidia.com, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 12 Sep 2025 13:40:06 +0100 Pavel Begunkov wrote:
> > On 9/12/25 09:39, Feng zhou wrote:
> > > From: Feng Zhou <zhoufeng.zf@bytedance.com>
> > >
> > > ifq->if_rxq has not been assigned, is -1, the correct value is
> > > in reg.if_rxq.
> >
> > Good catch. Note that the blamed patch was merged via the net tree
> > this time around to avoid conflicts, and the io_uring tree doesn't
> > have it yet. You can repost it adding netdev@vger.kernel.org and
> > the net maintainers to be merged via the net tree. Otherwise it'll
> > have to wait until 6.18-rc1 is out
>
> If only we had a maintainers entry that makes people automatically
> CC both lists, eh? :\

FWIW that was the intention behind this patch I sent:

https://lore.kernel.org/netdev/20250821025620.552728-1-almasrymina@google.c=
om/

I didn't get any feedback on it; I assumed people are not interested
(enough). Let me know if you want me to press the issue and send a
non-RFC version.

Although that one made sure that the changes are sent to net, only. I
guess I could add the io_uring list to the L entries.


--
Thanks,
Mina

