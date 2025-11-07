Return-Path: <linux-kernel+bounces-890428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701EC40080
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA7E04E9E48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17CA2C3261;
	Fri,  7 Nov 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMobzLOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFDE1F0E25
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520877; cv=none; b=ivshiMTEKu/eS/SDc5W/NR0mcnz1pjWMGNOtQ7byDAsXO08WbLI130WXJoAnK3aoj4X2NWHhiVf5fa23FbA66pGnF9VoG8cfWqWE84Sovl3XAE66m6364XtQQTnxizQCsuWymVtz9iYF0UNLzkQcWt1LdvkrUCvevP1ANMq1LsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520877; c=relaxed/simple;
	bh=V8FKGNxdOwawCztEIg+IywPCYuK7h266GoBKtgNL+k0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=fTykjEXdpngHyuKeieZeDe/pDNjI8jeIdGyYUQKgnyaGZsYPeKvMUOnuUdk1VgkJnrqdW/72lQqrEVTMh7Hicnjtu+ORJGYukWzegWFJzdnUKMOtXwcbrHUjLlggtaW68hyHADzOkc83O2CbX1/TqhmeuwTImAKU8/Jw4vUdTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMobzLOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54EDC4CEF8;
	Fri,  7 Nov 2025 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762520876;
	bh=V8FKGNxdOwawCztEIg+IywPCYuK7h266GoBKtgNL+k0=;
	h=Date:From:To:Cc:Subject:From;
	b=pMobzLOu1eoHe3j09jmvX93RoOHT9H3qpqoGwJ+2ge4tJArJmQUr3JLlAtvti5QXX
	 0a+eZ1nNlnc6JhjTySWkiMt1FAchJ9VlqccayyMxb9o9Hyb5phco6TnNxl2GZVYTCJ
	 bxSjQ3CvfcGaomUctZTe+nWW1JzTz+w57Y111CYg6hgnnwrYodkp/bgju+QycDagif
	 D2nWUy0jLWbhSUinKGL1TvQhj/6FTpNmKPonokBcIBn7JLxPLCW0TgbnejpppK5jTN
	 fFnI93pFYUHdGatraCgHOnjO4JTT52YlNxq0BOQI7kG42BRo+G5wsg7a5oeSAUuZrX
	 G7zn7122DNjsQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vHMC5-00000000GFz-3m8e;
	Fri, 07 Nov 2025 08:07:57 -0500
Message-ID: <20251107130730.158197641@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 08:07:30 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-linus][PATCH 0/3] tracing: Fixes for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Fixes for tracing:

- Check for reader catching up in ring_buffer_map_get_reader()

  If the reader catches up to the writer in the memory mapped ring buffer
  then calling rb_get_reader_page() will return NULL as there's no
  pages left. But this isn't checked for before calling rb_get_reader_page()
  and the return of NULL causes a warning.

  If it is detected that the reader caught up to the writer, then simply
  exit the routine.

- Fix memory leak in histogram create_field_var()

  The couple of the error paths in create_field_var() did not properly clean
  up what was allocated. Make sure everything is freed properly on error.

- Fix help message of tools latency_collector

  The help message incorrectly stated that "-t" was the same as "--threads"
  whereas "--threads" is actually represented by "-e".

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: 53afec2c8fb2a562222948cb1c2aac48598578c9


Steven Rostedt (1):
      ring-buffer: Do not warn in ring_buffer_map_get_reader() when reader catches up

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zilin Guan (1):
      tracing: Fix memory leaks in create_field_var()

----
 kernel/trace/ring_buffer.c                | 4 ++++
 kernel/trace/trace_events_hist.c          | 6 ++++--
 tools/tracing/latency/latency-collector.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

