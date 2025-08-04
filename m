Return-Path: <linux-kernel+bounces-754862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C248DB19DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38527A50A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5923F295;
	Mon,  4 Aug 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeCrmvpe"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413851E25EB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296206; cv=none; b=ng/GGTsRoJV7/FT88xRbof5bR74OVT5FVI4BM3yvIg0lcQzL1Xr5xIH0nksGfK1Q31xcBQYY9dxGP4UIGstLVsi+7/EWsvdhbVabKtg3GKf0rh+1vtWdYu9WFtvGZGU6zEFfv976anmRa0+2H0bN8+Q5vAVmlPys42CMxbMdXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296206; c=relaxed/simple;
	bh=G+Mk69SwhFZuF/HTHTi7oDBwppiwd1hxg4Ip6a8+5Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ga98rBvh9n9o8vxLg5j12hbiaurz5l6DS5nEfWUI/K/ell6TCs796j/8IK+uApOqHe/alQee/2plklefQvllfnlOUS46/t31WZe/TrzP4vEhtyAGPU0k6/M+jmK4w9zxjMjGlyDer9dsLj1u84ceK8sEqe2tATMpyyZxq8ZOrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeCrmvpe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24099fade34so32383655ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754296204; x=1754901004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3/zEyQGXGJNDQQQDdwGDRN3V31t4I9e8LP8T0bgzPo=;
        b=CeCrmvpeaXbfiH1vxs+QVp39WMjysrnocGoCAEK3TQrtD+SZCsid2kixU94pYq3O7m
         ctTiFlICZ71uesFt7MS9v6fcDKMFzgdx30zb/XhoFCCPMrOWdf8zl7Jb+hb2ZZ5Raj/G
         tkKuTXPU/oKfM+iXEshSOpMjkraAPS02eiZC62Pw+uGfbkGBmuySp7ptXR1/0RcMNA4U
         Bt3dc8LVq/kRrzCaiQtQg4O/qz/7VowkmGhGiEGyktmWcq0IZEHnw5B6dkgEr/p5feHw
         MB/VNsKzJcVQtdpG1mgpVRsl4f4aLGbj3bZkLflDZa5he5D33B3DMNfnOQ6Oftf/Icpr
         3CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754296204; x=1754901004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3/zEyQGXGJNDQQQDdwGDRN3V31t4I9e8LP8T0bgzPo=;
        b=jo2FZ4k7HpjxGo+tN4TnygwYc0+6j6X69dtT+f8aMRxpjPDAYwF+bBObEYACYh8+VQ
         0kohQ/ktFZhpVUEN6lzhY6eQbtUIiNw/ii3lj2l1Gkug7mOBgDq1bJcpZ7lDN0gY1doh
         uKqpL9ALUefX6H2xpjfl1Tcttzshk6feuv/pRqnRcwqD2PydGvmoJDiTHtQ4dPBcbMfX
         J1DAXLWGNK2/cJBrU/5gf+Qms7NrPZOX2CihaGMfkfXpfdcAMRXVXYdyumC1ezKV5lCi
         G4oQ3d2nZIqJz60a/IxRFKM75tLtM4RBdt8J+gVu+oHKEpmVJ0eHJnXwTetkK8WkdBMi
         YYrA==
X-Forwarded-Encrypted: i=1; AJvYcCXy+FL/UhYQpq5LrIvguFQSyd021vxYG07jXxSHQg8x4lJI8rGGrcRzTFP/0mxYxVs3Z+yOQSgST+aTk64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVg0ULwDf+IXpTkNTqqWD8pKGMXsSuf2c/VCXOYxxDH3aeU/5
	F+JoR+LsZJsM8NAqwmhM5EZmN4LM1EKVfIGQNwA6hmuPmwn/mT0kWHMU
X-Gm-Gg: ASbGncsA9u+dTEInDieXtMhPMHHw/5ZJRmVNGhzRG0piLQHfwRxRby3r8wO6SFJGYZ9
	sxGfWZFm20ToDZUlLscAj/7Cjb13uWzU+bUfhLuVY0tAN1wddDoODPyft2YO6p1hEQJ7sX+mXaW
	6wShMZujpglTTsVYeDlJp1RN+UyX64ZUfJ0JO7TZz90LeBu/hskoIHMAES3LEePNVOfjicasLkO
	FsTaYEGTQYIi22gk+5/GnnDenVoVWXDyqMfOU+RbjYNznoqSUBnbKAlo/ZbyazZfWiIouAiIcn9
	uqdCYYB5LCS54JrNdZIqjzsTOdLhGwGChktI4r5OHXGNp7AKkEeQr87vFzCky457feEfGTYWyUP
	lUdqW6ltpubEm87I9ybgKEpH/
X-Google-Smtp-Source: AGHT+IGXXg3XsdPzHMl+fAQP0WoV75VlRcNEHw3qdq2069o1heoW4eMWgWysIaradBNrhJE+LOUbJg==
X-Received: by 2002:a17:902:f08a:b0:23f:cf96:3072 with SMTP id d9443c01a7336-24247004a08mr74844375ad.26.1754296204464;
        Mon, 04 Aug 2025 01:30:04 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e8aa8e0esm104935915ad.151.2025.08.04.01.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 01:30:04 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] most: core: Drop device reference after usage in get_channel()
Date: Mon,  4 Aug 2025 12:29:55 +0400
Message-Id: <20250804082955.3621026-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_channel(), the reference obtained by bus_find_device_by_name()
was dropped via put_device() before accessing the device's driver data
Move put_device() after usage to avoid potential issues.

Fixes: 2485055394be ("staging: most: core: drop device reference")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/most/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index a635d5082ebb..da319d108ea1 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -538,8 +538,8 @@ static struct most_channel *get_channel(char *mdev, char *mdev_ch)
 	dev = bus_find_device_by_name(&mostbus, NULL, mdev);
 	if (!dev)
 		return NULL;
-	put_device(dev);
 	iface = dev_get_drvdata(dev);
+	put_device(dev);
 	list_for_each_entry_safe(c, tmp, &iface->p->channel_list, list) {
 		if (!strcmp(dev_name(&c->dev), mdev_ch))
 			return c;
-- 
2.25.1


