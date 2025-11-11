Return-Path: <linux-kernel+bounces-896317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C8C50171
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 724FF34C5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9AF2F6592;
	Tue, 11 Nov 2025 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfsWMpOi"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C02E975F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904745; cv=none; b=i4JAPqZ3XRiPr4ulpQONgToGOhFgTXn/Ldl7ndahij9bLjWs0X/o7Ymsf1LM0vKIIitO5CRWTte2W+7D4ifljajKu6KvLH/yaBgj2TDbWhRYoZFtcae3MBKMmlXw0TXja4eqL8831K8/WQouIhMR2hK+EFC5h23jQsPBfirYuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904745; c=relaxed/simple;
	bh=ZRLxBPwE3gJ9FwuD1Rfqtx7E2bpKGYVG3PFAQVMUEws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gcx1GkzdwoVwe6zr16er/LLQuPXzvro+liA/uZYsaEVKw3sXkoXn80KhKHIsI7/iVieMGcMFRkSKyj/gocu6tYhkIKZnWpmXL0ua1UZuvxQz5OToRYZj2Lr/OZ5BY2zjBumlFXArMMFRmVGhxNPkEHP9Gn5UENblpDSW/xkOZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfsWMpOi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so202603a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904743; x=1763509543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWBi1oTQN8xeszhItyirAU4mtvXfb1sh1s1DRwqqzOI=;
        b=GfsWMpOiAcW+MX0nnJ34/HOo5x+/VBFMZGQ1VWXhtt/K7LkV6cj6hoTdUq4vcWMA1S
         876L1HiGabyH8aSxpe49OHkmWXt2JbqFOUBNFaYWXmu5xqyeMUvuRPEVV66p+WchfRqQ
         y/itfkQoj5NC3SbEc++IK8Tbo6ngaO8rYq3Ay0yl6z+QNAwTsfp643abH2Ja18uxlbul
         uMl6DBRTTp2emjVdeAENQr7HIUg5PD7/Hp5cBCsWiprNDNvzync4ycwK9bG6nb4HkJAW
         2yW72xKvmPgKefshTqb/CtKGl8dHBb9hscRpTH71PPtOLywpbvZUuMHlmXXWXNiNHaMm
         roKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904743; x=1763509543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWBi1oTQN8xeszhItyirAU4mtvXfb1sh1s1DRwqqzOI=;
        b=cwhv9n+2bYPgcHyuQr5l1ItzuI3autRA2IQs1BFgWdYCEg4fD1JL25/HLJJCFxVwOE
         U7Nlb8ynwlsdIdXGvN4NEk6DZIKylLsbkq1nFZ+68QirqXXrJ/v3TuRyu/49FluIxkUP
         /xAEC3soap4Zah+b+pQe97K4VZlEW4pAfQeGljfiyWzG2EZroKGhumpGp/z+STeQzq4x
         007pfAnkMLYinlpXTJQNwaKdSWEptPYe9F2XVFawusxvVzMIdbMdgYDCFQ9M9HGPjSel
         M0VweKCdTaFBKKWAkuvfTWvDb9z8RyonWxARp99CwpsRTtqLxU3tkrR31J2sZrX6Hjc9
         Hoeg==
X-Gm-Message-State: AOJu0YyFrRjZ8clc6caxRlTPwOGdJUu9+7PCs2d+K/TtmPvCmDUwtzXl
	12EyzlvFY3j7df2zK6DXgRRP6VteKuWWHyvkfMUEov1mL9hk74Z9mOVm
X-Gm-Gg: ASbGncsNOAmRTS5Z0zBnwxZ8xUp9WRCZSagbOK8EX4Trs6N8jch1s+dV2EgT4fU6IsY
	fop/UEjxDMxEDIPXX7UbUMf8hRdnhVjES1k4QeK1rzcNostmxvXVO/QdG9EAXEeWumJNQ1BgXI8
	ilx+6yrR9xvUc+PRTLCbjUIGnPkmzBpqii01fvir+lVVoFvSZKtmHUsn+agIi/FnkcyVagk1jUI
	Sy8npYJ1JkosBpZ+HxTcuahWyA85VsnnhAmuwdDhbuaVIE2ZtRvbg7qIiY1cbCrMFwrM6F/ta/v
	aGmMql0Uflktw3FmlT52tDpv3U+9UxRfT/T1BP4S6p7D6BeRD8TKsQHMnb2MCz4e3VFyNMXUBmR
	3YpBvUeNFRUBB6TJWBR8xHF7y6VbfGb/9hwP8qJLAeQfoqCcs7P0SVuk2MZCKs3ffJ+864PgSLq
	IahNANpUDlCOD1cYyNsDovxqwS1m8A9kPE2km2jbw72mezryQ/hGOk9O5TTssHKmbdZqUfkVemZ
	wXHHowx6A==
X-Google-Smtp-Source: AGHT+IGEypHOScirbVPg+y6OQNiNvnVEj5qynDGboxmj9L9oebys66ZkruXNUzo16Du0Cf/D6yCZQw==
X-Received: by 2002:a05:6a21:999a:b0:342:3b8a:f33e with SMTP id adf61e73a8af0-3590ae34118mr1060999637.39.1762904743267;
        Tue, 11 Nov 2025 15:45:43 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:42 -0800 (PST)
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
Subject: [PATCH v2 2/4] nvmet-tcp: Don't free SQ on authentication success
Date: Wed, 12 Nov 2025 09:45:16 +1000
Message-ID: <20251111234519.3467440-3-alistair.francis@wdc.com>
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

Curently after the host sends a REPLACETLSPSK we free the TLS keys as
part of calling nvmet_auth_sq_free() on success. This means when the
host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
check for !nvmet_queue_tls_keyid(req->sq) fails.

This patch ensures we don't free the TLS key on success as we might need
it again in the future.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Don't call nvmet_auth_sq_free() in nvmet_execute_auth_send() either

 drivers/nvme/target/fabrics-cmd-auth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 2e828f7717ad..0cd722ebfa75 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -397,9 +397,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto complete;
 	}
 	/* Final states, clear up variables */
-	nvmet_auth_sq_free(req->sq);
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
+		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
+	}
 
 complete:
 	nvmet_req_complete(req, status);
@@ -575,9 +576,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
-		nvmet_auth_sq_free(req->sq);
-	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.51.1


