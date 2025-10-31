Return-Path: <linux-kernel+bounces-879993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B9C2499F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237734EA367
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4B340DB9;
	Fri, 31 Oct 2025 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QS9hOT/N"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5733E378
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907734; cv=none; b=LyakZBWsH/mwSQXyaDXAmHwCUhgqeY48pWleoMxXHcDmM67FI/bDgBxaXCNdcSVqPju3VcoJ3p5EwqsNhoemfYs6+yCECcXZxrgB2udB2L6nrZwfyzK8jhw44lCuKqsDhJE0CMkt3fn/wOfb35zbDQL2pmPR/O+SLphiHfmbh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907734; c=relaxed/simple;
	bh=qMZoVwpzippf9yrutcAv0F4qFlrXw6daNip8EX34GRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auAH/1VMlRieogd/oPocOGtsMA9Lex8K8BPOqippqEYS6KZPKNO+oZAvk+jFuySKnDQXJiY0pCZ05SohaVFWC//BeoUIRi25RkHmTlQrrf5G/K0RcLjYfGpuf5NwUo56wZsP3hIuYOYw1rZ5cC+D9iM1WoXZg3WE1e9bH9koKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QS9hOT/N; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso14820115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761907730; x=1762512530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgLCYfpgrKXyb0uNcHRkHZoucWvjEkXvo5QPwaDt/k0=;
        b=QS9hOT/NhVsrK77/fuueTOUUZhmNjhPpbp24FlIPtaxTtn5DglQ0IP+EdVVsyETpF0
         UsBU5pHud/TBkbzS6XTlID29V9/WCMiPWzJYOBajWK79uueREBKpq/iUQ+dOVIMmMpnm
         rO0z4xjHq6hcZlpqq5vY40e8wmsduCxfnMQrXqxjG7SDSlzkhTgasAab7Xh0jT6nT7a8
         YhML2nSZZO6sUen7HXUGu2V9dxofMUPpAudybqFgcOHnUzhjorrB9ukCdRI7AJeJo8aZ
         TeF7KEqKinmXbNLx9+qG8K6xitxlO9WQOF3aPY+1cIaiMAbn0rZ9MBhrw+5EFQZh5uZR
         6NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907730; x=1762512530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgLCYfpgrKXyb0uNcHRkHZoucWvjEkXvo5QPwaDt/k0=;
        b=Lo5D6F4HeICO32bbOEC7XmFTHglbbBRQAUvBqJQuPJ8hRwTcAP3uw0TozayDIe0/7K
         gq0OJ029I0s8RHA8nJ/HOAZ5coO+1J42mjo7ZTip7ZfyvDWfxhhudg3QmEfRP8jX8VMZ
         4WWo++OCfkm9iNZmC/0+z0n9OsnleT40iiLbCpCMLeJ4I+rCTcserSwm12k26Q+Xnouh
         7+YpRrkHZKIz2f/nSWTTxVOjVBjAUkRlMb6lSj2vW3MVYbb4xZ7ZZXxvpUxlGwEvr7Wr
         q5P8awgUTZrYe/hvgEqqf7Gu/UejQ+9RWRdffDEkRpRbDv7khR9XD1sUpiYfMvfMS6oo
         j5tg==
X-Gm-Message-State: AOJu0YxjSDr/g/Dkqay2fb++wDnl8vzrvaZRcHLn4elYYt7VS++m+VdF
	6Q82/N39l9Jblst444eKjEVZ5jfyd7tGZeB0spAg8RugFyI4/Be24qqze3SWWU/VIcG28LbsceD
	HwPQy
X-Gm-Gg: ASbGnctip0CojhjdD9tGNugzczGBdYSJGKm2sBTCPKs3ncAGLXDIOGjbcuqyVO0coce
	74fGcHy7QufBZG367BvqoDLPBS4jstxFHK0Zkw8SueNWWnQyzCUfckUgbT50Mmuwupt7OLh2ikg
	Tu3Lr4uDCrjz8Gn9vVG7t94EV3B/yRzEiLKZWcoNowTz9UmVQ1qeoPvAmT3O8CUyjixuc3fxeBz
	LkA9HBbj9hMzJeyJhO3aNVggI7vC6EAeY1kxjEHNT/wjo4tgd5QemNtmUVN1tBRq27kQxBORL3Z
	IxkK8uiv7LcJmOJd9o8rnNAoLjMJ3gYOSNp5TN++7AL8WIG1SUCijlXz/nvGDYTR1BGLVnXfDuJ
	KS3uv9TpsAFTM3KJz/ve6hOhbZ+K0JBLFFYy51es3vsVnaCvQrrN91Kr0e+c7LN4b737gLzXFpm
	+TRvKX4BCpkp9gDhs8kYo60WPxJr/1bZ+wS9Y=
X-Google-Smtp-Source: AGHT+IFP987BsDATwy71oQrVgMqL+tPUdk6zXS4vwh+ZuiP9GnPeneDUsTtppOuOWWpaBC8dvT1MnQ==
X-Received: by 2002:a05:600c:3e06:b0:475:dc58:39e5 with SMTP id 5b1f17b1804b1-4773089b541mr26933225e9.27.1761907729944;
        Fri, 31 Oct 2025 03:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm2961635f8f.0.2025.10.31.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:48:49 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] rename system_wq and system_unbound_wq
Date: Fri, 31 Oct 2025 11:48:44 +0100
Message-ID: <20251031104846.119503-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

1) [P 1-2]  Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    system_unbound_wq is to be used when locality is not required.

    Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.

	The new wq(s) keep the same old behavior.


Thanks!


Marco Crivellari (2):
  drm/rockchip: replace use of system_unbound_wq with system_dfl_wq
  drm/rockchip: replace use of system_wq with system_percpu_wq

 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.0


