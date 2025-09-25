Return-Path: <linux-kernel+bounces-832708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD7BA023B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F79218995A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B22EBDFD;
	Thu, 25 Sep 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qc+APSbf"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DE2E2665
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812645; cv=none; b=oIiHxvF7Z5uaQXyJMthb2KpxYxenRrah1qEoVv+J2dJIkaSbP09X3BM4xs3fbXpjtuctTIRutV0jg1z04CPrYx6md3f/IHayfPRdff29ULvdNL6f5+Z65tJZT5XmfBIsU+SArmxlO0aOE4QgMfyMWC3bCTyvwQcWwdP0wzJ5yUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812645; c=relaxed/simple;
	bh=IjHguO1SSzuIEEiOHsL79hvKeZ6PxEppQiWleFoLMcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsiI5uEqJi5W/NXhkjjzNBIRBwUQyjNNhRPkgx1W7YZaOKCoNWx2k8rSHbwnMl90X+NywUYDATNZZTwtdiKXBbUvmb3DDxrmwGtseTyrP0a9i2AIZTr4BrlhJXV3JsP8CBsBM4cFPs0Gqx1qdWpUSmECUJgxSYOXJP73Xv7sb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qc+APSbf; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758812638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EvtiP8cp8BhABUlmDna8Y0Y1St2GWHNIfZ0PtAqOnds=;
	b=qc+APSbfWfm1HkxNcTUxP7A7opt9wXkSXngWpYL2pyaw4uSvSeu6Qe+/07OQwHr20jSsbp
	0wDu6H/3V2x79Fjv607xpQZtCHzXNCdQe+UEqVidFbzQeWUzeLIXXX1S1FbL4faWTgE2j5
	zuHkCL88AGRahruz20aL/3tXpF7fbn0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 0/3] coresight: Fix possible deadlock in coresight_panic_cb
Date: Thu, 25 Sep 2025 11:03:39 -0400
Message-Id: <20250925150342.1845615-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This time with the notifier in csdev.

Changes in v5:
- Split reordering of coresight_device_release into a separate patch
- Check csdev mode before calling sync()

Changes in v4:
- Fix fwnode leak in coresight_register error path
- Move the panic notifier into csdev and restore the panic sync API

Changes in v3:
- Rewrite patch to remove the panic sync API entirely

Changes in v2:
- Add a comment describing csdev_lock/list
- Consolidate list removal in coresight_device_release

Sean Anderson (3):
  coresight: Fix fwnode leak in coresight_register error path
  coresight: Reorder coresight_device_release to match
    coresight_register
  coresight: Fix possible deadlock in coresight_panic_cb

 drivers/hwtracing/coresight/coresight-core.c | 71 ++++++++------------
 include/linux/coresight.h                    |  2 +
 2 files changed, 30 insertions(+), 43 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


