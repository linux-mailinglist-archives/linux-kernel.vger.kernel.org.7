Return-Path: <linux-kernel+bounces-750000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FEAB155BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901741751F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C375285053;
	Tue, 29 Jul 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCizDE+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B44280CCE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830719; cv=none; b=NqDzH585wVgo9C6bQB7zNfMy699TAFh6NOnH12al8Nx7fcXxFFUORMmR6ixGHsIX+RgFmmIWeo2FLT2bt+H3hf6QoMcAyMADetCaLolxBOsVaGDgPXREoCR9Jl9aoEY9h6DfW82ABlUHktluwvTtrBwo7Yoyz0s75TNMRGo6MUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830719; c=relaxed/simple;
	bh=7yBjII2EI2XOmeKdK/UJCjNS0Mlw9nVTvAqVEvTZ4TM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=h5plo1Za2pXleKfDi2kTShsVycST7MPUFT+LjvG6lM0OMIuz/cHja1p+uE0Jo6DwHHBhA3kP1mIlLXbxiy6tu9BbE0ti5luTqLx6Ih8x5oxEm706k/pg2aj2Z/TwH+v9dUCHJohmP5Mn82X+9zxJZ/mnX0xVz8OK6uhUhnunQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCizDE+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB03C4CEEF;
	Tue, 29 Jul 2025 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753830718;
	bh=7yBjII2EI2XOmeKdK/UJCjNS0Mlw9nVTvAqVEvTZ4TM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uCizDE+TO5An0GT4ZA+FAJYn5UmgKGHMkDQaIptDn0oeKcf0iSc9Fl+Rg0dNWShUI
	 0FyK8f3piNZbC87GqXypZIZAUz9cqvNDMfuKXc1CrfBroQqHHnK+9uWe/dH5ZvcGMt
	 7/C9mD9OWCKKEsK0faO/8LevOgQbJ6kW66HO28mghSS1EGh1vr2lO493wG1w+5HaF8
	 w/iTBGlwoj9rLZHTvaBSN2Se2q11iByaY894JP8SRH2zZ4DEU6s8aTeMFrZ6wbcpmw
	 1AJVCbAo8EdnFJRX7mmYt38JIbxoMxDzeBuHqcsD+5ZhWEVqk+1qX8YfFI7NU5ySrZ
	 42WrHzL6h1Lrw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugtUT-00000005K9F-2eo7;
	Tue, 29 Jul 2025 19:12:13 -0400
Message-ID: <20250729231213.489236527@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 19:11:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Subject: [for-next][PATCH 1/2] rtla/tests: Add grep checks for base test cases
References: <20250729231157.059587961@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Checking for patterns in rtla output with grep was added to test rtla
actions. Add grep checks also for base tests where applicable.

Also fix trace event histogram trigger check to use the correct syntax
for the command-line option so that the test passes with the grep check.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250725133817.59237-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/hwnoise.t  | 11 ++++++-----
 tools/tracing/rtla/tests/osnoise.t  |  6 +++---
 tools/tracing/rtla/tests/timerlat.t | 12 +++++++-----
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index 448877564b8d..23ce250a6852 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -6,16 +6,17 @@ test_begin
 set_timeout 2m
 
 check "verify help page" \
-	"hwnoise --help"
+	"hwnoise --help" 0 "summary of hardware-related noise"
 check "detect noise higher than one microsecond" \
-	"hwnoise -c 0 -T 1 -d 5s -q"
+	"hwnoise -c 0 -T 1 -d 5s -q" 0
 check "set the automatic trace mode" \
-	"hwnoise -a 5 -d 10s" 2
+	"hwnoise -a 5 -d 10s" 2 "osnoise hit stop tracing"
 check "set scheduling param to the osnoise tracer threads" \
 	"hwnoise -P F:1 -c 0 -r 900000 -d 10s -q"
 check "stop the trace if a single sample is higher than 1 us" \
-	"hwnoise -s 1 -T 1 -t -d 10s" 2
+	"hwnoise -s 1 -T 1 -t -d 10s" 2 "Saving trace to osnoise_trace.txt"
 check "enable a trace event trigger" \
-	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s"
+	"hwnoise -t -e osnoise:irq_noise --trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s" \
+	0 "Saving event osnoise:irq_noise hist to osnoise_irq_noise_hist.txt"
 
 test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 6a4dfa31dc55..7574ec6a5a53 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -6,13 +6,13 @@ test_begin
 set_timeout 2m
 
 check "verify help page" \
-	"osnoise --help"
+	"osnoise --help" 0 "osnoise version"
 check "verify the --priority/-P param" \
 	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
 check "verify the --stop/-s param" \
-	"osnoise top -s 30 -T 1 -t" 2
+	"osnoise top -s 30 -T 1" 2 "osnoise hit stop tracing"
 check "verify the  --trace param" \
-	"osnoise hist -s 30 -T 1 -t" 2
+	"osnoise hist -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 2d59ee199c4d..db263dc90a2d 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -21,15 +21,17 @@ export RTLA_NO_BPF=$option
 
 # Basic tests
 check "verify help page" \
-	"timerlat --help"
+	"timerlat --help" 0 "timerlat version"
 check "verify -s/--stack" \
-	"timerlat top -s 3 -T 10 -t" 2
+	"timerlat top -s 3 -T 10 -t" 2 "Blocking thread stack trace"
 check "verify -P/--priority" \
 	"timerlat top -P F:1 -c 0 -d 10s -q"
 check "test in nanoseconds" \
-	"timerlat top -i 2 -c 0 -n -d 10s" 2
+	"timerlat top -i 2 -c 0 -n -d 10s" 2 "ns"
 check "set the automatic trace mode" \
-	"timerlat top -a 5 --dump-tasks" 2
+	"timerlat top -a 5" 2 "analyzing it"
+check "dump tasks" \
+	"timerlat top -a 5 --dump-tasks" 2 "Printing CPU tasks"
 check "print the auto-analysis if hits the stop tracing condition" \
 	"timerlat top --aa-only 5" 2
 check "disable auto-analysis" \
@@ -37,7 +39,7 @@ check "disable auto-analysis" \
 check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 10s"
 check "hist test in nanoseconds" \
-	"timerlat hist -i 2 -c 0 -n -d 10s" 2
+	"timerlat hist -i 2 -c 0 -n -d 10s" 2 "ns"
 
 # Actions tests
 check "trace output through -t" \
-- 
2.47.2



