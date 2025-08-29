Return-Path: <linux-kernel+bounces-791210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A6B3B380
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101DE16FB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5F24E4C4;
	Fri, 29 Aug 2025 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJVJKVXw"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C0246BB9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449286; cv=none; b=cLI55lwpxwlmUnszvD1NRoc5WIGDO4/auAtTqfqGTOU1Hm37MoOmGqH0+ye0BNCmH6vM/mEuh/M8Dkui0r6M7i71uZQk5+Yt2cmRNTBTZrB02uxCTWUUZMxDP+SeT3ihUdWIT46aWLONyouW5dY7lGeGYrSn5jQde8ErrpJMYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449286; c=relaxed/simple;
	bh=DnxufK8oQk3cTsyEQGB2d/ugJ483fwgnsE/veV9s+Po=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uxhcNNsJxJAFQACi6G3gWg1ogQKHlbPK3xLbyUjdtnTUiCQGxwCCBqVlyGYAghr59Jo4mRrYsZnwaAtIYaCWhkaBhVrSs/+faouu19Ms37IVTtw1b3Od0dF5iC+n9rOmGyKHUMDDxc7hIh8b7E+F7Jm1bpcb7N+jVmgZP1BuHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJVJKVXw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so1269116a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756449284; x=1757054084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Uk9A/FG7B42gb2VzW8SPYRISI1iCRcnu9NRgkgqh+M=;
        b=iJVJKVXwEEHrLqhDRiuWz8JIShFZqZkXyc72ijfk44Anqx/wIrJg5MdUgsyqmDthiB
         QwwM55mDzRHF6A0rLroCDNIW+GXaJuCwJSWMBLC0iP2WyALaI+O0nrBTGDxRaGsRYorQ
         AeCzNP+nXI1WijtD0zXjcsEeXQ/+6Fq7lkWUifqIVch+eBZnxZMJUMf85H1K/b2O79YH
         VtvQTVZZetMQh6zfqa1zi8TfBpjDxKbpsutHrJiNgFFaCBe/y3b7xdib7EqAPoUP4zkH
         6qb15SYwExw0YK/HsQNQp9Tkqs06vFjLxbl3y/L6cssY7coKhN66t6TpWQxu6pjnIvfe
         b99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756449284; x=1757054084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Uk9A/FG7B42gb2VzW8SPYRISI1iCRcnu9NRgkgqh+M=;
        b=bDpK612SVHlFPJwPQSaRkETLULLtZ/nIZS9HPsqFy8yma8xYl2bbfi7mYqElB6K5Fb
         EVkBIZU4kteTkaLnrUGLsQoTJQV+wsJMMRQbOSWTunrapep3XEjkql5G1TAgmWyxAw61
         JFsFCXRKbTYohHdWiYe799Ducm7Pmev1/1xxHNSlAQqwQ0hoFsgakRV7YTlryhOXzIIu
         5m7ZwjuwIwUxE/2Q3yRWIuC0/Q0bK5X/fi61JKlUcS5MZI7I5PIQC4yjKlulsYiGbwGe
         Kcll2wfttoEewGkC5gmzfOy8LDy4bZih0f0e1JI9f1ePcb4w3A6jTAzI8dQdqjSEkbBZ
         4HtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqvvBcHZLYiT+61BqSAatWNlPx74vW4FSkaXxXPzgqjIQofZtMvX6+/1GYiNL4jB+qb9ld/oar8OJMkgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAPsr1dJFRB9oYwWJh048Yg/rs9IOC13GY5wt4siR2ix7/oT/
	gj3rTgrr3PNBKIlEzOU4B08sPOZy4avL+5bqyepfsK37h4OM7S0gUfQu
X-Gm-Gg: ASbGncsGdhGaiE2DP3TS7xBp15KV4Tv4t+3HHW8Ix2YSIU8DmBcE/UXP4/TA3QA9MBL
	w3bfznK+LT/OvPZieaXlm8T7UPXLid9VcVDHSUqqejMiyHR2SfF6tp2h3d59dXR96j8uhZD/gGX
	8iDxXxSIlfhDv75zWVjdljiCh/9OWDQ+L74zyawwNHqzxmQvKPUBcwvXiQQPOhFS9jjrU/t/9Iw
	k+ZtpmCimdx44gc0Z/Iz8GT1goAqqnCvibmVIzElMixmqI4nLBeoWe0VeROGBMUE3/NZ5NGZst3
	f2z/S0K8G8ckouYieByLIhLao9PLpyrRhOmsAe3V9r7rbfNE+qRwbY84v/ufz1DmXEUpuZncpvA
	9v+O7yeyscpFWi9XDrHvBISLqtejs2hOTV+5Ca5T0saMXtXg9NJi15Dj/0SLhDlTQHeMKpZAGuF
	BI8jHlf0lSycxWnUDPP1+iV7/gACCYlgSt88TO2fOR0zwjOw==
X-Google-Smtp-Source: AGHT+IEi4c1OOUaryaWljuCN1SqnkkZwaSknWakF2y1Fc4MSZv9q8cyL3Fs0HmaehVnQcEVjzHb6GQ==
X-Received: by 2002:a17:903:388e:b0:23f:e51b:2189 with SMTP id d9443c01a7336-2462ee4579cmr353046335ad.17.1756449284029;
        Thu, 28 Aug 2025 23:34:44 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.36])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24906589986sm14035695ad.111.2025.08.28.23.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:34:43 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Miaoqian Lin <linmq006@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	Olof Johansson <olof@lixom.net>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pasemi: Fix PCI device reference leak on error path
Date: Fri, 29 Aug 2025 14:34:29 +0800
Message-Id: <20250829063431.1968903-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix iob_pdev reference leak in pasemi_dma_init() when dma_pdev
allocation fails. Ensure pci_dev_put(iob_pdev) is called on
both success and error paths.

Fixes: 8ee9d8577935 ("pasemi: DMA engine management library")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/pasemi/dma_lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 1be1f18f6f09..0ba05c39c276 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -530,7 +530,7 @@ int pasemi_dma_init(void)
 		BUG();
 		pr_warn("Can't find DMA controller\n");
 		err = -ENODEV;
-		goto out;
+		goto out_put_iob;
 	}
 	dma_regs = map_onedev(dma_pdev, 0);
 	base_hw_irq = virq_to_hw(dma_pdev->irq);
@@ -617,5 +617,9 @@ int pasemi_dma_init(void)
 out:
 	spin_unlock(&init_lock);
 	return err;
+
+out_put_iob:
+	pci_dev_put(iob_pdev);
+	goto out;
 }
 EXPORT_SYMBOL(pasemi_dma_init);
-- 
2.35.1


