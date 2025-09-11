Return-Path: <linux-kernel+bounces-812494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C696B538E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709E37A8354
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D0435337F;
	Thu, 11 Sep 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C+OTkRt2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBE20ADD6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607260; cv=none; b=tbXPorXbWBCLWhrVifwoO6rxrIvzfjkf8LRbf9f0TKThAosPzre2JnWxlJCIEPC0CEfhGJKjxKFbt2kgqVR725TE06+SFvL/EwTw2pl/HtDb1cZkbB5WHFkSWnEE4jBAkeHox5oKQ6/qnYdSkIbqjyQy8C6PQZnIEw1ohBIbvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607260; c=relaxed/simple;
	bh=hjv904P+4rqOqflkNtuRiRuphKk9Xj6gBOvCQNNfr38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8nBJWqsnKPrgF5WRAIvk7mbSLbR+F8qe+yXLYgBxd+sGNd5F1Z3cubA5VKStKbAZKz4WmZmJsGQJfItXfe48Pvpvg/NrTvcGXp2tL9q6zL/mfEkQ0ThQeEUsvO+Dg2fLpzLwm4Ls99MO2y3VdkYipoY16iZ2w8cSqJ9ZW+ITy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C+OTkRt2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cda620e37so1499845ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757607257; x=1758212057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQhWayApKotZNesM7LFDQ//d+s5uEF6ep39Z8MhejHA=;
        b=C+OTkRt20shJjinYKUb1hBs3msVyGgCjRv9ptcgBwm0HG97D0+wNBcFtXTcJHkno1R
         UHQvwrqZs726MelKKkf2Wxl5Wm49zobSL9+6oIghzJikVACLh55YUli0Qnm3y1mHq6I2
         2l1swpoBp0TLXZ+dDRfUocPZejGJ61r3rCds1/dEAXZhWROJWFjqT04EC2RMEdc2Xmif
         TKgghMYZ8KgxHGmMtrguhxAW1twLAiV/qYndFEcrER3vYX03iR1ZjVB8a8n1VLyaGlYx
         lBP2KquVSUYIl8QjVf3Nw4HvjytO0UzPCNwxb1rowQRaQtDBGDIvGRX2pC3n7CZe6sFL
         c5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607257; x=1758212057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQhWayApKotZNesM7LFDQ//d+s5uEF6ep39Z8MhejHA=;
        b=THdDJAoETRQsfCuQmmw0kn8zIdUPP51EmUg5lGGWaJtX6ob7pV/EnjWsSvw3N184iA
         oqdCOOqq5mRnWXTBuQ8A3lTU9JX72GlYB5Q40nOzF6jWBtUVviBhDNFl0L4qG9X6ovHT
         rcAmFhFtiC3UaLk9LHi8+ReIEly3us3jiRA107tUlYQY+iZ776kxaQQQjKliBMb3JR4f
         odVvkxiAyW8C6YHDTZuvgkM9OFvRCSJawE2LsfHjwG/2X4W+sCZMT0qq9X7gXrHjFlWw
         jyEKUeI/G/QJ2nioIKmmR9fgLs/6ScXQOJb0iBN584KrLseZ+CltH9HhgnWbBjzfiRDR
         c2CA==
X-Forwarded-Encrypted: i=1; AJvYcCUlt+rKuvakwJxMxp2/eIw5S1Qb7S2ERt5WK0dieKaQjbBx2KvE1Sz2Ocv8/5aBGL/s8AGa22pbysxsztA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvJ2M2wQrg0BpoYTmOIsT0Iodzzsb+JIicRJd9zPGLZPuWyZa
	9fXg4p/8cvtt/RsGcJ7EbD4AX/FGTPBaAcU/mjvN1RArkvJ5gqzlonfZoqvrPGnf7v0giVoJPwE
	8XIFscLC6d5q9485LR4CD3PEP4cG6swD3UYPqFupzRw==
X-Gm-Gg: ASbGnctmo5jp5xQPPxJyClfZWNuUpuPDt0ThZZR0AYyewj/IhAToHCkPmLTnEnWFN4w
	dGP8SjhpZsK3Gv3kds8g2o5j7mIgKNHmkVfBl+1n099H32s0sGWNES9E5QTMN2WfMAIXTjYfRDe
	6E15VA3y+S5NXRxcCor7cslcvDQ5nqUGqaZgI35VBs2LfOpJBUAaZpcUkgf9NGFCWYbdQ/CzYqD
	obJXtYqnT0Znq8vGQ7YrJBP0z3PsyWgAqwMJI0=
X-Google-Smtp-Source: AGHT+IEntaUlyZJpjvhL3dhWQiy1zz9ST9DXO6LhnC0/iBeHnmxCwuuBSobY4k3WQjPr8z3/FD0he6xnmqQYRAROND8=
X-Received: by 2002:a17:902:c407:b0:24b:142a:c540 with SMTP id
 d9443c01a7336-25d24bafdb3mr114635ad.1.1757607257455; Thu, 11 Sep 2025
 09:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904170902.2624135-1-csander@purestorage.com>
 <175742490970.76494.10067269818248850302.b4-ty@kernel.dk> <fe312d71-c546-4250-a730-79c23a92e028@gmail.com>
In-Reply-To: <fe312d71-c546-4250-a730-79c23a92e028@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Sep 2025 09:14:06 -0700
X-Gm-Features: Ac12FXzAgdE35uhUmu6ZIn5ymvgle8od7WgZ2nhI1zOUzVmMns8HB3zGpbcJ8lE
Message-ID: <CADUfDZpH+6mx=rYb9uoL2z3-9DCmLLnF8vTBR8DX-PQBH+nqaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 9/9/25 14:35, Jens Axboe wrote:
> >
> > On Thu, 04 Sep 2025 11:08:57 -0600, Caleb Sander Mateos wrote:
> >> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
> >> an io_uring doesn't actually enable any additional optimizations (asid=
e
> >> from being a requirement for IORING_SETUP_DEFER_TASKRUN). This series
> >> leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only one task
> >> submits SQEs to skip taking the uring_lock mutex in the submission and
> >> task work paths.
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/5] io_uring: don't include filetable.h in io_uring.h
> >        commit: 5d4c52bfa8cdc1dc1ff701246e662be3f43a3fe1
> > [2/5] io_uring/rsrc: respect submitter_task in io_register_clone_buffer=
s()
> >        commit: 2f076a453f75de691a081c89bce31b530153d53b
> > [3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for IORING_SETUP_SQPOL=
L
> >        commit: 6f5a203998fcf43df1d43f60657d264d1918cdcd
> > [4/5] io_uring: factor out uring_lock helpers
> >        commit: 7940a4f3394a6af801af3f2bcd1d491a71a7631d
> > [5/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
> >        commit: 4cc292a0faf1f0755935aebc9b288ce578d0ced2
>
> FWIW, from a glance that should be quite broken, there is a bunch of
> bits protected from parallel use by the lock. I described this
> optimisation few years back around when first introduced SINGLE_ISSUER
> and the DEFER_TASKRUN locking model, but to this day think it's not
> worth it as it'll be a major pain for any future changes. It would've
> been more feasible if links wasn't a thing. Though, none of it is
> my problem anymore, and I'm not insisting.

If you have a link to this prior discussion, I'd appreciate it. I had
tried searching through the io-uring lore archives, but apparently I
don't know the magic keywords. If there are specific issues with this
locking model, I'd like to understand and address them. But opaque
references to known "bugs" are not helpful in improving these patches.

Thanks,
Caleb

