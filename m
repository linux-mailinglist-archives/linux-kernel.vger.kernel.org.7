Return-Path: <linux-kernel+bounces-682409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF47AD5F98
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A593AA338
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DB2BE7A3;
	Wed, 11 Jun 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KTGAP0oJ"
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90592BD5A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671850; cv=none; b=bbYtuhNT+K99AREJXv0E6cEl2Y7krurGORiJ+BPuDdJVgvp0l6R08YPctspY8fzzDQoJ0mDFVEWo2Xq2a7rNiNbQhDgn+5S8WduoVoMYQwjg3iXWwQYtwLBc/QBFtEbFQ8sOwURNmehZg5t/z1s84cgP9TX9JiDQsod5R/e/uWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671850; c=relaxed/simple;
	bh=MU8Zi+pntPYytdt49KNwDwq4ACCf3lHI4qQsBgK7E6g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gHUMDQcek7jDVKc/tGLs3M67x1pdRAp64GBUibpZEr+qCEIWMHNSYJ825YAv5r8jb9nnKpfZD6k8G1lljY2EBH4pd7lF5vkRwu9HOGeEEk4i0gjxhzT6uGd0n9Sf/hRMnLOnLKjAhK3KjHRFjlM9nCwLwiZH/W2L6KHMVNn5fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KTGAP0oJ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZW-00BIDa-1t; Wed, 11 Jun 2025 21:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=d1QaSFHfEh3cM2Uv7I3zUqxXFc1eWwgg2qbFxn/xMxc=
	; b=KTGAP0oJ7ZLO4T+XONPBBuZ8nO5acq803LvkagTvlFsHLizXcHUUNHkwSl4x+PGiPriobqTJk
	u7/5LM2t7Zl5CEIFaelft39YuLdSwumZCY01r/tWC+BAHHYS+URDpJtzj/HtTIDwyFW7WPlV4DuCw
	tPOvDs0TGlQfuKlKAT0WeYMGAJr20p7ETXT+X9AM8seNzlgFswC2upqvafnuOMRUD5MVjvDRQSQXC
	XwEGj38a2lelMCjiMdrAjvju58mc60qkIdxrWcwwSgCHHsjmurFyx8trG98niAVYf4B1o9oO7ViPV
	+mDGsjgI2VFjP7GN0mqQDw0b8KAAtHdJX4d1AA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZV-0005DR-G9; Wed, 11 Jun 2025 21:57:17 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uPRZH-00BycS-19; Wed, 11 Jun 2025 21:57:03 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v3 0/3] vsock/test: Improve transport_uaf test
Date: Wed, 11 Jun 2025 21:56:49 +0200
Message-Id: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHfSWgC/23NTQ7CIBQE4Ks0rH0GHqVFV97DuCg/tcQEDBBS0
 /TuEja66HIymW82kmx0NpFrt5Foi0su+Br4qSN6mfzTgjM1E6QoKMcBSgr6BdmmDM5r0KGAksg
 lojJqlKQO39HObm3onXibwds1k0dtFpdyiJ/2VljrGyyQH8GFAYN54oKOl54pZW5RhfWsQ8MK/
 gPyEECgIOdBCNVTI0b9A/Z9/wLGVSFF/QAAAA==
X-Change-ID: 20250326-vsock-test-inc-cov-b823822bdb78
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Increase the coverage of a test implemented in commit 301a62dfb0d0
("vsock/test: Add test for UAF due to socket unbinding"). Take this
opportunity to factor out some utility code, drop a redundant sync between
client and server, and introduce a /proc/kallsyms harvesting logic for
auto-detecting registered vsock transports.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Drop "RFC" prefix, rebase, amend commit logs
- get_transports(): don't look for a symbol that was already found
- Expand testcase comments, clean up the code [Stefano]
- Streamline `enum transport` and `transport_ksyms` [Stefano]
- Move KALLSYMS_* defines from utils.h to utils.c [Stefano]
- Link to v2: https://lore.kernel.org/r/20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co

Changes in v2:
- Speed up: don't bother checking EINTR or respecting timeout on connect()s
- Introduce get_transports(), warn on unsupported setup [Stefano]
- Comment the code, drop the sync, introduce vsock_bind_try() [Stefano]
- Link to v1: https://lore.kernel.org/r/20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co

---
Michal Luczaj (3):
      vsock/test: Introduce vsock_bind_try() helper
      vsock/test: Introduce get_transports()
      vsock/test: Cover more CIDs in transport_uaf test

 tools/testing/vsock/util.c       | 80 ++++++++++++++++++++++++++++++++--
 tools/testing/vsock/util.h       | 30 +++++++++++++
 tools/testing/vsock/vsock_test.c | 93 ++++++++++++++++++++++++++++++++--------
 3 files changed, 181 insertions(+), 22 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250326-vsock-test-inc-cov-b823822bdb78

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


