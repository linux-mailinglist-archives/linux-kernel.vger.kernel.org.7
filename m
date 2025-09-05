Return-Path: <linux-kernel+bounces-802470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B01B452A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B91D1C86744
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2E280037;
	Fri,  5 Sep 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/NHhILq"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E23309DC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063285; cv=none; b=LonR1jnggvIzRjMp/MqZ1IjY10Arvety5RpS+YcyPhQMITpsNCKU8mO+i+SCBT7igzl0YzM/Uiea3YqxbrcAms0QbSz2coax2hGYdxSj6rctswDtesrPwkTKYkGLvc/B5E/LALSCWbgWqpx8CPr7tq4+llZVSn523sXODeV6EBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063285; c=relaxed/simple;
	bh=qkdztFXLaFLOpPxKYX76fm7otHffD5cZK4//HWe+OUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPHs8Ns3/u7qUeyJRbpry5SsIw0M0O5BY9knpSZYaAuDlSJJPuOt72gCfyk51pVuyp6idPpxfBRohim+bBU7l76pfB2i/12ZI9FEXGQVM/Ug5hGafHbG65B2A5gKaL7XVwvmZDPQm+cCY0UdUM2VSgJhAu/dkgBXZgADo9d1By4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G/NHhILq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1283219f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063281; x=1757668081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNu3JrNHi/qEOOengN/e8XVNw/5CBER76eU60Ek4MJs=;
        b=G/NHhILqrS2GiCUO6GlOwQ7yVfhLkWFfzwvdzHeAWySHWn3XQYhimdiBMn1qavmZSD
         Trk6ADFlwxR+edt1dkLH3vcmzrT3s9rjpFJmurXdEwEzTkw9mSiLOlVuXeXmcEUU1XM+
         OvZAVKSssdbRCwWyTQt0B0sOfZUMwLyQsvhzYmCAM5M+v9fvooNa4U9T3HLidoHj7NgS
         R3ayPySRsfHMbGsMaEsZBmR+8F7ejtOr3aeNggBCeg6/800Em6cqvXRn7a2lZIpswGa/
         GeiL9+1TqLjpf3M7vITO8Ojj5v/PParXWQ7ae9AAWlRPBipW4EK0d9ScWQUxsmE7jUYB
         FUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063281; x=1757668081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNu3JrNHi/qEOOengN/e8XVNw/5CBER76eU60Ek4MJs=;
        b=jJXrq0MXTTCoJxpBL4GCh8qh10LN4kfZXWqfbmdrQCL45uAbiDBd0Y1o34zJ3hmiab
         XjUNfjjF5nU2g0ePCmp7bU6ZQKjuYetWhHpMouB0Nx1YB8z+rdlk8Pldv9WfmSNMs6jI
         kdAEuSqLsB9Ih2vMP6VQ2l5krWhNpN34Hc+ZjdSBD9tGs5hScoN2INHLyDyNzwggXQ5a
         FXnP/rbRjDZtQXEutOndj19dBkdgPWMWd30VPJETAbbYGDACw/YngzygVTWU77v4jrGc
         q4zBEqzRkXUbBMY8mys8HO6/5u5Bulce7/lZfMtuc6AKrSf/zarubVcxvMTwSmZuErxM
         uQOA==
X-Gm-Message-State: AOJu0Yyj9aiU4IKSc0/iS2pd8jXHhQIY1SySoU15KLEoiEzy7Rb0RDju
	xOjJ2RCc2aopK6irp5KFG0e/KIUg2UvLeEjA7tYysyBKqIo3XFuwd2/paT8GKAOoNmSHIgPk/bJ
	lOm+Q
X-Gm-Gg: ASbGncs5QHBHN4uJNAFMkEkYJHYRc/Ap/wqDRHv1UrBsZDx6vrg/cMGaSb34tnoXMZ6
	8Mq9UFwG8ByVS+4MAroewo5Ls84+2YuJAxIaqqE/ZMWt4vriYC9G07hW8P/rwTsh9rYTFhhfCKf
	8QH68jNse+DwxGtMMbhblRymfG6Yjc1qW1cvOzY7geVN7fIN/ACuzSkZhuVG+CrNkIiD6OVURWE
	8YPl2sxnRi1AnqXrYW1drpMyfZgfJfZDNariz+TAqMhCMoG0BPmhr7uySMYfy4XqrXm1HoSDxVp
	Fz9td0mZWAep69A5h0Diaum9wf4r7UxElYs2EElDwmonbfXNFJqtrxmmgzWKPRpz4d+2ykKtxo+
	NjWb7Abue1VbcwBJgN8R7d2qMGkAbta1opEghY+nt5zcACkWV95CKaEmqqg==
X-Google-Smtp-Source: AGHT+IF+/atwG9vdO3wlQO74aDlEiGObLmRVz5buolGSQk8dlHigSbSJZCAxM2nIrkHrG3Mpnrmhug==
X-Received: by 2002:adf:a1c5:0:b0:3d4:f7ae:bebb with SMTP id ffacd0b85a97d-3d4f7be0a79mr11095234f8f.26.1757063281330;
        Fri, 05 Sep 2025 02:08:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm311505335e9.10.2025.09.05.02.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:01 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 1/2] rcu: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:07:46 +0200
Message-ID: <20250905090747.107232-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090747.107232-1-marco.crivellari@suse.com>
References: <20250905090747.107232-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c0cc7ae41106..5fddd7168391 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -552,13 +552,13 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 		rtpcp_next = rtp->rtpcp_array[index];
 		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
 			index++;
 			if (index < num_possible_cpus()) {
 				rtpcp_next = rtp->rtpcp_array[index];
 				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+					queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
 				}
 			}
 		}
-- 
2.51.0


