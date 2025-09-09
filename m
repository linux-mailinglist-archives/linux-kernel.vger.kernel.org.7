Return-Path: <linux-kernel+bounces-808459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B7B4FFFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AFA7ACF2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397835206D;
	Tue,  9 Sep 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="oXXsW2cB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA0352066
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429315; cv=none; b=lCGZke2Qsttbd1+5IjxzYw94hvTYg7dbXoC1Bo3gvrtCl8YwcYZggIBl79OhEa7zJG7v3l4AHrrcF4QgEObHzEhpAUQektKwmmxBb+VJfArg0xmJ45jMd/1dfljdWG9Owjh+YoYoz4N1iJqBIHMkwUMqNnqRuZzfZ5anRhn+Fbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429315; c=relaxed/simple;
	bh=IrCEEvQ6quZd6vGY+hKaSFP8/aFjFmPuYsUXXSdfZ/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbEKUHXBLInUuT98o6CdwV2A3gSvIFgFIkZZwVPgnO1FSqRjOac1rsSJSBYclT/pTzs9za365iwM8dbSWbIfW14Fr5ipplaPgrYftzCjtN/LAQbP/oTte8vCVbVvED42VbR9hIaRM7vav+RgHE3tY6i6nVjoCqMjj0aOJgTD0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=oXXsW2cB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6228de28242so5632013a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1757429311; x=1758034111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riVtaRT7j8OUAE/oqMgy7zD7jURxy+XGa9bDP6fI0Tg=;
        b=oXXsW2cBgOjJTgeBUA3sZDKJZdHC5+LLg5GiNLXVuK60w8LctFTS0JEcAQyYYRhIsh
         3iPX1bNEy7b0e3rWy5l9rnNwJmgVvAY7U1w8u3KopqHwI6vvkdj0uJOp1bocUkfpW1uI
         rrAnNjr6Tdjs9o3cODByIEmxld5SjSJ7XsJnk6I4TM4ZCVcgjksm/q0vuEnZFS3jjx+A
         r/KWnK57JWBnWtaU8iD7tWbNPJzq6N1ZGiBBpfXJCSH2JfnxEvDjvziuTJBsX//kQ4wm
         hNtvZReEKIeniM0exXWArbExqRRR3hNUiqL+quA/aP4psOu0Uo/pE1zfLQYW6Cx7eXnf
         fYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429311; x=1758034111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riVtaRT7j8OUAE/oqMgy7zD7jURxy+XGa9bDP6fI0Tg=;
        b=le3nvr2ZSFaHnR4CL4rbt0d5BFGG7dI2w5TAD4E88jrTIrTiFv1XIGh0ZJVjtjqIEi
         BNUT8NTSUj6O4RkcdmvuPKkJS1Xggs5KwSNF4leVxrYKjQb7VkUUwnydpweBQhtCxPky
         hS6ZHeiBSv91dbdChVDhaakoUJt4k81SGXeiy8YloyKJ3og6LLuacPkFZkPmFqaTDHYl
         NleBIt6O/qVqO8oliVinx560rRDfiiAUHNYLPrrbbgpmEKR0tKzHt5g6fhbuKmCgYutw
         aRM5YBDhrtQQ/Mkybq9Y4GooZeRg9agOK7XUCrPEUIPBQdb9Q8qJroZrjtvxt0Xql5oj
         6ILw==
X-Forwarded-Encrypted: i=1; AJvYcCV8xeGSSSTxuIwDXz+Qi0ILQfbeB1Bu3Hlz3G5D5iquG2N5cDQ1wq1Bzfe6wLI8YVWsXrjaEDzyIwD/p6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfay5RMRqth3UQLv7Yq368GCNmnpH38+zmLkarxudz0t22aTw
	0K+qjEmWomCj+HX4j/7G4mz68LlyuBYQ9n5RWBiapZHfeZsBnzqL8eBw5hKEFenTVervdInfvS0
	G61Y9I1zNJRuRMTSbKTmwQ+50oFRPolnOvUMbXtb7sQ==
X-Gm-Gg: ASbGncvOBgCvNOlCgQD71WMHXigcVMxngp7cLGNolZhsiAAFyk2Z1PzSaQuUJTVlOC+
	UNsLlwIyJ/vvnWVOFUBCqzuL2lCJd3LmcG9cByiZ/xCbCU2oVjbfdwSqu6lbO53t2l1Ngz1OaVE
	rtrVcMw6aFvgJMxYbEtri5/Mpv5RBEh/tO6iEOmVo86FeWNj5fcIE07ftWDJgAJH0FV8Q9yuPXz
	jVss5B9pkGZ0/ut
X-Google-Smtp-Source: AGHT+IHmy4DiiZdCV07ewiDp5l0AAhtM6iSoXVlHB4cqIHw0PJz6J4GlBBIkNRNqG6GZflgKWGQY+CG/OTYDOfBqZr4=
X-Received: by 2002:a05:6402:688:b0:626:15e3:fa with SMTP id
 4fb4d7f45d1cf-62615e3029dmr7305027a12.13.1757429310762; Tue, 09 Sep 2025
 07:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822081941.989520-1-philipp.reisner@linbit.com> <20250908142457.GA341237@unreal>
In-Reply-To: <20250908142457.GA341237@unreal>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 9 Sep 2025 16:48:19 +0200
X-Gm-Features: Ac12FXwmbry1Lsm2nYhF0TgAF0dI5C-wuaikLjA0cYwT_2X5O2PH5N0rOEeO8dQ
Message-ID: <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:25=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > Allow the comp_handler callback implementation to call ib_poll_cq().
> > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
>
> Can you please be more specific about the deadlock?
> Please write call stack to describe it.
>
Instead of a call stack, I write it from top to bottom:

The line numbers in the .c files are valid for Linux-6.16:

1  rxe_cq_post()                      [rxe_cq.c:85]
2   spin_lock_irqsave()               [rxe_cq.c:93]
3   cq->ibcq.comp_handler()           [rxe_cq.c:116]
4    some_comp_handler()
5     ib_poll_cq()
6      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
7       rxe_poll_cq()                 [rxe_verbs.c:1165]
8        spin_lock_irqsave()          [rxe_verbs.c:1172]

In line 8 of this call graph, it deadlocks because the spinlock
was already acquired in line 2 of the call graph.

This patch changes that call graph to:
(Line numbers now valid with the patch in discussion applied)

1  rxe_cq_post()                      [rxe_cq.c:85]
2   spin_lock_irqsave()               [rxe_cq.c:93]
3   spin_unlock_irqrestore()          [rxe_cq.c:120]
4   cq->ibcq.comp_handler()           [rxe_cq.c:123]
5    some_comp_handler()
6     ib_poll_cq()
7      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
8       rxe_poll_cq()                 [rxe_verbs.c:1165]
9        spin_lock_irqsave()          [rxe_verbs.c:1172]

With the patch, there is no deadlock in line 9 of the call graph,
as the spinlock was released in line 3.

I hope that helps.

[...]

