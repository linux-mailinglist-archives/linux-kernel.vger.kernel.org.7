Return-Path: <linux-kernel+bounces-827941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1BB937FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3712244527E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0382FB98D;
	Mon, 22 Sep 2025 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRQpfFSh"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050F28134D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580893; cv=none; b=G9Jg8xAOpXa7Sx6GQ9nhzOe2BT8mU8C1tl/5fTnAKH/m+E1JzHQXCZZPIrmByxWd8NRTUjDedYydPLh50IHwvHAHBGPMitv8u5sKk6aXhpOLVTN0/WlYTwQIjCbgRMbKb8dWgMOyGKKpkWbE7ysCmbCbwUgcFQRu29V0C2lGqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580893; c=relaxed/simple;
	bh=0yh6sVdAT113ztDhuPxo1MqnAkuhIHDy1HJdIr+aZPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8/DaUPS6Bv8tUSiRqDAFtIAptLjVc+qbKgUYcK2jltZdX79tQ7LoxNBSKiClVIVkk9Afa1TqJzmQa3gGZq/mhKvgc3tUjMLKMVMiXKYqiqF3II8Cxr6gFE++P4aCtGV4JNQaE+UkdjW9Tu9OgWDcombwPM2l4sHPEvJnrMV9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRQpfFSh; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8d02f793882so3236015241.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580890; x=1759185690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yh6sVdAT113ztDhuPxo1MqnAkuhIHDy1HJdIr+aZPU=;
        b=cRQpfFShWL3Bt/dfiyTkGcDikhhABwaKi07qw/yDTOTsoaY5bTUEl5c2pltQWYKad2
         fss+RaHFYgHDbhi6h3/UN/8iIzXuy6Zwaknsn7V+0ufun6oIsHhslxut4iWzvQzIkvEV
         +swLqw3pNSWydk1/IdidRL13Ob5B7+lRyKxDSGUe10E++aSNx3JjnHGOOLI3+eRNGzwC
         zh23p4hQtYvND0LYu7nQS9fs12Kp7A4Jpn8/7EmqGVWFyzKwSBJDJRjj7iP1aBpgvA0c
         dUpZQShK9twFMUhffLeJ3EWusEWZiORtYXHim9ANGezqcuxeLtJlgy5S7e5CZKoBKzp7
         hFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580890; x=1759185690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yh6sVdAT113ztDhuPxo1MqnAkuhIHDy1HJdIr+aZPU=;
        b=LdH/1WVN5j77LpckplboEoE4IFV9j35QgW3dW3UIwuL/5uprOnMvpknPT5HJhVkc2w
         VBEMYnBimE3pUjAaH02J/MGoM23BYkyfJUM9gaj/Gmq+cxnBXx/k+su6Aem8NW1LW8MQ
         ZCJAcGvPds9cavSU6zQyR97dY2KazHJ6T+y5CNQh+jszhQo3AyxwrQCPMxfmthgnu1w7
         AskbDYySL4yp6JUysgnu4w1WSYf56+pp9e6OMhE3ZUqT9EqCHIQQaWxvYLtA3y95wItf
         ZQi/1wsuoW5icgVkbS8Vwz7vmI7td0RbyJGc8sWeH/n/gAJuww5uTW4juDqw8ftpzOcg
         aieg==
X-Gm-Message-State: AOJu0YyYb1lvby1EwuIKPVLZQM/24i/SfTqMJ5TUF9GCjAfcqHMT2+nX
	zGA+/bN+9bVjpW2+mfVRln6fCPsKvI1c6bD4IYf7imejFbRNRiAjSRekDVM6uP8/i7NH7ayDYpW
	TiU1UJKgrfSfckINNsi8Aoq0tOPNO0yk=
X-Gm-Gg: ASbGnct8NzadTKhTHaeFN4xaQ8yfTDnn2VsaeR07fGmR0YefDvsOUF4RW3IkAIVyl4n
	ysinTZQyu5tlbpzaqUQmgWgYtUH0D40sfkbV9btYSBfeu7ptTTII51Mm7RW0AbHYbA48svo/w4j
	/ELPYRxQjHWVNtMqH40WqM5pN8HLHiMuo0TJbZK7QEgEMhDJ53TG6iVjQfyTkBEP/gafU4xvtvW
	viXz1A2oICwwyAtr/HIe4z3DBlk5cnMP2ubrsk=
X-Google-Smtp-Source: AGHT+IHFB6pkceMUZ77NeXmuYnJm1V8ontKaUDy90T/NYBaMVOfoW99El5NLWv56d5b2UvDdU+jygkw5mvczc9Xzk18=
X-Received: by 2002:a05:6102:4492:b0:4c3:6393:83f4 with SMTP id
 ada2fe7eead31-5a57d8d7f2bmr255887137.2.1758580890508; Mon, 22 Sep 2025
 15:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
In-Reply-To: <20250922142831.GA351870@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 22 Sep 2025 15:41:18 -0700
X-Gm-Features: AS18NWB9iArZm8gNoiOyRm5CUi70i_coc1Ea1AEenDW54lVyHBPMys3KfUjFGeg
Message-ID: <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:28=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Sep 20, 2025 at 02:40:18PM -0700, Cong Wang wrote:
> > On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > > This patch series introduces multikernel architecture support, enab=
ling
> > > > multiple independent kernel instances to coexist and communicate on=
 a
> > > > single physical machine. Each kernel instance can run on dedicated =
CPU
> > > > cores while sharing the underlying hardware resources.
> > > >
> > > > The multikernel architecture provides several key benefits:
> > > > - Improved fault isolation between different workloads
> > > > - Enhanced security through kernel-level separation
> > >
> > > What level of isolation does this patch series provide? What stops
> > > kernel A from accessing kernel B's memory pages, sending interrupts t=
o
> > > its CPUs, etc?
> >
> > It is kernel-enforced isolation, therefore, the trust model here is sti=
ll
> > based on kernel. Hence, a malicious kernel would be able to disrupt,
> > as you described. With memory encryption and IPI filtering, I think
> > that is solvable.
>
> I think solving this is key to the architecture, at least if fault
> isolation and security are goals. A cooperative architecture where
> nothing prevents kernels from interfering with each other simply doesn't
> offer fault isolation or security.

Kernel and kernel modules can be signed today, kexec also supports
kernel signing via kexec_file_load(). It migrates at least untrusted
kernels, although kernels can be still exploited via 0-day.

>
> On CPU architectures that offer additional privilege modes it may be
> possible to run a supervisor on every CPU to restrict access to
> resources in the spawned kernel. Kernels would need to be modified to
> call into the supervisor instead of accessing certain resources
> directly.
>
> IOMMU and interrupt remapping control would need to be performed by the
> supervisor to prevent spawned kernels from affecting each other.

That's right, security vs performance. A lot of times we have to balance
between these two. This is why Kata Container today runs a container
inside a VM.

This largely depends on what users could compromise, there is no single
right answer here.

For example, in a fully-controlled private cloud, security exploits are
probably not even a concern. Sacrificing performance for a non-concern
is not reasonable.

>
> This seems to be the price of fault isolation and security. It ends up
> looking similar to a hypervisor, but maybe it wouldn't need to use
> virtualization extensions, depending on the capabilities of the CPU
> architecture.

Two more points:

1) Security lockdown. Security lockdown transforms multikernel from
"0-day means total compromise" to "0-day means single workload
compromise with rapid recovery." This is still a significant improvement
over containers where a single kernel 0-day compromises everything
simultaneously.

2) Rapid kernel updates: A more practical way to eliminate 0-day
exploits is to update kernel more frequently, today the major blocker
is the downtime required by kernel reboot, which is what multikernel
aims to resolve.

I hope this helps.

Regards,
Cong Wang

