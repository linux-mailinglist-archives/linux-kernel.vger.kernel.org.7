Return-Path: <linux-kernel+bounces-830970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705BBB9B0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD604C5774
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F1314A64;
	Wed, 24 Sep 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMffH/Yw"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35FE314A73
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734316; cv=none; b=EkoCAMgYPq6SEVbvnqFb14ZfelVsu2tqFmLyuWABfzuUBiR44roHS8/wWQnk8wAbUzKbXv0Lu/PcEUIjINqDRczmRrhTqeuCINdzHWElLs7g5J5QjsT8EQZA6/8absIwKJM7HDMUauM0hgYNeEHNAIDGT+ozPzHOOJHuvkHIVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734316; c=relaxed/simple;
	bh=hlK30MjUC9fiNGfLRxzMUUUgYUbF4BmxAwJAcTHgmLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH+fTMzmmsO6gXjiBdjkUa9RuCAglGQAaqtmVIJlY+lTZizzpdMWUvetZpjQaX7Bo0DRq/i+nnnREsF9EjiC0X+oovNVjDIU84gCVdX6aj6eOErDar9mh5OW7LYUPI2e8IoLbdyqToJ0Nz84ZX+deoKQFHNfnVFP3la917h1wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMffH/Yw; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54a9482f832so83936e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734314; x=1759339114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlK30MjUC9fiNGfLRxzMUUUgYUbF4BmxAwJAcTHgmLg=;
        b=AMffH/YwAn+aB+k1N8oMbOD98Q8HwlzYTD0YDG7zAUD9WCVpkQQOieLx4stHNhL1PY
         cVB9nXSEWcKFKAZQ0nOPS63uptp6v57lU8w+GqnREegOa5S8nDzrIn4txLsmx0eUV0L8
         qGAQOjtVPDqh+oa/nqWXcGs6XVZhOuYzkv16QfAvwhXWJTrsMe6kMIzH9g2HqgLwvM9I
         uSmJztI644J5OHcDQr4vZGHA2AWP01YEMbiChe49A9ncmwmv0Xin/enLm7Ej8ZwLRU1L
         5pfLqjueUU+M0awo656/GcWOm4AKf4cTvD5eqBtWudAfwyJ/LgbycO7mIKS26ooeZ2oj
         m1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734314; x=1759339114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlK30MjUC9fiNGfLRxzMUUUgYUbF4BmxAwJAcTHgmLg=;
        b=vH5wK0OaBauDk9peF3n7v/hoZ5dNbTwJX2dI/NxCwDs1Y+7sz267/fzOWejSHJ2cxb
         cUzcbFYbMExbRTUhQQixuXEnVxLQDHkK2bqm692IRS5inc7evND99CWYpQ3gzKHsFhIh
         b8xAKYakdjZaR0UhgVLHrKI+umiF5LMep/RBV8Cj964IoWQmbnxY7CAM/03hMyX4mTjI
         bUYODpQ64rRQ2zMjwV3IoxEjn5LywTnjGvcYwS7qRieWkJcpOXuz4O4u4ttTu47xYUb5
         Zbf9wAitzNjnE7nPaXE9tdL3luelOs2VC7fwTSZ7DazaHd0CjUjLUMM/7QOmTHSRli/9
         gdYg==
X-Gm-Message-State: AOJu0Ywr8WHVidr8Kr6nGii9XyvBMJ0Gb4XKA7mGeMc7ONESN9HGX2WG
	3pWggzgRX8ZmUf5ZMZnC4SOv6Kg+1RPohWLUFhiOK2NM9dLk7XJYghyWDkUBkIbjF4b2dUiJltK
	Yzcm7GhGucCG5ncl0o4gC4s89Ic9p07s=
X-Gm-Gg: ASbGncuOCgFUBN+EEiN6bl9tBbG/xgmSFcVqYuzKIYCvAs7weIOYFewZtNZBs7kw0Ue
	uCxhZ03aeRGYRXKscczGspImYFgkLpeyfDJlSDomMCdjpjTPRMmpMAZMB2aOLEQR51+yHiGN/4j
	5EPqDbEwW+cowGdzVi8r1TR8ciPRYxBOAn//wf0708jM6W2w1UlJ0d9OawiRHNeKG6H81Ojh5CP
	npI/Emj1bIky5x4sMtNr3Fn6rczkdYNC+9bk6M=
X-Google-Smtp-Source: AGHT+IFNudWYdRYohdYWRakfqW3sTemN0SWD3jGIkvD9SRgmpWDEPo14DUBWOj+taHvy6lJzsWWaGnYJeYCvB7r8Igc=
X-Received: by 2002:a05:6122:3c82:b0:54a:9fe8:171e with SMTP id
 71dfb90a1353d-54bea23effamr355653e0c.7.1758734313522; Wed, 24 Sep 2025
 10:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
In-Reply-To: <20250923170545.GA509965@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Sep 2025 10:18:22 -0700
X-Gm-Features: AS18NWCWLBluj_2WnA7xQt94H_1gC4pE8CBvpOcHrfIASayaDPo8l1l16vPe2Bw
Message-ID: <CAM_iQpWe50B4hfVTd-xTemByvoM_bg7eA9y8qwZjBsYcAbY9fA@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:05=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Sep 22, 2025 at 03:41:18PM -0700, Cong Wang wrote:
> > On Mon, Sep 22, 2025 at 7:28=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Sat, Sep 20, 2025 at 02:40:18PM -0700, Cong Wang wrote:
> > > > On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@r=
edhat.com> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > > > > This patch series introduces multikernel architecture support, =
enabling
> > > > > > multiple independent kernel instances to coexist and communicat=
e on a
> > > > > > single physical machine. Each kernel instance can run on dedica=
ted CPU
> > > > > > cores while sharing the underlying hardware resources.
> > > > > >
> > > > > > The multikernel architecture provides several key benefits:
> > > > > > - Improved fault isolation between different workloads
> > > > > > - Enhanced security through kernel-level separation
> > > > >
> > > > > What level of isolation does this patch series provide? What stop=
s
> > > > > kernel A from accessing kernel B's memory pages, sending interrup=
ts to
> > > > > its CPUs, etc?
> > > >
> > > > It is kernel-enforced isolation, therefore, the trust model here is=
 still
> > > > based on kernel. Hence, a malicious kernel would be able to disrupt=
,
> > > > as you described. With memory encryption and IPI filtering, I think
> > > > that is solvable.
> > >
> > > I think solving this is key to the architecture, at least if fault
> > > isolation and security are goals. A cooperative architecture where
> > > nothing prevents kernels from interfering with each other simply does=
n't
> > > offer fault isolation or security.
> >
> > Kernel and kernel modules can be signed today, kexec also supports
> > kernel signing via kexec_file_load(). It migrates at least untrusted
> > kernels, although kernels can be still exploited via 0-day.
>
> Kernel signing also doesn't protect against bugs in one kernel
> interfering with another kernel.

This is also true, this is why memory encryption and authentication
could help. Hardware vendors can catch up with software, which
is how virtualization evolved (e.g. VPDA didn't exist when KVM was
invented).

>
> > >
> > > On CPU architectures that offer additional privilege modes it may be
> > > possible to run a supervisor on every CPU to restrict access to
> > > resources in the spawned kernel. Kernels would need to be modified to
> > > call into the supervisor instead of accessing certain resources
> > > directly.
> > >
> > > IOMMU and interrupt remapping control would need to be performed by t=
he
> > > supervisor to prevent spawned kernels from affecting each other.
> >
> > That's right, security vs performance. A lot of times we have to balanc=
e
> > between these two. This is why Kata Container today runs a container
> > inside a VM.
> >
> > This largely depends on what users could compromise, there is no single
> > right answer here.
> >
> > For example, in a fully-controlled private cloud, security exploits are
> > probably not even a concern. Sacrificing performance for a non-concern
> > is not reasonable.
> >
> > >
> > > This seems to be the price of fault isolation and security. It ends u=
p
> > > looking similar to a hypervisor, but maybe it wouldn't need to use
> > > virtualization extensions, depending on the capabilities of the CPU
> > > architecture.
> >
> > Two more points:
> >
> > 1) Security lockdown. Security lockdown transforms multikernel from
> > "0-day means total compromise" to "0-day means single workload
> > compromise with rapid recovery." This is still a significant improvemen=
t
> > over containers where a single kernel 0-day compromises everything
> > simultaneously.
>
> I don't follow. My understanding is that multikernel currently does not
> prevent spawned kernels from affecting each other, so a kernel 0-day in
> multikernel still compromises everything?

Linux kernel lockdown does reduce the blast radius of a 0-day exploit,
but it doesn=E2=80=99t eliminate it. I hope this is clearer.

>
> >
> > 2) Rapid kernel updates: A more practical way to eliminate 0-day
> > exploits is to update kernel more frequently, today the major blocker
> > is the downtime required by kernel reboot, which is what multikernel
> > aims to resolve.
>
> If kernel upgrades are the main use case for multikernel, then I guess
> isolation is not necessary. Two kernels would only run side-by-side for
> a limited period of time and they would have access to the same
> workloads.

Zero-downtime upgrade is probably the last we could achieve
with multikernel, as a true zero-downtime requires significant effort
on kernel-to-kernel coordination, so we would essentially need to
establish a protocol (via KHO, I hope) here.

On the other hand, isolation is relatively easy and more useful.
I understand you don't like kernel isolation, however, we need to
recognize the success of containers today, regardless we like it or
not.

By the way, although just a theory, I hope multikernel does not
prevent users using virtualization inside, as VM does not prevent
running containers inside. The choice should always be on users'
side, not ours.

I hope this helps.

Regards,
Cong Wang

