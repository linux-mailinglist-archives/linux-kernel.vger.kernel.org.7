Return-Path: <linux-kernel+bounces-859038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFCBEC88D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330263B551D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866A28152A;
	Sat, 18 Oct 2025 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClfqFV8z"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748827A907
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760767897; cv=none; b=WPQaw8C4N+sGopi/q7PnOIas40j8Bp45IVoR2zyVYYJlGhU908X5lIzvq0+E1VZxwsIvkrdVUqlVf4FLhzfKY1kE5EVNVmYJC0RsADToVcLXJDT6inh82xHs+KzOP3INuZ4KNwp/FbAtI7ngArBUWVqEpHi60Gxxc3qPOZKi6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760767897; c=relaxed/simple;
	bh=lJRPbah2na4b9ckBfNOnXhL8Sw4U5wpVRHboCG375go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C926vRmarq/A42MYrv6ymBvYoQUeai33yW557iTx1squMyX+KtnlGd+r5M4G3leOgwDKspy5tsReAgejcOq9ey1OlBvqp9M02Y7np0ukawJX/fuyqvvXwFZfdeF8DdC7U/tnbgbfrku/30rZMw2qfnV2oWrrvrb3iuXvXspLT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClfqFV8z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so1792174a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760767895; x=1761372695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuK08AhMaCFjkCNPsmZTrH6+PYVk14sYYN9oj8qJbgU=;
        b=ClfqFV8z8eoJu3beX2O/icmK/d4kJcsoaA25hvE3q4gl6KoYldKKDvwM+18xnLAj92
         PpoEIcMx2Fv8lSjVRNHZ4MpeczFKHdaPLBodt35k8ubgxrtgcQTUsGL/QdcnmezzH1C8
         JxGZYrRreKq29Qph6h8zjiWM/DjpUnQ3L0OEbYocmA4Ykp4Otu9DWxWW0isAdJPkOEnk
         MrhL9Y9xdXyiNEhcXtNzAiSao/c0khCxueiPNQLxNlcvRGjkg2o5rDgwhFL134vUccwi
         udPQ+SC62cbo6r7pyQIVSGGeb/3teiB8FGCMCZOWbyeGNZ/YMCqgK1Bafs783G6N3th0
         3X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760767895; x=1761372695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuK08AhMaCFjkCNPsmZTrH6+PYVk14sYYN9oj8qJbgU=;
        b=pW9D8PSo8nENp8nVeobCKvTtp375BwCShIBuEWTsA+7tnmuvrHWXqiN/doD6GqDCUk
         kJ/b+tWU5v46eM6/X5nrrh5GKPJkDE2IYOiVVOhqOtk5CHy/DNy8o3CA22MFhSz1hMRt
         aZjkucV3Mlp90qrE9sKHa+QzQp4fgBLgx74eZ3uaVAeFpsbyWsJGyz5LMtaOY4gyth+N
         QdZnqybAvtD+iXec6CtmXQBrdKArKwyJ0DEgsGKJ2lIZ65eYWv9PTXZJXRfKvkPnvk7H
         nxnXXzrXjH5tARerIlLNCc8Fei3Ti8hB9P8jRaIqbkKnGoi4hoS6jimjQxk1yhNwM5Td
         /6EA==
X-Forwarded-Encrypted: i=1; AJvYcCXt3DWbuYkaUZO13NAWZllrm5GGKYJc2FiX8X+CUuOPka37r6cNwjbBWHUviCaxNGOW2g7NZhiyb1MR6Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywthk/0qCdS65/Ra7m942dpKcoUCVZJsEAuCVmOLCp2s6EVf5bS
	Rt7uVkygfyoioLdQfKaPaezQOxQfltgmO0UiHKYxvW+q85ksP+ywXWJi
X-Gm-Gg: ASbGncs+RoeqrrPgkns7ZDZcCXOCobs0rQyqzpHPaIlH67tLrpKpW4pm4SmLHGaTdnD
	q0BCZGIVF2g1G4usZUqQ4e4B8oOF3nwC2WVe5Sfm+10YY7f72cDdEGTETbRQLJaVqXPfuSCRQsi
	5HPnZpL7adloLdUP4oCT88vuX13JqFEWsCijvjBm4R0zt+7ASwXnQvvmWRVTmGtKsANhmfawrQq
	XSqI+xthK0C5BRkf9ZDq6DYZaI6BF0zACe/Dyn+1yWRB4rgrLYl6FgqNAzMBqHgGdDGueNutvPm
	40shZfk3iKoTD4WlQ2X/u75Fwsyc6WB/7IlOr8yFr2i44j4wVJv3Q+jQ++gzA5ckNFBQVcAYY3R
	ntY/jDy4RrG1H/DLtL2RjOoOAZByqozai6k+Ks6X156VhtRC2lB8d4s2MX6I2r+bogImgsTL3wj
	Vyd9SfxFpZ
X-Google-Smtp-Source: AGHT+IFD5KKQflxUKAzZp0jVPKQQRA0FESiph3hb/TkKSVtjx3w5Itu754OOQKM0Jsx0lX1D6seJ6w==
X-Received: by 2002:a17:903:1a4c:b0:24e:81d2:cfda with SMTP id d9443c01a7336-290c99a969emr82602655ad.0.1760767895200;
        Fri, 17 Oct 2025 23:11:35 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721936fsm14982735ad.114.2025.10.17.23.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 23:11:34 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI: rockchip: Propagate dev_err_probe return value
Date: Sat, 18 Oct 2025 11:41:26 +0530
Message-ID: <20251018061127.7352-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to return in all error paths within rockchip_pcie_init_port()
function. This ensures the original error code are propagation for
debugging.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da3788054..124ab7b9f3404 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -134,7 +134,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
 					rockchip->core_rsts);
 	if (err) {
-		dev_err_probe(dev, err, "Couldn't assert Core resets\n");
+		err = dev_err_probe(dev, err, "Couldn't assert Core resets\n");
 		goto err_exit_phy;
 	}
 

base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
-- 
2.50.1


