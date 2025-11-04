Return-Path: <linux-kernel+bounces-885569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBBC3358E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA78F42669A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4234678F;
	Tue,  4 Nov 2025 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWISR0j/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F82D978B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298067; cv=none; b=lXsMAtzEafYt4Neq0DLbA1B0mI+rMnm2DfUHLPTFEyGAwHEF3bhy/jNVmpoSbukVCig9epnQOmVI9NROiZkVUNVMduLewV8NSwZjCHo2H0CYP3g2QtSBL/IlzbJ8Q1pwpdOjhvzX09dwXjUs+bwxTtpNj5jkLU5yQkHFU1kMURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298067; c=relaxed/simple;
	bh=gg24jhn5xltb7KCgsuA0rzJc697rDBX3dpTAWcbDiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIniWWqMzdEVg5sP4Z2ShM6yW/KXffLVFlFJ9NCPzadq+JSL9+l07cp1uZ/PCvJ0yn9Fj4WlHxL7Z+ZfK3CFgy55ALteW8Mg5syuO6Vx0VxpXqi1g4mL+2qBfITul9K/h8v7c5fu1CcIlpD+tNLfnaxXdakm35S5wZBfL76c3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWISR0j/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2951a817541so68126075ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298065; x=1762902865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBXI96WMpDGx42+VJ4xeNtr5+eWqCLgIWQkUXRFFjgE=;
        b=NWISR0j/UZRPgb6iWawoRGQMl210MvQF6WRIHERC2c28dIPIEZZtL086DXvuN1zgPA
         y+4ShiB87FCRgwxEXR9KFmk/6QlpXNhAqNTKL16jBM7qWPpoI5d/70yY6kp2WIggI6If
         VAc24qfi5nN7+QEjrWODPRGVdzjxamnlnxJ9FyB1CKfnYD11YVd/Uxvjl8bgKsJd0xaM
         f4ZyP53JuulaO1g2+qaXUnDRO+dqgfLbB5RbIEXr5wqCerscnA0JJ070kdD9uYbNwu2B
         t5LptZ7bvdevDfnSn98sgT8g+E48p682pYZDae1eMJcOhEsHeftFU1n5CRZUTtkDJUSE
         zlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298065; x=1762902865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBXI96WMpDGx42+VJ4xeNtr5+eWqCLgIWQkUXRFFjgE=;
        b=O5So4k6eHTjqwwGcYWyP4HK1gRajeXQ435R/y28tJMCvvdSXYRKwEfuYiI3omKaRbY
         ik6BL/BVXu3QsXHKR+CBubS1DjvkdHz9gp6Fs5XExglevkCpWc1YU4F3tYbxA629ceZf
         8OQRypBXU2kPcxjNkekDTBleMlEwHaqFyvdULCf6Hq+9Y4FQER2J2c/ahOH2K1mfn1Lt
         G7nO6hnU+8ddGzUFSaQPZqa5BS4DZK8DPOu+5m3/k9PixWSw+rbg2lm9KHq7pC3eBndU
         OKTffH3PI505/FIWWmUrGLqUwhEuKJ6CR9pm5m0M+aYFRcGUz/bwvqJ99gTsph5hNtxL
         ERQg==
X-Gm-Message-State: AOJu0Ywa+ntkCqPrF/YVoC/IThB5bdU1FEvbzAoeb7YyY9dlkIvzRh1t
	TgclFAI/j2Jqi2glWVaJJYgVGm6zrZDdFNlYEu6QPrEWQFOmxk/CJDTR
X-Gm-Gg: ASbGncvbTNpWng8ZQpzSB4J6KPIDEnIE1vQz9wGws/Ldr86e4T/P/ktXG8MKZXh0pas
	epX1J/30fWf4ih/iVWOD7PVgXWOWwHmvqUbhnqxK0q0gF3MuPMsDoj9C38Gkom/uxiTSwn6g7QF
	9vfN+3RwtXmS4sm0FmdVUHeNhgs2Da7JQBOoyWBMnuRYd13f/NDa057d7ouBoiwCNR4iHP3ZJnM
	yybMsssIOqYzQkHIxs6wmZPmB/FzRNQWRZ3UVAnFfGUyh2M1UoHGrjJNaWLABjsIhK51esWGrHw
	6zD3DKyXq4yWkN7poM6TCvNsjqxIzQFxPaxkqEXdYbbl0OvS2mJ5DF1RnWkoqvXN6nn7H53QR2r
	3dRF1S5V7EG2tYvOUIfZTWxSoeUh9TVTlLxZgti9Pn7i9YhZYHt8Zt0wXMmoDgm/X6F5i8dlAcW
	k7adoOgOzOhYIPpXK7SKEqRLdKwFybde895GrdDNWc7/tD4oVvP6ya/vfQI68T5SEKOGWR8FtbN
	3aTaPea
X-Google-Smtp-Source: AGHT+IGdBvi17Le17PP5vZw2RL9BrEoB7qvViDJrnCG5SSCKlLWk2zN00TV8C7+sP+lFXy/yHxGY2g==
X-Received: by 2002:a17:902:fc8f:b0:26b:da03:60db with SMTP id d9443c01a7336-2962ad1faabmr19740605ad.13.1762298065412;
        Tue, 04 Nov 2025 15:14:25 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998887sm39697785ad.42.2025.11.04.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:14:24 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
Date: Wed,  5 Nov 2025 09:14:14 +1000
Message-ID: <20251104231414.1150771-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
the sc_c variable to the dhchap queue context structure which is
appropriately set during negotiate and then used in the host response.

This breaks secure concat connections with a Linux target as the target
code wasn't updated at the same time. This patch fixes this by adding a
new sc_c variable to the host hash calculations.

Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Rebase on v6.18-rc4
 - Add Fixes tag

 drivers/nvme/host/auth.c               | 1 +
 drivers/nvme/target/auth.c             | 5 +++--
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 drivers/nvme/target/nvmet.h            | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a01178caf15b..19980122d3d5 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	*buf = chap->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 02c23998e13c..f54a1425262d 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c1;
 	struct nvme_dhchap_key *transformed_key;
-	u8 buf[4], sc_c = ctrl->concat ? 1 : 0;
+	u8 buf[4];
 	int ret;
 
 	hash_name = nvme_auth_hmac_name(ctrl->shash_id);
@@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	*buf = sc_c;
+	*buf = req->sq->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5d7d913927d8..16894302ebe1 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
+	req->sq->sc_c = le16_to_cpu(data->sc_c);
 	if (data->sc_c != NVME_AUTH_SECP_NOSC) {
 		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
 			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 73da823a91fb..20be2fe43307 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -159,6 +159,7 @@ struct nvmet_sq {
 	bool			authenticated;
 	struct delayed_work	auth_expired_work;
 	u16			dhchap_tid;
+	u8			sc_c;
 	u8			dhchap_status;
 	u8			dhchap_step;
 	u8			*dhchap_c1;
-- 
2.51.1


