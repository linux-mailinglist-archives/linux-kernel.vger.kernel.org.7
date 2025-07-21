Return-Path: <linux-kernel+bounces-739966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F2B0CD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F49E6C4DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72C252287;
	Mon, 21 Jul 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AysuFOzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32024503B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139512; cv=none; b=JcilrCt+Q6p/Knd5hWbpuZVm6Jhn5raPz4KeGMnQGkTJQh1ECYQg4AaBpdm8Z9UhlOpOSGqQXIHr1iEoCapWB5eDKOwKE32JSt5jC/G9QF5RwpgBcWYZIOh/Y5wItRlVH5inkty6R2F0/X0G/l+7KYnkW7jvJHCUkPwOLJUKe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139512; c=relaxed/simple;
	bh=+B1acoAMtoMh6OG0TOvC5cM0I8M+uPpq/hFcmBEth0k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rcE9N9T/Nyr7jW+HRT29089edC0KvQmM0DxcaBRzsOIBYgE9tkSfnvmjx9TblCy81Y/KQ6U6z8kHLkHQ3OlcznpwimL9jBuJOuVIcJpSlXOxyZ0JHHhPXHxO21DxfApV3OM4sEUWjPxUbqBQxBbvYt4aSwj/FvGQmupH3yzdCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AysuFOzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217EAC4CEF7;
	Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139512;
	bh=+B1acoAMtoMh6OG0TOvC5cM0I8M+uPpq/hFcmBEth0k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AysuFOzTuCZXDS9lndU5GIxlW1sNTZL6gE7MeA6CMe6uN5JPOpwqK11v86YOJxh3F
	 jkCPuYysIyWOfpDc7qhgWLaJXz/Kaqs2C5HomzUYYG40cVd/EckHAmdwzMyzCTYgm3
	 7Xcq6JwnZFf/R1AjlJbZ7wzeLAARVculNYpm3qwZbcL5VPivs7yd3a9YhxuX5MjPsJ
	 WqIC7TwZXK0u8RO0vSt0mkoceGsxZvxD+203I8zlqYDB0XMIAXQk4g7Wt50iXKF3Og
	 2bDkFTLuF8TrB+nBdFie8fbFcw4d+DzUAKX5UCshbDdTuHFAQbli76dUcC7hapKBxr
	 Tg/JdCcvVsKCw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgF-00000009vKL-1reB;
	Mon, 21 Jul 2025 19:12:23 -0400
Message-ID: <20250721231223.297069085@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 7/9] rtla/tests: Add tests for actions
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Add a bunch of tests covering most of both --on-threshold and --on-end.
Parts sensitive to implementation of hist/top are tested for both.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-8-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/timerlat.t | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 579c12a85e8f..b354bacd78f8 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -18,6 +18,8 @@ fi
 for option in $no_bpf_options
 do
 export RTLA_NO_BPF=$option
+
+# Basic tests
 check "verify help page" \
 	"timerlat --help"
 check "verify -s/--stack" \
@@ -36,6 +38,32 @@ check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 30s"
 check "hist test in nanoseconds" \
 	"timerlat hist -i 2 -c 0 -n -d 30s" 2
+
+# Actions tests
+check "trace output through -t" \
+	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
+check "trace output through -t with custom filename" \
+	"timerlat hist -T 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "trace output through -A trace" \
+	"timerlat hist -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
+check "trace output through -A trace with custom filename" \
+	"timerlat hist -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "exec command" \
+	"timerlat hist -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+check "multiple actions" \
+	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
+check "hist stop at failed action" \
+	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA timerlat histogram$"
+check "top stop at failed action" \
+	"timerlat top -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1ALL"
+check "hist with continue" \
+	"timerlat hist -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "top with continue" \
+	"timerlat top -q -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "hist with trace output at end" \
+	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
+check "top with trace output at end" \
+	"timerlat top -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 done
 
 test_end
-- 
2.47.2



