Return-Path: <linux-kernel+bounces-800197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D3B43475
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D85617E2CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287E2BDC04;
	Thu,  4 Sep 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z4Xa4pAU"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6E1F4168
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971940; cv=none; b=ojoJARs6jZV03UAZ1MrOPQ6zjbZxkbTsC1VU46rkTzpNh+2HRPSvvIFUPtWTji+T6xDfdl6Uw3WYM13d5mkaFALCc84xpQE6B9t+4IorKWkla2EwlCo7JXn9lzFzNr9YbLc0DTsjJjLp7LM6XZ9Gjc8faj1+rhPQO/y3W1lfY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971940; c=relaxed/simple;
	bh=5nFDk4DbTwcgq+XQd78fBU7KRHI5oBKv+saUZCFwnJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLIF39EDFAopZuDkiieVCQhcTUV8J9txGbhmuqQQTaEGuiFitTTui50fa4GyI++SFq95QBgxta43574E/Y8W5yBy2B5Qi86Ww3q6Qfxt6M3dZcY6vvkFHp9vgkSXXfA5biENNnRbXB6ewmc2ujias+aULoevrcf7yOAxy8anKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z4Xa4pAU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c784130e6so9209825ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756971938; x=1757576738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpvqQaG8R1IN33CKrxppIpzXm6RtItfoOaI+A85lf/E=;
        b=Z4Xa4pAUCGAdVYyEF6n/ojA0TbNdfxrgKTw3/mG122zEKYvjsto8InKhnIcmUYOD5k
         2YqxemIZ81GUQmg0GP6IB7r5QyPLDXBGIJWvlvCnOpf/AIebKACKOYYSiEgqQ0jLNapX
         KRJmKaYM6LADZmlL9ZWXPNlFhJXvJzd2KwNt6brWwGpLS7/9OLRTl29Rv/PmPWt9rJnH
         w1cb5F6rk0kSFn5/NhkozvRPFfbnNfj/WgTJw3QEApp1ZfD3/ZbxaMAMMeTQXkuBdIgT
         qqJMAA6ot2/nAJKIWYHU4h+Oyuyguxn/jX+Wzn0e9LkGbq701JTjfpG7jGa3h/mTaALN
         hA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756971938; x=1757576738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpvqQaG8R1IN33CKrxppIpzXm6RtItfoOaI+A85lf/E=;
        b=pl39i6ewKQnxxYBlK7oE3Ujux9Vkv+xcN+LFf0ByP289NTdpV7g+XKQcYx8khfegc3
         ARhKXvAlKO6EcWMDwGQpq9/2oi5MoHetrSpIChhAjPDK5XCs5862whQ7gTkql0yRrmc9
         Xt4Ir4PJiw0lPduXyZtvU7zgIvHe8grzyRhLLqUVqjOvQ6JZAFeY5tUt8FvX+2c0nqzr
         t9hh/168N7z9umz/LZdPzuHUboHyjS8kXeIghY7kalJZf+XGyFiZik4myXMGnP4U1q7i
         eQKETPLSRc2OdWDWgGwWawn5MKnno8/8EjTCNrJpnqgiB/CKpbstJWL1jyETonXQQb9g
         48Kg==
X-Gm-Message-State: AOJu0Yxu7oBtxBpTdAwwp79a5aq5146zvqPu9tsyChYdxzFPrWBVf6RG
	nADZgm0nBWvm9er7Woh3RbYZmB5yGm4DyqOjbu0DK2N+EfMMkbQolWSucIdVey8dGCM=
X-Gm-Gg: ASbGncusy75VfQrHt86xJBXCKDjDdHVrCooq1B1Gx/ZyeiR2qKZkHI1iwF5+dnG6mO4
	3RmGtOAoqq5jkrXWWI1ud/cftooBVS/zfVq7krbvkUd7XKCn5znn61SfMvdv2asLcS2pRvEzzbK
	zFfXGtmKmuurPdrD2t807lo4MJa7cBxKipxsloPC5hTamX7ZvyJbqXK8ndbUaPEC9socihQkQ3P
	aDVbGqjwfLf4biBDXG5Wbo91lA9+mUQuaJrzaDWaBG/zUJ/36sTm8gj6xHGBPZBoL+iA8667CEq
	/tyKU2r917JO3WXjp+JW7Btk6836VhL629uoq2ZKgWZolh7QMvTjCfP064Fy2Wu9E4UkP2te/bJ
	yV+3FGEPhD9Abl0H8lsQ1OiKhnUsNZhYXCI1zEzrIBu90I9E=
X-Google-Smtp-Source: AGHT+IGZkPhRsNIMH2vOWSfd3g5Lg2fCbRTC9WjNY0j63FcCsXFBdRas5jvKguJfXwUwCjDAAc8LGA==
X-Received: by 2002:a17:903:2304:b0:24c:99bd:52bb with SMTP id d9443c01a7336-24c99bd54a9mr55776135ad.30.1756971938008;
        Thu, 04 Sep 2025 00:45:38 -0700 (PDT)
Received: from n37-019-243.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f7492d8sm63504395ad.129.2025.09.04.00.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:45:37 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	longman@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 1/3] cpuset: Don't always flush cpuset_migrate_mm_wq in cpuset_write_resmask
Date: Thu,  4 Sep 2025 15:45:03 +0800
Message-Id: <20250904074505.1722678-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is unnecessary to always wait for the flush operation of
cpuset_migrate_mm_wq to complete in cpuset_write_resmask, as modifying
cpuset.cpus or cpuset.exclusive does not trigger mm migrations. The
flush_workqueue can be executed only when cpuset.mems is modified.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675d..3d8492581c8c4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3256,7 +3256,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
-	flush_workqueue(cpuset_migrate_mm_wq);
+	if (of_cft(of)->private == FILE_MEMLIST)
+		flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
 
-- 
2.20.1


