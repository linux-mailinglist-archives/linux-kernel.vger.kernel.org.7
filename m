Return-Path: <linux-kernel+bounces-881753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFDC28DC7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D613B473D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8726B76A;
	Sun,  2 Nov 2025 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6LkIV2i"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FA1D5AD4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081086; cv=none; b=pnFzj3tKDMWQY/wmiYseHUrtScRcrDTjExl+x04HiRIEN6NJhmc/bay9D6lvAXiLhiEwrbIHpWBKhwN4uSNhkQgaLOiD0mtJhxaoQFQ7JTLU4zlf0qRUdMKyqIiMHzhw4uJu8KizBrnSlDhudyLkJ6jj7RAMAgI8+fSX7LFyurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081086; c=relaxed/simple;
	bh=YYUim/jEHT/moxRP+um8D0ezgl9zrVelNIUP/7RdRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SePm/rZl4erid8+VYN6fxi4jkf7pUvq5Q+aSeFSI+JsFuMcGTN8TDB6NtbfDq3PHnTWpQEaRbgdHBEOfst9cwxtM//w2rB7H6CrOXudj4CiIvmTiyAIa2htzZxhWJGiDasnEfa9ptHYmRj7nX8gxBy3sCndOh3d9XgVIgEGL1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6LkIV2i; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2870795b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081084; x=1762685884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IacRLUig7UN08q6stRj9OVGSX398h8U/Zz2TL8Csh6o=;
        b=G6LkIV2iTa39bL7W8nsrNbzEQXLw4K9F1LtQSyYSaI2MLOGLp1RLN19UdXgSFo5TXv
         phzOWC/EB6AwlRl8pdWqVMMG1aF+Oo6pMum/rFA9iMng2FEYa+iltwPYprcwJ7q+FWWj
         2YH2kmEz0sa+a+JtovtZoWuISmDuvC8mW2XsRIUPHOUbWLNjsFVz5I1L6ZV9tDKJJvCw
         5fcRir5LitGrEnexJIj2BlkJYFB/lcYZMXX1NXg1ibZHbqjEkSJNKMj3Lcc9VMfuObUS
         lVdJqptUD0LU8JsxydtxXvIe1zY2KuygKXW3Qk8uTVwOvcx6N57BUMJPnj9m7/bv5sif
         8Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081084; x=1762685884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacRLUig7UN08q6stRj9OVGSX398h8U/Zz2TL8Csh6o=;
        b=cvHqiGk7eR0n3VSlXMaue+OfOGdXjYwf91PpZWWoINReEOg0xolaTCxiPFPdwv0uK9
         iHK5DFFQEHbrmBGAGJkaPXkXGbhqKHs1ALu8xVD1e4hmjo9KoYAx+Px6xXbdkrYVcYPM
         mAMyERXDXX+b8RrDtJ5m2+vqIAATLUIIVCY/+I2Y2QS/78SK90MGVcUzN9iHs6qJ4i9L
         NT4lxTI80TM3Lgg81hsTNaJFsPhyae/a9IEew1pNR30woAfNYaS31AkM0MsnduZWE0Rv
         wMSNoIdLovqUXT5lb+uBgyxs0zI6BBzuC2O0rwgsHtm5mpmovG04Jy32OgKFp47CjaIc
         WM+w==
X-Forwarded-Encrypted: i=1; AJvYcCVQSnnoLNQprjONfIOjhx3V2poZEVtGq62sAONgeS1DTf5mt/dAC6WcJIKSVyoVAtRU3YRyFL3uhksEgq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/p2smIUYqEYE/vjXRn5SaF428rDbfvhCM+sbx64u8oLH8IHqK
	Gtj9MS2OjtVCCrswvsFpNIfVFMSv8JGfu/QYZFYGLkTdD2FOG6gerWbO
X-Gm-Gg: ASbGnctwLyHEmjenib2u846WMZT2Iu4sq7PszF7jsy/+rbsK/Ck6wOhcmGX/vSRDg7c
	JxisgrTh8vQixFu6tiNSu1XWtI1DW2qC2a1eRjf3+GYmZ6cnbXZ3tCq7NwgUL5DRAJNO/14CwbE
	HqXwjrt0V22QVIyvnzkLOtZc/5AMn8PmvMUebkJrQM5olgsG6+x/zfkAe5VkTBuahk61i79kffF
	NmeiQzswj/KQVnHP6u54Z8Yt314eVnu8RCdt9SH3CLmIZXm3QmQvDjzY4fHGsKQ9bJyL86O/pPl
	YF6ohljJdrpR3woauGl8oEeppbpqOPwTuP0V3PmeBVyKo6SwlM7ylyl5sYHD77K4bf25VfLbW3a
	DljL9owxLiC70Lh7njF5VYMDIYAuMSfGP725E/LMqsRE3oBJQvMUnxRAcwPpjSE1KE0BE1s0+sY
	fjxZsG6lZEJEPXg1liHpnFB1WKB5W7MJI80ler8Co=
X-Google-Smtp-Source: AGHT+IGOHUTKi0otXLZWZO3UtF87Lmbiwrz+oxQ9CxZzdYea045bCS6cyr2JFlyOfDjazcyhJ+6i0Q==
X-Received: by 2002:a05:6a21:999f:b0:342:77fa:4aa0 with SMTP id adf61e73a8af0-348cc8e41b3mr12903852637.31.1762081079412;
        Sun, 02 Nov 2025 02:57:59 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:57:59 -0800 (PST)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v4 1/2] PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
Date: Sun,  2 Nov 2025 10:57:05 +0000
Message-ID: <20251102105706.7259-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After misc_deregister and restoring PCI bus ops, there can be no further
users accessing the einjected list. The list items are therefore safely
freed without taking the lock.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..d0cabfc04d48 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -523,7 +523,6 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
 	misc_deregister(&aer_inject_device);
@@ -533,12 +532,10 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0


