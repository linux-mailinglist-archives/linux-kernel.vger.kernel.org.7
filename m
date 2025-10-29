Return-Path: <linux-kernel+bounces-876174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B9C1ABD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B1E1A26923
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672033F38B;
	Wed, 29 Oct 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtNDEiyd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B8433F37D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744215; cv=none; b=FRdbNNMIHnpdvzIUw2kmUXPJOYmhGHt1n3y9jqp6hHogqFQW4odB8WnebTE2neL0Fxk2rzWnYcB2gon1kHZKGB/wilm4cCdUyJiCvIpuaKVwsMSxhgbiBqnx+bAS36RFb7t/pWhKeonULfyYiDm46FAG3wCdpB2TEMjiNQGgmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744215; c=relaxed/simple;
	bh=ddAWkecBr92ro43mQ8PZN7RoRqvSWyWvAvbj+Y7jmus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCjOv4JhgB5y2+w9PlJ3HvcrZDjeosDzW7Svcpy/4bcj/fUea2sZOsR+Djki+ud/6H78frpi3ds4LoWArR2WK7CItC/Y5ufPBtB11c8oGkuhjS7CkYnw/bGdXQ1ALnHqzQ5ok5apb6DPEGeggdpcKzCPpRuQ73PrEZ+wMJ2kayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtNDEiyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6E9C116B1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761744215;
	bh=ddAWkecBr92ro43mQ8PZN7RoRqvSWyWvAvbj+Y7jmus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TtNDEiydVC57nYuo/ycuhwLABPiQZAJBSLTODh8b9BISekDWf6PUP+uuFy4wfWIY0
	 z4gSs+3FrGgicQx0c9+tkfOEYu/PkYZfA1W9KTPAzy39V6urqv2f1IS1Ceamv0nyDr
	 DZL2HLv2Mp5M+JTaCWzN5cpZhY22qQbyS+bnY1mLpI8zzimn4sZ/Ipwa9c05jmhZhr
	 gN4Zw/ENNNl6aq6KCZ9/Btcst5bCk1ghPO+aFXszFjLZb5Sn+HvabtV5/b+gTppI5d
	 /ze2l8DgbVT/aZakpH2bzP0c00eDXSaTROJQ31Wm0u3r2Mgw4z1VcolTI76KkwOvgO
	 SgZ5yDwVsMYVA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c52db2e41fso660040a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:23:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXe5XTRjwqyILaURyNToNG6jY6uLkjs3fHTqD0bgwFGrCRerV12pM5kCqPGyp33opDpQj08MRuVFtVM27k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJRItjU6nbs5seffF0141bnQaixCIPzayGu8T9ul60Om3aaE7q
	Dq69ECvygTDINMPQ4sj4EehR1RVGiIx1fHh8nzyhcbHrfSquNbXBw5YNcgm1WmdJPOVlAvNdFfR
	kpA434ybBz5DxZcGYu05L+ssdXstNJjA=
X-Google-Smtp-Source: AGHT+IEN5NwhOih9Yiz02q77IzIYOZUvhckDKDD+pcxiV0ri0aTo7Tl8bq7SdufEXCV2dphojidk1VzTqO9a9T3Gk7I=
X-Received: by 2002:a05:6808:2443:b0:44d:b997:d82c with SMTP id
 5614622812f47-44f6c79f8f7mr2620527b6e.18.1761744214318; Wed, 29 Oct 2025
 06:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
 <CAGETcx8ZL3jAwFRxO1B8SFSWmC2jCitc9_61hBG-N2AvzRQv7w@mail.gmail.com> <CAJZ5v0jiLzMvwBfcXKJEOMqa_U=6OeWymnBCBdxYfcgU+7P1Aw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiLzMvwBfcXKJEOMqa_U=6OeWymnBCBdxYfcgU+7P1Aw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 14:23:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpG19Tj9qmTkXQ_6N+wTSBD4Lzx9UvFwTh3WtUagCOGQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkRIv-pCc9QoOjKnPqYO79vvgvX9qd3s5958IMfh_hi6HQMrTXj71V7E9g
Message-ID: <CAJZ5v0hpG19Tj9qmTkXQ_6N+wTSBD4Lzx9UvFwTh3WtUagCOGQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Saravana Kannan <saravanak@google.com>, Samuel Wu <wusamuel@google.com>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:37=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Fri, Oct 24, 2025 at 12:47=E2=80=AFAM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 12:43=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Sat, Oct 18, 2025 at 1:39=E2=80=AFAM Samuel Wu <wusamuel@google.co=
m> wrote:
> > > >

[cut]

> > >
> > > If I'm not mistaken, the mechanism by which one more sync is started
> > > right after completing the previous one (that was in progress when
> > > suspend started) can be designed differently.
> > >
> > > 1. Use a dedicated ordered workqueue for the sync work items.
> > > 2. Use a counter instead of the two boolean vars for synchronization.
> > > 3. In pm_sleep_fs_sync(), if the counter is less than 2, increment th=
e
> > > counter and queue up a sync work item.
> > > 4. In sync_filesystems_fn(), decrement the counter.
> >
> > The problem with this is that we can't reuse the same work item. We'll
> > have to allocate one each time. Otherwise, we'll be queuing one that's
> > already queued. Right?
>
> Of course you can't queue up an already queued work, but there may be
> two of them and then in 3 above use work0 when the counter is 0 and
> use work1 when the counter is 1.  No big deal.

Moreover, sync_filesystems_fn() doesn't use its work argument, so the
work can be requeued as soon as it is not pending.

Now, when it is not pending, it has not been queued yet or the work
function is running, which is exactly when you want it to be queued:

1. Use a dedicated ordered workqueue for the sync work items.
2. Use a counter instead of the two boolean vars for synchronization.
3. In pm_sleep_fs_sync(), if the work is not pending, queue it up and
increment the counter.
4. In sync_filesystems_fn(), decrement the counter (after carrying out
the fs sync) and complete the completion if the counter is 0.

Of course, the above requires locking, but I don't think that the lock
needs to be spinlock.  A mutex would work just as well AFAICS.

Thanks!

