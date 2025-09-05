Return-Path: <linux-kernel+bounces-802420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48347B4523B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907995A2E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87301290DBB;
	Fri,  5 Sep 2025 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H/j3WqlE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10314301497
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062639; cv=none; b=lsyHLbUuOqwb9ZQD4DGYg43l9tugv5bnYLYnzGSZgSDioM+1DAXnoPqzM+3edEoHj5ooKKrenMPMEiBxNwGGST48sJUnkybS6v1ZogRCzKF4zIaC1OEixSlRchooyd/yXL8CcIu7n3Uya1F0quR37G6DhMGVo0FslJngu+BrJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062639; c=relaxed/simple;
	bh=noY2x8YkWOlIpwgqQFN144/sc7GwOOQv/UpDW+VgwuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8UKIdDxlKtduZn/B/jjR8Jf7fZA3J8PYeCXRrDP8Yhy18cHp4KfIvgLZDbS2bOAX/SkUxWjRnUqKxaxkb+zoTaSkYcbhQnPC3uFJVi58l1taRl02vy8JsFZdYQc3/Wo67JF8YOy51YrvP3G68mvfIqir3MYRfshUdbw7xQe/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H/j3WqlE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo321795f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062636; x=1757667436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+373k89tWwun6tYrTn7kvcTBTelhNfYslI7h6eKl8A=;
        b=H/j3WqlEoirAGQqSFsD3CLZUjCyc1QYC1HVa34czKbyWhFtO3povl6xhUcB3eC48Zo
         H3/2E7ORLPEQB9bcQo3w6BXpoRI+gG4VeZcQqIFCKqM5ViEpEkbebHZR43uDUgSmcx0r
         jH7IEhhDdovE2IGXmFIkKFaR/2bntPVxH6ffXuqCVNHEpIC9J/MIYm+PL5fntAYeMbH3
         FaJNiHO4ndKL06tc2Z6DT3y94+l8wQwWjMoAgPNW7FdLc83aMn9xmzvfZ5qJ9D0EmznK
         I7X5BMJa29iVYAqvezlNVutCC8E2KypOYY9dpFr+xewxkkBR9WP9iSDjIPYQYS6QbDE6
         tT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062636; x=1757667436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+373k89tWwun6tYrTn7kvcTBTelhNfYslI7h6eKl8A=;
        b=xFhqI9QsUccGBdgcRf2kxULVai37OxPDT/bPBCpHSPgcXgkYs/l6HYRBeVbH+nFp6S
         xiq3fNjJGnXBpZm5eOEurGoStV9MEEKenCwv5/3tn+IUNwWWn/xQz89EuxXBYamB4V9M
         ihYWtDl1DHgyW5V9ydhIpNYvXHSeFiHyJ86VJRisEGt64vM31PsUBpboCvEvg49u90I6
         +eEBONMlKe3H5CvXNHr8aqPmqEko+ziMjsCSxiCdaIaaiLt+ykEe0Bhfs9rqoRH0Lr+x
         9sAwudQnLhRunh7V3grC6p4lHZt7ScWsd9SJfsqzQ9ohABNJP57I0zSHBGbh6A4tfIUJ
         Lj8w==
X-Gm-Message-State: AOJu0YyKOevAg4x8VTwLSf/dM4TcApSDU4o7chY6yWf9n6iZATvmj6sG
	T4EpksT9Avf1MWVt4x8qDf4SrkHSq5fnhDez3nOhRKN8YRVPeYTAICySl7W7McbqvEdqbzAD/mJ
	b29QC
X-Gm-Gg: ASbGncthyP10diYVPjOwqL6tuxqbZDXuPt7Y2JzN/w88WBo1P7kzyWKlEoOMXd1B9q4
	pASvSAVDNnIOBiT+kKDpl6IuEZS4nUmZCPJxyYTsDEdZgUThh3yxYaWkgHU4I1pMxZtXl5foQMf
	RMlXMhrhCuvKuqoyYqZg/ptadLyalvexqiJqV7jB/LYEpuyGwhTV9w38jp3QKSdpBQISNMzEEfe
	TjIOgM5py00PTFLjLcLqnqbivqoXjnll6HplYACcwP5jB9DvIn5WQrPV3ZIzEwQZH4oH7RgUxNx
	uqOz3ZJneahIFY/ZIF2Sgvjh8ZXAxT9w7IhTH5OVuxSMZ8WDx6yhgz4y3Is6esEIXznkCsIYJ8w
	75JFvIOu4u/AKeVgbjIpkRKMOTl8/L3wwamo0HqhEvLvocUE=
X-Google-Smtp-Source: AGHT+IFo3nXBnIvWK8ei6IV3F8NXhA2ZlYdh4WG/HM6kH3mQu1re7CfNZmk1avxIW8asrKmx/77+IQ==
X-Received: by 2002:a05:6000:1447:b0:3df:33e9:14b9 with SMTP id ffacd0b85a97d-3df33e91a11mr8128044f8f.11.1757062636152;
        Fri, 05 Sep 2025 01:57:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e177488999sm5094989f8f.36.2025.09.05.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:57:15 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/1] crypto: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 10:57:01 +0200
Message-ID: <20250905085701.97918-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085701.97918-1-marco.crivellari@suse.com>
References: <20250905085701.97918-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 crypto/cryptd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 31d022d47f7a..eaf970086f8d 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -1109,7 +1109,8 @@ static int __init cryptd_init(void)
 {
 	int err;
 
-	cryptd_wq = alloc_workqueue("cryptd", WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE,
+	cryptd_wq = alloc_workqueue("cryptd",
+				    WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE | WQ_PERCPU,
 				    1);
 	if (!cryptd_wq)
 		return -ENOMEM;
-- 
2.51.0


