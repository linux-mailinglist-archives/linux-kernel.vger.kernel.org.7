Return-Path: <linux-kernel+bounces-893184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DACC46BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A23AFC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752B6310630;
	Mon, 10 Nov 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1WVAnng"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA530FF10
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779374; cv=none; b=Ds0kTfHO1Kj0eZRCq4XXEcGniiOVsyodxlcoZqIknjRSL0XfmDsbJHV+L60YUHQcNJ0gMx0Am0ZVJzMacwxqoiHWDGF/EYRB5UFqAzoU4HWXqMsPpLOnBQBByYDMJ3d4NECuE8NKo8e7CnUlZmcLggj9dxr+xREmv7nnXFwuVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779374; c=relaxed/simple;
	bh=hWgUq2BjHCusW9DYcsZGfXUPIqWHGydpEUSpbvT/FdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIfrkz5P3CnZwyiGRR1pKJyAKfpYbTPczbJmCkBSGVJS+xGSiBytwSd0AKVVNfDQ6VyT96xRiD1eLmNy8z4Nser08+gpGG1X6y8t9aP32reM9+fj2DK1+9jgMOOd6blvMmIA+mU9+zx+pUxOYUFVgeVrFkMiQQ8wQMpraeFoMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1WVAnng; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592ff1d80feso3118170e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762779371; x=1763384171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hWgUq2BjHCusW9DYcsZGfXUPIqWHGydpEUSpbvT/FdU=;
        b=R1WVAnngBqRu7ReVpqnIEUJOKwSMn/HVtIhPInzeuZKY+DES9UUN64CW1T/9fK9lmB
         NpIL/6IEkokYOMfP/tfqsnjoXRxguxKTniG2hLSJUHeg02x89etIFfh4LcgUEZluPhnS
         j/G9mXy5apVTaQm0KtH8NBGnQ5s8K8zyaeTozNxliI8pO1uTZILIiYX6B45JfYb6IR52
         Uh0E6EsG87GPuFjEqcqSQjRyengsPh2iLi4KQixjYHau94g8KfoebS2IraK7hXujzyjj
         YNg4jgNeDe2/KVrIbVHvo8AszCvhduY9WTlqXf48dzajO1as4IQbjLlOi0j/kidykszI
         MClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779371; x=1763384171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWgUq2BjHCusW9DYcsZGfXUPIqWHGydpEUSpbvT/FdU=;
        b=Qh45WZoNSOPaU3sbbUhrCS0qFJ3mDt9Zk9/DzS7LW6D6LBooIPHUX3OuTcuAaoFURu
         fqXUbNSNPO59SuQ3wG+xtnWNoJ7YfaWJxDvAvT/gs/No2d+xn1mmtlD5H9kE6RlqYTRV
         ZNrMPW8KEHv5MUnXpIz8O8ZeQtBKmLw+vqYszdLlJ8BN/lwBUxfckAGlYCruzZEdJGKX
         CAZe/HqiUJcCULkAhKloLRfBEMFy3y+bVo4PAhtJWfFZvGNgaFORHNO/aoAunRMWI3vu
         8AAEy47cs30SUIOBD8gvfAhGQkhYgux8aSZHVK7oO1IfenG1OXUZdijj4Pq8+sC168ec
         GDsA==
X-Gm-Message-State: AOJu0Yx0OTKxi0a/+SSkj5qu3w5X8HGZwgD3USR3NK1r4LIDv33QlN7l
	VIp7NnjkEtJitOa7+JywqENHEmm7LPoSjHQ2Oa8nYlx2mrcqVUnpyzoC1k5gGB6Hxmaj5DY7M/4
	ZQixSG1gVLES7uOjQR3ONoENI9dlnwerapA==
X-Gm-Gg: ASbGncsE2gNeBBelsdrcdBbfdPyVGK+R8aDUSUDMfj6bjNidX/K1wKhOQij+X/ajfgM
	cLp4MUYUw2F95IVAofkyUl7XweteLFceajTd0P2CVhdYdHG10VWQZzThI0rN3yQY9rqRj0Rzj3f
	fUvbsenqXmyZO7pJHx7LMkuVhrJoBVKkqvhQV/DNX/qX0prrjQwYYFtPpEwjK4xNVJaOEMmOeXs
	nkFaaouOybf6HFTNYXNwqFff101ajikV/JpOqwlWy3dvzJ1oX8HjbHJPyGMSnCNpSd5kmoRLw==
X-Google-Smtp-Source: AGHT+IGNJvdZLCrUFZuBYuWXQT3dmXv8a31c3giOBPtpvQfH/betQkwbdL5B2iLrRYMW9y/p54wMWpGDurWY8udeJpU=
X-Received: by 2002:a05:6512:23a4:b0:594:282d:f42a with SMTP id
 2adb3069b0e04-5945f19bfb2mr1958176e87.22.1762779370821; Mon, 10 Nov 2025
 04:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUUUZScSvNzqgBDyLCEGL0a4cz+EdeKHq3Rdu0QG21=XPQ@mail.gmail.com>
In-Reply-To: <CA+icZUUUZScSvNzqgBDyLCEGL0a4cz+EdeKHq3Rdu0QG21=XPQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 10 Nov 2025 13:55:34 +0100
X-Gm-Features: AWmQ_bkXh2hmMcz2pEYXgA_ep-0TQ0WFo-WXrG-bOdhG7ymEjPJ034S_X2TjpTw
Message-ID: <CA+icZUXGQpf5n-x2uR9FyiugrFigcaYxaLsdSfKRVpfruVwbJQ@mail.gmail.com>
Subject: Re: tools/lib: Use -std=gnu11
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 5:09=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>
> Hi,
>
> I am carrying these patches since Arnd made the switch-over to -std=3Dgnu=
11.
>
> Background was building perf with -std=3Dgnu11.
>
> Refreshed to fit Linux v6.17 and patch-series attached:
>
> 0001-tools-libapi-Use-std-gnu11.patch
> 4:Subject: [PATCH 1/3] tools: libapi: Use -std=3Dgnu11
>
> 0002-tools-libbpf-Use-std-gnu11.patch
> 4:Subject: [PATCH 2/3] tools: libbpf: Use -std=3Dgnu11
>
> 0003-tools-libsubcmd-Use-std-gnu11.patch
> 4:Subject: [PATCH 3/3] tools: libsubcmd: Use -std=3Dgnu11
>
> perf below changed to -std=3Dgnu11 sometimes - that was my 4th patch in s=
eries.
>
> OK, tools build-eco-system is different...
>
> We have other places below tools/ directory not using -std=3Dgnu11.
>
> What do you think - comments?
>
> Best thanks and regards,
> -Sedat-
>
> P.S.: It looks like there should be an agreement also for -std=3Dgnu++X
> (we have X=3D11 and X=3D17) in tools-dir.
>
> $ git checkout Linux-v6.17.6
>
> $ head -5 Makefile
> # SPDX-License-Identifier: GPL-2.0
> VERSION =3D 6
> PATCHLEVEL =3D 17
> SUBLEVEL =3D 6
> EXTRAVERSION =3D
>
> $ git grep std=3Dgnu tools/ | grep -v 'std=3Dgnu\+\+|std=3Dgnu11' | grep =
-v
> testing | grep -v usbip
> tools/lib/api/Makefile:CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu99
> -U_FORTIFY_SOURCE -fPIC
> tools/lib/bpf/Makefile:override CFLAGS +=3D -std=3Dgnu89
> tools/lib/subcmd/Makefile:CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -=
fPIC

Friendly Ping.

-sed@-

