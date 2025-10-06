Return-Path: <linux-kernel+bounces-843590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C08BBFC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795CC3C2CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3E1F7098;
	Mon,  6 Oct 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wx9JY0h6"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3E2556E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793566; cv=none; b=NGeDFbSUuuokpGxUGmYlu+/45/PJyFgXceKw8DF4MywkjaJVtfTZghKhawt6zOSQnUbiE7gh9wHkQtPUHKlq3eVKdCdWX9hnbSv6Zds87xREJMjLltpYJjM29F13Ky3GCuhD3hbgSLNyWHsGntjwlyl+CuCxc0UIf5KzbZGuhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793566; c=relaxed/simple;
	bh=7tqlVWP4acxgpE5EcMSiKS87wF6KuJWZHL6Q47dsTBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tujZXd6gUrNcbZGg1BG2TdbrAOKcNUK331nKrVGAB6kzc3BT7M7/ddE+OPOiKGJ7oRA8qgptYfJ3FMzS2FZ1Y5ZDJh9E1KUByQf9fa2PnbEnrsSpr3BmHYEwopTGjnXrAC20oczJqYv8v2r88++DpFSjmalSmxNFP5MEu1E8YA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wx9JY0h6; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54a880e2858so3625600e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759793563; x=1760398363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnju/FemhqeCtzM3OCxOQRA++/MMOptuug53TgoDLoo=;
        b=Wx9JY0h684A2yt2Np+lKhYrFhsMGVcvoWe0t48BuyuDualUUw//ZZgAgVM3zrScoHz
         UuROqKPUEbkyxaTNCCQM8clCzCSvnQmWscWtOaX0hvPQBiijQ9d905QcLGzESUEBgfMN
         d2lldJZLa/RmQp74VfoP9oUfcghqZ4rcf7Qec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793563; x=1760398363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gnju/FemhqeCtzM3OCxOQRA++/MMOptuug53TgoDLoo=;
        b=dN2tNAWdwmzoodSjjOLkrqxSN66nPoJQlfP7BTS1XYjoCaG9T65upuimdwRbVz6vfF
         Im2E81aw1CBf68ipjTTCc4XZsvrFCCu4Mxf7gUlAVtb2M+h81x0kaB8dH9ndgP/35GPp
         StZekN9WmXSjv6M7jdFNxMelLhhQXZIF+rqXva9Ir8kfUwPuSNl+x/4A0IvcNmRDcpg3
         ibx6k46G7pvunBg/E8QXLvyXp9QOVR5qaOX2O7muE/OzV8sLYfuqaOr9fawY0gSEVO0G
         sh8AOFPchxRTsdI0DvFMzcgGKWKmn1mpxgXgNhDCpxDVOiQqiWTnrzsxJ9vMJddih7UH
         7BHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDaTlqlbByLCgK4mBaT0hSXIPH1Y71xkcsnWpK4ue+BVZTda7q71ns/WzQm+mriFtUFm2ZE4YwOBgnkn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6AuZ3Ql+wuH0chF168Tu9R9dmX0VIetLUlSA5oJt9TBL2HkNN
	k0OtYj9vnM9GKE3kOqHgy+gpXfPkSodjYJgrmPr7ISoROqvpIGzWJrXXvechZTJhtdSx1BUsPTJ
	vSxI=
X-Gm-Gg: ASbGnctCXQ9y9fHN6SyUFjRhryxcBxG6k3aBAuF2IEa4Xt78gWFSyh1Q/O3Ll21UAbA
	LTAibjRgZgAKUBT9AGyNEG853LSlpfB98IeOHrHrmqhQRfS0xVPjtnP1gFZDjgR+vBUCFf05kEO
	f3OPcWYtiVNdIFQ9KyqWheC/cd9ZgkQ0ZG4kVbT3yQ1S7WC/ScoGsuoR1BzrGE2NE4CIrq3sG9z
	FbHHf64+5mIR/ZNY6dw7owJwJ+b/5KzkvFmBD2XiCDvSxYUe38EaRaePZ7e/pqRrqz2F1Uo5g1C
	Wppjz6J2geV6OlzVjNvPGNlsYsLBJkEetGwiRXaoFXXm8/OFXQ+0gY9AGL9g4AjcbiA/Au7EAUx
	bUbwWZGyO0diPs2sd98oH0iVgMr51f4y5BMJj/8x+4u6IH+oTkDyJU7sfrnG4DwcWGN8EFwE8H3
	iZIj9lVVnmNhAHElbtgcAi
X-Google-Smtp-Source: AGHT+IEixpbDiOsGWcq3Vj9HYr7l0RZpWa7qdV2lvDSMo/IzSUkO4VMiTvKtXc+mkaaFDiPSkErYVg==
X-Received: by 2002:a05:6122:3c50:b0:543:8c04:43f4 with SMTP id 71dfb90a1353d-5524ea6ea23mr5855063e0c.14.1759793562678;
        Mon, 06 Oct 2025 16:32:42 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce0f84dsm3417226e0c.3.2025.10.06.16.32.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:32:41 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-58de3ab1831so5302965137.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:32:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTr/58vI6dmJdy904gTdqQ576lyN5628vpf4v4Unuh8MXMhNxEzS8VPrGcd0eQS7YuJNTFtQy/jolIuKQ=@vger.kernel.org
X-Received: by 2002:a17:903:1a86:b0:28e:7567:3c45 with SMTP id
 d9443c01a7336-28e9a54ef63mr131748815ad.9.1759793096320; Mon, 06 Oct 2025
 16:24:56 -0700 (PDT)
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
In-Reply-To: <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Oct 2025 16:24:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
X-Gm-Features: AS18NWBbZ6LGmNfNjtMxbnkF3b7BSgxpW00PIA8Lwf4SUgxrT3SU1KuL0dbjEqc
Message-ID: <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Ian Rogers <irogers@google.com>
Cc: Jinchao Wang <wangjinchao600@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
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

On Mon, Oct 6, 2025 at 2:30=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Sep 16, 2025 at 11:14=E2=80=AFPM Jinchao Wang <wangjinchao600@gma=
il.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > > > On Tue, Sep 16, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinchao60=
0@gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > > > On Tue, Sep 16, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangjinch=
ao600@gmail.com> wrote:
> > > > > > >
> > > > > > > Currently, the hard lockup detector is selected at compile ti=
me via
> > > > > > > Kconfig, which requires a kernel rebuild to switch implementa=
tions.
> > > > > > > This is inflexible, especially on systems where a perf event =
may not
> > > > > > > be available or may be needed for other tasks.
> > > > > > >
> > > > > > > This commit refactors the hard lockup detector to replace a r=
igid
> > > > > > > compile-time choice with a flexible build-time and boot-time =
solution.
> > > > > > > The patch supports building the kernel with either detector
> > > > > > > independently, or with both. When both are built, a new boot =
parameter
> > > > > > > `hardlockup_detector=3D"perf|buddy"` allows the selection at =
boot time.
> > > > > > > This is a more robust and user-friendly design.
> > > > > > >
> > > > > > > This patch is a follow-up to the discussion on the kernel mai=
ling list
> > > > > > > regarding the preference and future of the hard lockup detect=
ors. It
> > > > > > > implements a flexible solution that addresses the community's=
 need to
> > > > > > > select an appropriate detector at boot time.
> > > > > > >
> > > > > > > The core changes are:
> > > > > > > - The `perf` and `buddy` watchdog implementations are separat=
ed into
> > > > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enable`=
).
> > > > > > > - Global function pointers are introduced (`watchdog_hardlock=
up_enable_ptr`)
> > > > > > >   to serve as a single API for the entire feature.
> > > > > > > - A new `hardlockup_detector=3D` boot parameter is added to a=
llow the
> > > > > > >   user to select the desired detector at boot time.
> > > > > > > - The Kconfig options are simplified by removing the complex
> > > > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detect=
ors to be
> > > > > > >   built without mutual exclusion.
> > > > > > > - The weak stubs are updated to call the new function pointer=
s,
> > > > > > >   centralizing the watchdog logic.
> > > > > >
> > > > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is that
> > > > > > enabling and disabling whatever the boot time choice was? I'm n=
ot sure
> > > > > > why this has to be a boot time option given the ability to conf=
igure
> > > > > > via /proc/sys/kernel/nmi_watchdog.
> > > > > The new hardlockup_detector boot parameter and the existing
> > > > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > > > >
> > > > > The boot parameter selects the type of hard lockup detector (perf=
 or buddy).
> > > > > This choice is made once at boot.
> > > > >
> > > > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a simp=
le on/off
> > > > > switch for the currently selected detector. It does not change th=
e detector's
> > > > > type.
> > > >
> > > > So the name "nmi_watchdog" for the buddy watchdog is wrong for fair=
ly
> > > > obvious naming reasons but also because we can't differentiate when=
 a
> > > > perf event has been taken or not - this impacts perf that is choosi=
ng
> > > > not to group events in metrics because of it, reducing the metric's
> > > > accuracy. We need an equivalent "buddy_watchdog" file to the
> > > > "nmi_watchdog" file. If we have such a file then if I did "echo 1 >
> > > > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to be
> > > > disabled and the perf event one to be enabled. Similarly, if I did
> > > > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect the
> > > > perf event watchdog to be disabled and the buddy one enabled. If I =
did
> > > >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > > > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > > > enabled. I don't see why choosing the type of watchdog implementati=
on
> > > > at boot time is particularly desirable. It seems sensible to defaul=
t
> > > > normal people to using the buddy watchdog (more perf events, power.=
..)
> > > > and  CONFIG_DEBUG_KERNEL type people to using the perf event one. A=
s
> > > > the "nmi_watchdog" file may be assumed to control the buddy watchdo=
g,
> > > > perhaps a compatibility option (where the "nmi_watchdog" file contr=
ols
> > > > the buddy watchdog) is needed so that user code has time to migrate=
.
> > >
> > > Sounds good to me.  For perf tools, it'd be great if we can have a ru=
n-
> > > time check which watchdog is selected.
> > Considering backward compatibility, I prefer to keep
> > /proc/sys/kernel/nmi_watchdog and introduce a new file called
> > /proc/sys/kernel/hardlockup_detector_type, which only shows the default=
 string
> > or the boot parameter.
>
> Is there code using the buddy watchdog that cares about the
> /proc/sys/kernel/nmi_watchdog file? My assumption is that everything
> except Android is using the NMI watchdog, so a new
> /proc/sys/kernel/buddy_watchdog file doesn't impact them.

Buddy watchdog has been out there for a few years. At Google, I know
it's used by everything except Android. AKA I believe it is used in
Google's servers and also in ChromeOS. Both of those (presumably)
enable the buddy watchdog via calling it "nmi_watchdog". It's possible
that some Android phones are using the buddy watchdog too but I'm not
aware of it. I don't believe Pixel is using it, though that could
change in the future.

IMO at this point "nmi watchdog" is simply a synonym for the
hardlockup detector. That was what it looked like in the code before I
started messing around and adding the buddy lockup detector and it's
how it is now. While it's unfortunate that there are two names for the
same thing, I don't personally think that should change at this point.
FWIW, even the "buddy" watchdog relies on NMIs to actually get stack
crawls on stuck cores, so NMI still means something even there.

If we want to tell between the perf detector or the buddy detector we
should add a separate file for it.

> On Android
> writing to /proc/sys/kernel/nmi_watchdog would switch from updating
> the buddy watchdog enable/disable to the NMI watchdog enable/disable,
> but it is a straightforward patch to make anything doing this update
> the buddy_watchdog file instead.

Straightforward, but you've got to go find everyone that you break by
doing this. That's not something I want responsibility for. If you
want to convince others this is something worthwhile and you've got
someone signed up to deal with the fallout (if any) then I won't
object, but it's not something I'd be in support of.


> If we have to keep "nmi_watchdog" then we should deprecate it and
> create an equivalent file with a better name (ie without NMI in it).
> It'll be moderately annoying in perf to determine whether the NMI
> watchdog is enabled by having to read two files.

Again, up to you if you want to try to do this, but I'm not really in
support of it. It doesn't seem terribly hard to make a new file that
says which hardlockup detector is in use. If that file exists then
read it. If not then you fallback to what you have today.

-Doug

