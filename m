Return-Path: <linux-kernel+bounces-778867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91169B2EC37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BD55E71E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855522D3EFB;
	Thu, 21 Aug 2025 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9GrA2o2"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036012C21DE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747568; cv=none; b=E+3sLy1HZZOEPNl0I4hU9j2aZpAbJty8/ibY00NzlCWUlP27vRxKGef1SUE0ffGQgWRWaaJvVuTliCIcmXxaueNL1WJnQiliM8RitYDZGJsxUKS2HYOe6a1aLLSgL62BeyF51DLQc0L4sA9hms21Z+fpPsK19WoOPYFYz8iI7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747568; c=relaxed/simple;
	bh=kWLYXOCnhNIMKZi0bPwb3V+7wgo6GpBDdz41mY96HO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvCgyPdOfca5Bb+g1LxQBFaSSw4HthNV0GGNAy4dq/Hr4LUiDOcJ6QzVOECtmCGaclkfln7VUByxjADjBjg1tk5j+o26wZSmzdhINpe44hV6XT/eV1HllCo/nz6jaPaRe4XFAA+iNMOUimrKsh6J56cRKXn4gMo6o4QUIfjEwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9GrA2o2; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8920c579f98so158947241.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747566; x=1756352366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHNhf7XSN8X4uNWNRTXgCcydX02QGrBwhqpJYJeqyQs=;
        b=S9GrA2o2fpNLdHWGxxiWrsc22z0+PnC9KpoON949AsVniRiqOH2U71c7qitV9t5qz5
         KoIyyScbArjkpD0bmityOGURBy6MYN0JknGWNylO/Fh76WZVZKSW6g+7lyELRGQLdLJU
         nRtdVBP0oydjqUsl8W+UPKkmDE9b9V7tWpdaroU0vlyYrB6rtTjqxDbLPNTtKV2iMEXb
         2sow5Chyae26M88HpAIZMvEswGUjD/IRq6jzZ2j5xexEhb/fcERLUjpk7n7WE170/Rdb
         hsnUcPOdT45vaPrBJEBQG1xZmSPMG4mfDa4y63ksRLdr3XbZaRBcQSygg1RMvO778ECf
         i5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747566; x=1756352366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHNhf7XSN8X4uNWNRTXgCcydX02QGrBwhqpJYJeqyQs=;
        b=f4IvZq9wkvA64k8ot11QAIFTzA3yUNkSDrBbcInVa+av2QPclJxA+XgrtnWn+HQV87
         DZGmzUp5Xd/JJPCtZe/1sYokY4rU7GtrloRne7dcQmA998IpwBW4BzYTxTHngKt/UztZ
         c209L1GaRwL8FE4F5z+4M6w93szc4z7oAgH3Bzz5G0OuBXdV3wx/nHj64oI+u2k4thM3
         T+NfrlM4Sc2oir08vApxEUNhH1tUsEjuP97smBATw03K/cj1mZDxsEFH+je0toxGn2e3
         DckMyaktgVYFfkTNwlqFPwId7ofmaxZDJqPO5zO0B/iFSboMmcyJydisjFS3DG00661R
         X0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWA9C0yWHMik1CgH0tw+QUXfw1SlsAUH42JnmmN7NfN740iyRo8+QJJj2IBAve9wgyi4Sd8VU5eZ6RjY4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0olyPuLmdHcgVQoQX744CIsqH7G5Ro6zGKsJWLyJunVY8SI4
	Uw1ktF4paAwCfxGSzmKV7+27VbYJRNY2BYJNgzRjVlCwC66zagf1eSsezIGKWi8rDaqoYXqLJqF
	JfodfplRWvBWg2WctwKvheee+ZMG1N1+EdJPD
X-Gm-Gg: ASbGncsZ5CBW1S+YW2SASRALzG0OxXeYDSKlB6Cr6Keg/uya0JXLUJs90P9KkHliptC
	41ncmyI4laGdDZ0nL6Mp/u4fqvsr14Avbv3dvJzX33Quc74rfvUvYX/2B1zyyfS+Ux3PKMfdWff
	7FDHT9wtFUWeS6yIhD7k4dimTr1PSokO0CcyTeZoDkuhhI18Mu1krRxlKTC39bSIMlRlWh+IJDB
	01O/dA=
X-Google-Smtp-Source: AGHT+IHPY9y6F2SaXBU3lk7s1rj/qseLIaxXnRT1jcho1NSkURSIDnznKHMnWM8sng6n7zAMPOxUSqV8Aiogo7Ih9tE=
X-Received: by 2002:a05:6102:f9b:b0:4fb:dd65:b97f with SMTP id
 ada2fe7eead31-51be0d43569mr281096137.23.1755747565805; Wed, 20 Aug 2025
 20:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
 <20250814133527.2679261-2-xiaqinxin@huawei.com> <CAGsJ_4wbgqGavjQNXtbFVeMw8j8oSCEVSdL4BrBVWEuNHzomPg@mail.gmail.com>
 <8db50f47-9295-4c7c-8bbc-dbbbd3fb5f79@huawei.com>
In-Reply-To: <8db50f47-9295-4c7c-8bbc-dbbbd3fb5f79@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Aug 2025 15:39:14 +1200
X-Gm-Features: Ac12FXxhlP5fMGBegDQf1Cw4y2-k7yQ_xExW07VA_SYwfbeiwBN1P6R-7m2YJhk
Message-ID: <CAGsJ_4xXt2uEtAohcq+3XF_cKdsZiWsRaRh+ZK4nj0-Zw-yWYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I'm so sorry, there were some mistake=EF=BC=8C'usr/include' should be pla=
ced
> before 'include' during include :
> CFLAGS +=3D -I../../usr/include -I../../include
> After the modification, it'll work.In the next version, I will submit
> the two patches separately, and put the modification of the file path
> in MAINTAINERS into this patch. Is there anything else that needs to be
> modified?

i am still getting same build errors with the below:

tools/dma$ git diff .
diff --git a/tools/dma/Makefile b/tools/dma/Makefile
index 841b54896288..c37393a3e937 100644
--- a/tools/dma/Makefile
+++ b/tools/dma/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 bindir ?=3D /usr/bin

-CFLAGS +=3D -I../../include -I../../usr/include
+CFLAGS +=3D -I../../usr/include  -I../../include

 TARGET =3D dma_map_benchmark


make:

cc -I../../usr/include  -I../../include dma_map_benchmark.c -o dma_map_benc=
hmark
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:20:33: error: conflicting types for
=E2=80=98fd_set=E2=80=99; have =E2=80=98__kernel_fd_set=E2=80=99
   20 | typedef __kernel_fd_set         fd_set;
      |                                 ^~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:179,
                 from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/select.h:70:5: note: previous
declaration of =E2=80=98fd_set=E2=80=99 with type =E2=80=98fd_set=E2=80=99
   70 |   } fd_set;
      |     ^~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:21:33: error: conflicting types for
=E2=80=98dev_t=E2=80=99; have =E2=80=98__kernel_dev_t=E2=80=99 {aka =E2=80=
=98unsigned int=E2=80=99}
   21 | typedef __kernel_dev_t          dev_t;
      |                                 ^~~~~
In file included from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/types.h:59:17: note: previous
declaration of =E2=80=98dev_t=E2=80=99 with type =E2=80=98dev_t=E2=80=99 {a=
ka =E2=80=98long unsigned int=E2=80=99}
   59 | typedef __dev_t dev_t;
      |                 ^~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:25:33: error: conflicting types for
=E2=80=98nlink_t=E2=80=99; have =E2=80=98u32=E2=80=99 {aka =E2=80=98unsigne=
d int=E2=80=99}
   25 | typedef u32                     nlink_t;
      |                                 ^~~~~~~
In file included from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/types.h:74:19: note: previous
declaration of =E2=80=98nlink_t=E2=80=99 with type =E2=80=98nlink_t=E2=80=
=99 {aka =E2=80=98long unsigned int=E2=80=99}
   74 | typedef __nlink_t nlink_t;
      |                   ^~~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:31:33: error: conflicting types for
=E2=80=98timer_t=E2=80=99; have =E2=80=98__kernel_timer_t=E2=80=99 {aka =E2=
=80=98int=E2=80=99}
   31 | typedef __kernel_timer_t        timer_t;
      |                                 ^~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:130,
                 from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/bits/types/timer_t.h:7:19: note:
previous declaration of =E2=80=98timer_t=E2=80=99 with type =E2=80=98timer_=
t=E2=80=99 {aka =E2=80=98void *=E2=80=99}
    7 | typedef __timer_t timer_t;
      |                   ^~~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:52:33: error: conflicting types for
=E2=80=98loff_t=E2=80=99; have =E2=80=98__kernel_loff_t=E2=80=99 {aka =E2=
=80=98long long int=E2=80=99}
   52 | typedef __kernel_loff_t         loff_t;
      |                                 ^~~~~~
In file included from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/types.h:42:18: note: previous
declaration of =E2=80=98loff_t=E2=80=99 with type =E2=80=98loff_t=E2=80=99 =
{aka =E2=80=98long int=E2=80=99}
   42 | typedef __loff_t loff_t;
      |                  ^~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:115:33: error: conflicting types for
=E2=80=98u_int64_t=E2=80=99; have =E2=80=98u64=E2=80=99 {aka =E2=80=98long =
long unsigned int=E2=80=99}
  115 | typedef u64                     u_int64_t;
      |                                 ^~~~~~~~~
In file included from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/types.h:161:20: note: previous
declaration of =E2=80=98u_int64_t=E2=80=99 with type =E2=80=98u_int64_t=E2=
=80=99 {aka =E2=80=98long unsigned
int=E2=80=99}
  161 | typedef __uint64_t u_int64_t;
      |                    ^~~~~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:116:33: error: conflicting types for
=E2=80=98int64_t=E2=80=99; have =E2=80=98s64=E2=80=99 {aka =E2=80=98long lo=
ng int=E2=80=99}
  116 | typedef s64                     int64_t;
      |                                 ^~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
                 from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous
declaration of =E2=80=98int64_t=E2=80=99 with type =E2=80=98int64_t=E2=80=
=99 {aka =E2=80=98long int=E2=80=99}
   27 | typedef __int64_t int64_t;
      |                   ^~~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:137:13: error: conflicting types for
=E2=80=98blkcnt_t=E2=80=99; have =E2=80=98u64=E2=80=99 {aka =E2=80=98long l=
ong unsigned int=E2=80=99}
  137 | typedef u64 blkcnt_t;
      |             ^~~~~~~~
In file included from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/types.h:192:20: note: previous
declaration of =E2=80=98blkcnt_t=E2=80=99 with type =E2=80=98blkcnt_t=E2=80=
=99 {aka =E2=80=98long int=E2=80=99}
  192 | typedef __blkcnt_t blkcnt_t;     /* Type to count number of
disk blocks.  */
      |                    ^~~~~~~~

Thanks
Barry

