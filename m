Return-Path: <linux-kernel+bounces-742756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE526B0F64D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B91967BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CF2FA628;
	Wed, 23 Jul 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFU3xL8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A12F94B4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282167; cv=none; b=uGaXu10nvoNlD1nQUgWxO7yniqprycJ+cI655fV8I6olpzqJcctAIrcUtl5syXNr3erEvsCixLJAwjWj3M+N6WZ7rEnsmvZEs5rTkkPBzoomUqQmK8YrDvnPWbd7u2fHOx7gbkkPpEOYepe0iJaw2y5Q4d9q5M1HoxukMBmFlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282167; c=relaxed/simple;
	bh=+tNxeXOdOUCuh8CYMpesQlhxnXzSOhrIzHE0Q1lMG10=;
	h=Message-ID:Date:From:To:Cc:Subject; b=uE5TpxdonJOhpBBG5zBUVb5doC5BK7krkTyfcHAbx9hvV3N914cgy1bTwE5V3d9RqIX4ZVDd+KeZ/gS0fJRP8eCamy5fPrpvInHJaeZj8z6/O/YQjIptbCJvvR4M7MMcyJIGf8g2RSjmbZwYL2W70KYKoYVUGbfjv2rHBKMhff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFU3xL8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0472C2BCF5;
	Wed, 23 Jul 2025 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282166;
	bh=+tNxeXOdOUCuh8CYMpesQlhxnXzSOhrIzHE0Q1lMG10=;
	h=Date:From:To:Cc:Subject:From;
	b=QFU3xL8UZmG3LIZSQZn7h8cK3D+I8M34hv5lJgMd9teHu1upxloeCKUvGK4GRs1KH
	 x2wYZlcH/GfSYYguRB/k2+5d6gNcZYozM+XJ+x91urVnBB6dGGfr1li7UtXvlWw9zp
	 kTOX6fezYdBHIHJbURoxDGLsR5Xhp4CVPUNU9jvwolNIHj9XEex5caIwBftVNjyLu3
	 knLjrAnOuS6kD6NmrjOPOvQmg0cfOrmbWSAEyP8xdtquqqkcpA8FYB4tPOreObfkUi
	 gFKVtji3nBbw4CI1hHMqM+CTrO0onYEq+2oGAO6Ib6buuDkuvHyKxjm9JIkXMoUCAz
	 23Hnhtfh1BIng==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueamd-00000000LOj-200m;
	Wed, 23 Jul 2025 10:49:27 -0400
Message-ID: <20250723144907.219256132@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] tracing: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 9ba817fb7c6afd3c86a6d4c3b822924b87ef0348


Arnd Bergmann (1):
      kernel: trace: preemptirq_delay_test: use offstack cpu mask

Nam Cao (1):
      tracing: Remove pointless memory barriers

Ricardo Neri (1):
      tracing/sched: Remove obsolete comment on suffixes

Steven Rostedt (4):
      tracing: Use queue_rcu_work() to free filters
      tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
      tracing: Fix comment in trace_module_remove_events()
      tracing: Deprecate auto-mounting tracefs in debugfs

Yury Norov (1):
      tracing: Replace opencoded cpumask_next_wrap() in move_to_next_cpu()

----
 .../ABI/obsolete/automount-tracefs-debugfs         | 20 ++++++++++++++++
 include/linux/trace_events.h                       |  3 ---
 include/trace/events/sched.h                       |  2 --
 kernel/trace/Kconfig                               | 13 ++++++++++
 kernel/trace/preemptirq_delay_test.c               | 13 ++++++----
 kernel/trace/rv/rv.c                               |  6 -----
 kernel/trace/trace.c                               | 21 ++++++++--------
 kernel/trace/trace_events.c                        | 26 ++++++++++----------
 kernel/trace/trace_events_filter.c                 | 28 +++++++++++++++-------
 kernel/trace/trace_hwlat.c                         |  5 +---
 10 files changed, 86 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/automount-tracefs-debugfs

