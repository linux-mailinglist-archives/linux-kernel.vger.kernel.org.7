Return-Path: <linux-kernel+bounces-831766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40BB9D83C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002783264BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01152E6CDB;
	Thu, 25 Sep 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="jwi24nN7"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB810287258
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780174; cv=none; b=I0ekRJsaIB11/6pBfZeKfFQTAev0iSFb5XrzW/gx3QCGrkpwbymXLy0VHoVUqneTCqJ9/jJK/lReojRH3/93CqIvU7p0rdSsLpYSAJzcReLKqA0ORsjiZKMEjdCsVXNulVx5bfeRLL4azqZtg9wodIpOO/UdYTTu0LcXo4qlCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780174; c=relaxed/simple;
	bh=DUla5PJziyCFNOF5ZSAr69aWrr1mHBZqCAxD1G43xqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5PMt4uZZqBL5TjglXnG2j+u4QyJ7zx+Ad+KeJQ5uP+wH+ptnX2CbKmaEEBR2TbHAAsmE2CqzvTw0mHfLnjB8WIgl++nnASbQ/Oa2ZZP6NhlmFBqgwX+x+dhc1J/rRdfhzQD2h0ggHIgef5vhPg0Uqli9RgRCKWQM7idz8HJfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=jwi24nN7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso993915a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1758780170; x=1759384970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUla5PJziyCFNOF5ZSAr69aWrr1mHBZqCAxD1G43xqQ=;
        b=jwi24nN7AQY6ScwC+IqSg/3sjatoQEhWaP4Lg/yXg/5RYSsqTu9Ln7/1INqB2e/qMk
         slCB4ILbZPf66tAdhzF+pYzwCCaAZscUl2vjSUA+s1JXINOa2sCy+jvHJVIqjT1kMbgl
         3tz6k1Buhr4o0UulVfkjKJm5/e4vmwup19ed/Yj/5JTkaHqedp7+e2tiVNJHDneJ18Qb
         K+66CBUIxb7ArPYw4k2GkYrJQVjOcCJ8UEsVVFToRnRd4kEMl4OB6lalIhKSXQ0wr/Oq
         qodzXIED1kpSK1n/VKDBGoBHJOFTpSz7UEpLbzXizSGGqXo7EaObhxDWxZ1O4jl+OuFL
         e+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780170; x=1759384970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUla5PJziyCFNOF5ZSAr69aWrr1mHBZqCAxD1G43xqQ=;
        b=pM1AxXv/QOsxoo0WUXc/530tlN0J5MO+ipMn4HUOKsetNoFtZ0otSp7rX9EX/hdMHc
         zAKr+9A8Z4dAEpvrUNe2hdZtJaLbIndTkbtbWOuiFUq379Y2Z9HHQiQunq+V8T6LamUQ
         0Qk7xqeUN3VEenppKMuBc/HCrtVQhZ/7l9ZbYGA5G5CObPckR3bUvRxa2ngfqXObr7mW
         3UEFnRxOwFWA56qBcBEPzGaNGWSP8g4kwbJBxXGSHt2QH1tlt1bG60y2ner7Tp3j6TYR
         5wXyiKuQ500OrQ1kp/2oudhDGGlszH+1hcDT1RMvfqXyiKXcnOiDSq9oYRFJWNjtc3lT
         nbZw==
X-Forwarded-Encrypted: i=1; AJvYcCXJA33XTrkFWglETn8iSDPUoiuzR/6AVTpVjg4hzm6wbmpQ/oySmzGdqHirirD82o1Icn6fMEdtYuftO3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxB29A3QmdHINV5fbc9pdL8SJdf4xp+lbyEcCVTk+jbpoK0jeH
	VUYa5IWED+rVL0chSrNpQJl81ThcMIqdm9ZWfUUKXmmuL1Sh9jxUPyTELYzg9tbT6QKr3c6NvL9
	7gLRzyCy8xzrLjbd2CLbLvjurcCCIhsco9ootsx6ibQ==
X-Gm-Gg: ASbGnct7rgrGCazSGPbAqwqIgRgTv1MWHUnP03RTx3uBSzKqGjHQ1VqiWWlrhqb8kdt
	HPqqf7EauIrM+TQ6/rYM2x1ZIhylK/sDEwEgnhsgDhBzEE4uYYReeGz25JrJk3A3DSBHH7SFHQn
	6kqT6yVgIANfchotaW6+kz9L2hXPDtcfRlvOt7ZcodIC+H4fc4/RnRCcIrI7CKUriWypehJUcjA
	qha1w==
X-Google-Smtp-Source: AGHT+IHuLUhpfZoeQ17XO1nU7j5y2qkgCPBRp5vKsEW0xkb9bgwyW8Z3xNh2ER4vvyV0SOz5/UW/SBD9YiHnzIXwPDM=
X-Received: by 2002:a05:6402:180d:b0:62f:9cfb:7d34 with SMTP id
 4fb4d7f45d1cf-6349fa97d25mr1323894a12.38.1758780170150; Wed, 24 Sep 2025
 23:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822081941.989520-1-philipp.reisner@linbit.com> <20250924132135.GA2653699@nvidia.com>
In-Reply-To: <20250924132135.GA2653699@nvidia.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 25 Sep 2025 08:02:38 +0200
X-Gm-Features: AS18NWCDO0QwVnXdw28DFlwnSnP-ZYUNKnvXKO4kJg0nbIiw6z-QKTuUt9keuVY
Message-ID: <CADGDV=XkfuNhATA4GkQm1VBVaG+JkFYmXojaVSnGo=rco7bUyQ@mail.gmail.com>
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Wed, Sep 24, 2025 at 3:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > Allow the comp_handler callback implementation to call ib_poll_cq().
> > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> >
> > The Mellanox and Intel drivers allow a comp_handler callback
> > implementation to call ib_poll_cq().
> >
> > Avoid the deadlock by calling the comp_handler callback without
> > holding cq->cq_lock.
>
> I spent some time looking at this, and I think the basic statement
> above is right. The comp_handler should be able to call poll_cq/etc
>
> rxe holding a lock it used to push a CQE is not correct.
>
> However! The comp_handler is also supposed to be single threaded by
> the driver, I don't think ULPs are prepared to handle concurrent calls
> to comp_handler.
>
> Other HW drivers run their comp_handlers from an EQ which is both
> single threaded and does not exclude poll_cq/etc.
>
> So while removing the cq lock here is correct from the perspective of
> allowing poll_cq, I could not find any locking in rxe that made
> do_complete() be single threaded.
>
> Please send a v2, either explain how the do_complete is single
> threaded in a comment above the comp_handler call, or make it be
> single threaded.
>

Thanks for following up. Sure, I will send a new version of it, it will
be v3, as this is already the discussion on v2.

Best regards,
 Philipp

