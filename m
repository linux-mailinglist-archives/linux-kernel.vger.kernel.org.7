Return-Path: <linux-kernel+bounces-747214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB2B1310A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3161893A67
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A271221F00;
	Sun, 27 Jul 2025 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYP4KFZt"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093178F2E;
	Sun, 27 Jul 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639286; cv=none; b=Nhr9cOxGtDkF50YnA7h+U0mNMDiWmQ02kSbCE8abpTJoQQCPAUBDK0DqxND5Kcn/rsNDcbIaX1LyJ/9ORXZwgAIn8SqeWh6H8NegiR0MPsT0rPCVx5/gjvB5msJmCg7Ke9NtLkrDJvjRPDljqtCEdfRcunki+zMQqSHgHnkihHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639286; c=relaxed/simple;
	bh=LI6y7ozJcC8Or2supKfVMbgMM+uopKpBzephb7b4Qas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7jutHBq6TfPAzUSLuSu8RmM36YRw0kRzpDLeav74chVolVTlNlM6qYMj5CKM25vegnTKgJFEq59bvub6glidHgmIkRgOOU6bQS2umOGsI9tXoifQjfsILxB03olV4TdqZ7X8b2E1DPn2NXuLyaMOXxdUy5QaPhX3EYuPQUbb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYP4KFZt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7426c44e014so2940966b3a.3;
        Sun, 27 Jul 2025 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753639285; x=1754244085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XocR6rTOn05yQM1S/WcSN7hOFbXc4E7TYH6NfvZ9v4=;
        b=MYP4KFZt38+h0TFv/mgx+Akyc1UYNoSiX3ff8TmyVy63XVNTqfgkbQwLZt47qgVPSa
         8fIKYohxAlORq5hV0EvWnUAlbSL6h9e8ODD3+pYmGcrFlBPguc4Q90MfW7SWMFumwLhI
         nfXKZw3Glv4SRh0htdFTBqhVZFl4av9vQYNslciij6ERcZaDogheGFgBuDwDL6dn00nT
         9xbRwhyEsFFpHkIdBnXLlVpP/7sdl8DUXvXfFPqFb5zRtaWzVUIkzyDuBBcjO8HeK57i
         HnQGj3dDBEsEsR2MZamWGx1Pz2D+h+UbmmXepcLuuwzAls8ksZG1l5zo3CBxOw1sZSwM
         Rgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753639285; x=1754244085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XocR6rTOn05yQM1S/WcSN7hOFbXc4E7TYH6NfvZ9v4=;
        b=UuYUtmArkbzfZie9PxmaIHQ6sssY4CfTngyjyyZz5dx5KsDNZBhIexg+G26b8dZ8Xe
         SukTUpF43GFAJuq0heg68ykoYkqlQQ8E68DttXRWxFgfrWdlqCk1rIteCRAv7Uxoqxz7
         +Z1OV54XlIL7HjA1w5fuQMgkcJber9L4kod8bhqGLlk6mLZkpeaTTVaAA3QDm6e+wIVe
         12hv8lUxpJlYiwlDZbOUxGD7IWbprCoiqxcgH5NmUES55MRoqgK1cZKAPaf2FD1muyou
         mpPVaX04rabpA98qUfdXr4SM7VFb77BVl427zyt+H5brcwk8QUpAHKAkZJOw3yrpovkl
         /DUA==
X-Forwarded-Encrypted: i=1; AJvYcCXRCTN/lKJh6utnCPwLBYzZwDP5pwOPI6qIHrMYleLjYWmqJmyMJB5V58PcKHW9Bu8nSc7OqnQCcbRB@vger.kernel.org, AJvYcCXtoA+0A2OGk8/VsisxH0UfOJvJnTRoy1Lu33fU8a5drv679Fkr7qNjdRvP3q7krqAwJ8RvvYC6+mo0Jrq+@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwQCtK1uN9eXH/jkchHWjrTWf5nmczVa+YbCqndCL/J7ee/er
	q3KdrE5+Mun2HIou/zEyTYsSzYHs5aLOVQoMwI3UFfDtzhOsa5v1ElOb
X-Gm-Gg: ASbGncu0QtRzXFCEafcjuUu/zBp1k7Y/J5ybr1DiQO69F6pjoI/8x8ldCDVoW4aZS2O
	RGnyAOpJ9BmcxHbTe6kwb8TUPgU7gIDls9XkwVxRT4fbq+QO8m4ulHT2XycDcCR25NoDo7z+W+S
	E2ln3cnzT8tSvble/Vr0/z9b+ZI5rJR5Ftsuh7pb4FYE3lE+U2SmQ0fXgwWsmN9dYv2CrR8ESIp
	ouqnssUzuO2DcVmVRLlq5VepM4h5hoX5LVbWXboeTyK8KKYS2JJ038eeRvn+Xwf9DpfQ7gNAZwv
	8gbR/h+i5a0pJgYI1hKMqzmRxxK1uRywcOdX9DxC5AiJaTUmEDK/2PC9AQ6y/1/BYKmvECAvBv0
	wsPNQMgHQTWaq2GD1nHGPME5T4QgVM9G8tt66yOrLWUyr8LhNeWpmO8ebA8107i31Kv+PE08Fs5
	I2OvI=
X-Google-Smtp-Source: AGHT+IGpFW5gv7iUfyBGK/ap4jGIPXnlfskJyfh3p4UPAIgAAzqPgMcg+xV0hTkIRH/c9+koaMyrhg==
X-Received: by 2002:a05:6a00:cd4:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-76334bacc1emr12831116b3a.23.1753639284500;
        Sun, 27 Jul 2025 11:01:24 -0700 (PDT)
Received: from localhost.localdomain (61-231-19-160.dynamic-ip.hinet.net. [61.231.19.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02005sm3826482b3a.36.2025.07.27.11.01.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 11:01:24 -0700 (PDT)
From: Joonwon Kang <kjw1627@gmail.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: nsaenzjulienne@suse.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joonwon Kang <kjw1627@gmail.com>
Subject: [PATCH] of: address: Fix bug to get the highest cpu address of subtrees for dma
Date: Mon, 28 Jul 2025 02:01:00 +0800
Message-ID: <20250727180100.15961-1-kjw1627@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function of_dma_get_max_cpu_address() for a device node should choose
the highest cpu address among the ones that subtree nodes can access.
However, there was a bug of choosing the lowest cpu address and this
commit is to fix it.

Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
---
 drivers/of/address.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index f0f8f0dd191c..5e984e0d372b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -969,6 +969,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 {
 	phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
 	struct of_range_parser parser;
+	phys_addr_t max_subtree_max_addr = PHYS_ADDR_MAX;
 	phys_addr_t subtree_max_addr;
 	struct device_node *child;
 	struct of_range range;
@@ -992,10 +993,17 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 
 	for_each_available_child_of_node(np, child) {
 		subtree_max_addr = of_dma_get_max_cpu_address(child);
-		if (max_cpu_addr > subtree_max_addr)
-			max_cpu_addr = subtree_max_addr;
+		if (subtree_max_addr == PHYS_ADDR_MAX)
+			continue;
+
+		if (max_subtree_max_addr == PHYS_ADDR_MAX)
+			max_subtree_max_addr = subtree_max_addr;
+		else
+			max_subtree_max_addr = max(max_subtree_max_addr, subtree_max_addr);
 	}
 
+	max_cpu_addr = min(max_cpu_addr, max_subtree_max_addr);
+
 	return max_cpu_addr;
 }
 
-- 
2.46.0


