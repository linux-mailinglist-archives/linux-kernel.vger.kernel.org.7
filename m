Return-Path: <linux-kernel+bounces-739960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CBB0CD93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5841AA7D19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32224468C;
	Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0sYW901"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2722F16C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139511; cv=none; b=CoizzPFdUhbQrLtHlz7fPWBl6Xbl5M9HoT5Fb8xMCERaYjRkVX5Aa+KvfvQXfUgp0XIZvKFo4Nl0agOlJzE2FbidR1A+kiI1XQHk7lRP8gDbTJRfsF8VKP7yqTkx63e7mPzMTLBH2iFTX6h0XjFVUYxF7RlH1WN0Sd19rtwPLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139511; c=relaxed/simple;
	bh=6j5SavbHHjj/xOFyMgPPJDXs/9TJb7qBQOu19LaDNfI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JmTXCYOJ2FwTcs0i5EZOq3KHrsNTDPG5WY32sWE275Yky9QC3y92tNm6kF2GppEpRyv0HuYpIUKrJhHRzDDcv+y2NSLaqarg0TlKDYwnj5PmOvZ5qmPUbXiKZEqPGD02o7Ym6+bxnHvFZABhBSt7/Oiga95FwdPVsyGzwDbRQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0sYW901; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AE3C4CEF4;
	Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139511;
	bh=6j5SavbHHjj/xOFyMgPPJDXs/9TJb7qBQOu19LaDNfI=;
	h=Date:From:To:Cc:Subject:From;
	b=h0sYW901f0fdmD12eFaHdu7LkpWP4AFGyKEDXXTw42Zgnbe362Oy7aee4y9PWylfJ
	 W2GSR+pXSijgGKfuMAXldSk0O0U0JB1qJFkLZz8QrV/S6R6fXioWTxmdmRfDClYQSI
	 B2u+fPh5Bm2bPJsZyCIuN0C7vYphBu2DgEpZxptc+LfksG4zonq9hEIFo7W78xznXK
	 fJuIY6vb8QgGVArVpLxh75LUEKP7S60A+9oHMrjsvqYePMrJFRWPrkITPJoHUDPs9l
	 kEWi2IjY4E4/yRMrEVJA/AztYMOK1M8H2OSfl5ZgqJmb0DT08GLKbD3V4871QS5+ek
	 9/MooQiVFAyUw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgE-00000009vGt-16jO;
	Mon, 21 Jul 2025 19:12:22 -0400
Message-ID: <20250721231204.100737734@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/9] tracing/tools: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 2a5fb6af11b53ad89834747e6ef7147ee9a306df


Tomas Glozar (9):
      rtla/timerlat: Introduce enum timerlat_tracing_mode
      rtla/timerlat: Add action on threshold feature
      rtla/timerlat_bpf: Allow resuming tracing
      rtla/timerlat: Add continue action
      rtla/timerlat: Add action on end feature
      rtla/tests: Check rtla output with grep
      rtla/tests: Add tests for actions
      rtla/tests: Limit duration to maximum of 10s
      Documentation/rtla: Add actions feature

----
 .../tools/rtla/common_timerlat_options.rst         |  64 +++++
 tools/tracing/rtla/src/Build                       |   1 +
 tools/tracing/rtla/src/actions.c                   | 260 +++++++++++++++++++++
 tools/tracing/rtla/src/actions.h                   |  52 +++++
 tools/tracing/rtla/src/timerlat.bpf.c              |  13 +-
 tools/tracing/rtla/src/timerlat.c                  |  24 +-
 tools/tracing/rtla/src/timerlat.h                  |  24 +-
 tools/tracing/rtla/src/timerlat_bpf.c              |  13 ++
 tools/tracing/rtla/src/timerlat_bpf.h              |   3 +
 tools/tracing/rtla/src/timerlat_hist.c             | 140 ++++++++---
 tools/tracing/rtla/src/timerlat_top.c              | 165 ++++++++-----
 tools/tracing/rtla/tests/engine.sh                 |  21 +-
 tools/tracing/rtla/tests/hwnoise.t                 |   8 +-
 tools/tracing/rtla/tests/osnoise.t                 |   4 +-
 tools/tracing/rtla/tests/timerlat.t                |  36 ++-
 15 files changed, 712 insertions(+), 116 deletions(-)
 create mode 100644 tools/tracing/rtla/src/actions.c
 create mode 100644 tools/tracing/rtla/src/actions.h

