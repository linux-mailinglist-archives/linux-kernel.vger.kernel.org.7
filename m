Return-Path: <linux-kernel+bounces-773184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F75B29C75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB1E18A1E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70B3002DA;
	Mon, 18 Aug 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS0SoZF/"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489F27602C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506505; cv=none; b=tpbvmizohQ41fx2h3MkPIpsRizODB9SN3yvxVIpwWBpYPtOd/uxwqw/GKcVcXdTzxfIwphs6w87L4TF42e5033Fq7Op7oGwSR/1KabA9FvqQggCq3863GrPtzWEDNx8JDMYlv6Pdip1JfFsAA/IfjIUzWAJ7fOqncDIwDHDWY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506505; c=relaxed/simple;
	bh=nOX6/SQg3PFfHFSVx+Ot0C7LNqSzuYk6oRLJ3jeU30w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2ifgQkD2bKZYpxww4JgTPN3skx/4oDtkYOXn4izHT71EqaCuA+j9mCu0xBsoZBlW9N9DTuvf4JYNy1LVrsbrnktS2B3iXBHQO1pABVWfkIQc+N7V4+Q9mus1HErVLrWm6rbovD0wrd0nSsOGfMXIQbigtmOp3yr7zFLHP4vpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS0SoZF/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e06496so4400861a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506502; x=1756111302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V3ndf0AVYzK4CjmdlZOILGIkrZFODvV2ZMg+myf1XM=;
        b=DS0SoZF/HBz5RXtLZZr7GnLC2dUUTwRnGHtVnZJLQWxeBkROQWsbcGQK0+G/WKFv74
         5+RWbntY3sabkfhRqqIK0oMHsvxNUFQAa05MlznTJeGG6AWxWRrz70xmSwwVPdSWEMv8
         KtitJBhFgV8RKGHimg0T9NYhhWen2jvxlCJyJFXA1sR0IwBeEzXqRZFbstZsiGTTqVYQ
         wuWd/iQUE3tNqwMI1JkYEhDJI7X6hHChBgPbzTmPXYu4l2RsjcyQmxLTAXL62SM1PKxQ
         vfiKJhmVWmMGmwWC0PtBqYj8mQpz626CgS9Pcy0JGrF5C5s89lGA9HbQB04YuKOqUHHq
         0/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506502; x=1756111302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V3ndf0AVYzK4CjmdlZOILGIkrZFODvV2ZMg+myf1XM=;
        b=BElyr9KRxbdH96QPPkkdEBO7dMzO68OmhtzYsLxnizPxyAWFRSLRJIcbla2Blszy91
         mCWz+fp16EF4w9Q3wlQFawLKduw77WTwB2oTItYprCFk3/4PAsnLvEOzm9rv8lfaG/hP
         TeUla/JtY+trQ0NA61AqyvUYBiPQNJt4CLS+Lvcm16gntLe1K60tmQ1x9j0rpWXxrvca
         bYsF5dNToyW4Pej+K3DtbTdCMJnhRoGf2mwo5bjWp5ZOtxHfk7Tox0DaWW9ueVhKkHvG
         MkdALQYCc1669gC+/RskhbZNTio3uLUq0zmFSI0IbRZzZfk4dAfpTvBiokYaFlCbR1Uq
         AqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxZig31KYtHc2h8Np+INKGEgRPQH91U3nUkyRhXldL/tMaLDW8oM6Q5QsZCoS+RTwDPNB7FPJszZ3u2MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKy4oVISjlDmfXxUxCW3DXJctdiKBbgD4Rf71NG5v7Lmot/OB
	BoGaYo5dSR5BLehdxOw0ogvpO8pT8XIATfTXhwmXKoYIJn+XvtAzxjPBrSvxSu47mEgCPGBoVQO
	L9N2WbYgg6bGYsrtb42d9eJsAyYklXsmPQc05
X-Gm-Gg: ASbGncvWkiKxn6pmdeolXGdzBw28iAXaKikgEbhL0BxIF1hW7k0JnvDrZXKgC/tvU/D
	3/QFH0zu15XeUdUhwe+9okaMVtCeBu6kLJBZ4/8G1uJfjlpy0Rj8F6hgY8SPcespFbJCEMsa3t4
	Zon9EplJX7TNJ9npQ6s98NPDpvYjBTjKSnil1lnkhxaTEDDbZDxuqonxladYvbPyIqIThrqcei3
	csEAA==
X-Google-Smtp-Source: AGHT+IETr/F4coh8A2kB6u6YDtISX917/k0AGWo1RqD9l2gPpTiV5flRaPhucalpYkttUxoIeBDBsC9YiZXrF6aTzQw=
X-Received: by 2002:a17:90b:3fcf:b0:31e:998f:7b75 with SMTP id
 98e67ed59e1d1-32341e0d69cmr15049665a91.9.1755506501950; Mon, 18 Aug 2025
 01:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729174332.3acd1a86@gandalf.local.home> <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
 <aKCLGvmPLPwjyw13@shell.armlinux.org.uk> <CAFLxGvwPwrG6KVsF=hKn1SmbC0yjLVjm6h8t1+qFE0GkO7rUbQ@mail.gmail.com>
In-Reply-To: <CAFLxGvwPwrG6KVsF=hKn1SmbC0yjLVjm6h8t1+qFE0GkO7rUbQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 18 Aug 2025 10:41:28 +0200
X-Gm-Features: Ac12FXwLopEmne9bhBU-Gc0V2KBeE647FcdMtGdzqLFPMs69QdXGU2Qq6VwMZpY
Message-ID: <CAFLxGvzcaGjNAWzCjdQdnOQjGPOqPg_VY2UBpp7Q6pGVBvAa_A@mail.gmail.com>
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, 
	Nam Cao <namcao@linutronix.de>, John Kacur <jkacur@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 9:26=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> > Also please check whether you're using frame pointers or the unwinder
> > (CONFIG_UNWINDER_FRAME_POINTER or CONFIG_ARM_UNWIND).
>
> With CONFIG_UNWINDER_FRAME_POINTER the stack trace is sane,
> so only CONFIG_ARM_UNWIND is broken.
> I kind of expected it the other way around...

I found time to gather more details, maybe it rings a bell...

The problem is related to va_list. As soon as va_list is passed as
function argument the
unwinder is no longer able to unwind correctly.
Unwinding vpanic() does not lead to a correct frame anymore.
Maybe because of va_list the function arguments are passed via stack?

The unwind table entries for panic() and vpanic() are:
0xc0302e20 <vpanic>: 0x808489b0
 Compact model index: 0
 0x84 0x89 pop {r4, r7, r11, r14}
 0xb0      finish

0xc0303190 <panic>: @0xc1c63ebc
 Compact model index: 1
 0x02      vsp =3D vsp + 12
 0x84 0x00 pop {r14}
 0xb1 0x0f pop {r0, r1, r2, r3}
 0xb0      finish

Disassembly of vpanic and panic:

c0303558 <vpanic>:
* @args: Arguments for the format string
*
* Display a message, then perform cleanups. This function never returns.
*/
void vpanic(const char *fmt, va_list args)
{
c0303558:       e92d4890        push    {r4, r7, fp, lr}
c030355c:       e52de004        push    {lr}            @ (str lr, [sp, #-4=
]!)
c0303560:       eb00a54f        bl      c032caa4 <__gnu_mcount_nc>
       static char buf[1024];
       long i, i_next =3D 0, len;
       int state =3D 0;
       int old_cpu, this_cpu;
       bool _crash_kexec_post_notifiers =3D crash_kexec_post_notifiers;
c0303564:       e3084464        movw    r4, #33892      @ 0x8464
c0303568:       e34c4222        movt    r4, #49698      @ 0xc222
{
c030356c:       e1a05000        mov     r5, r0
c0303570:       e1a07001        mov     r7, r1
       bool _crash_kexec_post_notifiers =3D crash_kexec_post_notifiers;
c0303574:       e5d4602c        ldrb    r6, [r4, #44]   @ 0x2c
c0303578:       e3560001        cmp     r6, #1
c030357c:       9a000002        bls     c030358c <vpanic+0x34>
c0303580:       e59f0324        ldr     r0, [pc, #804]  @ c03038ac
<vpanic+0x354>
c0303584:       e1a01006        mov     r1, r6
c0303588:       eb17f5b4        bl      c0900c60
<__ubsan_handle_load_invalid_value>

       if (panic_on_warn) {
c030358c:       e3043f08        movw    r3, #20232      @ 0x4f08
c0303590:       e34c31f0        movt    r3, #49648      @ 0xc1f0
c0303594:       e5932000        ldr     r2, [r3]
c0303598:       e3520000        cmp     r2, #0
                * This thread may hit another WARN() in the panic path.
                * Resetting this prevents additional WARN() from panicking =
the
                * system on this thread.  Other threads are blocked by the
                * panic_mutex in panic().
                */
               panic_on_warn =3D 0;
c030359c:       13a02000        movne   r2, #0
c03035a0:       15832000        strne   r2, [r3]
}

#define arch_local_irq_disable arch_local_irq_disable
static inline void arch_local_irq_disable(void)
{
       asm volatile(
c03035a4:       f10c0080        cpsid   i
        * Use the __builtin helper when available - this results in better
        * code, especially when using GCC in combination with the per-task
        * stack protector, as the compiler will recognize that it needs to
        * load the TLS register only once in every function.
        */
       cur =3D __builtin_thread_pointer();
c03035a8:       ee1d3f70        mrc     15, 0, r3, cr13, cr0, {3}
        * so go ahead.
        * `old_cpu =3D=3D this_cpu' means we came from nmi_panic() which se=
ts
        * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
        */
       old_cpu =3D PANIC_CPU_INVALID;
       this_cpu =3D raw_smp_processor_id();
c03035ac:       e5932008        ldr     r2, [r3, #8]
{
#if defined(arch_atomic_cmpxchg)
       return arch_atomic_cmpxchg(v, old, new);
#elif defined(arch_atomic_cmpxchg_relaxed)
       int ret;
       __atomic_pre_full_fence();
c03035b0:       f57ff05b        dmb     ish

#if __LINUX_ARM_ARCH__ >=3D 7 && defined(CONFIG_SMP)
#define ARCH_HAS_PREFETCHW
static inline void prefetchw(const void *ptr)
{
       __asm__ __volatile__(
c03035b4:       e59f32f4        ldr     r3, [pc, #756]  @ c03038b0
<vpanic+0x358>
c03035b8:       f593f000        pldw    [r3]
       unsigned long res;

       prefetchw(&ptr->counter);

       do {
               __asm__ __volatile__("@ atomic_cmpxchg\n"
c03035bc:       e3e01000        mvn     r1, #0
c03035c0:       e1930f9f        ldrex   r0, [r3]
c03035c4:       e3a0c000        mov     ip, #0
c03035c8:       e1300001        teq     r0, r1
c03035cc:       0183cf92        strexeq ip, r2, [r3]
               "teq    %1, %4\n"
               "strexeq %0, %5, [%3]\n"
                   : "=3D&r" (res), "=3D&r" (oldval), "+Qo" (ptr->counter)
                   : "r" (&ptr->counter), "Ir" (old), "r" (new)
                   : "cc");
       } while (res);
c03035d0:       e35c0000        cmp     ip, #0
c03035d4:       1afffff9        bne     c03035c0 <vpanic+0x68>
       ret =3D arch_atomic_cmpxchg_relaxed(v, old, new);
       __atomic_post_full_fence();
c03035d8:       f57ff05b        dmb     ish

       /* atomic_try_cmpxchg updates old_cpu on failure */
       if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
               /* go ahead */
       } else if (old_cpu !=3D this_cpu)
c03035dc:       e1520000        cmp     r2, r0
c03035e0:       13700001        cmnne   r0, #1
c03035e4:       0a000000        beq     c03035ec <vpanic+0x94>
               panic_smp_self_stop();
c03035e8:       eb00a127        bl      c032ba8c <panic_smp_self_stop>

       console_verbose();
c03035ec:       eb034d54        bl      c03d6b44 <console_verbose>
       bust_spinlocks(1);
c03035f0:       e3a00001        mov     r0, #1
c03035f4:       eb15167b        bl      c0848fe8 <bust_spinlocks>
       len =3D vscnprintf(buf, sizeof(buf), fmt, args);
c03035f8:       e59f02b4        ldr     r0, [pc, #692]  @ c03038b4
<vpanic+0x35c>
c03035fc:       e1a03007        mov     r3, r7
c0303600:       e1a02005        mov     r2, r5
c0303604:       e3a01b01        mov     r1, #1024       @ 0x400
       bool _crash_kexec_post_notifiers =3D crash_kexec_post_notifiers;
c0303608:       e2066001        and     r6, r6, #1
       len =3D vscnprintf(buf, sizeof(buf), fmt, args);
c030360c:       eb45cce9        bl      c14769b8 <vscnprintf>

       if (len && buf[len - 1] =3D=3D '\n')
c0303610:       e3500000        cmp     r0, #0
c0303614:       0a000011        beq     c0303660 <vpanic+0x108>
c0303618:       e2405001        sub     r5, r0, #1
c030361c:       e3550b01        cmp     r5, #1024       @ 0x400
c0303620:       3a000002        bcc     c0303630 <vpanic+0xd8>
c0303624:       e59f028c        ldr     r0, [pc, #652]  @ c03038b8
<vpanic+0x360>
c0303628:       e1a01005        mov     r1, r5
c030362c:       eb17f56c        bl      c0900be4 <__ubsan_handle_out_of_bou=
nds>
c0303630:       e0843005        add     r3, r4, r5
c0303634:       e5d33030        ldrb    r3, [r3, #48]   @ 0x30
c0303638:       e353000a        cmp     r3, #10
c030363c:       1a000007        bne     c0303660 <vpanic+0x108>
               buf[len - 1] =3D '\0';
c0303640:       e3550b01        cmp     r5, #1024       @ 0x400
c0303644:       3a000002        bcc     c0303654 <vpanic+0xfc>
c0303648:       e59f026c        ldr     r0, [pc, #620]  @ c03038bc
<vpanic+0x364>
c030364c:       e1a01005        mov     r1, r5
c0303650:       eb17f563        bl      c0900be4 <__ubsan_handle_out_of_bou=
nds>
c0303654:       e0845005        add     r5, r4, r5
c0303658:       e3a03000        mov     r3, #0
c030365c:       e5c53030        strb    r3, [r5, #48]   @ 0x30

       pr_emerg("Kernel panic - not syncing: %s\n", buf);
c0303660:       e59f124c        ldr     r1, [pc, #588]  @ c03038b4
<vpanic+0x35c>
c0303664:       e30e07b4        movw    r0, #59316      @ 0xe7b4
c0303668:       e34c019d        movt    r0, #49565      @ 0xc19d
c030366c:       eb0003c7        bl      c0304590 <_printk>
       /*
        * Unlike the bitops with the '__' prefix above, this one *is* atomi=
c,
        * so `volatile` must always stay here with no cast-aways. See
        * `Documentation/atomic_bitops.txt` for the details.
        */
       return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
c0303670:       e5943008        ldr     r3, [r4, #8]
#ifdef CONFIG_DEBUG_BUGVERBOSE
       /*
        * Avoid nested stack-dumping if a panic occurs during oops processi=
ng
        */
       if (!test_taint(TAINT_DIE) && oops_in_progress <=3D 1)
c0303674:       e3130080        tst     r3, #128        @ 0x80
c0303678:       1a000005        bne     c0303694 <vpanic+0x13c>
c030367c:       e30a3284        movw    r3, #41604      @ 0xa284
c0303680:       e34c3222        movt    r3, #49698      @ 0xc222
c0303684:       e5933000        ldr     r3, [r3]
c0303688:       e3530001        cmp     r3, #1
c030368c:       ca000000        bgt     c0303694 <vpanic+0x13c>
               dump_stack();
c0303690:       eb006216        bl      c031bef0 <dump_stack>
        * If we want to run this after calling panic_notifiers, pass
        * the "crash_kexec_post_notifiers" option to the kernel.
        *
        * Bypass the panic_cpu check and call __crash_kexec directly.
        */
       if (!_crash_kexec_post_notifiers)
c0303694:       e3560000        cmp     r6, #0
c0303698:       1a000001        bne     c03036a4 <vpanic+0x14c>
               __crash_kexec(NULL);
c030369c:       e1a00006        mov     r0, r6
c03036a0:       eb050e94        bl      c04470f8 <__crash_kexec>
       if (panic_print & SYS_INFO_ALL_CPU_BT) {
c03036a4:       e5943000        ldr     r3, [r4]
c03036a8:       e3130040        tst     r3, #64 @ 0x40
c03036ac:       0a000007        beq     c03036d0 <vpanic+0x178>
* to allow calling code to fall back to some other mechanism:
*/
#ifdef arch_trigger_cpumask_backtrace
static inline bool trigger_all_cpu_backtrace(void)
{
       arch_trigger_cpumask_backtrace(cpu_online_mask, -1);
c03036b0:       e3e01000        mvn     r1, #0
c03036b4:       e3040f14        movw    r0, #20244      @ 0x4f14
c03036b8:       e34c01f0        movt    r0, #49648      @ 0xc1f0
               panic_triggering_all_cpu_backtrace =3D true;
c03036bc:       e3a03001        mov     r3, #1
c03036c0:       e5c43430        strb    r3, [r4, #1072] @ 0x430
c03036c4:       eb00a103        bl      c032bad8
<arch_trigger_cpumask_backtrace>
               panic_triggering_all_cpu_backtrace =3D false;
c03036c8:       e3a03000        mov     r3, #0
c03036cc:       e5c43430        strb    r3, [r4, #1072] @ 0x430
       if (!crash_kexec)
c03036d0:       e3560000        cmp     r6, #0
c03036d4:       1a000001        bne     c03036e0 <vpanic+0x188>
               smp_send_stop();
c03036d8:       eb00a0b0        bl      c032b9a0 <smp_send_stop>
c03036dc:       ea000000        b       c03036e4 <vpanic+0x18c>
               crash_smp_send_stop();
c03036e0:       eb00a7e6        bl      c032d680 <crash_smp_send_stop>

       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);

       printk_legacy_allow_panic_sync();
c03036e4:       eb035931        bl      c03d9bb0
<printk_legacy_allow_panic_sync>

       /*
        * Run any panic handlers, including those that might need to
        * add information to the kmsg dump output.
        */
       atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
c03036e8:       e59f21c4        ldr     r2, [pc, #452]  @ c03038b4
<vpanic+0x35c>
c03036ec:       e3a01000        mov     r1, #0
c03036f0:       e59f01c8        ldr     r0, [pc, #456]  @ c03038c0
<vpanic+0x368>
c03036f4:       eb024681        bl      c0395100 <atomic_notifier_call_chai=
n>

       sys_info(panic_print);
c03036f8:       e5940000        ldr     r0, [r4]
c03036fc:       eb45b2ff        bl      c1470300 <sys_info>

       kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
c0303700:       e59f11ac        ldr     r1, [pc, #428]  @ c03038b4
<vpanic+0x35c>
c0303704:       e3a00001        mov     r0, #1
c0303708:       eb036048        bl      c03db830 <kmsg_dump_desc>
        * Note: since some panic_notifiers can make crashed kernel
        * more unstable, it can increase risks of the kdump failure too.
        *
        * Bypass the panic_cpu check and call __crash_kexec directly.
        */
       if (_crash_kexec_post_notifiers)
c030370c:       e3560000        cmp     r6, #0
c0303710:       0a000001        beq     c030371c <vpanic+0x1c4>
               __crash_kexec(NULL);
c0303714:       e3a00000        mov     r0, #0
c0303718:       eb050e76        bl      c04470f8 <__crash_kexec>

       console_unblank();
c030371c:       eb035ede        bl      c03db29c <console_unblank>
        * buffer.  Try to acquire the lock then release it regardless of th=
e
        * result.  The release will also print the buffers out.  Locks debu=
g
        * should be disabled to avoid reporting bad unlock balance when
        * panic() is not being callled from OOPS.
        */
       debug_locks_off();
c0303720:       eb151570        bl      c0848ce8 <debug_locks_off>
       console_flush_on_panic(CONSOLE_FLUSH_PENDING);
c0303724:       e3a00000        mov     r0, #0
c0303728:       eb035f7a        bl      c03db518 <console_flush_on_panic>

       if ((panic_print & SYS_INFO_PANIC_CONSOLE_REPLAY) ||
c030372c:       e5943000        ldr     r3, [r4]
c0303730:       e3130020        tst     r3, #32
c0303734:       0a000002        beq     c0303744 <vpanic+0x1ec>
               panic_console_replay)
               console_flush_on_panic(CONSOLE_REPLAY_ALL);
c0303738:       e3a00001        mov     r0, #1
c030373c:       eb035f75        bl      c03db518 <console_flush_on_panic>
c0303740:       ea000007        b       c0303764 <vpanic+0x20c>
       if ((panic_print & SYS_INFO_PANIC_CONSOLE_REPLAY) ||
c0303744:       e5d4543c        ldrb    r5, [r4, #1084] @ 0x43c
c0303748:       e3550001        cmp     r5, #1
c030374c:       9a000002        bls     c030375c <vpanic+0x204>
c0303750:       e59f016c        ldr     r0, [pc, #364]  @ c03038c4
<vpanic+0x36c>
c0303754:       e1a01005        mov     r1, r5
c0303758:       eb17f540        bl      c0900c60
<__ubsan_handle_load_invalid_value>
c030375c:       e3150001        tst     r5, #1
c0303760:       1afffff4        bne     c0303738 <vpanic+0x1e0>

       if (!panic_blink)
c0303764:       e5943440        ldr     r3, [r4, #1088] @ 0x440
c0303768:       e30e8b08        movw    r8, #60168      @ 0xeb08
c030376c:       e34c81b7        movt    r8, #49591      @ 0xc1b7
               panic_blink =3D no_blink;

       if (panic_timeout > 0) {
c0303770:       e5941444        ldr     r1, [r4, #1092] @ 0x444
       if (!panic_blink)
c0303774:       e3530000        cmp     r3, #0
               panic_blink =3D no_blink;
c0303778:       03053010        movweq  r3, #20496      @ 0x5010
c030377c:       034c3036        movteq  r3, #49206      @ 0xc036
c0303780:       05843440        streq   r3, [r4, #1088] @ 0x440
       if (panic_timeout > 0) {
c0303784:       e3510000        cmp     r1, #0
       int state =3D 0;
c0303788:       d3a05000        movle   r5, #0
       long i, i_next =3D 0, len;
c030378c:       d1a07005        movle   r7, r5
       if (panic_timeout > 0) {
c0303790:       da00001c        ble     c0303808 <vpanic+0x2b0>
       int state =3D 0;
c0303794:       e3a05000        mov     r5, #0
                       touch_nmi_watchdog();
                       if (i >=3D i_next) {
                               i +=3D panic_blink(state ^=3D 1);
                               i_next =3D i + 3600 / PANIC_BLINK_SPD;
                       }
                       mdelay(PANIC_TIMER_STEP);
c0303798:       e30cbb60        movw    fp, #52064      @ 0xcb60
c030379c:       e340bccc        movt    fp, #3276       @ 0xccc
       long i, i_next =3D 0, len;
c03037a0:       e1a07005        mov     r7, r5
               for (i =3D 0; i < panic_timeout * 1000; i +=3D PANIC_TIMER_S=
TEP) {
c03037a4:       e1a06005        mov     r6, r5
c03037a8:       e3a0affa        mov     sl, #1000       @ 0x3e8
               pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
c03037ac:       e30e07d8        movw    r0, #59352      @ 0xe7d8
c03037b0:       e34c019d        movt    r0, #49565      @ 0xc19d
c03037b4:       eb000375        bl      c0304590 <_printk>
               for (i =3D 0; i < panic_timeout * 1000; i +=3D PANIC_TIMER_S=
TEP) {
c03037b8:       e5941444        ldr     r1, [r4, #1092] @ 0x444
c03037bc:       e003019a        mul     r3, sl, r1
c03037c0:       e1530006        cmp     r3, r6
c03037c4:       da00000f        ble     c0303808 <vpanic+0x2b0>
                       if (i >=3D i_next) {
c03037c8:       e1560007        cmp     r6, r7
c03037cc:       ba000005        blt     c03037e8 <vpanic+0x290>
                               i +=3D panic_blink(state ^=3D 1);
c03037d0:       e2255001        eor     r5, r5, #1
c03037d4:       e5943440        ldr     r3, [r4, #1088] @ 0x440
c03037d8:       e1a00005        mov     r0, r5
c03037dc:       e12fff33        blx     r3
c03037e0:       e0866000        add     r6, r6, r0
                               i_next =3D i + 3600 / PANIC_BLINK_SPD;
c03037e4:       e28670c8        add     r7, r6, #200    @ 0xc8
{
c03037e8:       e3a09064        mov     r9, #100        @ 0x64
                       mdelay(PANIC_TIMER_STEP);
c03037ec:       e5983004        ldr     r3, [r8, #4]
c03037f0:       e1a0000b        mov     r0, fp
c03037f4:       e12fff33        blx     r3
c03037f8:       e2599001        subs    r9, r9, #1
c03037fc:       1afffffa        bne     c03037ec <vpanic+0x294>
               for (i =3D 0; i < panic_timeout * 1000; i +=3D PANIC_TIMER_S=
TEP) {
c0303800:       e2866064        add     r6, r6, #100    @ 0x64
c0303804:       eaffffeb        b       c03037b8 <vpanic+0x260>
               }
       }
       if (panic_timeout !=3D 0) {
c0303808:       e3510000        cmp     r1, #0
c030380c:       0a000007        beq     c0303830 <vpanic+0x2d8>
               /*
                * This will not be a clean reboot, with everything
                * shutting down.  But if there is a chance of
                * rebooting the system it will be rebooted.
                */
               if (panic_reboot_mode !=3D REBOOT_UNDEFINED)
c0303810:       e3083194        movw    r3, #33172      @ 0x8194
c0303814:       e34c31f2        movt    r3, #49650      @ 0xc1f2
c0303818:       e5932000        ldr     r2, [r3]
c030381c:       e3720001        cmn     r2, #1
                       reboot_mode =3D panic_reboot_mode;
c0303820:       13083198        movwne  r3, #33176      @ 0x8198
c0303824:       134c31f2        movtne  r3, #49650      @ 0xc1f2
c0303828:       15832000        strne   r2, [r3]
               emergency_restart();
c030382c:       eb024cbd        bl      c0396b28 <emergency_restart>
       }
#endif
#if defined(CONFIG_S390)
       disabled_wait();
#endif
       pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
c0303830:       e59f107c        ldr     r1, [pc, #124]  @ c03038b4
<vpanic+0x35c>
c0303834:       e30e07f8        movw    r0, #59384      @ 0xe7f8
c0303838:       e34c019d        movt    r0, #49565      @ 0xc19d
c030383c:       eb000353        bl      c0304590 <_printk>

       /* Do not scroll important messages printed above */
       suppress_printk =3D 1;
c0303840:       e3043f70        movw    r3, #20336      @ 0x4f70
c0303844:       e34c31f0        movt    r3, #49648      @ 0xc1f0
       /*
        * The final messages may not have been printed if in a context that
        * defers printing (such as NMI) and irq_work is not available.
        * Explicitly flush the kernel log buffer one last time.
        */
       console_flush_on_panic(CONSOLE_FLUSH_PENDING);
c0303848:       e3a00000        mov     r0, #0
       suppress_printk =3D 1;
c030384c:       e3a02001        mov     r2, #1
c0303850:       e5832000        str     r2, [r3]
       console_flush_on_panic(CONSOLE_FLUSH_PENDING);
c0303854:       eb035f2f        bl      c03db518 <console_flush_on_panic>
       nbcon_atomic_flush_unsafe();
c0303858:       eb03684e        bl      c03dd998 <nbcon_atomic_flush_unsafe=
>
       asm volatile(
c030385c:       f1080080        cpsie   i
               touch_softlockup_watchdog();
               if (i >=3D i_next) {
                       i +=3D panic_blink(state ^=3D 1);
                       i_next =3D i + 3600 / PANIC_BLINK_SPD;
               }
               mdelay(PANIC_TIMER_STEP);
c0303860:       e30cab60        movw    sl, #52064      @ 0xcb60
c0303864:       e340accc        movt    sl, #3276       @ 0xccc
       for (i =3D 0; ; i +=3D PANIC_TIMER_STEP) {
c0303868:       e3a06000        mov     r6, #0
               if (i >=3D i_next) {
c030386c:       e1560007        cmp     r6, r7
c0303870:       ba000005        blt     c030388c <vpanic+0x334>
                       i +=3D panic_blink(state ^=3D 1);
c0303874:       e2255001        eor     r5, r5, #1
c0303878:       e5943440        ldr     r3, [r4, #1088] @ 0x440
c030387c:       e1a00005        mov     r0, r5
c0303880:       e12fff33        blx     r3
c0303884:       e0866000        add     r6, r6, r0
                       i_next =3D i + 3600 / PANIC_BLINK_SPD;
c0303888:       e28670c8        add     r7, r6, #200    @ 0xc8
       for (i =3D 0; ; i +=3D PANIC_TIMER_STEP) {
c030388c:       e3a09064        mov     r9, #100        @ 0x64
               mdelay(PANIC_TIMER_STEP);
c0303890:       e5983004        ldr     r3, [r8, #4]
c0303894:       e1a0000a        mov     r0, sl
c0303898:       e12fff33        blx     r3
c030389c:       e2599001        subs    r9, r9, #1
c03038a0:       1afffffa        bne     c0303890 <vpanic+0x338>
       for (i =3D 0; ; i +=3D PANIC_TIMER_STEP) {
c03038a4:       e2866064        add     r6, r6, #100    @ 0x64
               touch_softlockup_watchdog();
c03038a8:       eaffffef        b       c030386c <vpanic+0x314>
c03038ac:       c1f231bc        .word   0xc1f231bc
c03038b0:       c1f231cc        .word   0xc1f231cc
c03038b4:       c2228494        .word   0xc2228494
c03038b8:       c1f231d0        .word   0xc1f231d0
c03038bc:       c1f231e4        .word   0xc1f231e4
c03038c0:       c2228898        .word   0xc2228898
c03038c4:       c1f231f8        .word   0xc1f231f8

c03038c8 <panic>:
}
EXPORT_SYMBOL(vpanic);

/* Identical to vpanic(), except it takes variadic arguments instead
of va_list */
void panic(const char *fmt, ...)
{
c03038c8:       e92d000f        push    {r0, r1, r2, r3}
c03038cc:       e52de004        push    {lr}            @ (str lr, [sp, #-4=
]!)
c03038d0:       e24dd00c        sub     sp, sp, #12
c03038d4:       e52de004        push    {lr}            @ (str lr, [sp, #-4=
]!)
c03038d8:       eb00a471        bl      c032caa4 <__gnu_mcount_nc>
c03038dc:       ee1d3f70        mrc     15, 0, r3, cr13, cr0, {3}
       va_list args;

       va_start(args, fmt);
c03038e0:       e28d1014        add     r1, sp, #20
       vpanic(fmt, args);
c03038e4:       e59d0010        ldr     r0, [sp, #16]
{
c03038e8:       e5932508        ldr     r2, [r3, #1288] @ 0x508
c03038ec:       e58d2004        str     r2, [sp, #4]
c03038f0:       e3a02000        mov     r2, #0
       va_start(args, fmt);
c03038f4:       e58d1000        str     r1, [sp]
       vpanic(fmt, args);
c03038f8:       ebffff16        bl      c0303558 <vpanic>

--=20
Thanks,
//richard

