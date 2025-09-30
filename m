Return-Path: <linux-kernel+bounces-838187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85DBAEA07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F16A189F25F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774162C0269;
	Tue, 30 Sep 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnznvQo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0C222560
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268718; cv=none; b=sCqckFgyPi4zCWOjtLjofAnzYYQrSn7OR5FHkOE99a+z6JivoKBwvuO+iZQH5ukc4oZCmsmPHvSvre0qA7yjiUjqf1vtVH4TwcPHDdQLAAkM1SM1z9HcdLnX1zd8tsEcs6qmJBjLa52MiUQAXf+KuaRYIXVbYYsy3GEx7ktQ6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268718; c=relaxed/simple;
	bh=zLfsWruy6Xs0wNtkHN+BYo1fj9b0x8wG3OoFp5mP224=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=atkktNQbCoWfvruw91vCBv23VTnI55nwY+GFUDr4R/tTAd8K04lD543j5XJXL8nhE39RRdH9PnAQVG3bi20KHzVGwjp/qoQYbjk5SzGwvtPK+r1O0koI2ZkhTEhvzF4hclTpUGNcjL7XD4Sw1csAFKXjqYYTbQqh1z9f/e5Q4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnznvQo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85925C19421;
	Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759268718;
	bh=zLfsWruy6Xs0wNtkHN+BYo1fj9b0x8wG3OoFp5mP224=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GnznvQo5oKfmY8mhI5lPPvNtmWDMjWBkeM8Sju6LIHBp+YegJ4VA8S6ggutb1bL3O
	 QwGpQknehpxpK510RoaFXXeSSh9PmDnaygeM3/sjUTgbt6j1RoKME82B7R3lO/4CHC
	 wavOGKSyToUJ8M3N88Kg7xf+ds78PGAkbApYN2EJV4E0f99z6WIEu6fsfw45qAZ4dB
	 u0VEw/h+TSlOq7lJPIr2MbjCc/dB0ulSIZApecK3BxkJoiE617d+lyHbGk48ozbpvX
	 QKtESx0RVmTEWbXQpInV0TUV3LLFXWw7H6PGfAk8GL2fW1XqJIKKuVbEBlQwF2qved
	 PLfxbDGdIiwjQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3iBT-0000000DUw6-0NSJ;
	Tue, 30 Sep 2025 17:46:55 -0400
Message-ID: <20250930214654.944795507@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 17:46:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>
Subject: [for-next][PATCH 5/7] tools/rtla: Fix -A option name in test comment
References: <20250930214630.332381812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Crystal Wood <crwood@redhat.com>

This was changed to --on-threshold when the patches were applied.

Cc: John Kacur <jkacur@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250907022325.243930-6-crwood@redhat.com
Reviewed-by: Tomas Glozar  <tglozar@redhat.com>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/timerlat.t | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index c71aed5534bf..b5d1e7260a9b 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -47,9 +47,9 @@ check "trace output through -t" \
 	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
 check "trace output through -t with custom filename" \
 	"timerlat hist -T 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
-check "trace output through -A trace" \
+check "trace output through --on-threshold trace" \
 	"timerlat hist -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
-check "trace output through -A trace with custom filename" \
+check "trace output through --on-threshold trace with custom filename" \
 	"timerlat hist -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
 check "exec command" \
 	"timerlat hist -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
-- 
2.50.1



