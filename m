Return-Path: <linux-kernel+bounces-743399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E56B0FE39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FE23B4764
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710F3597B;
	Thu, 24 Jul 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJClTEkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD82CA8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317702; cv=none; b=FeC7LYIoXkmAg2xiXwr9bEZoftIIMKtEXf2KGh5f9rdIBkD23s5zFoY0Sy0117pHVYDDGrz6OvGFDlCBmBXnoHpsQUIbX9Y0OvBk6iaVwdSrFwjP00VvaHmv7Te8wx+uFEHZYvByBiZUHQQqEx4hH7ZmuArDV6NrNHMYARaEVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317702; c=relaxed/simple;
	bh=k+2aOaQM61MRv2WOLCMx6/xgVuzY9DmIOEJyvJEskI8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=TKfec2BqFarKqvnW9eTBKYj/NHJ7ImRvtF3Yk9p601GamFU/52iQGPHqTBx9k6qTmdqwy1+vZTUEtj2Z1dIzMUYoAsrCbBTr+r/5nX9X5h8gTBqRsz1sd7GafAuP9Kge0Ao2v76N43PQsfL8vZI1XtX1h5Oj3r+JXvLuxuVkNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJClTEkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D6C4CEE7;
	Thu, 24 Jul 2025 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317702;
	bh=k+2aOaQM61MRv2WOLCMx6/xgVuzY9DmIOEJyvJEskI8=;
	h=Date:From:To:Cc:Subject:From;
	b=RJClTEkhEmyJOJdxQ37EkgRlCXqvgclQyBMwnAaHa2jptFAh4hK6E0K6lmtm28BRv
	 kHCnGH+cWGOqeZzzS7BQSvz/awNoMNrKKuFL67WQUDYQsc7ZdfDpGOiZZwJ94KAxmQ
	 fHhmnKsAk2Bz+Od4GxvzGcP/T0xEXaOH+Pds/qncI2C20wACMduWEsd2jfPgYMK2MV
	 6nWfxo+bSy/N5dqKIg+qTEKKnM9SnNoAnElupQ/Zp8oTy5So3DsffRK8gr43S9nPFN
	 zvE2sBZseAn9SvKntLwA3Dd6yJ3BTsL+q+C+/KT/2hjCNTfyYLcFn7ISHPL8IQ7shj
	 JaNTYSuAupOnA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uek1o-00000000WYg-0ZhB;
	Wed, 23 Jul 2025 20:41:44 -0400
Message-ID: <20250724004126.185765796@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 20:41:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] ring-buffer: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: de4342e4feeb28701561a24ce55fc0bf82dfab45


Colin Ian King (1):
      ring-buffer: make the const read-only 'type' static

Steven Rostedt (1):
      ring-buffer: Remove ring_buffer_read_prepare_sync()

----
 include/linux/ring_buffer.h |  4 +--
 kernel/trace/ring_buffer.c  | 65 ++++++++-------------------------------------
 kernel/trace/trace.c        | 14 +++-------
 kernel/trace/trace_kdb.c    |  8 +++---
 4 files changed, 19 insertions(+), 72 deletions(-)

