Return-Path: <linux-kernel+bounces-886261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B1C351CC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BC53B1C13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0BA30274A;
	Wed,  5 Nov 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOKl7hoF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646821CC58
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338933; cv=none; b=OjxmWZ3LvBRUi5cj88tA8hkBAxLnklxWtAIxWT1rkKGMqt0bc4Y93FfSi/1SqlBAeRiICWy6Q5mJOYe0Ivc9n4SijlEKC/sYjAfGWEXvZdtCIly0yBj5X1AwmJx9mYeWggvoAdIp2BitYxsQnZ8AXeW1G7ddA14UERxFg/E/caE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338933; c=relaxed/simple;
	bh=8TJ59t4nYnSY+KaMpp/yEU3o2+WDuJv3kx9jVpY66+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fbZxdh5bQe0Pyty0KweNm8GzaR7lD5hwEM4yLCaafFBvMZedws6h0T8sMIZvXa9d9Jjo6ED3on9CUb2qBQ4VgI5JBtEIDns/vNGwxnA+3xerip5iCVjkMDxRd554nzXoFLMd5ZcVIPlhmjkNAhekqGVDGZkmP8dt1a5UEyvVGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOKl7hoF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429bf011e6cso4895301f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762338930; x=1762943730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHSGtSw91yMJApnQHrVtYIfehJHVSrc8/IiLFo9IqHw=;
        b=gOKl7hoFOGNOXJAFySZqL+1FVJ0v111d739L6yHDXMWREBYW0IeUP7KlXEPJkLqjAZ
         AQtp75Qgc8zxfszd6z6u69q5AbrgG6r69PKXr6f5ciC8VoekakKazHLFVujVV/GFzec9
         im0ikNaY5D6TcFCr6/ZeJO+CQKjtbPkXuqLHwhisndj06GbSKCADC97hZ+Vr1dtmxHJ2
         HcKVlcchk3eCyrr/SSq7SXlCiaxH05A25KBgBwEwLLBdni/urV/Y9YN7eH3JE666GCDg
         lT68Feh4N2SP1gUfBjNIrAD13PabcLklpvLes8zVaCT2x2weK+R/HdTUYsd26/Feon40
         rciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338930; x=1762943730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHSGtSw91yMJApnQHrVtYIfehJHVSrc8/IiLFo9IqHw=;
        b=jUWSAXJfmiYMNyOJGVoDV6eYccnRe9xgftrUTy5ziC9JzLQNNB43kiy9iVtAolVKI8
         lOPCAUq/Hd7Q76IoLZYOcUkbllKRpuvukjjXtvukcOpv65ccokvoqyOQJgQR3D5QaeEG
         ys8NxgMYHWKGkmlMueKQgNklxlAidR4b9AcN3hia23vdX8w8LT23E5RWwNR5JOv1vbKD
         aaWz00MR5pVDz5ncl5+0rj2qjYORle6kyv3s/u/OrUUIiVq11X2Y9p6YZNpWnMQSiwNY
         DN2azaexV6ZK1QpYFBIznEcdB62dTUOHkvAoC+K3iJpBxyv0bl4CWKZFJhyVFqMYVDy4
         6yXg==
X-Gm-Message-State: AOJu0YyRf3ksuyS0spGHHCt9zX/asA7SsiJnPsGAXeea+Rly9LqCOeF9
	66ThLASalA919pWg1Azf4UrMAsXuQ7tY2Idofl2VK5NlQ2yYF40uJ4SLmR0J7tfHNn7Bg5sWwtV
	9ZzI+
X-Gm-Gg: ASbGncuRDt3s870Hjai+C+1Nne2k2wgpc8/76azuO8f2SnuzJrm/S3gGb/U26itYPEG
	4BHtIgj+v2L1Vmy5PoNKoXT7AgMK2K7mDjKMHUtniO+59WNauD+lDwfLkOVAEQ0gyAc4+IDLXya
	bWz5IFGQAwy+Rbh64PjYUnbAJh/VAbMBLM2HB1wleQHF3ia6VVlq25NHtMXVw1Tq/6RlTMKbpVV
	YuFOOUPTZSB4T+BuMonOnIGsf9gKues5hYTxGoFkRrvue2uALO5nMrFKx4fLPs1f78A9uGvW04n
	zTPe2qrg5sKwLlzie821u2woLMuTZ+zOFAHiy15FRTO2gQqH6FfdIvWPDkZQeR+UGjIapaxyU6D
	XLylRH7L9Cw4Sb6WiaKQLtZQdVl9nmKwSixYyQ6mzEETm5zuBtGajwyuPSZv31iaiFdmDp+a9Vr
	GxSTTcg1w/cY58YSaE3BwRZhY0
X-Google-Smtp-Source: AGHT+IGclvBeinufkgKuOVR4DGrC/gUgVfnrS8QtAjCtu9uLfDqEJVDbobTawEzBlMD9Fwk+60biGA==
X-Received: by 2002:a05:6000:64b:b0:429:ce0c:e67e with SMTP id ffacd0b85a97d-429e32e516amr2250691f8f.19.1762338929960;
        Wed, 05 Nov 2025 02:35:29 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9924053f8f.34.2025.11.05.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:35:29 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] replace system_wq with system_percpu_wq, added WQ_PERCPU to alloc_workqueue
Date: Wed,  5 Nov 2025 11:35:19 +0100
Message-ID: <20251105103523.103622-1-marco.crivellari@suse.com>
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

1) [P 1-2-3]  Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.

    Because of that, system_wq has been replaced with system_percpu_wq.

2) [P 4] add WQ_PERCPU to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (4):
  Input: gpio_keys - replace use of system_wq with system_percpu_wq
  Input: palmas-pwrbutton - replace use of system_wq with
    system_percpu_wq
  Input: mouse - replace use of system_wq with system_percpu_wq
  Input: psmouse-smbus - add WQ_PERCPU to alloc_workqueue users

 drivers/input/keyboard/gpio_keys.c    | 2 +-
 drivers/input/misc/palmas-pwrbutton.c | 2 +-
 drivers/input/mouse/psmouse-smbus.c   | 2 +-
 drivers/input/mouse/synaptics_i2c.c   | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.51.1


