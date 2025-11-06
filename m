Return-Path: <linux-kernel+bounces-887671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2132CC38D93
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAD4EED5A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B52472A4;
	Thu,  6 Nov 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz5G2w0n"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFE23D2B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395637; cv=none; b=WT2hXL4SkU6NkuLiK8ZfdUcmQWO4AWcWYYpqbI8HpinaBfxixspm69y4f6gpgzyDXD5VBCs9pCHK136m4TJ+UdHiDHMo5sJqjWUNBX2wEwtKshLbY6LOQ9XYTWsiDTjaw4BYK98aXeYigom5T+mTjm/x3dj7pw1rQjufYma8EH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395637; c=relaxed/simple;
	bh=rSbLt+ddIiogMpjgjBnkgQxOsiw/eWenHfzbMTcNGic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbhPxfiCtVZnLOEGrhFDtZTvg1TBNelyUjppgaGDvcH3n3N369XuD0NwYQBUFgwJ0sUBDZpYATKJfjQ5qA0ELFWJ9H0ziqV+4p1Ptg3bRkaVpZZV4AnrnqA7vy2KV+98RGYh28YmNp3YUPCtgzhFBZrkkGb4QB0F6A+r8Cv2MqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz5G2w0n; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aea19fd91cso688293b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395636; x=1763000436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr0Vse2Y5fi04cdwwrJDnW3ctvlVERZyfsaruZe18ZU=;
        b=Cz5G2w0nyhS/43Q8+hGuGvxSFWdb6c3ZcWY8f/5qJOO4Vyv+2PeQRhDfRKjbpRM1ax
         JriTpYxU9jAtMxxUHq2lXxza7P1a02RQQHEqRuw+HtXOdXIFjA3VWecj6NOCWMhvfPCy
         K0DYpZdO4llPIZkiMsdZpjM/Ke/TszGP+PJ/LNopB4wnM95QqqqwZXzyiAuKz/baMTr/
         lilMCoojnDHV0lCj/6q0umZ+bSwrWbZP+Y3ECr/n7qdu3IPeAiibdcGmO6vqH4A9WqSH
         U6+qpVb//h3+19dmkMVu02roBj7A1MJF1Yoff2rqNEDhDsS1loOeUMl8r3ePInGL5qe2
         S5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395636; x=1763000436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr0Vse2Y5fi04cdwwrJDnW3ctvlVERZyfsaruZe18ZU=;
        b=MhWGEop1mS9H1+w6jB8U1+HC7FFrlAOmFiHhlWMFucXQlmTL3Vd6oWJxwNSdeTdViQ
         QGWks4+vneXxvTQ32LwqGb30N0q3KwH10Nw6iJlbvspbJqMqF1NNuj1Br/B+i7QeYCLK
         P0cQcHMu6+KjrpbFnTHSncXMC+Fzc0QCba24LJkfMsgAJb2AKYqRGykBuoHQpefKcRsS
         D7N5rK/OZSDvh8wRM8i2uJ2N+Hfp8CWphehJ08WOfg9jDdCGRwUsm47/70eQI+wXTPAS
         EHyakU16z0FVfZZARE12V9+4aVbArQ4aGjMpOdvnqrXu0DhsSd/j59D7SK8Q94cZPvIF
         b4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP8Am3aErc9F8cSoIK79pxIqgK7Wi765c1pAKCAZXE44FKZaz/pQUpJ8tw6Pd6NWIsaNkg+mE6yMZL37A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7n75ax515D5FTVmD9Sx+4eaNzQe1T2aSQdTQZYYmsp4aa+vxX
	JpnKtRsNbIAag4nIpwvZdb26O95MEFw909QybQu6VZ2b943k2yROwMi8
X-Gm-Gg: ASbGnctRUhO+M31C4V7fgwjR0sYIq97TQ2/99uRQ+dnHwo0ZNzLEgUvJSe+z+x3aI+P
	t9ciVlazWDlpViqr+iTR+F4b+G4QlJuAuLyykSKkzzPdBqV/s1Fc0bhXpx7DBDVOVvMBHzx9lj/
	T49A4r8BP4SNcb2I57BA90wf/+0Fu8sjBD/HieaeT6BFEANPw+6/zoS3OoH4Js9AZSiW0fED6SK
	tViI2KDeF30H57V7hUR/G6ac60Biag7Sg9tcNuaDbeOChp2B4olSqyVDmBGp8eHbM80/RZIiVND
	Gd3+ylGoRhTUJBFkTtFS4Lo0Odap//vSpvlE+o/ZCA9cpwYSaScRbhl6EpL8Cksz2x02qNIby9H
	eaZzZdQPsxRuR0skl/vrTSDbxVd6FYrO/vhPF6IF5nnTIf4o=
X-Google-Smtp-Source: AGHT+IEQBBkO+M7qfWlA674bZguEe4T/U7VSYvqSNvaqCY06piaQC5cOyLjhg4IkWXUoHoyzszlh0w==
X-Received: by 2002:a05:6a00:2e91:b0:78c:995b:4e9d with SMTP id d2e1a72fcca58-7ae1cc608a0mr7699152b3a.10.1762395635714;
        Wed, 05 Nov 2025 18:20:35 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd57f91sm830516b3a.23.2025.11.05.18.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:20:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE)
Subject: [PATCH dmaengine 2/2] dmaengine: st_fdma: add COMPILE_TEST support
Date: Wed,  5 Nov 2025 18:20:15 -0800
Message-ID: <20251106022015.84970-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022015.84970-1-rosenp@gmail.com>
References: <20251106022015.84970-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add COMPILE_TEST as an option to allow test building the driver.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1e7c8f031b19..243d3959ba79 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -590,7 +590,7 @@ config STE_DMA40
 
 config ST_FDMA
 	tristate "ST FDMA dmaengine support"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	depends on REMOTEPROC
 	select ST_SLIM_REMOTEPROC
 	select DMA_ENGINE
-- 
2.51.2


