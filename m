Return-Path: <linux-kernel+bounces-867335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16459C024E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837C03AF7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B926ED5C;
	Thu, 23 Oct 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD1O3/eK"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A21DDC35
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235459; cv=none; b=OcfQNBA0JF5+gn+yTztLbqVjvG7cEdIHyurI074sC68G1hcr6Nzs7NlRk0lf/TxaGKeyX/RWg1AOuvisSeKeDLeawNUCIiv2mshBwYAQJ6RY2/cn6zdYycxKYQ5EXj4BeCbzsQ7a8nK0g2Phr0wzptNP33FDidR1FmXjgtJImzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235459; c=relaxed/simple;
	bh=BZs/EKkft0iiyczp7niO50EAP/xvjEqxKm4Yz1szu7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kadq2NvfH2LhlTgFm0kVZhWAVMePguwm5DKzF15+zcsfJxjH+lG8+kitf+FYIijRuWBOpIThFmenJ47HSHJJJ2V2b4YrdqtJnkymsQ11jaJ/6vJfJmM64xgh6UpuIfHTusczmkH0qiC9smpRuKoUIOSNTNu5Qnj71t6zkz2ISAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD1O3/eK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1103365a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761235458; x=1761840258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qh+XTkdUsVoqfUCJ1tlaETEztr9dvLetJyhEnaoDJ2E=;
        b=XD1O3/eKCa9gtdjCCVrb9cUSrznkvswSr8ngKuov0cBWSsv5U63026rt1l5WXuadh0
         JW3iiUY1LroUhuv1ZZpTwQlIky47u1MX5dybUuv1Ow30/O+8JDp7SOWNhkKVMqZtX/3C
         9D5zo/DIsXcf5g1yDjzRRZ2qSsvuOgv97EEUW5JNkWWW6DgX0vCcf7iW6DmLOvnWlxMw
         fNzoURuBqTe/EMSn8gOS3bOjjV+B84xKZFWzNK6Rat1eq5z7JW0RjlKhGABRNuSfHVbw
         sBMy4/4TCWGyFQ8R1bGWSucPPxGhkUI7xYycpDpKmKYCs3tAlHT8UGT5BS8FGPbMlGmk
         d9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235458; x=1761840258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh+XTkdUsVoqfUCJ1tlaETEztr9dvLetJyhEnaoDJ2E=;
        b=cbjlPrJtEyU99/uXfQc6fc2k+HKVIk6he6WoXFPf3NjmHEgjLGltLJTKFNiSOVsOj7
         yomUocWacllMLjvslm4TAtLQhdaTXlqLxHKH/3OuAbtZj0w6G7KhZ0+CXKf52ZS012Ky
         sTn/BgUo3TqAgi76U7vDbvqIj5HiunmI8zJlshj7HQuyIHTOYBOhAHNjcjjUP/8Y+1k1
         UsKv4q8xoj2W/wwGE9km3Y0LdtBnrQ2cqVVkVbYkF25Z7JCuAB/+Sfm6PIDej4cf4ObH
         GUT//1IfujTvW8pfAxQ+7/2bF910ywmXmNKL6wQfxfi8SVQsRcX+OHp8uPARDMFUwdlB
         4mEg==
X-Forwarded-Encrypted: i=1; AJvYcCVi8gvaBNG3jsvWwbcgX02tv1qTtdDuXLsTRR9vwCAW3UEupTh3HOGNNfdiYqoSaQk89CDlNrjgxleNAkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjA/aFQkZAzc4kEs0b4MEzUDRuMmVvES+cAe6yUC14hMd0JYA
	NkMJE5ULeSiypFMRS1ONxK54iPM8m9aEd8ID1QJ+DW1oV4z3BXfsTGSY
X-Gm-Gg: ASbGncuWvxQaMgfVTJ9XY1rBNprCOpN+Itw6uZKY78p3vvg4z04njlLTt10FCWMOWJ6
	TmonuIHmDndhAi0IqPg4Ilmu8Zjv9kxftCApVqU5smh0IhdsDnBD5Igp5sTvO+VvBCBbxbJSvwo
	Mh1KpcpXeIHZXK9faR/gr6VDmb1Ea6DEFawOhhjIrwF62OcN8qYiziKLdQnThTMCJeWn+ggfeDh
	LXJbP5MnXVDEWQ7yJJc0TndmeNln2YiZt2yYyKQI8dhr4zgjJPqlvWHP4NE38jdPjH340wYkZDH
	WCkU1CSIUToOO05k13JwJOK+rWP20TPD5eo0ZSEBX1qxX6MhdY5IWr/O/U+CcNmVIPBYVDHzUhQ
	6q9As6qaMCiibbDwo5xw5QakGAYhdL+QSj6ZhfwuYRte0yIzNxcidkb0F9gGAiAkZGDuI/uwTLx
	sTa2RwuldZXYNV8ITR1ZX3hshz7UANn0iEZg==
X-Google-Smtp-Source: AGHT+IEZI4ev2IBH4muhdtA8NDFE8NYLvVDhQkEqcYXbzc7+4M5oYKr1bimv/qoYUS2iAVBmMesOAA==
X-Received: by 2002:a17:90b:3144:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33bcf919094mr34693477a91.35.1761235457698;
        Thu, 23 Oct 2025 09:04:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37afesm2815913a91.1.2025.10.23.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:04:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guenter Roeck <linux@roeck-us.net>,
	Han Gao <rabenda.cn@gmail.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH] of: Skip devicetree kunit tests when RISCV+ACPI doesn't populate root node
Date: Thu, 23 Oct 2025 09:04:14 -0700
Message-ID: <20251023160415.705294-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with commit 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by
probing DT devices when ACPI is used"), riscv images no longer populate
devicetree if ACPI is enabled. This causes unit tests to fail which require
the root node to be set.

  # Subtest: of_dtb
  # module: of_test
  1..2
  # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of_test.c:21
  Expected np is not null, but is
  # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
  not ok 1 of_dtb_root_node_found_by_path
  # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/of/of_test.c:31
  Expected of_root is not null, but is
  # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:1
  not ok 2 of_dtb_root_node_populates_of_root

Skip those tests for RISCV if the root node is not populated.

Fixes: 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing DT devices when ACPI is used")
Cc: Han Gao <rabenda.cn@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/of/of_kunit_helpers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_kunit_helpers.c b/drivers/of/of_kunit_helpers.c
index 7b3ed5a382aa..f6ed1af8b62a 100644
--- a/drivers/of/of_kunit_helpers.c
+++ b/drivers/of/of_kunit_helpers.c
@@ -18,8 +18,9 @@
  */
 void of_root_kunit_skip(struct kunit *test)
 {
-	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ACPI) && !of_root)
-		kunit_skip(test, "arm64+acpi doesn't populate a root node");
+	if ((IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_RISCV)) &&
+	    IS_ENABLED(CONFIG_ACPI) && !of_root)
+		kunit_skip(test, "arm64/riscv+acpi doesn't populate a root node");
 }
 EXPORT_SYMBOL_GPL(of_root_kunit_skip);
 
-- 
2.45.2


