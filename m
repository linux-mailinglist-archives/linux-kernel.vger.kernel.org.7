Return-Path: <linux-kernel+bounces-721819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251AAAFCE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3241884E93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B22DECB0;
	Tue,  8 Jul 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uG6qN1IC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675C2DAFD9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986215; cv=none; b=VT0LoyJgsB/s8/O0qpIxgemqCR+GBhMNmeVXOxYNJmfSN3+PbrPE6U1HY5lMSo7tryyscrn7EVP88doY+FyZy/IZlt8MsiD9TX1Sf0KUftwH9mgtDhdv3eiD9vjXgQRB2GjnhBhIWa/vOajdqu5Pbzmb0FF2SIiuZ8W2XYxjwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986215; c=relaxed/simple;
	bh=HEgvTY7DvqUTASXbAkoz2Cq2W+UACAG7D0XiharOkiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LfvI57Un3dDPgnN3Scm60NLGA1Q9pYxBnUeCySS38WqE7g6vXuxuRrGHJBFFQfxO2q+4Klqo3Ji5aNocIvQI6lmxK6hy9vgPuplgGVUc3BQ58oMkSf5gP43ILG5JYjmZ8hf6RX90HCPE3H0M4SCLuiBw8LYEDDGwBMMcYAi1Ixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uG6qN1IC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4530921461aso31893165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751986211; x=1752591011; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+mcJ7ZL40yfdI/6L1U2sq8kmJCRggUCq7uPF858vik=;
        b=uG6qN1ICF86hD6jJf/IrYo8dfj0Xt4vgNY58oRn4PewJeOXeatbjqdV7DnwUG1mxYU
         gzC5LHXiAIaLVa8BVMNkvcY0vgxlSdEFOcbdAWlnaik44fe0nb28Tvy6KGsm4I+Gic6E
         xRWspBvLZJH8+LYvJsgtlxzf1OOlwQHm5U9BqOwqZN3p5fENhvLrW1yRh3y4ilGU7rd4
         Akr9z4CtMra9c98BRGY4wA2hHH26boKR/ZCbEgxs60d02Qf4iEc71RWjuHmjX3E50Y/g
         wpGqsNvQhaJOfxkik/dDniIdpGjICFALBnudhynF8xdTQtkcE2abBqEkqx5QSnYqYXym
         rgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986211; x=1752591011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+mcJ7ZL40yfdI/6L1U2sq8kmJCRggUCq7uPF858vik=;
        b=BXwl2xowB7tt2oya9VaCZEPYp3285KY06EcQMoUzHhrcLj/sUnWh/FeOMc5yOUbyV5
         Ku51EQLgMKb212z4irqvGMgPAA07k0RNVs1lNZcsJw42FhnF9Ay+kpfCpMBxKONUaX/9
         k+uMG+ZEzG3JUg+PHpzuDxiEGccC7Q0rZXEcomxxBSXw6HHb0cgeZpNY2D7SqGsiyEXK
         6yPWYyDF8TFsurRsxZf1iWJ5vzKZTgDNQ4KZCW7M8iwt6hOzfwk7x2DkwEbrU7CKFAAf
         Rb6l6lfEEG9fFrOHxRl2pbv6QaB1gy0OaNh+aWMrddxtUzmNTBnKSB5D9dJ5yFw/FvxF
         nnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGMMFg4tWx+0Rcco3774pPbwHfkc+pBq08zuyODkY0xq4J0SdRycYLan0KFJ5Yeap0CU91CanC0PZCyvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrfZJAfSZ8l7dT8AsXqwWZhb/TQb+V6vIvYe9Thvs8oA3o6R2
	s22Zl0ymcHOAljqUuKtGmW/H5fdFJMC6fyFlP6vbuxt2lczfmj9kTUEjx+H8+g3mh50=
X-Gm-Gg: ASbGnctt5R6pvVW6JuORtYbKqAvRHPPTyCEZoQDm7kIInHXPfn3ZIndSlhF5sDZQJCD
	lMT0RkN+Ipw/70s5HUORbbTq1xhQ1GGmHuw5lva6FZexxulw3i1B0p487gSFNYCYIO5x/WbFRY9
	1eCk92FVoCXOOIfxk+FI9iEyK6FHtAYVfy2/eUnJ18rq7M3xucOX1++19XaTCzu4z5UGSuPsp9g
	/yMkoq1SB98sreHiNseQSadzJNFMhaSeBMpc5MOWXUkfHg3iAYI0WnnBsWrX6Fr+nEBOjghNpCT
	w+WNlDqsdq2wxDj79GVGVB2hqttvdeqo5eFggmc+EE3TIKtDGhlh54ud+fZiyPgL4obegSnm3VZ
	Q
X-Google-Smtp-Source: AGHT+IH2G2zx5csQczqgTBlBit9l6rKgdpM4AL2R7/oW/cCxn22xdVAIxyhu7QXZ0RNJGTHll7v0Sw==
X-Received: by 2002:a05:600c:8b0d:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-454cd5234b7mr32681735e9.23.1751986211084;
        Tue, 08 Jul 2025 07:50:11 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dfdf:dfe3:8269:12e7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b47030cdf5sm12988879f8f.1.2025.07.08.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:50:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Jul 2025 16:49:57 +0200
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABQwbWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3bK8kiTd3HLdtMyK0gLdpGRjg0TjVCNLAzNDJaCegqJUoATYvOj
 Y2loA1x0n8F8AAAA=
X-Change-ID: 20250708-vntb-mw-fixup-bc30a3e29061
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=HEgvTY7DvqUTASXbAkoz2Cq2W+UACAG7D0XiharOkiI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBobTAdm1+n8PQLlMWBQtM3sujQ9VlXuPytqjO/b
 RX4fjO7geCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaG0wHQAKCRDm/A8cN/La
 hbW9EACZxPPbx9A9N7wzBBwK+X69FdGNxhFWZa4r0v2iig7LecShid9JdCCgxxpoMTiJ4Y7h/WD
 iepvHs56AKjPYLS3TQ1QSc0bhbHJco0KzUCQn+zJq153Oz9QNAYjSAYTXDblnUxvBHUE2TIT0nP
 UKcKt1RKzVpbMNSoNEuONomEejyFT35evSOKpyVwRiBENRx/IJipuJu3unfu6AzvVPsTRFsVaL0
 Lmc8lU+DFtm9eeA91jTOsStJBhdrz6ROjci+1WTlq6zdhJox60lw0FndiXEGAEI59CYsqSttzCL
 V7e8bZcPiJ4jeqt/FhpTO9dLn6gN42Xs6u/sOBxIKp1YHhME+zTphrFXptfSJUl3qa3PJRcW0Id
 Rz/y6L+YqCuAj3I12VWuJPloVzQZ30Iv/nQxk+zMICLF5ktrtpKQt7w7DPRbFnqR7NYF4xlIeox
 qFgBgTF5DPamsFhI2Rb0tYLY8LnmyYK6NYOri3ZUnibpXG6D0Q7s9rteRkbyT7ZyNZWZpQSN4nV
 3EnS5022AvlTmNfq3FqWqmGJphqMc+udewNL1w7PZbhlCpqF+zzQ4zE2og0wHhz+HNRyaNGDC3t
 IWg3bFShM8KgULCpQXVoiodbPpMix9DlvXjZiRvCme3UokWoxG1wc3WmNDxkNv909JVLYjrhDEi
 oG1fcYX8ebohO8g==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The id associated with MW2 configfs entry is wrong.
Trying to use MW2 will overwrite the existing BAR setup associated with
MW1.

Just put the correct id for MW2 to fix the situation

Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
 EPF_NTB_BAR_W(db_bar, BAR_DB)
 EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
 EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
-EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
-EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
+EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
+EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
 EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)

---
base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
change-id: 20250708-vntb-mw-fixup-bc30a3e29061

Best regards,
-- 
Jerome


