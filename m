Return-Path: <linux-kernel+bounces-745882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC77B11FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616251C26D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3681F4CB6;
	Fri, 25 Jul 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3HvOJUQ9"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CD1ADC97
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453233; cv=none; b=f1swiLPwbVMR5g7FWwtHw/IHgkGJaJPz9YiUI9OA6AE8kaQMRnzwkT2j5fuHUORztcYNXpArZW/w2GCewLI4y4r9D0n2bkktsOa1Kp5eYLqvLczvZcCkaVbcsHkUhzd/Wu/VWcyCLj+Afk3obsW9kUTMJPyO1RCp83OaU0jrpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453233; c=relaxed/simple;
	bh=OMwltMTnROc0x20VCZdOnkOJGoE17eDxpOQAnZCwq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUKoKShSSN4hQLRakIVQ+Fgu7ZqxlkJh3W53mCFGTO1ow+0ZVKAhJoqq3GReFeVPVuerAJfjO8NPwsmkp+ghUdB25K0gwuaXjNezHzgqWCkrqKlP1CHeAZ/9POevoIb+5zrbMMLEM4kztoLoZ4nTNmIUOf0l4YdGeABrscO/5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3HvOJUQ9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31e076f714so2360036a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753453230; x=1754058030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOelqn4iY/rsR6MxnRwx481vFltvLJp6wfVOt5IOJQo=;
        b=3HvOJUQ9f4idleQWGKNo3wrK3nMJOF41EhJf26jJ51axSr+erDLz7/5Tdj1XhqfwT1
         Xccw97DLPVj4BKW77gOd4fJUMtqDNESqtsae6dpIAIPXkqBNKexBsHoDptzKB3CLkZQ7
         uKKxIRm5L7d4X4hY5PtFtp5yQFshIe7dZF9/O/7a4V3T/PAzxrEOKWKmg4psVcEeZWHP
         WKbu2+AIRHIUYdtt7RnAsStYE0fcP9Q1c6z+yuqubR2SIEaHNBx/bCD8b1rCMZOiaGrA
         0Vtf5cp9f32tut+cwaDaLK/HfsIypqgeFoooPQVPwXJBVNep7bJdsfQ3W5413WZgEtkD
         I2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753453230; x=1754058030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOelqn4iY/rsR6MxnRwx481vFltvLJp6wfVOt5IOJQo=;
        b=TS7PDaCmRIcYS0YVzlhTDne0hSg/bnWg/U64FEjDo1Ut/zlr3Atbw8G+GrF5BMNel4
         8z0Bx39ZBFOIhdUYrJgXAlO5kaqs6RJZ9NvHB0ojRwDLxotRg0cCrRBAx5lyGs8JhK2N
         Ebrf/p/dLjXU9UuVIkQVBl4n0pE38dA7+TK6GhrlFtfudLsOF+UL6cGymb3wXsH5fE2P
         aHcBdBIOMhXVlIaUEPU00qS0x14Bp7FI/3UiiQz5RY00QbnFjDcFw10F7Jq762Gh9XXP
         rAXqBmbzR2X8uii6dCc2+Kgx/dXKk/g0/vi7qeunV5L8yZv+wAFcWH9B1mfuOTx2Dn2F
         qjAA==
X-Forwarded-Encrypted: i=1; AJvYcCU0iXZB8G+4cOxJFJiYOPUjjUODY8zpSXmxm764DU1Hu6axx+oOJRP/53CNyUil89ijD0HY65qc/ltmyXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbclI63BVgcpaYaZymqal1c7JEs9aFl+oPNAvACv9tKDcGrLd
	Yu42WxEc60zAqr7AiInj7kIU4FVOqVZ5FAdDeRZO6yDlCKU6Ht4J2CznWqEEJcZqmeE=
X-Gm-Gg: ASbGncsIvZrcF4Kae3xJGJBP4QhqmHr82e4R/WC3tajeCaoz31iSOfMcxl5TZ+9tUFI
	qTxv3FlSMCHYxcsnuc0MPdeOjRorocztDwDnBqcVYxT02VoOgjlrQLMm+lQRg9Hc4ZWbiKIC658
	YEQq+6zjcRqM8aPgUfbj9/3EDn/AqmkFvOWoWw+JN5wF19s6aqTWv/G+AAc6py57Bu22NqhiJDD
	yUxjY5cV4qexRK4JIcJfFixQLPj3lW79lZ15yqDbiAlGt7CWT6wB3LLga9+EiR3VP5DwYS0YaiV
	nswBYTOeeigTFzrl5epk+sZuL7VkB0/IucUZAe7RizcnonEfZ+34ZtzxvgAU/5uB9WF7D/WahwC
	0D7s1bwqLEkr73ioN+oYk6t7zZLooKDc13a/pnZKYyDY=
X-Google-Smtp-Source: AGHT+IFnToE7Y9m/LQB1LHyZJTXUY15A+gO23FToLy9nHc/JxiCSxR6k0MWES+brycAIrDFP11y4GQ==
X-Received: by 2002:a17:90b:5407:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-31e662e8312mr8688402a91.10.1753453230029;
        Fri, 25 Jul 2025 07:20:30 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e60a61628sm2176473a91.1.2025.07.25.07.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:20:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:20:26 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, samitolvanen@google.com,
	apatel@ventanamicro.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com,
	samuel.holland@sifive.com, bjorn@rivosinc.com, fweimer@redhat.com,
	jeffreyalaw@gmail.com, andrew@sifive.com, ved@rivosinc.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH 05/11] riscv: enable landing pad enforcement
Message-ID: <aIOSqskb_hBAqjIt@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-5-04b8fa44c98c@rivosinc.com>
 <1149732f-bc8d-4339-90c3-e34aeac9f1be@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1149732f-bc8d-4339-90c3-e34aeac9f1be@canonical.com>

On Fri, Jul 25, 2025 at 08:33:46AM +0200, Heinrich Schuchardt wrote:
>On 25.07.25 01:36, Deepak Gupta wrote:
>>Enables landing pad enforcement by invoking a SBI FWFT call.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/kernel/asm-offsets.c |  1 +
>>  arch/riscv/kernel/head.S        | 19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>>diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>>index e4d55126dc3e..e6a9fad86fae 100644
>>--- a/arch/riscv/kernel/asm-offsets.c
>>+++ b/arch/riscv/kernel/asm-offsets.c
>>@@ -536,6 +536,7 @@ void asm_offsets(void)
>>  	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>>  	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>>  	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>>+	DEFINE(SBI_FWFT_LANDING_PAD, SBI_FWFT_LANDING_PAD);
>>  	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>>  #endif
>>  }
>>diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>index 9c99c5ad6fe8..59af044bf85c 100644
>>--- a/arch/riscv/kernel/head.S
>>+++ b/arch/riscv/kernel/head.S
>>@@ -185,6 +185,16 @@ secondary_start_sbi:
>>  1:
>>  #endif
>>  	scs_load_current
>>+
>>+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_KERNEL_CFI)
>>+	li a7, SBI_EXT_FWFT
>>+	li a6, SBI_EXT_FWFT_SET
>>+	li a0, SBI_FWFT_LANDING_PAD
>>+	li a1, 1 /* enable landing pad for supervisor */
>>+	li a2, SBI_FWFT_SET_FLAG_LOCK
>>+	ecall	/* check for error condition and take appropriate action */
>>+#endif
>>+
>>  	call smp_callin
>>  #endif /* CONFIG_SMP */
>>@@ -359,6 +369,15 @@ SYM_CODE_START(_start_kernel)
>>  #endif
>>  	scs_load_current
>>+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_KERNEL_CFI)
>>+	li a7, SBI_EXT_FWFT
>>+	li a6, SBI_EXT_FWFT_SET
>>+	li a0, SBI_FWFT_LANDING_PAD
>>+	li a1, 1 /* enable landing pad for supervisor */
>
>The SBI specification calls BIT(0) "LOCK".
>Shouldn't we define a constant for the lock bit instead of using a 
>magic value?

See below `li a2, SBI_FWFT_SET_FLAG_LOCK`.

"li a1, 1 /* enable landing pad for supervisor */>" --> this is enabling.
Had we done "li a1, 0 /* enable landing pad for supervisor */" --> this is
asking firmware to disable the feature (turn off the bit in menvcfg CSR)

>Best regards
>
>Heinrich
>
>>+	li a2, SBI_FWFT_SET_FLAG_LOCK
>>+	ecall	/* check for error condition and take appropriate action */
>>+#endif
>>+
>>  #ifdef CONFIG_KASAN
>>  	call kasan_early_init
>>  #endif
>>
>

