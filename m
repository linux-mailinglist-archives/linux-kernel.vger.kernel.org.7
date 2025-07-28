Return-Path: <linux-kernel+bounces-747777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572AEB137FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E716617CD0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A2259C83;
	Mon, 28 Jul 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QYJQEMaL"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC02566D1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695807; cv=none; b=HBgOIQB8kRHbbzj2ltrvFxunDInDF2BoeZogSZynOHT4SDlrFVjAhhP9u3Ntk65L+Mvb66Y6W8zGn8zexLGHckdi4HCtGAfBPk9bFIssJc/unPsiNW/v5b782XKUFCr4LfS/DCkGrPQkcehqB6P6diZG52pxMhocqAm5BjVpQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695807; c=relaxed/simple;
	bh=gyloqI7MRNxMKJRKLrjy7BLm1ahzB5ZyG0rUCvET9Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKuYdDLPWES2VUNFg9n4Mao8f0AL/cDSHvfN4q8nk6Z4qNtswO2TH1qMEv253Iyo8WJIMRYhpCeUmq0Pl4Srpx8XfjvXPfAvbqGMCSB8XaJ29fDVgin3EDmFQSd5LaGZ5LJmIX8rDVAZoV46IYnmQwCEUVLtkPD19g0uxLrgwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QYJQEMaL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74931666cbcso3695106b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695805; x=1754300605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euEEBnJ10Ul0dBSAcTDiXwaw0u7DfxF4JtogRsP9Xlg=;
        b=QYJQEMaLpKDJhzI3Pb0nRVByJbQTehbAqKVuDmJsaNYQZEe1/6BFsPgosrLQPqr9C8
         SW43p/901Sh8Ua5tmfNMAWP5R1BKTleqi62RW1Kg+P7uBToWsLxIrQDAPOctfPQAWQct
         EpYWeSFCK6/pkeTnX9+jGf39MtHEC8ytu86jlrNGFLT6glY+6zArEUtJU+KTZPBARl4A
         3DVmxzA6zdZ45C8bO1fD5l0YiG9+uDJNIWWxv9yRxUBu19cTHSNYP55Y1zd4bqPLkYSW
         B/EjcPi+PISbUURBYDGXUBpDtFIYENreSdhQCg25M+wF5UONn+BasB0muCmefWAd3xWb
         jWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695805; x=1754300605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euEEBnJ10Ul0dBSAcTDiXwaw0u7DfxF4JtogRsP9Xlg=;
        b=QavzRhZNyQeSm+OTDgsXWdaHbeXvsyYOfZntJD5iPJU/jhTQcmMVa8YYEZt8F7dtmv
         3L9Do4aV5aggocuFaZQMFTVpw8+JkhGU5/I8Fs976GRSpxl8fPZP4oIi75SM+ocH5k/3
         jQPtH0AUA+oq4VAm2GyrTVWMWU65gQFxbViJUmfvycQipmC+C3fagLlHpK0GwNwlk/0f
         E3SxPTQw6yoI0Oa3bky0HcQKaXvFRuXnAu10Duv5NsNajvgLNMWv1Lb3Jgl07fvLeUAa
         hdB+EJhx24HCgXeLnwC1WAOZ4qIfX4moJxiR68BwFxT6453LtE2J5l/53Fox7ApGGKWI
         fMtg==
X-Forwarded-Encrypted: i=1; AJvYcCVAlpTmz/7CjSWU38K8lXZQo3XNIEaYgLMqJn81MO9PI9Qy7X8UbcXbLkHbO2rIsh18Ft6oRHRwrstTSRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTPfCSXKeFqYxrLxlzvNx+b50TFdCE97yjRxftuvTL/Z3xQSV
	rHWFXhMYocZTjyqdEoGSrkJyZAY6xgP4TpskOXfstHPMETO8PnqZd+KnXJ6Xh+42ivo=
X-Gm-Gg: ASbGnct9GPHoB884wJO3RIYUkfhRCov5D+Co358roWWkdG+JUZsqD1d8kjCLwHaBZ2d
	WoaEMvrHh6vZOfWaiywVEQkpuPmMjaX427A9C7ZTw0SszRdMTWFKVc/VjSsulHFbqW75z254FhH
	R9bpy8j/xcqGC4lbErCC5mVKFgQbTKK5jO5NjQ3lWeg7QaimzeonW0Uca2iwnVLo222K+YC8lNa
	9edsUQ1YZFZEifHcvbsLrKNOcexQgpEoad4dpAqV905Es0yh5/LSLuQhKAC0p3AiFS/Y/m8kbqZ
	CZLXXbiwpE6byM9b6Nke4VpuCVYTns7ESeYjhir0K7RsmKC7jDQhaDY8EF7O/j27UJg7ZNmMD/V
	tFmFSH5trdBrovA5rZcvK3DWlmF7wSs+LD1zvycjyIGh9Gy7GlR1IJ1peCNwt4TfmAVn6Eqk=
X-Google-Smtp-Source: AGHT+IEizoJ3UNlyldS4GPjZ4kill5vbQWHdMNdPT9Dq9OqpgnaQ/TaBG91MoeiJ+RuVAwxQD5HSqA==
X-Received: by 2002:a05:6a20:7f8a:b0:233:14ec:4f83 with SMTP id adf61e73a8af0-23d6ffe8db9mr17043523637.6.1753695805335;
        Mon, 28 Jul 2025 02:43:25 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:43:24 -0700 (PDT)
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
Subject: [PATCH v9 15/24] ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
Date: Mon, 28 Jul 2025 15:10:23 +0530
Message-ID: <20250728094032.63545-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
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


