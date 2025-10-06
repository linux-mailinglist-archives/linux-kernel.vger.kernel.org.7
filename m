Return-Path: <linux-kernel+bounces-843436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A7BBF2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DACE189C073
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7A254B03;
	Mon,  6 Oct 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RVADNuFu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADCC258CF2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782003; cv=none; b=L+dTwuHg0YyEyWMPqLQAms5xYBXpmUHrLHyW7DDtAZw+DHuqJUIEY1m4tu0K+JA37VWQJaEmPFVAOR9JQ+LVsIwR4Sut/C29wk2z6WwomLdm2CClcCMXNwURSzam9e3tj9zcWIFd4bECFpx1Vxgo6+pxCcMfH/2ziEAhcrjy+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782003; c=relaxed/simple;
	bh=mZM1Xn5JzqNdx8PftFwZgA/rtD9tl1Yh1zasby46P9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqhux1qCqu97OXLYvL+u16eID0jU6rZr+x0qWCMcwXljEcETBFpP2G5lBHXM0yrpUdb4xtsfkKowPSxR6VSJDDSfeVRTUn4eO+Vv+L3PaW73OlfLJIL/ZO1IU35A7T8ZFESFc/j33uhyzAEzfEZCcBS5ixklLiQWlHzjuVRvC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RVADNuFu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f1f29a551so6812076b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759781999; x=1760386799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQJdZyQhMwY/lhMG4TcQTIvMno90NamMQAcddd5OC2Q=;
        b=RVADNuFu7TG2MFLm0JmBIAvPkVybezOy2PUIlmapv7eNtYOSDXjXXYFqyO5OuJ+E2o
         Q2IutxNCa0iiPD1AgHwmP2ZfjP+0BfZsvLhSEiKRo4DiIiz77VSVfN4Op18HQhPcafz/
         tgv7yWCEN5HMzRqgFQl3v+zryXvplsoQtbRU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781999; x=1760386799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQJdZyQhMwY/lhMG4TcQTIvMno90NamMQAcddd5OC2Q=;
        b=LUZvQe0ThqA4+uyk7Z27YVFefu0adrQhP3WBmcBon55RzUS+qHOU/ridK5HCRyJDPh
         CDBEPo2C44h28gKovd5WhUa+qdDdTzkkhJ5WoR8w3UUfA9P/K6vDkHmpzpaH2D4ojEH1
         6ENoFaOYaKhkwHuG4W3P7qB9rIKhSX7WxsZx8PfwwvExZ0R5T6YoZ+BKvZ7bdllf3+pI
         oJXyzhEVB+vX2XCOCrFNjiwpbDDHo7eoYxEGFOwFuil3J0aAX4hg/Tpci36/lznr3qUf
         ukB8t+9NXuQWTz9TNwiD8T9PSS+dQQkBYN1SZJwtpr8+u5Mk3dxmGfnggsZNxfBZwwbC
         9q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz/xbeDhyz5GnvBHKvVTnkmj5sain8KGGEgr9twmbCRa+7WSS2opExS5nNFQgs+KR7nzq2bw8bGLlu2/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkritTBHRZir03FSJQfJT/Di+RPyn1j4xWJokGrC7BM2uldQPW
	75AopkuBvCiu/OpmFGuw1Y9J0MgzsRB9X976wGr9H4eovzlzkt33842N5vE6WU+IqOoGfxQRIzY
	arZc=
X-Gm-Gg: ASbGncvSY8w7ddAG7VqJpI18mdFz5LPaCaLositFj2AabdjLgctWRwQJlnS1JkVolRs
	J6tAWtiapfJc2Z2nq3i6aTtJo6MgJPLvJnqKSnH5QHB3Ceux6AmatEt/kwwJ/nwxQKKFTwG4DCo
	85d0OgXsayk9uq17ykbZDJFn0QnK6qwk+xxSoWAUNx9cIBHy7kfWg0NLBJlPsRxzOLIRT5AYwgW
	90aOsKKyOD4jXPNAdFlvWQA3LgRqG3IMeGCUrfaFwJLrjJay/1ASo9A5BBq5ZQ2h2y1IEhgp7AN
	bO0E+YWtU0lUQykQByf8ijtcCLCfmuhbRWOQpvLaz3pOdRhmhv4575rKRUMXNM3nxfdkFmbXA6B
	Ddd0NaIFxrKXeNEjmbYMfPn5jae1L2GfayZEK5QTtSG5gOVMMuMV1ZWKx/27jCWznaE9tHFDtgF
	afGBy04IVuWmJEBLmjWcunW11Op5XI7KQWtaU=
X-Google-Smtp-Source: AGHT+IFStWEYR9Nf7dI/79h1SPw8+V0iXsHAnbnBasu5YZFetTx7rEk9RFOTLAFnYeaqAnOinEts5Q==
X-Received: by 2002:a05:6a00:82:b0:781:2401:74f5 with SMTP id d2e1a72fcca58-78c98cfe331mr12174476b3a.29.1759781999097;
        Mon, 06 Oct 2025 13:19:59 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0208eb5asm13496718b3a.82.2025.10.06.13.19.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:19:58 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782023ca359so5139744b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:19:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+q4bfYFwgp7xnudBU5YPIIedqdviNJIng/dErLF0Fe3twXlTohjDDLWhtKqUEoSH8dc6Ft8x6z0Iwr28=@vger.kernel.org
X-Received: by 2002:a17:902:da8b:b0:268:f83a:835a with SMTP id
 d9443c01a7336-28e9a6d01c7mr166290125ad.60.1759781642366; Mon, 06 Oct 2025
 13:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <f932d6da-cd9c-4307-8877-eeb947a5c1a6@csgroup.eu> <aMpbOSN4DH09IPgD@mdev>
In-Reply-To: <aMpbOSN4DH09IPgD@mdev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Oct 2025 13:13:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WttSbhpct2bhwF+EHgisSZ2G+6G6chNebosmAUtmv9Hw@mail.gmail.com>
X-Gm-Features: AS18NWAjS9eb65vMivsZK8Ihu7dGX2eBE91P457m_KL2WK6DeqCInpBXFl0HmzQ
Message-ID: <CAD=FV=WttSbhpct2bhwF+EHgisSZ2G+6G6chNebosmAUtmv9Hw@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	kees@kernel.org, masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 16, 2025 at 11:55=E2=80=AFPM Jinchao Wang <wangjinchao600@gmail=
.com> wrote:
>
> On Wed, Sep 17, 2025 at 08:08:57AM +0200, Christophe Leroy wrote:
> >
> >
> > Le 16/09/2025 =C3=A0 16:50, Jinchao Wang a =C3=A9crit :
> > > Currently, the hard lockup detector is selected at compile time via
> > > Kconfig, which requires a kernel rebuild to switch implementations.
> > > This is inflexible, especially on systems where a perf event may not
> > > be available or may be needed for other tasks.
> > >
> > > This commit refactors the hard lockup detector to replace a rigid
> > > compile-time choice with a flexible build-time and boot-time solution=
.
> > > The patch supports building the kernel with either detector
> > > independently, or with both. When both are built, a new boot paramete=
r
> > > `hardlockup_detector=3D"perf|buddy"` allows the selection at boot tim=
e.
> > > This is a more robust and user-friendly design.
> > >
> > > This patch is a follow-up to the discussion on the kernel mailing lis=
t
> > > regarding the preference and future of the hard lockup detectors. It
> > > implements a flexible solution that addresses the community's need to
> > > select an appropriate detector at boot time.
> > >
> > > The core changes are:
> > > - The `perf` and `buddy` watchdog implementations are separated into
> > >    distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > > - Global function pointers are introduced (`watchdog_hardlockup_enabl=
e_ptr`)
> > >    to serve as a single API for the entire feature.
> > > - A new `hardlockup_detector=3D` boot parameter is added to allow the
> > >    user to select the desired detector at boot time.
> > > - The Kconfig options are simplified by removing the complex
> > >    `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to =
be
> > >    built without mutual exclusion.
> > > - The weak stubs are updated to call the new function pointers,
> > >    centralizing the watchdog logic.
> > >
> > > Link: https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@by=
tedance.com/
> > > Link: https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJ=
MoL6XCftEo6W7q6jRCkg@mail.gmail.com/
> > >
> > > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > > ---
> > >   .../admin-guide/kernel-parameters.txt         |  7 +++
> > >   include/linux/nmi.h                           |  6 +++
> > >   kernel/watchdog.c                             | 46 ++++++++++++++++=
++-
> > >   kernel/watchdog_buddy.c                       |  7 +--
> > >   kernel/watchdog_perf.c                        | 10 ++--
> > >   lib/Kconfig.debug                             | 37 +++++++--------
> > >   6 files changed, 85 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index 5a7a83c411e9..0af214ee566c 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1828,6 +1828,13 @@
> > >                     backtraces on all cpus.
> > >                     Format: 0 | 1
> > > +   hardlockup_detector=3D
> > > +                   [perf, buddy] Selects the hard lockup detector to=
 use at
> > > +                   boot time.
> > > +                   Format: <string>
> > > +                   - "perf": Use the perf-based detector.
> > > +                   - "buddy": Use the buddy-based detector.
> > > +
> > >     hash_pointers=3D
> > >                     [KNL,EARLY]
> > >                     By default, when pointers are printed to the cons=
ole
> > > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > > index cf3c6ab408aa..9298980ce572 100644
> > > --- a/include/linux/nmi.h
> > > +++ b/include/linux/nmi.h
> > > @@ -100,6 +100,9 @@ void watchdog_hardlockup_check(unsigned int cpu, =
struct pt_regs *regs);
> > >   #endif
> > >   #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > > +void watchdog_perf_hardlockup_enable(unsigned int cpu);
> > > +void watchdog_perf_hardlockup_disable(unsigned int cpu);
> > > +extern int watchdog_perf_hardlockup_probe(void);
> >
> > No 'extern' on function prototypes, this is pointless.
> Got it.
> >
> > >   extern void hardlockup_detector_perf_stop(void);
> > >   extern void hardlockup_detector_perf_restart(void);
> > >   extern void hardlockup_config_perf_event(const char *str);
> > > @@ -120,6 +123,9 @@ void watchdog_hardlockup_disable(unsigned int cpu=
);
> > >   void lockup_detector_reconfigure(void);
> > >   #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
> > > +void watchdog_buddy_hardlockup_enable(unsigned int cpu);
> > > +void watchdog_buddy_hardlockup_disable(unsigned int cpu);
> > > +int watchdog_buddy_hardlockup_probe(void);
> > >   void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
> > >   #else
> > >   static inline void watchdog_buddy_check_hardlockup(int hrtimer_inte=
rrupts) {}
> > > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > > index 80b56c002c7f..85451d24a77d 100644
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > @@ -55,6 +55,37 @@ unsigned long *watchdog_cpumask_bits =3D cpumask_b=
its(&watchdog_cpumask);
> > >   #ifdef CONFIG_HARDLOCKUP_DETECTOR
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > +/* The global function pointers */
> > > +void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) =3D watchdo=
g_perf_hardlockup_enable;
> > > +void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) =3D watchd=
og_perf_hardlockup_disable;
> > > +int (*watchdog_hardlockup_probe_ptr)(void) =3D watchdog_perf_hardloc=
kup_probe;
> >
> > As this is set only once at startup, can we use static_call instead of
> > function pointers ?
> >
> > Also, can it me made __ro_after_init ?
> Not really, this is just an RFC patch, and there is no consensus yet.
> If it is included in the final consensus, I will handle it in the next ve=
rsion.
> >
> > > +#elif defined(CONFIG_HARDLOCKUP_DETECTOR_BUDDY)
> > > +void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) =3D watchdo=
g_buddy_hardlockup_enable;
> > > +void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) =3D watchd=
og_buddy_hardlockup_disable;
> > > +int (*watchdog_hardlockup_probe_ptr)(void) =3D watchdog_buddy_hardlo=
ckup_probe;
> > > +#endif
> > > +
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
> > > +static char *hardlockup_detector_type =3D "perf"; /* Default to perf=
 */

I'd still at least hope that "buddy" could be the default. While
"perf" can still be useful to catch some things that "buddy" can't,
"buddy" can also catch some things that perf can't so picking the
lower-overhead one as the default is perhaps better?


> I think we should first resolve the consensus issue:
> - Should we keep both perf and buddy watchdogs? (probably yes already)

Sounds like people want to keep perf, so "yes".


> - Should the watchdog type be changeable at boot time?

Seems like a good start.


> - Should the watchdog type be changeable at runtime?

If it was easy/possible then sure, but I don't think it's a giant deal
to have something like this only changeable at boot time, like your
patch does. The fact that your patch is pretty simple is definitely a
big win.


IMO it would be worth sending it out as a real patch.

-Doug

