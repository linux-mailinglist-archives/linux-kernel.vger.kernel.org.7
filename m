Return-Path: <linux-kernel+bounces-844752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5006BC2AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764231891818
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9D230BEC;
	Tue,  7 Oct 2025 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUapcc3w"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A222D7A5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869797; cv=none; b=nzzHJDBlN5WT+jSOD2oz5ODjBHGlTnG4zRG/CJuO6Iq6gFrP/TmBRgGl3TtH/QSkc6XHY3p9gPbi9/6Nw8/wvm7kmueJ8sq4b8JHNNXPXHtgYHheT1Vj9ThOiyyRBduBz9+ZqH5Kw0O3rKj5ReSlHR9bsWiv/RR6bckPdlARMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869797; c=relaxed/simple;
	bh=pDu09pJxstqYrdrZpY4vKw8nJNg9Q+EYnsmiA4cqzeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvtGNwxJVU0OT64saSTzzyXW88WYq+wqgcLPWAXEIDAV6NXq2YeEmU6uPrxdQ7KagqVPlLL552b5KynKeKAgkq/sjN0NKauFh7hodvLp2/p3VquAHAMmdQpKjrfvu0i4hpAODEZE4lJC3gmbSZwkuQeRxCBDJp0wC7XaLhdOYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUapcc3w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2731ff54949so20785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759869794; x=1760474594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrvroDu2Y58Bd2NdGW9gMhnFH6MprmLVyBvqC8xWpCY=;
        b=qUapcc3wn/7niTBP24bQheU4mOUX/S5uKLAhuvvC+WT4zkBo0OK+z1iQ7t8whINYF8
         KXol/861h2biy69BCgNzucWbkq4LotzwmK6g1XJkJ2qhXyv6saod35VCRLIFyBAtAC1k
         diH36d/648BsbdK4KxMSWKXcygQAOQrfMliP0ZH2slZpaOzEh8dQOZU9L1FYhB7PaKUX
         ZlwvVmhASX/WJgP975uEW9GosB1PsjPq66Uv29Yv++SqXnc6UoCBSCqO7RdADjYpfSXn
         l3Q6oyO8XWCLnkobIYXCf6++vaXTTIvHH6jEhMcCMLq3bNOAtLWgxug0xf7I9WhzNJFZ
         7rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869794; x=1760474594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrvroDu2Y58Bd2NdGW9gMhnFH6MprmLVyBvqC8xWpCY=;
        b=Z70tSkWah1Zplg9jOi7qd5p97Y6rhb7WGntD7hptpD5k9fULO6hIE5RzvepNjsNy4S
         GkNXOUveDzlKXy1wIy4idlS9DYbivdLf/6YUNeFvZMorHl9DZ1wzLYVsJV0AKPeG3uyi
         A9CwJvFMAC8sJFd4C429hwF6jxxmKl44V6du3sTRIVOc3ufAuQGYEEOKnSDvgsdnOZ9Z
         GJMIagcw/Iqes0mrjY1STFYdq32+IwogODxE57bZseuUSucqOwuuCKYLNvNLsIEM8BAc
         x/fUG0gNGMIJNVIV+f9zuI/s6NjcRAGzn7N7Ka5lnoKs+rWbbvoiKWCqN+oJoHdVAjAT
         RRsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmxcZDHLGAjjQC7B9HBIx9r6WNgxorN94yPWPfyKIIYGMo8zxZc/6Wb2UO7F3QZxgH4fgjgBK+okoeq0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz956v0cuY582KCfkewmXV1ZuxZLj6pRjD/xwSR44LZdtPvqsc6
	B6RZ2Fw2Y2oAgIfQ261FwSFR/5+d93OY3Po7UuKNH8gEHHTlTfvnefM0I7rxsYTiS8jZuNtlSzS
	bhGV5iwNlSbMGtrLLZSyZFv6O9reqYt+JtHUYRwsx
X-Gm-Gg: ASbGncsf3Y6Nr5PXo1IIjPUzxG6ocom5Vf3uDFKji79TCzMqAFLlui/TmKO/Ks1JV82
	e3x4oMMHvPp6B7ZAQZgykZs1s9KGFtvz/ehHf390CAFp2Rl5sf7kaNJ5Y//Fiwthxo1H5uuiHoV
	RIDgL/4iD5FmlT9yTwT07k14ywAvwBdbuQHpIXuaGeRC5IDOnu0yk3QYhzh3f7ZWsFeH7V4idBC
	3GuJwC0FHeH8H5oACfn+kPYtbS/EiJ5vn0sWybGp9BeIBDdEfS9aEOKdVJZukiwtIuyqVO0qg6R
	PLM=
X-Google-Smtp-Source: AGHT+IGbXb7nFN5J4p1/T3D5a/IxHPzmlMZifarQz/afbkDMwBvBlnMVxodYD8mtYvw0vq22RqLnRdIlnOCbKvzs1c0=
X-Received: by 2002:a17:903:380b:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-2902768ec26mr1656665ad.12.1759869794130; Tue, 07 Oct 2025
 13:43:14 -0700 (PDT)
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
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com> <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
In-Reply-To: <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Oct 2025 13:43:02 -0700
X-Gm-Features: AS18NWBJDZpgfMKp4dMPapMw2PYlBgKsiMEPgy_0H0wauCMcp7CJDsUIkIcziJs
Message-ID: <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Doug Anderson <dianders@chromium.org>
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

On Tue, Oct 7, 2025 at 1:00=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
> On Mon, Oct 6, 2025 at 6:00=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
..
> > I don't mind a file that also says what kind of lockup detector is in
> > use. I'd like the meaning of nmi_watchdog to keep meaning the kernel
> > stole a perf counter as this is the behavior long assumed by perf
> > which I think is the majority or only user of the file. I think the
> > buddy watchdog being controlled by this file is less than intention
> > revealing.
>
> I'm more than happy to be outvoted, but IMO nothing about the name
> "nmi_watchdog" says to me that a perf counter was stolen. It just says
> that there's a watchdog that NMIs are part of its work.
>
> ...and, indeed, "nmi_watchdog" doesn't use perf on PPC, right? As far
> as I can tell, from reading `arch/powerpc/kernel/watchdog.c` checks
> `watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED`. ...and before I did
> commit df95d3085caa ("watchdog/hardlockup: rename some "NMI watchdog"
> constants/function") it was checking `watchdog_enabled &
> NMI_WATCHDOG_ENABLED`. That was at least since 2019, I think...
>
> ...and you can see "PPC_WATCHDOG" depends on
> "HARDLOCKUP_DETECTOR_ARCH", not "HARDLOCKUP_DETECTOR_PERF" so it's not
> perf-backed.
>
> I think this is just the critical question: does/should "nmi_watchdog"
> mean perf-backed detector or is "nmi_watchdog" just a synonym for
> "hard lockup detector". In your mind it's the former and in my mind
> it's the latter. The correct way forward depends on which way we want
> to jump, right? In either case some external code is going to need to
> change...

So we could say it is one-idea against another, I'm hoping to be
objective and come from the viewpoint of the perf code as part of its
function is to be a demonstration of APIs and the buddy watchdog has
altered this. The perf tool has referred to the nmi_watchdog's
behavior in man pages and code since 2016:
http://lkml.kernel.org/r/1459810686-15913-1-git-send-email-andi@firstfloor.=
org
```
+Globally pinned events can limit the number of counters available for
+other groups. On x86 systems, the NMI watchdog pins a counter by default.
+The nmi watchdog can be disabled as root with
+
+       echo 0 > /proc/sys/kernel/nmi_watchdog
```
http://lkml.kernel.org/r/1464119559-17203-1-git-send-email-andi@firstfloor.=
org
```
+void arch_topdown_group_warn(void)
+{
+       fprintf(stderr,
+               "nmi_watchdog enabled with topdown. May give wrong results.=
\n"
+               "Disable with echo 0 > /proc/sys/kernel/nmi_watchdog\n");
+}
```

Probably the most common error message dates back to 2017:
http://lkml.kernel.org/r/20170211183218.ijnvb5f7ciyuunx4@pd.tnic
```
      Some events weren't counted. Try disabling the NMI watchdog:
           echo 0 > /proc/sys/kernel/nmi_watchdog
           perf stat ...
           echo 1 > /proc/sys/kernel/nmi_watchdog
```
and that is saying "NMI watchdog" not "buddy watchdog". Users are
familiar with the idea that the /proc/sys/kernel/nmi_watchdog is
unremarkably controlling the NMI watchdog.

I've not found another use of /proc/sys/kernel/nmi_watchdog outside of
the perf tool.

> The kernel docs are certainly pretty ambiguous here. "kernel.rst"
> certainly mentions perf, but it also says that "nmi_watchdog" is only
> for x86 which is certainly not true. "lockup-watchdogs.rst" doesn't
> say anything about perf and just seems to indicate that "nmi_watchdog"
> is another name for the hardlockup detector.  "kernel-parameters.txt"
> makes some mention of tweaking which perf event would be used, but
> otherwise makes it sound like the nmi_watchdog is just another name
> for the hardlockup detector.
>
> My vote would be two files:
>
> * "nmi_watchdog" - simply a synonym for "hardlockup detector". 1
> enabled, 0 if not (like today)
>
> * "hardlock_detector" - could be "buddy", "perf", or "arch"
>
> ...if the "hardlockup_detector" file doesn't exist and "nmi_watchdog"
> is enabled, you could probably guess that a perf event was in use. If
> the "hardlockup_detector" file exists then a perf event is only in use
> if the value of that file is "perf". It doesn't feel terribly hard to
> do this and it doesn't break anyone who was assuming they could turn
> on the hardlockup detector with "/proc/nmi_watchdog".

It is not hard but:
1) it means whenever perf wants to determine the NMI watchdog is
present it needs to read two files rather than the existing 1, which
has some runtime cost;
2) the name nmi_watchdog for controlling the behavior of the buddy
watchdog isn't intention revealing as the buddy mechanisms whole point
is to avoid the NMI;
3) old perf tools with the buddy watchdog have the wrong behavior
(they've regressed).

It is also not hard to have the watchdog files named
<mechanism>_watchdog, such as buddy_watchdog, nmi_watchdog,
arch_watchdog and have the contents be 0 or 1 as appropriate. Such a
scheme would have less overhead for perf, make the name more intention
revealing and not alter old perf tools. I'm really not sure what
problem we're trying to fix by not adopting this approach. I was
surprised the buddy watchdog merged but using the nmi_watchdog file.

Thanks,
Ian

> -Doug
>

