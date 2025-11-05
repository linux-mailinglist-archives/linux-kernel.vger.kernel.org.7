Return-Path: <linux-kernel+bounces-887383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A248C38150
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76FE4E474B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6192E03EF;
	Wed,  5 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SnfRqlJG"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BF2D9EEF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379078; cv=none; b=LGPQ5n4KuVDGhAEU5vIx27583TemNhbGAbTF4o1HmqnCdpYXGjqr+nnBN43SkSGyhhEsv5am/LPuWT/pa/oN9/Il//K0Ac8OwQ/s1tznqS/Ur1imLkJmlfALmzWCRC5OLk8gu/luo+Ngio8S3qkVKPwVi7jbSS1atBTzfP3X4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379078; c=relaxed/simple;
	bh=B6+nsdGT18NH1NE7AX6pjoBR3M3Xcnw+DDIVghMfGrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guANYE87+Qipa1xGy+PKV0kUKJLYBgGwLE251M1jv/2EeTBBfSUZEFR3XOGYylpmzXoi0P/ePWY2DuTWBG09tOLqdxD4s/PqfJXzmi0rgJf8+XRE0YvxJIVmpsWo31oDBKuWTOjTBBtjpCNnTgrjJJM6rqxWpDmfAvH0gAHgw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SnfRqlJG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b9ab6cdf64bso616896a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762379075; x=1762983875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVWjaBUX/7qo8BA7ZtqqS8rCRLhaeeey8yCwyWWpyLA=;
        b=SnfRqlJGOgKT3+bxUU7kyzbiIMHh0B1TqQeDgYLUDpSV+IMmK8FBayXeg1lr1aRnyc
         mb8v6Eusr+kFO2/ZDh13Et3/RpY0j4Tf5B1tlNqGWEPTUzdY/8HhLkUeboMzoaH4Sz1k
         z5Nu7ogzDuMzwzzMTJoktpRAKUtPRFQGe71adkK6XLvSJ4+tursLa32iMmbF2/jzSRKx
         YjdM6iWxEAS2olx7bHYbxSPavrZyK58Vg8RggHGdXTWGdHQI9hklfBEJ5x10F4zd1KM+
         mNYCPMHlVG5vSAIwshJuEpkCG2qyzgDCc4+ZaSbMFUkwbM4lSYegCmspdzzIn8+8DaTr
         +aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379075; x=1762983875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVWjaBUX/7qo8BA7ZtqqS8rCRLhaeeey8yCwyWWpyLA=;
        b=xOL2MADxsCG91RDLugp4fxxA3q7hfOGpmJOt1f/4WyAYDXTcfXL/Gy21zvVc8HpYlZ
         cyD8UjEyeeZy0YVH/2+Jkcu18GYFWtqbz6UzgIRXPh1syZqV8t6NnbErmbFJUuScrezP
         1ke+VMuHcqXe5TwU0Tm4Bfsbi5sBWBCu++6xP56CURfpYCxBkzVJnJLqK62zo8PO4Zqt
         IJAE+YukTkOiq3BleahoH72Q8rfklog/XEghNQzRYDUJ0DeqMuHLmL6DxaDpr+NZqIj7
         ruyojQyqPs31tUX0IVy4pDdKjLFaIfM+axlFir4XdmNz/CibW2DBzQtJVfCRiT/DOEwB
         ryAw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqQtG9OB8Rs3u32EuSA/ATCnvSYrOgYVpcexDkwkVISgH7GKYtXZPjl2vh9paC3jleuVlRUh8sQoG0/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQ3lVdSrG4z+cKOkfhnbjLMSjORjO+14LiDSEMaKzdAXCVXyi
	OB7JwHRwBsPogCMvz8BOdlS0ruHF2C1h7YxSHPoVL/7nZ+b+JoXVOqSZt6jXPzY44r3afRqHerd
	cFxs9
X-Gm-Gg: ASbGncviWQSj43AxyZGUcCP11nqguuTzAAO7rCWN/jgkI6PFzoE7GGjwL1yGImgitRk
	zpNxLcZFOnvNzXGUZ7zSMsUqk0Iohl4jYdXn5b3+m9Xsvoau9CvugOi3SdIxUzkqwuEfLE3O/jM
	wBIgl6wXxSnDIbV1EMNRLf4r5lHfee+TmTt7Zq/zQeBxUJc/0vm0J82r4RkmUuVjtI8qTLz7hYl
	17mHaC6pIsCsJP48z2HKFhcfwKJt8ykg0m3ddAFHNojbMyJTiNY6fr5kj4hHAC9TYAeyKKfCY8c
	JVD4o0+HkMorznQLlxZqN2npF7IzgpBYnr7c3ivpfB2l+Cn+V9iDk+DUSM9ehVKzRd63QKkayMU
	sQpE0NQ8NJcNHwYmJO6IAmPLeaYOPrVfhSXgogWBID2EUu0fKwCgiXPSiAAD4GQmBFtWnjtThFD
	OA7vqMMwi0RgXYJtsZCsp8
X-Google-Smtp-Source: AGHT+IGUXuJp7B/Bqhn1WfKPsfAi2Zuz9PdCJSW9ZJXrA1YTaDItIRj/GRCMIgOV8doaMwcDTo+VDg==
X-Received: by 2002:a17:903:2f87:b0:295:57cc:cf9e with SMTP id d9443c01a7336-2964e9de802mr11033895ad.0.1762379075518;
        Wed, 05 Nov 2025 13:44:35 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm5273375ad.11.2025.11.05.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:44:35 -0800 (PST)
Date: Wed, 5 Nov 2025 13:44:32 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, Michael Ellerman <mpe@tenstorrent.com>
Subject: Re: [PATCH v22 28/28] kselftest/riscv: kselftest for user mode cfi
Message-ID: <aQvFQM38u0iwSlJ8@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <20251023-v5_user_cfi_series-v22-28-1935270f7636@rivosinc.com>
 <CACPK8Xcm2SeSStk2EBEcUoyiUc0=d6ce_MfnP=ce3z6MMXyuiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8Xcm2SeSStk2EBEcUoyiUc0=d6ce_MfnP=ce3z6MMXyuiw@mail.gmail.com>

On Tue, Nov 04, 2025 at 05:42:04PM +1030, Joel Stanley wrote:
>On Fri, 24 Oct 2025 at 03:33, Deepak Gupta via B4 Relay
><devnull+debug.rivosinc.com@kernel.org> wrote:
>
>> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
>> new file mode 100644
>> index 000000000000..55165a93845f
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/cfi/Makefile
>> @@ -0,0 +1,16 @@
>> +CFLAGS += -I$(top_srcdir)/tools/include
>> +
>> +CFLAGS += -march=rv64gc_zicfilp_zicfiss -fcf-protection=full
>> +
>> +ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null > /dev/null 2>&1; echo $$?),0)
>> +TEST_GEN_PROGS := cfitests|
>
>I hacked this up a bit to get it working for me.
>
>I added this at the top to use the local headers from a `make
>headers`. Without this the selftest lacked the required ptrace
>changes:
>
>+CFLAGS += $(KHDR_INCLUDES)

hmm weird. In my case it picks it from location where headers get placed as part
of build (or make headers_install). I wonder why it's not happening in your
case. In any case, I think this can be added.

>
>I needed this before the ifeq so it used the cross compiler to perform
>the test, otherwise the test was always false:
>
>+# Check for zicfli* extensions needs cross compiler
>+# which is not set until lib.mk is included
>+ifeq ($(LLVM)$(CC),cc)
>+CC := $(CROSS_COMPILE)gcc
>+endif
>+#nedif
>
>Findally, a cosmetic one. If we set the name of the main test file to
>be the same as the test, the rule from lib.mk will give us neat
>output:

Sure, make sense. Will do that.
>
>     make[2]: Entering directory 'tools/testing/selftests/riscv/cfi'
>       CC       cfitests
>
>--- a/tools/testing/selftests/riscv/cfi/Makefile
>+++ b/tools/testing/selftests/riscv/cfi/Makefile
>@@ -12,12 +12,11 @@ endif
> ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null >
>/dev/null 2>&1; echo $$?),0)
> TEST_GEN_PROGS := cfitests
>
>-include ../../lib.mk
>+$(OUTPUT)/cfitests: cfitests.c shadowstack.c
>
>-$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
>-       $(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> else
>-include ../../lib.mk
>
> $(shell echo "Toolchain doesn't support CFI, skipping CFI kselftest." >&2)
> endif
>+
>+include ../../lib.mk
>
>I can push up a branch with my changes if you'd like.

Sure, please point me to that and I'll pick it up. Test locally and send it out.


