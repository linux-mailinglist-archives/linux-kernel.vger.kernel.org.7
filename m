Return-Path: <linux-kernel+bounces-802489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1939B452BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4957AE93F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0643090DF;
	Fri,  5 Sep 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="al89wBmY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E1283C9D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063489; cv=none; b=AivUBknderMgX1RIWJ8kdtV2HNL8HgC0ixTb11CCJ6Aa55vOePFhZnZm5yRSRDS+nKHJ0g5kpk0L6WWbaJJLJOH++njkAm2CYWVROttBnCVi/LZorJz09ja82/up95/Bn4n72YjCPzcjDMHlq68Iw015qsO3wA45Nm6Dq5Y1s4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063489; c=relaxed/simple;
	bh=KXvtlV3MPQ7lDeMtVzfz2TkBov9NUsuF77uL3L9iW0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdoBcWRjC0QBRb+aPAQ5t/DwK3haZQAkYckaIJZRIbc3e3UIaja2jLoFiU4AqqvPC0kCdr1YxBrCkECYDk5t/3BSLgjYqc4UTtmANrv9nw8BQZ7SMUFjYlhPf2nb6dQmb+TkuydEB2ipHAcASY9KSSZ0wES4Yk3fbz9y6SNpfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=al89wBmY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo332044f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063486; x=1757668286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXlL1ziPlCvczXSzheLKkWVPPiPCm8p1B534peGqPBQ=;
        b=al89wBmYYhTzfikUrw8kb8gsjYrgRtanmsMMWKt1LupulTnM3RC9iCJQ2g1DTe9+GL
         RBUC/iTqdfLKng3wUhCEsiQZ2l/MFsfoBBdVDMisT+2Z+EXVqkM/U3KrwAoSfBwllAz3
         7WQIIK091Iuf0/m/jenuKajt8gJBe/nCYtlmw5OcRm+nasS1y6pxWDq9t4aP4PZQwC4K
         YS7Fo/kK9vmbNB0rZgfIDIMbgsG6gF8DbOSMw6gofw6nhIfgcrRn1Vdy1kGEWkNwEVTW
         mdUhbw7y5Y0sbf6aRgSKe/Z+4IGgaSINIQYMwRYA1C+7weFQNL0mtSs3iLFvqvS40Mg6
         01cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063486; x=1757668286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXlL1ziPlCvczXSzheLKkWVPPiPCm8p1B534peGqPBQ=;
        b=ABrVqdWdb1h30jazxMUL8h++f8c1Q0y01CF6xQmklX9wOhFRI8KqoIwXLkExoBzdyl
         hCYBQCz6jqgj+JoiMs02FzjsN33wZfallo+LjWHZuUubyWvPOZ9N80kLONt1Z9zdSg+O
         6Uh1G0s/vmiOWsWIkHCNh0lFiVP5rTqM0oyzfwVrwqFf9GyhWzKECtrmEvJjT+sLfA6j
         yeHN4ddtkp89FTqZljAVCicWxfY08m4TEmx416BlRfEGpOpCytUTHGly7dVvVzT2xYiu
         6/mS3Mu3tyIY56r1A900bSwxF4iS1TuSv5HuwXvRLcvHmO2BV2LkGkjCr7bC1aHdVwM8
         w6pQ==
X-Gm-Message-State: AOJu0YzoZr124k7+6Jl7trpPXE6BrTJLiPUWEMUt3uJA+CJMY5IgUawb
	dbWcVuaKIlAAOhLCY2TT/Qhqd5RDiwnSu6H8ruuaARQhrvSbrrk6iNNgtCeVLtodAJMsYWZl8ql
	HIKNbZFA=
X-Gm-Gg: ASbGncvvVkcGVfKrNV4Brcv3P5Sk9VlIDcMIQdtIDsviHD+nlealykk9ubz5S4k1juD
	RYZF+ez42nY40wWpPs7kYRO49YQiUf8zVa0dGFi8SsNntVWkD6WDNx1YM+Blr/OBicmG10sFFsW
	L2gtU+7qr6Z2oo3JuaBTaZjkD3kM650Le8DuS3q5tHVklH3X1NkjOb/jgLJo3pp8qSzaCVeTLO7
	pnlz5eSP3Ws9+UOoL/G9bdLt2pT4POoE8q5mj71syyF3WoIuIoqOz/45zTcIfr2y0QaaqzzFeaQ
	F+To+YqFO6VhcL7ygCsLGg+OA3DBr7jk5WiTXcjKBvqH1vnWQMzVObJXc7sLAtOczFKV627t7IQ
	J0tit6pdGrf5U2Wn61YZgBiUZuVqcEkZl0OEbXyGio2/Eh0Q=
X-Google-Smtp-Source: AGHT+IGMJwjmH7+8eo3BXSBs6fIYhDAp9auFCUadtxQoSV++l6MdbV/ulQwfU1Tz3AADKAHThd+2JQ==
X-Received: by 2002:a5d:5d07:0:b0:3de:e787:5d5e with SMTP id ffacd0b85a97d-3dee78761a6mr7379285f8f.43.1757063485799;
        Fri, 05 Sep 2025 02:11:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98e77231sm146839215e9.12.2025.09.05.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:11:25 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/1] umh: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:11:15 +0200
Message-ID: <20250905091116.110314-1-marco.crivellari@suse.com>
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

1) [P 1] Replace use of system_unbound_wq

        system_unbound_wq is to be used when locality is not required.

        Because of that, system_unbound_wq has been renamed in system_dfl_wq.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (1):
  umh: replace use of system_unbound_wq with system_dfl_wq

 kernel/umh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


