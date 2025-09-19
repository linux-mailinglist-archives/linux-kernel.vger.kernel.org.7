Return-Path: <linux-kernel+bounces-824933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A7B8A802
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE791BC0FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B95314D34;
	Fri, 19 Sep 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZ/lvbCE"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0321ABD0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298033; cv=none; b=hLUKRm7txQBl5jIp/Z7XpFH9RH1hemIwi+EyLYW/6JrLx6aj3MzdKZSy1IP95V1a/S9gZ9YAokZp2eVlb5/bkYPkYf97FHF3jAynnTjIG6CAvKDCUoRwg8PjkqnXifDv+DeeivG4F+XIYxxEfxw+ONK48zlFUY5cLjn+SJV7QWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298033; c=relaxed/simple;
	bh=kLb2Q+979d1A5yUNNB2cpVLXk2A4h+z1qvnoF+2loIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U96bTsiw66VbeD1klQ7VcIa20CH7JxibprffMXfMqKteeD9Lfl9LqmMIlV3F6vmLUa9zNrIt9Q1AQWxVtm6j7WK45TeiZ2G8bYU4TSg3ona6fjRaBmKVicC7Hp+TOcPxLSSUojcExMMd+3xh8+toJ+yekn4wvEY5sN1WeLEqzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZ/lvbCE; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758298028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AI+xJYubzU8xYbi5UOSxx5OYAN6NReD9lv4iQlpsxGI=;
	b=YZ/lvbCEDGq2qugkxdT68KuY11ipuLPPS/lFfSPjzNYXQbBnxLGv/qQNdS0HhBnrusAwc/
	Ee8zEynI1IJnWgQXZbcpHKEcQGKxNa269+HurkW7EqV/i36SZbEsNZXiOch/TUgsrbyEs0
	uyD0P2izsG6sB1Ha9stJU2CY2MUce84=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 0/2] coresight: Fix possible deadlock in coresight_panic_cb
Date: Fri, 19 Sep 2025 12:06:51 -0400
Message-Id: <20250919160653.507109-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This time with the notifier in csdev.

Changes in v4:
- Fix fwnode leak in coresight_register error path
- Move the panic notifier into csdev and restore the panic sync API

Changes in v3:
- Rewrite patch to remove the panic sync API entirely

Changes in v2:
- Add a comment describing csdev_lock/list
- Consolidate list removal in coresight_device_release

Sean Anderson (2):
  coresight: Fix fwnode leak in coresight_register error path
  coresight: Fix possible deadlock in coresight_panic_cb

 drivers/hwtracing/coresight/coresight-core.c | 69 ++++++++------------
 include/linux/coresight.h                    |  2 +
 2 files changed, 28 insertions(+), 43 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


