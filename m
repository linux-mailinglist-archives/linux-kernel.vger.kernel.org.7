Return-Path: <linux-kernel+bounces-822421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC8B83D35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E981B23CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688C21C9FD;
	Thu, 18 Sep 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDJkVhWo"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B642582
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188197; cv=none; b=gV3qQMuKfQXC9vaNVoxzqduj07q/b3xOEfZfMLO57FQutN6EvFn/OiLpJ6+cKGdD2DsNPlxFtfhuHHkVbgcWTNc4xM1zjWJKbz91q9CtZLwdlnzjSB6J3tFSIjWVqR0Wff4zWKIw6BGaLqxTdFNdYE0ixWZAyOqJXbxR8AT+4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188197; c=relaxed/simple;
	bh=WZdbcxOzbiNsQtB3ULEYsVAVNPqktdSanKBGZLRQ8a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7pxxOTpQbwGTDWH6puNRdWiF0dp/RpWASwi7KpvxJrKwH2fOq6oJEkZzDLwPhjC8PE4KYwEA+Vd4gFAEuMt+Wr5uRhsThNtnbY5qMrFB5foRt4Yp2tOVvJyZR1uTkP25gD6jUoP/ebQGrhLbHuwQ3m6M49D1viEvM/ubj6yDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDJkVhWo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26799bf6a2eso7578325ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758188195; x=1758792995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBtG29DuxWk0x1+vO/vrZiCN7poYWKo12KFNkdCIPk=;
        b=MDJkVhWooo8RgpaixpJ/gWERyqG8ybrXA7r8WTa8+1eV031PisqkSSyqIVRuOh94t5
         Bvg9sUftC4nQXV8JaZJaIhFUg3yqlIa8mi1nKATG5snB5/aa8hz5t06WCjbeGjPkXEVy
         QSvkDHmbXDWElcLjEu3T59kPAFmLIy732ZPWes0UIbAjt/Sbwjg4pz8f6sTWAqP7cwjq
         YvpaZHAcE/XwT9QNO8VV84V+t7Cuzd3qJwQ42VMv4G/k7D9hUGS6NsyQdSlfmg65htVh
         GISaajzyltU1taXqpfg2P0HmA3LcWjjb+tb+VomlhFgsamZtupPFzF9hxGfMYLZ0V5q4
         +AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188195; x=1758792995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdBtG29DuxWk0x1+vO/vrZiCN7poYWKo12KFNkdCIPk=;
        b=Ssx4KC1IFDfa6COIDzSYxqao8eXwAFlIm0mDCX7Cm4AZEwwbJty4UoDOfu5kMRZ8R0
         ZrLIoWEQntm7jRJLNcnq25KxQw9iKZo8ZANPELkQEil4gyZXcWS+FMS1C4AbuCw7/zbr
         81AiI5PM5wdN0nXz1AZqcKrzIGIqdHZRVndSpnv1hyOBDBpBRm1DICJE1gpdRpKGEolP
         u+iG/JEKObY8OprvHkUBtvJ7Co65P5/DZeaa8z1HHJ4uG4sZKEND3TXxl7oWKa4tmgdD
         xvLzy2nx+wig4YSsUpZlDdQAaFCl1mZMljCkVCxgqCG/VgfSF7Wn8WNMbJEKUrvxxDCc
         SUhw==
X-Forwarded-Encrypted: i=1; AJvYcCVf+UVIlC3ZXhlLoclSyIFGQAmS/zT74tS4NGeIuDqJH3UO2Fqp4C5xRnIMMVGep+kJBmY5p2kh3ykatD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvMu+bs7YfD8sz1lujvisEbcWSk0YhKNQ2AFvdBX6B1qBlF/1
	w6RBGBFwqo+SRoevkJbTu2QI+bPWeoE5qyO8Jx+TEr2f422St3lrj4jH
X-Gm-Gg: ASbGnct/IR7j8xI9AZOfQsLYaiifCs6d6j+QM1NteLqmzWmc+EKTQIrIZXIlLVm6B3G
	+r1wv9DsyVvA4cGz7wACxquM/hN9Ob7jyNt1vzI17Ig4Mkn4QDN6h5+nTzpVYYqh+dKx0dlE0mK
	BlgNWnaT3nqUH4ew3X1pubQQgt5Tt8iBLkIrZOYOhi2IoAE7L2shTWcO3IxQR1P2jkpVgooTbbu
	q3o0VXZJ/mchp3ebjiQUrJjJigAt4Xfeb2UCsrodysA4MW5KIIllSI90vI2uMNuXR0OhiN69WSN
	Fo/Fk2tkD8rtWdMx8el/lS7kCkhaMFm99QszWA+GwisgFTWyJKIqyGU7bJfw5BUjotpysvvP7r8
	DkSku1qZWCPwCfWWWovoeDo4GCyVCwOQtTzMyjCHZ8vDLwiVBFBI=
X-Google-Smtp-Source: AGHT+IHPVQDk6Ab2pQFcVltfSjSsGNPhsS0OloAUxOVgDrV9vtF9WjkL/knZUEDWVPGNTRaOkCpGOA==
X-Received: by 2002:a17:902:f548:b0:267:4b80:29c4 with SMTP id d9443c01a7336-26813ef9f5emr69353095ad.59.1758188195347;
        Thu, 18 Sep 2025 02:36:35 -0700 (PDT)
Received: from lgs.. ([112.224.155.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030d8casm20015275ad.97.2025.09.18.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:36:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/smp: Add check for kcalloc() in parse_thread_groups()
Date: Thu, 18 Sep 2025 17:34:15 +0800
Message-ID: <20250918093415.3441741-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index dac45694a9c9..34de27d75b1b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,9 +822,9 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
-	if (!thread_group_array) {
-	ret = -ENOMEM;
-	goto out_free;
+	if (!thread_group_array) {	/* check kcalloc() to avoid NULL deref */
+		ret = -ENOMEM;
+		goto out_free;
 	}
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
-- 
2.43.0


