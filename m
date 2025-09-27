Return-Path: <linux-kernel+bounces-835076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60792BA6333
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849131898CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652B22A7E4;
	Sat, 27 Sep 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exG53NJk"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C04316E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759004839; cv=none; b=dvGCwVEfCsojyAHOqyIKRnzv345onpXOqY7T/CTAhDb4XQa6/1+B9SuhwjDgH9bCnfhgnOLN4p3BCGGzgrGdKLv8d8eXvoZfoM18qQMTOa2FyJxDJauAegVV1MO5jJETmw01LTrCXsTkrtozoFD9PPoZX+/y1C4kvh2b00f/+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759004839; c=relaxed/simple;
	bh=9iKX971Yzh+vTHTZnyNwti+PFyVkjEP/KuLLQvtNxsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBvKGlO+qtSkavluxtJTK2wR0BqY3H6LWR7GeAg8ygfKNKru+R3DXsPUaVGq27/JqHlyiDyqCoxbzVDRrAFgX+7Hy8DbDJHqAb7jCBlBiCU22c8BuzKP1ne11diOQQ+0rCIGzlXw2K/TF8T7m+0eLkUMiLKUjbKlpHKNy5JnP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exG53NJk; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa30f4093so1303155e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759004836; x=1759609636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iKX971Yzh+vTHTZnyNwti+PFyVkjEP/KuLLQvtNxsU=;
        b=exG53NJk2wgrRI6rXx9j0duxaAdQn3G3dAGzWD/9C6HC26X/jNvuS02JRrZd/2yL2Z
         q4eMv8Sp9J6MvHjhFUrYjNaiivUOjvAfQaoh6cXywlnYBFTr8Z7dK0eJjfkPLD/7HxHq
         cENsO8r0fob18zNLJ4AsJtyC8j6nTRgHPo8RSfxKsc3ry4okn0TqhcQz81IXLeFYRVcx
         o/BY4jXyeYbQdzly71f0AGFuTPEoXSHoVwFZQy/u28670O4BFrJaPWLWLRDHfzsu2Eqy
         ptl9LuQVl47PjmQy1LwEReOHilLDzFcmbrEgdnGi7NHSW5SDdkzu3gMqvn3tt0Xcokd9
         caKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759004836; x=1759609636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iKX971Yzh+vTHTZnyNwti+PFyVkjEP/KuLLQvtNxsU=;
        b=FyAotnxHBPPsT0CT1lBfZ2zhLXIi6ywT6RVNb7yZfEsh7QF7kwOY1i8wD7N01X1icO
         fxHDYrw9/x+qgBvQnP2VRd2OYk5Y350sW2oz/bBRAXX5qRVS4BCvEHwFkSihCXjBFzMA
         Ar3l8ZnVSWXtSaPHkp83VQDDYZgfZxP0aNxgwxrCMpboIf+LR+Fqs35AD2RnRT/k5QvR
         Zaqn1d3nx9lycJBoVhDisdSR4qoIpXDgVunivvtffjR7Z1yv13XjH5K1aNi5V5d7oS8I
         xRtZ3xAC8hxVMYd1ju50w9gQd1uYZzXkk8vawEIqSuU9FPnJji7/kQx/wqGarARRwUH5
         CUmA==
X-Gm-Message-State: AOJu0YzH4qSSNo/9E/244SeVVCiabYMjZo7w4kfgxROm8KSL1sL7NrIs
	N99dsnK4miyTJo6yHd8V9dcPc+lhUHXxYx3IUY9ht4VNJTP7EntbsX78U7M+fhyBpNK40zinaxh
	HA7BROaeeUVeCohtfXfktL0phnQ+nuAg=
X-Gm-Gg: ASbGncvE7/c67B2H7ZvhLvM7wtUV/DO7GBI9vXyqSl1v5kGbjHBLPco9y1u0BjfJTZ5
	GfMq6KL7otgnRS2qMCuJR+yP+felmCu3n5CL5sjeXbSFYJusNPMAZa+Ehzg7JPCAYmzUfI3v12x
	HzJbKilwMkRfCYJ3IGaZTHv/F2dWs6Ml7TOlMhrHGhAUgxcVYcSvd2P78lDDPifyTLf9v1VLv7+
	Z2WLc0fPvBwj/52K0QYAHDtF+UZNm7bHOVXP1G8
X-Google-Smtp-Source: AGHT+IFl7dzGGOpBRgseA/NydkGTFZOWYjWGRoA+aFytHMvygeb0WWmRJxaS+K8TrsIzykl6wViA3ZMadBOP3gnRlPQ=
X-Received: by 2002:a05:6122:202a:b0:54a:a782:47c5 with SMTP id
 71dfb90a1353d-54bea37dc27mr4953333e0c.15.1759004836452; Sat, 27 Sep 2025
 13:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <aNZWTB_AbK1qtacy@kernel.org>
In-Reply-To: <aNZWTB_AbK1qtacy@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 13:27:04 -0700
X-Gm-Features: AS18NWAh5kZoQgB4hGz8PTAEfvsQyei1Zk5nXGW3DAd6TlCiQepkU5cVpkemP2Q
Message-ID: <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:01=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
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
> This list is like asking AI to list benefits, or like the whole cover
> letter has that type of feel.

Sorry for giving you that feeling. Please let me know how I can
improve it for you.

>
> I'd probably work on benchmarks and other types of tests that can
> deliver comparative figures, and show data that addresses workloads
> with KVM, namespaces/cgroups and this, reflecting these qualities.

Sure, I think performance comes after usability, not vice versa.


>
> E.g. consider "Enhanced security through kernel-level separation".
> It's a pre-existing feature probably since dawn of time. Any new layer
> makes obviously more complex version "kernel-level separation". You'd
> had to prove that this even more complex version is more secure than
> pre-existing science.

Apologize for this. Do you mind explaining why this is more complex
than the KVM/Qemu/vhost/virtio/VDPA stack?

>
> kexec and its various corner cases and how this patch set addresses
> them is the part where I'm most lost.

Sorry for that. I will post Youtube videos to explain kexec in detail,
please follow our Youtube channel if you are interested. (I don't
want to post a link here in case people think I am promoting my
own interest, please email me privately.)

>
> If I look at one of multikernel distros (I don't know any other
> tbh) that I know it's really VT-d and that type of hardware
> enforcement that make Qubes shine:
>
> https://www.qubes-os.org/
>
> That said, I did not look how/if this is using CPU virtualization
> features as part of the solution, so correct me if I'm wrong.

Qubes OS is based on Xen:
https://en.wikipedia.org/wiki/Qubes_OS

>
> I'm not entirely sure whether this is aimed to be alternative to
> namespaces/cgroups or vms but more in the direction of Solaris Zones
> would be imho better alternative at least for containers because
> it saves the overhead of an extra kernel. There's also a patch set
> for this:
>
> https://lwn.net/Articles/780364/?ref=3Dalian.info

Solaris Zones also share a single kernel. Or maybe I guess
you meant Kernel Zones? Isn't it a justification for our multikernel
approach for Linux? :-)

BTW, it is less flexible since it completely isolates kernels
without inter-kernel communication. With our design, you can
still choose not to use inter-kernel IPI's, which turns dynamic
into static.

>
> VM barrier combined with IOMMU is pretty strong and hardware
> enforced, and with polished configuration it can be fairly
> performant (e.g. via page cache bypass and stuff like that)
> so really the overhead that this is fighting against is
> context switch overhead.
>
> In security I don't believe this has any realistic chances to
> win over VMs and IOMMU...

I appreciate you sharing your opinions. I hope my information
helps.

Regards,
Cong Wang

