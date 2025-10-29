Return-Path: <linux-kernel+bounces-875120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0187C18427
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FDCA4E35CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468B2F1FCA;
	Wed, 29 Oct 2025 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTlPpMC7"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1F2E7BCF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713631; cv=none; b=lxI8Q4hZ4DFG28w9o7z5yAc7Ie/wO5eBXEI8c9MmTAh+DiwNgITTuTaUUglNlHDmhXu+LaLE1WBKRPOYUdYSRJpARuateMhXsAhtwSJMe7iKww9IMknE0dw9UVqP6VrT3C3wxTXciUJjwbqcpqCfzYKi68oIMSCA+/uRo2KoNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713631; c=relaxed/simple;
	bh=MNwtoNil87B8FrDVmZTgdGzZVQ0nx1tdTmrvj9/D3l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSqqLsoSvQU5R4JiG1YFCTvUXPI/FAomQWQnrv/pW2W9PUrly8Gw5EJ4dpVGybU/k0Y3IA3QlSsJcVYw34/NSx30AVVri0ZFCPp2+QkU9GJqw9K4hGHaHpIqZam2Odnp+gQeoXlKiIJ38gpH9qyCszfEfjbddgZ8Aeggyv/yPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTlPpMC7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso4981888a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761713629; x=1762318429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CY+0MVmUH5PmZeNVly8IHxBzQaDRE+875WgMWeyJQI=;
        b=UTlPpMC71e7+35vbUDAeIX35lZu9XZREkwqQSdgzmb1GCAq5PYgXwaimQyRlTZ40en
         QM27+Kr5pFlHeqpTuYMiGegy863Hcue1H1jV7zhTAVIUFp1D+zSylQqDyV8yq+mWhIb3
         HD8T4IKyvuqXNhqMo+MS5Zi/2/aivvpDjblVASEn2SIrw/h0Wgetu5E6Yw3Z4p0mQpDp
         nlO2wxSind3vJReh7QlYQcUEbSiLPlEj5j9VInmDCbidHGHhgS1moelaHA/AiRZtIbdh
         fjuO4JcTzorklZ7SF41xPlEtAGTqQi4a8ZlhZuGHFzXTmjyOkJi1sHRTWR9g2gETUqzV
         RlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761713629; x=1762318429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CY+0MVmUH5PmZeNVly8IHxBzQaDRE+875WgMWeyJQI=;
        b=nUlhGLACddJrB8TLXAQqeP1SPyNWKSSeYSg76XpruYyKq1GHEtJ8BYQIsgc8zcsiiY
         2/46yECnqdR6TG+3F4degxtax1+o4T5RRSfTwSIFveC/5DWNlVQqxBvtQIDBh+u0UlBf
         3oGqrV9fCgpp4DxvMFr0Gu3ycKHg7Ft78qRj4OMcgnjURnNp9KQPpVSRq33lAG6K+8UQ
         n18J4LWaPQY4cBzqnMBY2U8eR36aHtYbnGD0F9Wq8hpgQIMlK9eWSO7p+lRV3uhssUbu
         pLc2mE7UPB65VUdK2LkKMgPQCrTqDIn6ClnrA3549LCxTG21p2LGXEaAKNjG4BRpiEpR
         1JOg==
X-Gm-Message-State: AOJu0YxX485o501LY89l9fQvKY1+TrRqJgpC8kEd3Jn6vGGiN1eKIiuf
	pHdo5hX9HCafaiY+/ronSAVX0ZLnszSqbLEouuQs3RUoidMi+prYqWAi
X-Gm-Gg: ASbGncvCOhq3X003gWj8fu1ApETunTEkch+Yyg/OiDq2oqWSMMExag9EJO5cX9ws9mT
	c8keudxiui7hr9QeI+q6Tv21Rvh4ZKmm2zIw2TwFbrJ1/z+IbPSE3wIveGNiL1g85UEnKOWuHPT
	iOtBdVph1PyG/Q17VnK+l9q5nyokylQgiSI0jH4prncCSBUqAoDQhKGCIxO5lv7fmvf2z5287Rx
	+3lBhmAgrI1kF81NAi3cVekHPMBC3ZxpTeGiN5Fv/9zou87epsPmVDabxE/DG5N/aLucmx0jlpu
	Tp3uFDPfUPH6zqiJoQIjzTICswK6lGFqEggro8RdkX9/Ri6Wgb5BLbGb8eTV+F65Mh5Wftdm8Cc
	XZaO8moDuWp0tmglxd5zcOIRG0+2wolSTUJnlVB6czLxKThampjYCjl3sWyX6iYzgLtXEO5khk0
	Rj7keoPGwaBn9c0YYh6Bgr/jdCHt2yVjzz5HQ8E0h5+tkLquHMTDWj1ehOSfAvRCpP7ez5laM0e
	zC3ruLl
X-Google-Smtp-Source: AGHT+IF+tL1blEpB18Y1AyOuIFg8VIy3ahQmS7vzQLIp8gqRT5i0NTRaLH2fdnERQALAl+3zHQHK5Q==
X-Received: by 2002:a17:90b:1c09:b0:33b:b0f7:fdc3 with SMTP id 98e67ed59e1d1-3403a1435f1mr1757128a91.8.1761713629106;
        Tue, 28 Oct 2025 21:53:49 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6035sm14051709a91.17.2025.10.28.21.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 21:53:48 -0700 (PDT)
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
Subject: [PATCH] nvmet-auth: update sc_c in target host hash calculation
Date: Wed, 29 Oct 2025 14:53:27 +1000
Message-ID: <20251029045327.2035337-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/auth.c               | 1 +
 drivers/nvme/target/auth.c             | 3 ++-
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 drivers/nvme/target/nvmet.h            | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

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
index b340380f3892..f3cf7236e080 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, 4);
+	*buf = req->sq->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -377,6 +377,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index bf01ec414c55..50639e6e31eb 100644
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
index 51df72f5e89b..f3b09f4099f0 100644
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
2.51.0


