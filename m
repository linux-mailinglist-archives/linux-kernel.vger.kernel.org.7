Return-Path: <linux-kernel+bounces-683585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4127EAD6F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 13:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4291BC3699
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0C22F76C;
	Thu, 12 Jun 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOe3J4+j"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5B221DA8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728552; cv=none; b=GLYk3+ngX69C0vtDvXmzsm4LKVbOMSTvBOMln53pe0WTlqgm6eTv1PrFkVJxwuCC5/XhmUivtS0bIf3m/Y4X1njFOAmZBwV7WxiypGZb5j0jnVDHwEBgoL8DYIl3C4uyfhhQX50d1gbXzFKrnwfKzsTCGJU8tXCEOb6F2sz0+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728552; c=relaxed/simple;
	bh=M68nUWVIIwtURxYosMRH8VARWW4Z+lgLzYE+UyooFck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m0j4g06aqmXSxtDU5IRX1Xe0iFugLIgu49S/Y2WqDjplP2s2Y2lpxCyF+AigEvCCxv0DBII46Fjfp8fAI+KUhkA0wJ6/haezoOxxLh/IYBW+fdoz4o/z/v6jZnrgLi+jhUlDxKz/6inpDvZLef7mJykxpDRodh/L3Dcbr3l9+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOe3J4+j; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-60724177a1fso926456a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749728548; x=1750333348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nviQMUi3+6AKU5MNp5yJhHLaI5w/byMGPK73HIbgdRU=;
        b=EOe3J4+jYNm/FAXi5YynMDI0yWg5HxZuOJlo9TnzTYdMiKwHwQcSXTG2kvl7bv1vgf
         iMgmu+aB3glehpyW26CAo/kvVZGAcEknz2H8lZQ/Z3V2BkQqHBR89PaIytlUiQwwTFNH
         AB72IcOEk/a92tPCX09gmIGnONO+LwE6RgAvLFmvxZG2wXzwOhOx5csV3zmWJf8rtHH5
         Mw5lgluiy+Us8XIW+3TuAICfo/5Y4VdyN4oRXiJpYEw6dYgnRcx1/y8ex+K0ebyJu5Vb
         C/Lp7eyNfndpeXduiBE5OmwpvUybTaf2s6is8+N/a3odJdH6qqhfv2OyMVFpoCAbtd3q
         fBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728548; x=1750333348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nviQMUi3+6AKU5MNp5yJhHLaI5w/byMGPK73HIbgdRU=;
        b=l9fzHrKogPfDOCVEwLFYdfcdjVlgUmLroRjzuhho/y+PImPJs2HPMkZYfsmkNBT69R
         lxgoiIuWVlCD0BcNYokSDkxGEYEfq+2X0R0HrUGNc3g9bIMr/lcVUmmE3b9kbNDeDZ9/
         lQdFb/7DldO3W5s26vO05X2eZQt9lhtUKQquvrxHUGLEre++9Z594Kn2DLasMFHxljrP
         O8VMkyph6AdjjgrHCfqzOFvFq7UlctEUlQFDYos02WldVq2IIQmhpmhljoOzOmRId6AX
         KnuSLvWQO85Um5Ac120FXfYDWzRRgsdU7OQnrzqdbLA0zi3XKjwFec4MOwqG0WU1vzOa
         xfxg==
X-Forwarded-Encrypted: i=1; AJvYcCU6rmZD1skRi9VfpHJxNRcDJIHLuWHI+Ikir+fGh3CKBipfGNOO2gzNpW4LvgL6gc1mBZ6yNCVzXRUZLh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7l3sur+au4ZqcgLdsywMa1j/EWcZajxxqJ1GF/2UJpPgOgot/
	m4XBkNdhusMzw3SRFpUf2pCg5+1Qrr0VR38dem+R1ScGXrTBqbc+KMA5Jqaix/qObjeVnLSXt2Q
	quFB7nH4mn1wu54FIRwDn6w==
X-Google-Smtp-Source: AGHT+IHh9Pqjdn0VY8skR++NPQM27iqtbpRfUClylA8WtEhMMU8qe/JEYEVgqZUowB3UCVviOhARIH/e2yrT3GW1
X-Received: from edqo14.prod.google.com ([2002:aa7:c50e:0:b0:608:806a:7dbf])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:524c:b0:608:1357:d1f7 with SMTP id 4fb4d7f45d1cf-60863ae5590mr3454890a12.22.1749728548037;
 Thu, 12 Jun 2025 04:42:28 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:42:09 +0200
In-Reply-To: <20250612114210.2786075-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612114210.2786075-1-mclapinski@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612114210.2786075-2-mclapinski@google.com>
Subject: [PATCH v3 1/2] libnvdimm/e820: Add a new parameter to split e820
 entry into many regions
From: Michal Clapinski <mclapinski@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the user has to specify each memory region to be used with
nvdimm via the memmap parameter. Due to the character limit of the
command line, this makes it impossible to have a lot of pmem devices.
This new parameter solves this issue by allowing users to divide
one e820 entry into many nvdimm regions.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 .../admin-guide/kernel-parameters.txt         |   7 +
 drivers/nvdimm/e820.c                         | 159 +++++++++++++++++-
 2 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..63af03eb850e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3849,6 +3849,13 @@
 
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
+	nd_e820.pmem=ss[KMG],nn[KMG]
+			Divide one e820 entry specified by memmap=x!ss
+			(that is starting at ss) into pmem devices of size nn.
+			There can be only one pmem parameter per one e820
+			entry. The size of the e820 entry has to be divisible
+			by the device size.
+
 	netdev=		[NET] Network devices parameters
 			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
 			Note that mem_start is often overloaded to mean
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 41c67dfa8015..0cd2d739af70 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -8,6 +8,97 @@
 #include <linux/libnvdimm.h>
 #include <linux/module.h>
 #include <linux/numa.h>
+#include <linux/moduleparam.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+
+#define MAX_PMEM_ARGUMENTS 32
+
+static char *pmem[MAX_PMEM_ARGUMENTS];
+static int pmem_count;
+
+static int pmem_param_set(const char *arg, const struct kernel_param *kp)
+{
+	int rc;
+	struct kernel_param kp_new;
+
+	kp_new.name = kp->name;
+	kp_new.arg = &pmem[pmem_count];
+	rc = param_set_charp(arg, &kp_new);
+	if (rc)
+		return rc;
+	++pmem_count;
+	return 0;
+}
+
+static void pmem_param_free(void *arg)
+{
+	int i;
+
+	for (i = 0; i < pmem_count; ++i)
+		param_free_charp(&pmem[i]);
+
+	pmem_count = 0;
+}
+
+static const struct kernel_param_ops pmem_param_ops = {
+	.set =		pmem_param_set,
+	.free =		pmem_param_free,
+};
+module_param_cb(pmem, &pmem_param_ops, NULL, 0);
+
+struct pmem_entry {
+	unsigned long region_size;
+};
+
+static int parse_one_pmem_arg(struct xarray *xarray, char *whole_arg)
+{
+	int rc = -EINVAL;
+	char *whole_arg_copy, *char_iter, *p, *oldp;
+	unsigned long start;
+	struct pmem_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return -ENOMEM;
+
+	whole_arg_copy = kstrdup(whole_arg, GFP_KERNEL);
+	if (!whole_arg_copy) {
+		rc = -ENOMEM;
+		goto err_str;
+	}
+
+	char_iter = whole_arg_copy;
+
+	p = strsep(&char_iter, ",");
+	oldp = p;
+	start = memparse(p, &p);
+	if (p == oldp || p == NULL) {
+		pr_err("Can't parse pmem start: %s\n", oldp);
+		goto err;
+	}
+
+	p = strsep(&char_iter, ",");
+	oldp = p;
+	entry->region_size = memparse(p, &p);
+	if (p == oldp) {
+		pr_err("Can't parse pmem region size: %s\n", oldp);
+		goto err;
+	}
+
+	while ((p = strsep(&char_iter, ",")) != NULL)
+		pr_warn("Unexpected parameter: %s\n", p);
+
+	rc = xa_err(xa_store(xarray, start, entry, GFP_KERNEL));
+	if (rc)
+		pr_err("Failed to store 0x%lx in xarray, error %d\n", start, rc);
+
+err:
+	kfree(whole_arg_copy);
+err_str:
+	if (rc)
+		kfree(entry);
+	return rc;
+}
 
 static void e820_pmem_remove(struct platform_device *pdev)
 {
@@ -16,10 +107,9 @@ static void e820_pmem_remove(struct platform_device *pdev)
 	nvdimm_bus_unregister(nvdimm_bus);
 }
 
-static int e820_register_one(struct resource *res, void *data)
+static int register_one_pmem(struct resource *res, struct nvdimm_bus *nvdimm_bus)
 {
 	struct nd_region_desc ndr_desc;
-	struct nvdimm_bus *nvdimm_bus = data;
 	int nid = phys_to_target_node(res->start);
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
@@ -32,12 +122,64 @@ static int e820_register_one(struct resource *res, void *data)
 	return 0;
 }
 
+struct walk_data {
+	struct xarray *pmem_xarray;
+	struct nvdimm_bus *nvdimm_bus;
+};
+
+static int e820_handle_one_entry(struct resource *res, void *data)
+{
+	struct walk_data *walk_data = data;
+	struct resource res_local;
+	struct pmem_entry *entry;
+	unsigned long entry_size = resource_size(res);
+	int rc;
+
+	entry = xa_load(walk_data->pmem_xarray, res->start);
+
+	if (!entry)
+		return register_one_pmem(res, walk_data->nvdimm_bus);
+
+	if (entry_size % entry->region_size != 0) {
+		pr_err("Entry size %lu is not divisible by region size %lu\n",
+		       entry_size, entry->region_size);
+		return -EINVAL;
+	}
+
+	res_local.start = res->start;
+	res_local.end = res->start + entry->region_size - 1;
+	while (res_local.end <= res->end) {
+		rc = register_one_pmem(&res_local, walk_data->nvdimm_bus);
+		if (rc)
+			return rc;
+
+		res_local.start += entry->region_size;
+		res_local.end += entry->region_size;
+	}
+
+	return 0;
+}
+
+static void free_pmem_xarray(struct xarray *pmem_xarray)
+{
+	unsigned long start;
+	struct pmem_entry *entry;
+
+	xa_for_each(pmem_xarray, start, entry) {
+		kfree(entry);
+	}
+	xa_destroy(pmem_xarray);
+}
+
 static int e820_pmem_probe(struct platform_device *pdev)
 {
 	static struct nvdimm_bus_descriptor nd_desc;
 	struct device *dev = &pdev->dev;
 	struct nvdimm_bus *nvdimm_bus;
+	struct xarray pmem_xarray;
+	struct walk_data walk_data = {.pmem_xarray = &pmem_xarray};
 	int rc = -ENXIO;
+	int i;
 
 	nd_desc.provider_name = "e820";
 	nd_desc.module = THIS_MODULE;
@@ -46,8 +188,19 @@ static int e820_pmem_probe(struct platform_device *pdev)
 		goto err;
 	platform_set_drvdata(pdev, nvdimm_bus);
 
+	xa_init(&pmem_xarray);
+	for (i = 0; i < pmem_count; i++) {
+		rc = parse_one_pmem_arg(&pmem_xarray, pmem[i]);
+		if (rc != 0 && rc != -EINVAL) {
+			free_pmem_xarray(&pmem_xarray);
+			goto err;
+		}
+	}
+
+	walk_data.nvdimm_bus = nvdimm_bus;
 	rc = walk_iomem_res_desc(IORES_DESC_PERSISTENT_MEMORY_LEGACY,
-			IORESOURCE_MEM, 0, -1, nvdimm_bus, e820_register_one);
+		IORESOURCE_MEM, 0, -1, &walk_data, e820_handle_one_entry);
+	free_pmem_xarray(&pmem_xarray);
 	if (rc)
 		goto err;
 	return 0;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


