Return-Path: <linux-kernel+bounces-875862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D2C19FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119CE502956
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AD3346A9;
	Wed, 29 Oct 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMfBo65P"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53D3314D3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736868; cv=none; b=sZnfBcfw7CV+PzgxAeJll1C/jz7xTRuYZuR18cUeVyNcRcDFrd79ru+QvykFVzNhGiYtBIUkCREJ+DHeq0h4i74kyHmKQld2gaZZBh1yCI1NW6j46IhIbigcppDjvaFrHKi2/UWlwatSqiVhEVqlwKCvJQvjIA0cy/WR08uciyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736868; c=relaxed/simple;
	bh=VgCEpZKI4mDl/66FCty8eRurTJTD8qkjQPECINTr/Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKc6oN5smZLJPqPBfbAjH8gtFUX+8gDF0YN7Je0Rt9lEG0TokBzx84uqMlwWn7dnshCftWB1dnD5psCryF+FiWpc9/h3bwZmpfQvRC3hnOcbnJ8UkEoU5Yy4aPSooKgDiWPgOvrDgKJ11MBygQmX3bLyXly17oRNjPfDI30lebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMfBo65P; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso11457959a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736863; x=1762341663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ge5yVH+rgTk7yHRDi3yqgvONhI5/hNOx9YIFNv3msM=;
        b=CMfBo65P4dCMTs2IT82qUCvqL4l3y71NyeD1dXj/2t8macQgG3lk9yuCQQzvQv2CJw
         FktH6vAnSyoae2UBJOMGGjBH/WaKdFwNwTe1CzKdTDwGrxCxIwTJgnh6Pq80HR+8Gua7
         u+1H7LLj06J5pJkI2eiwAnCXZFY+gbpTY8q67CU33uj0Jv4Ir/uhiy4nHllPoe4aAHam
         0Qyi1cBv/FG2tkShPhs/thvNWhBFb6DTh+vvfu36A/xZ2ur0Y6ny6Y0oXps6Sf+31aIu
         MGJOR9jTTAdjNOkKSed9NYpF6sjXx6s6EkD9J0Zzc0TlBxHSLI3hoPG7Wk/YzO4jMola
         To8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736863; x=1762341663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ge5yVH+rgTk7yHRDi3yqgvONhI5/hNOx9YIFNv3msM=;
        b=KrfLvQa6YXLtwi3hwEBtt0nb/7s+vb7Bop1vI5zB+ws9j8Mr4fxvBxL/4uD02Def0m
         c5kPGexCZQdWNKs5bbhzCvum7E5xG4mNWziJLft5zZXYss+FF/INcFy1jCidFsevfMwO
         NG4rCo8qyRUcYlG6leMioPl9CgLAcQLhgjqxbVqXmyazo6tN/ZNC/swsbLe2G4atn3VY
         4irZo69542tQF/RPjzEN1qQWjSreqOVwSf8Czsc9Arde/05v6KnVTpLN4Gu+OE/6VPys
         chmNOHsrFo/FfiNHF13DH49pY8eiPwz1hnGmiLQdaENYe5wiQhx1I9tQoZVKmHW3+xTo
         +jyw==
X-Forwarded-Encrypted: i=1; AJvYcCUW9FC/oBi2T9f8fNHYMy+0SGc/i0rzlcZTvX4pSpHvCsUZIt7SzH++J5jhXCFwYsimvx6wpmakZF9qMBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybKAB3rGcUF7lX4iffC2P4aNK4mnQj4K7Yj92sbNhst0diBSuD
	y9zsGL6jiAv58nHleDSIzp1vIu/Txx/iL4FIAnFfnoKzgeL4mZVKLFA/vCh3Kz5jvvHFdUhNIpr
	EClozfdtHY/OP6vWchBD1SOgBINtFMsU=
X-Gm-Gg: ASbGncuUjGlkRBRxMBefZ+0OcbNa6v6PAlhr/YSW2SyHBFvEchbosk/r9qToHJY+y4E
	UWWnsH08/E6YGJimSmH7hTT9sWkV4B9+UAWnyLR82bCKkiRMPCX/Xxf2lAMRWymnVILE5+utOnK
	mCsEQCX32N/QmcWcukWxGG7eYv5FE3pjjVMQE0SzThMyiDPEVVAWNa8nnkgzKqL7yx9Ze88XcX+
	9tVh82JXYr+8dFHa/JnrBrO+5+qO+9OdHobXxhjm4373jixFvQHbaStefbBk4QTZWFlBtohsfc7
	sqH1Nl5NT6ZoMDk=
X-Google-Smtp-Source: AGHT+IGtzoXO/g3ZiHN2G1f7VZ5xjrcwHTs9yl4nbdJE0yJz6nLpSbbR0buPMaTahTQwYt80671Cx/7NYexnra+u6C8=
X-Received: by 2002:a05:6402:146c:b0:638:d4bb:6c80 with SMTP id
 4fb4d7f45d1cf-6404438173amr1626778a12.36.1761736863168; Wed, 29 Oct 2025
 04:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029045327.2035337-1-alistair.francis@wdc.com> <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
In-Reply-To: <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Oct 2025 21:20:36 +1000
X-Gm-Features: AWmQ_bkE7bJJHM3m1di6ZILHWBJlXLfT5wUJRaEfqSJFakwpllKcXC186lzlSPY
Message-ID: <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 6:10=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/29/25 05:53, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> > the sc_c variable to the dhchap queue context structure which is
> > appropriately set during negotiate and then used in the host response.
> >
> > This breaks secure concat connections with a Linux target as the target
> > code wasn't updated at the same time. This patch fixes this by adding a
> > new sc_c variable to the host hash calculations.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   drivers/nvme/host/auth.c               | 1 +
> >   drivers/nvme/target/auth.c             | 3 ++-
> >   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >   drivers/nvme/target/nvmet.h            | 1 +
> >   4 files changed, 5 insertions(+), 1 deletion(-)
> >
> I've already send a similar patch for this, which actually should
> already have been merged.
> Can you check if that works for you?

I checked master when I sent this and there was nothing applied. Is it
in a different tree?

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

