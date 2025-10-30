Return-Path: <linux-kernel+bounces-877501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942ABC1E46D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908C13BA859
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63459293C4E;
	Thu, 30 Oct 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOCZ9BxT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC62243376
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796292; cv=none; b=I8qA42vCoCricCwlvW+LFBNgo4By0vy1+lVEe2BDPsc25opeO43bvTqNOhB1moNaK8X8pgtI4iaiElDyzBmryl6p+swcjzxJ6Iyyb5j/6SUC2HZib8YV/BwYMyKIc7emBQe1MZ+TfLa3tgnszGaF/l7s7thSdzZKIeseQriyiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796292; c=relaxed/simple;
	bh=pBeeBWRYeKafQMod5bIA+zGCastuNewJmZBzcV88qr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV+f2EwNFRlMWcE6IvMFSBXvJXQr9nyeoey1/KzN6nXAshhS0kXoTR3pSOkQLrsSfHHkNz0jSTAxNEz1HAXWKxcrL2gXI1zFboGMb3ygmsr7pc3/VA+qeRVwTq5FNdpyhApjtgy784ua6Az2D3DZ3OJ3ZBf+dxj+5YCMCYgRorc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOCZ9BxT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-292fd52d527so5430705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796290; x=1762401090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV4KJ/itlJFLRca3pmyjvPn6JyCSXSOLPe2auNiZSzY=;
        b=ZOCZ9BxTpiznMXLHAKsI7TMLdtdrs6ishH7KzubxOBRJoYP0s2B78O0ErgJ6iGlXgz
         N6VvlndPY1FJPO2hPuoMZwZV3keEh7GFpJFEuMHWrUz96+wdiKEMgQIaohtTUzpYETjz
         w44/YbGG46M8snPKpLIPPuv5nWhoewKjO7CSyyKuH3RYOx9ZDfQAykEVEdqnMJiUO26X
         l20dO8IePKmvHbGiKS8QjGZThmy4tDCTq32CU4xTSHTL4diZTubsxOPxIF5NbT0MMxQt
         9TXnPeGaaw4CuBporcAzJowOOfn0aB+e66JJa4YxHCcOEzUprjupPBzi6cXnwubWrf1U
         SXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796290; x=1762401090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV4KJ/itlJFLRca3pmyjvPn6JyCSXSOLPe2auNiZSzY=;
        b=Uxv4JzgZm1jPcgFJxUnP6iwB0FcoS6M/Ru+O/8ViL4nKBxckJCOv3ha/RzNc4GhCDb
         CHCUkivQHX3vq4mV7kU7eGQSed9D7YklzJ4++6yLeZEU8aZVuTzpyH7jIUo0/GFIG6J0
         OBTwXTGWiyvzuPjx4w2dxd/4b3p0oBZPCLc8NzKd7hVtEq3q/2XbjS4Y5I7DFBU4V+MI
         B4cYCXTOzvrUR5J5jmWAYnDp6T4wW9c/+esAborjZ+6f2uZkAMAGZ6FLv66Cvx5TyUzQ
         y7AL/SSgREVhF+Y4QEKm797EBx6Z2Ih7pPVgeq/CNXzjhhI/02bIaaBAlzlUC0RM2XeQ
         19pw==
X-Gm-Message-State: AOJu0YzxeIhW4CzQDuG2WK/RtwodCxEfs2gatA70PbTUqBg59dwYwgzg
	L5zRuJmZCF5vJNF+AxZLf4qk8rfutftykrqWg005fhD6kFN/GnmIbv69
X-Gm-Gg: ASbGnctal2LXjL9+2gntgupin5TdsRWj0uHLIfWGAXGei2ilrGzRU4gWU0mAZ4N5Fb3
	t3w4PXsOOsM/FVug5TIvKDyKnswqWyVKpmKLIFHq+w/4aluzNWxXkVBfrsPeUcXyXJXgJ+yBwA+
	RoGxnCb6Cy1wf96RYFN3VXy0gOB9+If9g4mqiaE8EWuiQNnfC8MiG4ZDPxnNogHnGQDp78hX9x4
	AtdNuQfc2yCvDZk0eptqZ+naE+BpNfXx6Pc/NBtADQUg82VlVICFJbKKd18wG8pdsABeVFWx3MM
	Fk1nugRAPK2qp1Gj7PCaOZ2n5ffIHL+B3QL6b4k+7ts8OdbcfrOiYVpPSwt9SKQgHJwjoSyZ/1N
	Yx4GhIdkG8scE2UijJViwL4+y2vl6DvSRvzOufbBSnThA25JtPA9lDx82EkrkRcUhyBGhXRlk7k
	Y5yg99G0Hy79tsZ0y1AuZD+T8iz5SyByaG4CJ7Ys2An+xa4VJqSEOUixKJ8zmeGuuuNmJPjkhK0
	UisCL624GLf9u2qDnff
X-Google-Smtp-Source: AGHT+IFPBdMt0Uqk3RC4Q5N98p917B/ethKWmCVg0XTxRxMZNghvClcvOMeLv6v7oMLApmWNNYOqWw==
X-Received: by 2002:a17:902:f68a:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-294fc1d0db8mr8265645ad.40.1761796290208;
        Wed, 29 Oct 2025 20:51:30 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/3] nvmet-tcp: Don't error if TLS is enabed on a reset
Date: Thu, 30 Oct 2025 13:51:12 +1000
Message-ID: <20251030035114.16840-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030035114.16840-1-alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

If the host sends a AUTH_Negotiate Message on the admin queue with
REPLACETLSPSK set then we expect and require a TLS connection and
shouldn't report an error if TLS is enabled.

This change only enforces the nvmet_queue_tls_keyid() check if we aren't
resetting the negotiation.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/core.c             | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 drivers/nvme/target/nvmet.h            | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index f3cf7236e080..3e7024899608 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -140,7 +140,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -166,7 +166,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		goto out_unlock;
 	}
 
-	if (nvmet_queue_tls_keyid(sq)) {
+	if (!reset && nvmet_queue_tls_keyid(sq)) {
 		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
 		goto out_unlock;
 	}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..bd9746715ffc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1689,7 +1689,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl, args->sq);
+	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 50639e6e31eb..f71456a94b66 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -293,7 +293,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq, true);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f3b09f4099f0..20be2fe43307 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -896,7 +896,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -917,7 +917,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
 static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
-				  struct nvmet_sq *sq)
+				  struct nvmet_sq *sq, bool reset)
 {
 	return 0;
 }
-- 
2.51.0


