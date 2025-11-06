Return-Path: <linux-kernel+bounces-887721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB1C38F26
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943194E1B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857D21D3CC;
	Thu,  6 Nov 2025 03:13:59 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FC347DD;
	Thu,  6 Nov 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398838; cv=none; b=ani/ZCqh03Iu/4Ht2gAzvLKClhdzdCq0rqbCY4wKVqLTMJdKncfsupNwrZkYbW5tb+z96aUdsTOtzlSZpVUwn4rT0nWipZ6lFgo4/WIhgYwZk38tvTTqGN/4e8n+zY/Xv4Drr1kES+AlNwhIip+6m2GhyTtnqs8Da924kCMcQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398838; c=relaxed/simple;
	bh=8WUsvx5/71QQ9Vr0SEtyYTPNQiuu5YWD7TnNwLyYXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuT6GMnMypiqcAiBwCUTjmdWj2Beawy3vAvZCPntOqKDkFZyGWnLIaLzNW1wuvpQjjrrx2sYYfQED6/TJGEiNbco+8+n9CKPB6jR8UebO2YTCGtjpWLKFlvAx5C+8cUDr6l8bd6b5wP97GCxKrBn0RFYCWI20QYpr+1xx2aEotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7690c11b50e8-a31bb;
	Thu, 06 Nov 2025 11:10:45 +0800 (CST)
X-RM-TRANSID:2ee7690c11b50e8-a31bb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2690c11b23c2-40760;
	Thu, 06 Nov 2025 11:10:45 +0800 (CST)
X-RM-TRANSID:2ee2690c11b23c2-40760
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: linux-trace-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] tracing: fix incorrcet short option in usage text for --threads
Date: Thu,  6 Nov 2025 11:10:40 +0800
Message-ID: <20251106031040.1869-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The help message incorrectly listed '-t' as the short option for
--threads, but the actual getopt_long configuration uses '-e'.
This mismatch can confuse users and lead to incorrect command-line
usage. This patch updates the usage string to correctly show:
	"-e, --threads NRTHR"
to match the implementation.

Note: checkpatch.pl reports a false-positive spelling warning on
'Run', which is intentional.

Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index cf263fe9deaf..ef97916e3873 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1725,7 +1725,7 @@ static void show_usage(void)
 "-n, --notrace\t\tIf latency is detected, do not print out the content of\n"
 "\t\t\tthe trace file to standard output\n\n"
 
-"-t, --threads NRTHR\tRun NRTHR threads for printing. Default is %d.\n\n"
+"-e, --threads NRTHR\tRun NRTHR threads for printing. Default is %d.\n\n"
 
 "-r, --random\t\tArbitrarily sleep a certain amount of time, default\n"
 "\t\t\t%ld ms, before reading the trace file. The\n"
-- 
2.50.1.windows.1




