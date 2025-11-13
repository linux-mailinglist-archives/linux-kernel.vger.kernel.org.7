Return-Path: <linux-kernel+bounces-899748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF48DC58C59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 958503637E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA42FC00D;
	Thu, 13 Nov 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KH/rsQ/9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0C2F4A19
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049976; cv=none; b=CyzBghJ+cAo2//0cCon6ZgQjxB9zdvOmXdc6P72JxsSRtqHKPB/weW7ya0l0riBk2N/JYJFKxRGGZbigstS4UeblJAk6gNg0Ok6rBksQbyGnVQy2RiXFK9ZvKzxbcMD9w7qFsAfeoPRQRYiIzvJ0WFAL8rn3mACjiI3SBLRezcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049976; c=relaxed/simple;
	bh=ySzTp6pi22gxFAQkEOEnHW1mjXFsKHrGwJAZ6aBVIM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0G2nRVe4LLS9G3VxO98p71CAbDnp4IhvrsD5YdglixdlrNPEZE0wjkkRn8Es8bUxurNG7Rdls2rWLiVOvmFBHgfAHBy2BhlkylRvUff5W6pxwANbq4MdEZ/Ug4t0xuRHfDu88xnPdgOzPWiyv1zUIcyBnSUqAjBiqjEY/6wJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KH/rsQ/9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632b0621so6455055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049973; x=1763654773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJTSNeHpbNYeJSkiw1k7wh3DxAjvslu6ruETjokGvEU=;
        b=KH/rsQ/9JwFovDZMem5xihtLa6qgDVkDrdVLzgO7zNBr8yBqS5a5B0/lX1dD3RBgxH
         QrC/24k4lSjbe5I/XhYSRy+QGKy93rFuw3W/pw6F3SAvF398KNTfRFTfElLD2AnEN4q0
         9Y/irrYITs5NcqJ1EmGyNQqjaE+VcTuklxuH+6Yzu80Rn2lFn1FdIqnlda/wbgVm365/
         hFy99iuRuh7ypikKYCyat03IExZQaiYQMKxu5blmZYplbp/rHE4Yr8mI0kepDDB0p+vO
         pvAmi16LGyAlcZpsxqPd3rnl1j6tC+eaMpNJrDoJHy9CFASnLrhAcNzrCjIqbmOJGi2b
         AKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049973; x=1763654773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJTSNeHpbNYeJSkiw1k7wh3DxAjvslu6ruETjokGvEU=;
        b=l4oH420r7wLCDGz+8KgfT1hGEzSA121PZMyXhmb0AOO1TNVykWKUNj39ELbTlM9DsM
         nzqEDZrclQfuSdmkKHOOv90WLElDSyfMGjPMq4Zpx1dssEGrGgzxGF7gerQgKe6QXhHe
         8hcGS1YDw1hsrpzCu74zAVQX8iEw+gQ0dYhBTlXbC5CmaS4bWvXC64GumLnB2P9CAmne
         lgexQIKC+WGfCFMPujjKWgZW2vjTqTgMUP6+lpLjwV+7OHMpC6+bIskTog57mMsfM1qU
         g62Sb6iqSzXX8GIOqADDRez2uPcyuJ3MnCsuLYdoG7D0EDIhLtBZMdpb4YlCre1miqKC
         yKCg==
X-Gm-Message-State: AOJu0YyvK/kfb/CRd2et3jonQf9HEilJcGD2fSRsAAzssOiBUaAA8DOS
	7F3NNf8X+9qOAgQdBvngSElwSu5uDsO9ar+SR5ItlQU88ljVrw6UjxsWKSuOpKbywoLen6dVkHh
	9bUeG
X-Gm-Gg: ASbGncsJ9KGo5ewX2emAfmAUGEmBkkhAom8oFFuyz1S5jswEc5vBqrxlq+5xqCibQrS
	7F/nmNKhnwXojD+QSdtwEV1DpWH2ye2FVNdeeegFxT8+B1930AbqQqTz4VAnj1wCZep1rQZVQWa
	GvcHKrk4NkYP3FN27dZk6XIMNJBXk6k0p4i/Tnh4b8jS8MNbPdL0TxycKIaARISYbkdWAqHmw3f
	noeaaP9SfolpVKnHbFu5OdkJQR8WSmH6Lk2pC1dCYYxkYp9Uh5VS2dgU5m1Swr3MDC/lUvEET1a
	+OHBc8gBiNd4yc5zLzAG20OoSxrqeG+8zEG5Z3aYa3yXfX3x9Zmq3ixLWCyPJDnrrnAYlRyXDKF
	3JYWKn4jSKeR0LrHnfhg2rUY1xUAyzqLS47CxbDySwtZob+VUq4JJwZJPzv6TOH7GSmVD05b758
	Fjv2If/dWNBbdjSEtjUwhakGSM
X-Google-Smtp-Source: AGHT+IES6o5QI9qq7rl/O9nVOMD8tvOri3CtZBmED04pSrq5w2lpqdmqW7EGjKAH0of+B/G3lToLuA==
X-Received: by 2002:a05:600c:8b38:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477870b39e9mr70883325e9.31.1763049972718;
        Thu, 13 Nov 2025 08:06:12 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm41595415e9.2.2025.11.13.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:06:11 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue
Date: Thu, 13 Nov 2025 17:06:03 +0100
Message-ID: <20251113160605.381777-1-marco.crivellari@suse.com>
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

1) [P 1-2] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
  wifi: rtw88: add WQ_PERCPU to alloc_workqueue users

 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.51.1


