Return-Path: <linux-kernel+bounces-884187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7AC2F8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB463B2B23
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D73019A7;
	Tue,  4 Nov 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="bWdHiT2c"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA9248868
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240338; cv=none; b=fWsdkMbEsOpPJWBiXY6HyJwLgYQ6jtc52+DIvLCnxBxtJs/AFE3HOFRBa6nlKnamElPhnFI/366BW5GSw6l7gEzIA+q7VENumyIz30D218wx+1an4qAUQActc6G/h17aUKyYuAzkf5HE/Qe7VvEpNBOy4J9XKD1e405Tsrf10pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240338; c=relaxed/simple;
	bh=wcrcbJjrAu4P0P/yoZVU7Hr4Ma2OCBe3j4vXga3skfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFH5D6dWe4fKxbEUoIT8aeNKyqeuo9CFSGSX/2lZIpbMBKLDJ2acxaKD9O1w3f/fZ37TvJylShxEuqNCXGQWAm7laX7ndUYbcGShvMNZYQsu0e04OGFGAwuIdWUuS6Ya1BpLT9eJAWIFnrnrY0027E2UL6kZUKma579YZIG0zaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=bWdHiT2c; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60157747so54248057b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1762240335; x=1762845135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6DhNHinDEMKrStnZak8eWQGcaJ3OpsuOyGuzffapdkM=;
        b=bWdHiT2c8MlIbDZhvYLdchQ09Ghv4kkMmtkJNuZoeMwrN5jINoTmgvEmD8PyA3HABF
         C9Y64XRBqT2l1eeaeY51eke//Gb0lRP/A7jwx7hKKH+Q9NmrTTzwAm5DC2txqcX558+D
         2VUzb9h8zBeXhe7Q4YVZLPlIhAolzl2t+oh8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762240335; x=1762845135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DhNHinDEMKrStnZak8eWQGcaJ3OpsuOyGuzffapdkM=;
        b=gY/gurMeCrMcAzX3DPUNu+4+Ta6nUgwrNa0BsMORCzL1alVzZzG6e72DJ4WZZpTd34
         Dx4u9PoFBqjQuzrlKsh/dCpzz3egeOvaCuxy8lbXfHagqvtVOYhfH9snTDBOLSWX9yI4
         cvsZ3DAdKkzRwVYPF6vUiBGy6lCg9HjNYlHM0uAOB/yh+ljTL03YYQf2qBJCqDf9BuDv
         5fA5zh7qIh8VgqrVIqZRfDGgYg126I7K21lQkNLD2B/lsp6u0xembJ3Fj3mXa5JjraXF
         O66R2IePRi6UBQzdr3r+Jd9AReqhYLVskkFo2UdYC++zl0hfPrFEGQiV5d41fWSYFslz
         W2GA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZGLPvxsRwGdoRoQvWRZFkphYR3hPZDDK7ZTZJDbh4+gmO6wzx0BFSqWnsAtgJVrevpCc/8B/xx4BqCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/MjD9wiWb9dSSV/pVwakajd1oJLpM/AEEvEcFVtXXJDkeJdo
	8DCcppzD2hBFWE51XmuA9jD0OfRyQN3eYY50ONqosySqmoJLpmDHWSFha6tUFuobRXDeDK1xDCt
	C72TLdD4Tb0hGNTVom06oEGUVHNhulZg=
X-Gm-Gg: ASbGnctDyCPNbliXMDOsTeRNt3FheM3ag18z13/GlNPSrckDHye9w1azqgjgL3tD9hq
	dklJ1NFS/qUBjqxUHBnvETvxGAiPrWlpjgqi6wsndFYh60ZlCUCV0htpKugdlw/0cET95RgB2gV
	aEua92+bcxY6Kv7kz+Mj5eKcbBZQMBuFNgF2v01RrThnSLsGloWqlg2dzjcQrTtVZtcvAcsjcVa
	zhqRCtFKQ5GAliWt3r/uZOv6wJHn37B2VlJQV+0mvFfnLsG+rKG86oQYwAm
X-Google-Smtp-Source: AGHT+IHWRyWNijx53xdxcYVGd10kXtulpgaOMtWFtsRlweynhoG6M9QlChpPQOzFPjUGlHnvC36yDWnuxBQleSiZzmI=
X-Received: by 2002:a05:690c:e1b:b0:786:3528:7a1a with SMTP id
 00721157ae682-7864842b407mr121635297b3.26.1762240335364; Mon, 03 Nov 2025
 23:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com> <20251023-v5_user_cfi_series-v22-28-1935270f7636@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-28-1935270f7636@rivosinc.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 4 Nov 2025 17:42:04 +1030
X-Gm-Features: AWmQ_bn-71oLlMqKX_VP5NpE8pEs2FlYkPOhgrus38FzpqsR57s_m7fjE9VyofY
Message-ID: <CACPK8Xcm2SeSStk2EBEcUoyiUc0=d6ce_MfnP=ce3z6MMXyuiw@mail.gmail.com>
Subject: Re: [PATCH v22 28/28] kselftest/riscv: kselftest for user mode cfi
To: debug@rivosinc.com
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
	alexghiti@rivosinc.com, Michael Ellerman <mpe@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Oct 2025 at 03:33, Deepak Gupta via B4 Relay
<devnull+debug.rivosinc.com@kernel.org> wrote:

> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
> new file mode 100644
> index 000000000000..55165a93845f
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/Makefile
> @@ -0,0 +1,16 @@
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +CFLAGS += -march=rv64gc_zicfilp_zicfiss -fcf-protection=full
> +
> +ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null > /dev/null 2>&1; echo $$?),0)
> +TEST_GEN_PROGS := cfitests|

I hacked this up a bit to get it working for me.

I added this at the top to use the local headers from a `make
headers`. Without this the selftest lacked the required ptrace
changes:

+CFLAGS += $(KHDR_INCLUDES)

I needed this before the ifeq so it used the cross compiler to perform
the test, otherwise the test was always false:

+# Check for zicfli* extensions needs cross compiler
+# which is not set until lib.mk is included
+ifeq ($(LLVM)$(CC),cc)
+CC := $(CROSS_COMPILE)gcc
+endif
+#nedif

Findally, a cosmetic one. If we set the name of the main test file to
be the same as the test, the rule from lib.mk will give us neat
output:

     make[2]: Entering directory 'tools/testing/selftests/riscv/cfi'
       CC       cfitests

--- a/tools/testing/selftests/riscv/cfi/Makefile
+++ b/tools/testing/selftests/riscv/cfi/Makefile
@@ -12,12 +12,11 @@ endif
 ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null >
/dev/null 2>&1; echo $$?),0)
 TEST_GEN_PROGS := cfitests

-include ../../lib.mk
+$(OUTPUT)/cfitests: cfitests.c shadowstack.c

-$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
-       $(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
 else
-include ../../lib.mk

 $(shell echo "Toolchain doesn't support CFI, skipping CFI kselftest." >&2)
 endif
+
+include ../../lib.mk

I can push up a branch with my changes if you'd like.

