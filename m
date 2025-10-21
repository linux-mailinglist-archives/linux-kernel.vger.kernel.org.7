Return-Path: <linux-kernel+bounces-862095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D757BF46C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477AE18C597F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572D278E44;
	Tue, 21 Oct 2025 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9jlduuE"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393B17993
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015559; cv=none; b=em0cr2Z9U5KxO4dHfVE4hKsHg28KQnzMs3opF+hQAWrFjRl3i5jRa5klT7t7HswzrR1DGWDaQFmyvElTY3SU51tDOo2sT7ai8ZxWkfX3AzeVAwR8+Oxqu4N8oO5ZCW6O3oOiUPPJoRD7vx7ghMeJ5ImM20RU1HUkCjYxSREmzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015559; c=relaxed/simple;
	bh=TgGCFGn6hqh42rGy6bVq0OGvw1jWJNi2c5Mvr31Lj68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKbe0SUXagkbp6HzelhNZdo+9dPtijCCd5XI1wZdbiRTEvw3ZZwFnkMcP/J0d9l4DPM3pahZwBa92p7maIcN9F90WslPBE0sF/Yq365DpGVhfiGloHTWuWGikH917nyXWvNpV4/NkZWgmO18C2qQ9IBqd0Jw1GCtvwCpfwL/GbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9jlduuE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88fa5974432so701024485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761015557; x=1761620357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV0443ZaLPJFyHCdItTUFYSD3cKu9rIyDsapkd1+4Lo=;
        b=T9jlduuECUvG+X03A7tP6voZ+HWAnNb7VvuAAUBuiZMDYdvpPmzFkRTDIkmsKt7Vbj
         LipuQWoRJk4A7loQhsuSiTBRFa4PnwIqdX81pR8/oCIPIfl2UPgr+A2PjrXz3djmjk7a
         eJ9u8FSbF6lVY2l24YaLbVbp8bjHBCSHzqj1qdYShU3qbDuxpiQOWIPbDR4iBqU5X8S6
         8iBAkwd46HMP5a5aW9P2nHn07HooZY/mDuoAiLsTYZfB99BRXXg9m3nNUisLS8St3fv3
         GsyQ0UQKSmhBJEvOOY7SptrzrEmo+SJDvpEET3aUdVN1mEoFYYyzbf/RRntYPgrrFwbY
         1phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015557; x=1761620357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV0443ZaLPJFyHCdItTUFYSD3cKu9rIyDsapkd1+4Lo=;
        b=gKD8ZnGmodgWt4nYpNnLrzEcEBwgz+FunVXeT1qZkghMErxCUkF6hHCASHndObJI3s
         yBFAEy/j57x4J2/fN97lVeXRQmxQdsyvLG8TMxNvm48Roqft2hMjo76DACZcErf+szBo
         UYNbDvz4Zq0oZzI66gY6LEmtpNshA1+LNjvmHzqltgVuTRHXBJ/z8hruw93rQClG/Nsz
         jF9KB7wxlj+PmEY67VYYZaFXAwwqJBLdx4k++cZHBf0vUfzKSTQR51iUU8Cxwz/EP5rX
         30pD53yGE0TDBGGTK9Fbo2A+gmQC7+vv6jvcf7x8wezeWaHB1lD4Mawy3BZ0zaXUjQJl
         y17A==
X-Forwarded-Encrypted: i=1; AJvYcCUhmy4W94Nqhch9Zxi2h9tk2daA5ze8P7H6rLScwjq8ut88T2aObT4tSGZ98Oe3qB4ws3EShS/srrXZnz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPnaVyj6MJT7f7Ren9kpVs4dGNVhEPQSsu93Z7bfjHjGIeyNIp
	QuDNCbN9pi/wMMzuWv9oq5Sb1yd3JIxs3OrYA1d+DQpGbiZ/+P3PVmAZ0f726gcTFbkkh6rk+lM
	mvs1/PdJYH2P28kjaGr1gyJ9WULJeGc4=
X-Gm-Gg: ASbGnct2vy/Ze1qsgrmpA4BJe1Y9HzDH+pfB8aCixWoL6TrekT56pJzMzANch+0yy34
	ET26pbAVi4NM/2BZ3qGa2Kriq9ALKk4GW74JcNSTDzUfWOeeMaiAX53E0/MQoby4Z8APBB6aJon
	TMM+5nQUUOkIlcdM8S1S0rU30oCaHPx9jkAlsBK7ls381Bi5Fjple98sSD4vTpJUCil4EL+7vBR
	wy8ViCmG1A09gln2FMgtGhzIw6ktNxEJhwcM7aRwDKXqSdgOBBqysKs9v/FQ5vaswIR9QgKBX0q
	PMcr2WctVaZyynqG
X-Google-Smtp-Source: AGHT+IFB96dTPk++rg01+o8apTchkyODj+vboE7KDDEWlnB6aqeiuNJR7dn8v8idH+qYqM46al/LBv20XLVpppO+Emo=
X-Received: by 2002:a05:620a:28c9:b0:867:454c:be7c with SMTP id
 af79cd13be357-8906dfe027dmr1653567285a.5.1761015556955; Mon, 20 Oct 2025
 19:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021011739.1468912-1-xiaqinxin@huawei.com>
In-Reply-To: <20251021011739.1468912-1-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 21 Oct 2025 15:59:05 +1300
X-Gm-Features: AS18NWDVMlxpv4Z-hA_9uvVm9b3p_AQ_Pa-BCldxFZHV8I3lPZwC0zN5QvEzPeY
Message-ID: <CAGsJ_4zF4JOPXpkzmR+invqefLstcaB=xaGEfueHEQRSg2oLOg@mail.gmail.com>
Subject: Re: [PATCH v3] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +dma_map_benchmark
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> new file mode 100644
> index 000000000000..4acbd9e00cfa
> --- /dev/null
> +++ b/tools/dma/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +bindir ?=3D /usr/bin
> +
> +CFLAGS +=3D -idirafter../../include/uapi

I'm a bit confused =E2=80=94 it seems you haven=E2=80=99t tried to understa=
nd what the issue
was in v1 [1]. You were using -I for kernel header files (under
include/linux but not uapi), which caused those kernel headers to take
precedence over the system headers, leading to build errors. The uapi
headers, however, are specifically designed to be installed into the system=
 by
the toolchain.
So that=E2=80=99s no longer the case =E2=80=94 -idirafter is not the correc=
t flag for uapi.

> index b12f1f9babf8..5474a450863c 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/dma/dma_map_benchmark.c
> @@ -10,7 +10,6 @@
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
> -#include <linux/types.h>

What=E2=80=99s the reason for this? Is it to work around a build error?
If so, no =E2=80=94 please keep it.

>  #include <linux/map_benchmark.h>

Thanks
Barry

