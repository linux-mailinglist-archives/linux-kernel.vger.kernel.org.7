Return-Path: <linux-kernel+bounces-884664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE4C30B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9A3424044
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109452EA754;
	Tue,  4 Nov 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ethg0iR2"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C32E8B8B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255550; cv=none; b=GzPn8rfZn60GkW6U7WEnCQGKOifHsMHZl61KHR+Z5tRmhin7aag/gLo24P/OE37FKJQsBJ3GF3+PKXDW2hTIKjgaiF1UKYgVyQs6+QfNzMpzunLiomUzGalPVqn8pcfLN+6wQ2VBeFH4B1CdUrwdiF0dJunXlyrZAG91id5BFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255550; c=relaxed/simple;
	bh=zWKlwVNm+/sMxBT6oj3FeSVj5qHQhcaixESKOMLw3Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+/bHnD+hLM6/5e7dGKp3OSTRXq6PrnsimMdjah2qDZ4lyoEKvKfFuvZ6m1FTIOBwb/2gb50II7NWN/MPzWpgrN43+SFUFBaaSwLV/ipgzRg/zFz+Ry0vt9ocTNNVtyEeGMBoiJNbRxZ3gneWPUT5Oeo531GfmH3z9THqyBbRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ethg0iR2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so3127540a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255545; x=1762860345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stYzH45VwWUKNAgerNUBsncouNNyJb4yUgnMDG8eTks=;
        b=Ethg0iR2k37uygb5OtTKzMWIc0LJqVsr0tqz/GsP702sAnD3jqWaeBG2C/8B5mvJ3z
         FRbYvwnUmXtR2H83ys6DRA3OtFqMgmyltWxd9sMqCFIH4vLiAprPkC2sdSiLhKPfkLaV
         +rmrH4qV5jFlKMCRDPe600i+CFT5Cus3bwMUdPLCQUsbC62+QBpnl5ygvInz0CI+106u
         7mAu5woUpYb0JVGk/neDSh11vWH/jkFPtk41oXXpRNsFVABeDLGpUIcFWMTrfPVU2scL
         oChj/LHZX/dTVPhhYtDwPsyeWuSVJe2AdRK4L/W+cVrlLB/hnifrVWljdpmuebU0SzZj
         SuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255545; x=1762860345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stYzH45VwWUKNAgerNUBsncouNNyJb4yUgnMDG8eTks=;
        b=frfaqhXBdvt8hzoC0WzRDhgx6fsC9xiiuE6aMhckq+3u+UBA7y2gQ2XkkFNL+O0s1d
         xnasHYcc5tamZBwjB1uuKDZKrJAUym9Of2LiDKk1LqqHkWwfaRXsxBRWQXWN6FbsPJzP
         el6Hh5ejki51gy0ZueLle9W/osOiafVnqVhkfahMOwosY4iZt01lpJsrLSTLss+oOrYA
         NFdS860Q7aSUREptejculilx+05Ix9HhhQYO2N9i9FS0V7q5gCUbMRUU6E8tes6ReNdQ
         6r+DMbcXbgx9izaq3zXTdddDllbEzGK3TopLB5yFiMAYPU7JrMI2xg2GdDP1yPZrSAH0
         lzlA==
X-Gm-Message-State: AOJu0YxVRfvx15WQdQfRyA39eogGYQiRtxG4Q7sdXOguUKqB89PR+HlK
	45pIs57YcsYa+2eVgM2tsAoqSe9TO7IlSTIl3HuCtEewTCdLGbijQDPpK07mEcAacTPbAxscyC+
	W/lHf
X-Gm-Gg: ASbGncvCF7FuqA5N1uguzDK1aZj46koQDbAZF6fbyQ70pngtFHhclUc3dswDLZSIhcm
	CA001eFFY8d1FfDpblmVteSseb+CUdrjPr7oxbC9WCjbxpbWAQ3+ZF8rPjBBkKo9ntv7mGQ3hpJ
	O9/xzEjefOZPCno+b6Fouzg+V9dGWlJk8azd9IpczDr29kIp5/bwC9bGz14ULs8Gx7FyTIY+zO1
	6UDyIfQ2N+BZSv8Rzahg+JTztJJh0MVT7Y9jNxT8ASYy8pXltjv8Iew9wvpxy0HvMekraMK643K
	K7eE5gnARM93m4i826VGpvNSA93FvxljxgtOSVnhw39yRGjSblQuI2SEZxv/YdAPSBO9syhG4od
	GjeVj7IMVDqeqfjsV784le4gwByoPYWXFOKmS5UQsn6kXzU1UCgIZOIUogYXVkFIy5llQ7HJn0H
	7tFXs=
X-Google-Smtp-Source: AGHT+IE6JQ2SIkOePpolRdtpQwBCWa1MbJb7n/XyJv+jCBR3fHY/bgWDSuf1lU4NTorSPgPC4CHpEw==
X-Received: by 2002:a17:907:1c17:b0:b50:a067:2d85 with SMTP id a640c23a62f3a-b7070137f35mr1576695566b.15.1762255545149;
        Tue, 04 Nov 2025 03:25:45 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:44 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvmet: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 12:25:26 +0100
Message-ID: <20251104112535.139450-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104112535.139450-1-marco.crivellari@suse.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
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

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/admin-cmd.c        | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3e378153a781..29281f410cc6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1604,7 +1604,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index bf01ec414c55..8f504bf891de 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -390,7 +390,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
-		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
 		goto complete;
 	}
-- 
2.51.1


