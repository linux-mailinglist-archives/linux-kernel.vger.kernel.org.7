Return-Path: <linux-kernel+bounces-794997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAFFB3EBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D221891804
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159F2D594B;
	Mon,  1 Sep 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We/Ut0F/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051351E32A2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742160; cv=none; b=oaXtwIIVGEVJFY3CJSGF7po9I4PIT/mF6jWFW3VkGc++e8xs0D/h3ijjWwdFv3CsCrmwC26T64CHoUNPfegHWhcvUzTXz29uq3AI7/LOcEp4CjyFoKTvRlTEyNgaNqdKeawGM5YfJX2sS4EslxO98Gpa2d3Bx78WP84Jah2E/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742160; c=relaxed/simple;
	bh=iG3CyEcIA646L0ezNul0+k7QzOwrGcUCyJi0hIVXX7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVg5jQ26RsF8gsRA1E0lriXDQDYTGR8oRLYp3JmEFZ0obLU6WxjdxNi5NGZQfpE9/xqzfRoVnqIZUfMGeJqRCPG5sbH+bqFzXl2lhFJJ1yA4H1MD8zJZtNfEMQ6fwSckecHlVQ6eH/UV3dPlAKdI2Uut0IOB/Q80LB0UGcVVip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We/Ut0F/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cf429f4c2so7581123a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756742157; x=1757346957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MstfD5wYAbipEDd+wsbVGmRuZWNthTIOD73PD+Yzmw0=;
        b=We/Ut0F/+DD21IwFfrHy1SSo1SbmYMxIQBkYo+fMBPB3WcHp9Soh8Q5Ga6OfOTjF4t
         /Q2UuRC/EE+0dv9XDJadRdcISgWxnecumtdIxkREFSqtPgu0MEAus1kxypvtoJWY+8tp
         MH7bFF/YdCvu+QgcXVirTAgL1hNU4cYaHXT1T1CTnOac+DWGbSMPYzgLEt0Op8nzCKU8
         t4hEYNTVAIGAEoX3rWEogmIWLeoAQ/DZXbz5ENkTSaUvFjQ6auU65Kh1RWvaAfzHUDT6
         bz9fGSLFOeiGaU5BE0HRuyb4F6comXpLKoW9wbI9vZeKmYNaCoXEG9BYkYaq+g+r2yBe
         WIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756742157; x=1757346957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MstfD5wYAbipEDd+wsbVGmRuZWNthTIOD73PD+Yzmw0=;
        b=sMndXgSzTG/yRpRW+RSo2SIkx13YwYsv+yICzqg4Q8n6olW8pPUwiq4JE2NID6PxjY
         0YGfoEgdHaLO2FaDGzA1krdu1h3MRzpBklFV52/0ECXfmFzHug2WwJ8PnhIt7E7bQ5Vb
         Wlp9p8DWc0j1DJgAbU3tOV8LicDh9+bEI731xcX8pI10uAFznKvZll+Xfd5rh5cA0i0P
         MdrGzIbPMfOTidnkXxt95H085tcsbuSZfD0GFb57j00v+f//VoX9XYlu2V1m8K98ZbcH
         Jkx4IR8Po2BSYNbrQ2QUQXn2Gz60W7g6ErC+/M3TYwH2d+8ufX+FfNbQloa9iyE2RkNf
         nktA==
X-Forwarded-Encrypted: i=1; AJvYcCVjPMDPi+jqH//+2yMEMhJw6fQ5QPq/qmc3YdNBjYTpmXg1MIm6ya7z2tlt4Tyc3ZGjZkv9DRqfxAmJrns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Y+bZn6Fk7vzlgHDCw9FX9SdKVSq9pigk/GtGRUBoA+b/t6Ki
	toIdnYL1yRVGe+NLKylyPpAYvr/pqRzm86X0eyEAPOIixuL/tKbZ8oSRL9QN/SuYCWt4wFdCHci
	RcCZxj2C+RpB6zo1NS0JIbyizwfDqiwM=
X-Gm-Gg: ASbGncuU48JDMh/oNq0tqL0546qtwlIsH6OKi19FirfIDP5OYwGEiKxIM/DAMrcF4+C
	43fJ5k+lFBM7i/VJ9b7fW1GRQ5mxMouv8Fh62DABn78hTyq/RadCs35RlWZWXmsa1JIM5uI0xS6
	gBA1z1kRG92Ne7pEos3pyiZSCvh6lo6S83UDod+0EF5Dghp04CEhnBZ0VJMFCfwuCWWh+feu4Mo
	73nElWLWlWHCV63WA==
X-Google-Smtp-Source: AGHT+IHunYI/Qc9lPZyBzZCIiHKLCs1ZR1rpiQA9DO6nBXYK1vmW412R+Gi7EJkijOomY7BvH0Vj7F88DYS7BC/2pMk=
X-Received: by 2002:a05:6402:90a:b0:61c:e9b5:74af with SMTP id
 4fb4d7f45d1cf-61d270e811amr7402142a12.36.1756742157148; Mon, 01 Sep 2025
 08:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner> <20250819142557.GA11345@redhat.com>
 <20250901153054.GA5587@redhat.com> <CAGudoHEoK9f=M6-iOL5yHqK=o4wiJW_78t88BEwsAksAW5HNqQ@mail.gmail.com>
In-Reply-To: <CAGudoHEoK9f=M6-iOL5yHqK=o4wiJW_78t88BEwsAksAW5HNqQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 1 Sep 2025 17:55:44 +0200
X-Gm-Features: Ac12FXyNPJz1dUjEcSc9c4t4AfnfOnNlH-rsyyfBpK1elpef2R-w9dOQQvpgvGs
Message-ID: <CAGudoHHY7dMmxAc7x0avSxpNz-MfitQa-Shv2MSisLm-r4GH-A@mail.gmail.com>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Xiang Gao <gxxa03070307@gmail.com>, joel.granados@kernel.org, 
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org, 
	gaoxiang17 <gaoxiang17@xiaomi.com>, Liam.Howlett@oracle.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:44=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Mon, Sep 1, 2025 at 5:32=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> >
> > ping...
> >
> > We need either
> >
> >   [1/1] pid: Add a judgment for ns null in pid_nr_ns
> >   https://git.kernel.org/vfs/vfs/c/006568ab4c5c
> >
> > or
> >
> >   [1/4] pid: make __task_pid_nr_ns(ns =3D> NULL) safe for zombie caller=
s
> >   https://git.kernel.org/vfs/vfs/c/abdfd4948e45
> >
> > in any case imo the changelog should explain why do we care
> > to check ns !=3D NUll, "Sometimes null is returned for task_active_pid_=
ns"
> > doesn't look like a good explanation...
> >
>
> Since I caught this a stray patchset I'll bite: given the totally
> arbitrary task struct in an irq handler, why even allow querying it
> from that level? The task is literally random, and even possibly dead
> as in this crash report.
>
> To my reading the code which runs into woes here is private to a
> vendor. Maybe I missed something, but I don't see a justification for
> querying the task in an irq handler to begin with (and per above I
> don't understand what the point is).
>
> That is to say, if this was up to me, I would at best assert we are in
> the process context and that ns is not NULL. As a result I would very
> much *ban* the call as reported here, unless there is a good reason to
> make it work (what is it?).
>
> That's my side rant, feel free to ignore. :->
>

Maybe even go a little further and assert that the task at hand is
fully constructed and not exiting yet.

The worry here is that normally you would expect the task to be all
there (so to speak).

For example imagine the task is mid-teardown, with some pointers
already freed and whatnot and interrupt comes in. Code might show up
which will deref parts of task_struct which are no longer legally
accessible, but this only blows up if you are unlucky enough while
racing. In practice these accesses might even never trip over anything
despite being illegal (unless someone nullifies a pointer or
something), hiding the problem.

All in all, this is a can of worms and from my cursory reading no
justification for doing allowing it was provided.
--=20
Mateusz Guzik <mjguzik gmail.com>

