Return-Path: <linux-kernel+bounces-805156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEAB484A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3453C189F76F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C70156C40;
	Mon,  8 Sep 2025 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhe+YAZL"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4E1DF73C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314899; cv=none; b=Zxt3w90umPj2om5L2qDCeZX5/rbLgvD9gdqVdpKpwO8VCGVECodgCtMWUUI9BOlqxM1X8/Zs+pOOpIKE4UCnoTaoZI+qiSCFPj3cWHCj8JkTx4VU3lQf0QfbxD6yQVx4FKXNCcyI0Hk044XoVduTIzMlrYziyu+UW3bHtPVYunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314899; c=relaxed/simple;
	bh=D4Ay7cjqW/QNpararKO4Lw+hA5bmuFK11O8/2Rv/vhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFafQ6oK9J3K5mw+eITJ+R+7jhey7y4YZu8Ggw6bnjo4kllf9wvL43uXwlJr0hviLoAJsg3nEYQlDrHV3MEPYYT/Ov62weA1GLM/qbHh/7CMZYhcZpVJfaFE+ge+MlyLM7lDFKgRPTcDDHN7cdkUtDC7o7kJmEaGysRhURZs/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhe+YAZL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so4004663a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757314897; x=1757919697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbaEmYlV3AOzGtE83K4L4+Dz35fmJjUox3DLoNP1Lvk=;
        b=Rhe+YAZLuwqZhdgqgIPZ+NWfIWTO206A/Kdu162F42j0uTJkm/Xdsr10YgLEulkyzN
         1+4ugNCf89XuSYMjz3EOe9Qa4LkB4FtRTDRhKCPzWLIsxB/IvGg8I1x2AgF55zpk0635
         uKOpDRnLAQnLbLDJe3GZ0020QczYbyARlk/mXHdGxlfl93DRfHpfd5Xc7jAFJmHbcmhz
         t9A6Fi5bgV/Ysembgf8XbHDwuLnF9uihOx+f1c4cAm/Boc0R4ZlUP+Pw4CN57kvZ4U1k
         F4FAWEiXE3V6FMReJ0CKNu7lVOKtWP+v1tciaIUDdGaB34rm0KajvziIyVjOaPKxeDIH
         fiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314897; x=1757919697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbaEmYlV3AOzGtE83K4L4+Dz35fmJjUox3DLoNP1Lvk=;
        b=N7xcGvAr+SjoadROKnvxRqa6QetkEKZcQC8O5m8Y+yYy60zU83+5j4sAG5uUUaRNmm
         tlI7WkvInbPxA/cCOR6DGKbeKu1NCQDNMTmztLhUCYDGNxaliPKBSTiCRnen1kJQh1gO
         gB4+eUjCIUTvID+9FX5YLhAquT+L9kG4MAPGOio/0C76pV91FA0UOEwNZKifOTCmsidp
         v5Dz843bnqf6opSsxPto3ZeP9NhR/jGmFHXUh/W3OaEWfwafwCVkbDrUVEaM+n6ITbG0
         GezrjvFvqE5hpttCIeEI1Yxl853cc7jvv5JXYAfHL/mmCNrTuZOTmfQq+BjGTPnkSUe3
         Hyzg==
X-Forwarded-Encrypted: i=1; AJvYcCVDWKsGIHSbuOhmEjK+pLB/b9UMbeJAu6hNk1KNaAgDxESrthlfC9eUjcnjuz+fPPK3olk0LXOHWpy8iOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKy3ZALMBHiVGDBX39ay0lnqEMkwhFsYckfahJ1QkDDHu+y1N
	zhkmLC1CGKEHbtyhrjRpfcWviucDSdeej8BVAnLAuFF78Nspa8pc49Q8
X-Gm-Gg: ASbGncuctVzWEolLCZDx3bkc/FKkt2f4FgzUE3kjia2AZdfLFvLSlMN0Q7INCovTSPR
	VQpgHmxPaV38pzrfycgnY/fpavtmu8BbKpV8bRvd3BkI/YPG2Gi4lbfNkHiODVUvq5sPVywKBCk
	rJFcFVBNCZfTrObEL+JvkUBCN4BGEFHra4alIuMWY03lZAoEZcIUX8093xiuIptog4uAw8P88IU
	I6Gx2G7ZvXX5fgcGzvl6QBy8yZj0qggqVyRb48b2B5nG/gXpZjdSQ7I+N08HgxqG2eBrCdcjGCB
	3qcDPrwpMNtTg2XWhFiYcimY7EQoJQ/3RcNYtwIUN2o/VaVl3R70pIgdzkhZI5F1X7B/lSC1cv2
	r7pWw5w8zy2yGer6J4TSF1OF5d9rRP0kHges1/eH5y8buKQqNw3F69exElA==
X-Google-Smtp-Source: AGHT+IGc7TXpRM7rIBs/KpzQNu08oMaqlYYUm4E8f4HgHjSp2FZ4vFD+byutu6dJUmsCyMjNMiob/Q==
X-Received: by 2002:a17:90b:2d81:b0:32c:7693:1155 with SMTP id 98e67ed59e1d1-32d43f2f29amr8015933a91.1.1757314896992;
        Mon, 08 Sep 2025 00:01:36 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d89f32ebfsm1705683a91.0.2025.09.08.00.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:01:36 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com,
	Pratyush Yadav <pratyush@kernel.org>
Subject: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
Date: Mon,  8 Sep 2025 12:31:24 +0530
Message-ID: <20250908070124.2647038-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strncpy with memcpy in sm_attr_show and explicitly add a NUL
terminator after the copy. Also update the return value to reflect the
extra byte written for the terminator. This aligns with current kernel
best practices as strncpy is deprecated for such use, as explained in
Documentation/process/deprecated.rst.

No functional change, only cleanup for consistency.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
Changes in v1:
- Update return value to match the extra NUL written.
Link to v1: https://lore.kernel.org/all/mafs0ms7bvcd2.fsf@kernel.org/T/#t
---
 drivers/mtd/sm_ftl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index d28d4f1790f5..3c5d6d0c728f 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -44,8 +44,9 @@ static ssize_t sm_attr_show(struct device *dev, struct device_attribute *attr,
 	struct sm_sysfs_attribute *sm_attr =
 		container_of(attr, struct sm_sysfs_attribute, dev_attr);
 
-	strncpy(buf, sm_attr->data, sm_attr->len);
-	return sm_attr->len;
+	memcpy(buf, sm_attr->data, sm_attr->len);
+	buf[sm_attr->len] = '\0';
+	return sm_attr->len + 1;
 }
 
 
-- 
2.43.0


