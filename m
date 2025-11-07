Return-Path: <linux-kernel+bounces-890659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73AC4098A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C7D3B9755
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3D31771E;
	Fri,  7 Nov 2025 15:33:19 +0000 (UTC)
Received: from mail-m32120.qiye.163.com (mail-m32120.qiye.163.com [220.197.32.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CB188735
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529599; cv=none; b=f3nHIKKcCDJIJd8fLIkS6EErsYdDCaq16aK4W8TqCJvIZcJs/OhWsCari0I6e6ECa9tFGF2nlLk60DhXzEzqx3wzKbexfPqyLnFGMC7D+wSHHCcFgUMJWHgIq7jPj/2y1L3J57KqeNvhztcFA8+aglEDinKAGTS0wb9L5aclP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529599; c=relaxed/simple;
	bh=hhKcFwyj1jmlk5pA8wZFglbcC1qmcZFvPfOrhf3NioA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX51WJJnBFGQk0Gmn4Gp9J0gO2/SNhDrkpGqkaUGR5JjfsQUiu/cTzIIpFYhIfXy1yR8E8njmyou4OX867cfkl3tw8FzntQtmEdaQeETmFOJCQKL/kBeFlE7MHMaIuml7Drj3PpDPm8E3JMPppzyttzqD49Pa+bNJC7vzhwf+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=220.197.32.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28c500947;
	Fri, 7 Nov 2025 16:43:30 +0800 (GMT+08:00)
From: Shouping Wang <allen.wang@hj-micro.com>
To: will@kernel.org,
	robin.murphy@arm.com
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	allen.wang@hj-micro.com,
	andy.xu@hj-micro.com,
	peter.du@hj-micro.com
Subject: [PATCH 0/2] perf/arm-ni: Optimize codes
Date: Fri,  7 Nov 2025 16:43:17 +0800
Message-ID: <20251107084320.555979-1-allen.wang@hj-micro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5d7c291309d9kunm533ae5d212b2d40
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhhOVhpMGklDSB9PSU5KGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++

Rename PMU device name, and display the topology info of clock domain.

Thanks,
Shouping.

Shouping Wang (2):
  perf/arm-ni: rename PMU device name
  perf: arm-ni: add topology debug info for the clock domain

 drivers/perf/arm-ni.c | 69 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)

-- 
2.43.0


