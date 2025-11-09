Return-Path: <linux-kernel+bounces-891789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AFCC437DB
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 04:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59E04E1D09
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 03:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8019309E;
	Sun,  9 Nov 2025 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMT94RYi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912E34D3B7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658356; cv=none; b=WBbN4eIHVQqbrF2tP9Hs89ik3lgpb4rrWtPVnW/nxn5lt04cHNYYk0cyt4LA+FdEYAtYNDnmvzRmoHOzicxzx5Wxp+MiKGOBYk6KLdafimPgPisyD0lpzga3qRbvEX+OqCcFU4ijYLJ8x3M8nXIKr2wv2IQjo0e9kW4++2jo9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658356; c=relaxed/simple;
	bh=GSRPPL9DpZFac1791xYuPmtWvvkvVXPEPrGNNO9i7YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmFmfBkvHJQkRTWvxazU7lmAR/pNuoxVqelViGryrDrIKE1G1ikk/VZbOSMQigb65H85U+uGcfLwrl+Z7kA12KKwrkoWQuPf0qbOKE3ojzAJpqr4LYLOPtCcJlNOlw3ieJ5mNi+oNGrqxzbsD0pmOjaTVkT5MDGHtFYlMYJVB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMT94RYi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29558061c68so23335235ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 19:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762658353; x=1763263153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI/GrMMx83ubf8OIVn/kLV887i86or4fJBpkeh7DJ+Y=;
        b=lMT94RYiaqGhelNMwwOY7nIx0CCdrKwRGZlnMtn2VKeLO4cSO1jcLGeVskjh20h4NM
         bhx/DViBdqUEfta+3vRGV8WeKXraHWFaTLm7vAmpxbNRpeYmM3kYOp0i1Uf1GZADkd8D
         n/G9knLMysjpkdDYWyS8C/6QzMBPiJ9XTEZ4vJ2D4KyFsaPArjEbNoZI5lKCi0JhBWMj
         z12+YGw6VAckBhruxyRd2743iT+HKeM/9gVn85+0vV8Zk2BRyL/Nhc3tdlJ39ppbDlXZ
         Yv71gJGYABAXRv9VaRz9lVXrgILPTQHQY2xEpqyy4TpjkRZoL3R8wB8ZgCnqb4Oibcol
         ePuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762658353; x=1763263153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mI/GrMMx83ubf8OIVn/kLV887i86or4fJBpkeh7DJ+Y=;
        b=HsgrI7LGTTY1bPmOQ1/prHvP2np7lY7jSLnsMhXp4QlgiiGIANVEZIqp4g8kl/CAj9
         lf94S5ZDO2IA1jJ4wJ70rvvnlVxuLkVYtqs63bcwkTXA789sw8k3GsBl+UwY7/oJIste
         FFhIHYz0LaXyTN2YQKaAMPpIo06KzBDMSfuhAU8I68hkddfxhI6CsMBZ8cwu1hE5nSWE
         RHekXYksbIbChpxFhoDtIQP3Q2J1ZC+xjntf3ft/2q68QWz47Z2BVY6R16UQFOUs5bOE
         oE1U3+LFkVOUEBVKi9+l9+J+6XLgeHq29myXtM9k3Bas52XXg5cfxDCkFvhy9fCr06Px
         XFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUIxSSun/11oC1ggDi3MXHjbq2dD77IDvN0x0jJ3HDCG5wLsjS9RllcscM+Pb5u0xZduWuuSRkh8MJRhtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBPsmJSpFtwBNaZKPVzzpKrQ5O8E38iBcnaMaJlwFRdUxHcgM
	kG5vQelzhwLJ5BCvVWPbjWG1FGa5J14fm7Bpl9PlAa2vRo6dGsKy9ThO+VPvPKHAzpzsui3ghsj
	LnkzhfvxnWtWo4XmF7oEes8M3GLtRDjE=
X-Gm-Gg: ASbGnctu2eVX92vdkf2BCvB/Udnq/dmx95NRvt2MhZnpfhn+zaTZxyiaQOfKFbzOrhH
	oVPftzD/CgAQDbliOK6rfHQa9PyMVM8t7RFaWuhX0u+xJajGV9jFXJTUViflw8DoGMCYcLMUZGc
	gAa9Oe8209C1arf0HMGlhuWYZyheWGQn1nYBL2vMQd3kymdvbPvz38kdEN7wD1AOCxb8UjVBfXi
	LBS2hhtQO4S8+4r95+H7VfjsR7kna1mJXBmtEL33+AI/Ml4JoeqbgNW4Fg1xw==
X-Google-Smtp-Source: AGHT+IFy7SuqakthMcrFphV1gUWUjBaZcbZPoW1aJMQFUQ0KGK5gJE7PNJvGIIizHqAtkd6GMXdl1TjH5NGKeqB+FTM=
X-Received: by 2002:a17:903:17cd:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-297e5628727mr51344375ad.19.1762658352604; Sat, 08 Nov 2025
 19:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7-1dMwPQ4mirrRjsOkKKyLchkBR+7qMVqxjo7Bbr1T=A@mail.gmail.com>
 <c311789b-a6be-42c9-acfe-c1fdd9f4e3e1@intel.com> <CACueBy4MTDesg_icWRYrAEJxZ3m3_Qo-joQUdgV0tqRWFe8Y4A@mail.gmail.com>
 <a1dda600-4452-4ed5-adaa-8a2c47753630@intel.com>
In-Reply-To: <a1dda600-4452-4ed5-adaa-8a2c47753630@intel.com>
From: chuang <nashuiliang@gmail.com>
Date: Sun, 9 Nov 2025 11:19:00 +0800
X-Gm-Features: AWmQ_bkL3USLMGKVR3po8KKj6uSUmrm__wxQzMf8hf28pdGErqgZFHCSEqkMQRw
Message-ID: <CACueBy64u_11XgYeQJCXD1cNhDfhyy6vPGRLmC4H72H3cdu1RQ@mail.gmail.com>
Subject: Re: x86/fpu: Inaccurate AVX-512 Usage Tracking via arch_status
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the ongoing discussion.

On Thu, Oct 30, 2025 at 11:00=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 10/29/25 23:56, chuang wrote:
> ...
> > I traced the code path within fpu_clone(): In fpu_clone() ->
> > save_fpregs_to_fpstate(), since my current Intel CPU supports XSAVE,
> > the call to os_xsave() results in the XFEATURE_Hi16_ZMM bit being
> > set/enabled in xsave.header.xfeatures. This then causes
> > update_avx_timestamp() to update fpu->avx512_timestamp. The same flow
> > occurs in __switch_to() -> switch_fpu_prepare().
>
> So that points more in the direction of the AVX-512 not getting
> initialized. fpu_flush_thread() either isn't getting called or isn't
> doing its job at execve(). *Or*, there's something subtle in your test
> case that's causing AVX-512 to get tracked as non-init after execve().

My analysis of the issue suggests a dependency on the glibc
implementation. Since glibc version 2.24[1] onwards, AVX-512
instructions have been utilized to optimize memory functions such as
memcpy/memmove[2], and memset[3]. In contrast, previous versions
allowed the /proc/<pid>/arch_status mechanism to reflect genuine
application-level AVX-512 usage more accurately.

The disassembly of my test binary (while_sleep_static[4]) confirms the
activation of these glibc optimizations:

00000000004109d0 <__memcpy_avx512_no_vzeroupper>:
  4109d0:       f3 0f 1e fa             endbr64
  4109d4:       48 89 f8                mov    %rdi,%rax
  4109d7:       48 8d 0c 16             lea    (%rsi,%rdx,1),%rcx
  4109db:       4c 8d 0c 17             lea    (%rdi,%rdx,1),%r9
  4109df:       48 81 fa 00 02 00 00    cmp    $0x200,%rdx
  4109e6:       0f 87 5d 01 00 00       ja     410b49
<__memcpy_avx512_no_vzeroupper+0x179>
  4109ec:       48 83 fa 10             cmp    $0x10,%rdx
  4109f0:       0f 86 0f 01 00 00       jbe    410b05
<__memcpy_avx512_no_vzeroupper+0x135>
  4109f6:       48 81 fa 00 01 00 00    cmp    $0x100,%rdx
  4109fd:       72 6f                   jb     410a6e
<__memcpy_avx512_no_vzeroupper+0x9e>
  4109ff:       62 f1 7c 48 10 06       vmovups (%rsi),%zmm0
  410a05:       62 f1 7c 48 10 4e 01    vmovups 0x40(%rsi),%zmm1
  410a0c:       62 f1 7c 48 10 56 02    vmovups 0x80(%rsi),%zmm2
  410a13:       62 f1 7c 48 10 5e 03    vmovups 0xc0(%rsi),%zmm3
  410a1a:       62 f1 7c 48 10 61 fc    vmovups -0x100(%rcx),%zmm4
  410a21:       62 f1 7c 48 10 69 fd    vmovups -0xc0(%rcx),%zmm5
  410a28:       62 f1 7c 48 10 71 fe    vmovups -0x80(%rcx),%zmm6
  410a2f:       62 f1 7c 48 10 79 ff    vmovups -0x40(%rcx),%zmm7
  410a36:       62 f1 7c 48 11 07       vmovups %zmm0,(%rdi)
  410a3c:       62 f1 7c 48 11 4f 01    vmovups %zmm1,0x40(%rdi)
  410a43:       62 f1 7c 48 11 57 02    vmovups %zmm2,0x80(%rdi)
  410a4a:       62 f1 7c 48 11 5f 03    vmovups %zmm3,0xc0(%rdi)
  410a51:       62 d1 7c 48 11 61 fc    vmovups %zmm4,-0x100(%r9)

Specifically, I performed testing on Intel(R) Xeon(R) Gold 6271C and
an AMD EPYC 9W24 96-Core. The Intel PMU failed to accurately capture
AVX-512 usage, while the AMD CPU showed partial usage in some
scenarios. This potentially relates to the PMU event definitions,
which appear not to include vmovups instructions.
The descriptions for the relevant PMU events (as exemplified by Intel
CPU) are as follows:

  fp_arith_inst_retired.512b_packed_double
       [Number of SSE/AVX computational 512-bit packed double precision
        floating-point instructions retired; some instructions will count
        twice as noted below. Each count represents 8 computation operation=
s,
        one for each element. Applies to SSE* and AVX* packed double precis=
ion
        floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14
        SQRT DPP FM(N)ADD/SUB. DPP and FM(N)ADD/SUB instructions count twic=
e
        as they perform 2 calculations per element]
  fp_arith_inst_retired.512b_packed_single
       [Number of SSE/AVX computational 512-bit packed single precision
        floating-point instructions retired; some instructions will count
        twice as noted below. Each count represents 16 computation operatio=
ns,
        one for each element. Applies to SSE* and AVX* packed single precis=
ion
        floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14
        SQRT DPP FM(N)ADD/SUB. DPP and FM(N)ADD/SUB instructions count twic=
e
        as they perform 2 calculations per element]
  fp_arith_inst_retired.8_flops
       [Number of SSE/AVX computational 256-bit packed single precision and
        512-bit packed double precision FP instructions retired; some
        instructions will count twice as noted below. Each count represents=
 8
        computation operations, 1 for each element. Applies to SSE* and AVX=
*
        packed single precision and double precision FP instructions: ADD S=
UB
        HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14 RCP RCP14 DPP
        FM(N)ADD/SUB. DPP and FM(N)ADD/SUB count twice as they perform 2
        calculations per element]

Overall, the /proc/arch_status mechanism reliably reflects the AVX-512
register usage status.

We are utilizing AVX-512 enabled infrastructure within a Kubernetes
(k8s) environment and require a mechanism for monitoring the
utilization of this instruction set.
The current /proc/<pid>/arch_status file reliably indicates AVX-512
usage for a single process. However, in containerized environments
(like Kubernetes Pods), this forces us to monitor every single process
within the cgroup, which is highly inefficient and creates significant
performance overhead for monitoring.
To solve this scaling issue, we are exploring the possibility of
aggregating this usage data. Would it be feasible to extend the
AVX-512 activation status tracking to the cgroup level?

[1]: https://sourceware.org/git/?p=3Dglibc.git;a=3Dlog;h=3Drefs/tags/glibc-=
2.24;pg=3D1
[2]: https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3Dc867597bff256=
2180a18da4b8dba89d24e8b65c4
[3]: https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D5e8c5bb1ac83a=
a2577d64d82467a653fa413f7ce
[4]: while_sleep_static
// gcc -O3 -static while_sleep.c -o while_sleep_static
// glibc > 2.24
#include <unistd.h>

int main()
{
    while(1) {
            sleep(1);
    }
}


>
> > Given this, is the issue related to my specific Intel Xeon Gold? Is
> > the CPU continuously indicating that the AVX-512 state is in use?
> As much as I love to blame the hardware, I don't think we're quite there
> yet. We've literally had software bugs in the past that had this exact
> same behavior: AVX-512 state was tracked as non-init when it was never us=
ed.
>
> Any chance you could figure out where you first see XFEATURE_Hi16_ZMM in
> xfeatures? The tracepoints in here might help:
>
>         /sys/kernel/debug/tracing/events/x86_fpu
>
> Is there any rhyme or reason for which tasks see avx512_timestamp
> getting set? Is it just your test program? Or other random tasks on the
> system?

