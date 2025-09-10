Return-Path: <linux-kernel+bounces-810141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D583B5168C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE8B17AE71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97030E0D9;
	Wed, 10 Sep 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ACs0SQxh"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52C23FC4C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506318; cv=none; b=mQXQZfUOz9OFnOKDszIECgmdDifduNHRPq2xq4oo0sIVlY2e9TyAU+ascEoQazwzlU+wV3tSekEpjk/lvnr/FcgQVJUwXHO83HbseNDoVkvZwfFz1OenyzxJ6ej+Ve61oNuMuZjS1DcA5j5xycFC/gERk2zkgKJYY3f8FDpXbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506318; c=relaxed/simple;
	bh=b693sWWvp1I+xxWdJ7kZp5HxGTME1fotX47GKIlw+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8yg2r5taFPdbctdiF9fSC+F+P9GjFAG/M8VNwBcuuwDthQ5j2KXL7msxRRgEjui6S5WvQQ1JlkqwxoAapZD0Jp5/7hnlCFkiYu/C6+tU4npS3UqCvZrgXdp/H/OafR5vAhfefmHELrn4EQ1O8xqjIPoCsAaeYk3/8JMTQTY15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ACs0SQxh; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757506311; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XvIiVqSYrXf64RVaEfdD9zGvjg33JNVU80CZvbmOC+0=;
	b=ACs0SQxhx7cX39c/gxrbHiwPn7zInVE7sthUg8209g/tCtnq5cdQxuLhY+Ua6N03YOB3J0mZ1i53zv0jjOrtcBmf1rjeDANNCpnZQtMsirDuFR1PK0I8INMAWbLnE44DpZCOqppnlim0c30DkjyYtbdkqy8DoXi24VqKD2xM5x0=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wni1q9J_1757506305 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 20:11:50 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 0/2] perf vendor events riscv: Add T-HEAD C930 JSON files
Date: Wed, 10 Sep 2025 20:11:19 +0800
Message-ID: <20250910121121.7203-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

Add pmu json files for T-HEAD C930. Including topdown and some
other metric groups.

Chen Pei (2):
  perf vendor events riscv: Add T-HEAD C930 JSON file
  perf vendor events riscv: Add T-HEAD C930 metrics

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 .../arch/riscv/thead/c930/basic.json          | 117 ++++
 .../pmu-events/arch/riscv/thead/c930/ieu.json |  97 ++++
 .../pmu-events/arch/riscv/thead/c930/ifu.json |  62 ++
 .../pmu-events/arch/riscv/thead/c930/l2c.json |  87 +++
 .../pmu-events/arch/riscv/thead/c930/lsu.json | 182 ++++++
 .../arch/riscv/thead/c930/metrics.json        | 538 ++++++++++++++++++
 .../arch/riscv/thead/c930/vfpu.json           | 177 ++++++
 8 files changed, 1261 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/basic.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/ieu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/ifu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/l2c.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/lsu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/vfpu.json

-- 
2.49.0


