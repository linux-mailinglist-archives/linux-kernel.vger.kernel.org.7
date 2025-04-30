Return-Path: <linux-kernel+bounces-627497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480CAA5180
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80304E79FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2026460D;
	Wed, 30 Apr 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQAtIXGr"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843F263C90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030064; cv=none; b=Dtz28F5B+s/sNidcqCN+BJ/YMY83Arld2sQ1kXZH6gta0bV7VZZQDg2TWK6x53VdGM7LJAxyTtKGxXnoYeZoAIBTr7KPaGW8jQH86isEyqwFq7XX2C6l60IufoXzE+Lgl9UvfGC3R4RCvWzSH0H8TCznQNWTUtvjvZV7qMK6GZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030064; c=relaxed/simple;
	bh=LpHRfhDvHGPF2hXjZlOMYKooffdzDnFTNYYSF2yPQ2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGaAnu0QTtIZUTau+iJXNd3ZgkbLvevgJl6vlZQNIcdbZoGw4UToIZxnpa6pFxAH8bwpAkD+79U36F2+FFa2EGH+Gwkfz2qrqAqrnxwqsVv9cG6CDzlh8zLBFBNlgEtXHYijpeuJQ1iGenxP4ysmY10rZDfnzOW+Sfe7e+UZA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQAtIXGr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe808908so2905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746030061; x=1746634861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITlJTqCh7uuC+AGjnX/2OcnlbBzBhZafTVcOLvpVDYw=;
        b=AQAtIXGrH/83WlGPZ9pIArgc+sDEazm1yA8+GHjaisXauRxkzCBYi0Gjtqd/KO1KYY
         znKmWywnW5o5RtFubnmSz/wrMm3cXFRvHiZtcTTy9X0j2UN6x6yf9SIYVwgBvDGyNdL4
         oApBSh8Rxjc/8X6rvsS8Aq3t1SikKmhjK6Is+Qkwy/9t8wItkeRHQ2QO6Vyfml1f5XnH
         SW0TcvsSV8DLDuSxdk6E1Y2zmJG6rCz1QpjOcdEbJF/W023s08joyD+0MmZFc79xfyPZ
         yKEkZNzrrtgH6fmWol9qE6YAFjauskSFmLyp6b/OINUqVb4/xmrZDfLXB+hNWw12qgtX
         ujog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030061; x=1746634861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITlJTqCh7uuC+AGjnX/2OcnlbBzBhZafTVcOLvpVDYw=;
        b=CyMzlO+KOIrFFt81gezOc31e0W+HJi+QK+v8aXRrxMz5FQ4yV0UUzFJvAgMTaMD57n
         oD6XgHS7zOVIkWTmoccxzeD3I9bxDF1BkiVP9vhobb4ErfntTZV3uonvfvVTMyzWFUsp
         5/T+VhVc9O1EZ8jLHh8k6jb1lARvX+4/AnY7PgpPHyY9C89GCTU3bsOF1fCG+3p0FAcP
         6A4s31tFnSAsEA2s1IsmbG7j0KPxkyQx7q+2cfItwv1YsCB/hRrG48ghCMQgrghFeXjN
         eZxUbrL/Hwqr/oMIDw3HaIcSs2C9pa6XHGcr5WhLJUuPL8vKTHeYW+e6ftxf8g8ofQic
         MMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Qy29CAZld9rIPQM4CA13HLVKvIb4KRk/1cb59wuzKpWXpBy9xoNbUTCxV7NxedC2PpglpA+zfsptYLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4C2mI4YUGzzViMvf3fl6Qed0sCIdEy2v1PnZYXexEAxR1hUOk
	26WdHYsJgH5640RkgqDMwmXsVYWJ1nHoifSkO4X9UoVDBS7XBl43yqY+viGZYabfMejfBexjsR4
	RcIgvRh9owzx6DZhrvsMyw2S6pF2tXCAX42TD
X-Gm-Gg: ASbGncsh71uDzdHlZApc8iFepPj0QgXdvn6SY+0ISLDGuRfwM0Yq5i66yV5ARwL3Mm6
	CjdxC0nhd9gWOlaSHksPQYMmzuM9i/e6UquHX9YPs93SerjaovQlu19liw402mU3fo7oCke/0ql
	OduPzlCzwuK4JtK//wdMTcHOPQR1lu5tMgWMXNPwQGhWslEDYFFA==
X-Google-Smtp-Source: AGHT+IGjq5UCWuOVohT4wTc98AFxoE5cC1RndlLUKdHvMQth3F5/w7t4WqoGSe6nSHUwNQ8iWR2HZkZH8kD/nBSW0+U=
X-Received: by 2002:a05:600c:1d90:b0:439:9434:1b6c with SMTP id
 5b1f17b1804b1-441b4d7a6d1mr546205e9.3.1746030061267; Wed, 30 Apr 2025
 09:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115105211.390370-1-ps.report@gmx.net>
In-Reply-To: <20250115105211.390370-1-ps.report@gmx.net>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 30 Apr 2025 09:20:47 -0700
X-Gm-Features: ATxdqUGzlbj1JzYl8Y8d6xa0ko6OVa25QiRzQSU_kIdPLFfnUA-zNBFDvtwFXPk
Message-ID: <CABdmKX2+nhw8L7HLZdaSvbX4VWhCEaxZt42G2QEvcfKxzpw3RA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] selftests: pidfd: add missing sys/mount.h include
 in pidfd_fdinfo_test.c
To: Peter Seiderer <ps.report@gmx.net>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:52=E2=80=AFAM Peter Seiderer <ps.report@gmx.net> =
wrote:
>
> Fix compile on openSUSE Tumbleweed (gcc-14.2.1, glibc-2.40):
>   - add missing sys/mount.h include
>
> Fixes:
>
>   pidfd_fdinfo_test.c: In function =E2=80=98child_fdinfo_nspid_test=E2=80=
=99:
>   pidfd_fdinfo_test.c:230:13: error: implicit declaration of function =E2=
=80=98mount=E2=80=99 [-Wimplicit-function-declaration]
>     230 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>         |             ^~~~~
>
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: T.J. Mercier <tjmercier@google.com>


> ---
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/te=
sting/selftests/pidfd/pidfd_fdinfo_test.c
> index f062a986e382..f718aac75068 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -13,6 +13,7 @@
>  #include <syscall.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
>
>  #include "pidfd.h"
>  #include "../kselftest.h"
> --
> 2.47.1
>

