Return-Path: <linux-kernel+bounces-734187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0AB07E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACD5507B86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A32BD598;
	Wed, 16 Jul 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8lbtstf"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001D293C4E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694779; cv=none; b=P07Vl01iVPP4LkWnN6MeBMX0Ac5mgtMcQhtUlY4BN1Hl3ZxNLBsqXw1R9+JX+QzHEAuM73JKcdDZw+4LhQVW3iMVxCp2tgPEkEGY8SBKVmFlYjDUDmI9a1sFkOssaacoJNt6IVFFsIzSkUyk+P9TXAbugL+LzMnhZUTfN4cyXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694779; c=relaxed/simple;
	bh=c3XKBoYDYcEudxH67q1tANvc312RSld0jflutzajsLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dN2wWtU9buZuGtSjikcQLmvw80MUhFnSE7g49LV5XlcFUMhaELG5E9YTXRN9MjmVLdn8PBTmX+tS3fG5Z05h6yiISTngJ7gbfMRsT0eTgqJ2mc0W0gBCdjsbv5Do3itsRfmAgdaeJS5P1pDT/Yaeaf3Or8hRWG9Hj9LezoHCDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8lbtstf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fae04a3795so2857536d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752694775; x=1753299575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MT07KRj0+nBHa5goGNn8vSfLfOq9Y3KUUirgwPd/6M=;
        b=Z8lbtstf+tXiMNOed2BF0rHHKdr7uSwl7dqR6st1zENS4tw851mcTl7/DnGX6XEKu7
         qBsKnVEqKerALMKXSfTWMalGWjuJiOh/HYTZ1F8sD1GfSAqY26/h+ZvlZltRwjgakUPW
         HVehE5u8MzMrJILeu0kXv2uEwMxOe2rCfGaiJkWdQzrNuYI7+ot+kInHVKzn8lkZ8t7z
         xsL2d5qbWGhx3Kgdu0d1kySfCiExFwzZL0Xqg0ZfPoIkYFQHMxJ+rg9RhzK5F6Uj/P0k
         TKnW5lXDfvETwph73BIEjqmKaQfsmCDLWTwERLg5IO05YZN9HNCemi3Tby3riGYf+Qdb
         vtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694775; x=1753299575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MT07KRj0+nBHa5goGNn8vSfLfOq9Y3KUUirgwPd/6M=;
        b=fz5y7oWyQ0hfLdNzDZqokyfS9RimEbD2Sf0U5u+HjrqI/omExb7J37sMUKtL5XF9og
         FYHsVGQQDh0wTWWhYA4SDBPcllDZDhmbhWdO0KL4kxS6NPAV6m46uPTH99kCUtEKmkA8
         5DCIuwxd+90Lpa2qfBTZTf7q/9zmWb1bCY+twbCQVvedFwN535GpWITiIPpQtSBXZ6tB
         AcsePUBqNQ347NzFrpxsur4SifgCQGOf53PZseOTWfyaRvjKOtsF0/utZ7M8q1jycMWM
         2djA1or8aZDaywTjoDY3RtbHFtrqobHhXl2gxS41oHrTtIilXABFgsP3nOWm146cU8Nx
         f+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn9TygNZAzoG/sReXXjlTkQ6dGUTNcuyZHfy74fxfXSWSEuZwpeNRJ5HEEWnHlbAwXuWqUoKUfpXu7PiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpESCZY9wK6elrDi2e9QghhRizUTQzyZZ8ffSzcxL/xLUJWR3U
	Nblu2nMQEZZCSmogjj+v1p7NdqHK1FzsMT23gp71pgktBTK26tbdPvDo
X-Gm-Gg: ASbGncuOo8ZjJ8l5e1O45a35SJgRC/wIdRRTOKG6/yBog498ebHfL9Y2lJ1DwQmwpjw
	vHULfKfPkSyVuaipTNMzdBhk9DOJrIeJm769dJ1TU8+UTjtLX1WZ1a5B2w2AOcyydJILbmGchSw
	8ET/n9thYRqA7MmIrnlGMCdWo6lVQ8aeLQIi+ppN9sxUwLPIDogu8uvBa6HpGlbGXmwCmDNcvQm
	q2qCsbWeoanba3dfwuFu/7gD+9b/gKFQmujcRgCG+7bXsDkCt+FYLltPbZv5loTQBz/UOoBlkJz
	HaGbO8YZpIXJUWnnh0jINFwp2k3l/y3r4JGDeNZgke+JT6+gIU3D46fIP1BuQuVPsfbfttJzHPd
	GEQf0YUwoIZAiyrElhhKb3NO6
X-Google-Smtp-Source: AGHT+IGHA5FLzQtNAaDBUYWyu0Vs8vPCKhVfV7bOFIZAyB/3BPDXqG78jlFVbhKYlhX+ZnNFQuCM6A==
X-Received: by 2002:a05:6214:5788:b0:6fb:25f:ac8c with SMTP id 6a1803df08f44-704f4ab51famr83145786d6.31.1752694775318;
        Wed, 16 Jul 2025 12:39:35 -0700 (PDT)
Received: from pc ([196.235.182.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab6386c9c8sm41932601cf.16.2025.07.16.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:39:34 -0700 (PDT)
Date: Wed, 16 Jul 2025 20:39:31 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] char: xillybus: Replace deprecated MSI API
Message-ID: <aHf_88zgSElheIZ-@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors(). And
add pci_free_irq_vectors() to free the allocated vectors before removing
the device.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/char/xillybus/xillybus_pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 9858711e3e79..fc7bffbd36ed 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -76,7 +76,8 @@ static int xilly_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	/* Set up a single MSI interrupt */
-	if (pci_enable_msi(pdev)) {
+	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (rc < 0) {
 		dev_err(endpoint->dev,
 			"Failed to enable MSI interrupts. Aborting.\n");
 		return -ENODEV;
@@ -112,6 +113,8 @@ static void xilly_remove(struct pci_dev *pdev)
 {
 	struct xilly_endpoint *endpoint = pci_get_drvdata(pdev);
 
+	pci_free_irq_vectors(pdev);
+
 	xillybus_endpoint_remove(endpoint);
 }
 
-- 
2.43.0


