Return-Path: <linux-kernel+bounces-875882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B10FC1A09F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBFC464004
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F998335091;
	Wed, 29 Oct 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WTi4wd3o"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01E32F765
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737251; cv=none; b=nVHiJeFc05TuOpIcjCNh1mWc/aTNaWfJMin2kMNKXbuwbbzQRLbi+FmNwwx4twVEIhnGts24zVjGP/t1W9fC/5wlLTfdWzh3vFY5P1H8ExLgLCRzpq29XxpSacxhgDh93cGxYB9rjCHAiXYsx/dAE+IYD0QRj8TgA+QHqUueZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737251; c=relaxed/simple;
	bh=TSz747FjNEhM7uf1XzqCJ/IKzP85Xywzfa1M0ZRoX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTccwmaoVY0X9p1hYNXAxnKTWSfdw2xsC1cG26YYshA1uQEcOzrDUUuWWOjzU4+PGqBkLam9sFccAvGv31Dx2NS15w7D8XPehaBgj0DI7ZAwuotDCK5lJGhJI3NWz5JYO/3EWZHGEjAUk5HCnAZeMgYxqI4B+YMHVQIUnS5ft+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WTi4wd3o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781010ff051so4875452b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737249; x=1762342049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=WTi4wd3oXOxF8q1Jd84m90kQ33Jx02mWFL06AgA/izDdMv0Wgd7ehAWAQuteldL+nM
         wOVL63CdMbIZ+63TaJH08k0SPDLF1j/zbgMEYA6Lr4Carul3Vkn+vghCZEquZ5S55fba
         xpwTanLyB1ge2YZSiltHVjk27vyCC5uRhvLVg683NZTFXJ7lyfluZfS33LHyC8oMq8K3
         w53Dt570zmJTchho7PdkgUGjHk6Hc8aZ8glzvYaN9bQyV/c4NZv0deviZyX0MumrDzgX
         VHoiqlC9nVqpJ8w9rQsRx+jqdAWBljXFQ0bj0HKI1T2VyL46qR8ptlGORZfgvQfU0UqH
         N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737249; x=1762342049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=Ui++9J5J5MG3eTAYsr11d/5LWaZ6b661v+Vmx/CMIXLkct+hwG8sUSAIsSr0KxdLBE
         uw9OwQByTG60631VONGy2prIbkyhIxvVDkWVoEMRLkM5tZAhm89Pg0it7OGExQSOe5JR
         YBFTJN5sTHrPJFevhRfUNURftM/nN1GVSnmLjRNMXLqKesuuWt3VGB6Dr4QG/mDY5cDd
         A/LmnpelpLfgo3+tArA3YWnFA4i3PioOQ46P6oUNmIxatNqAIWpA9XD1UTarvDIo9+5y
         077TGTsECmkqVz8UxGf8jvXFTqyRbtB5ynj3GeO+nvQckGgncj2zoOyMsp/El/Z43Slk
         t1gA==
X-Forwarded-Encrypted: i=1; AJvYcCX2IzUnWzHnnsoy40+DuCbmBPHfRpPHpoSr/13Jta6htUOlHr31Yg4bv5688ztNDayULC5KL2w7x5s3+LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIeyfMK7N+NF666PmV0InxYMQgNXbJo+/2yr+COoBCMRShjdxO
	TckrX98rPcsI5zoupSQlCa6HYo9fW8/YBzoteAFSSp164Bwg8CioYtH3lhxkiJNNwQ8=
X-Gm-Gg: ASbGncu5VAj2f9lxdeY1yTX2JjVCRKZhiRebX4fZeDtpbnSMgZliUGMwcMVeanM1kZ5
	EWuIAUqo9LiZVMTwwZ+x24rhbX5hD1LrqQ1XiQEVWB4EEDVH7Uym2CToKmLS0g2SSkVX2P7j2wt
	YTQAzCIU2Hub14jfzbqfcqVXiipL4h13J/ksSV2/5Yz3OXc2Ey+k/rri6g1GRVovDzWkS8ks1ps
	kqcs9OMA/eFUWVHIk9jcFu1XdjbtRYPwlE7yBFF5YvSKD997d97cqQ0byf4lb7PUdc64BSBsvps
	RJYeSl9pSjFD6TWc/PraI4pHMlVRWKFXV17Yo5Jm8rE58s4/4aU20VWt+oZ5aRPuWQQFBXI5g7w
	vD0ZCqWpXBAte/Vml2K6Jbs84IejRqLFMQ+q2rSxSv5vZkYeT6hDRy59yYne71hvcdWcI5S5xq1
	JZJyrx5A7YH60tgJqfdY3cdjOCSSlI
X-Google-Smtp-Source: AGHT+IHs9/yah7+LL8dEcqJhQQLW+XK5ngSWHXrirtA5CcwyDvBqFPLqGRdj2uDT9wLcliFabWN9TQ==
X-Received: by 2002:a05:6a20:4328:b0:341:ea4:b977 with SMTP id adf61e73a8af0-3465381d8f4mr2997177637.44.1761737249215;
        Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:28 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 05/10] riscv: conditionally compile GHES NMI spool function
Date: Wed, 29 Oct 2025 16:56:43 +0530
Message-ID: <20251029112649.3811657-6-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae0..f2cbd7414faf 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1356,6 +1356,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1374,6 +1375,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


