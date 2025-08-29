Return-Path: <linux-kernel+bounces-792059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CBAB3BFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC82D18853FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB2334395;
	Fri, 29 Aug 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA4C123Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20635326D4F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482523; cv=none; b=C1p9JirNJUbqhMTx//XDc9j8LlQGsPIHGPYmB4Qrcn58q8QxyMrob9M+SUraP+bfKASzzp0foi5V8UENs6Q6baDevAR7ZlsPr654hZoZmMth2TWq+2oTHNGvFXkBu20HsvyfgtiXUmz0c3RfB/B/q/p48DQ6flTl4QBiHJ88nJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482523; c=relaxed/simple;
	bh=fgejeggFTJF5KymiXlA1EoAj6cO6G66DeOSRRZSU6VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYO4pfaNDvfKNh7rW/e1AyFM+OtNTOFK9F7qNod0BREwYk7TCMVaU+zu9NjbQX800qTX6WQXTClIAejtFxRwxQJxUzgAYNKVJEiis3X2ONTknRjn9Qe3p2y21jhdr1c0Jfs3agsK19wT6/2OCCm+p0ISy5f289xlDeWarOrP2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA4C123Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B295C4CEF7;
	Fri, 29 Aug 2025 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482522;
	bh=fgejeggFTJF5KymiXlA1EoAj6cO6G66DeOSRRZSU6VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RA4C123YmO1uTOx/KKumY63ZjvO2S5ckV0mZi4L6dSyjJhtk2epPfdl+vktamFs5M
	 Ah+6oScoyYKi5QIXO9wQXavJ09G9hstFVe33A3RycYqkGiYfv393n+Q8OrJzkEu8NU
	 xzykTnkDJUg+Z1/DOcnIt3AqK59uvglAOjrq8ifALFC2QKivkyyAdRFgT9bZh6wWxR
	 csFLv6dN0+cPtMfHL6SBB2SudoM3F6r9ZgHAzQXHPmPc6sp6wFMA0kjyKb9QMJT+aJ
	 rIXkDYu4uim1WlenScn5KIYvoDeaoOBfdq16hHdghTQhgLl3eFcllMRRn+qVSbOvcc
	 3dDUJ20NF7Czg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 08/33] driver core: cpu: Convert /sys/devices/system/cpu/isolated to use HK_TYPE_DOMAIN_BOOT
Date: Fri, 29 Aug 2025 17:47:49 +0200
Message-ID: <20250829154814.47015-9-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure /sys/devices/system/cpu/isolated only prints what was passed
through the isolcpus= parameter before HK_TYPE_DOMAIN will also
integrate cpuset isolated partitions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index efc575a00edd..f448e0b8e56d 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -291,7 +291,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 		return -ENOMEM;
 
 	cpumask_andnot(isolated, cpu_possible_mask,
-		       housekeeping_cpumask(HK_TYPE_DOMAIN));
+		       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
-- 
2.51.0


