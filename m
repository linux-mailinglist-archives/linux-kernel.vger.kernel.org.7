Return-Path: <linux-kernel+bounces-803502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D43B46118
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB023BDB1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E723191C1;
	Fri,  5 Sep 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGdG9G6V"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680982741C3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094752; cv=none; b=ex9dSp9c/kanj1siKxpJFv2tE8e5qHRGEWK+8tHuWgATnwU5VFTI12Y9vLN5jopylv7iz8nJf6sothOVz31tU5ypmGmh8XZfDXuwgtgULlbGxUcokkvvFLUtecufKYJi6g5uiR7ffiHT8Gc3sIc3ndND5cOX1YLOBL4//gX1VJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094752; c=relaxed/simple;
	bh=rODzLRofJcFgARvay8orMOiUJ1s8/nrDQHaYoswCTWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJmzQzJ3zPpiR65gsg8MusJP4Ou9pynQaKnf8tr/NF5o8Eb/y4Qx34d7YAEoW+0o+TftguERdnwRxRBxzHuyDNsn8ztKoxzTRi0+KMDFqC8Z1E6Fy8i0PF47ByPyG13PExW0dHNR79WboxG8gW/aFzpKXiQgKyi2+TipZh4xAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGdG9G6V; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f23f3fc686so15127645ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094750; x=1757699550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rODzLRofJcFgARvay8orMOiUJ1s8/nrDQHaYoswCTWQ=;
        b=fGdG9G6V+6wR/cvkfngTYYV4vw7NGKs6AsodYKJObokU1ZYuPBAuMJK1EXqWhr7PmT
         ZQPp0Yemq3E/Bk7oa3bl20z3NBSNpGGFZcOyqVC2dxFNQa3RPE5ELgHW7T0UIuPiPyiV
         9LhMiKm0XROFm6igXKTL9OKdtNreFXIPq37nvf9yt+sVO0BrfV4m7lmce8c9Ij4T2O8q
         hzROsqh26Kl8v3I7wqwhsGbGtS69Vp4qgj+kVz1gCfvQHqysPtrUfdFH7+/mNaek3tu7
         7dVjQ9zOSbSA9UPnNPW13wvuKAfU2dZ5jD5QOCPQ7fk02SSewlXR88Htfwaf2yD5i30W
         YuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094750; x=1757699550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rODzLRofJcFgARvay8orMOiUJ1s8/nrDQHaYoswCTWQ=;
        b=fIVLxTgWthHPNgYTzJ+caEn/J3xOeVyiJCoRaLOv0sMbwdJMf5HZ/Td21TsL73I0AD
         /qmkSUa5zd7BPxmuO2DqxgDBZTJQzj71f+0Sd4RNcl0Lm8bO0WXCTAV+NlqyTgCSspkN
         iOczxP1kxcEg0HDiMZ44ESBpNeD+NacdxraeCWH5TlQrK2oi4ArfxNcuGObnkOp+62Ow
         EOtTzFFk5QVbGNoRua2aWAsVVvgvYoxkPC92oExntx62CI+zP1GgG07arHbe9jQoFZ9E
         wbGGZ+L1ZtqHBsT39Gae43w1++MvOz8bU9w6gJFnhu+HOb6ELJ9p0dPtBuaKqlOoBjyj
         3mUw==
X-Forwarded-Encrypted: i=1; AJvYcCV54pRr7Av1deuODUh2iIS6FmCliJot8RtjNWJU+KHugwaWFOHKvGMOTWQ07np6e0oPVEsKyJoqPZOf0oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqGs1AETMQDJmySfLOdV/mnnpjpUDpzMcHgTYqwiRCbfaV69Z
	2k7AHmy3nqkNs2IaLasFs5RhFhkuDirCKxvsDb1gJOUFJTq1ftGRBLjMF5+BlsZLiX1VMUSYvV3
	dJEVIx37bjJeINFbjCEIVVWy0Jh1pXkA=
X-Gm-Gg: ASbGncuVpXqAhHZ8mQJ1TRK65EaGY0paf1tQsLxHBHFS0zSS99baUt0VdTXo2Y3u6Mw
	nkUiNrhVeYUHE1Sq7I/SkfbitCrf7Ar5lqWEPKaPYxNVQTv6IuZknQctXqPMTLsdvNEy8RaH4rX
	nzQp5l1auZFnhjh5mugBBpqrT8jtnE2Dcoday6YcZyDZIm+PTtd8Xkx4sJsiAKcgTMFr/gvBd9G
	2kulMv+qOHxD/k=
X-Google-Smtp-Source: AGHT+IEDol+/lohZYi9Y/NFSKM0lfOTzS3L6PZJihsXBE1JGsvkJpojYVq9ljMlryr8XwDq86UdBhoVCt6bas5s2oqY=
X-Received: by 2002:a05:6e02:3a06:b0:3f0:b1ba:f72e with SMTP id
 e9e14a558f8ab-3f4021c42d0mr408790765ab.25.1757094750404; Fri, 05 Sep 2025
 10:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829162212.208258-1-hannes@cmpxchg.org>
In-Reply-To: <20250829162212.208258-1-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Sep 2025 10:52:18 -0700
X-Gm-Features: Ac12FXyArcg8HLTO3HVVGOFdyzJb6hPsDWKqbopHOKNws0wa2b1mtcYW9LCU0KM
Message-ID: <CAKEwX=M8ccnsOUc4_ZcFrg-8MSwDDF250=LCFKctvTrL5vJZ6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:22=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> zpool is an indirection layer for zswap to switch between multiple
> allocator backends at runtime. Since 6.15, zsmalloc is the only
> allocator left in-tree, so there is no point in keeping zpool around.
>

Taking a step back, even if we do have needs for multiple allocators
for different setups, having it runtime-selectable makes no sense.

If you just need one particular allocator per-set up, then it's better
select it at build/boot time. And we have ways to do it, without
adding 700+ LoCs boilerplate.

So:

Acked-by: Nhat Pham <nphamcs@gmail.com>

