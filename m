Return-Path: <linux-kernel+bounces-721985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E645AFD062
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A83E188676A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584642E3708;
	Tue,  8 Jul 2025 16:14:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211D21C9E4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991295; cv=none; b=phnzEaGQQvj74iY60o4W5Jf3WR1D+stlx0qe2MAcE4eFZdktVLLgpTi7HX/nnKR42MMbGnZuve3qhR6xfyMHwaPGcl3VWs2jjhB7emXUgaoDwM4zgAx/dQSvgzZRvI1UtHkiL36pXLpox8Ks2MLL3pbvB2aaQnIoiTXe4Gh3XJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991295; c=relaxed/simple;
	bh=3kHplAdP0zVGF3P1aTKWa5BEPMasRXMF2rRY5rrDwuQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T4Qsu3EsDVKUbPt9FWvDP/wFmKHui99Tnhq9FFbQPOutj8TdTXzujjoW0CKTWnncD6mafcwqIZvq68thxiftqLAzoIBMz1WSIxO9DTTH2A96+s24rhnq5FamAIHophGYLEI+uPXZcwNk/7l8wHiVI+6hK805VhE4cmu4yanqjqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F9E153B;
	Tue,  8 Jul 2025 09:14:40 -0700 (PDT)
Received: from [10.1.35.36] (unknown [10.1.35.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74CCE3F694;
	Tue,  8 Jul 2025 09:14:51 -0700 (PDT)
Message-ID: <8413b873-d4db-4772-80b4-35c03370bdcc@arm.com>
Date: Tue, 8 Jul 2025 17:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, arighi@nvidia.com,
 Changwoo Min <changwoo@igalia.com>, David Vernet <dvernet@meta.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [RESEND][PATCH] sched_ext: Fix scx_bpf_reenqueue_local() reference
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The comment mentions bpf_scx_reenqueue_local(), but the function
is provided for the BPF program implementing scx, as such the
naming convention is scx_bpf_reenqueue_local(), fix the comment.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba21..702fa31459fe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -884,7 +884,7 @@ enum scx_enq_flags {
 	/*
 	 * The task being enqueued was previously enqueued on the current CPU's
 	 * %SCX_DSQ_LOCAL, but was removed from it in a call to the
-	 * bpf_scx_reenqueue_local() kfunc. If bpf_scx_reenqueue_local() was
+	 * scx_bpf_reenqueue_local() kfunc. If scx_bpf_reenqueue_local() was
 	 * invoked in a ->cpu_release() callback, and the task is again
 	 * dispatched back to %SCX_LOCAL_DSQ by this current ->enqueue(), the
 	 * task will not be scheduled on the CPU until at least the next invocation
-- 
2.34.1

