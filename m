Return-Path: <linux-kernel+bounces-844021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AECBBBC0D96
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE84F41DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343072D77E5;
	Tue,  7 Oct 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="hEtcKJjD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045362D7DC8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829019; cv=none; b=R8+PfXxAcjvPgGU8MDOQXd1IGRO5zVTLwQfIZaT7buKHsTHB3aUQEE/6zfzGkMxmBJOC5q2VbYCoXohLo1fUTFvq3PJxjfl8xPXCnFzyXt8Y6wdJAm3MnKzbaaa5wVpQe6eHgYqe8YmYRYL9pwJikV4O3AKB3Tsj9R0OpN5OkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829019; c=relaxed/simple;
	bh=U4GkNtp5nOav2nmyt8vVluDERiX84m/g+t6fg257pzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQqOqPS7Y9xpeyGyqkJz/LdPuYsKqb7jCvC6sbnsULbtp8NiZzg69xZKGjboCyEvcBtXCLsiddXq6kqnbVc+DwIJtFfWPcc3uWm3prfP8sZw0RH6wNRhR8/slFduDhfGzkFJmn928C2KAFxFhM/Lo7bn6Q3H7FadmWORAiJ5Nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=hEtcKJjD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781206cce18so5074831b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829017; x=1760433817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9DzUNgYrybOaCJXzvxFTfL7BnySvd74Sjls907O7gc=;
        b=hEtcKJjDf9vw4WN4ebFEKxEDRjTEh+g9eQLRDU8K3LIp6gfMRhoyamZOhFVozZCMDM
         wDCw5U2e/nFRkiqgM52mnFU0aH3Yy/sxv4rWvPF6D6+q3fFpDm1F9evs6ao87cJHJRJg
         6XWW1UzDKPNZo3VbuEV4NKg/gQfJJyztZWA7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829017; x=1760433817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9DzUNgYrybOaCJXzvxFTfL7BnySvd74Sjls907O7gc=;
        b=fnYJMbmgFfL6k2tnhVMKSfhZAFCWYRBI9zg0hosUiAFzcIBH4vsGnlGfrvrXjV/nxQ
         fMROFyiuUarGQjZEJEcnUinAXEaEM59/v/M3vbVUPksUpyrdxhFnNWdXcCPTntV3HY9o
         fixV+x92rcMQOVlC7cD7JXWcAOkmfPt1os9Am2CD1GaGYS95zTxjhWtR5DSuDdmTksJ1
         1zswnPO775FkUNKMnpVITdWIFYayn5i/XDrCUVsK2EvfkTU/R+NUouPZTKXkA/BzLYLq
         ebao+8fBiuGz08wIJPJm/ZWhZ/u7XGB0w45NUj0BGCp4+X0iUK6CoQYERUkPsCtOjBnE
         fwZA==
X-Gm-Message-State: AOJu0YxEpqgsoIG0kN4aP61PPrjs1WuYtmw7O9+0NAcNdOKEnr8xAWvA
	Ox4tBUMoG/QXOpIUjaYnQ4ux9uLhl9ysfGKTHGeLSI8Rhmrt/DNbBeCCVqPk4Junvoel9M9h6GR
	4TymCI7g=
X-Gm-Gg: ASbGncsrZzpTwePd8Fm6QOw8UndpP4ZsdZXlgzBWJRZ9F20KnBOHP8jOGjY6CFdGpN6
	pse7bvlS77r2kHAHVFbyySan/OenBZmz4VQCYzq6ep78fcuM36j2fCAL7YZNpwk+ZIVz968H0GN
	QpjLE6Y7Kw7Q8MnwkIfnYlToiJIzcmIM1I7kD7K27NqU+p/PZqogPoYi0vd7UjtDFvaPVmBu4/v
	TGrahpaTn8O59HLqcDufPwMjs/YHEpDCX3dIaslVc2rTHodBD21qUEasyeIiYKiMKd5UO6AsyiI
	sK3564ZR95KsJnrsgGLRlJuUhOccQnGXVN06q1cCItacRNdtkPJrgMulHMjcRo9t6dqxIkAmYS8
	pMFW9hHw1YXg5JdcaU/1jFtvWuCO4REgnfpJUY5oMLnHMdNPrBJeX/MO3E/pz4xbZgHLAeluPYC
	+MXROa+CvD5igyL/tvVDi5ICRQW6uBBAkEtbM=
X-Google-Smtp-Source: AGHT+IEwApYE4bcVoj0TdA/p3fC9MzhC83ylm4Bt3jZjLY09+Fp8yf60U6Us/aOsm75FFyq+QvCLWA==
X-Received: by 2002:a05:6a20:e30b:b0:2ce:67b2:3c41 with SMTP id adf61e73a8af0-32d96db80dfmr3802640637.5.1759829017271;
        Tue, 07 Oct 2025 02:23:37 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:36 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 2/5] m68k: Increase number of IRQs for Amiga to allow for PCI
Date: Tue,  7 Oct 2025 18:23:10 +0900
Message-ID: <20251007092313.755856-3-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the comment the Amiga has 24 interrupts but I needed
4 more to allocate irqs for the 4 PCI interrupts.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/include/asm/irq.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/irq.h b/arch/m68k/include/asm/irq.h
index 2263e92d418a..ec944dc27710 100644
--- a/arch/m68k/include/asm/irq.h
+++ b/arch/m68k/include/asm/irq.h
@@ -24,7 +24,9 @@
 #define NR_IRQS 72
 #elif defined(CONFIG_Q40)
 #define NR_IRQS	43
-#elif defined(CONFIG_AMIGA) || !defined(CONFIG_MMU)
+#elif defined(CONFIG_AMIGA)
+#define NR_IRQS (32 + 4)
+#elif !defined(CONFIG_MMU)
 #define NR_IRQS	32
 #elif defined(CONFIG_APOLLO)
 #define NR_IRQS	24
-- 
2.51.0


