Return-Path: <linux-kernel+bounces-830978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C61B9B0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC06380A32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763B314A97;
	Wed, 24 Sep 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5x9m94t"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B4314A64
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735043; cv=none; b=HelX/vHC9n2BgcWyyDQgyFcbp66xayMNBVbLtkGYoMIKemcYYbS+CRp+RUWOSWc7wrwAZdAt+VUnVo9xGXdUWlVr+36oEgspI0XPXEH2YCCD8HOcGdw2T9QKoUpRmN18rKTbivyJOigIx86Xlo7JstF+T0YScRpctnNVBMjIDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735043; c=relaxed/simple;
	bh=5k4yjC+BSG1p1WXbj5tLbzcQV6kbIE3+SfAB1tB9E6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7tegggMM3Hb0RVblKLD/5jlP73KMgkFuMdUpXRJS6CmEXdsrQLrynT3EtEgGKwK+ZMbBaGNVaWrnktUlq/Wwto5NXXYAuHW29uAPz760xlCXr68a6EYyO7iP+oHBSQT2hL/yUs50eH3Mr91srWyO7hF59fzeBVU3rzGecSa5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5x9m94t; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54aa63e82bdso73929e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758735040; x=1759339840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k4yjC+BSG1p1WXbj5tLbzcQV6kbIE3+SfAB1tB9E6M=;
        b=O5x9m94tfdv/HKkDRSzx+t3SsvHAbEqPj/mclpa275bGdEAtQfASRdW73KKZ79rwUC
         u8e9cyqjpsl+zQB/NjXziX4vY2oomalsZSRQ1NUaPxfwbVt49wCCai+6Nubrkn/YjGF8
         pPbTd15Orb9Qn8jszuU3zfDszuog5rywTBeyyvkwWvuAFm4iDUIRc5nB4msRPiKezsEI
         0BnZo6Dr7wugmP61SU3X0/FTHZOzaeQkNxCpyhE59nNIb6F4bTokUj8n/v33dYFIzSdE
         bR1zKc+UNgD4bW3PSQ+AzXWkH1xqRkK+/8oHOoZQQsipMck1FgpDXoXq86qaLubVSnC7
         U0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758735040; x=1759339840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k4yjC+BSG1p1WXbj5tLbzcQV6kbIE3+SfAB1tB9E6M=;
        b=mbj/hWa5/BbZEKM6RivyJlSju1mPztnVUCwj5v8nZvzmKavzEc6sNn/piqSsmun5xw
         HldIWfqiI6/A3e6cIfAI1JbzrqTt5TRrUMUZtdmJ+JCTQSXGpYAIzH/KGN8WvsFgg8vM
         U0h9JuDBOcKWtRoQmrxQS5+qxJdEGOWENgxx/wka6PT86zzA1Gf+IWNu+FgNZ4Gx4cIw
         kll30BMTdKKyTlhMgtB2XfaEV2vCX85lM8muZ4KPiXSPyZYXMBo6UHeTHiK5P1Xz7f7f
         kGulykicasKejWesCZrnn1MzEon35Yqt2Bmw8zihE/J1ut/a28VNLfVl2AMPY9bgqQgF
         MQ3Q==
X-Gm-Message-State: AOJu0YzE9n/UAi55aajz/rZCg+FIbH4tcMJ/lHOZ0ucM/KKmxnvVb5xB
	MLdhsy+JMSXHCuM0X3mhvl/RAKAR/cel1HyDP+yaDJeP6a0plSLtEWk4ykOekDl+ceKQEWfqxgK
	n02mSKigPXZL47EuCEQ8qUdTxoMX1l08=
X-Gm-Gg: ASbGncvMOtbMCWGC289oVGnqKchIVh8UaTV33CSKSr65l7QnogKifxW/OVmB6De8Yl7
	GiOVMCTkZ3Pg0NCG5VbKC/72LiWWGa+8S8uhI9Y+wVtaHgjcIq8fAE+OJihB5dUPNiUwyaMEiJi
	CLT99zsEfAEjnFZepqwn8jzb4UvglmgQ3ScX2lCOmbGsf6qmzYKRfyWbG/zvDK7VD8j9ULcEmAi
	MXpYQUlP5I3hIxEASMurmG+10S4nNqsnK3EMAM=
X-Google-Smtp-Source: AGHT+IHRUpk+l43lUEkfSvsxG/gFSXsSmy0Yb679EkTBjMcSGGxPm5euPRNwbWLb6UIPoPzyECrG67GnQN0NLXcRGYk=
X-Received: by 2002:a05:6122:a02:b0:54a:71f6:d570 with SMTP id
 71dfb90a1353d-54bea048358mr462955e0c.0.1758735040012; Wed, 24 Sep 2025
 10:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250921014721.7323-1-hdanton@sina.com> <CAM_iQpXMjFs4LmpRVNqxeBnFp4KxEfgi9cB_Jwuy7VgOSqTfsQ@mail.gmail.com>
 <20250924011237.7568-1-hdanton@sina.com>
In-Reply-To: <20250924011237.7568-1-hdanton@sina.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Sep 2025 10:30:28 -0700
X-Gm-Features: AS18NWC4qMXjcqYtqwcv8qlLfwmYuF4gi5abMG-3xTy48-aZuz-HQ3CPl9ywuBM
Message-ID: <CAM_iQpUwm0wOQx3Epo-5MmkfwZmLsehx6HmABNwzqpRNiPjTmQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:12=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 22 Sep 2025 14:55:41 -0700 Cong Wang wrote:
> > On Sat, Sep 20, 2025 at 6:47=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > > On Thu, 18 Sep 2025 15:25:59 -0700 Cong Wang wrote:
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
> > > > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > > > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> > > >
> > > Could you illustrate a couple of use cases to help understand your id=
ea?
> >
> > Sure, below are a few use cases on my mind:
> >
> > 1) With sufficient hardware resources: each kernel gets isolated resour=
ces
> > with real bare metal performance. This applies to all VM/container use =
cases
> > today, just with pure better performance: no virtualization, no noisy n=
eighbor.
> >
> > More importantly, they can co-exist. In theory, you can run a multierne=
l with
> > a VM inside and with a container inside the VM.
> >
> If the 6.17 eevdf perfs better than the 6.15 one could, their co-exist wa=
stes
> bare metal cpu cycles.

I think we should never eliminate the ability of not using multikernel, use=
rs
should have a choice. Apologize if I didn't make this clear.

And even if you only want one kernel, you might still want to use
zero-downtime upgrade via multikernel. ;-)

>
> > 2) Active-backup kernel for mission-critical tasks: after the primary k=
ernel
> > crashes, a backup kernel in parallel immediately takes over without int=
errupting
> > the user-space task.
> >
> > Dual-kernel systems are very common for automotives today.
> >
> If 6.17 is more stable than 6.14, running the latter sounds like square s=
kull
> in the product environment.

I don't think anyone here wants to take your freedom of doing so.
You also have a choice of not using multikernel or kexec, or even
CONFIG_KEXEC=3Dn. :)

On the other hand, let's also respect the fact that many automotives
today use dual-kernel systems (one for interaction, one for autonomous
driving).

>
> > 3) Getting rid of the OS to reduce the attack surface. We could pack ev=
erything
> > properly in an initramfs and run it directly without bothering a full
> > OS. This is similar to what unikernels or macro VM's do today.
> >
> Duno

Same, choice is always on the table, it must be.

>
> > 4) Machine learning in the kernel. Machine learning is too specific to
> > workloads, for instance, mixing real-time scheduling and non-RT can be =
challenging for
> > ML to tune the CPU scheduler, which is an essential multi-goal learning=
.
> >
> No room for CUDA in kernel I think in 2025.

Maybe yes. LAKE is framework for using GPU-accelerated ML
in the kernel:
https://utns.cs.utexas.edu/assets/papers/lake_camera_ready.pdf

If you are interested in this area, there are tons of papers existing.

>
> > 5) Per-application specialized kernel: For example, running a RT kernel
> > and non-RT kernel in parallel. Memory footprint can also be reduced by
> > reducing the 5-level paging tables when necessary.
>
> If RT makes your product earn more money in fewer weeks, why is eevdf
> another option, given RT means no schedule at the first place?

I wish there is a one-single perfect solution for everyone, unfortunately
the reality seems to be the opposite.

Regards,
Cong Wang

