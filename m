Return-Path: <linux-kernel+bounces-856475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC9BE4441
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F63D3B1DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6CF34AAF8;
	Thu, 16 Oct 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="doPubc3P"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79534BA40
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628674; cv=none; b=Xz6mgfA4zC0Afxwik9bRrno+proG1C6blhFomSWB/AOhdfaeqiDdS4VCC87rMjVHdL3NL74/b0azB6buVaXO7DjymVcLXBpl/lIcxYlXtjTKYbEb9TUsNU/ENHyYJPsiWY0MkBFzP2AFUsE1Ej3WJdsgRfXsk7pEzgQtFg5fgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628674; c=relaxed/simple;
	bh=9p3Gr4qeRbg0Ysh2iAnD1VpHOA3SkA6SHTG6Wu71gKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1dgKUBB+9I9OHZf2MdOwFbO6YMZSp9hTFiGfKwoxbD9a88dtb7xvATbWORdq8YY8cfTtQ3sfZa3XcZczFqPln8/kFOiDm0CW/AyuTZa/IBecHjAJSiNwLE2bz4uZ7uOC0FRO1jAx0iOQ3rjEBesOW86rD27naY4PXRlH/Docl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=doPubc3P; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so516603a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760628671; x=1761233471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPplYqAzpwU4gxjQp2Rw6jkCzCOQWdHbasm8KJuRgKg=;
        b=doPubc3P+gZ+HV7IYjMGh6lGx9ouANOyuXU4B+3+4MAHmWEyWU77V475Dyc9hub6Q6
         snrFK1pfy0QH0ZJfrksGyE/R51FzqaCxy+nN9v5ZVxoRWeiGBkGzHsQkkgRKC8oRGs6A
         Qc4XHh7LpCelOZyfpQFDtzZyfPNzoG7Xxq/MEbhVrfOGCMVpO3ALWzGG8KEXiZ0gTd2U
         kXz5LAeozLbwfJ0qMLwrbxobgJ90xnwvoyp+T3GYAK7Q1A1ZNxveNu/2UBljDFB+2H9T
         hEOfqN2+6TlM6U39FORldh72GZE0OMZnNbyPJlJ28O1jqgCYMcvLbG1m8zRdqkaXZYSZ
         fP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628671; x=1761233471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPplYqAzpwU4gxjQp2Rw6jkCzCOQWdHbasm8KJuRgKg=;
        b=jyhJc9pJtk7u/jw4jQtHldgllDZoCbj6CBnZiuVEitJQssycpC/RF20WedDhNwZ3xZ
         8Xkb3DwKzx2Wf8oIrJsaab4VNQjPrbFPtt5PCrj90OEoHLEsbe+eapuzfGYAkUXt6mzl
         T/IFoSm2LXHqDtcj8ciSrOaL3XNnyy1++y5GOJWLn/ABq4bvlo2LNKfDkLouT2F8Rd+O
         gtXkYThvbLQauCBZ77ofeCAYyD4UuN+Fwq44O6qQop+HUCbfGRcZldC1kcD8uvnfBXP2
         YCDNESlqYQJsss2M72DLXGWKU3ykfSpUMtNm5jRoZRfj/MR3jW1qebfS33jTlvcCo/in
         Fauw==
X-Forwarded-Encrypted: i=1; AJvYcCViOTz2XWDzXAvf1+uA5cUSOCeaQ/lJCMFQjoRuku6POXrLmcse/r86W6yr9nsfkaqa9RS8dYnh8QxXseA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDIiQPGUTJctEZwUgC/4wzAyjfS8RblUHDxz8EGitGZ2miDQG
	Yc5XC8/+iAXMP53K5CXnZkapcKvgkYy8Ey4FZg3CzEAUDFfWXn2PWKBKHVIcpJebXX8=
X-Gm-Gg: ASbGnctPnQP6dGzjL5BRI0z6xcOBwfvs7uzGvKIJxmYboSkITaQNZsIj3fpSL6IEREE
	AFhxemYEpDil3kDX663SpgdU2s2Ar1kROHfjHF4n/syaEIiWB+ww1hVJo/VSUvxoVXO5MqJeN1D
	7/a1jHsypFSzmgzeNkuKcl1sd6GFmuTRdNDy/zyuO8OEDL87J0/xFP6rKpJcVc3zLaA7eaw19vd
	FDYP3WG8WByixW25bthJBVR5qRId+rehxeoGMgq1b/8WsRMcFaRpbyoDhmh+cUSU7SW0gLtQrMZ
	KJwAJAcqa2Yw3TCbp1TL2Fd7ZJHNqEpEt+ozvdQ9TQLAQlzxWofk6w8bV4NRchSMvnCIf76pbBs
	YRwrTihrjN3eFkE1IqMVRCf+vRvDgBdYrAnR8muyevWx4c4YyT/f52D67QXdN4Sf3zYqD9IDzA4
	5Xq3W5URSIkA==
X-Google-Smtp-Source: AGHT+IHwQKe9LAMk6ozD/GRZ/4wHAc2uQ93fezPeXjgomM0kYDp4EL0uCq03NAVcolelP7TLwPE5CA==
X-Received: by 2002:a17:902:db0b:b0:24c:d6c6:c656 with SMTP id d9443c01a7336-290c9c8a84bmr4369005ad.4.1760628671090;
        Thu, 16 Oct 2025 08:31:11 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm34122695ad.26.2025.10.16.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:31:10 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:31:07 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
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
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v21 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Message-ID: <aPEPuyYo_e4DFSMJ@debug.ba.rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
 <20251015-v5_user_cfi_series-v21-25-6a07856e90e7@rivosinc.com>
 <CANXhq0qHT=nnwG3SX3s_D3G2QqKGmQBbdzFwiQ5MMkimxCHJHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0qHT=nnwG3SX3s_D3G2QqKGmQBbdzFwiQ5MMkimxCHJHQ@mail.gmail.com>

On Thu, Oct 16, 2025 at 04:29:48PM +0800, Zong Li wrote:
>On Thu, Oct 16, 2025 at 2:14 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> This patch creates a config for shadow stack support and landing pad instr
>> support. Shadow stack support and landing instr support can be enabled by
>> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
>> up path to enumerate CPU support and if cpu support exists, kernel will
>> support cpu assisted user mode cfi.
>>
>> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
>> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                  | 21 +++++++++++++++++++++
>>  arch/riscv/configs/hardening.config |  4 ++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0c6038dc5dfd..aed033e2b526 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -1146,6 +1146,27 @@ config RANDOMIZE_BASE
>>
>>            If unsure, say N.
>>
>> +config RISCV_USER_CFI
>> +       def_bool y
>> +       bool "riscv userspace control flow integrity"
>> +       depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
>> +       depends on RISCV_ALTERNATIVE
>> +       select RISCV_SBI
>> +       select ARCH_HAS_USER_SHADOW_STACK
>> +       select ARCH_USES_HIGH_VMA_FLAGS
>> +       select DYNAMIC_SIGFRAME
>> +       help
>> +         Provides CPU assisted control flow integrity to userspace tasks.
>> +         Control flow integrity is provided by implementing shadow stack for
>> +         backward edge and indirect branch tracking for forward edge in program.
>> +         Shadow stack protection is a hardware feature that detects function
>> +         return address corruption. This helps mitigate ROP attacks.
>> +         Indirect branch tracking enforces that all indirect branches must land
>> +         on a landing pad instruction else CPU will fault. This mitigates against
>> +         JOP / COP attacks. Applications must be enabled to use it, and old user-
>> +         space does not get protection "for free".
>> +         default n.
>
>Maybe it is default 'y' instead of 'n'

aah yes, this needs to change. thanks.
I'll see if there are other significant issues, if yes then I'll fix it in that
version. Else I request Paul to fix it.

>
>> +
>>  endmenu # "Kernel features"
>>
>>  menu "Boot options"
>> diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/hardening.config
>> new file mode 100644
>> index 000000000000..089f4cee82f4
>> --- /dev/null
>> +++ b/arch/riscv/configs/hardening.config
>> @@ -0,0 +1,4 @@
>> +# RISCV specific kernel hardening options
>> +
>> +# Enable control flow integrity support for usermode.
>> +CONFIG_RISCV_USER_CFI=y
>>
>> --
>> 2.43.0
>>

