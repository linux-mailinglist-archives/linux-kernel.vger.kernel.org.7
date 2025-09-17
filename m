Return-Path: <linux-kernel+bounces-820029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35496B7CC61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DE21C019A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BA270EAB;
	Wed, 17 Sep 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNIbWBmh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730351DDC0B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089652; cv=none; b=KOU7OzYhgUorZ94EkYb0bHaUYBxtkxlI1j+0UdKvhUfWNTqFBpADkRa2VO9Z5Qdo/fCmnzruzDB39J1NyexHjvrlfTp+MM3yji7tkw3xlSxfwRCd9DFfC5+5ozHsD7eWLR6j02tb/+12t5IGkUF6ddufjPgZPZDXYujD1OuWt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089652; c=relaxed/simple;
	bh=jwNyZdCzkpVeu8M/UncF/JIEZsPkukGJTMUOSNPYnO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyf2a8TAnRG65YJ0C6eFeHJ8yImBlPwMsBaaXHORmKZ72JGBbobKVjye+WYifJLtoWErCNadXIKatxKPTDJ479+m3BUfWqIvSFrhzggdjgUhjcdXdwNB4SnwPHovt17kFFtGxyxSGRFBB3tCETeDF/6JyS3fG3JlH1ANabaULnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNIbWBmh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-776b0100de0so466103b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089651; x=1758694451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FmzfgTfio2uU1BYpRua3Nqm7f01ztuczzsg9vKgt8Hk=;
        b=fNIbWBmhnTpKRlRZlHhECeXxrxRTkuUGze9MPrTN3O0pBWYjyWKp80N/jMoEHtKNlw
         7it1yZ/Jc4+Xy4LGlPw8Af0KBpIjvxtUYCQ0C4TxuJeOLOG935Q5ouWtu6ZoicaI7m0I
         TRBO1S4hQUSvUoxhg5kp+xbhmAn6s/JgakGKfridtuDyQaXlpe2Rehq6bEpZQQeYqqIb
         eoiUGU9Ot0IzawZh2UfPYJkIy2CB2L7Jo3NchVSkF4mRATr5DUcIxeZa6nWTA6TaQq7f
         eLs4wx+fZ/RDc+IFZ5dYKRItMp1W+H0KBdkbmsgW2eKd7pRlfr4OkuuKJnEmclNosI/i
         mi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089651; x=1758694451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmzfgTfio2uU1BYpRua3Nqm7f01ztuczzsg9vKgt8Hk=;
        b=wksscgY9va7nl1mvGIUFpXAwqPbilaLbisMZlG+OfZMIcztD632/pKQId7RkMayhhk
         PKH6X7ieAuytgjMdSQWxpJB222jY+PtYjBzndZ7i9uWudJLQUFIb84HlYSRV+CLyQW3g
         uM7wTMDK0Ru2UX8v9v87uPpPhrdYMw4al3r99ELuGYan4EOEWaHOz4NkarkR0DdkKS2b
         kc96RyfpP9qGGXFDr+/YSXl+Y35aqBS5MzEYGiW38l5OgsG+VeD6jg+cuT0tXBJWXptn
         Q3XkQVp3JYUea8Nd+4/eOR91SEaej4debIXQQumwjm9I3v0fgPMvIQ8uRtYJFPYyg9HB
         ScOA==
X-Forwarded-Encrypted: i=1; AJvYcCVeUjr0oPMx4hx8MzI/agj5QSdW48b/u1zOJ7HHZbHvOcEtN0G4g/D8Vxd5wBIPL3TV9Tnndm49/lHcrUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcu0XgkIkpsgI3/nbLMe5IIBy629FKcsie22aNh08W2ANbm6gL
	Cw7J3p5ZyeX+kt/1O4oy0VpeIKOP2A7Ykqjd8Bu4m7g9mAAeQp+7kGw6
X-Gm-Gg: ASbGncuTb7PtdwcdLQZjghfkrGW8Lj4E3ca6b3YYTF5Hgax72sNxTSWwJeXKgQKcZfJ
	JfA8oxloKBW79n2rIbHokKtQQR69AyiDq2fDzFsETvjxBRzSySwrpla0zZIrletyh2NzQMndAcG
	+ZYGt+nB8BDcvcUcHsEVMlRInsbFJV8HXWOorC7WY5tsmKW8O4U1IEuYdkBZjdJurpxI7+6jgzi
	yMVG1dTRNHwAaVJiy2+/2DqFWXgP44zhiCTyZua48DWb1Tf1HnwMqLRI8L0ZRQ8GHF6lYdJnRBz
	WMmxwiIvslglMbgQB+HbLQxIM0O9d1INKc8pkmp+um3v/0Cund7jhDxhSyE3zZcgctKOXOkjN3G
	njmS/w+iqC3I8J0YJNxGpUEMMjo2gMMejxINeUT9V
X-Google-Smtp-Source: AGHT+IFbOOUPuUp71MZLUCXJnIvNlVqkzTniqbE7azWA2KDlmn7NJjUtb/+FLQYp6JRxCAhLg6/vEQ==
X-Received: by 2002:a05:6a20:3d10:b0:243:b089:9fbe with SMTP id adf61e73a8af0-26701102125mr7170178637.31.1758089650568;
        Tue, 16 Sep 2025 23:14:10 -0700 (PDT)
Received: from localhost ([146.19.163.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm12638506a12.19.2025.09.16.23.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:14:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:14:02 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Doug Anderson <dianders@chromium.org>,
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
Message-ID: <aMpRqlDXXOR5qYFd@mdev>
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev>
 <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMpIsqcgpOH1AObN@z2>

On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > On Tue, Sep 16, 2025 at 6:47 PM Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > On Tue, Sep 16, 2025 at 7:51 AM Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > > > >
> > > > > Currently, the hard lockup detector is selected at compile time via
> > > > > Kconfig, which requires a kernel rebuild to switch implementations.
> > > > > This is inflexible, especially on systems where a perf event may not
> > > > > be available or may be needed for other tasks.
> > > > >
> > > > > This commit refactors the hard lockup detector to replace a rigid
> > > > > compile-time choice with a flexible build-time and boot-time solution.
> > > > > The patch supports building the kernel with either detector
> > > > > independently, or with both. When both are built, a new boot parameter
> > > > > `hardlockup_detector="perf|buddy"` allows the selection at boot time.
> > > > > This is a more robust and user-friendly design.
> > > > >
> > > > > This patch is a follow-up to the discussion on the kernel mailing list
> > > > > regarding the preference and future of the hard lockup detectors. It
> > > > > implements a flexible solution that addresses the community's need to
> > > > > select an appropriate detector at boot time.
> > > > >
> > > > > The core changes are:
> > > > > - The `perf` and `buddy` watchdog implementations are separated into
> > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > > > > - Global function pointers are introduced (`watchdog_hardlockup_enable_ptr`)
> > > > >   to serve as a single API for the entire feature.
> > > > > - A new `hardlockup_detector=` boot parameter is added to allow the
> > > > >   user to select the desired detector at boot time.
> > > > > - The Kconfig options are simplified by removing the complex
> > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to be
> > > > >   built without mutual exclusion.
> > > > > - The weak stubs are updated to call the new function pointers,
> > > > >   centralizing the watchdog logic.
> > > >
> > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is that
> > > > enabling and disabling whatever the boot time choice was? I'm not sure
> > > > why this has to be a boot time option given the ability to configure
> > > > via /proc/sys/kernel/nmi_watchdog.
> > > The new hardlockup_detector boot parameter and the existing
> > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > >
> > > The boot parameter selects the type of hard lockup detector (perf or buddy).
> > > This choice is made once at boot.
> > >
> > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a simple on/off
> > > switch for the currently selected detector. It does not change the detector's
> > > type.
> > 
> > So the name "nmi_watchdog" for the buddy watchdog is wrong for fairly
> > obvious naming reasons but also because we can't differentiate when a
> > perf event has been taken or not - this impacts perf that is choosing
> > not to group events in metrics because of it, reducing the metric's
> > accuracy. We need an equivalent "buddy_watchdog" file to the
> > "nmi_watchdog" file. If we have such a file then if I did "echo 1 >
> > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to be
> > disabled and the perf event one to be enabled. Similarly, if I did
> > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect the
> > perf event watchdog to be disabled and the buddy one enabled. If I did
> >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > enabled. I don't see why choosing the type of watchdog implementation
> > at boot time is particularly desirable. It seems sensible to default
> > normal people to using the buddy watchdog (more perf events, power...)
> > and  CONFIG_DEBUG_KERNEL type people to using the perf event one. As
> > the "nmi_watchdog" file may be assumed to control the buddy watchdog,
> > perhaps a compatibility option (where the "nmi_watchdog" file controls
> > the buddy watchdog) is needed so that user code has time to migrate.
> 
> Sounds good to me.  For perf tools, it'd be great if we can have a run-
> time check which watchdog is selected.
Considering backward compatibility, I prefer to keep
/proc/sys/kernel/nmi_watchdog and introduce a new file called
/proc/sys/kernel/hardlockup_detector_type, which only shows the default string
or the boot parameter.

The global str pointer hardlockup_detector_type was already introduced in the
patch, so exposing it in a file is straightforward.
> 
> Thanks,
> Namhyung
> 

-- 
Jinchao

