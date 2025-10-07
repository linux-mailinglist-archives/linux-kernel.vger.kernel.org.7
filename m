Return-Path: <linux-kernel+bounces-844791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E5DBC2C88
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAD4134F485
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33315254849;
	Tue,  7 Oct 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEYVoIN7"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8B23D7EB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873412; cv=none; b=qlDCwH09m6WjJTQAscT7a0LDudV3SvN4diYh4NAo8K8ptdZ5Kd87iu058y3zmzSiFHBylxO5NcoTi64gStRpv6gIzhi76rBqPNC5GvlI6QsXiY6RLnTJKfpX8RsFBMC05KCANCNYh2XaiA6YRJcl6cvs8yHwGsMNxqKqznDveX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873412; c=relaxed/simple;
	bh=mXMo9HWefitty/egIYp/klsc0GBXRnutCiuqQwkHvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buC74sVWnMfods38QJSEROkPljJhsMN2ueGL07Z/R2Ic9N8o8gtZnE0exEuFxj11PNywKSQ7IJCLww8ULvw7/fQVtqJMCCDeeLg+BoVLq0Er4BlD7noidVBh5xesJSmqwKwxd6VYTgi96bbsvvqYLcA5BRb9ipavEkLbKniOQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DEYVoIN7; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7835321bc98so6581473b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759873410; x=1760478210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq6BkujLYLi29aUNYGOcmotTjsZeMJXrFlPqy91DqOM=;
        b=DEYVoIN7sJeXJ5Xo43jpotStbVTNmX6WAXEWLzNxsBKbv5e6cXtrVYI4/hypDQ7DEa
         7T75mnKbxtDiVsYVSPsuwEExCOKj1xlEM1/Bb91CgDGBKw4BmLYfLRbYocLGejxCNd33
         J0Y0KP9uABkrNXdACM0KYYrqtbK3RBM2m8jWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873410; x=1760478210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq6BkujLYLi29aUNYGOcmotTjsZeMJXrFlPqy91DqOM=;
        b=LpbN1MOAO2/hGQ5u8ENeLeZdwPUS21/JXFxvqDwIgQiC7AcRUSKJ7zWhHqR6U5mJJ9
         YHQXhOwxQhzTkuR4TNCnnyTGCc4rgXwsRAmnrB2gj6GDqkEmXjfPoUYoAWUpdJ5eLjjc
         H7v9gaWKwSPcBhXGSB0737+9lVUbUxS/IVmRgpLI1M1M1SdzOxvBlIyPW9/ICSupY683
         PNvoj/duhddtJBfpfkOgN6sGPAwoRohmGt4EPGVGB751F6l8gG5UqMGJXxzLZ+B96268
         VgeMg059BLPae4iHVQa/FElQvnFrs5R/3GdjkUqrJnXPCO1NRTUD0sivl5PQFCfegTen
         E8hw==
X-Forwarded-Encrypted: i=1; AJvYcCVa3ajD7rhCFVtKuOGXIZHsTo/J6kS0I5EEYBFxC9DetIVfX5qvrPMHmPLmz3COPVQo5Sbt+LE5iKxGkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAR0zRXGkeLbsYFSQSk5Lwl710U5e6c38nNLnfk77+RxbBccTi
	rYGcHMOoCncoDkO1JnFHKfA+by3+5YePVWOjDgIk1SeIiZNIRsfz202px2Qec5GOhUaJSPoc85o
	AuhY=
X-Gm-Gg: ASbGncuYt5dCxXIhaXhuNripUucDFLc/K3QiGF1sw2JS6pkNRtTdsiT5RW7p5GQyL9S
	LphdThfFnGX9P/BvteZnzESQFConsQchmCIxslikcGV8PYwRJGIVj99Iv/BkIIA0OzbWPeITFJ1
	bZphutdzzG2CEtoUHSjz61bESleOtkJHhluPwc3HVnaTehhYrmmzM0eBPs/HlVu2/vZr6/3FXxz
	wkbyph3IzXOl0WoGf2J3jMmp1x1fB00055MUeIzgAMuXvc3Tyw6e/q8xzyliit0yh8tMxSkABdH
	nSn5dNG+Xcdtpq58nlJVJ7ZEeOUuR0AHZtdATyBzcdyoFP6NhmZFdBU4KROd0aJY5oaEIHR9PaH
	uPQoTGy9ceRt/iTvwgVkV29PETmW/hHm3GZR8dL4aEKHOwPAc4Sput4bM7ZmHJL0FiR4mYyPKBL
	NkeddO5O7vvB6rr5314snztdI6
X-Google-Smtp-Source: AGHT+IGZOPY+0/R72L7DUZVk7mqoqM3OhkQMgO5uR/yziKF7ljZwz5MDwWkKdyMlXdIVzLHSrwbEow==
X-Received: by 2002:a05:6a00:c8c:b0:781:15b0:bea9 with SMTP id d2e1a72fcca58-79387c16f18mr1122386b3a.22.1759873409698;
        Tue, 07 Oct 2025 14:43:29 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205341esm16580388b3a.42.2025.10.07.14.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:43:29 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b593def09e3so4988824a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:43:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXikUks4ARc8jsnAO92jP1iO2uYZcJ08X28nGCqsXvD3pt3UEDrUqcyD+48IdaESg5xrnyt9e6vvBOzvYM=@vger.kernel.org
X-Received: by 2002:a17:903:1a6b:b0:25c:abb3:9bae with SMTP id
 d9443c01a7336-29027385222mr12638845ad.48.1759873408458; Tue, 07 Oct 2025
 14:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev> <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2> <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com> <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
In-Reply-To: <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Oct 2025 14:43:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
X-Gm-Features: AS18NWBYFe63_-xIFHhSVLEaht3LtLaaYEfLA9Sab9Q5YCvr1mkfoaxOS0mBbFo
Message-ID: <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
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
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 7, 2025 at 1:43=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 7, 2025 at 1:00=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> > On Mon, Oct 6, 2025 at 6:00=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> ..
> > > I don't mind a file that also says what kind of lockup detector is in
> > > use. I'd like the meaning of nmi_watchdog to keep meaning the kernel
> > > stole a perf counter as this is the behavior long assumed by perf
> > > which I think is the majority or only user of the file. I think the
> > > buddy watchdog being controlled by this file is less than intention
> > > revealing.
> >
> > I'm more than happy to be outvoted, but IMO nothing about the name
> > "nmi_watchdog" says to me that a perf counter was stolen. It just says
> > that there's a watchdog that NMIs are part of its work.
> >
> > ...and, indeed, "nmi_watchdog" doesn't use perf on PPC, right? As far
> > as I can tell, from reading `arch/powerpc/kernel/watchdog.c` checks
> > `watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED`. ...and before I did
> > commit df95d3085caa ("watchdog/hardlockup: rename some "NMI watchdog"
> > constants/function") it was checking `watchdog_enabled &
> > NMI_WATCHDOG_ENABLED`. That was at least since 2019, I think...
> >
> > ...and you can see "PPC_WATCHDOG" depends on
> > "HARDLOCKUP_DETECTOR_ARCH", not "HARDLOCKUP_DETECTOR_PERF" so it's not
> > perf-backed.
> >
> > I think this is just the critical question: does/should "nmi_watchdog"
> > mean perf-backed detector or is "nmi_watchdog" just a synonym for
> > "hard lockup detector". In your mind it's the former and in my mind
> > it's the latter. The correct way forward depends on which way we want
> > to jump, right? In either case some external code is going to need to
> > change...
>
> So we could say it is one-idea against another, I'm hoping to be
> objective and come from the viewpoint of the perf code as part of its
> function is to be a demonstration of APIs and the buddy watchdog has
> altered this. The perf tool has referred to the nmi_watchdog's
> behavior in man pages and code since 2016:
> http://lkml.kernel.org/r/1459810686-15913-1-git-send-email-andi@firstfloo=
r.org
> ```
> +Globally pinned events can limit the number of counters available for
> +other groups. On x86 systems, the NMI watchdog pins a counter by default=
.
> +The nmi watchdog can be disabled as root with
> +
> +       echo 0 > /proc/sys/kernel/nmi_watchdog
> ```
> http://lkml.kernel.org/r/1464119559-17203-1-git-send-email-andi@firstfloo=
r.org
> ```
> +void arch_topdown_group_warn(void)
> +{
> +       fprintf(stderr,
> +               "nmi_watchdog enabled with topdown. May give wrong result=
s.\n"
> +               "Disable with echo 0 > /proc/sys/kernel/nmi_watchdog\n");
> +}
> ```
>
> Probably the most common error message dates back to 2017:
> http://lkml.kernel.org/r/20170211183218.ijnvb5f7ciyuunx4@pd.tnic
> ```
>       Some events weren't counted. Try disabling the NMI watchdog:
>            echo 0 > /proc/sys/kernel/nmi_watchdog
>            perf stat ...
>            echo 1 > /proc/sys/kernel/nmi_watchdog
> ```
> and that is saying "NMI watchdog" not "buddy watchdog". Users are
> familiar with the idea that the /proc/sys/kernel/nmi_watchdog is
> unremarkably controlling the NMI watchdog.
>
> I've not found another use of /proc/sys/kernel/nmi_watchdog outside of
> the perf tool.

Although it's possible I missed it, from my quick look in ChromeOS, I
don't see any use of `/proc/sys/kernel/nmi_watchdog` either. NOTE that
you also need to look for `sysctl` references to
`kernel.nmi_watchdog`, right? That's essentially a way to access the
exact same file...

The other thing you need to think about is the kernel command-line
parameter. Right now we have the kernel command line parameter
`nmi_watchdog=3D<0,1>` that can be used to turn the hardlockup detector
on or off. On PowerPC I believe it turns on/off the ARCH hardlockup
detector. On systems with the buddy hardlockup detector it turns
on/off the buddy hardlockup detector. How are you proposing to handle
that? Are you going to make the kernel command line parameter still
affect everyone, or require people using the kernel command line
parameter for buddy/powerpc to change?

All of these ways to turn off/on the hardlockup detector can, in
theory, also be things that end users are messing with. People may
have settings in their `/etc/sysctl.d` to tweak things. They may have
messed with the kernel command line in their bootloader to tweak this
setting. I'm not saying it's impossible to change, but anyone who
changes this has to be prepared for people to yell.


> > The kernel docs are certainly pretty ambiguous here. "kernel.rst"
> > certainly mentions perf, but it also says that "nmi_watchdog" is only
> > for x86 which is certainly not true. "lockup-watchdogs.rst" doesn't
> > say anything about perf and just seems to indicate that "nmi_watchdog"
> > is another name for the hardlockup detector.  "kernel-parameters.txt"
> > makes some mention of tweaking which perf event would be used, but
> > otherwise makes it sound like the nmi_watchdog is just another name
> > for the hardlockup detector.
> >
> > My vote would be two files:
> >
> > * "nmi_watchdog" - simply a synonym for "hardlockup detector". 1
> > enabled, 0 if not (like today)
> >
> > * "hardlock_detector" - could be "buddy", "perf", or "arch"
> >
> > ...if the "hardlockup_detector" file doesn't exist and "nmi_watchdog"
> > is enabled, you could probably guess that a perf event was in use. If
> > the "hardlockup_detector" file exists then a perf event is only in use
> > if the value of that file is "perf". It doesn't feel terribly hard to
> > do this and it doesn't break anyone who was assuming they could turn
> > on the hardlockup detector with "/proc/nmi_watchdog".
>
> It is not hard but:
> 1) it means whenever perf wants to determine the NMI watchdog is
> present it needs to read two files rather than the existing 1, which
> has some runtime cost;
> 2) the name nmi_watchdog for controlling the behavior of the buddy
> watchdog isn't intention revealing as the buddy mechanisms whole point
> is to avoid the NMI;

The buddy mechanism is to avoid the use of a perf counter, not an NMI
(non maskable interrupt). "NMI" !=3D "perf counter". Many types of
interrupts can be non-maskable (or pseudo-non-maskable). The buddy
lockup detector still uses an NMI (indirectly). Specifically, a
non-maskable IPI (NMI-backed IPI) is used to interrupt the other CPU.

You keep saying that perf wants to determine if the "NMI watchdog" is
present. That's not what it wants to know. It wants to know if the
hard lockup detector (which likely uses NMIs in some way) happens to
use up a perf event. If an NMI-backed hardlockup detector (presumably
like the one on PowerPC) wasn't using a perf counter then perf
wouldn't care.


> 3) old perf tools with the buddy watchdog have the wrong behavior
> (they've regressed).
>
> It is also not hard to have the watchdog files named
> <mechanism>_watchdog, such as buddy_watchdog, nmi_watchdog,
> arch_watchdog and have the contents be 0 or 1 as appropriate. Such a
> scheme would have less overhead for perf, make the name more intention
> revealing and not alter old perf tools. I'm really not sure what
> problem we're trying to fix by not adopting this approach. I was
> surprised the buddy watchdog merged but using the nmi_watchdog file.

The buddy watchdog was pretty much following the conventions that were
already in the code: that the hardlockup detector (whether backed by
perf or not) was essentially called the "nmi watchdog". There were a
number of people that were involved in reviews and I don't believe
suggesting creating a whole different mechanism for enabling /
disabling the buddy watchdog was never suggested.
-Doug

