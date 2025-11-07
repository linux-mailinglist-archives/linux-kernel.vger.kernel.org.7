Return-Path: <linux-kernel+bounces-890684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC0C40AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA391A456FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D276E32AAD6;
	Fri,  7 Nov 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WnLN/78y"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8E329E7A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530569; cv=none; b=Qb2kQPom5TLWts7wAl30ednTUrrY2oVrQQvxjAxnD52WCcQRfHAIM8Elq0EnlweXLcdYRNLFIoyrroXCbT5mQVfYwikmZypdU5/I4/9cfqow5JyjQN91aUWVPfYNucRPI+oQUWEjtxK1bSWWs54uM75koQsglVbXKShubduDyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530569; c=relaxed/simple;
	bh=27VE+i4w0x2v9vXfjkwHZYZx7SWxOyXyFMIchgV6VXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cuc+Qbk30yfIR7hJrNQVV+S5cxkwtUsiFC53qwWxaLUBSgsLk8EQMNxGdsHaCEhJMKRDs368/CrbJwFRG/+BXLHq0ctId4UhJaYz8dcs12AwxTrh0vH1BOr0mgQpamjKo1kmIKCPhmv+PUXDyyn/cbL85UMJ7AKazBSWfGoK4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WnLN/78y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775638d819so5262485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530565; x=1763135365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CieNdBP+iDUkzWsYIh1zY2fr6PrC6rMrfQxyOHiJYwM=;
        b=WnLN/78yOG2LCA6lR4rsnKSWLX7cUHNK/qLZkFwxHKQ0RsK7yv98gXfGZeI+ymz19i
         89QwiV3QyFFjnNkgCfrv/S5tyJLfuCCqkq4S/Gx4w6dmKtDaZTjOEk/iLqQYZEfYIV51
         qUqNpaR4HFVL2wz2g4PiEE1D4FMojwQtQvrwybS3mXGhXBMxmbx3N3Vn2pwNaBD7wTFx
         yhhcCBiZxeaf2Y8Vf3+zKflTkDqvCmm2E54XlYIgR7xS+eX+GsOJk7tLssDPLQd6bToF
         s7OorbwNhyhvQiK+85nlRQVCNdRp652uaI+bZhw2ME98gnTLR9HPtlZrOZcakcLShJGT
         M31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530565; x=1763135365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CieNdBP+iDUkzWsYIh1zY2fr6PrC6rMrfQxyOHiJYwM=;
        b=nS3VFSd3KOEjUQJS24hc4PvEMSVx4r33CX5nHj60om25SNoY7aHoJjzoIzW+PunL2i
         IbhNx6D8utxYhKjh5P9JYXEpzyBuO/1VrfMfInik/JzIHQaCNYTlvAhz4p0+KT335uHE
         VvPZA6eBfe49xH2rEhJuQPvUYQNV3L78lPeZ3NtJDucb12Y8an8kyX1UgeXzH/ERxTy7
         a4hHEA/Iu869JNJ7eHonSju6u69yzswZTkg1tXvm+QZVDcSgsAXYbQWmKMIqwcKHi8VH
         2XuDNRJJD0iMxNWguo0TEtxlVmOldD5S3J2APP5UmfwNrFDw6L3IUbynloZvzVkKq2Db
         ivHg==
X-Gm-Message-State: AOJu0YyNERYDeEy8mUuOPs8KTb5xUdpxv38V1xYIWYN5MmfIedhym+Vf
	Cv9XBUBlgx1eS3ntl7aJ6cGayESG1/M3tNFTBQ15OvDOFopJDqDOLiccsecCGja1iGdwWUAVbmi
	bc3aB
X-Gm-Gg: ASbGnct6NS21yrSoVt5agupyBS25q5r7i+vNYdTsllzIHzpZhYE0mEpO35wZr6NzdJf
	8MLd16ibscubXcn7nXasz2VQdNKZ/c6YS82WiTO2IETB7wSP/PFHmw5Amqs3QZrdZSrF6qxe8ZK
	pgbN6lClZ7XVzCvte+Pa9c6XfIIhKxSTWLWxpTgs/na1/wxTRDu4GT4fEgNSSLq2Adqj/0w1ra+
	8MfLqf7avTfr/bfm5AVFel2P0Yt4+D7OgVuoJIsyxELZ4RW/SBAA5mFO3Z/TQ7P33huBHJk6+7u
	x2AvmVHfbZb2gVWJFmpnp9cFJBThORqwzA+yHbmdM1MN3Y5ydkzYXgfKfaN0kR9SHo1AfUnAXtn
	fbvJZca4YUHJdCEGnRSt8GS1gpeC/lI7r9EjtLvvcu1JaQdGx24GnFX4oXvft6kJTa5H0nWiNKR
	hhdJIjguRc3t3mGY1mMXzwCZar/CjdQeOIAoY=
X-Google-Smtp-Source: AGHT+IHCPrN7eR+D+kU2SwBA7nmLBnku+5xo6MtDpIgXiSpETxbxNcs9TulWIMc7l8A5LJZmRcmwdA==
X-Received: by 2002:a05:600c:1c9a:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4776bcbf80emr41226985e9.28.1762530565117;
        Fri, 07 Nov 2025 07:49:25 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5875338f8f.9.2025.11.07.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:49:24 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue() in virtio_balloon and vduse
Date: Fri,  7 Nov 2025 16:49:15 +0100
Message-ID: <20251107154917.313090-1-marco.crivellari@suse.com>
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

    This adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
    to be per-cpu when WQ_UNBOUND has not been specified.

Thanks!

Marco Crivellari (2):
  virtio_balloon: add WQ_PERCPU to alloc_workqueue users
  vduse: add WQ_PERCPU to alloc_workqueue users

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 drivers/virtio/virtio_balloon.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.51.1


