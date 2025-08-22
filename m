Return-Path: <linux-kernel+bounces-780910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F9B30ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB5C1C8396F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6C35959;
	Fri, 22 Aug 2025 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="negoLTiM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579A13C3CD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826726; cv=none; b=hZdu/PjZLE99PERoMQjKgeUZuQfCS/SMWEvM3ALx8QiwjhefBKiD8D3xna6NwweedtsHIkEa6oRZUiiB6xHx2VpSIuAuXBqryPObcRsDL2Mxk8mpwxF6k7DCl0+GlfG1NV0oOlG7AG868DJonl3Bfc13hnBqXtG+NqU2qM1J6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826726; c=relaxed/simple;
	bh=A49EhjtovdcOMZSxAFwCEK81dRUbjpo5bkUejNjPW/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QTr0NRW+u+CGrdEF8MMEadh3TDbq5izkDK9BKrIlKNiT831mhsP7+HjwbACc8qSUap0bQRK3y2/974Llpj69naIgG2VxvJeJevF1NKcGNnoC8UYcjBSD2BgICdWjOol9Fy0nQWi6l1503+hbI0pPebf9FnCZlVKLGaqd4oywQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=negoLTiM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445805d386so19178645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755826725; x=1756431525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W15LouMyj4vdHymi7TVZHUFLWipG+7CdV/EGR2TsyJU=;
        b=negoLTiMhigrb4WOxUeYZwslBrPELMadcwzJr1Pf1HPZ8JFSZoYv9vWJAXh04/Gnx5
         bUn6SOV+J2gD5heKMzK4PZKrxH4bVDsEFyV77Boyg3Rv0IGwnRc2O2FdQzCL7TblwEBE
         EOtUyD6TBcVnoiRKLGwE/R5H6PTwD6CADLhpzs+lxiSlV8fkjlsJZCro4FSZTn/5Bt3U
         zmQ1VgYo+NAoLcl0++2RE57NCr1cNpRK0cFjGn/ZRrcUaDPlewLBHlRkBu78wkKUhNHe
         G5PZkRdGHmsxsxmai/5DCJVSAv0lbk5CaxIn8OJqGqGDGJUFPxn3N9M5a6cmXGacT3Ph
         vvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755826725; x=1756431525;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W15LouMyj4vdHymi7TVZHUFLWipG+7CdV/EGR2TsyJU=;
        b=XG0GBRgSuatp2TjAx5gbRe1dUz2Yyw+RRm7El1C4OGaG47zWf5gsEa3bMgw7FaFoGD
         XAsjyqbZt3e0GK7XExBvVDsJqfdvGC324dYnunzDMPbFh8eXaZKBwfI2o8QYbav+eLxk
         LWuU48qNuQyz1O07lLKZqnFLLAG/FilDSQ9e+zKwUHovhrBBxdhg6VnxuUzBVy2l8DQi
         +L00QsHviSMNRPcXpxSL1o7l695w/MLwrA9n0FfpTtmuci1/Hns4ORGZwMJbd5c4W5Ri
         6vsAKdyBHSE1t10aXbXmIocQRHgYv+jl2q8AzMXtbtfn4QIBs9x3lGlrH+7QD9pYCRiD
         4FFQ==
X-Gm-Message-State: AOJu0YzMJUyjkMMuJ44hVeiPq7m8m1FcLQh3VyKN69FB1Srlolt3LBDN
	sF85U5C6FLCkmwmwKTSNUPuadVoYR67SrHjx0c8aT3B4d7iUUJwak7zwTRzGyknhNefTaG0e5ck
	CVMLZir8f5UJHsslITFxBClsJazWc3JSRISY+mEs7HUlnaXLT2cbkpo5CLiYscQcJJcqVuIqoVH
	gpxY1dbUv2Q/sIT5r4YNtfTDniq6MpxYHDMe/bSiCEdZd9TwMipA==
X-Google-Smtp-Source: AGHT+IHopvgy+NT1vyxHR0lL/IQJOLtwOt5TkxAJYqqhMkX+S6CNkIYHIk02Ok4PnPzh/BGnt+DyE+ktjcJP
X-Received: from plbme14.prod.google.com ([2002:a17:902:fc4e:b0:240:1953:fa3])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c6:b0:246:1c6a:7025
 with SMTP id d9443c01a7336-2462edec143mr21257215ad.12.1755826724580; Thu, 21
 Aug 2025 18:38:44 -0700 (PDT)
Date: Thu, 21 Aug 2025 18:37:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822013749.3268080-6-ynaffit@google.com>
Subject: [PATCH v4 0/2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The cgroup v2 freezer controller is useful for freezing background
applications so they don't contend with foreground tasks. However, this
may disrupt any internal monitoring that the application is performing,
as it may not be aware that it was frozen.

To illustrate, an application might implement a watchdog thread to
monitor a high-priority task by periodically checking its state to
ensure progress. The challenge is that the task only advances when the
application is running, but watchdog timers are set relative to system
time, not app time. If the app is frozen and misses the expected
deadline, the watchdog, unaware of this pause, may kill a healthy
process.

This series tracks the time that each cgroup spends "freezing" and
exposes it via cgroup.stat.local. Include several basic selftests to
demonstrate the expected behavior of this interface, including that:
  1. Freeze time will increase while a cgroup is freezing, regardless of
     whether it is frozen or not.
  2. Each cgroup's freeze time is independent from the other cgroups in
     its hierarchy.

Thanks,
Tiffany

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v3: https://lore.kernel.org/all/20250805032940.3587891-4-ynaffit@google.com=
/
v2: https://lore.kernel.org/lkml/20250714050008.2167786-2-ynaffit@google.co=
m/
v1: https://lore.kernel.org/lkml/20250603224304.3198729-3-ynaffit@google.co=
m/

Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>

Tiffany Yang (2):
  cgroup: cgroup.stat.local time accounting
  cgroup: selftests: Add tests for freezer time

 Documentation/admin-guide/cgroup-v2.rst       |  18 +
 include/linux/cgroup-defs.h                   |  17 +
 kernel/cgroup/cgroup.c                        |  28 +
 kernel/cgroup/freezer.c                       |  16 +-
 tools/testing/selftests/cgroup/test_freezer.c | 663 ++++++++++++++++++
 5 files changed, 738 insertions(+), 4 deletions(-)

--=20
2.51.0.rc2.233.g662b1ed5c5-goog


