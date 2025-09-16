Return-Path: <linux-kernel+bounces-818147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE79B58D93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EF41BC5ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435327F75F;
	Tue, 16 Sep 2025 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPVEEEM"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC82EFDAF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998184; cv=none; b=suxXDIMIroA9T5nNpV2u3oZ+FsaIqpWH01FfKjMNEVKq8ghOeUbDUAKFsGYMzm9F1zPsFRSC0D25CqLrvMoBlJrGniju9A7CZoHpZ7qSWjnIKI1huglqpuokufKx4vWe16TvOJ5hLSZIZT1Ay1u4ZFICdTaGeADyZSYgHjg9FV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998184; c=relaxed/simple;
	bh=xZie7XPvdT38eYIBnvXACDOKlp4uDfFQ6p8xkwCAypA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6IXJI+zcwfkxQ/DmQKLR86ane/E37waNJtz8+/nnPhI7cnOm/djfvhFNlPlb9FiIjD2CZVRDXoHe3BfL+wSCB9+SQPVpOhifzTFeS6V+LXcL78BRhqwmiJGdodE6PbuiGNCKhb/0yO/vqS//rOYa5JeP77ucE6JM1VdD/nn6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPVEEEM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so3462534a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998181; x=1758602981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=VRPVEEEMyPFp1/apdgsdGcdVZa8RyIEDb4oi+MRkYBM99QFUqx8qesncXE5xPiXr4k
         5EmQzzVM6ROAy9MD5JQWOsyeqzNpcJOOfhDFpvyiLSBzgAVmSV4PpvkG7J3oLLXh3T2t
         aSGMxXUkZ/sTwLMVvwCxtrd/98Mzai0cB56bcT2QDXO9wehrl8U9zH9CWY9ycecU5qrW
         lgZghkMXBNPhiPB0dDJ7sUurWKQUnVaHBn61VqMU8sFvJRgf6DYXbUA1UPvggaPVkZ2/
         wEyAhf8NXX+w9nILAVNf9HZ/dItwjE6ImKe5EZYWjDrUvt9j68hAE0JwgxYdvG9auYLy
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998181; x=1758602981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=v1yGuVqN6gfVAcH0zfP1QPqdvcXyInBE4A+7ypyP/uF5hdYOkmemgitlusgalLcMpF
         7SKth9vrpU+7W9WKKWUXyDSnbKzQeg1deYJ24p+ewxFfnoCajXTI+/0oC187IKaggefG
         fJBFYyJ7gJaY3kbTIdAef4AKM7r1w/SgmE5+VQA4EnHlKh7Y9P4GQmwZN2wmNOSimojS
         gRB/F+ME6k8J2EBX1ecdn/6QYZGDdgj/hQAdZhHGnuJQjbpI7gF16/zCrww9upzr6xZx
         AAoLQXAc2U7IgTrDaAZp8j/heLiu2UgNZDMHDm0l50cgGGMWp98TAHoY8JarFdDl1fcZ
         cyzg==
X-Forwarded-Encrypted: i=1; AJvYcCXjjwFSwtW+ZNaM8J0QDu2fNxGLWWxPhQPsNLE+CYiSTllfWaiHWIYuyTbSFeMZoANleYY7tpbsJwxnu5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceHTWYVn+oyxbC6+y2sIRlDWEBMHvqS2SYf/FEt15Ss1AxEdb
	W+3e3Jf539nTZL7efxFNVf/qPEjsfveaOfyjq879nJoZJCJCQICa/wPaJbXw6tPUcoU=
X-Gm-Gg: ASbGncvMBc5DTd59KPPdeMWl1+ZjZNyf5oyyk2gVvgrFaWgWYnEplj1yluwwTw3MpYF
	KDnXYiHV+C4y44x+MxipAkER1pgNIORiILURjTNS+XnKFKEY9C+3Z9q8ZuL3G1ebajCROorQWP3
	/6YOEd3x7we9KnUhZk5uyNJ3W+SWZgnibUVsHgJDC4zOntGO0AxHDxojn5BMVDEIbdZunXqbZZ0
	gjInrQP240pnYWtNLr05A7/TLxzNJv0Mit09H6T3rnzwWMd+sn1KV4crnidG0jD5z7rD8sR1VQL
	FcIyS7wVLR/nyZZuenlEsDsXE7He52o2qo7gdB77kGI+b6jhP7d7XYuRig3UsyW4hetCUKPtfaO
	ayqcgNde5B1mHKjWAAHC1JiOFaphb8/+m7o7s9gQ=
X-Google-Smtp-Source: AGHT+IEk/DXYOCMhugqpymqTGh+KMlTQeAIuikssxOXlHLYZS5SBPJrXDrKkOxyomJ+DECodEM8EoQ==
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id d9443c01a7336-25d24cac4eemr191581215ad.6.1757998180587;
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 13/14] net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:34 +0800
Message-Id: <20250916044735.2316171-14-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
-- 
2.34.1


