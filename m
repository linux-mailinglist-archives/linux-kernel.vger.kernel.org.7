Return-Path: <linux-kernel+bounces-769439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1166B26EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05653B61647
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2F63B9;
	Thu, 14 Aug 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWChOP7/"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F6136347
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195400; cv=none; b=rq6O3xyCcaPCMCE1awUWzL0EUUIL0lI0wfLZ1jiMIAzSq9qkTE0hOYssVa0Ow0Jly1SO1wZ5MBg3TpurkWEjUX8l1FF47F04SVMFvjpdZiFZBvxWYjgi0N918VTCR8unoM5L42auOQDsqZHQGiWqfqj34deAqGYkQX6fpvG8vPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195400; c=relaxed/simple;
	bh=nyAVjfUoyamLIGmku11hXtD5P6NzVU1upKijZWfk7JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa1vc4bl/UJJn6nyOPeeG7qYAdEjhTocE9z6DsrOZM3cS/S+okcQYdYFt8Ln4GJGbfWdQjCARRmX3Eqx48sQ2F7v5oLbLy740CjcEk2I+uy3BO1W71YEixcVjAALZYgdzofiM7le/LnXthQn8q2fyaSaJBdCGmABQm7HT5Oe1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWChOP7/; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-89018eb849aso339540241.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195398; x=1755800198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmvDr8Bbjq8VNZi5UsVeHtFFR2f+Ie+N5jkggeqH3zk=;
        b=ZWChOP7/6DNdhgA82TwSWwxIK1R58SGfRTXO6PdYKdgoY1mcgFtD+wucG8vkanZJyC
         J9YxWTS3BZvArAt4ssQ31Z1nXeykAhH4hSKc/DtbZk75OkoPBHs9LS4tvG3W8YJMK/mE
         QPAmv6cOGatGBdQmVessLCZbjWPazZDy8liaNYfOlLXHXX8OzeG3xxu97ZGAMqvGeQrs
         BPxVWdMs8voDxkpWT/Rt947HrtYWs2ugo1OOYmYr7BM8bmZbZpn0OTNYDn3RXyg7cefY
         N7pmg/owmx3F9dnY/rQAqm//iFmpYwXgKEF6660+CjyQBxktXXa5nf30I6T2RMNDCuMh
         7NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195398; x=1755800198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmvDr8Bbjq8VNZi5UsVeHtFFR2f+Ie+N5jkggeqH3zk=;
        b=qBlBPL7stxr1e/8Yh90Sf3ccnO6RgYNnet7KcVRLf10EvhttB1lbJyQ/4MWC3h9Wpa
         IhqvhKr6h2M8gf5VVQelAYA+fNK7KMth1yCZQK8XXHhFsKmcnobqRlidf1tQMURhCgz/
         qKFtz8hfp+jI2yjfC/jemi3d1j5dxxtWbqILdqwUQHJJSycDVDavLtyuAy9tB2ZYsXv4
         5Fbk3snwcdMKVs0B6Y7M53dpxEMXg8L472NAJUXdGSJIHwdB7lklL5qhrsrCZEDlqcrH
         US1KyBx0qpamMZjfQz/bbJhBBYyBNZRGSqIKs8dg2JAFeUVn/MLcTdjK52kEUjAJUqVq
         eM+w==
X-Forwarded-Encrypted: i=1; AJvYcCXvF2n5+qj8+mo3LkIDysDfty2lTTvS+BKcUHKXoSE5BtSvvbEUWWVGxufcVYDCL5oi22CaxtF77N1IylQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPugrxKx+Arn3LY2oZ+GGvZTRF3zFag6hwvNUASJn589Z4d+S
	f2D41PWTemOOETpDKALJC6cY6Ew35cpHuTwS90RfrPC/1BxBJqDuRiQtj56EsScJid1iwA6ihte
	UuhF3dDghO504aOekx3Xb8w2SvWN9LqjHm54VNxjU
X-Gm-Gg: ASbGncsVeiaFRR2PQ+kGoY8WB9K/vRmVJGGXyOusjWyhxJT10me8E5fgo1O95YfDgYf
	j8LUIFO3vA7qnsous/s7kFV97a6YwcGDFQdntOiTC6VUjDpPTcCy/orfS9eegUbd2n6L6C5z4jy
	vSoZb5UOC797PMU3VfhEQnpTneOxecG4V1Xo0gPX3WccK1WtfTzKuAtqNp7UYcx5XYdK9QXcZ0r
	z32/NHESgIg5JwkheTwmBYVkj/ZyaDKwQ==
X-Google-Smtp-Source: AGHT+IFlGxn1Sqg022zva/7sQSnDvOwgknB32FjHN1arfvNFeBr9ye/vmCe8vWbmlOVMNOovnkPxQYXr+JZ1VHZpP3Y=
X-Received: by 2002:a05:6102:41a8:b0:4eb:f003:a636 with SMTP id
 ada2fe7eead31-50fd3226011mr1931707137.0.1755195397812; Thu, 14 Aug 2025
 11:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814122949.9024-1-wangwensheng4@huawei.com> <2025081451-police-playlist-3f9b@gregkh>
In-Reply-To: <2025081451-police-playlist-3f9b@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Aug 2025 11:16:01 -0700
X-Gm-Features: Ac12FXxNCurqT0RfOTHN0-GF2GJlEKLsArSW5Q_diP7-WqsEjZCbjN_t9NwhEHo
Message-ID: <CAGETcx_-otRyDknVs4SFVWzf5-Zi07TiKUEpetDJJ3r0BTVqmw@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Fix concurrent problem of deferred_probe_extend_timeout()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wang Wensheng <wangwensheng4@huawei.com>, rafael@kernel.org, dakr@kernel.org, 
	robh@kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org, 
	chenjun102@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:20=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 14, 2025 at 08:29:49PM +0800, Wang Wensheng wrote:
> > The deferred_probe_timeout_work may be canceled forever unexpected when
> > deferred_probe_extend_timeout() executes concurrently. Start with
> > deferred_probe_timeout_work pending, and the problem would
> > occur after the following sequence.
> >
> >          CPU0                                 CPU1
> > deferred_probe_extend_timeout
> >   -> cancel_delayed_work =3D> true
> >                                      deferred_probe_extend_timeout
> >                                        -> cancel_delayed_wrok
> >                                          -> __cancel_work
> >                                            -> try_grab_pending
> >   -> schedule_delayed_work
> >    -> queue_delayed_work_on
> > since pending bit is grabbed,
> > just return without doing anything
> >                                         -> set_work_pool_and_clear_pend=
ing
> >                                      this __cancel_work return false an=
d
> >                                      the work would never be queued aga=
in
> >
> > The root cause is that the PENDING_BIT of the work_struct would be set
> > temporaily in __cancel_work and this bit could prevent the work_struct
> > to be queued in another CPU.

This feels more like a workqueue API issue (this isn't too obvious
from the documentation) or me misusing the workqueue API.

Is this issue still there if you use cancel_delayed_work_sync()
instead of cancel_delayed_work()? If so, just switch to that and add
proper comment on why it needs to by "sync".

-Saravana

> >
> > Use deferred_probe_mutex to protect the cancel and queue operations for
> > the deferred_probe_timeout_work to fix this problem.
> >
> > Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on dri=
ver registration")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> > ---
> >  drivers/base/dd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 13ab98e033ea..00419d2ee910 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_=
work, deferred_probe_timeout_
> >
> >  void deferred_probe_extend_timeout(void)
> >  {
> > +     guard(mutex)(&deferred_probe_mutex);
>
> But if you grab the lock here, in the probe timeout function, the lock
> will be grabbed again, causing a deadlock, right?  If not, why not?
>
> Have you run this patch with lockdep enabled?
>
> This feels broken to me, what am I missing?
>
> thanks,
>
> greg k-h

