Return-Path: <linux-kernel+bounces-819423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFAB5A07A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA84480C55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E22D29D0;
	Tue, 16 Sep 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9cg8I5U"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E1265CA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047157; cv=none; b=S07JSYhp8cZ4ulJ3ohIWxpjlboBgYMbMOZ2EU/AvwOSFWYAHfJS02dijg2++JvI0Gy++U9buyhnUUV2mBLR5bl96QwoBOsGNo+ubC1dkOl2C7cOTnm7bJAQNDwodlumqOful5KGbPLtsnlA4oqFDw3k9oaNF2rEHWemP5xkUAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047157; c=relaxed/simple;
	bh=JnWXlQLI/J5WtQGKFgA4eTmeUFQy+BjOATh2dzHmKG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoG7s5vBdbVV+rQDn9aGmYPgS9WbNzcHwqRW0pTVwUlHsYDwcZKfqvm2smz3XVqjacpeQneSdpHnLpd8i+jKbGQ6PBCCEb5Sjjq6iKuah0nFkgCM6FVjl0ZRZCTALpEUFeZE1+uBdVBBwtnifunm6jxKTeDTZee4gOdGIjE8A4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9cg8I5U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62f19b9fb8cso1591a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758047154; x=1758651954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0VcLk74dR9yFqPkcnr7kuHB/f+/2YKwO0n6eHIar3s=;
        b=Y9cg8I5Unkd586eexpIkkrltIOzj3xpS6i2wzcZM56N0pZ1/cCFQvQD58omsE349ZQ
         B+5K86/dNMp7SW82VtmKRYb/eZMFfzqgAXwg2v3VHAdvAxnsSSBmOrQ4juRtw2nQmwa5
         FbVmP4NpL448fBnfWcwGsxz9GkAYLN1ZOo3NTBCVsFZSu88cOTaQ+cQ0rZtdxpwO7slE
         S3xe40HsnsHAqfFLr1YNSrp58RjUruMkilYgDfKkAVZCYlokf/308PG4ziSrIR7gqblf
         sCWorwy49vsmy+pr8kypcHncY7YBwrxDdZ9npwvUVvJhkJXv9WneQ41gnLGooAd1rqN7
         TZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047154; x=1758651954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0VcLk74dR9yFqPkcnr7kuHB/f+/2YKwO0n6eHIar3s=;
        b=JocnfkCDChXh7tXc9A3hseQ/3Tdo8+ybYdTBXCgxBZVNxyTKhhcIYb1hOYXo3mxYyC
         04CINOt+zANP26jop5qkW2vA5joIkAO9Gyq9MxKX1N75oav5NR9LubGuN5w5oAfCV/+r
         5L709R/FqklCONrYFPHRmRKDrbEdEXkOV242F4gPsSLdtOjuTflVR2Fl3VVMJRugurIv
         xwJ8OQVPFNy1Gtm6CAZXZXGhIpuiBGhWAijJZ9SukdLCsY6jQGhLbZi0SEeudDE0roU1
         xn0igrleOi2Pu13oAuvs8of/fDjwRUHCMvMdzdXJmI45681hPcwMHMEaE8TtataG82GZ
         nXQA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYqzhmpSNv9I0nhriYUje13JCrq+z0FmjxhF50ORR8Ro5FTPiSLKn8rMbwIagQC+WVihuq5U3Lu4fZEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvUiJDzcFmVQU1CCldqFZX7buKGbainRH5OSCKI7LVDs4bqfr
	Wmq47uni9ABmBMV6oln0EKeXINSwnGO+mqmRWeA1c1PaP3Q/v8qKEtg1vEe1DB601Y1o+7cLALj
	LEqx5RRM7KK1bzGGhigOfeqIQEnJV6ogKg/Vj+ZIK
X-Gm-Gg: ASbGncthF6erP4nAu+cVUxbnrrBz/jT65ZmWhHFy69n+Lb+Bg2L6VxP5WqJnwmWWQz0
	A4NEZIo9Zxuv2iUBLU/UQiMlTQug0L1UkD1mWGuIWb7Zx4pdtJI8nY6/en9VD3i4WXkkTeHm3XI
	xct7hoCyN0YswcS8guX8PpLbgkZchEcLNGXdEmsxdfnGw/73m9rzXlY+574gJ4l3c0G8eK+d8PB
	WcRb2fGmcXM90U+lAatl9Pu
X-Google-Smtp-Source: AGHT+IGB++uGP92/3eX+DzpcCYzC7w6FRYx7GVwU2UvS8bV9IgfnXF9imW/DEk57JYWkyi2iUzVE/ZMr5wpsPSunReQ=
X-Received: by 2002:a05:6402:24d2:b0:62f:155b:5e8 with SMTP id
 4fb4d7f45d1cf-62f7e2f8f92mr9478a12.3.1758047153784; Tue, 16 Sep 2025 11:25:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <aMLakCwFW1YEWFG4@google.com>
 <0387b08a-a8b0-4632-abfc-6b8189ded6b4@linux.intel.com> <aMmkZlWl4TiS2qm8@google.com>
In-Reply-To: <aMmkZlWl4TiS2qm8@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 16 Sep 2025 11:25:41 -0700
X-Gm-Features: AS18NWA0y0Y3-CfH_AYL3ReELcTLiz_cc9fscGdmhgbQD8z2XBP9Wg0cvjgDVBk
Message-ID: <CALMp9eTZ7TA8RLSkJYPAawQjVVT9pFxB4QzAjs6XhzHJvQ=V3w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/5] x86/boot, KVM: Move VMXON/VMXOFF handling from
 KVM to CPU lifecycle
To: Sean Christopherson <seanjc@google.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-pm@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	pavel@kernel.org, brgerst@gmail.com, david.kaplan@amd.com, 
	peterz@infradead.org, andrew.cooper3@citrix.com, kprateek.nayak@amd.com, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:54=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Sep 11, 2025, Arjan van de Ven wrote:
> > Hi,
> > > I also want to keep the code as a module, both to avoid doing VMXON u=
nconditionally,
> >
> > can you expand on what the problem is with having VMXON unconditionally=
 enabled?
>
> Unlike say EFER.SVME, VMXON fundamentally changes CPU behavior.  E.g. blo=
cks INIT,
> activates VMCS caches (which aren't cleared by VMXOFF on pre-SPR CPUs, an=
d AFAIK
> Intel hasn't even publicly committed to that behavior for SPR+), restrict=
s allowed
> CR0 and CR4 values, raises questions about ucode patch updates, triggers =
unique
> flows in SMI/RSM, prevents Intel PT from tracing on certain CPUs, and pro=
bably a
> few other things I'm forgetting.

Do we leave VMX operation today when applying a late-load microcode patch?

> > A lot of things are much simpler if it's on at cpu up, and turned off o=
nly at the
> > down path (be it offline of kexec).. no refcounting, no locking, etc...
>
> For Intel.  Unless _all_ vendors and architectures follow suit, KVM will =
need
> the refcounting and locking.  And while it's not anyone's fault, the *vas=
t*
> majority of complexity around enabling virtualization in KVM is due to VM=
X.
> I.e. KVM added a bunch of code to deal with the aformentioned side effect=
s of
> VMXON, and as a result, all other vendors/architectures have had to deal =
with
> that complexity.
>
> > so would be good to understand what the problem would be with having it=
 always on
>
> Doing VMXON unconditionally is a minor objection.  My primary objection i=
s that
> this series does what's easiest for TDX, and leaves behind all of the VMX=
-induced
> technical debt in KVM.
>

