Return-Path: <linux-kernel+bounces-888898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD52C3C370
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4C054F79C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B194343D8C;
	Thu,  6 Nov 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MJw6Mrk1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508832C92B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444724; cv=none; b=rrfNY52lX6Oh/1qczVcVIgIGbaUgnUCQLoF6qkSoJtz14DPMe7HTpbn3tM9nwc38BckV3FbevAk5wO3N5Blj56m3PRHh954Px8vLsnbw8Z9yMtfMz/lnqMtLz0m9Gp4BN1eVAZQeuCeKWeqGOe+WeTx5KYOHZ+YzOBJ+DpIpugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444724; c=relaxed/simple;
	bh=3qVFFqjSsbMQoARA3fyDO51AjscQzhcj8lHRbSMe4Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VcmcxDlLEPAaxzwt9haZUgU91bHTdnB8I68GErLFOOTlvBqaLPuXmvrtaP2FFAbe4Y+lV/Jj0osuLfrvwWVm9dGpJ9zgZXh508QUGP4Yv9oDRHqpMtVFHAmuZjBc+dx2f6TruErhzEGf3XDEHi/I49rSvQoTjSvCTSTjRpRXxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MJw6Mrk1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so1222200f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762444720; x=1763049520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FL6nYeU7/sYbYGrjWjcW/vfma09XwfZvs7Q6SdJJn4=;
        b=MJw6Mrk10YLmuRSYF2JJUovejEaZIDSqJXtpgilj0Ty9zV4GssoS0YWjCgwaipZFAA
         SKnPeMqi5jXK/JBjzbawivdRq1ChWeW1Pahgv23CucL20I3tk8efxzbSWkDl7w2DGVdr
         x1HrDoErOFsdBch2gcId5ecW6khVND8kfPa+dl0AOXurwRtQl8dR3m5mXKJxX6lt8cKN
         g9alqupbuv3QvdrYkf2KquUfra5g7vpdZhhxl7hZiVHlTEW/Jfob42s9GPIxPPWpQY/R
         Vbc28NHn/0z+3lf2PXG3WZVQRff0iUwKP25W6+dIIqX/j1ThaseD81H0moF6AiWTr0q6
         XX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444720; x=1763049520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FL6nYeU7/sYbYGrjWjcW/vfma09XwfZvs7Q6SdJJn4=;
        b=N7ZDyflAz/AD+8hQ9apzd82rysgBidlku2Kll9u2Fw3wricP39FeGllXc5jLN6JBID
         Rur+RHUwHPdkyWAonWtsbhMBo3AAN7o7jkktctZXjNjI1t+ohaSkDHnGzBJ/wrZBlmbv
         e472rzEp4amk0oAQddXjHJXx3dTRWSwrTrpoVHpUX0oIuwfnrX25+XN0Cy9T+5qBJDAA
         evvdBxlQnbJx0hlrZ5f77gXcR5PsxDt12d3znT6jyuCFim+Q0eKDOfDyDhWztnVK0stf
         UTcvf6idNBygdXR1WWYk3/ibUIDSgSo2a3xrq0Kp+bg0YgecZ48pIxAZYve57kCZgpbZ
         HHbw==
X-Gm-Message-State: AOJu0YwYywlGX/f4qTuPV12c8HDajan0kbOlBJKmPWlpcF3MwZkfK/Ok
	3U0oOOplx9A6k7h4pV+ZNsbvDYBtwXrTEk/ve2+7mXjdgFU2HO+BO0sVWcNhv5P/AdVLEqLpqae
	LxK35
X-Gm-Gg: ASbGnctKnlGfOGiURzAEfgcpipFYGFGph87Pg48b2AvV51/NsAmxnRBMQhREEtQZo5S
	rV/Hpl1LvEK6BC5SUx8iKSqxIO78Yz2JEq9UzKIR79IjJiEusnZar8sIPbm3+8K8hNpS4XduSTg
	0tBaYIJIfZYh3hirKwC79gBnRrjGOP/2GntBRXfT3xzV/aguEYr0lueXHUVcedbm82rAkZTN0FS
	CLLCQb2BzEd5jzKWKHbVrjeyDtJTbPjxspryzXDNwORq9SmjFIxhiBjZuP8nxlsMElgOHmYZ2xJ
	WNgvgY63z+uHDkW9tN4d2K9nVNOA+JXsrNP6x+kl5I73zAse75nfOoBXJv5iBqyhVB9fbZGg3LV
	gsUKJP5yJZkMVfjoHHRmUYKQgWp9KhO7A8fApMQ5JIGpBSoy0HLw9wgnP4Sxo7+qDgAUwmgZ49q
	KAxorTMokcQ2Gj7MdeQ5JOea4=
X-Google-Smtp-Source: AGHT+IH8Fw/SiYYMB3pMDxqZxhmpJLxioCFXohxA9aJIH8CCNIcwKocF7Uc9vAgCmTSIo71Hr8Z5Aw==
X-Received: by 2002:a05:6000:2910:b0:411:3c14:3ad9 with SMTP id ffacd0b85a97d-42a9579c728mr61206f8f.21.1762444720333;
        Thu, 06 Nov 2025 07:58:40 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403793sm5758966f8f.2.2025.11.06.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:58:39 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 0/2] replace system_wq with system_percpu_wq, add WQ_PERCPU to alloc_workqueue
Date: Thu,  6 Nov 2025 16:58:29 +0100
Message-ID: <20251106155831.306248-1-marco.crivellari@suse.com>
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

1) [P 1] Replace uses of system_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    Because of that, system_wq has been replaced with system_percpu_wq.

2) [P 2] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  xen/events: replace use of system_wq with system_percpu_wq
  xen: privcmd: WQ_PERCPU added to alloc_workqueue users

 drivers/xen/events/events_base.c | 6 +++---
 drivers/xen/privcmd.c            | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.51.1


