Return-Path: <linux-kernel+bounces-808594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D523B50206
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3E03BF97E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB332A815;
	Tue,  9 Sep 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="IbzZ4jat"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA324397A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433651; cv=none; b=ba2cZt4Z+I6vlr71eFMeHNkTh1dG+6QYkcKQ//an2LV4yZ2W97Lu9x+m7T9z65tmemprek2i15rGz1JCYW7X7Z2fBVe5UrR3iOB43N5gONtCsMWNlwiVFiJ1nWtqmZJzjErE9y4kMyo3vPxjd3xS38bNpL7Y9bpYVUfKk4LTlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433651; c=relaxed/simple;
	bh=wqY6JDSIcxawkWa1qORCwMabSdCTnaqJBzpi9+ot4R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVNFEoRgpV6nH+O8+wSVhzmeRChbbDrWDvhTDeHhUEaLk7PRSrIAdndjO85Rqj6EdU5e02lb50sTxK9DHBs3UEJao5mAc1m4McluZ6QU4qhot7OlXwbM6aiNYNXqy7F5ZIAftu3yS1FUE2dQRk5hkNQesxinhM65lzTHt0THi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=IbzZ4jat; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62221568039so5402807a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1757433648; x=1758038448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6dBQ67zpbOF0+TmT4tU24NROF1jqu4H25mUIYv9L1U=;
        b=IbzZ4jatVJsTOsK2zzKIRDuCtEUHSgliPIQhvPZLFteYD6KsWR1+R+4wC7PlP61a7T
         8liTgTSsIcXmbFvbfQPkCHmULup749cCH5kuiBBGg0iuxr5a8W6W3Gf1JEnK/Xdw+quo
         qMrBDrS5cHNbMTHgpw0JcX7UlzCaHggAI3hTxxg5s7mfAGUgLILRFdhOJrhIrvPxE1AZ
         JKm9jRV3g+weA5mb7CzSvFijSCqYvAXWf5026gAj1LhY7MZegqvlvT5TQlsp8Xdcu32e
         92YaN3YYeTm+j94yDiAxGfHOaGMk374lUVP2NIjVj/xFbf9nAqiAgGoNEtnA93b1fTPJ
         8/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433648; x=1758038448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6dBQ67zpbOF0+TmT4tU24NROF1jqu4H25mUIYv9L1U=;
        b=h9k6x0nvVufOLktRet2zkonNHI31utsX1Wv2AT0yNxKx0qybnsguC9Chx7jUZ+oxSs
         b4xIulge992NATZentsh/VoJY9bnhTugK+DPyrMU/DU/ayXczitW4YFWuEuTJIgPTfiw
         2529sov3prvJRansZvGbcf4pjUnkwxCDId+vtQ3UK/sknijXZjUUYgftWdjfbS30+gXU
         HjJCb4EO207CIjUIvADRyqUtNfBUbaNXt4hn2oFaeEkK3nThZLdI5jbt9qH7XsFDkrzH
         Mx4u3YvzGVTzJMbaoknSch+g0SZWie6b3baXHkyWMkEXTiVgelorzAqeUr9QQY8FxBvr
         PObw==
X-Forwarded-Encrypted: i=1; AJvYcCUaPJTn/k/TQaU4JvzezjxYPGXJdctTNc/u44sNB4hCDHYNN0JmXFFROXBw5Se+/MfM3AdT2xlT0O8dJPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9Ux1lhKcJfTuWtAqM6HUe/hOWvBxcXOmJRaliBmdScwB/gFA
	KSRg3qEVZJCYGQdonQYwjb17n+yIjFDlqVF8eplbnZZW6Hxdn/zJQtpQPAJHlf/JwRDsMuS5s0m
	YYJVhlXzl8VMjafSgit8h9HTn7oBMH0QwrS3Kw/C1Pw==
X-Gm-Gg: ASbGncsc64FIR6VJ5wENyDLJ9SuP5G3x+vWOacf9oon1ZIbVb8+z3jvdZP/iodDgOOq
	3pXFP7THi54+R+T1Bd2PzsiFqDdRX3IHV13LE2fcANuFrtX/j1w9lpP7xnpKT9jlEXBq6vDGKVW
	RhP8Xs/mxFOdcC2OaywyLD69C/UcCliGi+h41CIknoY1TLNUqJibYUCFVTiPdMVFoEPhmC/MA/2
	Y8XUAP8xGe0Q/MK
X-Google-Smtp-Source: AGHT+IEGhp/dQBeWCDHgeIQ5hgwB4IsLD3LLWFhZJ6j5zqWsSmd02imgRzV4N2JOE9Yr9y40F4QSN1J6RMfyUMzQQJg=
X-Received: by 2002:a05:6402:50d0:b0:62a:768c:220f with SMTP id
 4fb4d7f45d1cf-62a768c24e4mr4866745a12.11.1757433647609; Tue, 09 Sep 2025
 09:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822081941.989520-1-philipp.reisner@linbit.com>
 <20250908142457.GA341237@unreal> <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>
 <20250909153133.GA882933@ziepe.ca>
In-Reply-To: <20250909153133.GA882933@ziepe.ca>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 9 Sep 2025 18:00:36 +0200
X-Gm-Features: Ac12FXw3kv7hAy2mmPNYyG5bNfUvsjfQVpp6_6gub_6zOYFmE4QKhzg7VGQ76qc
Message-ID: <CADGDV=VZK4oXM=h4PzYOm_PJihMKdQUkrADOiw6EaC4kCssAcQ@mail.gmail.com>
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Sep 09, 2025 at 04:48:19PM +0200, Philipp Reisner wrote:
> > On Mon, Sep 8, 2025 at 4:25=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > > > Allow the comp_handler callback implementation to call ib_poll_cq()=
.
> > > > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver=
.
> > > > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadl=
ock.
> > >
> > > Can you please be more specific about the deadlock?
> > > Please write call stack to describe it.
> > >
> > Instead of a call stack, I write it from top to bottom:
> >
> > The line numbers in the .c files are valid for Linux-6.16:
> >
> > 1  rxe_cq_post()                      [rxe_cq.c:85]
> > 2   spin_lock_irqsave()               [rxe_cq.c:93]
> > 3   cq->ibcq.comp_handler()           [rxe_cq.c:116]
> > 4    some_comp_handler()
> > 5     ib_poll_cq()
> > 6      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
> > 7       rxe_poll_cq()                 [rxe_verbs.c:1165]
> > 8        spin_lock_irqsave()          [rxe_verbs.c:1172]
> >
> > In line 8 of this call graph, it deadlocks because the spinlock
> > was already acquired in line 2 of the call graph.
>
> Is this even legal in verbs? I'm not sure you can do pull cq from a
> interrupt driven comp handler.. Is something already doing this intree?
>

The file drivers/infiniband/sw/rdmavt/cq.c has this comment:
/*
* The completion handler will most likely rearm the notification
* and poll for all pending entries.  If a new completion entry
* is added while we are in this routine, queue_work()
* won't call us again until we return so we check triggered to
* see if we need to call the handler again.
*/

Also, Intel and Mellanox cards and drivers allow calling ib_poll_cq()
from the completion handler.

The problem exists only with the RXE driver.

