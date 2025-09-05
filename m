Return-Path: <linux-kernel+bounces-802472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33568B452B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967287BF29E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98030CD8C;
	Fri,  5 Sep 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hog5+1Us"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78E27FD68
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063312; cv=none; b=m3FgHljdUaOQ8OhH0Ayd9d/TenfBumRxKn//DH2mzXclkkhd+9W7x0raM33aTwBd5GJpRT93elLZcusz84bdrGpjsJdskw1oZVMY4L1XowNdqygyjRr3D0rNMl6BWZFO7aExTG3lU+3C+yiFU/d77nwBrC0GXhB7BBoX2cvezeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063312; c=relaxed/simple;
	bh=pfUYsJytL5Xha+9fmGtXNsuTP5Iy55visY0fvimyZbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyJ3ID/ZVbH1khXE8izoCgo6hNtgLLQUL/DCEYXH3feH4DAku/z+K6ebNUY8V9uBf62X9IIZemjx4MUQg2ziCQxu7SBG0WjwX3E2TKhamTBkGaSxaMZNGXUY83xlFBG9Y8dufm3DJG8jhmDwdJG7aXBJi6170JxwOvqMJuwHdxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hog5+1Us; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so11331785e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063308; x=1757668108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfNHkuuYJisQeLCjdnmFarVASjjt4pqTTKCuIEhNpU0=;
        b=Hog5+1UslOdFsaPl3KvhmRVcpoT0JvaPMjqSpsRWTdvvG6sFubfvYz+P/7rpTzdkJq
         xdS7P1YTVFleidcF5Dupgz1RmG/SVdc2/N1kSOIrHXAAYlcw7zshCwgIexQ6dUcBxV8u
         hagR86hBw0Up6mHvvIISqPg8D/cwgYVVyAUam5i1/ef+BsEjHDUFWpTDEN5+yU/lhehf
         yYrHE69+8I4UvA5jW/50LOagD79xomZmcg6HHn2lZ+alDtruEFq8JjMtNCosXRY819YY
         v3DqaKqB9mLo9Bev/do0zRJ1XCR7P7dwFg4mKSTdNOtcP62yrlecKo48I4jvWoD+51VK
         M6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063308; x=1757668108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfNHkuuYJisQeLCjdnmFarVASjjt4pqTTKCuIEhNpU0=;
        b=UsPy006EuEyklQ0UoJPMhbMZ2VH6XafrlIHjcmgJZN613uJvOpn9aqhS6cX1sJoNdM
         lnL6bK7T6Uh+Mn7FKbOKdF1Vp4TNDPDUJ3BgBKW0J3PoPjDuTw3gXrXUC54gtlM7IWLB
         ZdcRIEbEPzRj7jDtP5HsZNPrVzEgs7M8AFR78C4picwaeDNISnUbMDO9yUwaZ+o5fkrQ
         fj06DurdW0naacfkW7wV8mJ1A7da56yu7PVaSoGFQo3X2/YXespqJM9ULWRnL1q/DBQ7
         AN4n7tiD3l4fL0NZVykFD6mk3QqdBFTHETrsBxOty3uqaOQJplXUHLgUfX78q8y1AGr+
         Svzg==
X-Gm-Message-State: AOJu0Yy3WPW2GnUUSewSh5tiP7PH7i7UlD5b06q1c74Er+FYPEkx0uKP
	zxLYEyG1Eai4mbVL8L0AiGOUcd9wvVuoceQYyMvK00Z23t79VUwBa5mFeLojn1zE/tWLgjErRuq
	X8Ph4
X-Gm-Gg: ASbGnctVsss4DOu8jYz/d/ADlZCWZHx1iFCaGdDh5j/xNjphDvx8I7iVPWgUSLvCmhg
	32PxD6ONL6NgMUstIbp9Dx7nfnFEj9nh6fAq6xuk1a2mSbNOKJyFos9o41Baa1lsd3gsaivFVDu
	za+2BsDJjiBZ1XN6Tt+VhcC9/HwiAuVnXXy70yez6Y8ijFEeFDBP0n6sza29ZTRZNEY1y0Inaa/
	TagTyRa+875CtTiuyZA6Br0Lxo17l/PaEzbuqwiXTYWPYvZd5VFqWfK+sk257tLY85PLUDwpAm/
	fdQ4BiYu3qA0BphjbhUcZsBqJ4nBCxSvqYKE9jAaPOUiyufW/NYx3PiyWhFLR7dq8IckieE7Hlg
	/IgA52xoEuCCLmx497R2yqmMLkRTYs2igsKQ1u7ckCWaBRbxkRkHlrtbu3A==
X-Google-Smtp-Source: AGHT+IEe6Z1CIxc3wwR6bIcUETKibcIoiDaTx4IWniTQ7UYnUkWPwDFvUlnVCzahyGvL94wifXuujg==
X-Received: by 2002:a05:600c:1d1d:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-45dd287d512mr42523305e9.25.1757063308214;
        Fri, 05 Sep 2025 02:08:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0350e80sm68900805e9.22.2025.09.05.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:27 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Subject: [PATCH 0/2] rust: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:08:17 +0200
Message-ID: <20250905090819.107694-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.


=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (2):
  rust: replace use of system_unbound_wq with system_dfl_wq
  rust: replace use of system_wq with system_percpu_wq

 rust/kernel/workqueue.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.51.0


