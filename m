Return-Path: <linux-kernel+bounces-827911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C2B93682
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D74179A50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD22F39DE;
	Mon, 22 Sep 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcJHHubY"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AC26AEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578155; cv=none; b=q1UoJupIVI2e7Aeam/FfzJoUen8Ia8Zs1Ccu849JTuUvcjuW18/Y+CUucrk95g1tqWSnhrVSNqic3JD27imbVQmh6VMhtLipyotoXrUMjvAMlQnSgVIIAso5nJvfZjpBbg4tI2YnF/VAjQAhZXTILfbcuBsxKgSyo3Ll77lkjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578155; c=relaxed/simple;
	bh=kTHCUySsAgP6wxXlzXUMsb5ERn8ZmdP+HwnZhOMU5OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWMhw5xQQqpbpVIXQhentsgeR9H2iDmI4cVPibHlS7fyKj3MP2dRLXu/NO0XxfuSihImrjUhDJyOglx2+cJKZyzcvrFuRQQe6lakzOAj9QroavuixvOqQG2EvPE4Yy8iYdhlF2ueCsldSEEcJInwiMtQmENJ4l+wHbKRhcTQ+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcJHHubY; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-59c662bd660so1002621137.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758578153; x=1759182953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTHCUySsAgP6wxXlzXUMsb5ERn8ZmdP+HwnZhOMU5OA=;
        b=LcJHHubYzRgr6iUpbg2WA4eEIk/dnj54//vjuv/my/nw6Md3rh9rVN729mewodU6Pu
         y71eK3ysO/ZRRW+dtAleN6P0t66DCq7dENwku4SEO4FKwXDroGBxFv5CvFWtqG0QtJJf
         Ir6plqZb8Fl78HR5LZOaCvhNb9ObKPbmaVS0cBQQCBxAzUfycB57+3wdZN1RLkAA/JC6
         UmYT7fz4JNzzJoMo9r4sqZns0KMDK1aNxfmcd1UGA/Sw84IYHCk3F6fUpiIWbyq4ViFV
         MwnYNDSxEEnjV6+FLiA/+jZoVPsioLjf9pjfENiqFp0zHC7yFZMvegy9QywqnGIasKRL
         IWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578153; x=1759182953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTHCUySsAgP6wxXlzXUMsb5ERn8ZmdP+HwnZhOMU5OA=;
        b=rJ4srhNL713bIDOm7dj9zaYqL6ofz3qABlWqlPW+t7HJmAeuYkqbF6/tQ7clLWSdSc
         ykGI1a+btUbGAC8JvKDyjazCd0GZEYGpTiiLegmehqgseVdDYp8rPdYg7NWVuCRrb4Pv
         GlCLHFH34sgNc8n64bFB5dLszd3/D1tI6aUZOfXu8N20rpSEg9crKxVYb7AUj97P/uTQ
         mhyCTfx4qmN13P60qPaDJ396XglYkbQvOBgT3N5mlo0zu1Rn8ntkeySrMuVqtODZZvvf
         EHKLmCAkwxxiY6xV/drwwyX/oq4M3uVeSPfoHX87gpmLWQvAfH6BDd1zR+XkOSaLZUzs
         KiyA==
X-Gm-Message-State: AOJu0Yx0E/v4nTMzI2X8nMjDHCUrG5tyovegVSi727CuR1sUNIQyOkNz
	XxgtBMoW1aYljh8hBpC4/ZyNxObUIxcGwhBv4sDyF3XZQED/6cRLcQ0wn9J9seVVSdvtvmaQ3ps
	Y7DBlo1ivuKM9lfRjtYnKA/JMjyBl9zQ=
X-Gm-Gg: ASbGncsCtGF7xOFFBf9sIM3gei7PuewH3UBrpk3x386/mTn6uxk82xi8ZypQnkqZSdW
	83tonoXkavZ1XJ3gmADJs4M6+SOqRwJs2Sk/EiWAoYDmOhP4tlYpXOx81Q7ihxtVCw2MYF3L8JO
	A4vZd3VcrXym2AAtZTis66yzneo/cECQxlJ/ln6eS077BGvzy49jNCPB4NKjWQ/gDqqu4UKHAcp
	R+OeFLgJ///VnQoj9g57aRZbaCNcq05yKW7xwY=
X-Google-Smtp-Source: AGHT+IHOz+8/11z3CO49ka5L80yW5m+VRpGco9UMZ1EjvSRe6ZYReFt5lxYnV62pJwrR5DLMt1AZon5pYHmXn3KDwhk=
X-Received: by 2002:a05:6102:f98:b0:521:ec86:77d3 with SMTP id
 ada2fe7eead31-5a582330312mr174933137.21.1758578153087; Mon, 22 Sep 2025
 14:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <20250921014721.7323-1-hdanton@sina.com>
In-Reply-To: <20250921014721.7323-1-hdanton@sina.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 22 Sep 2025 14:55:41 -0700
X-Gm-Features: AS18NWDwXZgd8togHkyR5VuYzyj7hcNQKVG0Sjq-VJyhnlscuDpAe5Af9RYNnFo
Message-ID: <CAM_iQpXMjFs4LmpRVNqxeBnFp4KxEfgi9cB_Jwuy7VgOSqTfsQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 6:47=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 18 Sep 2025 15:25:59 -0700 Cong Wang wrote:
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
> >
> Could you illustrate a couple of use cases to help understand your idea?

Sure, below are a few use cases on my mind:

1) With sufficient hardware resources: each kernel gets isolated resources
with real bare metal performance. This applies to all VM/container use case=
s
today, just with pure better performance: no virtualization, no noisy neigh=
bor.

More importantly, they can co-exist. In theory, you can run a multiernel wi=
th
a VM inside and with a container inside the VM.

2) Active-backup kernel for mission-critical tasks: after the primary kerne=
l
crashes, a backup kernel in parallel immediately takes over without interru=
pting
the user-space task.

Dual-kernel systems are very common for automotives today.

3) Getting rid of the OS to reduce the attack surface. We could pack everyt=
hing
properly in an initramfs and run it directly without bothering a full
OS. This is
similar to what unikernels or macro VM's do today.

4) Machine learning in the kernel. Machine learning is too specific to
workloads,
for instance, mixing real-time scheduling and non-RT can be challenging for
ML to tune the CPU scheduler, which is an essential multi-goal learning.

5) Per-application specialized kernel: For example, running a RT kernel
and non-RT kernel in parallel. Memory footprint can also be reduced by
reducing the 5-level paging tables when necessary.

I hope this helps.

Regards,
Cong

