Return-Path: <linux-kernel+bounces-803811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BCEB465AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BD5AC0615
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494702F83CD;
	Fri,  5 Sep 2025 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdSx+pZx"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486A2F3C28
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108126; cv=none; b=rFUjHoBxBvTovQ0l6hvtX85CK/CbXqfTN1zTOyqZnCqraCJBMCSX+RACerIGhi5laKYiUTUed2BUz0vy3NGkGbaHn0VvZZLuS9CLdtOtki3gTvLcVbnc2Wldv9Knmd3cs9TJY+oaiMs5ABy+wcxu2Heim8stHSxjTmjynJvWT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108126; c=relaxed/simple;
	bh=hEZdWRv/z7iciKhuDKF1kowxhp5PcLo5vzJehKUARp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHSuINSlLSgiLBtq9Ginh9swq92EsNaPAnskF+zoViHdKaQu9I6h6yKwqGkkOFXYaUyUmXVsR3fitFR6n9CEeovEMLDUzKcdKho70xzXrpwdVLGl91Fz1i6A60UWAihYFhAzp+vpNls3ZrCRnxb2A4oeJrunVn96qXG/mHglT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdSx+pZx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ed0be20147so26050155ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757108124; x=1757712924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEZdWRv/z7iciKhuDKF1kowxhp5PcLo5vzJehKUARp4=;
        b=YdSx+pZxT/JuyaGkkYUW1/W2LHqjjGxdpUjZmARWqUWTV6Wv12vRvAX3Ldz73blzvk
         46c10sIUYHAhZ1zmayTBgqbesfdHLOgEhRuI/bazVQExyprmX+8hu5faPaN3+yJNTi8Z
         03hvZXJSTcJsmt8IGIGOudl0pONEd6vb0hv4KAyzAqCnLYaiv1ZBUOdKmDn1ojtyPCYO
         PobYeNbSnFQb73EtZv5WlqSe8qGP0kZE0eElJEJhaseOXj5I5d9IL9QirScEQOSZSqw3
         KxT3KoaMq0zFhxInny5qSkQ0cUAd/C0aokJtNNOnhFXt0wQkcDMKNZb/ujh4KdgDkiXz
         MrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108124; x=1757712924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEZdWRv/z7iciKhuDKF1kowxhp5PcLo5vzJehKUARp4=;
        b=qp0G3vYXErGCC5aq5ZhX9LCGJ+cbO0ouzFECBbQUfyT02/SNQnuhN0rocxidBd46l/
         qk2FgrYfsQHYIFK9geWX/bO9eO5kx8GrtkYrVUX6WV4sECIuyAG79BA5UWpiWhGEmuni
         oVlDfoPJHwvtJnZgfAvmVGeywDkGPMrsZkK6FYMEIRa7qjN3U3xmpJVLa4hC75kgsUgy
         RjNApVXjX23k4k6ca8upb0jcv6hT6bc4BnL5JZqVPn4+Ijf4Dd6PZzcNpmU1gwMxyKCD
         uuLgXzf0DRCj1eScpuqq4PIw6QsgKMcjYr++xqAq24TMWoCAfNwNwvBPnBCcpfiqt5yM
         FCCA==
X-Forwarded-Encrypted: i=1; AJvYcCWVc5pYLuvFFoYHgNPYaf+p9uSPLQzZ6dllvmmRgjeBHZsLJa7qVd5rCwIzy+3s8LzmCcQPF9vYUXEEGgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17+5H1xOZ7TFDXKjKmdnaIK0HE5h0KtssVuAWYSH0AlURXSTK
	ME3PQGfcp9CJYRK1b6TJdFd/Oj6ic2g/pMYTXUkHAjGG9tZ7eZ9mkZlTTnuGPQQ9A0qCpUiKtiv
	LSdOekO55p3jix2T8gqZV/o55zJ3URnY=
X-Gm-Gg: ASbGnctYIhrPkpKM4sg2K5GOtmFyI58yjICVO5iBGf8KlYZXaETddAYsB1Iz2ACzcyX
	0IeH3Cq5dE8UrfWKXXBcdNt0M5iHjwUUm1uGkSW3xS1fvaD15btRBAzljjs8avbMi/vrYd4Q6VI
	/Lsd9oVTKXhfQFH4S8YPoHQpyFtKNeDpthjfl1s+jz0ltskZKy0ZuDhUFAwkRGaPtSnjaye1xLe
	r6Y0sCUTosa7LHDwqQ=
X-Google-Smtp-Source: AGHT+IF8WVpB/g1JMlOdobaIjwrWwlXDO20YTmdhB82E33R4jbv8LdlESlw9MlPJrT6Dgk8ja2BuPEbvb3+xGqZlJy8=
X-Received: by 2002:a05:6e02:164e:b0:3fc:d8b1:7a96 with SMTP id
 e9e14a558f8ab-3fd8e98d13cmr6645145ab.8.1757108124237; Fri, 05 Sep 2025
 14:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829162212.208258-1-hannes@cmpxchg.org> <CAKEwX=M8ccnsOUc4_ZcFrg-8MSwDDF250=LCFKctvTrL5vJZ6g@mail.gmail.com>
 <4vpqew3bfs74kesmgd6kaafgm6nr6zbtt2t3hl2khkc6ds4zep@hllgy77hdumf>
In-Reply-To: <4vpqew3bfs74kesmgd6kaafgm6nr6zbtt2t3hl2khkc6ds4zep@hllgy77hdumf>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Sep 2025 14:35:12 -0700
X-Gm-Features: Ac12FXz1xIEuR5P_UzNwabExfIPEV8sQerJraRtHn2GEfVW4UeX0axaUNE1zkPY
Message-ID: <CAKEwX=P=2cm7X4VMGO==xqmcFfBj4tq_YU9DqCSbyAmCioDccg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:45=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Fri, Sep 05, 2025 at 10:52:18AM -0700, Nhat Pham wrote:
> > On Fri, Aug 29, 2025 at 9:22=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > zpool is an indirection layer for zswap to switch between multiple
> > > allocator backends at runtime. Since 6.15, zsmalloc is the only
> > > allocator left in-tree, so there is no point in keeping zpool around.
> > >
> >
> > Taking a step back, even if we do have needs for multiple allocators
> > for different setups, having it runtime-selectable makes no sense.
>
> Honestly I think we should take it a step further and make the
> compressor selection only at build/boot time and completely get rid of
> supporting having multiple pools. We'd create one pool at initilization
> and that would be it.
>
> I believe this will simplify things considerably, and I doubt changing
> the compressor at runtime has a valid use case beyond experimentation.

You are completely right.

And, even if there's a setup where we benefit from multiple
compressors, the current setup is definitely not it. How are we
realistically going to use these sysfs knobs? Change to one
compressor, then quickly change it back? How is this remotely useful?

Let's remove it all. In the future, if we want to do multiple
compression tiers, or per-cgroup compression algorithm, we will need a
completely different architecture anyway.

