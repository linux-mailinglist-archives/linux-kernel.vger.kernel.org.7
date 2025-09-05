Return-Path: <linux-kernel+bounces-802493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18232B452CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20854188C8BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C53164A4;
	Fri,  5 Sep 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a4K7IxD2"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699530AD0D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063514; cv=none; b=CXoYZfCYVohG8gza0qbd1GCGr2kizoFJ3voJoRk2+er5vMzb49WTwES216g25AOQ85YuSYS0JSpCobimI33O+SuVNwg7a25YNoMCoLeGBOW4jHPUg4Irk7n/AenMIo1ig4hv1obBaoujFdodulB9/ShL94nETIVMzplOZzfh6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063514; c=relaxed/simple;
	bh=rwDuCmztYd+toVRjJB9A29waZRnshUnClgrpnY09UqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTqJxPaGqltnCbXOgzVHnSq4OjdIWxLaVMB6grNVkKseOH0uVsAlt7g3wnVQS+yVW95xfbVX6Cj+KpkCuAOtwiM31TjMwTc2i3mr+2sa+m+GCoThT1qvPteO5/zoObjntwbiJcJil6vO3xE8p/9aivwTHOPO1M+l+8c8y9lAVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a4K7IxD2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9853e630so17690185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063511; x=1757668311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WehogbhCOngrfVkXJ9gjqQ8QZM8alTGTBjSwoe0C/Io=;
        b=a4K7IxD2VHGC86AB568ZolqqNU57Wq87ZckdV+qj8ieWCMAbgFMYcqmEonKFj4cPDe
         r04EwQUBzZ8JLb2jSAdsmdmSVi/siKfBVWY0mgvUEKEav7UT6RTllDf6tqCwM8ntObX1
         jNTNojQhF4FPd4wnSSE5NR5SOwAaxl1VzvdS3fLawYGBDOlAWer7ejVfi0NzBrvSI4C9
         RjHDxsW/eRknOxJeCbxNDf/XDqI695a81PG4ezVt/Pw05Cq3ttf0ERyTWl7AkNAeeQur
         9D35i3uwK7pOVG7wVMJey6OSR+So95BKv5vzJjU0SbYzhG8lbOm1QxRgTeIj92fIHQra
         +x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063511; x=1757668311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WehogbhCOngrfVkXJ9gjqQ8QZM8alTGTBjSwoe0C/Io=;
        b=XfOwVxws/KKaMMRG/JqJ875w01DR1KXDMjDmrq2V5EhtUm/6TFM+v3EACkMA5AipHH
         vzKdQkWUtfAqvsosANWgn+J9vw+oMH7Ra0wouMcC8LTu0jP+eTEnypu+MAntnILGH0/R
         H2UnmCVXw62+1rx4iLQ4okWDze+jxUSHDc70SRp/Ex0ExvqgAJgj32LqhuGv0mpMr6B9
         HAH3CXyvkbg6PuN4J5uM1d7DsfcyGqlz10Ysaw1U6z3KIg7jFMRX/WK9sdIImC2bKVH8
         AgHTFnmIguDZLAXyXpoyA3nMJgVO+i2MrcgsdUVV2pTk+ZmRq+fCxRqK9JSbGpXmT6cw
         4tCA==
X-Gm-Message-State: AOJu0YxUxfNXfGsgan8KyuiycMfigHPkVrs1FvT+dVJzJSDclZHddiK8
	AEe1CguJq6ioiV+cRP/OPMkkrMydkHeBJA9vO0jr8wH9Tkv0W5JFeuvvmHuV94N8rHN/ugLxm+1
	0ykSCqpY=
X-Gm-Gg: ASbGnctgTxnvUhHpicjG345Jd5/5h4pQJsndiVe0aS1ZtSfpUKAvCZNd9aleqAjam3m
	cbemTTACPWuav8nmrp6eLSSmEEEsGvCVOCb+ZTZ2dFwFKL7BZ67VJRFTW+CxCZH3zInUNP8FbdN
	L5SQX/pF13YmA+q0zCDICrNkUWKczeBmhaPzrV7hqurnzVEnvGAOOzmF2ALYkqliBy/eBzwaytG
	w2xMv4VwFIyPFR/hmkyrRUT+LiaF9DtQyIUn8b0CyDHsVYuwlO0qbgWSM1+17jhS+IAo6Wb+CRP
	87kzzzrkygtaPZpQNSlqO3DNx2rXuJj/+eEqtJCMBsvtmTGWChiLZ2TevKEa7CXmdJ2ajUGM3v2
	ZGPk/nnGoo4a5WXny4lu3uhrAJVxPT7wyu4Z2AGo3gaiaNkH1JIQdgZwszn5rnF9nhS7X
X-Google-Smtp-Source: AGHT+IFVCL9azlvebkaZgj+cN9WIHPQixc398V2PgiYXnFdLCE8sqr7fuSJu1LNTEfRiNNxjdHwG7Q==
X-Received: by 2002:a05:600c:4ed3:b0:45c:b549:2241 with SMTP id 5b1f17b1804b1-45cb54923d6mr69358275e9.27.1757063510653;
        Fri, 05 Sep 2025 02:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda4f2a0dsm13296265e9.2.2025.09.05.02.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:11:50 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/1] KVM: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:11:39 +0200
Message-ID: <20250905091139.110677-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091139.110677-1-marco.crivellari@suse.com>
References: <20250905091139.110677-1-marco.crivellari@suse.com>
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
 virt/kvm/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 11e5d1e3f12e..4f0bdd67edb2 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -662,7 +662,7 @@ bool kvm_notify_irqfd_resampler(struct kvm *kvm,
  */
 int kvm_irqfd_init(void)
 {
-	irqfd_cleanup_wq = alloc_workqueue("kvm-irqfd-cleanup", 0, 0);
+	irqfd_cleanup_wq = alloc_workqueue("kvm-irqfd-cleanup", WQ_PERCPU, 0);
 	if (!irqfd_cleanup_wq)
 		return -ENOMEM;
 
-- 
2.51.0


