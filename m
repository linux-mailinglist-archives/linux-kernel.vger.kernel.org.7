Return-Path: <linux-kernel+bounces-839778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A801BB2656
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B3323FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8CB1A9FAB;
	Thu,  2 Oct 2025 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX2k/IDB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E91BC3F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373349; cv=none; b=KRvlnGNdI1zJLcEzdZUJCh6tZ8y3GWXwoC4/+VEAttgOZV+JC6HrDvqAA69vY7Qf30ecRqjdpqC8rOVTvusB1GsGjezbiMniccE6bb2cFy7y1HMAJXr3+TJGsKab2fnxverzQjYdm60qvjLZUAK/7CRn3efxEGsfJnAlXjNr7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373349; c=relaxed/simple;
	bh=Rlm3SRdluo6yATbX4oF9ZqGmVsyUJvCoJRvFMc9x7uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nW41ywMaZDdYg1P2STvPP39vL+uhWgOyHoRJcUH+2lcPkpg3O5KZjCMw1at88iPPQsXMFTTTBHfUx6S7Y34+Eujk5b9VjBn00S4qNw7/CodBPJ5jTVrxfplB/hjdyIz0NInAHSu7fiRI0K66H20XXJ3aGjBBrkN4L6hnnR+5aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX2k/IDB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782bfd0a977so571744b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373346; x=1759978146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tx+T52VXaGxHIwE5ue3lwEYrArbLgvH+yochMGJeg3w=;
        b=RX2k/IDBFpj7OaiBMMNw2ldViDFkCSCVMLjiRm9ajwCmkjJdz/7W7a0ZEjwKSqktUI
         xn+zO/YTabnn/CAjD+gU36LXyet0alW1Sx1uj5cSQ0zepUpsd7yNNawoDFvhPuzXuCOw
         scCkIPjZa4Vdjb+BGVveCM9EAO01sTRdiyGmlLZGN5QNOS9rpUFKT44a+PYc/qMvEHNH
         LM2D485bez5S7WPnsZiol/R98+9t024VbuTZIvVnLumcyt7JlXHupaUPBXZGkmRFdMBs
         UQvpagS9hbPihMnv9oAKEYaOE6hB6ayfOSA0Ci7Osr5YdlMsCs6rFvhMjb0Mn32Tlcjf
         PAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373346; x=1759978146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tx+T52VXaGxHIwE5ue3lwEYrArbLgvH+yochMGJeg3w=;
        b=tiH0EvAZ+splS4FqAWEMbZXKgldc4kAy2dUHiqIHxhrFyjWDuQIotOAx1sVfsZrWeI
         vIavTe78RcspkBZxBgWsgvkLKrXAf/pT6OkBwYa1vpVMdxs48KRqRVcM3sVjEgevUOmB
         5nc9CSCfsZtWYrhEOQlneFfL+lO3m4zQO9+nRVuSJauujHOd07rEKXjmU+WxH+zmqsA9
         LpmJvK/6I2amzqyB01c6lH/bACetaO+rokxkWPFNE+Fhua/3THDNppAccYB8MFZSzsS5
         LA6tWKD44tVLG1thq1YMt3CMLlHbF2I31zZ0/azKukcWSUg/84pCneOOS/yO1k/R2G8u
         Ad1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJbG3vMqbjQ2ZTNrBnE1rYyjoIR7cZ5DE7zoYPTsfCJGOp5bEgmO9aBn2DLlIqM5BbjOkfDmRgwnhtJzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HJtaiFr0qZW8XXUD3p4+6xAha7xR7q6W7xQSGdckM8pH8Prz
	6lb5j+ZzKgJ0l/ucGuFxUlP1apgoS9GvajPmcZhEHCNoAJjRbWBio0Kp
X-Gm-Gg: ASbGncuI/I2WYOdZOZ10dREHKfwYomeKVpvZJJIQ4GSS1G2uwyQ7unG6WlVOPjTPT6y
	8ZK1lW1X1+r+lN3bKpFE32OZ9GPdIWggpmQS+Fe9+ivvwZTDney6qe4999M/v92z9qqygxW58rX
	sCYfXgRAu8N/dkocQ+GONGfPfYys29vixWwkufnU/BWN/isE5gftlImzboGtOO60T4d+TeAOo1u
	rLNERK3yWIPB39JOl+9hBZw+Rf/9OQiPP7jgvHd7nvlbILu8S3md/zGZ4Y5CXd0mRm5D7bHY65h
	FtMVJXPzv4vVAzulnuAAz1kfhg5p2uwTaRc+L+Biw1tWt8XDwcygofjhu/CnvmAqMmFFnPJ5Oq+
	FDEA+TpaK1kK+CIf8AY7zGM3vyJYZzHOTXv4TnnzvBz1pxRGSXwM5ZPPrGpxZfsLI/v/Bwtg=
X-Google-Smtp-Source: AGHT+IETH7I1DUb42a6zVBccP/CPta+Puwg/XA6sZLcvnAAu5JdYF0uhLuw9HJFtEs02mk+EPLAu+w==
X-Received: by 2002:a05:6a20:d306:b0:263:3b40:46d4 with SMTP id adf61e73a8af0-321eb7f0ea7mr7236687637.56.1759373345690;
        Wed, 01 Oct 2025 19:49:05 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f72f99sm845643a12.47.2025.10.01.19.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:49:05 -0700 (PDT)
From: Sammy Hsu <zelda3121@gmail.com>
X-Google-Original-From: Sammy Hsu <sammy.hsu@wnc.com.tw>
To: chandrashekar.devegowda@intel.com
Cc: chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sammy Hsu <sammy.hsu@wnc.com.tw>
Subject: [PATCH] net: wwan: t7xx: add support for HP DRMR-H01
Date: Thu,  2 Oct 2025 10:48:41 +0800
Message-ID: <20251002024841.5979-1-sammy.hsu@wnc.com.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add support for HP DRMR-H01 (0x03f0, 0x09c8)

Signed-off-by: Sammy Hsu <sammy.hsu@wnc.com.tw>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 8bf63f2dcbbf..00c0161f0c78 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -940,6 +940,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 static const struct pci_device_id t7xx_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x4d75) },
 	{ PCI_DEVICE(0x14c0, 0x4d75) }, // Dell DW5933e
+	{ PCI_DEVICE(0x03f0, 0x09c8) }, // HP DRMR-H01
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
-- 
2.43.0


