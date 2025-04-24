Return-Path: <linux-kernel+bounces-617281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5500A99D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC83BB1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738B78F2D;
	Thu, 24 Apr 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fjSpfiQ0"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51459286A9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455559; cv=none; b=kHZdwnovz8kWXhofkBiuLnZvqCAeCmb9dQZFOAgBnRtb4y5i/kN7RoSntHec7TIMC+RGZbVrLgxl7Ba42IbvOvWXu811SJqiWgDuFuC5WNKl/nbvoaRhRBp/ha+P9/7X45L0uXcKtoYqanFCLE//Wu1k80hABuW6tUsJRiOqht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455559; c=relaxed/simple;
	bh=Oe1WMqLBDyQWCK+DSdDYKohiPHkUJKKI27mpm+YppJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu2rE9vzs6+tA3Sxxk7oDkFRazNXwmnW6EXio4c2BvBL3PrU7Ka/sIX1kTh5WMjwLkcZPDQtB5auDTsm3ItZTVfV5FWONrZ+gyDCSHIIZ8BluYLumzIoFQ9MndSA5F47QZ8gxenVh53pdAZa4HRox+VycmuFLmFjwXnGIkQVZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fjSpfiQ0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b074d908e56so257602a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745455557; x=1746060357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CC8T5V5ETxB3aI46jMwjb5xUFdEfDSmv/WDvLTa/TKM=;
        b=fjSpfiQ0jb0rg/Iv97V6TVHy0ZixEk5tF/NG5IuJtd4x71GOt6/Zl0K5IjL4BEbLos
         7erQ19j1Vahx1AdqHbNPlfFK7zAvylLSYxMXWexB69NxhdptjkS+O2Zi7ucN/mbKfdbz
         GbTd2Vnog+pixLx4WnEeIE5mjqp/wvwdLYAMAz99gvtkAa0cSfOBj8xyx0tOCm2tdqgF
         mZquaBAqbgJBZAFT3wR7J3r9u9u630YvWTjil1DZXAhWqIwgaAhDc1QPUPhI5LuVN97j
         roPDGL2gcn0n+pCwutY4XrMWmmt+9TYT9YaJF27K9fPs2p3FVeir6qUi65x28uuOs18S
         SqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745455557; x=1746060357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CC8T5V5ETxB3aI46jMwjb5xUFdEfDSmv/WDvLTa/TKM=;
        b=Nx4uM1ne4k39Yxh51bW3XqacaHfXvqaK2lfmDkiDOc0hP0GKF1WoE6b+PZEXH49Hwm
         B/v/d1FPZA0ZjLxGJdO7T4zo00H+kujyhX57uDdkM2sgmNTgkYBQOkr1/TRJ7aJHrq1o
         tBkfdTwZpUay/KOw58p+ni3D2a2n+RZB2O7BqojBnfWkK5Le0BAuJr2YIjW9Wvx89qCe
         ybItjP+aRmcje0uPWfmr2Xm6/2okCAWQAKG2r+OLUJ/VEX9ipuqJNNuAP5kOVQrF8gZ8
         4gKSWm1onPSKM4LfaF+1blE7GEw41i9RKnpCHr0jzm5GDqyVlgavUGX81TXdELWzQYeB
         AlCA==
X-Forwarded-Encrypted: i=1; AJvYcCXeIfcdUUFVgh+cMjhbJUSBDRFpiTzUUwW2a87SDPZQuttjrca8opCT9Vl9yxENerdT15OOcWVM7e2F2L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTEyMiGNeAakLnuIq2ljIWGLUAY7enVgKR5Uc53kn9xp8Ooqg
	VqRmIAsXmhH30vE3QxU6SNvqsGCLKPtT29hzehQbPQcepiTi/JnVfw5wJSyleGc=
X-Gm-Gg: ASbGncvCII+lVeFFZzPK+bBnQqawYj/HLqzhgWrcyUfkMUJ105evpX2nFbkdGN+UMkR
	OmkNwRTuVoSPdEHq0/rikelG/P8rXFhi04q/vXDRgeuLEdL4/fvb2ke0V3S+lYZCos4eNelvz4w
	7BYQ3mwDmr7MY/SEVsKDnlQhiDof6rzOWY1eJfd4Fg2KN62E0u7bk4a07uPQOX/N6Rkz+MHTG0/
	ZzdFRrgbWDe085CY7yzN9fAcC9m8m4oyj1qf6qv8NGG0sgmfRop0XQ0LaYr3CcJEnbwBPXewRAf
	2c9Wz8GYmcY5obkIh1RUM62ZNqXF3atuZ/v2D/utirq7siQJiLg=
X-Google-Smtp-Source: AGHT+IFSRc4jFZIKl/995vivdy0v1krVWENkLmQTo2FqdjSK7VIBAtsfvTZB7Ln0D+cPb89ZAHZGNw==
X-Received: by 2002:a05:6a21:9984:b0:1f5:8f65:a6e6 with SMTP id adf61e73a8af0-20444f6b564mr805436637.27.1745455557578;
        Wed, 23 Apr 2025 17:45:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fadec8c0sm113497a12.68.2025.04.23.17.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:45:57 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:45:53 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ
 | VM_WRITE
Message-ID: <aAmJweehK4ntbVoO@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-6-e51202b53138@rivosinc.com>
 <D92VG9GT3W5D.2B71FBI67EYJ6@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D92VG9GT3W5D.2B71FBI67EYJ6@ventanamicro.com>

On Thu, Apr 10, 2025 at 12:03:44PM +0200, Radim Krčmář wrote:
>2025-03-14T14:39:25-07:00, Deepak Gupta <debug@rivosinc.com>:
>> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
>> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> +						   unsigned long pkey __always_unused)
>> +{
>> +	unsigned long ret = 0;
>> +
>> +	/*
>> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
>> +	 * Only VM_WRITE means shadow stack.
>> +	 */
>
>This function also changes PROT_WX to VM_RWX, which is effectively not
>changing anything, but I think it deserves an explicit intent.
>(At least in the commit message.)

Will do that.

>
>> +	if (prot & PROT_WRITE)
>> +		ret = (VM_READ | VM_WRITE);
>> +	return ret;
>> +}
>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>> +	/*
>> +	 * If PROT_WRITE is specified then extend that to PROT_READ
>> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
>> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
>> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
>> +	 */
>> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>> +		prot |= PROT_READ;
>
>Why isn't the previous hunk be enough?  (Or why don't we do just this?)
>
>riscv_sys_mmap() eventually calls arch_calc_vm_prot_bits(), so I'd
>rather fix each code path just once.

You're right. Above hunk (arch/riscv/include/asm/mman.h) alone should be enough.
I did this change in `sys_riscv.c` out of caution. If it feels like un-necessary,
I'll remove it. No hard feelings either way.

>
>Thanks.

