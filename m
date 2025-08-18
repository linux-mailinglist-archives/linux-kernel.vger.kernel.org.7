Return-Path: <linux-kernel+bounces-772820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63FB297F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A53B9DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6126A1A8;
	Mon, 18 Aug 2025 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ga+12Ceg"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310D26A1C1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490333; cv=none; b=PHYMmjQFvQDKL7rd4o+7xnkYWLWNzI+Gxj67OwApJmLVfBQ++u2rpqonfvrvawhzHEMJw4IUWSNXL1D/BrKF8t3OQF7RNVjVzLtEHzzDCCcmgd58dpXNViENnqOKuak4X3fMeH0vi0WI1xeNOC916ag5AGJLYUDTmhQf5rEjAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490333; c=relaxed/simple;
	bh=gyloqI7MRNxMKJRKLrjy7BLm1ahzB5ZyG0rUCvET9Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+i4HaddGnKuByHJ0E8SkMPs+3XAHq99BU0IIf8aUaUrXhlq2b+Irj4jlKphemyUXb4WCrSq/ZG+21zCvVOz1pXPULHiHZP5sx1b9WwLlVVVEo1yXGjs8v6fnw7WAP5tI12p0sPCXZkMZWIAVoUz/n6TobNLbTJDePLawi82fag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ga+12Ceg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so2578067a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490331; x=1756095131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euEEBnJ10Ul0dBSAcTDiXwaw0u7DfxF4JtogRsP9Xlg=;
        b=Ga+12CegOv981tW7PqQbRZsm0KJysI16DSQXVpv2HnKMmPXLajzwZADCx47GBJifqf
         O0QMnH1kTt3eF/DIm2zdq8h7lYRHOL8PEQwGles8RnDAACWXMfmRfuXWOTHEcI+fWsk8
         tfaKX5KKQY7WYofJnBqzA+S+14Lve3sBnLTe2QWqVOmRx3R917exPXFH2+2G8mlA9zfR
         D6s1WFXw9XHcMXLd2e9w+hKy+SOIjl4f3NZzuLe1nEOpXp/iq7tcrcZXpIr4GUXZCNEV
         ZvnWH1mZBD0vqVwFdR/VyliJ52IjNvxfUUu1BJJs9uGUKqpS2LD3vHBZFzSm4lg85tLz
         cGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490331; x=1756095131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euEEBnJ10Ul0dBSAcTDiXwaw0u7DfxF4JtogRsP9Xlg=;
        b=rTBKt5q7Ocxl3vy435Sdie1NyYF7ZN8Ypkaz6m9ITosQdfcTi0JBiQAaJL7blx+Bqr
         MW1FVLsonmBmNepdJITJORqJg6OouXTwSUlvjciCFCOXGJRNJkZ3m7RCWfsKRq6mYZhy
         OYFVey8W+P2EMMYoHJ5SVZ+gY4OZfHDbhJIOnIsGq1ZB4KBxk7kquqNukAVNJ66J6Hm2
         QPBQ3sALwS1HXacHb1Ai6pNUq/s9VbX8giDrX1EE2jfnx6ozGxVu9KC0WS8il7q6bzpD
         SzT8ZADGZ9AIxhHRToUYrVzYtqNYU/JGxfT/a5Tpa2zHwPfKmvY2lkbxor/hajkjRIu9
         EH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPENEGMt5a9hZVWajfn8/6+sVkBmAOEcWHwBhAEMjQjlNaN9pQJkTTQWZn2O6cQuGqNOm+u7RgH44zroM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPUDBrpsu//cWA9g1Y1U3VhWYeKSX8+V7+m1uElg+S7HYz2gq
	Uu5SZjxm4v8m7kjhUuy61vhNZ3YlmpHV1DkrD3bj5vO7yc8P3NAY4tl6TPwiV3gncs8=
X-Gm-Gg: ASbGnctyXZH1BFgq8PlpSOqwy5vLx6fnffvn5KAqhRlV+c7BSjKupKdLt0qJFSjzQLs
	0a+Zqyx6rQGfKJc2y2T925kRu6y2mEp8FLHCT5fnBLThq9N4waX+e0kJOf4kUfd/UyJOE64dgio
	+vPbG1sCpUWdjVGkk/ZldCrE1ksg6CUP2siFWd9mOaoTVPYL+tK+QIl6hECb3XmBi9H+E5v+T3J
	D10Jw5vJ3u65KCGtO562+t+8VkH4ZEfCkDZEdZvr6/RdRfh0QILUgfmf8gtmTs32ufC7+SSpFJv
	7JRu+3zYzi9M/ZVsDFvwOQlvqdVPKqhrJI78xhz2CHoMxv1lXdgdwsQOFONBbcZXvlteDOIpp1l
	zOtetvCNC10bFu00B3wf8bIJqNMNFS5eTQeB2x+s21MIF0/N4FVP+l+gdQHd3tW2H
X-Google-Smtp-Source: AGHT+IEbCDpwORPaaFZ1NYP5UlV84IBgHfNrd/o9UzgQMcIg0DT5gPsfDu8wRZ7EeXNlc9EJa4PqPg==
X-Received: by 2002:a17:90b:5343:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-32341ea8b2fmr14321856a91.5.1755490330522;
        Sun, 17 Aug 2025 21:12:10 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:10 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 15/24] ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
Date: Mon, 18 Aug 2025 09:39:11 +0530
Message-ID: <20250818040920.272664-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Currently, ACPI does not support the use of a nargs_prop (e.g.,
associated with a reference in fwnode_property_get_reference_args().
Instead, ACPI expects the number of arguments (nargs) to be explicitly
passed or known.

This behavior diverges from Open Firmware (OF), which allows the use of
a #*-cells property in the referenced node to determine the number of
arguments. Since fwnode_property_get_reference_args() is a common
interface used across both OF and ACPI firmware paradigms, it is
desirable to have a unified calling convention that works seamlessly for
both.

Add the support for ACPI to parse a nargs_prop from the referenced
fwnode, aligning its behavior with the OF backend. This allows drivers
and subsystems using fwnode_property_get_reference_args() to work in a
firmware-agnostic way without having to hardcode or special-case
argument counts for ACPI.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/property.c | 29 +++++++++++++++++++++++++----
 drivers/base/property.c |  2 +-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d4863746fb11..e92402deee77 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -804,13 +804,35 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static unsigned int acpi_fwnode_get_args_count(struct fwnode_handle *fwnode,
+					       const char *nargs_prop)
+{
+	const struct acpi_device_data *data;
+	const union acpi_object *obj;
+	int ret;
+
+	data = acpi_device_data_of_node(fwnode);
+	if (!data)
+		return 0;
+
+	ret = acpi_data_get_property(data, nargs_prop, ACPI_TYPE_INTEGER, &obj);
+	if (ret)
+		return 0;
+
+	return obj->integer.value;
+}
+
 static int acpi_get_ref_args(struct fwnode_reference_args *args,
 			     struct fwnode_handle *ref_fwnode,
+			     const char *nargs_prop,
 			     const union acpi_object **element,
 			     const union acpi_object *end, size_t num_args)
 {
 	u32 nargs = 0, i;
 
+	if (nargs_prop)
+		num_args = acpi_fwnode_get_args_count(ref_fwnode, nargs_prop);
+
 	/*
 	 * Assume the following integer elements are all args. Stop counting on
 	 * the first reference (possibly represented as a string) or end of the
@@ -961,10 +983,10 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 				return -EINVAL;
 
 			element++;
-
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						acpi_fwnode_handle(device),
-						&element, end, args_count);
+						nargs_prop, &element, end,
+						args_count);
 			if (ret < 0)
 				return ret;
 
@@ -979,9 +1001,8 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 				return -EINVAL;
 
 			element++;
-
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
-						ref_fwnode, &element, end,
+						ref_fwnode, nargs_prop, &element, end,
 						args_count);
 			if (ret < 0)
 				return ret;
diff --git a/drivers/base/property.c b/drivers/base/property.c
index f626d5bbe806..6a63860579dd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -578,7 +578,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_property_string);
  * @prop:	The name of the property
  * @nargs_prop:	The name of the property telling the number of
  *		arguments in the referred node. NULL if @nargs is known,
- *		otherwise @nargs is ignored. Only relevant on OF.
+ *		otherwise @nargs is ignored.
  * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
  * @index:	Index of the reference, from zero onwards.
  * @args:	Result structure with reference and integer arguments.
-- 
2.43.0


