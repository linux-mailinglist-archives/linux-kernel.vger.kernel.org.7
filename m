Return-Path: <linux-kernel+bounces-835078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C41EBA6348
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52678189ADB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20D23278D;
	Sat, 27 Sep 2025 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QbpYDXPz"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CE14A91
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005582; cv=none; b=JzspiNdSv/cPeUHoHjDcH5sKKMdXH9nWWt2W8fCe3ySXlPHi/SbJHUWTusB/40A2WF3MLAkeKn+ZwOLBYygTwFKCD4IpXABN1nLlReq2BqDuUBx8hayLO0+SXop3TJudse9RacdmzUuB++fotz1Sxm+65Wev5X9FMgrMsE334PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005582; c=relaxed/simple;
	bh=Nqm2a1slgwRpzw6giHb6m2YLEyBBuzMrjpXPrRVXwQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwoiXY7/suoQgvzr24/2yGzuXzkxYU9rQDuLNl20o+knbwxPwZkCIFFjMR1TOe2gt5pzxLQ+ZToiur6w2QPBuv3O7FQ5pH1W0IxPApywLbrHnaSy6AgGw5Oa8xCwEH3WZ2PwylLT6XH1gOXr4lP6UTzW4Vyv4e0ggD1iWW0GgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QbpYDXPz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4de8bd25183so21231181cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759005580; x=1759610380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqm2a1slgwRpzw6giHb6m2YLEyBBuzMrjpXPrRVXwQ0=;
        b=QbpYDXPzB0AVGdf8VZ419BePsqIKYlHx7zjYKCbqANGhL4HS7ClAPtUZQSqu6BdIUK
         jcQsFtNyLvVTQi0/XzdqxBKcM/DME6ol0Zf535kYvgOiE3dPTfMQLJZap2oe9LhBU8zg
         hF8EqYQl5o0qLvnrRfrIv8ziu/XS+MO9aNPTjRSkgsIv0VXECK4NFhCaovhTxfZDM/+w
         XXHZZDcqgxjxno6FhFiOkcfzjWgsRV7uVbrUQAoI4cpzwxyRXLK6mD90prYvr82MXRJR
         jbwVUxs3GnF0yn/LAM8Am0XJvkCmIKADPVjvRcsBIlJamRukvfQjFxDBxrFoT/aL+E+Z
         7aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005580; x=1759610380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqm2a1slgwRpzw6giHb6m2YLEyBBuzMrjpXPrRVXwQ0=;
        b=qhjs7rSAm/pLo9CoVsbZrMbJd48n4h6ksKy6Mkx1A5aSanjG930YCEYWE5WTV71FYG
         YUCn3K+/uWq7vLZyATxtiA61yFCjtaqM/xheG/xcH8Dm6/ez0rNr74Z16w3LREYxgfeg
         3xon4rZNXQV1S8PVABZjNKU03GuLNnPV9Ypa3K6reqMZ1MxYUVUZvN9fNuTiUO9bNNKn
         k88t5sRu1OzF370lBO2WxZo6bYNxNVkzxJ3ATJIVbXtS3KPCwTAd9jgdvpWw7LZIy2s3
         NVBr816EdnCDEjmw7x4Od5cNUWt/mYuun4HrzL0z7NCcqM55qI8ottS4DDfkFuomd2qH
         cbZw==
X-Forwarded-Encrypted: i=1; AJvYcCVWyTry167jrVZIwflnQN2JQR4+ImEnvDc/FV1lyw0veALCeZkPZd10EP9Nmi5IpGi9AjX/3s08RGVROOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWzrX/6SmQGEU0fBYpyK+X5rPJOSI7mVZPpCuTO/OxNAubQHH
	Z8du/yNSf9dL5VvV1AoTvPGUDEZUtZE2arPq8Fv71zluGYuU1maYKlhaIa2rWxeuZqmzZmWyTqs
	Ea0ROwQ6i80J91vqel0XxaO9B0xGjGZP5xwGy+gk5VA==
X-Gm-Gg: ASbGncvf7ob3vXa/hyC75Pk2kZT/O1WyIQnbCO84COzM4lsjBBOhCODO9Wr5ofapSii
	pgHJFY44aBHtfdnCAyPt9xfJQsBk/GmDVh3lkKUbajkOqkC4O8Bo2aLSv/iSk7X+PIZCeDcLCEr
	CSL+ozdC9pqI947aXLc2D7+48SPSaK8c1XSzhrDoj8GJ7Btv8Ik7u2ktYBmiXMfI0SM2atxl0aC
	drUl15m/zCaQ8RCroDd1LX/Rg==
X-Google-Smtp-Source: AGHT+IGBzy4xKVonjD75U3bFZeJHdh+aNj3HgTEf2iQJ6Ivdld2/QWu42FO96m5+KzxRvbcmbaVonTr0xtmksT79s30=
X-Received: by 2002:a05:622a:4cc9:b0:4cb:102c:56b2 with SMTP id
 d75a77b69052e-4da41e113ecmr158400271cf.0.1759005579868; Sat, 27 Sep 2025
 13:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <aNZWTB_AbK1qtacy@kernel.org> <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
In-Reply-To: <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 27 Sep 2025 16:39:02 -0400
X-Gm-Features: AS18NWAcl8Gu_k5gDYsA34u-oRSTQGnYnzR7vJJapQMSC9amp96YmIxuBqedkv8
Message-ID: <CA+CK2bCFBOVQnwvRePHRkDqdh5rA+QYrkhqvf=ZiHu=yicShAw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 4:27=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Fri, Sep 26, 2025 at 2:01=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > This patch series introduces multikernel architecture support, enabli=
ng
> > > multiple independent kernel instances to coexist and communicate on a
> > > single physical machine. Each kernel instance can run on dedicated CP=
U
> > > cores while sharing the underlying hardware resources.
> > >
> > > The multikernel architecture provides several key benefits:
> > > - Improved fault isolation between different workloads
> > > - Enhanced security through kernel-level separation
> > > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> >
> > This list is like asking AI to list benefits, or like the whole cover
> > letter has that type of feel.
>
> Sorry for giving you that feeling. Please let me know how I can
> improve it for you.
>
> >
> > I'd probably work on benchmarks and other types of tests that can
> > deliver comparative figures, and show data that addresses workloads
> > with KVM, namespaces/cgroups and this, reflecting these qualities.
>
> Sure, I think performance comes after usability, not vice versa.
>
>
> >
> > E.g. consider "Enhanced security through kernel-level separation".
> > It's a pre-existing feature probably since dawn of time. Any new layer
> > makes obviously more complex version "kernel-level separation". You'd
> > had to prove that this even more complex version is more secure than
> > pre-existing science.
>
> Apologize for this. Do you mind explaining why this is more complex
> than the KVM/Qemu/vhost/virtio/VDPA stack?
>
> >
> > kexec and its various corner cases and how this patch set addresses
> > them is the part where I'm most lost.
>
> Sorry for that. I will post Youtube videos to explain kexec in detail,
> please follow our Youtube channel if you are interested. (I don't
> want to post a link here in case people think I am promoting my
> own interest, please email me privately.)
>
> >
> > If I look at one of multikernel distros (I don't know any other
> > tbh) that I know it's really VT-d and that type of hardware
> > enforcement that make Qubes shine:
> >
> > https://www.qubes-os.org/
> >
> > That said, I did not look how/if this is using CPU virtualization
> > features as part of the solution, so correct me if I'm wrong.
>
> Qubes OS is based on Xen:
> https://en.wikipedia.org/wiki/Qubes_OS
>
> >
> > I'm not entirely sure whether this is aimed to be alternative to
> > namespaces/cgroups or vms but more in the direction of Solaris Zones
> > would be imho better alternative at least for containers because
> > it saves the overhead of an extra kernel. There's also a patch set
> > for this:
> >
> > https://lwn.net/Articles/780364/?ref=3Dalian.info
>
> Solaris Zones also share a single kernel. Or maybe I guess
> you meant Kernel Zones? Isn't it a justification for our multikernel
> approach for Linux? :-)

Solaris kernel zones use sun4v hypervisor to protect isolation. There
is no such thing on x86 and arm.

Pasha

