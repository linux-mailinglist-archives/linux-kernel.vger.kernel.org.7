Return-Path: <linux-kernel+bounces-753942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7DB18A6A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC9A1C81581
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F008126BF7;
	Sat,  2 Aug 2025 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVBS+i8F"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34982139E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754101295; cv=none; b=dI4bNAf6wgci5vbGx0Tqor9WlMUGaRCwwlhBYjv721H3oxRFSfG9DCrIbWYk6eddInXWKQy8uYlKED0jCZYqJdiB5t7mv65Lbl3eL0axhfaMbwVo7f9T6jpB8T4X2YrXISCARgpswD2qpDc/dFttNh8iUkaHA10eKZmz/omsuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754101295; c=relaxed/simple;
	bh=uciT3hUkvQO+20Zzo8rFarDrec0lPSiUtZ0hz3pIRcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgQ16QsTrvXzQRy8sKfT/8b5fywket0J3FbeHTaA14CckGPGHKHX6vd801rLrnwbam2n9dzOExB1v3OigMuS2mYrEKkwUORlPks2duV/X2qDp8giJcfw26xepfY4X8EHy4orlNoE3KL5PFPEcEcgFcHLgsQio3AKWiOjNfgFiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVBS+i8F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23ffdea3575so11089335ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754101293; x=1754706093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FHNcjvjUaDiUoXdxQ1BX0pHx22fMo7G8NiKAuGEvpw=;
        b=ZVBS+i8FKg/C85ujYWgLWp4mF4ZuTFI2feJqp8sjj3tYemaJ6T52yIe3qTYKvO81tl
         8N2Mwsi/aQ/n1HMH5CKz3w5t4pWJzjS0accp1maaN2Kb9ogGf0gGZAYMOggcygCMRQcE
         o95rkg4WmAAC5KkZKPu2WHisu7CPIgG2/nca9u4e1sjwXx2LdPUjaVA04E1BqEClw6fQ
         nsBhUC5TKlC4G3b/JeUd0OkfLFf42qWw1XRyR+9mmLBifjyNx36Si9h9TUAeEknkCbzh
         yk/LSc1K6xqCYDD/iPRK/SftvRZobPIMsf3E9PogpXVxMU9CXfEniYXLRlVqUkRhvGkd
         wWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754101293; x=1754706093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FHNcjvjUaDiUoXdxQ1BX0pHx22fMo7G8NiKAuGEvpw=;
        b=QhomE3lv/PlIwXsgWA2XseL/l9HvQi6HbkYyT59aZRudgvnYEUYDP8Erf2Bcl2hfIW
         8y3bTphWtge4OrCXu2l7Vb78bzQ7OepLcUxXQcyBHdM8YeZrdk5wdxWbnxwhPbxp8yYp
         E02yTZo2kS5GR1gZt7Kdk3rA25B9LV0foMzJ70K/5NCh/L/Y3WwG82xtNbOoAIKvISye
         I3f0dszkgoMePAufrV4FESMpJ0wD4InFzNuTgyBZSLujVjPoXPHOYUXreix9q2d5oiwY
         tZtcVwMb8u2Hsj+rv/oUzx1US6VrPG/ykZisj9tqIjBTb5WPQXBnIIbMDekIbZtcZ90S
         WrSA==
X-Forwarded-Encrypted: i=1; AJvYcCUDuScg6zwUXkzMS5DeVa7gR5zBUKpLkhhwSeD7n/815NOJseZau3KZRSljCfC0QLiOKEeSc6sus8l5gvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5w0elWiC4JwJ43lD8ylg7T+0XUP/AgWaJc3wEuWWMNFzuVjUd
	GG48sPs7Knlg73B3EhA2TN0uUyxuTtQqgRAuo7NNv4UXcbUuclb8nhUu
X-Gm-Gg: ASbGncu0PgSKCM4F3GiYXcGlfrpdpHvcSHINpM+hexyZvqAYfSwVQ9fdruIYsBRPVWv
	+20mrEuKhhEub5s3DUr2ebiU7Pk4YrGQjhxrf8aM93Bd3vo4WmKz1UhBhGJPyhiTMfRyRKIGfgR
	jIjHy61VbO5dnvs7+0zVjO4fDVmT4/RBF+o7jO8pIloknQRCEuSKUbawZc1lbdvvzfsgnuqIydE
	0+gxgAKiJ0JlmxjFs0mH66nCXv736Emf2CiTlUOuGLeM3fDFmWBiycKHD2oPIMJJKg8Vo175xVc
	9qvUSlUDt5vQJUR12YywjeeQoJmK1gpqhyARS6urbQZFvblc3Uc3yE0K72Pt1sjZdeUw0BcFGGw
	V9+vI+uzc2s7uVkL+J72KmsyFfExbvcPVRz18I43F/463aHzxDMJ+faVTrTQybwWP
X-Google-Smtp-Source: AGHT+IE2VbInvpX4DE8EswMfzj2WuL8i7hGqPDeBpiZqmTY7or6ptL6iMkBEQS9+mTYvAadcBCY1WQ==
X-Received: by 2002:a17:902:f549:b0:234:d431:ec6e with SMTP id d9443c01a7336-24246f595dfmr21784325ad.3.1754101293319;
        Fri, 01 Aug 2025 19:21:33 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ac8cb6sm54623275ad.192.2025.08.01.19.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 19:21:32 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	Liam.Howlett@Oracle.com,
	viro@zeniv.linux.org.uk
Cc: joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Date: Sat,  2 Aug 2025 10:21:23 +0800
Message-Id: <20250802022123.3536934-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

__task_pid_nr_ns
        ns = task_active_pid_ns(current);
        pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
                if (pid && ns->level <= pid->level) {

Sometimes null is returned for task_active_pid_ns. Then it will trigger kernel panic in pid_nr_ns.

For example:
	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
	Mem abort info:
	ESR = 0x0000000096000007
	EC = 0x25: DABT (current EL), IL = 32 bits
	SET = 0, FnV = 0
	EA = 0, S1PTW = 0
	FSC = 0x07: level 3 translation fault
	Data abort info:
	ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
	CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	user pgtable: 4k pages, 39-bit VAs, pgdp=00000002175aa000
	[0000000000000058] pgd=08000002175ab003, p4d=08000002175ab003, pud=08000002175ab003, pmd=08000002175be003, pte=0000000000000000
	pstate: 834000c5 (Nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
	pc : __task_pid_nr_ns+0x74/0xd0
	lr : __task_pid_nr_ns+0x24/0xd0
	sp : ffffffc08001bd10
	x29: ffffffc08001bd10 x28: ffffffd4422b2000 x27: 0000000000000001
	x26: ffffffd442821168 x25: ffffffd442821000 x24: 00000f89492eab31
	x23: 00000000000000c0 x22: ffffff806f5693c0 x21: ffffff806f5693c0
	x20: 0000000000000001 x19: 0000000000000000 x18: 0000000000000000
	x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 00000000023a1adc
	x14: 0000000000000003 x13: 00000000007ef6d8 x12: 001167c391c78800
	x11: 00ffffffffffffff x10: 0000000000000000 x9 : 0000000000000001
	x8 : ffffff80816fa3c0 x7 : 0000000000000000 x6 : 49534d702d535449
	x5 : ffffffc080c4c2c0 x4 : ffffffd43ee128c8 x3 : ffffffd43ee124dc
	x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff806f5693c0
	Call trace:
	__task_pid_nr_ns+0x74/0xd0
	...
	__handle_irq_event_percpu+0xd4/0x284
	handle_irq_event+0x48/0xb0
	handle_fasteoi_irq+0x160/0x2d8
	generic_handle_domain_irq+0x44/0x60
	gic_handle_irq+0x4c/0x114
	call_on_irq_stack+0x3c/0x74
	do_interrupt_handler+0x4c/0x84
	el1_interrupt+0x34/0x58
	el1h_64_irq_handler+0x18/0x24
	el1h_64_irq+0x68/0x6c
	account_kernel_stack+0x60/0x144
	exit_task_stack_account+0x1c/0x80
	do_exit+0x7e4/0xaf8
	...
	get_signal+0x7bc/0x8d8
	do_notify_resume+0x128/0x828
	el0_svc+0x6c/0x70
	el0t_64_sync_handler+0x68/0xbc
	el0t_64_sync+0x1a8/0x1ac
	Code: 35fffe54 911a02a8 f9400108 b4000128 (b9405a69)
	---[ end trace 0000000000000000 ]---
	Kernel panic - not syncing: Oops: Fatal exception in interrupt

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index c45a28c16cd2..14e908f2f0cb 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -491,7 +491,7 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
 	struct upid *upid;
 	pid_t nr = 0;
 
-	if (pid && ns->level <= pid->level) {
+	if (pid && ns && ns->level <= pid->level) {
 		upid = &pid->numbers[ns->level];
 		if (upid->ns == ns)
 			nr = upid->nr;
-- 
2.34.1


