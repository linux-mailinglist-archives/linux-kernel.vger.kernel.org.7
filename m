Return-Path: <linux-kernel+bounces-889050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F79C3C87D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6C4E35250F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319FB339B3B;
	Thu,  6 Nov 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IusIFD+P"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1562494FF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447367; cv=none; b=eV05yWH+bvnx9w1FpPl5QuirxfIoxH7ama0ToWxjBcLFZqKM3Bw+WAbNPswQBQHAsW1PvMPAeGQJRpMAX5Sbnww565yPq6i+wGxZQ4NxB2r2Gcems5hmoe+ss2SmFfvmhD4cXOGOL0mUvHzxWTSMOM4uLdkI1GvqIK8utgQ9vMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447367; c=relaxed/simple;
	bh=dWua4jrZl0r37ywkIwIo1mbydYSjyvb6Mj4LORQIgS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qE2bVaIRgCW16h83GoVPit/rfk2J9D51eb+L1xwF6zf90MayJbrw62mp5x9jlXEk2H9tIHHSDPzjSQfkno2SF5dF50nBsHfXGfvw04j+oOy27w/S2ZPj2HYKn4IX8sZl/3zanZ3PK0mOWcx1DmA7TjN3OPEBjlSDbJObGfolHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IusIFD+P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so7158965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762447363; x=1763052163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bWVfG3C8DSuF6D5kXiUtuvNzIgvYK/pa4hX5McjgVk=;
        b=IusIFD+P84syu65y/9cYP/jr+NUA/whUPyzdEWdNhCY4ydeduGTGcWsrLolUSFBbbh
         Nywa2anM0hvGkjv9PIjvcAM4D+/CkU0/1QotZ41j/PDg4YhZENQe644MNSOiU6JXrdNQ
         LF/csdbGrRGcgUbyTkXzUPD9b6VPhT3+hlt6U+/7e9/mpc7c+XUtV/oX9MeJwU53hmv/
         hcWFtI+SExtBED/G0uEr8wvAa8YsqWVNioEeUJO6NXThC2zJMoYQmK0T/7VLZS7wOcMq
         cGXFET/Y1C8HTN3AzR0mFvu6SPZXIBLTu/vI6gdQkzmRc/mg4OiiPg/Mnh16J1srlJ9B
         jSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447363; x=1763052163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bWVfG3C8DSuF6D5kXiUtuvNzIgvYK/pa4hX5McjgVk=;
        b=hlm9dFa6ZEuqYwz7R/skw/qj0UNqo6bOu/IDWeCiCB6THd/0WH3Rr4EcKz9xtjTcMJ
         miwiDNO2ezyb6H2WPogupWf2vgpVDMzksM3H75Ik0QVIUfwkOoje8150kb/46VLzaBcC
         JbZEUhGAEOsgrixr7QcUZoT0jLjOn17sQ8Ck45IxSNcWFSlbaLgHQq2pwVp32Ugkonok
         w2VDUu/87VcPkLD6UV4FtI14rNpt+HZrrHVnihIm7ocXsDhgBJ18+oJLBmpiDmOYE/2B
         dxP4Ngee4gyY6PSHA0MIMwaUmbpT+XtbxKpH1JoZkiilCAaakIR7lBiD1RSoWTUIq24c
         MBWQ==
X-Gm-Message-State: AOJu0YyqzXSQY7E5fZdZzobFJ97aqKfToTtm7ir1P4CwCZl25AtCeAKX
	YNXSaKAL6Tx5jlQrFdf/L8EBwOtkKoWCwji4cbjQvGcCZv3A1p6Y0QwEw7bV2SzYJI9nk3UpNpH
	gULuc
X-Gm-Gg: ASbGncvG6jTZayKyuV7ZBtHxRMyypkrZxeEPl1CQ6rb3ccvzq6aAlXjR6ErPyzV0lTa
	36GDRlm6pJRa4b9ODaNe7SL1R0SDfx/4ontMw0GmcIFuZ86Ge4tC7YSz2TUprjNTGnYHfyPrp8I
	I/GLfVhhAeUuT/mikTnjL9TVu3sr+pzlEYEwavp9AmJyHxuigkWrFZMGUWzUHrdpc/dQP/A3H2l
	tjOcwLXbYmqrrCPLMLaj0rJqOYbtTDPgNNpomR6x6vFuZTb/6PpGgKQBA00e3lXMqSGIFNBC/Jh
	EY5VK2iyjigq1pog70aLejns3AHP/70X5s1IOhHV5LCGs8aLReIx5qw3Ys5BSIi626fGLNBpPNZ
	UlA85ePFM7QqjLfjhGk5CMp4vv52glGfSSl/YAU6vSGXtPq3xwQ1q93XNppcU7E/S85A0xaaDof
	3H7aXCIl09UnO13SJd3aUUUqQFAG9it6B1Aw==
X-Google-Smtp-Source: AGHT+IF+PBs1j5FzTL4nTtbZy9S8jQx0oyM0Yw6fciG0T5QoS4kG8UPHtVSxZJs1keD6X3tfzWTt3w==
X-Received: by 2002:a05:600c:8216:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-4775ce20dcemr92100835e9.34.1762447363317;
        Thu, 06 Nov 2025 08:42:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b28asm75115f8f.6.2025.11.06.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:42:42 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH] crypto: cavium/nitrox - add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:42:36 +0100
Message-ID: <20251106164236.344954-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/crypto/cavium/nitrox/nitrox_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_mbx.c b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
index d4e06999af9b..a6a76e50ba84 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_mbx.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
@@ -192,7 +192,7 @@ int nitrox_mbox_init(struct nitrox_device *ndev)
 	}
 
 	/* allocate pf2vf response workqueue */
-	ndev->iov.pf2vf_wq = alloc_workqueue("nitrox_pf2vf", 0, 0);
+	ndev->iov.pf2vf_wq = alloc_workqueue("nitrox_pf2vf", WQ_PERCPU, 0);
 	if (!ndev->iov.pf2vf_wq) {
 		kfree(ndev->iov.vfdev);
 		ndev->iov.vfdev = NULL;
-- 
2.51.1


