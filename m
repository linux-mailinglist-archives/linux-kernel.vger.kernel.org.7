Return-Path: <linux-kernel+bounces-819999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968DB7E4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6D7AC849
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224026FA4E;
	Wed, 17 Sep 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUMkzv3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02032BA42;
	Wed, 17 Sep 2025 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087350; cv=none; b=NOQdMUmDU6XAE01+14JvalxCRhaARjAzzXtWQFjnD8tqemVlGkAeNoqjXOs90ZLL2F78SE3BVh/MZWogYtTpWqNmgQcupoZRuWk2zV3G6jkzdz/o+SH+PxizlFSb0FfVBBP4Yus+HpbMC3IQuTC6uZzVrAkLe8uSY6D63/px7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087350; c=relaxed/simple;
	bh=1WaN1+VS/2NmIW3J1I9V+lFYw7mqy2+wDfdY6Gnjxxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC/8m08iU36JE+ni7tT73FgrGOOZ/K5GiBeOjNQlTJj27FC9R94kT/NjT6qxCSEGmxI2oTCjX4Wwd2GH3WXGtNCTpWzwuRvcOZqIZsedDn6MywtIxohBAXhjuM/alxMSk+o5rmy0NSiFqSqcRx2UXGn2FnYP0vFKbLVFRHJnER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUMkzv3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD882C4CEF0;
	Wed, 17 Sep 2025 05:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758087349;
	bh=1WaN1+VS/2NmIW3J1I9V+lFYw7mqy2+wDfdY6Gnjxxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUMkzv3bXvKVKSNP8VsH1qHTukPPjaJa4BFrytybZbphIfxNx+82GJ3aQpfH5KqVE
	 /k5Io7gA9lNbE2sKWMXFiOe2QVlfxD/Q+pN2tCedPkhju7lgGwS9lQjcA56LnJ9uXK
	 t/Quwfw8CJFBZPAQm7+K413L9y7TeLZP8vwHLPCDG8B+kL7SZVe48doGfE/jhXETYJ
	 zmodle65GIEOC2+S32YHex8Iqwq82GCnyDglECXABU7Vrsg0oxkTsrTz85ZsT5YHIb
	 FBvUuXaipVLNF/3aTuXxwarP0T5nEYieBiSu6ed5jRnlDA1MH2A/ub3gBLcje/siZt
	 jo3sJG10UvOJg==
Date: Tue, 16 Sep 2025 22:35:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
	akpm@linux-foundation.org, catalin.marinas@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org,
	masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, xur@google.com,
	ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org,
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com, gautam@linux.ibm.com, arnd@arndb.de,
	zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com,
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup
 detector
Message-ID: <aMpIsqcgpOH1AObN@z2>
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev>
 <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>

Hello,

On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> On Tue, Sep 16, 2025 at 6:47 PM Jinchao Wang <wangjinchao600@gmail.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > On Tue, Sep 16, 2025 at 7:51 AM Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > > >
> > > > Currently, the hard lockup detector is selected at compile time via
> > > > Kconfig, which requires a kernel rebuild to switch implementations.
> > > > This is inflexible, especially on systems where a perf event may not
> > > > be available or may be needed for other tasks.
> > > >
> > > > This commit refactors the hard lockup detector to replace a rigid
> > > > compile-time choice with a flexible build-time and boot-time solution.
> > > > The patch supports building the kernel with either detector
> > > > independently, or with both. When both are built, a new boot parameter
> > > > `hardlockup_detector="perf|buddy"` allows the selection at boot time.
> > > > This is a more robust and user-friendly design.
> > > >
> > > > This patch is a follow-up to the discussion on the kernel mailing list
> > > > regarding the preference and future of the hard lockup detectors. It
> > > > implements a flexible solution that addresses the community's need to
> > > > select an appropriate detector at boot time.
> > > >
> > > > The core changes are:
> > > > - The `perf` and `buddy` watchdog implementations are separated into
> > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > > > - Global function pointers are introduced (`watchdog_hardlockup_enable_ptr`)
> > > >   to serve as a single API for the entire feature.
> > > > - A new `hardlockup_detector=` boot parameter is added to allow the
> > > >   user to select the desired detector at boot time.
> > > > - The Kconfig options are simplified by removing the complex
> > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to be
> > > >   built without mutual exclusion.
> > > > - The weak stubs are updated to call the new function pointers,
> > > >   centralizing the watchdog logic.
> > >
> > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is that
> > > enabling and disabling whatever the boot time choice was? I'm not sure
> > > why this has to be a boot time option given the ability to configure
> > > via /proc/sys/kernel/nmi_watchdog.
> > The new hardlockup_detector boot parameter and the existing
> > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> >
> > The boot parameter selects the type of hard lockup detector (perf or buddy).
> > This choice is made once at boot.
> >
> >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a simple on/off
> > switch for the currently selected detector. It does not change the detector's
> > type.
> 
> So the name "nmi_watchdog" for the buddy watchdog is wrong for fairly
> obvious naming reasons but also because we can't differentiate when a
> perf event has been taken or not - this impacts perf that is choosing
> not to group events in metrics because of it, reducing the metric's
> accuracy. We need an equivalent "buddy_watchdog" file to the
> "nmi_watchdog" file. If we have such a file then if I did "echo 1 >
> /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to be
> disabled and the perf event one to be enabled. Similarly, if I did
> "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect the
> perf event watchdog to be disabled and the buddy one enabled. If I did
>  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> enabled. I don't see why choosing the type of watchdog implementation
> at boot time is particularly desirable. It seems sensible to default
> normal people to using the buddy watchdog (more perf events, power...)
> and  CONFIG_DEBUG_KERNEL type people to using the perf event one. As
> the "nmi_watchdog" file may be assumed to control the buddy watchdog,
> perhaps a compatibility option (where the "nmi_watchdog" file controls
> the buddy watchdog) is needed so that user code has time to migrate.

Sounds good to me.  For perf tools, it'd be great if we can have a run-
time check which watchdog is selected.

Thanks,
Namhyung


