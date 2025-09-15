Return-Path: <linux-kernel+bounces-817813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D026EB586D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B51C1B246C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817529DB6A;
	Mon, 15 Sep 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWryTFIm"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13128D8D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972245; cv=none; b=bTbyjzqS7QQhAMugFT7QJsPGDMYaqZvQm37i1+jcNNHMpabqJkrn+85qbPYuyt8i5ALYbeZBmJXXKuFgmKdtXVW9S9csl/6cYPgEfVgO/sNgbln4fnu2bUoCQMjj4BN9AjF4JPVDAVnccTVlut/2nJSv3pbUnFqi258RDiZ9w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972245; c=relaxed/simple;
	bh=DJ1yQU+46cCei0IZcPQ5UVD/tR0uFMzgc1ttjjlcKME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWM6uvkwMdcZ7SGHZBspb+oA4TM8wNEIPX28cSi+tS50H83R1A5oYfRfDTVSblW2YafoTfLduL0wSvqod6JKT28zwqi7gI0dA4uYI96qokdtSHtVUKSlr4NeCUpbsg7kPo9hNpxTR5H9Y7gNNNXz0gGCoKjBoyI2Uwgezmmf93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWryTFIm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso6132362a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757972243; x=1758577043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJ1yQU+46cCei0IZcPQ5UVD/tR0uFMzgc1ttjjlcKME=;
        b=bWryTFImWI/3jV13CZ6OsFnsblzfYV4ZacBsRrDUdMmxkyXfiB/PtcaXv3CTUFQwNG
         qgnfY6d8sybvM3s+rlrtA7wf54KtWaxwh8CnLkygY5nXGbYPg/AEFurqcSakbnZVtjwY
         tS0mn+qofNoTclrJbhD66YwT70WqX/iyYVVwzxrtbS/Dfg62GunrbO1xFvIqufEaWeSx
         CRMS5BT8uOOU/Qyt0QkitrXBTRObn+aZjJdV9PkdmDBuhajJrJNQeLtRizE8GXlzJZZB
         GN3iLI3F78ZiqeThta3aieVw+igz56UYqRHczeStx0wj8OY0ACvwkaLXqc3oiaQqcon3
         jlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757972243; x=1758577043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJ1yQU+46cCei0IZcPQ5UVD/tR0uFMzgc1ttjjlcKME=;
        b=FneCJzTKVi6kBzgvGFIy1qGIfYTfi1Zq82Y5579MLxl86K+ptTq3MH3dZMA9ZBWIy0
         DMVaxkBmwN3fEJIoHmyPvWiTVm2+M0VdDqikLCKTPxC7N6ynW59WvbNA7VfDXroOM0Fa
         9yhG3OzCe70EIS3dfbAvdNnXHuFrZ//gCcrL2P+/ua9DFyoShjsoFGJIMYnsUuu/aLcz
         VcMTnfkE8f4OzzTrkEjrR0UgEsD4pYRluXfYedZqWzfxUxJZjLRO558hmPD/bVHTC04n
         kAx8UX5FVb48n8AQHhlHbd2ry7K8PTnGvaX+qJoXvRCPsmzULfbkWHQox5nEZ4gdfjsc
         kVYg==
X-Forwarded-Encrypted: i=1; AJvYcCVffmIjEKQtjjF3h1QP616ikhiIAN+/TXD52X+rngLtQ3xoToogKTbSVWoogFeBjtXMSMSN8/graNfdfLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOZdhO+iqnSZMynOSKdbtJGmO2cMZ89CdMxAWo6Xmy5/zYuCw
	0w0EexY259sHD7qd2yUw0iLCH+HVl+8qD0oG4FdbkXvGwwHa1HOdvkL9
X-Gm-Gg: ASbGncuSMy39JqKdM6IVZrol3KXeC702VTzkyaba2nhPV+b13wLO6vK62hf0k5q6otz
	0JTkUNW816ygOkZcnfBs30RlX58DcFbW6WSQX+nDxXI/vFLG71ZLR7Pq4KCWEzc/aBc2gwCC4G/
	mePFSd7IfoXWNuXh7WzxU5326xg9iNq8B7wBbD29axfNwBSrU2W3jjXzMlOsJhXm4ti2uhr8jL1
	Pat23c1PVX5QDvnzS0lAEDcSum9fmM/SSeZlfg/E/kAO48EWCaAzoatNmJpvBH8J0NdP0JnLIM2
	Z1nzVTXrMHNShWuZsDsE0bO2DJ2UQLfKxDf+6MTseq7ohM+A+3wpPSPh3zTrsKGrpwxZx9sovGj
	ne1+Q156ODCreWcQvBvHabeA0L3XZclQKOlZOdNofsGOI5Pg7tfzI1LT019g2
X-Google-Smtp-Source: AGHT+IFfBqyi6DinH8aK1CrKezF5SSjD+j8kk98LYlSl2lDxgnVgV78RqDPTjc8dVlgIIWjUMVwdCg==
X-Received: by 2002:a17:907:6d08:b0:b04:26a7:f77e with SMTP id a640c23a62f3a-b07c3869126mr1366969066b.51.1757972242454;
        Mon, 15 Sep 2025 14:37:22 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da27esm1038092866b.6.2025.09.15.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:37:21 -0700 (PDT)
Message-ID: <7d29cca832103f70584a9bd88c32b77f508e9045.camel@gmail.com>
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev
Date: Mon, 15 Sep 2025 23:37:20 +0200
In-Reply-To: <32bc2a49fabd619ea7dcafd7f5d50fca206b38ac.camel@linux.ibm.com>
References: 
	<7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
	 <32bc2a49fabd619ea7dcafd7f5d50fca206b38ac.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-09-15 at 18:44 +0200, Maximilian Immanuel Brandtner wrote:
> [...]
> As I already mentioned in the QEMU discussion, I proposed the fix,
> because I was working on a similar implementation to bring resizing to
> QEMU.

I couldn't find any mention of your implementation on the QEMU ML.

> Unfortunately, the patch-set was stuck in limbo for a while and
> now that someone else has picked up the slack, I've descided that it's
> better to contribute to the patch-set that is upstream instead of
> sending a competing patch-set that does the same thing.

Would it be OK for me to take a look at your WIP patches? I would like
to see if you did anything differently.

Also, you mentioned before that you were also working on patches for
Libvirt. These will still be useful, because I won't be implementing
that part.

> [...]
> I don't really care if this discrepancy is fixed one way or the other,
> but it should most definitely be fixed.

I'm of the same opinion, but if it is fixed on the kernel side, then
(assuming no device implementation with the wrong order exists) I think
maybe the fix should be backported to all widely used kernels. It seems
that the patch hasn't been backported to the longterm kernels [1],
which I think Debian kernels are based on.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/d=
rivers/char/virtio_console.c?h=3Dv6.12.47

> Kind regards,
> Max Brandtner

Regards,
Filip Hejsek

