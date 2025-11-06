Return-Path: <linux-kernel+bounces-888711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED89C3BBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF09560E69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8D344049;
	Thu,  6 Nov 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y97m7hzR"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792C32C938
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438811; cv=none; b=eaC6u/lCXVBFsWG2fMIPZ4joAl5dRjUyI1YgWtcNyS1BYeAAImF6It/ir9u9Yoj+LDje/yiYaAme2jkrNWX+2Hq1QE4C+xdsJKrSyvTpCq51h/MqqTLOG7WxecrdLr55wo61EsPvqI+iB3Z4za9q5kYDb2TQJOYvmy4lrnRZN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438811; c=relaxed/simple;
	bh=muH04Li/euKoT6gh0bf/efPxE3q0mcUSTRaH+F7f1B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KVAoTB5aZoOId0lKGWm/FfnN28lrV7HAs9cWwflRtztDsNiFIWz60/AU2uZ46/dSfyezU8Yf60AS/yy6F968JHYchij/4iZxt5BNPM1KlQrXadhaDovacePzbRG7/p/NepH7myc1Vshlxn6ZQL297oHPhqiUrVGEz8GWEZDqvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y97m7hzR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4298b865f84so532965f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762438807; x=1763043607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/o1I258l0tFe+MrAdu/nYdPH3cuHmEXwwhzxDKTBKtQ=;
        b=Y97m7hzRjrSZfvhq9lbbhjWT2RQ2TQbaiTucOlfBGL/EnpZT6E58uSKX8a5qbX1wvL
         p0P/6YuwMGPsL32CVaVje0jvJL+dOpeIJMU5SEJnWjJ/qaA3cNlM6ldthOwCfQtYWy3B
         GY4aQUpuInGY8RycLS7Whib5KW4zDhxZ+Y86SlKTTRD0Sd9rwPeNsbM87hOeQipiJ7tx
         xFm+9HVdMLiqdmqanQyrna7MrmTzjfk6Sm+ZxW3ZxRXnflVKZtH97JFqF7QDF9j6m11i
         DlktenWdKZOC8omDyG7RlhBusY13saJfkYJuhxNKDmTYFW/D22sqT4s9qxRDRv3jm/A5
         Ckqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438807; x=1763043607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/o1I258l0tFe+MrAdu/nYdPH3cuHmEXwwhzxDKTBKtQ=;
        b=NWfXou1wkUSwf43TKA9mkTVIsEp+gYWSYFYn5K9ReEgUXNwpSRb9EEFfbCks30Waj0
         nkiG2xl38V6M6jjmtb0ToyJ6Qofo3uxJ5uzlTXjrA2EUnEAjxOY1J1bz8Z7tVUDVKSkA
         +Y96MFFKxKvu5maRx+g8DIFkvaXevTE9HGz7vG3nH2iBKLAPHjAjZ8ju9GMHZ1gNob9d
         WQBVsakEReSb6ZazCKTL/V8OUytOw2vc6SuTMF6W3fBN2plN4sR/PwKrxtXTgtc5+Apj
         /NSNal5sazkKQHqA5zD/bvFhxjrmxp24czNEpi/bGtYwE9b+ASy844PT3RvN6fQdyLQl
         2VKw==
X-Gm-Message-State: AOJu0Yyw+An+muOEngijIkojqycUyrRVik6rre1pLuvocydwjML108Hq
	Njpabpg973FeumJmtFo/7tNlVQ8Az2UMU6sqTXllPXXrxW7ppuqyz/dHc07FA7ZYac0IqcEpXcW
	E1Fbz
X-Gm-Gg: ASbGncuViKQEmgcO9cTPE2xXHVpe0rpx63rYM+OZxTI2/JXwVUmYDIZksXEQFdQavXm
	Td4qcWkfwB7NmYklTMDcKBAgo8b4/S7tXYlc/4FXaIl+LMP09p9HGEwXFg2fNXVZxsBmXUKUn/Z
	Zvm4mT90dIJlguC5HBMwG/PJrcHPi8sCdvwhc0N7Q5ap/H0HjZVoFlgxjUGlFyLOdUy3cjOexE7
	ojUMfV5ZG4Y263LENS63MG94agSx2Q8jaqnOZiTYnnBJLvzyDFGljWY7yN04bGyPNePzn+MUpmn
	nbYn+cjDd8dKvZnBYC0d5j4F/J8iir+eO4kGWUoaHlbUPNmCMl1z9RjMvjE9uwN9CqB98Gr3U3o
	ryv1hvNL3xo4i9mYqjhgAu9hp+UnF0HESDfdpw+IC9qK+4GKSfuPVOD4eoFJrrVM/8YDi8yYoWZ
	3WAsphoznVwQEa3pnT6l15Wzs=
X-Google-Smtp-Source: AGHT+IFP+kui3xY3lYbo4x5nDXyU8juVkVr+ZGQqGRRDm5rC1wFExRBcgrsMCXHCGbMoTCCq3zkR+g==
X-Received: by 2002:a05:6000:2301:b0:429:d391:642e with SMTP id ffacd0b85a97d-429e3305da1mr6151061f8f.30.1762438806856;
        Thu, 06 Nov 2025 06:20:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49be96sm5255531f8f.35.2025.11.06.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:20:06 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/4] replace system_wq with system_dfl_wq, add WQ_UNBOUND to alloc_workqueue
Date: Thu,  6 Nov 2025 15:19:51 +0100
Message-ID: <20251106141955.218911-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
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

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2-3]  Replace uses of system_wq

    system_wq is a per-CPU workqueue, these workloads do not benefit
	from locality, so change the the workqueue with the unbound,
	system_dfl_wq.

2) [P 4] add WQ_UNBOUND to alloc_workqueue()

	alloc_workqueue() users must specify one among WQ_PERCPU or WQ_UNBOUND.
	This workload does not benefit from a per-cpu workqueue, so make the
	custom wq unbound with WQ_UNBOUND.

Thanks!

---
Changes in v2:
- all the patches use system_dfl_wq and the custom wq is now unbound,
  using explicitly WQ_UNBOUND.

Marco Crivellari (4):
  Input: gpio_keys - replace use of system_wq with system_dfl_wq
  Input: palmas-pwrbutton - replace use of system_wq with system_dfl_wq
  Input: mouse - replace use of system_wq with system_dfl_wq
  Input: psmouse-smbus - add WQ_UNBOUND to alloc_workqueue user

 drivers/input/keyboard/gpio_keys.c    | 2 +-
 drivers/input/misc/palmas-pwrbutton.c | 2 +-
 drivers/input/mouse/psmouse-smbus.c   | 2 +-
 drivers/input/mouse/synaptics_i2c.c   | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.51.1


