Return-Path: <linux-kernel+bounces-817671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB640B58532
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134513A22DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB128152D;
	Mon, 15 Sep 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlEJqrmt"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8328315A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963696; cv=none; b=MQR9qsrQqI9dAoBlnLGpSuYkVyppr63JU9gIGAb2IjpycoWmCK3FfgUKajw6ecXi/oXGb6hsIjfPBwJLhClg0WOwSPfapy4XaYVrUrUNvuGs05i1r8RL2B+Jv7D2ftxrp0Ru9OLZ34CWd4EWGsw30RpBfchc7jvsGrDok6cOfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963696; c=relaxed/simple;
	bh=c/xwwXA3LmBOBhBu2xW7scBMnY4EehI2985j3EdXFks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM8T1+3KJWlCN7y7CUsPuJyKbVnTPAJ8U1rshCYad9mxfFqU6iphfatO/T8Ohl0f9bU6GJU7v72kT0xE0ddZm2UGNg47nLOJ7mu3oOyC9eRwrA5cFc4Yuiu3teccRxP44Nczo6S81VM38ljRut4uppwwQwUejUGVabK8vFEUI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlEJqrmt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77287fb79d3so3502524b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757963694; x=1758568494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6wqGfRu2qI7+46L6ERmQDqDyxlRm+K7+bHyAwd1/ys=;
        b=jlEJqrmtHfQvrHt+RJ2K77Bi1DMrt2z4sYHpbdXzBuWZEJBMMFFrfCYuYjFcO9/zbx
         sYbYKLTurMtBAaYl5T42NHK0TZctBCNI2dWU2qlXeUDvbZQIk8Wk+XHHzK3IQucLAYeY
         g11iC1fV+fgrfdvGQ7mpJTMFrwiCXqgXgB/7yc7OuEZ7J0N98TPy9vwDdrMVDoj22cdF
         K/ADqFZTSHa4JYaFXV/QZoqlbsWdTKOwXXq1VXLXvD8wNh57PHzYDW3Gc2kh94u6+q0k
         aUBVVDt0/uknwv8D51oQ0b9PlfsB8rHPRcQuD/cg10wlI7er1wSWIT50Zv8MRqK4Of5x
         FQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963694; x=1758568494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6wqGfRu2qI7+46L6ERmQDqDyxlRm+K7+bHyAwd1/ys=;
        b=rM9Q1CKY27hYWobxFNAIXH6MlwgnmbFP221W0P389Xb9QPAlBaDpp19P3AfS3nG6mN
         utbQqX1WkLvrALZYAe7wYRzJgPYeLd8XECVJbx2LcsiO/bGvppeIjBDHbtfHf9odCDFs
         PEmlsOH6S9qOPHAuvNuRyVZNYfN6CVm+EgTXejwx4rlzleFL0UWXbb3rq3wyCET+EEjP
         krpM9mJ6lwPyGw/NfwLOFRXkdHI3SPSZv3op0v80F5kUDy/g1UT+yUGXuOEdEpSaidO4
         w5mSpgBhCTJCFsgLkThhmykwdPYzHJD1i5o/3bTKTUIExmZaUlxJ8CY2Fr76tVQjSte1
         X9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVr/J2Nl4gb2nd6zgnCpvev6eHzhbPZM2zOutvtQvYKTmlI6iyvw+P87mtw0TnRHv9HdrtwanNXBTuckoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqLWrVNK663F0akWD4SeVXiQO1VyQagWUz2X3l45LHwp/yLwH
	Vl7fcVw1sN6h/LNuWOa4JeijUQdUU/KPpINa/Gyu+gaogitK9aMgqRxLyB+Qh2YpUXyTJduSWhP
	aLBcEBYGFPbFM05aXhkSC0HZA6JmIKHEdVv10aTE3jd0cFwqRMgOOiBE=
X-Gm-Gg: ASbGncuMw1ABJklkEeY5z7GziNvGOQE1mNn2As+TGw+c1TlsgeSi0cws+0VnEu1NYG1
	6FnQPNeZ98qBkiglen3htawJb0+/vkPQdLR4v/Sjg2GxVKaAlU0cDYNXz+7D/g+H8+nxdkpwwjH
	DXHE5sP7W1n0sfa59xuCvxtxvpGcRLAKAOmlXmRh8pn7Q9sW0JeOWqaCW8Z8M9WwC0iXb5BzwTy
	NY3hZiLLNN5PclimKusZZvoIcVd9ufzc21Pyy3Zm0eHjFrucJTe2nRH/yxBQW84rmxndQKzf3+X
	lxNWzA==
X-Google-Smtp-Source: AGHT+IFS5Yosk8zDvCLXFq8KmRAPDnuqfaDSdxmgmvOa6yUNvkUlqGro+dILUrXNR4yBf3K+Z0YAEwYFzYRDWuMc2Nk=
X-Received: by 2002:a17:903:40d1:b0:267:bd66:14f3 with SMTP id
 d9443c01a7336-267bd661815mr9354435ad.51.1757963694201; Mon, 15 Sep 2025
 12:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
 <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de> <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk>
 <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net> <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>
 <a1dc9839-ab45-4dd6-9eeb-4bbc35bf8d90@sirena.org.uk> <5fe12804-2538-42c5-b5c7-66d36ff947d9@t-8ch.de>
In-Reply-To: <5fe12804-2538-42c5-b5c7-66d36ff947d9@t-8ch.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 00:44:42 +0530
X-Gm-Features: AS18NWAPyThDdNoP11CbNq-0STFMKwn1jS9ssO9hoUB8yYX9018L0FgtP4-g6Ow
Message-ID: <CA+G9fYsnPBYoeVMzQJMCPA1JGhcJXr53Y-_uOMKdB_3D7ZGQNQ@mail.gmail.com>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error: use
 of undeclared identifier 'HWCAP_GCS'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Mark Brown <broonie@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sept 2025 at 14:53, Thomas Wei=C3=9Fschuh <linux@weissschuh.net>=
 wrote:
>
> On 2025-09-12 12:14:00+0100, Mark Brown wrote:
> > On Fri, Sep 12, 2025 at 01:07:58PM +0200, Thomas Wei=C3=9Fschuh wrote:
> >
> > > The Makefile does *not* use -nostdinc, so the nolibc program probably=
 finds the toolchain's glibc asm/hwcap.h.
> > > There also doesn't seem to be a static arm64 hwcap header in tools/in=
clude in the first place.
> > > I am still wondering how this works for the other tests.
> >
> > make headers_install puts a copy in usr/include, probably we just need
> > to include that in the include path.
>
> Naresh, could you test the patch below?
> The other custom $(CC) rules in the gcs directory are also not
> respecting $(CFLAGS), but I'll leave these for now.

I have applied this patch on top of Linux next-20250912 tag and
tested and reported build regressions got fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/s=
elftests/arm64/gcs/Makefile
> index d2f3497a9..1fbbf0ca1 100644
> --- a/tools/testing/selftests/arm64/gcs/Makefile
> +++ b/tools/testing/selftests/arm64/gcs/Makefile
> @@ -14,11 +14,11 @@ LDLIBS+=3D-lpthread
>  include ../../lib.mk
>
>  $(OUTPUT)/basic-gcs: basic-gcs.c
> -       $(CC) -g -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostd=
lib \
> -               -static -include ../../../../include/nolibc/nolibc.h \
> +       $(CC) $(CFLAGS) -fno-asynchronous-unwind-tables -fno-ident -s -no=
stdlib -nostdinc \
> +               -static -I../../../../include/nolibc -include ../../../..=
/include/nolibc/nolibc.h \
>                 -I../../../../../usr/include \
>                 -std=3Dgnu99 -I../.. -g \
> -               -ffreestanding -Wall $^ -o $@ -lgcc
> +               -ffreestanding $^ -o $@ -lgcc
>
>  $(OUTPUT)/gcs-stress-thread: gcs-stress-thread.S
>         $(CC) -nostdlib $^ -o $@
>

- Naresh

