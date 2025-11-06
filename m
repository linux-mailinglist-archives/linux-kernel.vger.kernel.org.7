Return-Path: <linux-kernel+bounces-889515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC4C3DCCB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47C11342F47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65C631D36C;
	Thu,  6 Nov 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h378lVi1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694E2D6E53
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471044; cv=none; b=BCLBsavbS2r1mzP6sdPtAlQ1O4vEc5vzRx2VkrSQenjtCvHyIDEomwHEtUhsNJtpevvaBKrgaiIQHlfR0pOmp4Hk44rnqZraP9zkrZfuShyquds5PYh3ASx/GSUI5WRjYJH3W9OZpAOIzWGi6XOMHz4+1OmaYM3hMEwnRuCbl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471044; c=relaxed/simple;
	bh=VcOEGWso+uKssUtqeBPYqCla35svV4NAQL67nY1ShZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIDz4DAwC4Zn/wvBOwP7Svf3Mc7OaeXEoZmRTESDDS59WB1fpirQIzqkSPPNSg7eH/SwAnqEc81KuFrQTIWqd36SEAOEwryBCgKWuXZrdqcKZAqvGquM5DU+Vm6LXKM89VEZYZPIc1PskRBRSy0J4imH2pPy4xkAP2ESVDH0I5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h378lVi1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso127667b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762471042; x=1763075842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxkbqocSKuMAYx2uu2Fs9IEgdxjiKFemke+ud0Q0HuA=;
        b=h378lVi1SESjHB1rARBe03dbB3+PP8SaE2hsxABbI8B/dF+xaI7rsKBP4FTxcnSVrb
         KHLWqMpKI+vrR5vKFcTmcpjti4OmgjIfAwfQxRrG9ydFz99+ozKqtndhL5lXWSK0JpGg
         6OvVPh+OCG68RipZckVun8zKDaXneHwYefi5Lx1A7E2fv7JrPoTAvU7knwZgjgtFMxU3
         4CT+uYvOM6Z0igw9VXfVuG+jBS87XAefei8vMQMgSnP4YQPwhSBgG0Jixl9eD8RHbZa1
         BmcRzhWuLZoYqf7/5FDgIVSkcbTGkIWwXgPq59V6DtznzD6VO0uUEbGa/YWLkTGLbcH+
         qDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471042; x=1763075842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxkbqocSKuMAYx2uu2Fs9IEgdxjiKFemke+ud0Q0HuA=;
        b=CXbsxvRO6ojZeLQUVIT15yoHPgWDnpuNTLNRMIxgJPameW1GyKgo/pz8iEZD2Qgvsm
         tI/Namf+P25ixsd1VjOIXIfZUcgQibu5on+OMpCIp6kunhuBRTHFzuJ9CF7SpPjjgirO
         JB+QT0ahmekkEvslqgB6sg2UEpvrORVm2mm3xkX1yMyXZ4JCPhV2jpVlaYGDncnf5yqf
         G2g2PEwp+V7bBwzu4iBwq7YhFrXyC9xOMnWPrPNuEDpiwTuGGtyLe7eLUaHFtCsCX4jd
         +fsia2yQkYUKXU4e+CJDfIJpIE2lSEyw70jRPdksTYUaVCbNI+y5wxEDzinpo+iKEPMO
         QLfQ==
X-Gm-Message-State: AOJu0YyBO4qPYr/P47TtHjEejgFZ+PEbhUoiWythcuwUGaS2+dAuVzyc
	XIrAmMht05DEBfcUZkoOMWAwbme9t0tWRzyc5umN/pZ5TX0yDNxhziPo
X-Gm-Gg: ASbGncvw7oWTa+vUjCAqsmNIoLsZGaNH4WKMgduVNDQpyWwD2Etd8hqvYV2n/5xxo+i
	LaVkDzAV2ZctTZCUEEzJqSe/DIbJAyOoUnMDvDn+/v7ooiozcukQpljleKu/RzuwtSZqb/E/8h2
	Z4JuiSaMOiipsu4oAZaxf1NacFUYx6sV37ZONOMFE1flCpJB8vzptvZMFtcDG05OXZTgeEyNxaE
	oOFiLF+5svPHvLBPlQaYjx5gJjQ/fwti6uEcHfZ/eb4mjES4VyaAmZbKQck8+SzD4FXHdGlPAI7
	WbRbOo+HZ2wcY7yKxahbVKgwZeBj1fblUQ9qcd8KY5d47GOKw6VWfNWt7iTBS3OPGYbZ7mxtVaJ
	Z3RrV/epfzu8LzBqkt68q7EONs0ogJsKIyWq5H1svOCD0juKTpJIxPQL1pgk1xzjaH2X2xK7lAF
	r5wuM9sc93PAFIwcf/XL9a3IJEdHfbthzHRZB7PZY4viw7nTf8/tl3jIH6xq6XmpVTfUrlHMvRS
	oUgQRkCZw==
X-Google-Smtp-Source: AGHT+IFgt5H5/Jh5UddUTi/eC84zmUvNW7lSw4KqwjZ32dpmEteJM77JYy4M7NtASe4ejJ68zTxu7w==
X-Received: by 2002:a05:6a20:9145:b0:342:873d:7e62 with SMTP id adf61e73a8af0-35229d5e6a6mr1867860637.29.1762471041912;
        Thu, 06 Nov 2025 15:17:21 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc175484sm680245b3a.42.2025.11.06.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:17:21 -0800 (PST)
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
Subject: [PATCH v3] nvmet-auth: update sc_c in target host hash calculation
Date: Fri,  7 Nov 2025 09:17:11 +1000
Message-ID: <20251106231711.3189836-1-alistair.francis@wdc.com>
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
 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 drivers/nvme/target/nvmet.h            | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 02c23998e13c..58d80fc72fda 100644
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
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5d7d913927d8..0cd722ebfa75 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
+	req->sq->sc_c = data->sc_c;
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


