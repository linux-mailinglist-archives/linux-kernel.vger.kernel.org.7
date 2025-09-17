Return-Path: <linux-kernel+bounces-821193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E06B80B31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6212F7B8521
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1A33BB30;
	Wed, 17 Sep 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyAkhkYv"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAF33EE1E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123549; cv=none; b=JO690X0CRVMJqaO1Ax2EMi4mtRjn7dhCnPDAIcPbZu3uo3TkK3f69mKuZjWFojKv+MriVPWiPBlg53gnFHYXUOljKkFeHLVJQemgJHPQYzFSgW8bCwNVwpG8cdAONXZ4nYq4gVOOJQuDeVIjC3yrIreXabB5nmM2irvvSdk9L7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123549; c=relaxed/simple;
	bh=a5bjwpxTd5MlEjoX9iDb8/uKmhaNxN8A6oQz06XSmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGBMcTIrxRnnEmhM/ZDUMrc0YwqOS/UUzsBZ9GmMUcpFfNZ4TGTB5BWB3dsHGG5mPKfjbV6pAQPGVcK/dc+6lSFdeqNldRDEfPqj9BKlHru5h/wziHXbKhCA0bcLEFLoNOYyi/wTGkNa8AD3THKP2PCl+l3Lu11EFs9t8pUvWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyAkhkYv; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3ece1102998so575968f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123545; x=1758728345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OKQ5EvS5a+gZrJZA4QsnhZJV/o36dNUgSjCog+ZmUE=;
        b=XyAkhkYvKt++cfqrIJpNAvvui705g6zQqxUJTWBzxGpSnn/y+dlIf6GwVRXL6XPXmQ
         vdUeYeF6Uwr5WknfzIfD1DGjUDkbd4Anr9FFL2kMKG1tkBWSmaRzUUSxX83ZwrG0N2G1
         oRGlLcTh16zt7iEm2f0IsAuyPYDcYV3NDB+4mm1yX6KpM+EM24n1C+abOmmNILettiyy
         hTC/89aYdfRbBMWjlwR/jKaIE6LnF4oOJ+dgRqfzgSW59LycSl5ncjfAw0E/lDTjbBma
         mbJtl+GHzz2yV6PYVSrGdYHIkrBIB/TzjswQqbkTwVKyLvVSiMK6opweK+md71IlzdZE
         F8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123545; x=1758728345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OKQ5EvS5a+gZrJZA4QsnhZJV/o36dNUgSjCog+ZmUE=;
        b=nQ96gZnf/nCG047b7r3SBgMt7jNe6i2XtSAJTamzZKidGiB8nmxzSmIYCXpC5P9vZN
         pZ+1nuIxfOvgoeWIw7bsMicF89MsBDqa+D3GI55DzR+1+vnj1tWXijA7Frp3BQuKOEz8
         /MSMmRiY6XwaxcIwzblGImynGBpVtkl10ie+PSB4pYzm0HguTwrvDzITBkM84u8z01Ju
         idkRX83+HgQxl7lRxg2JmJK+7Ej9ikWAY821FNGaeiK82BIXNH8SlPgHiz5j430/xfmT
         wmXk31+btikJDZ0TKDEXQgPPSRqfeHhfS6cxyvHBS1Cxx4CqqNxX4/Qf6plHEJcnjuF+
         KPvQ==
X-Gm-Message-State: AOJu0YznVdDRdtjviFpCdnM861P9+kKXhw/yOFdcz3jjuEB3l5jObCT0
	Yvaik6hZGKDX+5gXxCvf1E/7mTRynPTP+06TcrRQDnMtjj8tHfBooDYe+O7LGy4EGP4UmxfW5o1
	EDVL73bYQMA==
X-Gm-Gg: ASbGncty0yNVrlLmsMx0wZ+THO8S2UQkk2vLv9Y2aVic2yAFPnAnBB2lJFpKLPVOmTb
	4sLJoD+6c7PIUI1X1I0MIPLSng4qnT3lAkUdT/YOtuWEwnLckmhyZSLJRFapPlhrYhHYoohp77W
	o5xpx8TntctMoJl96yHCjXa5zFjd+UrNjRb8PIdYUO4AAsLQjtCd2evVyiUOkx3Qx/6ANgb6fob
	slAZ0wkesanpvME/9PpPxwIHK8xZeX/KRQ2geu+iQPk1FX/mhDRmU+b2gtYaR87rSIuKDe4361a
	xKWJ++2Y4hzZU3aLCADhrHkOr3+tbQGGFdIocIYl7RaqfSVyKZckr9E3cV5fBsnmfnn3nHAy5pv
	+trLVZGieWd/ImfPKUrnaXn8Qf/AuNZ64U9EJZqmXssAqEfw=
X-Google-Smtp-Source: AGHT+IHd7Kvdz/BCcMgbB466Jm/wCp1kzuvdKItEQjhl+8bjCb3QTRXBD5wNHBIkLdVzt5FZxRnMjg==
X-Received: by 2002:a05:6000:2511:b0:3e7:64c8:2dd6 with SMTP id ffacd0b85a97d-3ecdfa0b8dcmr1981118f8f.29.1758123545284;
        Wed, 17 Sep 2025 08:39:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:04 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 0/3] s390: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Wed, 17 Sep 2025 17:38:56 +0200
Message-ID: <20250917153859.363593-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

1) [P 1] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. WQ_PERCPU has been added to every user that is not
		actually using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.

2) [P 2] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

3) [P 3] Replace use of system_wq with system_dfl_wq
			(arch/s390/kernel/hiperdispatch.c)

		 system_wq is a per-cpu wq but hiperdispatch users does not benefit
		 from it. This has been changed with system_dfl_wq (the new unbound wq).

Thanks!

---
Changes in v2:
- New in the series, 2/3: arch/s390/kernel/hiperdispatch.c does not benefit from
  system_wq: this has been converted directly to system_unbound_wq.
- the others system_wq users are converted to system_percpu_wq in patch 3/3


Marco Crivellari (3):
  drivers/s390: WQ_PERCPU added to alloc_workqueue users
  s390/diag324: replace use of system_wq with system_percpu_wq
  s390: replace use of system_wq with system_dfl_wq

 arch/s390/kernel/diag/diag324.c  | 4 ++--
 arch/s390/kernel/hiperdispatch.c | 2 +-
 drivers/s390/char/tape_3590.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


