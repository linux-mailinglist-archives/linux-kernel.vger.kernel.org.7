Return-Path: <linux-kernel+bounces-831079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2318B9B7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA4219C2A31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813963128B0;
	Wed, 24 Sep 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqGqnRSE"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53561239E9D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738498; cv=none; b=br2Ui0Xcu+ou+YnJVjgr05nynrO/oSa9mc7EnX2ljbg/Vh6LkWvQwUCWc7lOiXVA71YINFVC4OwkBD6EBZU75RTEpogc5ncRa6BiVwWwkhYTWObQFpsMTr/ZhTr0agiOszZdDpWC0cRBdX/BjDUMA4Xm/HOufsOz+2Q1v47O6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738498; c=relaxed/simple;
	bh=IC9nKcdgtD6FCnJ0khO3nQPUu6U/Swo2cDFZgdHuKJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxpLadfrAadtGKRTloZ3U55CjmV92CMEq/Qm+ckpKKnQnsKkZwYOn8G/inLgCA4Lm4wP2fx/+bcRb1PoAnMCrcofPSqwdQxBD1UqnHZs+rCwa2M+WncYty/ujEH/BGfB/azh6PZmckp12Xs/zlBwQk5Wsz9Wg1KV8Om83YQu1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqGqnRSE; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-890190d9f89so19229241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738496; x=1759343296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IC9nKcdgtD6FCnJ0khO3nQPUu6U/Swo2cDFZgdHuKJk=;
        b=ZqGqnRSEjZ+3cfhYWYxl0l7iE1dOMz1kbNzCRB9VkLTuQS+iRanU66t4yOKtAeKEkx
         1OR0TZlJFSdnrk3wgh2vAPOKX0rmn0Hl0RYnkCn+tGvIxN/Vzyt7SJxqbwyhAbGchcuv
         31UZ+Ba45iHO79l1Fg4Q5UtqJ0WOulGOeetAJxgv6DXW5vIZl3taS8ta0W9u06GGS8OQ
         xtxZnfroku6nHclgOWoeNUWljwe2zESAuKWwzfEOG3mjDdbpDWWpQWNgXH4OKMii6PLw
         ev/UvD+OaNm8UcQdCiuQ/swMVrV1QjgcrrMCv0Xxl9g00GQGVhS90c8S55IeSjq+1Mfn
         fcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738496; x=1759343296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IC9nKcdgtD6FCnJ0khO3nQPUu6U/Swo2cDFZgdHuKJk=;
        b=uMAuEy9UyoXGsggBlh/aPwDbFpmh22nn3UXCx1VLAKTLjtpWsxvjWJ+uSCZr33Kya2
         74jXaJ9gqPchPnVjlGi6zP0uClXJkwphX3gKircjKiMuFHgymXqffn7bfLw29AZ4P4Z3
         WCH2wAUHbH7wHxTMRVpuPqFffO3xPfAleZVwHE2bOdKvSAed55KUaQvxiao2sbjkFB0o
         TT6mlR4MGvIvbU2Eezbw71Bol8nG7rNYh9nmxzH+XyMTg4z2OMhwE7F23W4AX+0Sf8nk
         GedCghKvmNMIgdwAMOs0uDQraz5Amx1tGFS7CoytImUSY6tEwGTU/nn1UWCjy/gc+no/
         2oAw==
X-Forwarded-Encrypted: i=1; AJvYcCU7FM2IQPryg0i45T0/Plz1FvuBCblKqpzi5fOpJvJ4kMg67b2rZG5VlPzcSMVShMH1I0VMuYN32e3lHKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItET4tYeYENnFA8XC1FUXK9hFMIUcekRfJy2+uBr7tWG6qbui
	m1nFFYUISocpceOlzfJuAT6QHYP/Aiohh9MuhmUzEWEN9zhkYgQMcZd1wq2W9t9hbGWKdFT4jzI
	yPR4FOW0rfM63FX6AJg4bV8iBxqoibo0=
X-Gm-Gg: ASbGncvCPGKz0lr3j7JTS2m0p7mJspjt5OtApYafHiDnDP6oBvKLb74EawRy0D+SEDl
	oFSmgC4VV6pHLHnjgZozdZE0MFXoZqUFDIGoqkiwL3GWhHK3NgOSTTUtBENIfW1wLa5QFgXxoZn
	iSvGf7dWAiSYTlSrKJUowA4uxuCp7RTk3mCyILKn4ZP042i0k1yCo6rOoKyYwHmL9DhpXDQyLUd
	iBm8c70XWCnn4LmrTRbODPvgwWzi8g28wb8lr8=
X-Google-Smtp-Source: AGHT+IGnZ5YD7V4USsci1qW3abSoXkq9k+Mc//5cJJhmJJIWBD1IuJEsonv3BX4urHjIQD5e13xNPYxJy+BdDvyWIxM=
X-Received: by 2002:a05:6102:d90:b0:4fd:53e0:b522 with SMTP id
 ada2fe7eead31-5acd4639abbmr429762137.19.1758738496130; Wed, 24 Sep 2025
 11:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora> <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora>
In-Reply-To: <20250924125101.GA562097@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Sep 2025 11:28:04 -0700
X-Gm-Features: AS18NWCuwrysu1oqk43xTve6hldZaAK8cQhNTzJSaIvDKFt0icQ4DA4v7i2Wf-M
Message-ID: <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:51=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Sep 24, 2025 at 01:38:31PM +0200, David Hildenbrand wrote:
> > > >
> > > > Two more points:
> > > >
> > > > 1) Security lockdown. Security lockdown transforms multikernel from
> > > > "0-day means total compromise" to "0-day means single workload
> > > > compromise with rapid recovery." This is still a significant improv=
ement
> > > > over containers where a single kernel 0-day compromises everything
> > > > simultaneously.
> > >
> > > I don't follow. My understanding is that multikernel currently does n=
ot
> > > prevent spawned kernels from affecting each other, so a kernel 0-day =
in
> > > multikernel still compromises everything?
> >
> > I would assume that if there is no enforced isolation by the hardware (=
e.g.,
> > virtualization, including partitioning hypervisors like jailhouse, pkvm=
 etc)
> > nothing would stop a kernel A to access memory assigned to kernel B.
> >
> > And of course, memory is just one of the resources that would not be
> > properly isolated.
> >
> > Not sure if encrypting memory per kernel would really allow to not let =
other
> > kernels still damage such kernels.
> >
> > Also, what stops a kernel to just reboot the whole machine? Happy to le=
arn
> > how that will be handled such that there is proper isolation.
>
> The reason I've been asking about the fault isolation and security
> statements in the cover letter is because it's unclear:
> 1. What is implemented today in multikernel.
> 2. What is on the roadmap for multikernel.
> 3. What is out of scope for multikernel.
>
> Cong: Can you clarify this? If the answer is that fault isolation and
> security are out of scope, then this discussion can be skipped.

It is my pleasure. The email is too narrow, therefore I wrote a
complete document for you:
https://docs.google.com/document/d/1yneO6O6C_z0Lh3A2QyT8XsH7ZrQ7-naGQT-rpdj=
Wa_g/edit?usp=3Dsharing

I hope it answers all of the above questions and provides a clear
big picture. If not, please let me know.

(If you need edit permission for the above document, please just
request, I will approve.)

Regards,
Cong Wang

