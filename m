Return-Path: <linux-kernel+bounces-746768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75060B12AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC4A7B3487
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94728641C;
	Sat, 26 Jul 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC1AYRx/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3F64A8F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539402; cv=none; b=HFioj/PL94kK4YVALu3KqS4m123ev9feljz0CFe+9A7ISCdY0VRfd3xwInFVBwb8dT8HwLCeelREx8F/nAkRk6VI6BzhXl7W0PnbkIyE0Rnx1C5HSh3zCkbjiZGDALf3gJ66v9djJnoYN9CjGeoKeUtGSRU1Jr6kXMJPfOIIxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539402; c=relaxed/simple;
	bh=Os64ietSU+2rJitZlx4M8k+FSIx64zOru1rm5+xfHnw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mYSoXXS7sbKh4E08lrjOaeKFGw0RRgUf9TUYRTKlUW9ySQDZxc3oejSXXha6I9DRDYlSjntFpX8rXYVKpCDBt1EmpR5Ie5ZiaCkO0j7IwrlKqFhrHoGF5XmKtGAzkSGsTaVjRW3PnwJ7d/D6akovN4SRmV7OccbSLE1TO7o2Eu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC1AYRx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF7EC4CEED;
	Sat, 26 Jul 2025 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539401;
	bh=Os64ietSU+2rJitZlx4M8k+FSIx64zOru1rm5+xfHnw=;
	h=Date:From:To:Cc:Subject:From;
	b=QC1AYRx/ThjtQ461+Fh4zLYgMn3MCfMCkc6Pw3Rx/xA0pA43/EPlCgxVN6Gy4+QAQ
	 paw8KSUn/m9WPqp1Qy47j/1HOOsotgDb7QTyG48vqRzfBm1IIduwJ2DXsRUK8ElbeJ
	 qd67tizRRO2w2muTA15H6MPb7M9fTuiOf1b29BJLlW8rs+AASA7E9vF48Hd7kil9/c
	 dCfnOsKW7ydqx6cH0h96w8EvaLRjeQmJ2wjixr9mVK3Ay9asTI6NR1r3ewX9tY1uoQ
	 NU4ehX4H3Syac4oAxsDnUjeFphAApCCxeEpwvNc46mv0QIVHc4EdWo9JEsVAPeA13Z
	 zf9Vn3m7wrVsg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffhh-00000001ssY-2SoY;
	Sat, 26 Jul 2025 10:16:49 -0400
Message-ID: <20250726141604.934070855@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:16:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Hide tracepoints when not used for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unused-tracepoints/for-next

Head SHA1: c2dbaf0af05193fa69f267c37d1f825c1c3a59ab


Steven Rostedt (2):
      powerpc/thp: tracing: Hide hugepage events under CONFIG_PPC_BOOK3S_64
      tracing: sched: Hide numa events under CONFIG_NUMA_BALANCING

----
 include/trace/events/sched.h | 2 +-
 include/trace/events/thp.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

