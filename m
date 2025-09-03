Return-Path: <linux-kernel+bounces-797492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD39B41114
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0EB3A81BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40A10942;
	Wed,  3 Sep 2025 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRKqu7Bq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47C38D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857666; cv=none; b=LxAdmo64rbkm8No+lhDXUUrHX0U5U1ZaDQnG+f63SfAKURb1ovVcf70O3FdP30vretKVgV81zqprVGXhMK6BDdpHDloviAVhLw5xteCQ+JrLKBr6ee1mCLbEwLii21tQbq6kc1EiV5S6ySd899qmvfRfjLctVsukppwksvKn/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857666; c=relaxed/simple;
	bh=L6KzKFAj5KyI4xTHNVJ+Bav+TRut/F+RyFSESyEfLYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdKZXc3h7PYsSKo8onpQ9ueSmgnAPszJuUaGYVZ9xxpSHTAWg4VEHcR35bhuPTy3KoJfrznOpv+oSxqEHCtdbNGT4i4ZgZi7QBbuiDi/ZUM/PFukHF9hqsxSx0PawQnPVnKgLh0BK9+TTdzJmp8EpAhHZRaECpUjL/0lufmfceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRKqu7Bq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b040df389easo585102966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756857663; x=1757462463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6KzKFAj5KyI4xTHNVJ+Bav+TRut/F+RyFSESyEfLYI=;
        b=WRKqu7BqJd0JDOMTzm8b7fLFJvdy3ax8ugQaVbDbRxhYlOEWyHbdo5zmVeFsopsFMe
         pGyDuZjC/YOVhZOh2lcE3HPcq8NBtAO9p3A4Vmq004Ofgo9hExaXuwU6GC9UN934uBfg
         OmmxLq3QZTrCNlcCz0v6JdU/rOPirGI/RISxw6EEjd/Gbc5bKPq5XSV7QS2TvlMRaY5H
         s0RYdSCqgXkuYD2vnLefvTsvy08y1BDSO5dHAcSxKDjdW/4Cm6IG7JJVGoStngXGNrlQ
         YL1Cn3qNOrkw0jRPg8sUAkp7tJBh9bq/iSd6pypXbEmdNlA7IwWKv2hK3TSc27HSZGCk
         XfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857663; x=1757462463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6KzKFAj5KyI4xTHNVJ+Bav+TRut/F+RyFSESyEfLYI=;
        b=kr5+L8cTWXsOp6pI7waGq3Ftw2CbBk4l6pnmDTvbqVuHKOpV9SWyJEuSvp4leuMueY
         NhdR3hfFDIc0NCpAwC63dZ10amzpYlhTQQYZ8UQnnEQ0z1tqq7YlTXOSsr7ADvu0Yrd+
         VElDWUztQdgW5Gxggo6Oqcbi02ZWruM+B9noLqTrOde8Ao9PCab46+34aHckT66eMA+w
         +Rg2PSmPmrnKXOOdk2nngdhDg1r4u0BNToGYocIu5ar5anZVItI1GKbi9ytdMOYHa7YC
         rWvLwUvuIr/Gt4fUGhJk7ETK4gtpnX/TGNoSltyxE0rtR/FpLcgdQQ1B8Z/w570Z4dn4
         eB2A==
X-Forwarded-Encrypted: i=1; AJvYcCUxnhFR9a2+7BcNGbr8udUvMR1a6WjzA9IVY5bvIJS6MKHJhsZsZSIXtYEoCaco31jIDyAOUXfy9bPreM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWY+b4BYG+se315TUSBijXxlRaw21bHJ0DJYlatlmeKFN759lB
	xZmdJik/IdVjdijQuyYAQnN3nZY64ZK2GLpPa+EjJPjMb4LFOAFY3uHsHv2b3wBQv+n5/v60/ry
	4wU3gERzMSRZeEE3nI5eIcaWZRO7nno8=
X-Gm-Gg: ASbGncuKra+XxdGEQ8ZpQ2F8xRRJLKjV1U1xy1mMJbFyPLmr1MTqNwKGwCFxW5tMLTM
	yXAhAwWwbR4xiffXfJl2tW50jImAz+NkPnbcvPcf93CmE+SHzb+5/UZZwZs8KoCF8ZwbyaMK2mI
	CHldGReBO/uUAoXgJ0gVFNSQd4fDesxIN3rpzBSe8qKmxANNStjKtyBOReur15GXQdiTbKIWz6Y
	fyFr3EYERWdpkCgHElJV/+2vZzMjKeKBvZ05Q==
X-Google-Smtp-Source: AGHT+IH6AhRllJP7mdg0MDSz8PEOPVrNJ8CX2CFL4+9ZpOzCDEs6FEzJQPkbG4z93klh4esHrxBxLEF4fpZ8sfSm4/8=
X-Received: by 2002:a17:907:9444:b0:b04:53cc:4400 with SMTP id
 a640c23a62f3a-b0453cc4661mr420536966b.27.1756857662823; Tue, 02 Sep 2025
 17:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902035211.2953174-1-alistair.francis@wdc.com> <2841bd1b7910bd0e1b263b393152f2cb13dd3ae3.camel@gmail.com>
In-Reply-To: <2841bd1b7910bd0e1b263b393152f2cb13dd3ae3.camel@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Sep 2025 10:00:36 +1000
X-Gm-Features: Ac12FXzDj2HtYGSJ8MLBLRHiuUatNFdUj0151ogn2qRiA-uR8AUABjK4lxcy2Wo
Message-ID: <CAKmqyKNtx-eq-dSgcJqoXjajX--QyBvqwfgKyfTfxiTiF-cFBA@mail.gmail.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery connections
To: Martin George <martinus.gpy@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:35=E2=80=AFPM Martin George <martinus.gpy@gmail.co=
m> wrote:
>
> On Tue, 2025-09-02 at 13:52 +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The NVMe Base Specification 2.1 states that:
> >
> > """
> > A host requests an explicit persistent connection ... by specifying a
> > non-zero Keep Alive Timer value in the Connect command.
> > """
> >
> > As such if we are starting a persistent connection to a discovery
> > controller and the KATO is currently 0 we need to update KATO to a
> > non
> > zero value to avoid continuous timeouts on the target.
> >
> >
>
> When would this ever happen? Won't nvme-cli & nvme/host/fabrics.c in

It occurs if you perform a `nvme connect` to the discovery nqn of a
Linux target.

> the kernel ensure a PDC (persistent discovery controller) would always
> have the KATO either default set to NVMF_DEF_DISC_TMO (i.e. 30s) or any
> positive int value & not zero?

The kernel doesn't set a default for discovery controllers (hence this patc=
h).

nvme-cli will only set NVMF_DEF_DISC_TMO if the `--persistent`
connection option is supplied to `nvme discover`. But it doesn't set a
KATO for `nvme connect`, even though it's a persistent connection.

Note, that I think that is a bug in nvme-cli and it should be setting
a non zero KATO. I plan on patching that. At the same time if the
kernel knows it's a persistent discovery connection it should also be
setting a default KATO. The kernel is already using a default non-zero
KATO for non discovery nqns (see nvmf_parse_options()). This just
extends the default to apply to persistent discovery controllers.

>
> Do you have a test log for the above scenario where the KATO ends up
> being zero for a PDC?

I do, it's just a lot of keep-alive timeout prints on the target

Alistair

>
> -Martin

