Return-Path: <linux-kernel+bounces-830507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE1B99DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB2D19C3CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB81FB1;
	Wed, 24 Sep 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkfN5BYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8F92417C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717495; cv=none; b=X6CiI2lolBVre91NpHowWHBSW05i4G7K1JRcxlQu5CN6839E9RDFuobQO0WEFJxOHAbzHsrHZRPoksLM7ub+svcLo93ggWwVro1IwadTq33Ff1D4jfkpdqVkreKVnLRNObD9GzlkjrRTBccGKGD8wMiKlkOYapdCY/3ur4D95tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717495; c=relaxed/simple;
	bh=czD1suQinfy+rBLz89im1EB34LEjxwjibqErL74jV8w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R8XZeU+5khmrR0WPRthwtWmN/yZJ/SYZBIQ+Vm74385XYCOKaDaURvFko+DSi2g7G8oN87aTO0Wn90Ai4W/woFO8i622knLEoKWJMECO3d0PFA5L14NNBNe9LBO+up4IpSW46E0Zu5Hqtic6Pa9whp0DysCQx2bv6j6kjGMDpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkfN5BYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB635C116B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758717495;
	bh=czD1suQinfy+rBLz89im1EB34LEjxwjibqErL74jV8w=;
	h=From:Date:Subject:To:Cc:From;
	b=LkfN5BYkmlc0pmgXks7vEuM73NKcCY8GFehePmf4ozBcifoc3/dJN+pC2PpVpcZT/
	 fJn4llJGDH3d3YF4cOYGqzhnsscM4EQfLLu+njKTfB5R19U0m9ASIqFJZGfLYAa9Ro
	 ClfzGTnCUqPu9DFRPRJFQnfMKBbQPODcyih11/ekxJSvfWBBO4tQtkJwEkPDNC4QJ1
	 XP/c2DF5j+zGitXicE6b2oc567wE2qwJ2c7pqxky3usrVjud+yVHMe/8JrZvN3Gsmg
	 mpLhHMngQVK2/qd1g8Sce/KE5s9me4F1zrB7oSa59t9zLNQ+1Qnjzc4Sqla/DsncGy
	 rnyRkSgCeKrIQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74382048b8cso5341698a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:38:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQhDlln1sd6bOl87fEIbrsS5BOqNEIPQlUTcC9K9tL2xmMZSXDatmX8oO2+PThN/z+aSfH33vs3f1qWwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09jHy17XHl8LThDKprpTxPC8ijRxqDaSzQaQQBHYeCOe+WDZg
	je39IKOgxCPa+bVQ1OJt2nEF938POGoER4RTrC5jNz9GvL0WH7UOC2EbAroet0Wt/nZe23uhHxn
	+MNoUywTdAUIkq88muQc1fXai6VTWDWQ=
X-Google-Smtp-Source: AGHT+IH4oiQputRouqoqiC1vt+uvYEQ86hVX9sEqhAyohQUCr9e632INcAZEMAkbH+AlDf1Jr76nYYZAxt5YU+wztqc=
X-Received: by 2002:a05:6830:2653:b0:757:44de:c0c6 with SMTP id
 46e09a7af769-79153cb9819mr3497706a34.17.1758717494282; Wed, 24 Sep 2025
 05:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 14:38:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
X-Gm-Features: AS18NWD-I5Uq4FjQUnyU6MYt8XA4c9y3TTHkTdlRaQUlWgzKG7lMPMZTCK7q9Ik
Message-ID: <CAJZ5v0jfvPV2cmk0=7G0LyAYvnKmYMG5fM6p_-oCYTgYTgN96Q@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc8

with top-most commit 8ffe28b4e8d8b18cb2f2933410322c24f039d5d6

 cpufreq: Initialize cpufreq-based invariance before subsys

on top of commit f83ec76bf285bea5727f478a68b894f5543ca76e

 Linux 6.17-rc6

to receive a power management fix for 6.17.

This fixes a locking issue in the cpufreq core introduced recently and
caught by lockdep (Christian Loehle).

Thanks!


---------------

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

---------------

 drivers/cpufreq/cpufreq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

