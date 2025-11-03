Return-Path: <linux-kernel+bounces-883571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7DC2DC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D98188F3C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687242A96;
	Mon,  3 Nov 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqlN6c2c"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7341B87C0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196530; cv=none; b=f0b3tcUUJlXdybe9wrmp7DZgk8kw9qnz3/euKIljYZo+QD9gYXUhKflzP0cvgx69rEkXkaEbL6kZ8y2ibT+LUcFU1wmO/90aLHY/e8KKiyY0XpFqcG6wibgciG01ClRaCPb9efNJd1ucZix0s/46ch5EAiE9Mu6k6/BhWUN4lVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196530; c=relaxed/simple;
	bh=TbqkSgZCXlTrGYhXzkeDQaBOdkWS495hC6rftFSCSLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtIFU074WfHOZ38dqCM8eaBazOV+CZ31cE4IE+SWSK2qjFYmtxajmyEF1opdDZQ8AszYhdSxYzYbjBUCPqU/M7m1QC7iBPV+Yjhu6EuRkLxB+5EaIInGor/kM6V5zaKqxFQw+0BWo3rIGj62Pj8H4QS0Lq4pH5khSxn9/lYNYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqlN6c2c; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54a86cc950dso711954e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196527; x=1762801327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+wfLlHdlrvYcCklMhkk2SxyIiTOFDFm9ntS4AcDqkw=;
        b=bqlN6c2c2z8F5g1pELtv8SzMTppUd515HsQQyRgOFVBkoub7ESSv6xWwasL4c7Wt2C
         1Zyrpmkqvfp+rKIJLwRhcmfyTRLeZKLHc0ZHthY6aGLP5pCt7fwsdzTzU4VT1+CkHI6S
         546HCAkWJldIKtdLdU5tAqdpqvqPvNYr+hFn51PvNlY162t5IAjVaiojN5E984a4RVBn
         0hgiE+0rrBAPT4PVdPskYNgU2OpMFxchQH1tsaz1gOPxAqajmduItWEwm5ekyVZwc1ZG
         CNafAJVNcxbEavJ49Mih1MDs9ixpQCHfZHHCNaOYkVEBSjuDI2z+kgUeJzlddBNZ/Lnh
         o1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196527; x=1762801327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+wfLlHdlrvYcCklMhkk2SxyIiTOFDFm9ntS4AcDqkw=;
        b=Wcc2GZg7ceLvjzUG3UlSpI3XEHcjfCSvT65Vhn+hcxMimiUCBI8pXPLJhtgRMZ5eJ2
         hrXnVmK3So0toyyMDJdNolg33u8GZubmteHucWB1de743QNDnZIXw8euzX60IaRiFbnk
         O73/O4To5ud8O6ZIQZlvXJkBbYi2DfPLEhaXEy9LOHAkaE8Tzie2jt6v9qam1MIBP2Bj
         iJZb25R/Q4HDtKA88dhujM1JwNEj9e/lc6wle7HNnf08BjWjeBoISjWGyve31gP2Ukb8
         1/5baKBLm6vIfp7X52KHcwEsUU9qbO64jXw9J9o2YApeIBwJywYPS0hgSyqC4bHFPh5l
         i2SA==
X-Forwarded-Encrypted: i=1; AJvYcCVMwZCT5GSvxE45vN56eKtMdhuKUTfwH0X5NTcZw1aqXi25afYSlYxzICGFNqka/m+gjIMCwbp5GmrQ5mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYmP/Eoqea+8tlq2PLKYnW2XGScsZdg+169+Xfqd+7+wvAfLE
	KThLVPYKvSs0qi5Iqb/5+Lj9yBsrSTiJZ6j8zWx0Muzw/oBgk/r3XhpSbe8tXQ==
X-Gm-Gg: ASbGncuz/GdsVgGB92ykY1ojax7SERTQHras3AgR0NckIYV24dS+c6szPWvpR+6SZU/
	WanZdmgaJ3fQ6gcuy5ghreOamPJNMlYRf8ITb2Yy5gw/OZHjLowzojZQeVi2B/dSX/KNY5ocMXt
	LNJlqd0i+w/YkJ7Yg/x4k/Dg5pehJNajW1wRLPEJjMH6CVkg56gmzgCO0HHdi93YUtZISBObd5i
	IQTxOQZfsvWm+F5L3UcX/4vy2cE5T+7UZanFnSZAvEtq36Zz09PrBLt9H3W4hR8gg75dHjLGY6/
	guRgG+I2KcoGswkYf20E1xFqeFPQ5UpTYF55HMXQwIUiMZ/ye+VFKYB6ogM7QPZDaBL+g6BcJgG
	WnSdXU+S4vWp8OLF778bX05+1mgkRvipskQRYqzHGq+yMyJRYEArCH6Q1SvkCgVniqWhUePHIOi
	7d3mkDQCtD5b/S
X-Google-Smtp-Source: AGHT+IHQJiuKepqGQcmrBoRO1kAtF4hiBGj9Yir2z/yiL5vsrXcf+T2JYfiECUzR5VFEEv230gcPKw==
X-Received: by 2002:ac5:ccd9:0:b0:559:6e78:a43a with SMTP id 71dfb90a1353d-5596e78acf4mr721689e0c.9.1762196527510;
        Mon, 03 Nov 2025 11:02:07 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:06 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:46 -0500
Subject: [PATCH 3/5] platform/x86: alienware-wmi-wmax: Add support for the
 whole "M" family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-3-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=TbqkSgZCXlTrGYhXzkeDQaBOdkWS495hC6rftFSCSLw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5RmXYi5emtn9Y050fdrtpivjDUVyzimbZbIVV0ZJ
 rLwk0h7RykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzk8B6GP5zv0i1rK9JOLLo5
 JyNj3pa1U1iPbFJurBS4nGI+/XqclDMjw8MUvvc7nEXNVzw5aKxxt6huvnphxGepqZOmXu2znr7
 gHBsA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support for the whole "Alienware M" laptop family.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index b911921575ad..53d09978efbd 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -98,18 +98,10 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware m15 R5",
+		.ident = "Alienware m15",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R5"),
-		},
-		.driver_data = &generic_quirks,
-	},
-	{
-		.ident = "Alienware m15 R7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15"),
 		},
 		.driver_data = &generic_quirks,
 	},
@@ -138,18 +130,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware m17 R5",
+		.ident = "Alienware m17",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m17 R5 AMD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m17"),
 		},
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware m18 R2",
+		.ident = "Alienware m18",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18 R2"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18"),
 		},
 		.driver_data = &generic_quirks,
 	},

-- 
2.51.2


