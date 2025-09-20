Return-Path: <linux-kernel+bounces-825912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7261FB8D179
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A44E00C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F027F183;
	Sat, 20 Sep 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEG6ff7K"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651327A906
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758402841; cv=none; b=Ai/wDFPzK2H1visR+fXjYXok183rO0e7gkWMWKM8ITI2zjO7QB2J2FlQoyQiEDI/vOqi6qCNEERj9CVTfTQVsi+pW5mmn2QBuy/0ZEo79Z0gf9jZCTQe/goODRyQocIfO+cUgpP+8Z2KBFqvtGWTsiny1Cj+lyrECJ5aTcASNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758402841; c=relaxed/simple;
	bh=QeMZgrvO+7K48mkRFOLItjYhggfVYSiAcetFREUSsTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYNwezhvn4BzSu2wsooCWkdcnmF09z4Yyme4xnsrpgJREuonHrhr1O2NJnWrYsLEVpf1rJZuHHA7Nem59jm8vh+rBhdpPZTg0gLERZvvCJ/2OH0ji1VPeT/p3WQoJ30RsSnTPSoMf6iDdFt+nqKiwgSSNqDWaGDd9lwG27y34VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEG6ff7K; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8a967f3a873so1270992241.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758402839; x=1759007639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UIugca8SZaxMzP/24yjEddM7n8Al4cXmz5gSsZCJUE=;
        b=aEG6ff7KggpyCSkOyowvvOdTxaJFIAomr7vrmCQ4TMmy2i1LNEHk4NxFoI89LtYRoW
         ZS0oA6a2dzsN6acbnth6XTZSVCDgust15BzEx8wDYmJODDcwKFODITkMOBDqhn8zOia/
         GTLkK8lJ0U7NtIWnjOeLG09ibNg6kAKH7fY+AOHN90BaI7qkQn1Zjv3tqomIZrldo6Ep
         tXsTvb88ouD3EV7y9t0VM5BwCEcVQhcBoC+g5MEGUdnANbVE1hWHzPQhoQqpDOILKaGD
         uLca02j16Y+AyMuiYNRmgwVYa1mmJI6lMF0tN+GN/jAQgQF/k6rx4luaMUgNWILZTAGi
         9hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758402839; x=1759007639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UIugca8SZaxMzP/24yjEddM7n8Al4cXmz5gSsZCJUE=;
        b=iO4+Y6fGmqUFl2p2jVrqy+TJeYTobNETU9iz2RyYmQW4sEZ7W+cJ9HKXhhYn6nuYcM
         eAU7x+Rb1FZE7VtxoSF8Fz0qx4jjbgW5pjKDK7/JfcDluw555uezYZLlNM0Z2FEdHSOV
         flyaE+Wql8A3Qa27R75BLOxo46ORz9kRpQFj/YgDsMpaAyS+pEf7c7TDlQ4BTMqr0Reb
         rAEm/JDbQMK2LWTPkLmBjmdzkZILJEzSZM/lBweZphQwxZzN1/zGQ2qtR20kcaZflE4a
         3eDpsX6hoh0Z20AfhOiriNZ6ir+a86MbU0BvyZvcWRd29+JmWRi2YtjdF6tzs3/BCCFy
         /6zg==
X-Gm-Message-State: AOJu0YxaNI9XnWbdtti0FiPtAIurEx5HvBljkr3X23DtSeOTTMdemrHa
	c5y8G42XcAErrDHg8A52Lg8ozXiUenfZHMZWcyBfNlJIo2xVYTrHIzQGqgtAgW9RMM72SC4bmS9
	ajXJVunha5SwmEeToNmoJ4UkfCEajq0k=
X-Gm-Gg: ASbGncurvpVf8TnBgrA6I/9HwO2dEPn7zi1eZRJAmdyiribfa4LH98CaAJywvR3htUI
	vp9NRR+do9Kxf1saz/0VWzMLOci5QZPmwRrXlowtnNphydHBdp10+ByN1CDkp0PJan1OkBVN4UR
	GBM0dU6ux/Hy2HR/2rmTeKPdja2dqdrPvbT32Xb4q+rVi8ys5xi/Yre8sb87v6qS2hKIMKqJG0a
	eRROGn1dI4KRLurzfg3F31cqeQx2Q9BHJujjjM=
X-Google-Smtp-Source: AGHT+IFvnPA4h7T1ZUVtn4JDNMPpiPFDn9Yh1yg75Ylw2qMBHo9vNQ/p0Qj34UE2hbDoZxw+1L238MnfW2TU2rGaUKs=
X-Received: by 2002:a05:6102:3e06:b0:55d:34c:f231 with SMTP id
 ada2fe7eead31-588f9cfbf36mr2475265137.35.1758402838660; Sat, 20 Sep 2025
 14:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <CA+CK2bD3D_XFu1E60qBYwdDzK0c7_bN0BkGBE7h6h_sxmmfvAQ@mail.gmail.com>
In-Reply-To: <CA+CK2bD3D_XFu1E60qBYwdDzK0c7_bN0BkGBE7h6h_sxmmfvAQ@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 20 Sep 2025 14:13:46 -0700
X-Gm-Features: AS18NWC0ac3RYhgSaViFSOyGBJe0fdwa4OEZ_zquyfPSWFlJlyPiOoaLI9mEwmY
Message-ID: <CAM_iQpWmfkB9VPdV=sCcFzUm71my1bWFL7G+QLtYGHpe3oPHAg@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:14=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, Sep 18, 2025 at 6:26=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
> > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > - Potential zero-down kernel update with KHO (Kernel Hand Over)
>
> Hi Cong,
>
> Thank you for submitting this; it is an exciting series.

Thanks for your feedback, Pasha.

>
> I experimented with this approach about five years ago for a Live
> Update scenario. It required surprisingly little work to get two OSes
> to boot simultaneously on the same x86 hardware. The procedure I

Yes, I totally agree.

> followed looked like this:
>
> 1. Create an immutable kernel image bundle: kernel + initramfs.
> 2. The first kernel is booted with memmap parameters, setting aside
> the first 1G for its own operation, the second 1G for the next kernel
> (reserved), and the rest as PMEM for the VMs.
> 3. In the first kernel, we offline one CPU and kexec the second kernel
> with parameters that specify to use only the offlined CPU as the boot
> CPU and to keep the other CPUs offline (i.e., smp_init does not start
> other CPUs). The memmap specify the first 1G reserved, and the 2nd 1G
> for its own operations, and the rest  is PMEM.
> 4. Passing the VMs worked by suspending them in the old kernel.
> 5. The other CPUs are onlined in the new kernel (thus killing the old ker=
nel).
> 6. The VMs are resumed in the new kernel.

Exactly.

>
> While this approach was easy to get to the experimental PoC, it has
> some fundamental problems that I am not sure can be solved in the long
> run, such as handling global machine states like interrupts. I think
> the Orphaned VM approach (i.e., keeping VCPUs running through the Live
> Update procedure) is more reliable and likely to succeed for
> zero-downtime kernel updates.

Indeed, migrating hardware resources gracefully is indeed challenging
for both VM or multikernel, especially when not interrupting the applicatio=
ns.
I am imagining that KHO could establish a kind of protocol between two
kernels to migrate resources. The device-tree-inspired abstraction looks
neat to me, it is pretty much like protobuf but in kernel-space.

Although I believe multikernel helps, there are still tons of details neede=
d
to consider. Therefore, I hope my proposal inspires people to think deeper
and discuss together, and hopefully come up with better ideas.

Thanks for sharing your thoughts.

