Return-Path: <linux-kernel+bounces-890571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672F0C4060B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7884423A98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4795329E63;
	Fri,  7 Nov 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPdH/4Dw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713332A3FE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525734; cv=none; b=vGfm/Cr/3BV90i5lGvWXvfUesUyUO/rAWh8yuxvmuFRv03hoLyZ1Gt26DwNydqAUpVQvroPHE1V9p1ECIGhCdpY1Z1Y3tLKHDR9hvxnt4kzPXl23n/clBYbXuYISqCZRkDXQ2ZPSVAHVReYb490UOpHgpRt1yEs4z2J1M2lGi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525734; c=relaxed/simple;
	bh=3BhTKLrt8Wvihg8vp8choQ0z6FtpnObNcCgY0g7rt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qblMbHDavkVZ16f0PjOyOsbBEnqi5tqk0UqBFUC8ClkBe4JA1Zq3SCEdHC+wfoVpU95ifRBwb0d/pwFqFVfgv+pWADPp1QdTpzZSNV2w6sXgVx5r0/pyvmFjJw695AzdA6eQ9euGgeBFADyng8PBs9Cn7gglthxlMTA/WIjUPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPdH/4Dw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711b95226dso8155705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525730; x=1763130530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcbvvRs2xvl1u3FoZnWA9K4Q8QMEKWU1ON5YmKljc6k=;
        b=UPdH/4DwWdOBXzrhJR7At9cVPp7MoA5VMbzwNkD1qCgMeXlLmjtkIGcD0dCaw4rc5r
         U6daQOi2XupGPYhNYGcgtsKqenR2uzQugDAjcEeXBlh6IYDanL6R4M5sqLHOJyKgaCBh
         2zf0TrJ6+u1KUBqU+om3tEV6u+oyP9y2qypBvReywd6h5ad6lMSbOCMZoCz2tp6lM957
         5uejcsMQXepXY/F7BK4A25sAWCChtmILtmdgrp0X8ZT4rnJPtf2dbaHSfW/Jk0sIXHmD
         poAuIJb0nwbDhuMLP79i5lhV/z3e+K+JZFt/Wsyg7QMYK6UszNRnBjupqAqFSHiRo808
         2kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525730; x=1763130530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcbvvRs2xvl1u3FoZnWA9K4Q8QMEKWU1ON5YmKljc6k=;
        b=V/0ueAPF73IeuDE/8n8LY32x3uqDKitm+gel2ju74NjdTY0Ff3Y0ye+RZKMN2NcjBc
         3hbJQcy6YgIeUxk27LWvDEpcLnoiWrodcRKun9NwY47GfGYOngPH/KUHDQy2ecnIGDEw
         3YvTvDueZYYLmkU58UwNSujaSalQY6LxxxGes9M6XxZQSVukSv9ZUQz53hhl4Uq0XJin
         W5NvgTkjEXUGD3sOvc47yYs+KXYWzJqzvm3h0atYNd+8ZZ0YLSazsqCwTs2xOIMqtiEl
         iASLGE6vXmAxC8UoMiGbFOyGCI+iXbnjkt71bIauK6eIAA8712Km8tMEicuYsQyBtS9+
         uA7Q==
X-Gm-Message-State: AOJu0Yw9Qf4bda3Es9YXCf7TqMzNV54bSossk4wUcf/j4j8wMS0P5OgI
	fUrG5kJRAKtvMdF9lfaK5vPrjmbcM2y6gkxoIuACrL6o9DhYQE6M34nvczAQRl8FdP8ACwRN4tW
	WqrIG
X-Gm-Gg: ASbGncvd0mKcs0T0HkYoirYgidH8BqxU1w3BI6ZQwSmL2ZZB+2UfNSFqUK5vKTdxv0O
	LujhtxIbAsfrZZOXTTbHXJcsuA/L6csCGwIJDBrUh7eAvKAUACGk9iigOktZ6UQ+mcCyHk08AZo
	az1MVrevBHd7UCHqtSaF2Drww/oBIJ9NX8BZvalgIZwPj+AyQhGoyyB0DUl4m1F1y5YfInhzM7k
	IZ7D3djEf3JA6DSlObB1kKHFVsRvuxHTCzHsYkChvMJbDXRSKc0jMdK7zTlgE4AhfKDPVzI1+To
	y2Iy1BEhnU3XSBsKDFfZceGEi5HnxGnyFdOB+G5l4qOZctHFpKfMksORQqSsm93aoIhHtHbpxwK
	qIYmcdT4wpjGBnuVhqGWyb5QIOGRdi4nxM73MKpzH76Md4a0q5+tb0a1bRGSdBgBl1QLIQ9TxYD
	g7FT6/a29v4xLgqAQTpxDCl9og
X-Google-Smtp-Source: AGHT+IGSUrN/hCHTEKNrK/nAtni+bSccTeEoJLzD46C+Lw2FCkxvsZIT3Eo/AVNFZdrzTW3STsHRog==
X-Received: by 2002:a05:600c:4fd0:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-4776bc886femr28359035e9.4.1762525729708;
        Fri, 07 Nov 2025 06:28:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm181970865e9.6.2025.11.07.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:28:49 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: epf-mhi: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:28:35 +0100
Message-ID: <20251107142835.237636-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0c..27de533f0571 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -686,7 +686,7 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
 		goto err_release_tx;
 	}
 
-	epf_mhi->dma_wq = alloc_workqueue("pci_epf_mhi_dma_wq", 0, 0);
+	epf_mhi->dma_wq = alloc_workqueue("pci_epf_mhi_dma_wq", WQ_PERCPU, 0);
 	if (!epf_mhi->dma_wq) {
 		ret = -ENOMEM;
 		goto err_release_rx;
-- 
2.51.1


