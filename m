Return-Path: <linux-kernel+bounces-880863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE5C26BED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9596A3AD4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C53385AB;
	Fri, 31 Oct 2025 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kaf4vG02"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87030B528
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938868; cv=none; b=Q0Hm5qumeLMTXx8zWVkQA1sgih2+Zs0/Fj5s+NTd20hc6a9AWJjoOmrncaTA23KcpfeKKVC3hcJrgZ0OaFxLPjZTWr2S71gUYK4A7YCz/uC1BINRg84P9798HL+jz7FXtzTiQbdx47Q82IP7GVb51eGfV8jeuqrXAugqImUP74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938868; c=relaxed/simple;
	bh=W5ERWeScacJrf/6VbJA5tzli6xAOwXLej82R5oNfZn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zyd8yKn09PGU/ZmRK2Fl8kuKPPARxNuYqc4IpXU/NuxosWzXUNXgZg56bZ/+KTuJUUIGzCkShz+XF6l30WRgqokwas75p7EWVtPfTsCQrZMaNcBje9BSM1jMLerh/lpCA+q4mxRGxwnFFcNFrHWC+DcfBurYL9/08KQHm3G9y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kaf4vG02; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290d4d421f6so26777795ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938866; x=1762543666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D//lpsjWyumK3n6VlbuWmPrat3C7InfHOVa4TBnUZU4=;
        b=Kaf4vG02AspVkEQufslGTPLsSeyG6UdwdnCitxJyr41M+eiYrExuNwTvB3W/qXOgxj
         PRdmpjfXsc/2AVmDjk3OFLXCKtZaZiGL1rEaT6msODg8PWt+3Kl3A8/SL6yaJF+5N3+L
         Fb//cQLJp+kr5GsSNqOO++EBbqMb+U2L0/RwOOV4nzgy/83OtgZmLGAuHBC35F63WoFg
         SJPVyTUUwsQSkrNSc8tVzbp7ZaN20KGupj04JWa0HNN6pnw8hOBlMHV4cPXp2FwPrHfo
         R4J1kzBhElE7ZD4mK/GFko+hjzCPfVMsHTtjjVDt5YpAt4yAPVeWylgmxSwsd/tGmx95
         UcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938866; x=1762543666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D//lpsjWyumK3n6VlbuWmPrat3C7InfHOVa4TBnUZU4=;
        b=sdTESBJtgwE1k4lb2b9AGcoDpmA8MVgRO4pnh+HR5ALKwFoShJxqkBWwQYM6m8b81E
         LiDsw6WdUIop3i7JNiB1nfflN73H9ySCySeX0MWLmh4Cm6L229tQp6BA0CJGBkLCqLhR
         +O7kjq9+AyFeww7pqRXpt3daw2VLPSZysn089CKqGYOScFjzuOUN6JdFXGEP6KeVMv9Z
         jatlTp8GS3NjAfshoSEdT2GfNwmXXlP5pKmnICqJYjTm6Ll1m51PIvO6ensz+2nIAJ/p
         bBRvQn3yg7xG4n1/cw2cZ5B0DhjZlw4hLtqL7a4A8c0Y0kFQIrbNM1yx+PEAmLzSyDru
         kApA==
X-Forwarded-Encrypted: i=1; AJvYcCW4vbo9tfMkJVZKsVWcoCkgjKVEKg3xPENQ1ElAMYab+sLQOta6Cw29vSm4hgLa63fyOD7tqAljceAtgE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzcqsiPOnlLa5XEmlZVwgkzpeU5T8u57N+gJezMfYTumrlsuh
	lXkC1pMaYT89/UODjS3EqsYG22ZePHW7Tj+Rng1knQhgE3yuLu9s8pi3eUZTWjh7gZjlWOSQdgJ
	mOY2uDrNitl56f3mqSYGrlZUYHukxA6Rbj25HLHoe
X-Gm-Gg: ASbGncuQwrGStTNpx66B5hmzUspV1ND4WzNA65LMkfXKQXsFxBW82T74sD5SSsM6Pbf
	hhLazr5FhA36FLIM+8/akdtHJNqhS/RiW2k6XjTcbcwmBzC0/L6Q6EA5t7iqCBzs4xZCk63Zebz
	JlwdP5uZFJ7f7wlZSLYoe95WA60iHgRH6rCRGS1hapDOzCHYLhGZJ1M+H4XKr16VAWA5RYpEITE
	D5jS/ZAlaap5bHBGWf2jddcpQRHKLBLwIlGuHywXxmIeoDYt6/L7A5OoULRz5WUyl1lLhpuYL83
	M+IA0Gg/KgOfpx53PE4862LOOAjGQPnEAAjoAyI=
X-Google-Smtp-Source: AGHT+IFZUbXp28y0C0+8P0RtCvqI8+9sTeRUh7l5pcsHt3+fz1d92FONyqve969QB3J7LLHn7Chttx+BCV31QLbv+Q0=
X-Received: by 2002:a17:903:228a:b0:295:557e:7467 with SMTP id
 d9443c01a7336-295557e7b0emr2653585ad.17.1761938866351; Fri, 31 Oct 2025
 12:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com> <20251028161506.3294376-3-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-3-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:27:34 -0700
X-Gm-Features: AWmQ_bn2YZsASxudsjnaQ_5Bjyi-hSzM7nTrE0vhRKJJp2EZCZFWgvZ56FkYWlo
Message-ID: <CAAVpQUBaJMNCOZtzEcUUT80XmZsj+w8CZDe1C08FudjXJFPT6A@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:15=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> For the following path not holding the sock lock,
>
>   sctp_diag_dump() -> sctp_for_each_endpoint() -> sctp_ep_dump()
>
> make sure not to exceed bounds in case the address list has grown
> between buffer allocation (time-of-check) and write (time-of-use).
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

