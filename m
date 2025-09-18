Return-Path: <linux-kernel+bounces-823576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57150B86E15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2471B3A35EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960C30FF3B;
	Thu, 18 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHUkk8Wl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75412E36EC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226805; cv=none; b=EkB1tCvvXnw0KSQZ2XrlbYzfNfYaiPY3ZGJJF68T8JOTyuMN6dJ6yKaUEWd1ICbdquF3w8Jqp8mC/36FC0alUNuksl/WYR0KBTKZ6YFmRcAWbNvIfEUDolhyolv9+qWIowBh43suRoHVY6rAgBv1hyznw6AIwnSBHi7wl/h/4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226805; c=relaxed/simple;
	bh=FSbtJlfbEWpXTTAL2IWDvDc9bF4V5nwqxEsky0boeH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiubx0jLKAPPUesoB4eOMVApcczkwuKKAlV8SPlz93ipGFoEpJ7Baz49/jmVMGrzPv2l3gIoEPIdC2v6GItfG95fCB15lfOQcV0VtyUIoMMaxg7lc+7BQRIP5PlNLf0RePK9lZWvWBG9eNj/qhlWjPegtczwEsUxORM2MPRt5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHUkk8Wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD256C4CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226804;
	bh=FSbtJlfbEWpXTTAL2IWDvDc9bF4V5nwqxEsky0boeH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHUkk8WlH2WQSknXGdIkl0p8/1L5ZfUR160VJCNnolIpi0OXYJhra12Y6VWYgf/l1
	 gkW4nCVKnIToZpxLhPtdor0Jg+a1q6W67huv2/WwpR7FjyOfgJOhAPVO+e0L9JMniX
	 pUhblqSti95R9llSdqoILioc1KBBD/eZB7yG1GqCJQhDSGgwvjXIT4/QGDZ703PJrB
	 RsFTEtkQpluxZqONKAHbFaDJ7dNSIgbHXmll8B4TneKQSl2kk5Cr4cXw8H2pHbzQc5
	 8LleJ5x2HKN+UY3OAIn7++vKcDjp9XQC6mbOq82elDV9exy/Hp4D0/+4YyNKBfm4jb
	 80mYiyl3zBUCQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7459d088020so832011a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYRwCAlXLvaOv2P/+ik+oIkuSswMFk7K8ez1aH4mlZfI78jaub167lVL8HiZuDhaCKJ3NU+qNPoG9p57g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGCgnxSLL0wilR0i/vhPWDs1HFFWLmJjMOpXMeaNXBIJ7HaUM
	BTY4DtGJ7jUPiujrC4vk5YbnB5d1imjor6mmtqLvL9iCcsssNYclPYBCU9Irj4fqZPVeW7e8pky
	tUj+IOlQL0FngNgtNLxRGG58CRoYS6rE=
X-Google-Smtp-Source: AGHT+IFj8Evd9wrxrU9eEA0BZbG2dAGaKoOu93PO6e4DBK/ygFMiTGXFHDyw4LJmydZFqvSmBzO86Qgv961KHtPOF5w=
X-Received: by 2002:a05:6808:2109:b0:439:ba45:96cd with SMTP id
 5614622812f47-43d6c252460mr359647b6e.31.1758226804076; Thu, 18 Sep 2025
 13:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki> <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
 <87h5x088mt.ffs@tglx> <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
 <87ecs38qi5.ffs@tglx>
In-Reply-To: <87ecs38qi5.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 22:19:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivDy8DrAe0BBuN47eU0FZXb_FgEATCwMHL1HnwR7uDyQ@mail.gmail.com>
X-Gm-Features: AS18NWDjRyOU3mVcIH-0Z7u0dM-a-ij1AMhSchzLRem42YD9hL8SFOslN2ZAgPk
Message-ID: <CAJZ5v0ivDy8DrAe0BBuN47eU0FZXb_FgEATCwMHL1HnwR7uDyQ@mail.gmail.com>
Subject: Re: [PATCH v1] smp: Fix up and expand the smp_call_function_many() kerneldoc
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, Sep 18 2025 at 12:05, Rafael J. Wysocki wrote:
> > On Thu, Sep 18, 2025 at 10:31=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >>
> >> On Tue, Sep 16 2025 at 16:13, Rafael J. Wysocki wrote:
> >>
> >> > On Tue, Sep 9, 2025 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> >> >>
> >> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >>
> >> >> The smp_call_function_many() kerneldoc comment got out of sync with=
 the
> >> >> function definition (bool parameter "wait" is incorrectly described=
 as a
> >> >> bitmask in it), so fix it up by copying the "wait" description from=
 the
> >> >> smp_call_function() kerneldoc and add information regarding the han=
dling
> >> >> of the local CPU to it.
> >> >>
> >> >> Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
> >> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > It's been a week and no feedback.
> >> >
> >> > Well, in the further absence of any, I'll assume no concerns and jus=
t
> >> > queue this up.
> >>
> >> Sorry, was distracted. No objections from my side. Did you queue it
> >> already?
> >
> > No, I didn't.
>
> I pick it up

Thanks!

