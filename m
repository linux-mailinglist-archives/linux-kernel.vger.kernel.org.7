Return-Path: <linux-kernel+bounces-770693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7344B27DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1801116CC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60282FD7AC;
	Fri, 15 Aug 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAuKAm1c"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B82D8760
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252223; cv=none; b=eJAvsbM2Z69TAMzt4pDK27RYjNgd2v1y/ki1pLf3v4cim0De6OzGFChY79sJzXmzfi42+goKGgDsud9XKpEFBv0fVsdwmqQ/zzEDIDLcee8pFO68tyooEb8U+hGk9VDPumEKOWn2JqO8VO2Ps44GK1e4DxDHyn9EMHr9r6KN50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252223; c=relaxed/simple;
	bh=J+0nESK16nJf1ZfqAI5tJ8G70VsoWHvhZxk1vMurWPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwkaSve4ySe9qMWzgYrW/KOLzNIHCRwhUB3iWSAanXR57JR2pFPZhmU32rnXTiwrF3PUcH3mjUr7v8atbvXHy2JSOe+6ujG+zB0SihqjAHW8GY95WTZKAYQxhjJCs6l2Pn/TU+lRxXzYQ6vCelaUpVzTzJUo5CGxU6n1K9fd4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAuKAm1c; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e931c85710aso1869671276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252220; x=1755857020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kWEJ5Yv+tWrbgEd0o0fIg1MyTUWmV3rR9qR1UZ22wk=;
        b=KAuKAm1cE7JHTOWoqRNNFMAY0yMpO8Q3B/XNIuO6Adtg/vpW+ya5jL5CLu646PoUPW
         gqL2HTPLY11tQKT0oDIkOnIcd/Ps+MuGCix4NhLDyk3pd+2H/n+nDiK2eNwiLBabqIzQ
         dzNIY39dBRWjDihm9NUVl09MyC+XtZgk2c5J68DOeTmKNDZ6uP51bcVRAMHT4Z38keHc
         aQnKz4tsjbwYgwx2HW5VrSQ4IHtkW1bUWFsJYvjcOZTEP6QoXBb0XBQ8IYuiH9vmNDnr
         HKFZ0At9D85l6WLTIhBp+vv5tWqW83GvkWPcf45lL2LrDiPS52FX9jHLx6rwLCCQjy6v
         abJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252221; x=1755857021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kWEJ5Yv+tWrbgEd0o0fIg1MyTUWmV3rR9qR1UZ22wk=;
        b=NzSUDgfoOWRZpsFV+GqgpsHAURrQiUCyycNxQs8qfaA5Zr5h0ehDcjeJM248NQnZ4+
         f4g6qv99zlsFwHTYAIU0g8Cuh4ZqAAb6KS4/i7pVZVaWbPQ2mr+8YshhT+FqDQXhfZPX
         ZL+g4FEWsNY6xbkbiXsBNMtE//eHnxnwnqYoQn2OvfTBDiT2kzHehP0zSm/fjGj0aGoS
         vVTmGLWEV7oSFru6PME21a0bT1ENJyYNUoUWgzpTBH32WqM81qU/qZagnSEfMSulOdXK
         9/bOyC9is/VHOLfxC7LcRoN/DhVu37WQZhxezeNO6NBbmuHeN9BxcZYt1WxVnvomXEB6
         4mSw==
X-Forwarded-Encrypted: i=1; AJvYcCUWboUowqQQYgu8T4xHFj+2eTEVmDE5FhUZOIds5/gL/wRtoGyuNWac00++lTWfknabUrvzgSLHkPXNSgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjGRBqRr6JDYM0FFYeD3qZIVYjRNcvHmW11jY+DvV3mWWApF1
	KygEz8ha4ug4aQsmjB7/WgyvbQXd9XbyfmFkfSEQuWDSZB307E3Ru7BxA8SnhVGZIC/ALvxlZlV
	sLAbaHgS/EM+aMazEhsTOO3qWtmIdTP4=
X-Gm-Gg: ASbGncujyEbdysXMaB4UAk96zIdDwImjkSqqFMd0R7MipYRlpnY1K9/yPhd2ptZeIkD
	z4uMTl08aPxCMrlmPKRvC2a6SfwlUTwR3jB9lxrNL124mh52Cu9uuFM/Dy2qSYnNGt1nfaWotmb
	p91IJtlEYlNqFgsP69Vzkp5gfp7QZ01ea56L04IVFb+/Eb+Z+57oaUBiZqcAsfvbAnY5SJiFxHR
	rC3MDU=
X-Google-Smtp-Source: AGHT+IFElb130hQA0niGb/AxfzIzZBeWjQ/NQ8ze3wVSSEt8Zw42HJuVPpCVdrqETxWs0cjWCmUbBE6F6RFk8gTNhJU=
X-Received: by 2002:a05:6902:2b08:b0:e90:6c17:7e2b with SMTP id
 3f1490d57ef6-e9332526f44mr1857610276.49.1755252220413; Fri, 15 Aug 2025
 03:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814133527.2679261-1-xiaqinxin@huawei.com> <20250814133527.2679261-2-xiaqinxin@huawei.com>
In-Reply-To: <20250814133527.2679261-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Aug 2025 22:03:28 +1200
X-Gm-Features: Ac12FXw8PI-x5k-_BrgGSpEfsASjNl4TwKhvhCYTe8IB2GCjmV57Cu5gI15E2E8
Message-ID: <CAGsJ_4wbgqGavjQNXtbFVeMw8j8oSCEVSdL4BrBVWEuNHzomPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:35=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> dma_map_benchmark is a standalone developer tool rather than an
> automated selftest. It has no pass/fail criteria, expects manual
> invocation, and is built as a normal userspace binary. Move it to
> tools/dma/ and add a minimal, the original selftest/dma/Makefile
> entry is removed to avoid duplication.
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  tools/Makefile                                  | 13 +++++++------
>  tools/dma/Makefile                              | 17 +++++++++++++++++
>  tools/{testing/selftests =3D> }/dma/config        |  0
>  .../selftests =3D> }/dma/dma_map_benchmark.c      |  0
>  tools/testing/selftests/dma/Makefile            |  7 -------
>  5 files changed, 24 insertions(+), 13 deletions(-)
>  create mode 100644 tools/dma/Makefile
>  rename tools/{testing/selftests =3D> }/dma/config (100%)
>  rename tools/{testing/selftests =3D> }/dma/dma_map_benchmark.c (100%)
>  delete mode 100644 tools/testing/selftests/dma/Makefile
>

Please ensure the build passes at least. If you cd into tools/mm or
tools/spi, everything builds fine.

tools/spi$ make
mkdir -p include/linux/spi 2>&1 || true
ln -sf /home/barrysong/develop/mm/tools/spi/../../include/uapi/linux/spi/sp=
idev.h
include/linux/spi
ln -sf /home/barrysong/develop/mm/tools/spi/../../include/uapi/linux/spi/sp=
i.h
include/linux/spi
make[1]: Entering directory '/home/barrysong/develop/mm/tools/spi'
  CC      spidev_test.o
  LD      spidev_test-in.o
make[1]: Leaving directory '/home/barrysong/develop/mm/tools/spi'
  LINK    spidev_test
make[1]: Entering directory '/home/barrysong/develop/mm/tools/spi'
  CC      spidev_fdx.o
  LD      spidev_fdx-in.o
make[1]: Leaving directory '/home/barrysong/develop/mm/tools/spi'
  LINK    spidev_fdx


tools/mm$ make
make -C ../lib/api
make[1]: Entering directory '/home/barrysong/develop/mm/tools/lib/api'
  CC      fd/array.o
  LD      fd/libapi-in.o
  CC      fs/fs.o
  CC      fs/tracing_path.o
  CC      fs/cgroup.o
  LD      fs/libapi-in.o
  CC      cpu.o
  CC      debug.o
  CC      str_error_r.o
  LD      libapi-in.o
  AR      libapi.a
make[1]: Leaving directory '/home/barrysong/develop/mm/tools/lib/api'
gcc -Wall -Wextra -I../lib/ -pthread -o page-types page-types.c
../lib/api/libapi.a -pthread
gcc -Wall -Wextra -I../lib/ -pthread -o slabinfo slabinfo.c
../lib/api/libapi.a -pthread
gcc -Wall -Wextra -I../lib/ -pthread -o page_owner_sort
page_owner_sort.c ../lib/api/libapi.a -pthread
gcc -Wall -Wextra -I../lib/ -pthread -o thp_swap_allocator_test
thp_swap_allocator_test.c ../lib/api/libapi.a -pthread


If you navigate to tools/dma and run make:

tools/dma$ make
cc -I../../include -I../../usr/include dma_map_benchmark.c -o dma_map_bench=
mark
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
make: *** [Makefile:11: dma_map_benchmark] Error 1

Thanks
Barry

