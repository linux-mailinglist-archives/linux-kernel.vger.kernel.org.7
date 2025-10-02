Return-Path: <linux-kernel+bounces-839809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04333BB278D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 06:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8761C4DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 04:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477E1C5D59;
	Thu,  2 Oct 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzHaU6Iu"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE379CF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759378638; cv=none; b=MB7L40xTbw3YXOSRLPl4HHNdct8+0hcVJAuMAdpmSZYbQPFSyxJmpGLElGeytbs+ChXYnvfOCEBXrD1ZCvCNt0RdW1kIAPtJUCEBrM2/SaR0Av9RrXUKOBVOB+nR0m0AfgozTJiyPORjfn0KjyWHOmYj7oeMBure8w90Ygn9DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759378638; c=relaxed/simple;
	bh=ctQddUgZm+88vHmtPzUekOskf2BJsO+AnrtcChvOlmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWQLmUTpT3jGhFhas1GBDV8W23cRyRg1RDSCWOlBrbdqJDOkj3gNDs5KaLSmt8zRXOLQdvmhL5BZs8xR30cGzDukQ138cZCd+THId7o5w+CnBfdfc+kM+OlvAGSVZ7jEdcPVOVrx8pcinmqtKiANNMFHu9y9hpYz7oKaP88T8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzHaU6Iu; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-58de3ab1831so623643137.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 21:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759378634; x=1759983434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctQddUgZm+88vHmtPzUekOskf2BJsO+AnrtcChvOlmA=;
        b=KzHaU6Iu6X0WFjEHN18TskRGBspqJmZIxR0MBT3G4JQjRuNGbYq+M1mgM7jHIdKaF3
         hmjqYOycGR4LUuXD7mT9T7phwELr58pFHs1FwAHf3ZeS3wUcjjPukmlhh3C/DCwT15jZ
         Uh86fBVfokWg3HSuYTnKtFbNUsylN6zXKGAyb0YOe4HZuHAG3wFXxEpJTIz89bW3iCIl
         3XyA3BOxm8sm4qcfz9Y+fQ/yHDRAvJqZjSHOoIKZa4d7UyWDfmCTahz/F/5mxPDfoVTf
         mB+xQ9N8s/gQku6SsqaizJUbwGk+d2tMT7kCjzrXXDgYgaEXNJaLY8qEHIRaa4HqoKef
         fuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759378634; x=1759983434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctQddUgZm+88vHmtPzUekOskf2BJsO+AnrtcChvOlmA=;
        b=joyRs7hk53to8XkXBcIJAZVMh0JA+ZpCyeYUN6O+Cd91aNg88u/RgkMxkiJxKgK67J
         5EFybWfatU5Me5Iqkju1nP8nfEX1m7uSNQ0Qhxlw4JNu/FJF4a9N/xCSKMHyyRg9ZAYc
         ItBZzsT57usemOzTnfQjnB0kZExd6CAfPke21psoLRC6gzO+z2XENCS/7lztF962VfWU
         RZGMuPZ1WuTAOHiYHsL23uoLhHHf+whIac2IoXrZiH8K8bVTTa3xQS7kL7xyn9Jc1fgm
         uNOahSrsUKtJASoMzXFXxFgeV+G4yub4FCVtdQwEDDGffyPZnYjArxAWlmi9X2sYJ3pf
         56DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKbg4GS/SRc9VYGuKfNBY7U+xWpxP0AxqqYOntiVeEKiKI1LtiYS3r2h62Fst12VYpmp/erB4WuKRwx8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdPTOGFuMdeBvIUJY6Ym0n0aDYaMfrLwLSB5QR2FWX1bDhGNS
	f6Yi7sikS3PfJ3sLcpzQcNZKUiWRKOPpPq08MOmKEImjlTZZJTpzqeWd+qpGLMi4uzHjpqWyMjV
	ktx22HbGe4J+nsUvDuqWtlJEfervLIpQ=
X-Gm-Gg: ASbGnctdVtpiQPzieEBpdlvrnJyVQr29Pl3pOMNSDOVGLJvTprL+vSy7mTP7KbhHDik
	4By2OC+JcomV1ZBpO76hJSsEVYIVLz4zTCTpdQQl6V/mkLQOulr3B32v3QUHkCuPYYcWY5gFB4M
	ytH/InZNKNwiCd25JBh+Dasi83+x2ztvBbPZE1tUjXfXw0HOYT70aitj6wkkBPnmShY+fkPG+0v
	p/nMDMCF3Rm52/k3rkQjE53zDx6bruvi2Z51eSrIgnGRCL9WSNMYd5rOMmd1Q7RTtNRCpy6GvQ=
X-Google-Smtp-Source: AGHT+IHtvWQt8jonztmIlXZVLrosCzlBFZCwfKRU9/rXACxnEYGw3JcofNOIt435bpI1Zm7zqg5PCoJh2gMscknY7Rc=
X-Received: by 2002:a05:6102:41a1:b0:59d:b0f7:664c with SMTP id
 ada2fe7eead31-5d3fe7043d6mr3036274137.35.1759378634290; Wed, 01 Oct 2025
 21:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora> <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora> <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
 <20250924190316.GA8709@fedora> <CAM_iQpXnvyZWrv4W45SBTDV-tCXU4Fz1=S8z_0s5en+U29vSZQ@mail.gmail.com>
 <20250929151149.GB81824@fedora>
In-Reply-To: <20250929151149.GB81824@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 1 Oct 2025 21:17:02 -0700
X-Gm-Features: AS18NWBSFERQychThKDKhC7xP4aDfnWKA8U5c5GLpDIk74WF-1WcxMsDvgDcjOU
Message-ID: <CAM_iQpVRruWNnMtP2BKfQJrHnA_B+ea84GbO_C2rF6cuJcj5_Q@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:12=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Sep 27, 2025 at 12:42:23PM -0700, Cong Wang wrote:
> > On Wed, Sep 24, 2025 at 12:03=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > Thanks, that gives a nice overview!
> > >
> > > I/O Resource Allocation part will be interesting. Restructuring exist=
ing
> > > device drivers to allow spawned kernels to use specific hardware queu=
es
> > > could be a lot of work and very device-specific. I guess a small set =
of
> > > devices can be supported initially and then it can grow over time.
> >
> > My idea is to leverage existing technologies like XDP, which
> > offers huge benefits here:
> >
> > 1) It is based on shared memory (although it is virtual)
> >
> > 2) Its API's are user-space API's, which is even stronger for
> > kernel-to-kernel sharing, this possibly avoids re-inventing
> > another protocol.
> >
> > 3) It provides eBPF.
> >
> > 4) The spawned kernel does not require any hardware knowledge,
> > just pure XDP-ringbuffer-based software logic.
> >
> > But it also has limitations:
> >
> > 1) xdp_md is too specific for networking, extending it to storage
> > could be very challenging. But we could introduce a SDP for
> > storage to just mimic XDP.
> >
> > 2) Regardless, we need a doorbell anyway. IPI is handy, but
> > I hope we could have an even lighter one. Or more ideally,
> > redirecting the hardware queue IRQ into each target CPU.
>
> I see. I was thinking that spawned kernels would talk directly to the
> hardware. Your idea of using a software interface is less invasive but
> has an overhead similar to paravirtualized devices.

When we have sufficient hardware resources or prefer to use
SR IOV, the multikernel could indeed access hardware directly.
Queues are an alternative choice for elasticity.

>
> A software approach that supports a wider range of devices is
> virtio_vdpa (drivers/vdpa/). The current virtio_vdpa implementation
> assumes that the device is located in the same kernel. A
> kernel-to-kernel bridge would be needed so that the spawned kernel
> forwards the vDPA operations to the other kernel. The other kernel
> provides the virtio-net, virtio-blk, etc device functionality by passing
> requests to a netdev, blkdev, etc.

I think that is the major blocker. VDPA looks more complex than
queue-based solutions (including Soft Functions provided by mlx),
from my naive understanding, but I will take a deep look at VDPA.

>
> There are in-kernel simulator devices for virtio-net and virtio-blk in
> drivers/vdpa/vdpa_sim/ which can be used as a starting point. These
> devices are just for testing and would need to be fleshed out to become
> useful for real workloads.
>
> I have CCed Jason Wang, who maintains vDPA, in case you want to discuss
> it more.

Appreciate it.

Regards,
Cong Wang

