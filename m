Return-Path: <linux-kernel+bounces-782550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC63B321DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D6E621B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09329A30D;
	Fri, 22 Aug 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="bowIBjw1"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F0299957
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885601; cv=none; b=IpTu9aegvc4YrEWboKnQ2nkQ8zRQ2CYipx3B35ts1Xuht/XePvbeRhBlhqhNC6nOSzLz4fZbYdAu6r0FIR7KdvR/S0wbUrcUFUMKkZWJhgUMKMCkuR6QySKz4t8lrUYug5c9oxLGpNxhhCWVIx8/t7+4tC58ov0TsZwWWISWezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885601; c=relaxed/simple;
	bh=QjGUX/IavHKYnweyZiQnCgeIEp0Qa7sid7tkHYHTpno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMx9aw0Qkmy/XS1aUnoag0I3jqzTRMuoyfi93TyVosNwPY2d/hCV9cji0r2xiU8Gu6D5DTtvUSD1ZWYS1o8ll3mkcCYujhYQUd5fSC8hduAc+FBTA1SgInqWwgzORCl1YCPeFBXyPHuCPAQrdoMTelIQdSuvu3FLVusGLCbgjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=bowIBjw1; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b17531009so779935e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755885598; x=1756490398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9fNzpGQYiY8hUTovQusQUuPvFziC263n9KoSaKQGOM=;
        b=bowIBjw14hcCMcXEFQelP3F/IgxTFZDchFVES0znmztlohD5OqknGtwUauveTSnrWI
         d+g9ASlXmk6+S6w0s3lsxdo6K/nufGMQFXIZwbw9iynSEugqPGnB9tqXpw0Hcih9Onui
         iijzOiiuMaPBArTtbShD9NF713MkistmOXciz2PZKEmS10o7BfeUpLVebc5fgDvwRzKP
         xg2jY+GCeh9VBOPo2w7FXx5csbaTRSS94Be+Y1ueb3eVtMPtYQMLwwwYnbRwA83bIx5T
         3xrWnQYIygkpgtWfsU2DBLyYmw2+EVYgNGEEnHrWCUL7dgBJzqPflfVugdJwqWJfRBi2
         TVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885598; x=1756490398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9fNzpGQYiY8hUTovQusQUuPvFziC263n9KoSaKQGOM=;
        b=ICyoJtz65tOsjXvHRfvc8cMIH1/oxCGU+Q+uLxZ/p8iP2k12NoDUT8dwALQ4zqrox3
         F5iRWpKawD2c/K4Sip0Snqae3oV4UH7D9A2Agm4NO6IDKPbmzp8TUzcZDFODjP0amsMc
         qhgFV0wZ/muWtJn29OCLiPo5dprchiMM1X1c8nTXC70e7Z3RoklsU8fioC73nLoAVrFP
         DQgLjQw0YocrfHpt6lM8lI4fZiehvLgICEsZS8IBZQxI2l3tk/9LgUL3EgYA9PeEZdf5
         D5bjgj0kjFM6Ifm3bT5EqtmiTHf72fhZ3B4XQ4ZdGmTSEe3OBGq23egjyElVXwu+PEoW
         oV4A==
X-Forwarded-Encrypted: i=1; AJvYcCW2EmB5mCeTxMsnzk4o/+tYrA5xSBKNBAPIXtJ6nqIleBbRYEwklp2xRbA57PKOk6HbCKjss+Xw9veN8M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSi9zRHYLu7U8krLqp0QaDMB/EkiIA+ECyKcj9OZ07bKgYEj1
	TJih51sioeM4wKwoMoFeuSs+Z95wWZvzpY5EhhM1nikVjWUlRQAgzhecGDTMdpYmg7nJUMSyyzr
	n4bGa9jE6kA1S6qF1cetzkMSgO07g33HR4jKuTrVAug==
X-Gm-Gg: ASbGncundy6NqzipTgszmsvXyH74Dgtn+SD9aM04WdrHEnGfevEHKUIA/BaxjUPK/r5
	YO4m53kcEQG4OQcM4YnAz4F8FbMYJjy2mpTA9EcMdeT/yDAg88PggzpPMMeQi6rbxan+b7G6KN1
	YJnQE/gHgYAZMlJxnOOTioN9n8Vb+H1oWs9+iyXIijSwxQm4LYdJOB3EOwyXaVCsOiMSZkQnAgV
	gpu2rze
X-Google-Smtp-Source: AGHT+IGn5vdUvXU42asTYKNQVZYOTWSFQylr/vzhKnTrBq4lq3wiMD7MVYIp2kAGpgvKTA1X/43JEESbQNKODDhNtrQ=
X-Received: by 2002:a05:6122:2502:b0:539:27eb:ca76 with SMTP id
 71dfb90a1353d-53c8a2ea9admr1107586e0c.5.1755885598348; Fri, 22 Aug 2025
 10:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Fri, 22 Aug 2025 10:59:47 -0700
X-Gm-Features: Ac12FXx85Q9pdAS3tmJucpDWbmumN5hD5YReh0RpBOKeYl8mPi6vXHz7zLBXbxM
Message-ID: <CALSpo=aQyb+E0HHDRoXs0f5vvxJtMpCA546ROkq0e3B-ur9QBg@mail.gmail.com>
Subject: Re: [PATCH 0/8] riscv: add initial support for hardware breakpoints
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Evan Green <evan@rivosinc.com>, 
	WangYuli <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:47=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> This patchset adds initial support for hardware breakpoints and
> watchpoints to the  RISC-V architecture. The framework is built on
> top of perf subsystem and SBI debug trigger extension.
>
> Currently following features are not supported and are in works:
>  - icount for single stepping
>  - Virtualization of debug triggers
>  - kernel space debug triggers
>
> The SBI debug trigger extension can be found at:
> https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-=
triggers.adoc
>
> The Sdtrig ISA is part of RISC-V debug specification which can be
> found at:
> https://github.com/riscv/riscv-debug-spec
>
> based off the original RFC by Himanshu Chauhan here:
> https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro=
.com/
>
> Second RFC by Jesse Taube here:
> https://lore.kernel.org/lkml/20250722173829.984082-1-jesse@rivosinc.com/
>
> Himanshu Chauhan (2):
>   riscv: Add SBI debug trigger extension and function ids
>   riscv: Introduce support for hardware break/watchpoints
>
> Jesse Taube (6):
>   riscv: Add insn.c, consolidate instruction decoding
>   riscv: insn: Add get_insn_nofault
>   riscv: hw_breakpoint: Use icount for single stepping
>   riscv: ptrace: Add hw breakpoint support
>   riscv: ptrace: Add hw breakpoint regset
>   selftests: riscv: Add test for hardware breakpoints
>
>  arch/riscv/Kconfig                            |   2 +
>  arch/riscv/include/asm/bug.h                  |  12 -
>  arch/riscv/include/asm/hw_breakpoint.h        |  59 ++
>  arch/riscv/include/asm/insn.h                 | 132 ++-
>  arch/riscv/include/asm/kdebug.h               |   3 +-
>  arch/riscv/include/asm/processor.h            |   4 +
>  arch/riscv/include/asm/sbi.h                  |  33 +-
>  arch/riscv/include/uapi/asm/ptrace.h          |   9 +
>  arch/riscv/kernel/Makefile                    |   2 +
>  arch/riscv/kernel/hw_breakpoint.c             | 763 ++++++++++++++++++
>  arch/riscv/kernel/insn.c                      | 165 ++++
>  arch/riscv/kernel/kgdb.c                      | 102 +--
>  arch/riscv/kernel/probes/kprobes.c            |   1 +
>  arch/riscv/kernel/process.c                   |   4 +
>  arch/riscv/kernel/ptrace.c                    | 169 ++++
>  arch/riscv/kernel/traps.c                     |  11 +-
>  arch/riscv/kernel/traps_misaligned.c          |  93 +--
>  include/uapi/linux/elf.h                      |   2 +
>  tools/include/uapi/linux/elf.h                |   1 +
>  tools/perf/tests/tests.h                      |   3 +-
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  .../selftests/riscv/breakpoints/.gitignore    |   1 +
>  .../selftests/riscv/breakpoints/Makefile      |  13 +
>  .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++
>  24 files changed, 1641 insertions(+), 191 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>  create mode 100644 arch/riscv/kernel/insn.c
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_=
test.c
>
> --
> 2.43.0
>

Oops, this meant to be V2.

Thanks,
Jesse Taube

