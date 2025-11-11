Return-Path: <linux-kernel+bounces-896316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B3C50174
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24019189C3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07512F6190;
	Tue, 11 Nov 2025 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZcs3zI8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A892F616C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904741; cv=none; b=WqYSFLDUSuAULHyhf4T8eiedZzdB+uufn3jMRNHJtChEJc2b40OBbFAPOf1blBLY9Ej6f6Q16B+CpsaXsLSOh0tvOPLc4BE256uMqMfO3oyeJyGnZ17m+ZsxdaJmiXpfDop+c3ipPSC+gor4XHOfDZ+km44s3h22IMWoVO2knGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904741; c=relaxed/simple;
	bh=jd0oZ2wEyRyT2c2fH6IVuUuDMWE4H6/TPUUp7lywhxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrmCUF24OflFCiuIf1f1rZ02Caf06zLbHzZZSKivhxYWcI7LZP23QXcXD01FfeQ5I0ELdelhyBC9BbRdHdPdOBGlOL9MH5eNmJG49djm2Gwm0fQIgKK5ikv5K3wyV8koODwf2XLuzEzSUnAVzLeipMnNN6bvq8r6lFi9uk5kheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZcs3zI8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo211501b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904739; x=1763509539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1qmLvBmRsfddvSIMLLF1wU/sxsBAzT2ahNzIDu+7xY=;
        b=eZcs3zI8PPhBIkawC0v1AMka6HZ1A067/K+Ix/07/qLJdFh662e3ws9keMJfJvo3DC
         5kx4VfrRP2W/+pZgKFgzAGMK/mU6Qo3BbRUxapThbxzmJRQm5Q8ALxRj4eKJ1PxQTwrR
         fnISzEMP2UWoV9x/Za2JeZ3F4M7/CescNzfgs31f52uzQqjJA21KKTFoT+jWk9Nolsfo
         rk42zT/lup93OoUXOngiIzmqfbcI7iJtsGxkxZaPZnx9Zd/t5/uQwZEGf9cszTS7marg
         PVoLZn6/QXmO74j0VzsGxoDUe0Ef3JwWphzjr23+x9wcmu5BA5zlcKijyCmrcMdHptjJ
         SWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904739; x=1763509539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1qmLvBmRsfddvSIMLLF1wU/sxsBAzT2ahNzIDu+7xY=;
        b=Vsk0nGG9tlnZ+FiuB8fsTdQukpN/FVUCY/pBnJWf3tCuUQff2Qtbuc6qdaXFRV5zBh
         0IVihpBcFQJNaINpc2nphsTPf3moijVqSpWMj874eCmxzsbm7A/qMm92IhEBN/6SfHJT
         gcf0tfIH1I8t/DJZjPvTvIEzvYLlXGIYNlMFwJbxX1oSbCO0CtrS6oqc/DKL5ltDlz+7
         lUtYaFuyl7iKnNGIRXGYGpU9SF5XQBHD7Sx/wfVmLaLH/ZvGZpBkCgbXQB/G4Bn8tgKn
         3hbxJl1WZa7IjFeegLL+Dc6JS10EnpI5xj7ADeL/egdLBcpg8UQoU8mYq1mBu93Sn/+M
         O4ew==
X-Gm-Message-State: AOJu0Yz+uzWuecmqE507S+vIOXpfeDtRlju25MWKo8Az/OS9sYIKTo+z
	ZxACZuHJcc8NS3ktTHi5liO0va83HeqwjWVpXkXlzgn05/BETpJ4XGJ/
X-Gm-Gg: ASbGncu2iQsLL0v652k19xEPkg3fY1pffDR8xBKja/V9JhOYYKJ+H1KEqF+JgLkCQyF
	oHoGcPxE7HLH+qlgDPdu8r8N6YlOppPl+H8FOBr5Mp16BT4qg69PeYRnKiP33KkdF2tqS1d8PAk
	O5S6IFbGPOVzwqveZpn5/JUXvrUhNjBz+pir85qbGNcSw+zFIoK9PKLyf07WiWqdmkIb60eLhgA
	5MH3AKYmEcV6/nYvuWMIMYlpgBM6my0v6qZoylrrMY0MfTxBTXBMc7zejLQRGwF+JxbutFNzwaz
	94asXrgV7m7EUO/KMU6S8BEUSBbztxF/hkEaX1wnHPOD6g7pYaQGi2v76AbQhPXsBHBRLCqjmdR
	qgWMwqBOvd09uczZh2S49wljtQ6hsTymgc4X9xjJyIg57AtkkwUlthbjKPMhe2rSWgmQFYg9ZdV
	Zt3yrdeGrOqjAo7QfKw9PF9C4Wiu8FpJuWuG3lQa8WayWgsey+AjdXGNAhOUkBCrAS8W9zobb0a
	QND43oyuQ==
X-Google-Smtp-Source: AGHT+IGa7SEJ6OSEuz2ghiRvesNvzPboXyLy+UmQ+C5H9LApItHI6PS/SlgKFtZajc5yC4DweL7yxw==
X-Received: by 2002:a05:6a20:548d:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-35909f6dc49mr1277638637.23.1762904738869;
        Tue, 11 Nov 2025 15:45:38 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:38 -0800 (PST)
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
Subject: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
Date: Wed, 12 Nov 2025 09:45:15 +1000
Message-ID: <20251111234519.3467440-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111234519.3467440-1-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
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
v2:
 - Fixup long line

 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/core.c             | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
 drivers/nvme/target/nvmet.h            | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 300d5e032f6d..58d80fc72fda 100644
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
index 5946681cb0e3..2e828f7717ad 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -293,7 +293,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq,
+								 true);
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
2.51.1


