Return-Path: <linux-kernel+bounces-772822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF60B297EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C091B189EC43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA81263F4A;
	Mon, 18 Aug 2025 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HxoC6whx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F2262FE4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490348; cv=none; b=KlRugdVtLU6x79b3XKTKsiGiSYCMZIwLwV3wQNNzYm/y0oooh4fe7SpKlUrA2+gYv1Ch4ugUZpAzjz3yLORxfF44c+hRGt1ppgQHhtCHMLLk7Byee7Ig6W9WDozrCNcJK9ILzYAcLQc3unYUc9iludt8zr7YpKpuVtO+d1Rfu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490348; c=relaxed/simple;
	bh=uLkW3DQcKIIgVHib4AKQIVSEPy4uT4MPjoilFNj5tRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpzfcDeanVaxVkLt+HmdKtSW9PUffO6dBpCqTBM+tzMXO2c5rY/Ci3hTFPtNQyRZCbccFGzY6v2K9GqAD9pZr7qFmTNB7r/kmJiIb1HbxSRMRvXX3kO9eXwEaw09DI5mMgxIjhidwWNsAaU2RsndKB23ROA7QVgYqOzoL31c2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HxoC6whx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445826fd9dso40693935ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490347; x=1756095147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiu9LW4OQPcl48oQrH2DU+mLfm2FHbXqcRasNtW9C8A=;
        b=HxoC6whxKUf+79TSLvxsz4ZZOa3RtFQQLKG4pDVpVjR5w+7qHewQ7+b02tCrW/oe5+
         JnX8PGb4Jw7sxBCWASE74K61+FvRSjiTB2TLzDstm+5h/iaGji996Gm5iFboSXG+IlCq
         njIo/nNry5hUjKom82uK1vQfO8G1dct8H/dk7QvNgoOEGPjZo6tJ65k3/JVqVDcmfLiW
         ww6SzoAYoQehQkZHtsO//laE/3Qc1mw4ZM2ksblwLMLuUWRxrM/J74EgdtDfBYDp+SwU
         2ZMn3cO48w6HD6yZLYdrBxi3wOrzNetHMvObJd4YE+JLZBUEYsrF7v801ORskmDm7U6I
         bxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490347; x=1756095147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiu9LW4OQPcl48oQrH2DU+mLfm2FHbXqcRasNtW9C8A=;
        b=a0pAk4Uh2TSIw50jmO5yZW3EKN0Fkb8AFLfqnPjBKvXENihhoQOM5dQ+7H+QHNsPKj
         94NLIgPAaxLzFh+eYfHEvUR9I5KC0k4ADVkkr6tO/xnFOpH/QAW9rArqsikR0SLjDhz6
         l6zu7O5d8ljaS05zkIOTzW+TuFdUmjIKBjljw7YhQdC+Y9BsFIjvSKoBbYJvsbkTYupZ
         VfUbqFg6qbAN5y1Q54AMNdp3eXVrtSuXn8+EtId8MkB857Z5KWAG0GDhF52MMd9rRaiM
         ChjMFNVXizRsuSR0MLPQqOjUyLk0L6B/HQcWAaeUaHZxkmdMgrhbAbOT47M2preCebsg
         44Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXvXf4ot3AIYWQ4SkXrPzup0eRHaFGvceEb6GEchlOBlbShkVlqzuC3UzVp8lxFi7bTeT+86njOmf71yDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4oXoTfLxtKAlOAkT75J0YLKm+4EGM/AfUrmCuz3dkqTgoSDg
	kROYI2KXnEt4Q1KQ5FOP5k+b0HOPdPZQQNmr9F/OIOZ33oity6pk1j1DSBk/IcR5y4A=
X-Gm-Gg: ASbGncscvduEjL+kg+g+EnJO6bzAltudlZjbpIVpTaykGVoA6DMz7WjsPL4dCCuvYo5
	ygDzzcfO3+4d9vgl/PIhgzvUxQBcVC89ZZT90JOCAbec5iMqob0sNhJWWO+EvGUJBwjEo526ekB
	OuLS1m8XMT/bV6+oV+AJmOhwhNoNaQ6ob5+zpsRWkR6Kwi5KmXt33Vh/f2iaBAmdPd0jcJ/+3KS
	SuvKkNN71eDGRQ9sQVVwt6O9VwX8xg5yJaJyx+RxQNVhaNIMfxolxXPB9rJqYWxfZ+s4PWjMO2U
	87ofAjSLyFFEGrIQigSHkwHOdCmNBDFvPlacK5McmGVDYICF9lHYld4ZD5+MR4qeja2xHmRhGdM
	xeiEIyYGWqXsWKK+++2E2FuvQo+mCbpKPkpiVTf5P7kPqphZjEV1Dog==
X-Google-Smtp-Source: AGHT+IHa4chLy02LQ1m0p6qX0i3HzDZVLkMVRhkDtgaV/+W4jzDIxOW46iPZExZlIfoygb6NLHSF/A==
X-Received: by 2002:a17:902:cccb:b0:242:b103:18e with SMTP id d9443c01a7336-2446d93b694mr107561665ad.50.1755490346744;
        Sun, 17 Aug 2025 21:12:26 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:26 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 17/24] ACPI: RISC-V: Create interrupt controller list in sorted order
Date: Mon, 18 Aug 2025 09:39:13 +0530
Message-ID: <20250818040920.272664-18-apatel@ventanamicro.com>
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

Currently, the interrupt controller list is created without any order.
Create the list sorted with the GSI base of the interrupt controllers.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index cced960c2aef..33c073e2e71d 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -115,7 +115,7 @@ struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
 static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
 					       u32 id, u32 type)
 {
-	struct riscv_ext_intc_list *ext_intc_element;
+	struct riscv_ext_intc_list *ext_intc_element, *node;
 
 	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
 	if (!ext_intc_element)
@@ -125,7 +125,12 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 	ext_intc_element->nr_irqs = nr_irqs;
 	ext_intc_element->nr_idcs = nr_idcs;
 	ext_intc_element->id = id;
-	list_add_tail(&ext_intc_element->list, &ext_intc_list);
+	list_for_each_entry(node, &ext_intc_list, list) {
+		if (node->gsi_base < ext_intc_element->gsi_base)
+			break;
+	}
+
+	list_add_tail(&ext_intc_element->list, &node->list);
 	return 0;
 }
 
-- 
2.43.0


