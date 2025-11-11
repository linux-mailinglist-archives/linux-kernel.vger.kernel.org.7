Return-Path: <linux-kernel+bounces-896319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9BC50180
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41326189CF10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9232F83C2;
	Tue, 11 Nov 2025 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr2iyjRO"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB62F3C09
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904754; cv=none; b=XoMuPk1XGaIRuPiBprokdM8lu1zxCht4wBzVIFTtexSnlxW00cLscRmWXdTqSt7GMIV9V1bFbEXSOfvVTJGNay6ZQ6xWQt+t9cGEf74Rjc8BpJRM4wiq2l9+WKjQoa7S9NopE1eAgyQltqCgZmoYHhXG9GrFS9D6iu7oSIec42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904754; c=relaxed/simple;
	bh=piyGLJt485dKGIG+BiHrcokwe3Zha2zC7r7tpiO1YtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGpxIcUSgXJJJ7xEnVfsPJsKDTf+CpFz+dh2btGJiaFJwFI7KBmAzQ0Ah3/ZSRQm+lALmF1lAu54J+iPTCmdDp0S17CwlYY5XXlGL36BnEd7vSAkSAIje5R+OK2FNxvTJMz262MK2k3Gu2dvNrKakEKZyz9HXH7rUmMlVR3Ah+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr2iyjRO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so356467a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904752; x=1763509552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku+uUPMeqOTqJ/waoV9S1SGRJDVLJtYE++c1OnVYckI=;
        b=nr2iyjROAtMI+8vXWTYO0+AtWN+gUExTs8IwL7nfaHoG9ZUu8ln5ra/ovQBnR80OVn
         BkDLBL7n5zbweV6U0uqd1ANX8UnRV4M2aEPm+sJ1NlwqhAxuT+cal26CuAHDPi83NpAQ
         H5i1g4GEUr0QSVRW14hNABL5/SuuT+dAjxUCv0fOhzbVF8/wo4VxaqF6tmGCJfRkqd/s
         3E6yhiBtCU75N9syebroGQ5nkGRVsoKqWdp/QEcjTp2za/XZsyzbJyspPcSfASqetgMx
         Y9+3p+vmoGfoa0KDMkgJTsXuItCxw4eN4DpTZXSMNnTa4X1nU2wHrOd9pj3lKpPsrQLC
         XxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904752; x=1763509552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ku+uUPMeqOTqJ/waoV9S1SGRJDVLJtYE++c1OnVYckI=;
        b=MKddiKfk9ZTnX55kMa4YGIbA80olf/pfQyRxeIpMH/driuRUvphIt9cXSTni4t7+g6
         WHoVEdO96XCX7xsQ1ap9G8H+/tSKnwI75LyjmK6/fqBFy4VOGl/2gyHypMQmhy/bIsOS
         ax2AEt75sSKD8nAK0pzRLwb55HPLi7UvqHvaEjeeao377GzVMLkPSvZhjtKYUXJP92y1
         pCh5xsOijh0ZhzRLSE9A5r+bGqBSA4p8qGWJudN3nJCuQChi9M4UxFPJgFw2e2H4yWy7
         3e54irVgPupLMfRStqlQ4Qq4JTKkEbBflNc90uPmUOUAktgWj4nv8oQrSpcuKWHXuOQ/
         GyqA==
X-Gm-Message-State: AOJu0YympicbvhbWA2+cC7yTA3R6di0AnNn8rnoajgIZyNkQ9bKz2Ir5
	UEy82cKeu5vviqhQV+iH7wjCrBdojQFWILTmKKfW6on/yFsG9oFesTAl
X-Gm-Gg: ASbGncv5li4LRkLQZGBfKLRSUzQErfVg++UIca/dbNO/5+adrbEU9TIh9Sc/zXZgOz0
	KfOy25KPI1sEAV+2IP206IrRPVS4d0l8cuGcxawDH99zACp9SAucSjFWv/7u9U1CCmLXJF5BTIs
	Icb2vGlndVp264a0Amnp+o/vcf1rbdOr000xsQSAkSRVoRBnr3sxyKtmaMqYl/3+XtcMr55bLDT
	1IZqFNRVSlayT2O46Sn0oQnFQyeG1BnLxmK+8gzT6dz0iqz9F0UqVBgoyTciSF+c98m482FI2x6
	t3srOlUce79Sbmy9uFcEgdqvpYWyqv/0OYwWLUkDfBXLBSIb7wtQ/lCUJw2NO7sc/e4KU6wq82m
	9sDM8qK/XYcUgvWWBDx4Hf3YIx7gXcQ9HuvE8jVQ1jZGvWR4nVealU/mos/Sw+TnDlP862UJjUX
	OqyIZSWoch9ILHA04Depad4fy+VxhmSGTiHlUcqdTnnjSeIE3JZzqJwEgAag4h7Y2lYia9ZoxWU
	UK7gboAgA==
X-Google-Smtp-Source: AGHT+IFt1zGwYGAmAVjS+MJ38BSYObFsBFiqI8Px7FyooYwE/yqV2VYEEU1VfGxit7rguzbRU6nxWw==
X-Received: by 2002:a17:90b:562f:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-343dde8a9c6mr1021769a91.25.1762904752048;
        Tue, 11 Nov 2025 15:45:52 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:51 -0800 (PST)
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
Subject: [PATCH v2 4/4] nvme: Allow reauth from sysfs
Date: Wed, 12 Nov 2025 09:45:18 +1000
Message-ID: <20251111234519.3467440-5-alistair.francis@wdc.com>
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

Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
This can be done by writing to the sysfs file.

echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Trigger on any value written to `tls_configured_key`

 drivers/nvme/host/sysfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d10e12136d0..db1c53e00501 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -806,7 +806,28 @@ static ssize_t tls_configured_key_show(struct device *dev,
 
 	return sysfs_emit(buf, "%08x\n", key_serial(key));
 }
-static DEVICE_ATTR_RO(tls_configured_key);
+
+static ssize_t tls_configured_key_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int error;
+
+	if (!ctrl->opts || !ctrl->opts->concat)
+		return -EOPNOTSUPP;
+
+	error = nvme_auth_negotiate(ctrl, 0);
+	if (error < 0)
+		return error;
+
+	error = nvme_auth_wait(ctrl, 0);
+	if (error < 0)
+		return error;
+
+	return count;
+}
+static DEVICE_ATTR_RW(tls_configured_key);
 
 static ssize_t tls_keyring_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
-- 
2.51.1


