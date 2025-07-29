Return-Path: <linux-kernel+bounces-749999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E8B155BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E0F3A7C46
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF4281526;
	Tue, 29 Jul 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo2xhfcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900FA1D5154
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830718; cv=none; b=KQSoqavRnpAnrTf9LssCAZBrAkElM5d/JjG+sZ1mb7ZY3UM1WPXvCtCbwWGmEEr0Foww7IXBHSwmiMpaHBFRxBV4vxXAyBIerA9yyYNDs3PxrFtECVruvwvZq/FwjNQx22Ilu8GtZEWCQYlD5kgfdG+vERnj43OFdw+sW6nhm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830718; c=relaxed/simple;
	bh=Jp7+7x/8NdveDAWzRogvYT20aHe9DBA6tsqBWg5Ot/4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Dhb0nkgsHKFOVX2IKdfFDjhAlrK6aCNdrovaTxEMsUcdczRkBa0NaJb5fAhk00zD35622Cs2wZy6OtuQu/LIe57COApWe7iec0QzOZp0PQMZ5XIszri6iJyb357eNvhMTjctGKRNY7C8Zk+oUZdADxjZzP6SdyqkZB319dnWso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo2xhfcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E823C4CEF6;
	Tue, 29 Jul 2025 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753830718;
	bh=Jp7+7x/8NdveDAWzRogvYT20aHe9DBA6tsqBWg5Ot/4=;
	h=Date:From:To:Cc:Subject:From;
	b=Lo2xhfcYnyTjS/5Wmtwbmd/PtyOUGghKPMD81fLZWq4GhrYZrIOvCT6MTEyVVcTzm
	 cP+wWU73/INdvC70qAisjGa09FpvhK6bi0auDc7g50L+ojR5y4MuuidoJYOC5QLJ9R
	 yCbcLBu/0qeF4JtUx85XQ5isi4BNgtAWPvi8gbc6TxPJGJju4mPidiCWbvH0kA8YW+
	 L0qw0Gu4AJ4htIJpBjPMQ+e0n+XTePaV3HwG/1KEOSa1wpIK347YYsxMOXWwNaIYDK
	 xSzry5cgzEExso5InQ9mLwuUSi2OiYzoKzzF1bocZhRtTmkN9fu2xrqXKIET73e6i8
	 VczUg72jVLeAw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugtUT-00000005K8j-1vES;
	Tue, 29 Jul 2025 19:12:13 -0400
Message-ID: <20250729231157.059587961@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 19:11:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/2] rtla: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: a80db1f85774ae571b94077f65c5cd57467641d3


Tomas Glozar (2):
      rtla/tests: Add grep checks for base test cases
      rtla/tests: Test timerlat -P option using actions

----
 tools/tracing/rtla/tests/engine.sh                 |  2 +-
 tools/tracing/rtla/tests/hwnoise.t                 | 11 ++++++-----
 tools/tracing/rtla/tests/osnoise.t                 |  6 +++---
 tools/tracing/rtla/tests/scripts/check-priority.sh |  8 ++++++++
 tools/tracing/rtla/tests/timerlat.t                | 15 +++++++++------
 5 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-priority.sh

