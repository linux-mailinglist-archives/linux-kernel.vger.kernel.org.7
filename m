Return-Path: <linux-kernel+bounces-873328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18AC13B10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991934065DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9759A2E613B;
	Tue, 28 Oct 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ja3p/cwu"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9112E6CDE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642268; cv=none; b=vD3D9dknxwpHN6BpxVOA7iybP1FunFemZrZOP6v2DgIR+EuVK9bYkRrqVSnghWf0spZ5fh0OMWzQjhY8grGcjd9Iw84STHVLhTFG/zr6ZbDgD2QvTqaF+2iF0k1APZLrCvNbN44ieLt7MKOOPume5iqXLi1XzllFaZ5GzQFfEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642268; c=relaxed/simple;
	bh=ArfTrKrv8Ysh1doytRjr7MtYumzy/kUaptVBDhO+T9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8dfcySzSp7/8/ayFnojOTzXFDbolSSFe1mrqvnq4YGtIlvd9TiWtsT+JJqkYu22LqImU/CDRJihxvAutAnXdIFhUtu9S/4NyiIU6Y7qwwVu5UW9d4+skhJ8XX6cpZXHfQxJJxnqbSHKazaTgH3cDxZcs1u01hwG9A+v8MORzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ja3p/cwu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5445189a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761642264; x=1762247064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCk37IL9TNEuJu99+/BU8pgLYMu1/hhqDZOHWWgs03Y=;
        b=ja3p/cwuqGQABscdEWeHDvrV5cx2tZRMe4p5giaOwzDdOc9yIIcgCSnX/EGhZMupeL
         JC8IA1DKmPf8B2ewe1QUMP3kN78bwd+LxILMfh008aFDb804xK/N0T5YtsTVfvbYks7W
         jPg0WgSDKuyaGUJdNT5/os+0yPvhbWYkACPu05RLnSvidYIqINOjpTdrx//rpX9xnpqQ
         iHez+/8zOMygjkp4vt0PuDaJ3d03RHK7X/tMM+q50F6MujJB/dobbl6ICiL3BQRO+p/6
         9a78rJ50jANObpfdLApBtiepVx65VyK7SRaLUvHGUTiZ/7iRNm7ytqWkF4Bosv5RqU0p
         ESNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642264; x=1762247064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCk37IL9TNEuJu99+/BU8pgLYMu1/hhqDZOHWWgs03Y=;
        b=M90Gwedl8X4Te6cL49BoRs+qfiArW1dWMviJEcfhviiIu+Ly2zBZhlvMKnBX13RgSu
         49CwTcI7Peh1iD79eNhgeRtRywK4TeB+CWCMUALkr+I0Rk0SfKzHfSOPri4ec+90Lk/R
         JAWr19JJjVWau5PvKQyC92Q2iyIRPTTxZ/YXpMnt/HpDrna2Npz0ChqeKH2BJtJX7WDv
         zyYVbQ4mixHnbgZUmiz/VLPl0yAUrBHJbbnfUnPawhJk8inOTghy7RciLHf6UaZIMSsf
         /zp0w1cMvaVazHIqn96T5QXQNYch8ifCPFbfePTjh13dATXYFR3NF/+ZjOLR9SGfMgTE
         4qgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1nBd7GkhBA9w1c03UKTJtST+NxdNr6iAPmqwp47pJBMKw1NukVHZSs2ayzeU+4O/HCHltGmt2c3iK914=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGHoDj0EiXtyk/yWcD8/AJ7wjNnQjS0qKZrivhfJJJnuCP1BQ
	jRG8z+fwqebCH4ecERLIRiEItPJJmbS9IKl2qstKZB/ae/2UL8tGZ78AK758P5BQBKs=
X-Gm-Gg: ASbGncuQVvCC15MKRZULVh1n+3b2b3+I/IGvDovtCBqZ8E8VoFTujOdUXVi6cdl7zeX
	GTpfLn8EABhbZSHd/B9vfVMdVxXA62Fh8KMfzy19vDbS9r38LOjJWYLDuGat9UQT4qqEV/J7FnD
	0/HeQrKpzIaeZ79dNMUaYgrQ/SK/odyjs0EG4PayPk0MVJZ45D8/xWRkrJiXVkEbi/3LtknVQYa
	nI//H+XsOuHD8uJwfqi9n16jb1qfvVpLvAmvSHzZmSrZYKBoLGPnJsJ3yXxC1Y0LfjdXfR0/7dH
	j5N3dUCLs+yxTUzGFaXWj0IReyMCxH2BKOzCsO9+qZU4CNk18bpRkiiyyXNPCieomN3pgbZO89S
	xh6CBUDAvuGNNNd+JaZU+9edDkryWaRs4b2DWf/ueHQFBhrnzzePpyyRYdtzNW03FUvF1JDZ845
	CGdmuuHXHrptvQ+VStNN+9BerThXPc9ZVNTdSUXzoo
X-Google-Smtp-Source: AGHT+IE0x8+gQC0CyX0cFdRTYzDWc7QN1yKT32zNylaVLGljr2NqwohXZstVtLf5ZgNGVymFFXxzGg==
X-Received: by 2002:a17:90b:3b41:b0:338:3cea:6089 with SMTP id 98e67ed59e1d1-34027a09d5emr3049018a91.14.1761642264277;
        Tue, 28 Oct 2025 02:04:24 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34028fe80c5sm914996a91.0.2025.10.28.02.04.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 02:04:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] genirq/proc: fix race in show_irq_affinity()
Date: Tue, 28 Oct 2025 17:04:08 +0800
Message-ID: <20251028090408.76331-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reading /proc/irq/N/smp_affinity* races with irq_set_affinity() and
irq_move_masked_irq(), leading to old or torn output for users.

We hit a real-world issue: after a user writes a new CPU mask to
/proc/irq/N/affinity*, the syscall returns success, yet a subsequent
read of the same file immediately returns a value different from
what was just written—much to the user’s surprise. Root-causing
showed that a race between show_irq_affinity() and
irq_move_masked_irq() lets the read observe a transient, inconsistent
affinity mask. struct irq_desc is supposed to be accessed under the
desc->lock, it seems that show_irq_affinity() forgets that, so fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/irq/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8e29809de38d..d8979d46abbd 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -48,6 +48,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
 	struct irq_desc *desc = irq_to_desc((long)m->private);
 	const struct cpumask *mask;
 
+	guard(raw_spinlock_irq)(&desc->lock);
+
 	switch (type) {
 	case AFFINITY:
 	case AFFINITY_LIST:
-- 
2.20.1


