Return-Path: <linux-kernel+bounces-857800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 884ACBE7F81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55BE84E8101
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF326311C33;
	Fri, 17 Oct 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IerYUUVd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F6310625
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695675; cv=none; b=s20HCefweS7+e7HkUnFBclXj6iJuilhWZbomTqyKGa6j1YVLJWVuZxyWQwVbJKVmUR5r8Wgyz/Pe3DjNMTszI8KYYZk8O0SDDU3bbIC686OnhEIWdp1BMLqK4HIvd32bEZt1V6Gw3yDf9VI0V+QqNKiRDbPKZYG+bneSIigBf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695675; c=relaxed/simple;
	bh=IyWTiQNF25BYk2oQublRhbi2VYkn4hoGCVt/bUMoH6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tShd3DLuQbM76pKgm3jIui5dglsM6HrlrKKepndPvndcPEJBjqGSceDaVGZ1egStRUZn+kJUB8n/mrXJU5XY51fVTuvmE9K9nNnJCakPf9Qjuji/SKqq2451wwy5dKEpkC+n+jqKidCcVoUy+S41MowCsv71eC/IP7WKpTXstLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IerYUUVd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7811a02316bso1266448b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760695673; x=1761300473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGe/CRT39ZQFPjeA+jyXUuqmmxANn1zMrtmj+nPNink=;
        b=IerYUUVd2VNRUVztq/SSejqP75P9XNuWSiWb+rrU9miCP5h5pHQFZzgRZkhTJsLg3z
         jy4w+SVXHc1FEPFkfNaoceeexi8QWwfM+TTJXQQXZ/D2P7TFsG7plHzPkENWn342UT60
         j4XHb4a0UbN+EscpfuJSQArLlsNbaC70gALoFD708i0weeK/G5Wfte54GlVLRDMZXqxd
         ioyU5g35C1tNy1XJcMrPfkTSKbkWOzOawZcS9qRUGtpyoCtK/nmFhoPTNjE70cHIrlqa
         j4y9mOJa15l04M9hUzfOfksUeLc2j2ZCmxMEy/foLH89FzQ/SFjgXDLY9H26JO6rQNWA
         ZXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695673; x=1761300473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGe/CRT39ZQFPjeA+jyXUuqmmxANn1zMrtmj+nPNink=;
        b=DWWsWnNlt/Z4jZkvhJMUDqyWC/JW4qmugKGqM8e1/SQ9aPDpq1BN45HSxhnmCPTscG
         rh+B/nhNErGl/oaqyLyO6DG5yeozziULBMsfJKdou655QEXwEiAY2MeyW7U34rpifO1l
         LvDQpCpUViEYrFimOKtys3eBpUEWZyXpdfudPVhnrIXFRJ7S33c8L8F3Q+30WhKzJ02r
         Ehfq5tpXpbh0YB8F2VwF6PI1YEq81eIkg3IkehQLUoYVLiqpcpwulhqXDmQWkYDQAwNv
         Nhfh9+iEQRu8AoObnvH+gJbkntKyAgd+kzrlLhalQ/R5LvuLtEFl7W4DLoFyvFy+pkIk
         y7ew==
X-Forwarded-Encrypted: i=1; AJvYcCWfBJI/Hh5KGkrI5qEqUlMYXxwIaKQA44uXj4Fv/vc+RnAjqkI+k63gHiTVXDTiJ21rlMCQ+ZbBjRXaVZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbYPpMGRsZuNfBZmz9h316WS/7+giyLZworFte4A9VnQXD7RH
	UJqt767Ka3lMK1gUfaJIz0uyOc/gLQhLCwXX2ik9+GRdzlS5veIg78DBWuPB0qB0gxo=
X-Gm-Gg: ASbGnctjlM7UL0eAmcuVRwUUg1+ziKrAev34AbxIQdt+EujOjgozNqVqeDwsPBXQjym
	1r0vm15CrXwTWP0LGiudfLKLsehslbtp5eZVR+EPMKf7nDsfZbTvjePJN4CLIWm4X8HOha0KmFT
	qJSPnOBSUUTiBFOXFdje44raed4J9m8kA0QgFp9QX+W6gNLsV1oMudBCtDHtjvb5bTSVyHluO22
	lKbY7KvR2hORCFKUPQWSdO87kOpFPd2EvGPs7szPYNO4gCYda/vWx0F5ShEq/MjTmJw5f8b+3M7
	4hcElRo3P/hsSUMTDepG20SzEzz/JxljBeiEbZ9AI4a4vGF4TOZL3yqARAh7pLOpL18o7ojoXY2
	1NjOuUNwSzMeEgmY7ZvIJ8fCYFUewBgHqwO3lGc3lm0TggusgvnNnf4ai9ePDq7a1pWyQeNLMpn
	38AJyMO5Mz+BD4KgV92hY=
X-Google-Smtp-Source: AGHT+IFYdxhdopSeCt1Ue9AYvkyQWlrnVCBo+RDvUTTSjKJXSA/CgP5zTKZtZzV2zbMC7CPhk5pG9g==
X-Received: by 2002:a05:6a20:3956:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-334a8504834mr4672273637.8.1760695673108;
        Fri, 17 Oct 2025 03:07:53 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2472fe0bsm5092826a12.17.2025.10.17.03.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:07:52 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] ACPI: property: Fix argument order in __acpi_node_get_property_reference()
Date: Fri, 17 Oct 2025 15:37:44 +0530
Message-ID: <20251017100744.71871-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A refactoring bug introduced an argument order mistake in the call to
acpi_fwnode_get_reference_args() from __acpi_node_get_property_reference().
This caused incorrect behavior when resolving ACPI property references.

Fix the issue by correcting the argument order.

Fixes: e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args() to support nargs_prop")
Reported-by: Thomas Richard <thomas.richard@bootlin.com>
Closes: https://lore.kernel.org/all/1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com/
Tested-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1b997a5497e7..43d5e457814e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 				       size_t num_args,
 				       struct fwnode_reference_args *args)
 {
-	return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
+	return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
 }
 EXPORT_SYMBOL_GPL(__acpi_node_get_property_reference);
 
-- 
2.43.0


