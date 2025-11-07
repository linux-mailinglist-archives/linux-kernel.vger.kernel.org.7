Return-Path: <linux-kernel+bounces-890431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E5C40097
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CBF3BAC30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6362D24B6;
	Fri,  7 Nov 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAolzATU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED322BFC8F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520877; cv=none; b=MluVmFxzvgAwubSR1WTw39HeztimWtFtw2NZ1dR92X02NWG09qsrQBsJ6NNIG0utL9zyan4ouKaE0ah+vIPEymwuPsSfT7a9q3KEP0mXT9eP9m0WZeFXWcpTChMnO4NbuJ0WPfG1ShaHTwGATLUbh+P77lJWYxnNY/qA+h/MAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520877; c=relaxed/simple;
	bh=x5i4jI3rGTtuKkTnNhWVfyENMY/Cb47mGtDuLs0h73k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uujlzJmQ8fIetN3Plk8UQ2VHMcRyZtDVBsxu7syQ4sKM0Y1N4sUQgEvdn/6hUIUuML+aeLCc6mIUgTmI95vJbNF49SIJ+mhdDY2aadD4NECQreyJAQPtx4XNygQwMzAVUDFAMMUx+U+D6yO2x2GA0bp+3xH05KlxVTm8E2KuXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAolzATU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1162AC19423;
	Fri,  7 Nov 2025 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762520877;
	bh=x5i4jI3rGTtuKkTnNhWVfyENMY/Cb47mGtDuLs0h73k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dAolzATU2a3p+yGycrbdk8H8eIeyRpVCgJfxXD7Gi3WLq/UonLrNqbfG/QcLanaLe
	 PoVIJ/jWRf3ty6HmgviJNHjx6Eq2zwvxglbjgBfAOZJRMLUdyweAC2BA9w/N3gRsC/
	 84lbeom6dLpUHhLWdoQA4SFNcR+wH+rmXZhs1/gmrZPgA1SK1rv78KqX/2vrTBViHb
	 ufYRgS2TBBEjEui/L+8B8u7/mfSahBCMTzNaZHNzQ+r73L67KVK3boNZP/Rh7FIBFD
	 320uuNpSi6erT4CVjQAR3pxWODxXhdg6go+LvdbJOPB8+zl7pf5IlgMXd/1Gb1u4oP
	 HVGbWXEOOSJAQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vHMC6-00000000GHT-1kU6;
	Fri, 07 Nov 2025 08:07:58 -0500
Message-ID: <20251107130758.272051237@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 08:07:33 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [for-linus][PATCH 3/3] tracing/tools: Fix incorrcet short option in usage text for --threads
References: <20251107130730.158197641@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

The help message incorrectly listed '-t' as the short option for
--threads, but the actual getopt_long configuration uses '-e'.
This mismatch can confuse users and lead to incorrect command-line
usage. This patch updates the usage string to correctly show:
	"-e, --threads NRTHR"
to match the implementation.

Note: checkpatch.pl reports a false-positive spelling warning on
'Run', which is intentional.

Link: https://patch.msgid.link/20251106031040.1869-1-zhangchujun@cmss.chinamobile.com
Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/latency/latency-collector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.51.0



