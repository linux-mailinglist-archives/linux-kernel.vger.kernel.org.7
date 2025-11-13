Return-Path: <linux-kernel+bounces-899750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4CEC58D82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B399363E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544C340D9D;
	Thu, 13 Nov 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yinl5a6g"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40D2FAC14
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049979; cv=none; b=cFEWAo3CyGTBaCO/iOUMDFOG5Xib+krBQywIM02ueqJAqzIOEzQ7xIP2HrfFQPo3Ei0xAAoVubJ7WrEudvUl8hQ+StAN2m6HUp/j+lLFjvf8s0SH4JeLqn6ixMatxl5T4dh+Rs+CdjkB+NZKg9wLW2oHAQX2l09iWZOWqJ8mnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049979; c=relaxed/simple;
	bh=b3j/Wc2OtToDhvUSwLsZ2/Rbg5MWETd3kh7hoUyLCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jqhs2OePTbk/Zsn3vx8wlbB7s5pTUkhAbn3TqCH+30hCMdcD2yGJlXf6U03ow5DYfu0j5NcWZHx5iDuGe9LBLjNTVKzeANU8RMYvw98fFTHYi2DrHQXzCpEil/mOnjf8sqdTerznbS8SgsHAuk/FYnACbCUgvNYO5hFMB1kRD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yinl5a6g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso6343515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049975; x=1763654775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpDVepX3vNSmI1FdDJpGJYu0mEkDdjVxk0Pg0gfi31Y=;
        b=Yinl5a6gSY2eO6MLnKyBW7Hun4Dx5rxl/RufZ2cR9Msl6eDU16Y99NiZwEYodT4zsw
         9DHA/graBfUXPSeDbgA1zV5J5YgDJO+Blh21WjHSX8Ads7KfuqyL/DNTnl6dkg+vojM7
         xxaYAPnodNVKjDCDevpfNvhV3CZqIXVhUVBGDPu+3lP8HuwSPbCX6yWomkFKMN1pvKaq
         h05KEzGBqjRw1sNRLPQi3PLn2KZFfedd8zH2kIIxfMx6e6lElEv0BOV9KbSr2oNj+chY
         IMcMrl5vJbTaZ9wUffls5n1DBJy0yUBThqZ34ng8DbvWtJPj0wg09rxb57DMFxGrfvyz
         u1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049975; x=1763654775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpDVepX3vNSmI1FdDJpGJYu0mEkDdjVxk0Pg0gfi31Y=;
        b=PtaXOMVqKOfl3HsYZv+3qn5KfWF5d0ixPmu54Bh0MlF1B2Am5tKYJVNM0FzHYEqAuM
         7SFrdfsvZ5iWwyy8X5DWdTjQ3LWR8qJXFuy2r6f60dgmVCaF2zd5zLJiFtUdiXWH4LCs
         Yc+A7Jy01dwnDueaZkpKOJyM71COdqvj4QhtEpdzsOH6Lsg6Omm4QG4vH7jbl/FOdwD0
         epqbiWHEFREjzO6Aopy5eeqn2C6AvPoudXcTZzq3sPtqMPqzqR+2EkWC2t/4BC39Kvue
         u4CmLJPYS477zVAPeQbwHLhTEOjAR/jepar3VRUlqkvnEkoW1t9/gR4zALeteQ/js2nh
         LAUQ==
X-Gm-Message-State: AOJu0Yx1JHl1pL2bkiYRP4tcsjdOdXA7LHs2rPN6dchm1+oonqFLc8Ad
	FY+pr919vGaUzTbvs1EKlFEs/EU0riHSdI+TuyNypQlcyVfoNqzjyM40Sa5TMLwhQEBXunOOSFK
	5s6pi
X-Gm-Gg: ASbGncsuRsi+SfqMbcQOsmCKMF09ipLnd9EE79YpLTWvkqgM2Ua+LSkEWSkc5y5DlTd
	Nh4UMgVQWnyJtqKdChAQuYH1vHJ0s48hqwtFdy8dR37LOSUpXoJD+Bl1ix5utf0tDTduljcq7Kf
	1w0/OcTasolGiYOomtvkYR/L3js6is3EY9FEPcAd4phNB3wYThS899vJ5oU06935DyFD+eSkK46
	rC9r5bZOBgny2ZxjtlY3mR4af7JFM7dG0GTMCokTxpQrjGgjeoGxbpc51OpgtaigX+e+bRztnOb
	xgzrTFIKW9J0sNTYCb8ffKElk43GRHDdn4paSEs5MjXbY+h8tbVKTdcPfS1GI6ECe0QYbPSn7Aa
	MEcm4ZbM+EwfEi9Iaou491Dy64AD8epqNhte+zDi9sMpt0D3SKBomhrz7LkJPVN8k2rMM5p3zaC
	MJb7XuMOxUpQSRGRGUQLkK7fT+
X-Google-Smtp-Source: AGHT+IHTIqN3sACYJ8L+s+DSf5fK5S59AG1bon4iPbb6kvAdV+dUJTAIosw5brBjEKYuiUfzpCW4SA==
X-Received: by 2002:a05:600c:3b1a:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-477870c4f26mr71238165e9.21.1763049975028;
        Thu, 13 Nov 2025 08:06:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm41595415e9.2.2025.11.13.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:06:14 -0800 (PST)
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
Subject: [PATCH 2/2] wifi: rtw88: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:06:05 +0100
Message-ID: <20251113160605.381777-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113160605.381777-1-marco.crivellari@suse.com>
References: <20251113160605.381777-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3b5126ffc81a..db60e142268d 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -965,7 +965,8 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH | WQ_PERCPU,
+				       0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
-- 
2.51.1


