Return-Path: <linux-kernel+bounces-896420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D343CC50535
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6D154E62E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEE24E4A1;
	Wed, 12 Nov 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gk2VSwhX"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E122301
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913980; cv=none; b=QVh3xk52jajjpQpfrsLdJeE0AzG4wdUFBcaUoYOmB6COrrjLsM4a+pmlDWKFxxQBxZB4XcBFe/eyk4DnPDqGHsACeauBelGhe/XIYuIZWTB5gBahMN9yOYasTv1XouSMRyrjzlHAEHAlNo4L0rf+spaUD0bY7Pg8yj4rzB1dBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913980; c=relaxed/simple;
	bh=x2aGuz+zJKZnZZkXzCTVvYZ2ScR1g8KD1+E5T+TcHbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVQDchFqy+jmVqEbCPpuB+eNQ7RjLOC8dSQSmX1esAEZ4IHHpuEydaRhD8wNZTRlgDUe8P06s8QoxOSiTG8YqCQKjir/6xjdeS5+Sh0W1fu9UjirIt2tYVjeCjdqpKVo3MNCVp8T/SNCFO2FbLJoPuZwyx1g8dADMYtqvEuvBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gk2VSwhX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b731b176b5eso68424366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762913976; x=1763518776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugAQKBkBrsHecB9x8Cs9RwnH0DI2WGTlcIm1Ae1jyr0=;
        b=gk2VSwhXpuPtX/Fqzr3AwXz1gHhLb2kLLml9g1FsMGgyXn031gl4T+NmBIirL00dD2
         Kn5SVvCG4YbujGvs0sw0/Ek0BLiKDcxnbKnN3cZnvW2NcSnpT9L7MSbY1LwKTnhA3Pek
         8uRkUEuzFAz4MUVdwJCKZFJTianz3jU7wwVhB3CmB5SddXuo+Rvyb/M8bkCia5+DCzDz
         /jkYGUraJHhlC7RXmQ/BuF2Ef/CUfgTuYn6dMW9UlYw0kEw/KyOnpyd81swGrQPScQKM
         GBysQAUuvVA1EpDUhYpI2mVYSlBC1BvGL3yZ5VDHxAu+T2VmAp/3aG3ixPQNjs/JSpAz
         /thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762913976; x=1763518776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugAQKBkBrsHecB9x8Cs9RwnH0DI2WGTlcIm1Ae1jyr0=;
        b=tlxbROm27X63qWJG3bkDR+lwtPZagnkeTwzNRPnYmsqHGWZUfJlM5g8FaFHoauD3TG
         68+utyRud4K1dkXTQ9ylYrfr+rBgmn3ShJefj36/2VUWCehy5iOf54Lhac+H4MK5yNan
         uKOudf5kB0uTz3+QM8tBTLlbNPlBRlhmM12lMR9Mj43PuiE8q5tyLGbRY+S7M5xA+y1q
         x2JY7rBWPkLoFNj+fWrHrKjuHCUpzTJypxYjltrrBnmyx/DL+7gpV0wMt1pithMTzPoQ
         OZ+VaajZKmddbZsq/RtIz/qBShwoe510dn0DqUiFitpX8TMbPJWxNx7arLRpDdmHHNRw
         O6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0tr+XEQHjFgVLK6IzaUEjJSrbFvhMUOpzdScAelQQ7Xld5cr8auxNssKEEoPCTRjBeCEn3K+hpK0DqOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIRRigi/4mppA4MeQ4rkvtH+OhcwITdhT3EkTPd+/BLm8wWV1
	dZ4XD85JFw+gl39TrGc74VYijcrqFfhxyMQhtKHWXMA+Rzjk0ReBCCbRZZ8NkpzOM78/L1ZYm1I
	xJork5dmuJmKEQC4w+42KSblhpOim4IMNE90uHZ0xrg==
X-Gm-Gg: ASbGnctfE3SUhFXPzxP5p9ghIrY9wrhIjG/ggEm938yc1bewNCCKmiTZOJNa5oHGm1C
	fdd8kys1HYZwNIMdX4qEu3JYgsF+CImXRTHqRwNwuH2IEuH/k1zSn1jRVhqr+78uBHz4GO7QIlT
	gUPmXUquZnCp6vsOdTrI2TWtuCqaC9bGVoFUg5Ms7V8WCFyCdFO++BGV12G+5XnEYqcLP6q47w5
	GTKTE7NhS+FxdpFpndOryJF+93P+zqNhpn3YSlkxcM9wP6Zrv/JWl4CbdjBVJQ=
X-Google-Smtp-Source: AGHT+IE+yEBTlwHkenGiGwu5UyXnAf6gT3RkSyNE+10D+a3qX/UN5XaT1J5EAZetmYd9Vh7p3GgyT6IZWxgqCbtm2x0=
X-Received: by 2002:a17:907:3daa:b0:b72:52c2:b8ca with SMTP id
 a640c23a62f3a-b7331aec193mr102047266b.59.1762913975653; Tue, 11 Nov 2025
 18:19:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <20251023-v5_user_cfi_series-v22-25-1935270f7636@rivosinc.com>
 <CANXhq0oEpCow0G+KsJ6ZPuwsxmAFVqoKGEzygiwSmxFsmntiWg@mail.gmail.com> <aRN-0Z9MNeJ9IZf2@debug.ba.rivosinc.com>
In-Reply-To: <aRN-0Z9MNeJ9IZf2@debug.ba.rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 12 Nov 2025 10:19:23 +0800
X-Gm-Features: AWmQ_bmKovRTmE80-MSruF1BPvDQmZ8Z-ahD6_kAC3IOhiFoglBht7EGrzIY3bI
Message-ID: <CANXhq0ryrNUoBvACX9hh-=FVOe+L6_6beXrZQn2e1P6eWgcUiA@mail.gmail.com>
Subject: Re: [PATCH v22 25/28] riscv: create a config for shadow stack and
 landing pad instr support
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:22=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Tue, Nov 11, 2025 at 01:58:37PM +0800, Zong Li wrote:
> >On Fri, Oct 24, 2025 at 12:51=E2=80=AFAM Deepak Gupta via B4 Relay
> ><devnull+debug.rivosinc.com@kernel.org> wrote:
> >>
> >> From: Deepak Gupta <debug@rivosinc.com>
> >>
> >> This patch creates a config for shadow stack support and landing pad i=
nstr
> >> support. Shadow stack support and landing instr support can be enabled=
 by
> >> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` w=
ires
> >> up path to enumerate CPU support and if cpu support exists, kernel wil=
l
> >> support cpu assisted user mode cfi.
> >>
> >> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS=
`,
> >> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
> >>
> >> Reviewed-by: Zong Li <zong.li@sifive.com>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> ---
> >>  arch/riscv/Kconfig                  | 22 ++++++++++++++++++++++
> >>  arch/riscv/configs/hardening.config |  4 ++++
> >>  2 files changed, 26 insertions(+)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 0c6038dc5dfd..4f9f9358e6e3 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -1146,6 +1146,28 @@ config RANDOMIZE_BASE
> >>
> >>            If unsure, say N.
> >>
> >> +config RISCV_USER_CFI
> >> +       def_bool y
> >> +       bool "riscv userspace control flow integrity"
> >> +       depends on 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_=
zicfiss) && \
> >> +                           $(cc-option,-fcf-protection=3Dfull)
> >
> >Hi Deepak,
> >I noticed that you added a $(cc-option,-fcf-protection=3Dfull) check in
> >this version. I think this check will fail by a cc1 warning when using
> >a newer toolchain, because -fcf-protection cannot be used alone, it
> >must be specified together with the appropriate -march option.
> >For example:
> >  1. -fcf-protection=3Dbranch requires -march=3D..._zicfilp
> >  2. -fcf-protection=3Dreturn requires -march=3D..._zicfiss
> >  3. -fcf-protection=3Dfull requires -march=3D..._zicfilp_zicfiss
>
> toolchain that I have from June doesn't require -march=3D..._zicfilp_zicf=
iss
> for -fcf-protection=3Dfull. If that has changed, I think this will need a
> revision.

Yes, that=E2=80=99s what I=E2=80=99ve learned from the toolchain guys so fa=
r, perhaps
we can double check with them. If it is right, I guess we might merge
them into one check as follows:
$(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zicfilp_zicfiss -fcf-protection=
=3Dfull)
or
$(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zicfiss -fcf-protection=3Dreturn)

>
> >
> >
> >> +       depends on RISCV_ALTERNATIVE
> >> +       select RISCV_SBI
> >> +       select ARCH_HAS_USER_SHADOW_STACK
> >> +       select ARCH_USES_HIGH_VMA_FLAGS
> >> +       select DYNAMIC_SIGFRAME
> >> +       help
> >> +         Provides CPU assisted control flow integrity to userspace ta=
sks.
> >> +         Control flow integrity is provided by implementing shadow st=
ack for
> >> +         backward edge and indirect branch tracking for forward edge =
in program.
> >> +         Shadow stack protection is a hardware feature that detects f=
unction
> >> +         return address corruption. This helps mitigate ROP attacks.
> >> +         Indirect branch tracking enforces that all indirect branches=
 must land
> >> +         on a landing pad instruction else CPU will fault. This mitig=
ates against
> >> +         JOP / COP attacks. Applications must be enabled to use it, a=
nd old user-
> >> +         space does not get protection "for free".
> >> +         default y.
> >> +
> >>  endmenu # "Kernel features"
> >>
> >>  menu "Boot options"
> >> diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/=
hardening.config
> >> new file mode 100644
> >> index 000000000000..089f4cee82f4
> >> --- /dev/null
> >> +++ b/arch/riscv/configs/hardening.config
> >> @@ -0,0 +1,4 @@
> >> +# RISCV specific kernel hardening options
> >> +
> >> +# Enable control flow integrity support for usermode.
> >> +CONFIG_RISCV_USER_CFI=3Dy
> >>
> >> --
> >> 2.43.0
> >>
> >>

