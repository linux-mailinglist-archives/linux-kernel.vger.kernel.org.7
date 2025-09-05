Return-Path: <linux-kernel+bounces-802481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C80B452BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE8C5A8317
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C230F80F;
	Fri,  5 Sep 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DGU1AeZP"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592742E719C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063406; cv=none; b=Bq+DhNmXaYsP7IWw9G7SQmgvXJpQJ4OziV5QYjz8TrocGLxRHEZSPYtpby+cPGr5SModRroYM77xbPPzJynURTmbUPjFGGnnyf0sipYKfKDLC4Mw5Xizv7TBy7W2jTIt7dV//7m43kQj1hESZwmK9P2ETXlk8RaTkdWIVpCmcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063406; c=relaxed/simple;
	bh=c77O9ec/ULWw7SMgr1eYONGGF+NUm3SQJponSBiRNuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfUdNdeR8OBeNwFaVuZF4isuDUePlhgMum5Z/yuKnabPFXyZ6TsJ7xJXizvmis2U1rCVxG7u2gHiWK5xwTOISeFk1zcj5CR85ir/iOmsa8aF3KoKhW6dviPyvNub4rU1YYXpt8a7zFvYKAfhw1TfiZu80ToyZ+wC02kOiM1hdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DGU1AeZP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so1698249f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063402; x=1757668202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLSvCMs6f42pnQPhbcYVWMfK+jR4DhMGATcBhJ540AY=;
        b=DGU1AeZPU62pmAK6jtU33m5/zfW7IY6JxDyitViLWJMwo19lEk66TkjwAXbANFDuUV
         z4oHmKPavCc+mncjbrYqNEk8uuc3ersy//pc8svIrxt+EZa1aOqwl2clWq89frBeEVBc
         279uQFR811ySPkgvXJmoSuYypoR4gk3/IQckZ582UVfZHOJTZIN2gp8gOWQNrYv4pzWv
         VqLTOUKDWudBuXldxLBuZKJ9uPCFdIk4eb+Ui7ISyc7CeCtykjWTh6bfrc5WBpxQdXE+
         WgACotFInRXxCH/wUR0gvK0H68nxerpxink2V2f9la28aG3ujA3lIuDYXi82TTivvird
         ux4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063402; x=1757668202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLSvCMs6f42pnQPhbcYVWMfK+jR4DhMGATcBhJ540AY=;
        b=Ag+Ev5juR8y9WoKy/YsMCI6BK4ckMCsx15rtMoI0wfnF5gFEegqrkzNI1TNZkp0gz8
         whu7cYBjsUhSBF3jRycyofaQ67/ZLfaBHFubh4PzHUfT8J3yE1q43To6+wf7kGNJNA5I
         Ebb7lBrihV3I4cOu+BGVE0mzI2dEsmqHMyXmagiHWPksdqIuBAlbWYAr1xtz/d71nqzt
         O+P+cl4z3/UuNMkbxZEoXNK1M79CNGQmIliPoXi3Q2BqV/lEzOWdrNDO2bxqQ4urS+qk
         7t8txLysHfwbH3bXJvm1EQE80CIc45zDUTLEbhiyl15el5EFjWEIBU6K3lnk/kZYqkKF
         RcTw==
X-Gm-Message-State: AOJu0YyWBDktg/KD1vjk7r4f9aiyMjqlChdX22oIBWUOTVTJOwXBpxj4
	i2prWM6f8TdbWcGjEAw52Hg13/nFXKXQ7jutKpLw9ir58+ABIVYX2TT2V1OprPOW9OhDsXQVjW/
	ZQmCcH7U=
X-Gm-Gg: ASbGncvepRWwRJlB22q/Zk00v+ycbfeCKvlr7p8gtR2gnoTngkjNwwcGTPGnS5NyflJ
	l59MkgYRBjvL8GWy7newZZIY/QnSpWQModgq6nP0A+YmatJqGxjIqHBIgEgdIta41HFhZr5dCI0
	y5hNs/Vwvev5ptv9AtRjC0xLRYNNv2ZKDaQvPL68X42WRH1/Xo6X8K2brcuKju6unT0Mm5Zegtb
	asYm8+s/MMqsSsncsc97mvo9ZLWE+rOnR2SK1ayS58eRTdcWIDJ2LKzh8CuYVu0mpvO6Cwbwnep
	buqrACAJa2Vqm8uZVqXpjn0j25Ys3P1MpFGbjiTe+MnD3IHOqj9MFzMtsoVOb+YurJuy7JLbZzo
	WSAlprxNcUJXT+wePiB5+6gZvdMnrNlxC8FYpsw66u/5RxZW1zwPl9nik1A==
X-Google-Smtp-Source: AGHT+IF9cquSdypJfeGFkMNuDvqnMZBIPE0UMwUtySPIYLzqfHtCzThBrrR08RRJALy10j8mWr+zPQ==
X-Received: by 2002:a05:6000:430d:b0:3d5:319d:a972 with SMTP id ffacd0b85a97d-3d5319db843mr10217290f8f.9.1757063402287;
        Fri, 05 Sep 2025 02:10:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm135607395e9.0.2025.09.05.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:01 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/1] smp: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:09:53 +0200
Message-ID: <20250905090953.109082-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090953.109082-1-marco.crivellari@suse.com>
References: <20250905090953.109082-1-marco.crivellari@suse.com>
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
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..c3b93476d645 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1146,7 +1146,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
 		return -ENXIO;
 
-	queue_work_on(cpu, system_wq, &sscs.work);
+	queue_work_on(cpu, system_percpu_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
 	destroy_work_on_stack(&sscs.work);
 
-- 
2.51.0


