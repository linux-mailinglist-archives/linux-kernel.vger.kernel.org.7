Return-Path: <linux-kernel+bounces-802409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402CCB45222
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C855879AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A8308F39;
	Fri,  5 Sep 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DBxvcbz6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AED2FD7A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062406; cv=none; b=sn+UoqzdAw/Cft0DxwAMTaWLxYEY5ahJW2UcxXM28a7gWEpEkE15Bd8fMHPhM82RLZqIGQBQkFj9hAVVVCp9Nh/pSLCEUHhFnNL3xSlLlz9UiLwo8Zor1H83Hb7FbQFTwI0moxNy7McL9cH4G1PdvFlojcmI5cYTrs7rJ+MPTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062406; c=relaxed/simple;
	bh=Rd5E7VX8al1/yxlM1TCq3M2KFAf74BT5deQ9L5tNQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzQD0HlXUxbOOlpGQP3fXL5DLcEBsx+f4izAK5jP0kuLijHifVbkqYBpImR0E7B6/TQ1+aFUA0j5kWTCDFDma0D4CM4InxG4NnpftPd+3F2jcWRzHaeJH5IStW6J2u2dEtY/ve3ffC4aHY9BNJf9HCKYrlsWigCxxMjI/wBEWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DBxvcbz6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1272447f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062403; x=1757667203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkkrYyhxJd0RflEiiebzkXK9jZInfTGc63Bh8fEciOA=;
        b=DBxvcbz6iIrxbCLiCNYovdQGCZcZerm/YxP0DpFb+GBF4WA4ttiMmB7wKYCu2P8VbC
         rvosGyexqGiCK/giWC2Ed4gSEMEHjiXFPfkeLfpMiF6dRU/tgm+rvDY98KJ4NaEzuk80
         k8QnjDDH3gw82xGe88cVzcJ1jwoXBuHw3PCAFIVULX7ynMwST3jHkLDrneJ8+Yz83YuN
         PN9xBMbwZrBYKiResjICKXUlRr3zlk+sY+6Aw1Os0pm8UQQkbFJ1gyLzSzhgYVAmQsJI
         w7dY18qiLcyxO0s4tWoPwixuSvQACnlpbqJU/08DurBQZmKdvwXRwOQd8Nnrdh6QrI0c
         h7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062403; x=1757667203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkkrYyhxJd0RflEiiebzkXK9jZInfTGc63Bh8fEciOA=;
        b=m4/sAnIElyIGaglS8ljui41IQd8CzUiky0OB3/4RABiORyX+KuKlFgyF0S9MmfJKuD
         QmVEGQFY88ZP4oHwpRGKTiQSv3Qf46Txz6732rAFGg75VO0hjemjy0A75e3yVdO9If89
         1VP59R7iaI2r748xuwESZXi4k4IdxHLysM52fcBlIRkIXOC/1Ankwyq7dHSZE6nrFRwp
         zfLkc1KToYi4BSNQtGFy5LONwH4htTNJmE+sOIUbzWqAIr77Pl685gTnUNth8b+lR3zb
         Jc94SCB/hQwEmAsy5bfvBYRuL4OCvWjFaX/WrC6TlNpujC3S4EGVOIFq28zi5Rf5Q+uj
         jl/Q==
X-Gm-Message-State: AOJu0YyOc/PyQsYI4RYzgtUawuAZAcCeo2rcycF//DNiSIb8VJR0atjd
	/r1BjRpd8Gc0BOLMBJO+BhOA2HnmTODciD1rqgL7osoOOKn3cW6aoKfe31h42tzN/+y8OA5AhDa
	XOjus
X-Gm-Gg: ASbGncvZJZf8GdDekBYXjLQUnW1MmE5sacnvhYoSWZ6h5ZbDW+NzF9Efzm+sxTlrgPg
	a8SFcQj85ua+JDZXZc3sVEC1XpM0SGnEms7U6ocyDnlU50UpV2sGQ7+Yl65gnnttN/957a4dvFX
	d10i1vOR93YNfKAvdAGCRZ1jia1ktVztJRmCbLaxXQADscqMATYKXAXuN4tKD36aHIKGg5SoBuL
	hKutuMlvFcaV8rZUNwnL4vZ9EPHL2EXeXIF29tL8SoBVRi0IAbhu3a+7lhj9QdKxhmzryafQ3ok
	KBCMa7rNX2m532+cm9/3TnlMhPXPmboQd3LJeB4Nj0PwERxcF2unIU3pXQ790KxnyzwL/QsPU81
	sHohIIIcfxeoE+xGcnVlkgDaTNm/JvVScXxILgy5v3g1E4tO8S75jbbfR2g==
X-Google-Smtp-Source: AGHT+IG4QQ45lKCN+n0HyBk6qgrsjQ/B3l2iLMhuDOogHoANzxh7AVdJOxYPMBT0wed4ztKRtHT89A==
X-Received: by 2002:a05:6000:22ca:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3d1e06afa9fmr19056043f8f.53.1757062402553;
        Fri, 05 Sep 2025 01:53:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18487293f8f.8.2025.09.05.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:53:22 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 3/3] bpf: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 10:53:09 +0200
Message-ID: <20250905085309.94596-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
References: <20250905085309.94596-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/bpf/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b8699ec4d766..f3da9400c178 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,7 +34,8 @@ static struct workqueue_struct *cgroup_bpf_destroy_wq;
 
 static int __init cgroup_bpf_wq_init(void)
 {
-	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy",
+						WQ_PERCPU, 1);
 	if (!cgroup_bpf_destroy_wq)
 		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
 	return 0;
-- 
2.51.0


