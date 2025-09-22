Return-Path: <linux-kernel+bounces-826972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5E7B8FC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281C718948F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929702877D9;
	Mon, 22 Sep 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P99aMPg5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F625C6FF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533577; cv=none; b=tPuLCOCigmhrA8s6nE9U3pfeiyqFHOYyKdYevzm3UpUwjP/xL3GTS5q4iBwEu7e67du+lmcmlecLfeKedwhXXCIEb6SC0sr2q55ppfl1CJPJHwYKJ00JaLaWmGQoZYlVYBhXa8yFLS5uTSRiPXrh9jblVOU3U75HAoTTlUhJM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533577; c=relaxed/simple;
	bh=hchWIqZ9e5+T+S0grx85x4RBOslEweq5wCdPHXYbC3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDgv7pGUdGWk61oVqGi2dTmgA5zN1KPirFyS1/DWU/QArvA/l8onYy+fTU82kIGQb0jeaW1N6jMiq5sfKRvMkViaSs4tHlN0mELA+9dyLCgVpngyevk504EWRaIuYHY+4BRwO87sepLAFKMKt+n2arBPRTIu8Z0xEfejIY6Ft9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P99aMPg5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so27753355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758533574; x=1759138374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhHEebbyU5CnpObkeR/WFFbKDX/bFW3JYSJRh0+BuBk=;
        b=P99aMPg54K+lIiNZ0ojxaGd9f0fuX6sXz5ytndUh+6UYXdEg+WBQsmLg5K7GqbzMZD
         QdjI5HJ+PxKOMLEChDMhFeHt9ROUamU2tJhPkkqSp3bhHsTdwqR7cXDjk33aGjJ+xWtZ
         RjAU2NyMr9e+NdNOvW1mkNS3GdxmnEG34vWi6gLemFT2BhHQaWzX2x0SZuAtodwzh+8Y
         eVA3xpd57gmYKn2dTZYb21V88kNYHI+4g9mTHWc1+IahUnQHps7zIN39QYTMQVkWmJun
         r1OaU3M0SaIm110B4IEw2+DEuV84Vqo3dk14lgzDY3s+je5lmAwtbrCgVuiKiJ4psqk6
         u/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533574; x=1759138374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhHEebbyU5CnpObkeR/WFFbKDX/bFW3JYSJRh0+BuBk=;
        b=OyZr1F1uYWPNbCNlcuqp3O4Uv9ig3FBqb5J2ft3g70JyqQPlLSKh0OxYg2aHdGMVo5
         dj1adHyBvgNMfp4mYfNfUZ1BWO9StcHjFvFDr5j2wbJp8bJE/VeW/rmFNZEQg+8FMX8f
         cGrUJksQ+SVjO/Z7ZhrObHzNOjN1qdCLD88x89nDM7hJoijASQU3R0NxV+lxYyT/dmnJ
         Xjx8RRD/qWjrK3SmSMu9kP1uobL1APOqmN3u4f1oSDl3ZOLICMe9PVvxmCCoPEckJa31
         cF9jPQLTIdg3EChaG7nRVeZrzOAgUNyRu7l5grFOErueV47GGLtczRy3NhUbQNt557ME
         lUoQ==
X-Gm-Message-State: AOJu0Yz2RrygQRASXrtevKAZnr+wSbyGiFR5DIck9w3uNTqTePI78XSz
	Tpb3VmNHgKw26kujvMs9Omi1AYhFPWFJfbnpSK6nRLK8XMwxJ+oanI07TuMIoCwFIrKzrowUuVM
	0rd/0
X-Gm-Gg: ASbGncuC3ir0JrUdZKrYfdO7psqCy2Pjf87p4k8H8KMOrK4smXHOT4BLVuI6lV7wWpM
	SPtKZDAahxJopEkADufuEkwvjdcU/w2DIFeFpQGvswPpO6neXES4onoqH91JWjxIpEOwQ1d5cDE
	CaccQOFKt4za/PjZtBd3kjchUsnu+v5xXI3/IWZpn9Xq3tmwQv9yuJfUT1i7qtBTqMMCTFK2dkh
	UtNByDrMIFhU6EWM3gDYL8JWbQ1WUeDElzIjxSukEolvMLQ/V9LGKxRSBj8rKOPbu/e+mlJfbHm
	lEPC5IS87WAiz29WSCt6ZwZ2KNHS/mhh2339xGoltz4dGbX/JbQF4budIanu1Zjh+Co4WSaTvg6
	DjaaX9qPYv/R5M6CBRa3mEKyOansWUbLhNXiM4R5RanG6nlk=
X-Google-Smtp-Source: AGHT+IEB2plkqqlj8/pQzKhUN/RKf5fQe1/aelYENrRva9JJezB9Y4IB22RvtTC11NF9vwVMxX6x3g==
X-Received: by 2002:a05:600c:4fd0:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-467f0871186mr116478715e9.31.1758533573752;
        Mon, 22 Sep 2025 02:32:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm19735964f8f.37.2025.09.22.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:32:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH mt76 0/1] wifi: mt76: replace system_wq with system_percpu_wq
Date: Mon, 22 Sep 2025 11:32:42 +0200
Message-ID: <20250922093243.140946-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

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
1)  API refactoring (that this series is introducing)
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

1) [P 1] Replace use of system_wq with system_percpu_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        Because of that, system_wq has been renamed in system_percpu_wq.


Thanks!

Marco Crivellari (1):
  wifi: mt76: replace use of system_wq with system_percpu_wq

 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0


