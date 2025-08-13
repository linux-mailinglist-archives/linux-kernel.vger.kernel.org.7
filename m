Return-Path: <linux-kernel+bounces-767305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD2B252A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A17F721F16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D58299A85;
	Wed, 13 Aug 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmbJA6Gs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C129B205
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107780; cv=none; b=T5x3/hvzWCkeBc9tGqtMam+Ge1Bi1f8z/EwzFmv1l/WIOkNlOMz6o26WKCWvvA21aOCNj4BMlxS8uFgtMdgFgIqTmQkw3nD3EToyyVJVSXd+mar/tUzAeopCjWvt6BThoc5/mZmsmK3LqKqAk1Sg0bO+FSg2mqN9lQmco9OoRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107780; c=relaxed/simple;
	bh=nl2yBpZRvTfmVxRWdsIQVBAvauFmBGisrTQMortALrI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GU1T6gh0tA7d8S9ZVMJtGQK7Y2KRlTaWKzvw4+G2F53NGyslhkKPW1lOxMDv+ypV+0SfdlO91DyUJevPTXZtFlDHwRH7xg3HOJUEifBqTwCDygPqrNFhzv2Phmc7SankWu1OW1rK/z//Vysy7lXoOa+6WLymPgou7EOqVeVfsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TmbJA6Gs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457f581aeso379815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755107776; x=1755712576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XoIq2ubOlyxbtRkYBP/TzvBun/sOOkbTC4CyxYULUYc=;
        b=TmbJA6GsiVIs2SumeH5hEovkr5pUXWzAMSjmTnDZG9VIK9JvIpZOUQvoUq4LYWXyXA
         xIQjAgNqzJwL1u5tO4fcHEojDEO5dwLEqXjxD6sUM74zhu/h9rQUvpYoQ4MSIylapyE2
         DA/m3TBetmucpbKINOhcB/6yhG0J1jbq69+/D8DQeCQEwc5q+OtLU7xpm86qudgZtkTX
         zkiFtqsxGW5CPbGL2dAvpVjeR/X4aUmVY9ZpTlJ44DR4BmsiZQtrajmCOuGRtKA9VHLp
         kb5uRJ7SpUPT5TpT8TuMURksA8cAw96T3/gCathA11RA6YepZAm2gjXlW9wTOS6bwpes
         kwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107776; x=1755712576;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoIq2ubOlyxbtRkYBP/TzvBun/sOOkbTC4CyxYULUYc=;
        b=J8LBO3HlfDx0vD4HifchDF6xSHPKyPY5Cm395ZXzg1exLB9f0IWOUc/3NZhLp5t+ic
         MfJ5dOf5J+XSpUPFAjqnFIWk0l/fuXGP0sl8nSgvjINyqqmD6jNrAjpmxHgFsdyxCJnb
         27xD9bD/NzyEl32VcUbVFx+yMvBMUEnZeOcyvGRYpNzOHlmsJz9PrO2EXL81Gpuf4nYA
         KW+huYO99fXx/n0DtHMZ4bOnQfooS0OEKreJFhxsIV08zPhqZtFnrdDM8mElQCaFJHYO
         crYt8LknKg/Gq/c30SNtVY8SUkETdzQ+hKyjAeeEaFG6b1PK5HXTN3rVJrXWm9IGpUh/
         7thA==
X-Forwarded-Encrypted: i=1; AJvYcCU9OGwBBdGK8gNb8oN3bgJgd/yoVOovvshvxjrnf2Jgzgzfl+U9wDTZVH9We8O6bqKo+f7Tbvdm+2K6ReE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLRYMKswCb9aJo47BPH6Y8Gvdh618zhT3NcdZQXGSt8d9NY8v
	I3VOJEskd6VktgL3EyKRlzzWHOl3A9/MMdrtzTd5ylsjF4GkThpaBG5QiYTiw1wj2hFckQrYQN+
	8cCW7GdJKv71KP/jV0mqnGPxL5nAQTGmTaBfl6AOGPA==
X-Gm-Gg: ASbGnctKy2bKoEo2FzwBifHy3psVmGTXxmD691a7hNEgUAex3X1zw6/7K2h5++WYkqG
	yq8EmRcoLBKuDsV/Vqi3kH3qb+keYY2IMk2VBEw5Gh4gq72cCG2TlD9fo7TVcua9z2ZQMXWxC1R
	id1Y2tMy/Me/c7Bz/O1UCa9VVNjAvuWLFDxT8KpY9OMirFHvAMwMxVHl9e0jkTh6eucCpgcjhl0
	trhnpSDMJe00o3wVaytGffd3FSIBGxt9Xrogqg=
X-Google-Smtp-Source: AGHT+IEkiAGoLbMGkvXnlFSqPQ+NERPuNoFrCDcPTgVm2ojJsZrVhHUi72yNXNyT4cDONEDGhe3E10OKGjZiy9tS3ck=
X-Received: by 2002:a17:902:e5c1:b0:242:a0b0:3c1f with SMTP id
 d9443c01a7336-244584af50amr128565ad.7.1755107776617; Wed, 13 Aug 2025
 10:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 23:26:05 +0530
X-Gm-Features: Ac12FXyG0YWZ_N3cTY6hqEM4R9dYMT1co-eY8G4uUHRenE8ObEitphecfPJYjck
Message-ID: <CA+G9fYtJPqkugHFbgs8vNK5jNGivX1yO1ZiL2q97c_dazUiArA@mail.gmail.com>
Subject: next-20250813: x86_64 iov_iter.h:171:7: error: variable 'remain' is
 used uninitialized whenever 'if'
To: clang-built-linux <llvm@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Regressions noticed while building x86_64 and i386 builds with clang-nightly
and clang-20 toolchains on the Linux next-20250813 tag.

First seen on the Linux next-20250813
Good: next-20250812
Bad:  next-20250813

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

## Build regressions
* x86_64, build
  - clang-20-lkftconfig-compat

Build regression: next-20250813 x86_64 iov_iter.h:171:7: error:
variable 'remain' is used uninitialized whenever 'if'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
In file included from net/core/skbuff.c:66:
include/linux/iov_iter.h:171:7: error: variable 'remain' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  171 |                 if (skip >= fsize)
      |                     ^~~~~~~~~~~~~
include/linux/iov_iter.h:190:7: note: uninitialized use occurs here
  190 |                 if (remain)
      |                     ^~~~~~
include/linux/iov_iter.h:171:3: note: remove the 'if' if its condition
is always false
  171 |                 if (skip >= fsize)
      |                 ^~~~~~~~~~~~~~~~~~
  172 |                         goto next;
      |                         ~~~~~~~~~
include/linux/iov_iter.h:163:22: note: initialize the variable
'remain' to silence this warning
  163 |                 size_t part, remain, consumed;
      |                                    ^
      |                                     = 0
1 error generated.
make[5]: *** [scripts/Makefile.build:287: net/core/skbuff.o] Error 1
In file included from net/core/datagram.c:53:
include/linux/iov_iter.h:171:7: error: variable 'remain' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  171 |                 if (skip >= fsize)
      |                     ^~~~~~~~~~~~~
include/linux/iov_iter.h:190:7: note: uninitialized use occurs here
  190 |                 if (remain)
      |                     ^~~~~~
include/linux/iov_iter.h:171:3: note: remove the 'if' if its condition
is always false
  171 |                 if (skip >= fsize)
      |                 ^~~~~~~~~~~~~~~~~~
  172 |                         goto next;
      |                         ~~~~~~~~~
include/linux/iov_iter.h:163:22: note: initialize the variable
'remain' to silence this warning
  163 |                 size_t part, remain, consumed;
      |                                    ^
      |                                     = 0
1 error generated.
make[5]: *** [scripts/Makefile.build:287: net/core/datagram.o] Error 1
In file included from lib/iov_iter.c:14:
include/linux/iov_iter.h:171:7: error: variable 'remain' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  171 |                 if (skip >= fsize)
      |                     ^~~~~~~~~~~~~
include/linux/iov_iter.h:190:7: note: uninitialized use occurs here
  190 |                 if (remain)
      |                     ^~~~~~
include/linux/iov_iter.h:171:3: note: remove the 'if' if its condition
is always false
  171 |                 if (skip >= fsize)
      |                 ^~~~~~~~~~~~~~~~~~
  172 |                         goto next;
      |                         ~~~~~~~~~
include/linux/iov_iter.h:163:22: note: initialize the variable
'remain' to silence this warning
  163 |                 size_t part, remain, consumed;
      |                                    ^
      |                                     = 0
1 error generated.

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250813/
* kernel version: next-20250813
* Architectures: x86_64, i386
* Toolchains: clang-20
* Kconfigs: defconfig

## Test
* Test log: https://qa-reports.linaro.org/api/testruns/29479215/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250813/log-parser-build-clang/clang-compiler-include_linux_iov_iter_h-error-variable-remain-is-used-uninitialized-whenever-if-condition-is-true/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31DcGmmPgATtnxuFKXwu6DM9bZu/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31DcGmmPgATtnxuFKXwu6DM9bZu/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31DcGmmPgATtnxuFKXwu6DM9bZu/config

## steps to reproduce
 * tuxmake --runtime podman --target-arch x86_64 --toolchain clang-20
--kconfig x86_64_defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

