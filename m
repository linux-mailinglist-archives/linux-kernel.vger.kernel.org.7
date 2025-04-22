Return-Path: <linux-kernel+bounces-613926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E691A963FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991C516A08A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2901F1906;
	Tue, 22 Apr 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VyKHW3Tj"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305092F872
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313434; cv=none; b=ppfF6Bnbwg4Ey5+8IzvwnKd7K9DGmI+fnIfRVcE+pTUifxM9/FPAxJAGjsq9REZ72Rhwi/nCpGhD+55mAZILtFQhnBS/jPWcLvOaE+LeSobqjUfLgookcDNCv9WMKOfhGFWpWIAr7wmEj6rY5hP363QuaDCQxCWMr+685FGcP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313434; c=relaxed/simple;
	bh=2+Hg1j9TD+fECcZIFf3N8ABPxHsxjjhr6jbTTk9uqSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjfWnGDaUGyyp6mjM0/VRTp5emAuVUAUpF1YcgZxAXHhsvCDBpGUVMsQkK9MN12YXg1lz/uFurpO/X9xSMImX0P9l/8KKVfhXMCbzhNDgh27XD6V5uWGQsw8P0+cSFFstpUn858suvh1DJtZWSaA7ZxG7NJlPNNqptJlAUrE2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VyKHW3Tj; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745313420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jk0ZV1PxWMKLH6tS63dm99aZAvjsLyQLeAI6jWMBXRI=;
	b=VyKHW3TjyVmLM1HOFsQmGUW393ChHWH8e/R2mxKxm6Ti7q9fu5+gZReh0gwdxtvMQy+dIM
	8Hiv4O90SwBJHnf/FNfV3y+0KGqLrFEyipOSKiYkHpFmFWu7dk4nuWTQvYuN7ZiB3saQji
	Y94qKK80YdSTu3wzqZX+BvK2CZKBCw4=
From: Tao Chen <chen.dylane@linux.dev>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [RFC PATCH bpf-next] libbpf: remove sample_period init in perf_buffer
Date: Tue, 22 Apr 2025 17:15:58 +0800
Message-Id: <20250422091558.2834622-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It seems that sample_period no used in perf buffer, actually only
wakeup_events valid about events aggregation for wakeup. So remove
it to avoid causing confusion.

Fixes: fb84b8224655 ("libbpf: add perf buffer API")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..1830e3c011a5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = sample_period;
 	attr.wakeup_events = sample_period;
 
 	p.attr = &attr;
-- 
2.43.0


