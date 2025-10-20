Return-Path: <linux-kernel+bounces-861042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20765BF19F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37458423E93
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55661320CD8;
	Mon, 20 Oct 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hINppOgg"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721731A049
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968082; cv=none; b=nvtxHOfcNOSp0DKzBIXUDmAIpjVZkYrpNqPyBVNfWoUPfSbXk9aSifA5Fcr6gM9FQeya55tyZ3eQz44FpTYSpQ/oQvIJ6q1iPjo1ho4qN5pDUO2ceiVfk8IPjJXzOC/nkoHxU0e8u8b8wbc4XAtd4kdrvGIR9ZPVn9xXg5AtB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968082; c=relaxed/simple;
	bh=P+aFf9oth4LiKv2hExgb8uC+PnKCw7ZhDOkJopU58r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4ZJYFdPAYwkcZaphPAnbJtIBZTDlm8L16BxptIkg3tEBvIkvkRol6U+AS951Cpfn6usMq3P4+LKNiyuf6JIqzOkSQFjhSJe9/2M0IR0JUDUMJc19gknHR39ykXP2ybTxipSpUTsq8d+mSzjcsGU0fDWmCQwxq76fwMl/QyMouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hINppOgg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so3053932a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760968079; x=1761572879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owfB6MZ/RaTOdbtTEnPA/HVBHwSA4OIJrzJG673UzUg=;
        b=hINppOggA8fVRnKjRaE9phEEFuBRXXqg4dTzeh0HMwjTj61TSvG81KShztWwA+ZdeI
         D8NrRTH1VVs56xsGnoMnP3JlLqLnU2I4N/qmqvmmUyBpVVI7oTeiEB3B370fT85c0lGM
         frJu1C7Fovn9RtXaoxuAHJ9E/JvW2fvG5oJlEuA6dd2IA50HE2/0cFlqPZAo5TIGzulm
         ZwNIIDXgqYmqIN5Lrceo4jMazGfDjBD9CK2dSgnpMp96x56Xy1v6RyQf85L8vEgvJrun
         J9g42WRBwHv22BAxjCSenW2/Y9Zf+ac9wSoRkIm18dFuwk8xtMzS7iKErGlqu0D8Bwin
         Kh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968079; x=1761572879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owfB6MZ/RaTOdbtTEnPA/HVBHwSA4OIJrzJG673UzUg=;
        b=PJdoWahFc9y22vr/W+RQ7HBgQW6+JaR0ZzPj6jOAZwjRuS7Z70ZlFDH4gxVttviTed
         x+zhxIlofMEbj+eiZf8gkMY2a+7pHNok4W4JLUqKJU24QiacnL1PbzclzuY1/0c7hkTv
         zDBmwcGdpEtG5I2SVe3SaFmjH8CwssPawYkaLHAH4Eww6XUR1Cf6ZxYSWzW32Kk7MNtq
         SpEAmy/eylXGT292ENh8O0e8/XJ6Zj/kEsJrhgx+/aY3N34+fMcHE8Bi1DGN9PTxq6sN
         JCsvsy74AH/GRNVWmKsnVHTJijiX9E0nVfc3aX5JHAc1I2mLXl/fk8sN3bi6u9Rwy3tO
         J+QA==
X-Forwarded-Encrypted: i=1; AJvYcCUkq0oT/rXRRZ8uPKe9ML5Z2majeUGDHoHiQzjI1e+Zz4httcRi4IwELc/1x3ldjtOf/1/boR40riQe1lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7g3iq5N5+x4mMekPL5o54eQqybeJVLEVmJMycCjFS76QypW3
	vH0ET7YUik8YrLjLXFmWI3Q2oYqTg/qx1gLegTUJTI3XIwPvOYeCsudjEnOdmSIBcHT9Om03Qfg
	Jrce9PP2Nrv9VHg1DLuZZy+AdwyMUfD1zKR+KOm/4Bg==
X-Gm-Gg: ASbGnctPDkubdzmpBTtsFcqzCaekX5gBbR+A39vvpJuxnJ2d2vv3DyE9Px2GtYV5LQU
	aoAevcRoN31DK1Nq03de1SlbxXDkFSWMt1FEnSKjdEEskVCMkN3qfewezkUcLQmELG97C/vqlYM
	qWMr6sg6v2K45sAY0L/15TnbmNUFBe9KGfbGmxnrTTr9hkEL9J7aGrVxsXkw+6rYxTBYepO3pZt
	hv+jUGYjxuwKmoZRNIwlFRPhSQVoPMGP0QrLxM+0DhDT1b7taUcrq0vUMUGDXwH7ZpjBWelDzgq
	fzg=
X-Google-Smtp-Source: AGHT+IFcr4yYt5BkZRvwg4aS3vOuI/dUA++JB1Pa5n/q7YHF3s544Z0m9fDyyoCLymYJhHWCIs054zb/31d4lLoohCo=
X-Received: by 2002:a05:6402:2113:b0:637:ee5f:d89e with SMTP id
 4fb4d7f45d1cf-63c1f6b4c29mr12824950a12.20.1760968078712; Mon, 20 Oct 2025
 06:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <aPXz-IPDRniMHN0u@kernel.org> <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>
In-Reply-To: <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 09:47:22 -0400
X-Gm-Features: AS18NWAHh0mRsVXmirlOiWUS1kBKZtHjFUd9z0xLGz6uGryTcRWZa3G7aWSpR-I
Message-ID: <CA+CK2bDaN5quQd+3UOXguxRfdq2OMLSVqnPU-cM-=YCCRw8=Tw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] liveupdate: Rework KHO for in-kernel users & Fix
 memory corruption
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:46=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Mon, Oct 20, 2025 at 4:34=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
> >
> > On Sat, Oct 18, 2025 at 01:17:46PM -0400, Pasha Tatashin wrote:
> > > This series addresses comments and combines into one the two
> > > series [1] and [2], and adds review-bys.
> > >
> > > This series refactors the KHO framework to better support in-kernel
> > > users like the upcoming LUO. The current design, which relies on a
> > > notifier chain and debugfs for control, is too restrictive for direct
> > > programmatic use.
> > >
> > > The core of this rework is the removal of the notifier chain in favor=
 of
> > > a direct registration API. This decouples clients from the shutdown-t=
ime
> > > finalization sequence, allowing them to manage their preserved state
> > > more flexibly and at any time.
> > >
> > > Also, this series fixes a memory corruption bug in KHO that occurs wh=
en
> > > KFENCE is enabled.
> > >
> > > The root cause is that KHO metadata, allocated via kzalloc(), can be
> > > randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> > > early memblock allocator is restricted to a "scratch area". This forc=
es
> > > the KFENCE pool to be allocated within this scratch area, creating a
> > > conflict. If KHO metadata is subsequently placed in this pool, it get=
s
> > > corrupted during the next kexec operation.
> > >
> > > [1] https://lore.kernel.org/all/20251007033100.836886-1-pasha.tatashi=
n@soleen.com
> > > [2] https://lore.kernel.org/all/20251015053121.3978358-1-pasha.tatash=
in@soleen.com
> > >
> > > Mike Rapoport (Microsoft) (1):
> > >   kho: drop notifiers
> > >
> > > Pasha Tatashin (9):
> > >   kho: allow to drive kho from within kernel
> > >   kho: make debugfs interface optional
> > >   kho: add interfaces to unpreserve folios and page ranes
> > >   kho: don't unpreserve memory during abort
> > >   liveupdate: kho: move to kernel/liveupdate
> > >   kho: move kho debugfs directory to liveupdate
> > >   liveupdate: kho: warn and fail on metadata or preserved memory in s=
cratch area
> > >   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
> > >   liveupdate: kho: allocate metadata directly from the buddy allocato=
r
> >
> > The fixes should go before the preparation for LUO or even better as a
> > separate series.
> >
> > I've reread the LUO preparation patches and I don't think they are usef=
ul
> > on their own. They introduce a couple of unused interfaces and I think =
it's
> > better to have them along with the rest of LUO patches.
>

Forgot to add:
The LUO preparation patches have been soaking in linux-next for some
time now and are mostly reviewed.
...
> Pulling them out to apply fixes separately feels counterproductive,
> especially since we agreed to add the new kexec_handover_debug.c file.
> The most straightforward path is to build on what's already in -next.
> Let's stick with the current approach.
>
> Thanks,
> Pasha
>
> >
> > --
> > Sincerely yours,
> > Mike.

