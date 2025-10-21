Return-Path: <linux-kernel+bounces-863514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DFBF8075
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A292E408286
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0B35028A;
	Tue, 21 Oct 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZgZdRXf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B61355815
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070473; cv=none; b=XUNuUREXLMJ2YI9dAm3FaDrrP87N2N6y/2EonZq6rBaFzbQ9oYZsSzhLTGORhDFRKNlHXgkikUj9I9U2PuFakFqOf9xdcfloVgpxMo4JP54zpbR1PpygctcgbzE97pCzOrJecGJoSHBCNb6Jgl3fzGNnYFDGA+wzand2Tngek9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070473; c=relaxed/simple;
	bh=o9rNbSpNBoVUUMGd/35JWT2yVORpEzqBAt8IfqSL+OM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=N2riHX2fLfbMve/9v7GctrrQgdF42Y+Ja55vsycm30JwGeFYwmT1Hgn1LtZ5b/yHVSJxifWHfekEmr5hJhOHVbHHE/aIEfdf1bj67Zls2NXCX972XZRXoUPj0cn/+7loyW32+rRkq0t3bVLTCRvANp543C/lcB6+6qnL1/o2pMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZgZdRXf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47106fc51faso70103345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761070470; x=1761675270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=itonLB/q/YNj/+GW+x4yL234j0gIzsFzNZWWY3KjRnM=;
        b=AZgZdRXfCGNjnn4d2/o8GMrApTfxRf3NDmaAE23wvoDDE9Bax+0P9Jvxx4ctLAxvS0
         djzG8OyFWemnGl6TIUr6dhm53OfflMURZhAPqMc51LH9zXWse8VBh17jh+QwT8JNs/bd
         ugLNYddyBmRRZ6fZYD9thWf/5RDoRc7X4s0s4d+McqXYtxg/dIvmUSYG/xvjWy/FsOYu
         gq6FM5ftW+3SWUfE7ri6TA4E2FPRlQKld1y3I0dbw8NRrY3VZG+JHlOvFVbgc0BU1InU
         KvtiON98N/JB32Y9Z1/o/Ll6HK3ZyxaTyas3cs4tlDp6JaR7DKDW+xqrSlEoXPPjTJWF
         OV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070470; x=1761675270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itonLB/q/YNj/+GW+x4yL234j0gIzsFzNZWWY3KjRnM=;
        b=VJCoSNO/LEdfkDkYFjGC0XPKXjfiqU5gWPzDbH42tINPIri335rqT0UM+tdq1JuA39
         SiMMfrr9NPOtIHBsYDcGBxT+7dNJc13ujDVDge+zUvKzTmrYrCzcPPSBMTnHBOLjiqyH
         5WY4x04KXyD6BU9OjeFQdVQiGQpBq9mzN9knliYVHHbl+IK/5WJHlt7bbRMDKdbiegDK
         9YmXyuTFoAWdOMkXjctjHgUA1mlMFGsp0BN2xOfPLqw8MtuN9I2OEfWzU96NhVEVZHh0
         uD+4JHEUz8nD+UmuKbjX7Rm0pJIlwpp8Fy9anJVg9MKNerDyJQ24WOn8DCR64/VpYE8p
         tY3A==
X-Forwarded-Encrypted: i=1; AJvYcCUIWZ8lAvxICeoTh5ldvuDTIv3AhJ/kkA5umut0b4/Y0QGd096fbdl+L7/1bjs59tWHegVyqfx0j6vUviA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKhqBrDcxtWHx0/aFRfKKa/ikZduKY7h9vbDQmFiuznLkR9R8
	5Djsnwpcf9hTr2/g96gxavEkOtKxaKskcN9FawWQ1DgWegRYwcnbWnTy
X-Gm-Gg: ASbGncuLWF4Wqf5967tpyl4BnLJ/bAYzEyvA1pH+ew2RYcNB831U8Ij2xT26MZt6xYs
	dc+MaFeBvUfiOyJIsJa72MwNtwAvTUczdOcydkteUtgQWEY3KMBv24es+ctBR5sivCoRtYgR/S3
	dZTFdlJbp98Ee7H+Ba0IjVsZMJCtyyk9tqinGmFNBSVChqg4+HbYNqsRpq2+qArFoAeEXhJj070
	J0/VTBvG16/5E/0O4IRoYSUrsfrA6896XATpkDaGx5mRAHxsTpR7HF9X4AvIzEwqex2lIDYs8Y9
	1PnZRNtvIO8gxiuAh+J/EREwuZOboACt0dK42xOatnIcSQDeNgQpGbJ7o/GBo7+bBmEOChAzhQy
	sn/bSbKI4VgMqVNLwSMV0V4IcL8wiZXnfv8UKvJYodwXW6ISluR3eqg89ocjKcPuvmANnuwXqHd
	5puVoXEO3I1SoyMbveHbMoL8ZCij2ipjqXNKn64d+2
X-Google-Smtp-Source: AGHT+IGxG8umXjHtMY/AKkPJqS0tl8j3kkDrEFb8xVPLNpxauF5mV6ALBrumlAi1xAT02B74F8Hj3Q==
X-Received: by 2002:a05:600c:3541:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-47117917452mr138852985e9.28.1761070469513;
        Tue, 21 Oct 2025 11:14:29 -0700 (PDT)
Received: from localhost (85-250-87-71.bb.netvision.net.il. [85.250.87.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428e9b2sm4313505e9.5.2025.10.21.11.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:14:29 -0700 (PDT)
From: Vlad Kulikov <vlad.kulikov.c@gmail.com>
X-Google-Original-From: Vlad Kulikov <vlad_kulikov_c@pm.me>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	David Hildenbrand <david@redhat.com>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Vlad Kulikov <vlad_kulikov_c@pm.me>,
	Ma Wupeng <mawupeng1@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ipc: create_ipc_ns: drop mqueue mount on sysctl setup failure
Date: Tue, 21 Oct 2025 21:13:39 +0300
Message-Id: <20251021181341.670297-1-vlad_kulikov_c@pm.me>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If setup_mq_sysctls(ns) fails after mq_init_ns(ns) succeeds, the error
path skipped releasing the internal kernel mqueue mount kept in
ns->mq_mnt. That leaves the vfsmount/superblock referenced until final
namespace teardown, i.e. a resource leak on this rare failure edge.

Unwind it by calling mntput(ns->mq_mnt) before dropping user_ns and
freeing the IPC namespace. This mirrors the normal ordering used in
free_ipc_ns().

Signed-off-by: Vlad Kulikov <vlad_kulikov_c@pm.me>
---
 ipc/namespace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 59b12fcb40bd..cf62d11a09b9 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -75,10 +75,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	err = -ENOMEM;
 	if (!setup_mq_sysctls(ns))
-		goto fail_put;
+		goto fail_mq_mount;
 
 	if (!setup_ipc_sysctls(ns))
-		goto fail_mq;
+		goto fail_mq_sysctls;
 
 	err = msg_init_ns(ns);
 	if (err)
@@ -92,9 +92,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 fail_ipc:
 	retire_ipc_sysctls(ns);
-fail_mq:
+fail_mq_sysctls:
 	retire_mq_sysctls(ns);
-
+fail_mq_mount:
+	mntput(ns->mq_mnt);
 fail_put:
 	put_user_ns(ns->user_ns);
 	ns_common_free(ns);
-- 
2.32.0


