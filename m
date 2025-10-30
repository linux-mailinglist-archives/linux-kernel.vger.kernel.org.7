Return-Path: <linux-kernel+bounces-877503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A756C1E479
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D8188F875
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B51293C4E;
	Thu, 30 Oct 2025 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOKaaXU3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E8248F4D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796301; cv=none; b=h9bYHiWnlvWR8aghmiANuHcVw7c3XA1TGr9MVRl0fuqUdNkjmczNsbx1sY53BKqjU9oKla+L69GeLJELctE8GdJs8IhwzYmCsl1qNL3kmodbbRA0z/+/kxLPj0hicyc/ykBhBuHa0OLb643d+TRM2N59vVsw2e2OgXc0w8UkxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796301; c=relaxed/simple;
	bh=RiFvMaVv/sJhCAnOCv6KXAlMvQC9pAvjdW7FnhsUUv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scMnFsqiDfdiAla0m8Ggtd3bJl/o71ACQP5tSH7B7Fdh+cIJHY3Uvlh+W5+SBLaHvQamdzosS0D9jG7z2qm5CH7MolbrR1OrKs59FQZXBsz6HM4ZkkEiAr6CUmiHG8CTx6XMjFfR9nmKnfR61ySUQsX6rWjJL1gK4K93/oux1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOKaaXU3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5579235200so354672a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796299; x=1762401099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg57DbX152h+KFFdXgeP517P3SWQLEL3rJ/w0rVMxsg=;
        b=DOKaaXU3YXnSGtA4HvMwDaTjSAPxp/IkqhvOQnu97ybZ/9eOZBlNtCHpxR2SkkKnig
         kd7jCSXHq09i0dAU5Dh3015YBO4A5wI+jHGJIIGLY1DFmaMrfEpp+EnVHnf0YRju31oL
         cQuGV8YXzHS/7k52Wzf8OdiYPxFlIxBLJTwDAqG3ZSYYwlk0fUIUpQeb+ydozkTdhirf
         V0v/kgYMzNlQ9kzLu7iyQqpqhzI+7xVmBRRKY9ZDRk31rwuQWMhY2VD9aeJt+IwtOCIw
         bX2gUvqR1N2rhvYGSmH1uBwrViaihb4i6c5u2cya8SVF4f5Yl/zg64MQhBKyDZ5No250
         eJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796299; x=1762401099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg57DbX152h+KFFdXgeP517P3SWQLEL3rJ/w0rVMxsg=;
        b=NZi9TjyBuHuX66Qy8T1d/Pvqh3aPL6IFszt6VUzXcFNG/pF9GWaeUBk5RZiAnn7aky
         IwA1YH2tRwXSiwNDodikCHc3Y/i/ztTbzQSkPzbMIyqfckSK44GPfuTRp+YLFR5zL9cY
         QmAULE8gXuFbKLPz+zbRf01QmmlpwqCQO8f1URepCLHdhLOk1qUThClPNKpsxzNeyatx
         akW3yMiOa9tg9K21UjyrcyJnSxLCEAn46VOs/eZcQfKXS1KE2M4kRmPFyT0qIIWxCFan
         5jT5HtTLaiFwG8bCidlwEpZDl+zM73BBPzQmKXwtFeWMbseYDJulSosL7ZnTPQX35RZk
         HIKQ==
X-Gm-Message-State: AOJu0YxTdhrLbO5dBrakihGEtHNBv8I2QF8If/+n//coQEvrecdkohcB
	ve1Yxff4jtdm91sa8uiIT09MqY9F9pR5M1A3Ty7xl1HhMDkoJrPKQxZu
X-Gm-Gg: ASbGnct/fQLQ1715rb8HHtDaO4KQ9Zw7qCm6M6ofFe3FXKp0j0ddyUPs0+yIARLk83i
	u7Hgge1xmQO+n+dfrYHFyXUK0SUdn/Re5AvcNxAOEx4VdFpv+CtZ4fKaLfR4I/BDcV9wubzjUjR
	A7sHdqdkwogyikSCyHVktcwgITUbfmPPZzYMuaCTEYGzAuro3/9esCmOmfzi5puGv0Z+OH0S1QH
	2dywhXWeUsdS4Xi0z6rxovDdK0xAR+zz4qlx01lQnNlZMQIoMaOIWDqctvvlNE23HJSSc3fbeMb
	RTfZkNLFEj6K2R2g14h86+4sdr9wRNbgGQPDKMWtsrdY5cxNz9LLkJm1Xgg3ZzaYbxbLdLJNoOK
	nMfSYp86hcZr76z+DT5ovAgu8FZfgSWa0rY4M1+SeIuopIXLk0vnBoXy/eWRPnrB7SzfRn6sa0S
	fwFJcpDI5qxI/cdsJvDWtgqZ9qc4gOjTt0KhWll6ajrdMNTDtlIn/GPYY6sfx5UZi0iMOnkxIFW
	XAlyByBIb5rzi/v1pOQ
X-Google-Smtp-Source: AGHT+IECB4TP3ESqGiKQRZGuWO+zfnfT3ZOQklY1c2ma3P3YZVJziVDmG63qsEJkvCKs8lpqrnfA3w==
X-Received: by 2002:a17:903:2284:b0:294:90cf:699c with SMTP id d9443c01a7336-294dee209f0mr60182985ad.16.1761796299023;
        Wed, 29 Oct 2025 20:51:39 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:38 -0700 (PDT)
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
Subject: [PATCH 3/3] nvme: Allow reauth from sysfs
Date: Thu, 30 Oct 2025 13:51:14 +1000
Message-ID: <20251030035114.16840-4-alistair.francis@wdc.com>
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

Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
This can be done by writing the queue ID to te sysfs file.

echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk

Note that only QID 0 (admin queue) is supported.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..f6994f35324f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -246,6 +246,32 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nuse);
 
+static ssize_t nvme_sysfs_replace_psk(struct device *dev,
+				      struct device_attribute *attr, const char *buf,
+				      size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int qid, rc;
+
+	rc = kstrtoint(buf, 10, &qid);
+	if (rc)
+		return rc;
+
+	if (qid >= ctrl->queue_count)
+		return -EINVAL;
+
+	rc = nvme_auth_negotiate(ctrl, qid);
+	if (rc < 0)
+		return rc;
+
+	rc = nvme_auth_wait(ctrl, qid);
+	if (rc < 0)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR(replace_psk, S_IWUSR, NULL, nvme_sysfs_replace_psk);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -747,6 +773,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_replace_psk.attr,
 	NULL
 };
 
@@ -776,6 +803,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
+	if (a == &dev_attr_replace_psk.attr) {
+		if (!ctrl->opts || !ctrl->opts->concat)
+			return 0;
+	}
 
 	return a->mode;
 }
-- 
2.51.0


