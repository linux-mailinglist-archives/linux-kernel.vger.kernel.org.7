Return-Path: <linux-kernel+bounces-863256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6DDBF7627
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7704355FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1F346761;
	Tue, 21 Oct 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ocn3sV5D"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B2346762
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060613; cv=none; b=U8tDki88wi96dgW7gJ1zelvLG+Y5LH7wdGQXf4M1Z8cnMY1sDYXYIHU4ZAsjn7V6nepqwZGUo7ttUzyxqTqaTFuvT0p7RjkGPkpyuFDl23DLGour0W/oeigWcAu8TSXvf3Gyfc/vf4qOQ3P8tJbXBr489yzpcR03NJkjsyA8ENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060613; c=relaxed/simple;
	bh=+f7O9lqmMO/tX/w1zN7bxbzuN13C7uTtt+VLYmK6kxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUIqDypmiqgTuuWahP+nUVJEazL7W+RZ13mj0OASBN1LLJn0/R00e92wVdL0Ha749UqoVCBR4o7IxHvGQVsjchGgot649z8XbHZUbEM+9GaLTwbe+ilxe60dG2U9MRBPuA6Pl50fp8o/xFU3TLXyaTEVscviAwu9BIAz0AU7fSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ocn3sV5D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3d50882cc2so1089889866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761060610; x=1761665410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUzpv3BxCmCZXTEwvzep7NMMR9W5hvjdg/xN1LZUEgc=;
        b=Ocn3sV5DbZS5/W+SYO0slQsc054Z6+Ycz0Tv8L44nRhhGdh5pMPgLc8maxEu+VDmJQ
         6c9BaLBJjI8kfQFm1U1TMc7SocYxbdwaUxmNSKvKZ9YOGB5dtRGjPrJ0Hinr/WpQanw/
         Xfa1EnoR2B8N3bOlQv/eU4lSO6fM8rvFTM3c1BdSStQfVKwgbHoo6qReTs/87iEd9Hu7
         nPVgOj/RoefFg8ieiXdZAyRP+g3Q7TvBBB9ITBCRYSa+nxYn+BROVXFpoeTA+OJ583YC
         Vo1OFxCyt9JBmFBl2V2ilXn5kApJFVCYONiY0PVZvzEqPTZbr/zy54KG+dOrIg22L5NQ
         FRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060610; x=1761665410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUzpv3BxCmCZXTEwvzep7NMMR9W5hvjdg/xN1LZUEgc=;
        b=fi5PHY4xWD61+x01K84g2DK2cPf25kaXbDQKMGzCBmZDmygLQHY/5bw51KGde8fvS+
         DQoOfLJ7rEJGpgKRrqkXoGnTjs5Tf76Ni+0/G0XMFHV6oFRK0RQ7MwKMeZEEJZQX2GPR
         58lAEp0xqNEWhwoKWNu7PvW/fnD+vfAdoNgdzSppBN9GMZ40u8T4sMSc5aFLT5zviRp9
         +jKJRXraDvdbyxO11CBQbOKVocVWoLHlOONBrmdmzJ15r3WtlccfpVjAQC8Src7Eh2dq
         ZXA4ewaD90YkBp6ZLrAa3K8WgZDj47b1a/cYmgYeQQOjzfqNqw1cva8YK96FfeLqtkF4
         Ei2g==
X-Forwarded-Encrypted: i=1; AJvYcCWjWwGlqweQciNjhc2ijIgUqFX4v4w+RUdvr++XCwBBODZWeydgiF/FBTxZV1UKMAJqZIHPiGEEB68ZBLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPLDkENUqcLXcYQ0U4Q74eU8GCkW6IbQjo9WVRLjSqd8M8hmq
	10R10pdWYVXC/y02KKr+1FIt92x2wppbVz8cuQ274lp5SpUmZiDftlF7zEUzXvKk7Po=
X-Gm-Gg: ASbGnctwEJbfHQxM1hYk56xFQveKymJWluZIq1JdJFy8ZZvkNsE3Vz4Ry5S3mb+rmvJ
	hi3xLdaTS5XZIDLCHYaRBisiBiFQw27+P6NMXUAggpl9fExNIbFEq5Yh4uq5eKnlmzlmokxDkeS
	e4AC/uPPV9Jil7oXNu3OuGXTha2rwF4PiWjDbihTG7mC9dkNM/7rSBQ8efHme2pvVcfWz+ZmsUm
	0xVLslmkDbRjc1QJpxqmelrQjMjQNl386VgVUSwGQAV518e5RuZDwkfxw0CrwaNuSrowbkkFjzI
	ucjMyjuT4zwdVcWfji0im+GwTZx68daPB0SoACZ42lE5sPdFoyVLKk10TUYE8lIQbmuJ95NZzbc
	YE8y/qd7SXOBSx03w+apKZ9RMsByLptdwh2Yuj/H10Jnv6XpduLAe16ZejMv83wt2atVITPAGUH
	MD4nf9B24fzbKtVJEF6MP2BRkWqcPGKdeUnp4OhpGshwChlYO5xyZSSumM8ZwdwQ==
X-Google-Smtp-Source: AGHT+IEim2CjHliqYoMEOMTWDO0It2YWhRo5Hd6rRP9ZaNHU+yYpEMyFy+mtqvif/6C2qsaOD7Nwjg==
X-Received: by 2002:a17:907:94c1:b0:b50:a389:7ab0 with SMTP id a640c23a62f3a-b6471d45a81mr2179399666b.4.1761060609920;
        Tue, 21 Oct 2025 08:30:09 -0700 (PDT)
Received: from localhost (host-87-9-62-200.retail.telecomitalia.it. [87.9.62.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab54desm9802102a12.13.2025.10.21.08.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:30:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mbrugger@suse.com,
	guillaume.gardet@arm.com,
	tiwai@suse.com
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] PCI: of: Downgrade error message on missing of_root node
Date: Tue, 21 Oct 2025 17:32:19 +0200
Message-ID: <20251021153219.9665-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
is generated if no 'of_root' node is defined.

On DT-based systems, this cannot happen as a root DT node is
always present. On ACPI-based systems, this is not a true error
because a DT is not used.

Downgrade the pr_err() to pr_info().

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..034486593210 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+		pr_info("of_root node is NULL, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.35.3


