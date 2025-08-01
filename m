Return-Path: <linux-kernel+bounces-753698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61396B18697
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8702A586427
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17AD26B75F;
	Fri,  1 Aug 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS/sDff8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C426C39B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069110; cv=none; b=WG5CDqmFtIniswAejbXf3le77asakiNcdv1OQ2fAWLcO3GnfU2IT0b+iiyoEUGItecoRyVL15B+vEGHXxvL5GubDAz/erNTeSIaOv5vMyBxXDdCToy7Ttx1aN4iBpzrTLNuSBGse32iGK9BZb8wB/QB4jSSg3NYGpGHseY0smdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069110; c=relaxed/simple;
	bh=RbhuAWeaD7ViOs8NK3bvKp2+gub2fcMAW8yCl0/Eo3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgxc5yD/QfB2/uPFxIhf0hXxIzoaR8ZVD8lvmIAzN+GxxFNluMYvFWge0ZzKmCC2JaP7vWkqyZKi80ONfc5AM5ZSxv00uPQXYB3DKmHS0NW2KnZKxxhwz67k1XXB5H99MijnuSDZ3wKOxliNQYs82rGEyh0r3gSpaIfWCK8ySdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS/sDff8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so3701173a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754069108; x=1754673908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02fkad4eKiB6xVcDH8lydQ14lNJppnH2NwDAfq+kj7I=;
        b=QS/sDff8H3b4IyBpZLUVdHMniSNpPafSqJ39tzwn5n3fpydPz++BPc+jf+xaTtExMI
         mA8j2SMGOtDVhQcmfUlZjcufN4Vii44GPsgvB0ggROo4CceOGMR48koCLY20b8QljdFA
         i/Df0xQzetbblk7EeKR13pxNsixjc97ygPpAEnoG7J6nZ357kXrAshqJVGNFRfkSEoQB
         udK+f+3A6y2Y0INf5yUWvbew0iJvPpP+in5sI+TH8wDVsSntKPPZ6aii04HdrE1BuNfg
         lbYdUD7JTuIXYKXcROfkcPIVVRQSBJ+cbNmHHD2pFLI50A/emxtwLZ5sVlZLZZpC5d+d
         N4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069108; x=1754673908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02fkad4eKiB6xVcDH8lydQ14lNJppnH2NwDAfq+kj7I=;
        b=kirZ2pHyiHzctnqnugFLnVPPCRaoDfV9tf3+RlZ3tkPzcvaeWC5alrLfb3j57mkeCf
         n8HvPC8C9ffe4lVrwl2KVXXL+0xDeg+sxa13cDD9GxVZViCXPrYIH7eewEMy2tTbGlMy
         VWEJMKJNtf+L3ae/dS1NISm7D13wHRtVLJJRfZdBebrMA8P1P59STFdqEKg0Ru55kqu2
         1Do2PQoYUJ6VVAbnZQfATeGGV0SX5VLHywAwg6s+D+IEjYyvvHnB3m6UMuTbAQhGZOq2
         mW4DhaRco9TE56mCtCbO53Plu2DbfnBsD9v1qQOIdAZmGFMrnD9mRFkR2TgB7OKLhJws
         siAw==
X-Forwarded-Encrypted: i=1; AJvYcCWlQwyUDLGidevJD6pAzmqlvE/O7U5vmVHRq7LOT4AqmWNwKlt/VQ1HtI81x+iRIR4nGjm4Fo0bB6NoWPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlkS7dWOBkxq1RRwXln2WCTvIKsAsUuwZVV/zWLD1Yd+Q1yhR
	XQBkiJ3DRvq7+DQgUV70/ZYmnvI4hXrqUOwHoqfRISt2vHP7Um8g024+
X-Gm-Gg: ASbGnctxAK1iLcCsCqn3yX2rmBvy6B3VHrGQQbKsTsdSb3W0639LjkXYfewKsy1+RF3
	4GI3bC6fCHxPywJAfLiAmXHYUiCtgu0x9kdseVEJuz/EB5YYaAuIuWsvArFeOp/wqQAOqc6O2u+
	o5F2uPjcwktIxJWLdkNoXLrDiKiZttWj2pjrtLrqeKUhIVpCBkCKGfp5fILU2SeDrCWFYWYoIFS
	uhe3Y69jh6YyEER4nNWAU/Jx31JuxsBkr94+8KSYbfqXxRNQL/rGQTgvAEljNBB3GMtQqzJR3k5
	eXcK/D4U761y4FCc0fy3Fggz53tIMZqM6dNmoNjKZR5Bv1WOfKLOAO+smBXtf0PBelKKQJQQ9wW
	dEsc3zmvVxKAJbe1hB5Z0RQPpB5OJfC/oy9cBoPAO6FBxtfSUJKnxv1E60i9ZtrjYqERRQBxI+X
	UJVPMyFSl8
X-Google-Smtp-Source: AGHT+IGOvEL/v0KJNKqTgoWnSa8t0f3UojSYww4el0ye4wJCFD+wfbx7lRNSwg9E2lInbee/teiDxQ==
X-Received: by 2002:a17:90b:58e4:b0:320:e145:26f3 with SMTP id 98e67ed59e1d1-320e1452b4amr9666855a91.8.1754069107844;
        Fri, 01 Aug 2025 10:25:07 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-320f4909b8bsm3171514a91.16.2025.08.01.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:25:07 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: anup@brainfault.org,
	tglx@linutronix.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	maz@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] irqchip/riscv-imsic: Fix 'imsic' dereferenced before NULL check
Date: Sat,  2 Aug 2025 01:24:59 +0800
Message-Id: <20250801172459.94708-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported a warning in imsic_irqdomain_init():

drivers/irqchip/irq-riscv-imsic-platform.c:317 imsic_irqdomain_init() warn: variable dereferenced before check 'imsic' (see line 311)

The variable imsic was dereferenced before being checked for NULL.
To fix this, move the initialization of struct irq_domain_info after
the NULL check to avoid accessing imsic prematurely.

Fixes: 59422904dd98 ("irqchip/riscv-imsic: Convert to msi_create_parent_irq_domain() helper")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202507311953.NFVZkr0a-lkp@intel.com/
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 74a2a28f9403..04037653f274 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -307,11 +307,6 @@ static const struct msi_parent_ops imsic_msi_parent_ops = {
 
 int imsic_irqdomain_init(void)
 {
-	struct irq_domain_info info = {
-		.fwnode		= imsic->fwnode,
-		.ops		= &imsic_base_domain_ops,
-		.host_data	= imsic,
-	};
 	struct imsic_global_config *global;
 
 	if (!imsic || !imsic->fwnode) {
@@ -324,6 +319,12 @@ int imsic_irqdomain_init(void)
 		return -ENODEV;
 	}
 
+	struct irq_domain_info info = {
+		.fwnode		= imsic->fwnode,
+		.ops		= &imsic_base_domain_ops,
+		.host_data	= imsic,
+	};
+
 	/* Create Base IRQ domain */
 	imsic->base_domain = msi_create_parent_irq_domain(&info, &imsic_msi_parent_ops);
 	if (!imsic->base_domain) {
-- 
2.34.1


