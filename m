Return-Path: <linux-kernel+bounces-737848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C1B0B137
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CAEAA43D6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960492874F3;
	Sat, 19 Jul 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzxbT9bV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F71EB3D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752947874; cv=none; b=VRz2nlZFKgWWuPd3r/Dcez//CJmVrpB9drGJDgH/bXqnyI2Yv1vMN86k3GdLmSOdwvx2KUvWcPKtr0SRYgekh7bhih5ucB5hJjYfSFsgsvziogLg/UiB5zKrjLMAjWXdUKDJkNeT4PRNRMrngCDU6bDeEUF4DN0IuSdeBiEX+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752947874; c=relaxed/simple;
	bh=ZCk2sq+jUmsbbTNHCJLB/w212eu0FDQTOYzg3ECxo6U=;
	h=Message-ID:Date:From:To:Cc:Subject; b=F26GakfGbQMzyswcguiqYtbLDezXjwiySDdL/cNubkbBKvMw7BVQLanZWjDj+jkbgDQvtW6JiXGGUMgF4CCVWmlx1AOtkQirakLPzEQjR1UM/1s8vAGHMm3+YLUhY80zrxejOWXztCapfKrmqTP4SMyfgzfh41EwwD7zHwUJLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzxbT9bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3B8C4CEE3;
	Sat, 19 Jul 2025 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752947873;
	bh=ZCk2sq+jUmsbbTNHCJLB/w212eu0FDQTOYzg3ECxo6U=;
	h=Date:From:To:Cc:Subject:From;
	b=SzxbT9bVFR75ad8GTHv93MtTEO7yFsdn44CccNg3vlD9/dMTlqQAHD9g0FHmq28Gf
	 RnyPYOQjw84KLjv21qeB8QSIfPSv0It6bwE2zv3UR72g3WC9QQbErI2/hTnS3gaPx1
	 W/MFT4amTt34S+mhWu36gIjPltQq7CNtOpv4TyXcn6uT6sqqpZOa2Oq/cYnrHh84vU
	 hhTXV1YDEx4Ty0f4aoPUXKKCT+1J7y+rL3vr9KHXo7a9hnGKhY2vGVNFOiZw5jWegR
	 hFthTSD3B5AR4mM2+WCxDC0UeURwOlzkpkKusxP6c4OekTjFaIoo/C+2EgZQQSk7g3
	 UILV87U+INsXg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udBpD-000000085Gt-2kYp;
	Sat, 19 Jul 2025 13:58:19 -0400
Message-ID: <20250719175754.996594784@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 19 Jul 2025 13:57:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Fixes for 6.16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df


Steven Rostedt (1):
      tracing: Add down_write(trace_event_sem) when adding trace event

Tomas Glozar (1):
      tracing/osnoise: Fix crash in timerlat_dump_stack()

----
 kernel/trace/trace_events.c  | 5 +++++
 kernel/trace/trace_osnoise.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

