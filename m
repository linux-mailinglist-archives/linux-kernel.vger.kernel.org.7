Return-Path: <linux-kernel+bounces-881754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05EC28DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E9C3B4C24
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E026E6FE;
	Sun,  2 Nov 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFsnJ36y"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489026CE37
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081089; cv=none; b=ODLQYoGg//s/X48XDYkn5x9Moki6AAdoTVDxnRxt659W7vOTT8sOG3g8PZS5UN92FXDAFCimyi6Z6yMfp5v+17WVcC2enXnpQ08B6LOk85vSUpct+Tf1gDpkuFkHf/hxcnjSu5CYWyA/lYxOsGY8ngcxLNyh8jAbeuhcDR4xnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081089; c=relaxed/simple;
	bh=iU945rxIytYge2u36qpKv+Z6kWAP0ds/jXgSSHdC0x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1rNQkfqFhoTfny5r65Ko7KbPeLNhLpTVZjijzGRMWwvNng+LUZl8HzmZe50Zq55Kex2T6mAoM8B6cjwpEPUvOR9uxm7GZE+hBC+L7c56uIrZImiz3GU9+pfVDk58XamwobNmKhv1M5Lk9yKPznKt3xaUtgjcP728CexHp2gtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFsnJ36y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3453250b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081087; x=1762685887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnvxcwW4nROqi/pUDVHqj/B8lAE5wjrS3W1SNd+wzqE=;
        b=GFsnJ36yJ4RJrMV6Xp3CNxuLHnKM97WPtlQOb5bus+rBtWQI79ZeiWdRP4ZazhnUAn
         XKCT2Rg943XdlgDhHnBakcniBb3VK+0muZphSzTmjP1TcSTeLJb5Vab8Y4JfPBHhS2gk
         EqTN7fUlAxzWIU23nfeRxNmCPx8eza6U8wED0lVqWHOUtsuefg4XJhn61JzEDaxWD6h8
         ZE2WEYDT5jiBb21evvK7H0JJlawNX02mZgeB5rAX9NYfBMtb0Pukz4gaT7ISkxpeZ4ca
         ypkHL5deyu3xjZkzIRb1sqmFqAy0x+rdkCew74ehvTzlVG9EK1kEBXDE+29ambGX85c1
         pATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081087; x=1762685887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnvxcwW4nROqi/pUDVHqj/B8lAE5wjrS3W1SNd+wzqE=;
        b=uox8MmwCUC1z10Nii76wCTX/CW9kJoJ9odGuSBAd1ySHRf0iHjNakOkdx6b8/I9sR/
         YAZcIcZ+qGzoZ8bjLakJYZN8K+uxMpivz+vldUQBBw1/2fcE4/V2NfbC3kpXI/1vY3Iu
         DjJ50QJfv+OQ/K3wm29JpAdHdCzzdOpXzbLlYYXt2r1m5aLfpRKWHY+iI/13WNveZ8M+
         +9x97yPdM+YJCVA8kkeg9xaCG4h5XV2e8FG+Ffx1OM9/6/D4EfaPy4i/nH/Wd3Pe8pJY
         ZqjOuapL7lEMnf5Plx74/1qg+dKkx89WMVB2sM5jj097+4qfDrNJ7eHnaQZ7hQFF4HbU
         leJg==
X-Forwarded-Encrypted: i=1; AJvYcCX7wAiMulqu+k9efRUwML7gFBalUpIjUuJRn8FK0BWhrpEw80Hmww5gY2OGnT+ICCShJUxLoH4i1PjO/j8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Y6odY/JPtnUWIOG0R5WBqS1N7/5ur6PDH8l77YjPEfFfHMVa
	z/Kvu0qBayQI/7erLzIIXB8cfXoEltWca6SXZt8HYFqgm1+SRA0x1L1j
X-Gm-Gg: ASbGncvtq9t3/1Vi49hT7t1nShBFSNI6VNYrfOeU3XWx3B0IPUtd+9mmC6GJSxZ+NMP
	+JhliG5zqW3OBsY6+HL1ZJ/ilV8vRc4Fo9tKT73c5sgGxfMX3vunTw3K/bG95QafMs/VzheRQe2
	owLp4PR7xp+NHR+VN1H1UEhY9kHUJNc8Pq9U+XRWk6ql9YfQDLX5tOIuJ4Dahw6OauuMudV/3WZ
	t690A4MR6EsT6YSnvTiqRK11BVJvXfQz53oJZfjccbihY8me1PUQTI99Npv9hYMXOK6qMl3lGFx
	8vnz9RjYQj9oN9rlksH0AvOYEmZgXozK5D4QAzEsAUHZmtzHLDnwXDzQ96KlkyPH8KJ+HBE6TXZ
	AM91Z7TiSMllgYt4NkWr2G35XoysFBWCz/HKL/D1AODcSBKwP2LzsaOm5JXoO3gAuKMpvIxPBtX
	KFau2HcwpNPu5echF5by6ptCCccJ3C9l3g3QRvkUvHjtj0sfrYCw==
X-Google-Smtp-Source: AGHT+IFw7LQmxvnT7Z6/GWYHHWlCaXIwYo97IH5BaRo8+IRI9C+4EfgykCBDqZa3hOGXe79E1lknOQ==
X-Received: by 2002:a05:6a21:99a1:b0:340:a205:681a with SMTP id adf61e73a8af0-348ca75c051mr11435936637.4.1762081087211;
        Sun, 02 Nov 2025 02:58:07 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:58:06 -0800 (PST)
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
Subject: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
Date: Sun,  2 Nov 2025 10:57:06 +0000
Message-ID: <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AER injection path may run in interrupt-disabled context while
holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
sleeping lock, so it must not be taken while a raw_spinlock_t is held.
Doing so violates lock ordering rules and trigger lockdep reports
such as “Invalid wait context”.

Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
semantics. The protected list is bounded and used only for debugging,
so raw locking will not cause latency issues.

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index d0cabfc04d48..a064fa2acb94 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -72,7 +72,7 @@ static LIST_HEAD(einjected);
 static LIST_HEAD(pci_bus_ops_list);
 
 /* Protect einjected and pci_bus_ops_list */
-static DEFINE_SPINLOCK(inject_lock);
+static DEFINE_RAW_SPINLOCK(inject_lock);
 
 static void aer_error_init(struct aer_error *err, u32 domain,
 			   unsigned int bus, unsigned int devfn,
@@ -126,12 +126,12 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
 					   struct pci_bus_ops, list);
 	if (bus_ops)
 		list_del(&bus_ops->list);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return bus_ops;
 }
 
@@ -223,7 +223,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -236,12 +236,12 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	sim = find_pci_config_dword(err, where, NULL);
 	if (sim) {
 		*val = *sim;
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_read(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -255,7 +255,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 	int domain;
 	int rv;
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
 		goto out;
 	domain = pci_domain_nr(bus);
@@ -271,12 +271,12 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 			*sim ^= val;
 		else
 			*sim = val;
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
 	rv = aer_inj_write(bus, devfn, where, size, val);
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
 
@@ -304,14 +304,14 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	if (!bus_ops)
 		return -ENOMEM;
 	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 	if (ops == &aer_inj_pci_ops)
 		goto out;
 	pci_bus_ops_init(bus_ops, bus, ops);
 	list_add(&bus_ops->list, &pci_bus_ops_list);
 	bus_ops = NULL;
 out:
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 	kfree(bus_ops);
 	return 0;
 }
@@ -383,7 +383,7 @@ static int aer_inject(struct aer_error_inj *einj)
 				       uncor_mask);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
+	raw_spin_lock_irqsave(&inject_lock, flags);
 
 	err = __find_aer_error_by_dev(dev);
 	if (!err) {
@@ -404,14 +404,14 @@ static int aer_inject(struct aer_error_inj *einj)
 	    !(einj->cor_status & ~cor_mask)) {
 		ret = -EINVAL;
 		pci_warn(dev, "The correctable error(s) is masked by device\n");
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 	if (!aer_mask_override && einj->uncor_status &&
 	    !(einj->uncor_status & ~uncor_mask)) {
 		ret = -EINVAL;
 		pci_warn(dev, "The uncorrectable error(s) is masked by device\n");
-		spin_unlock_irqrestore(&inject_lock, flags);
+		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 
@@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		rperr->source_id &= 0x0000ffff;
 		rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
+	raw_spin_unlock_irqrestore(&inject_lock, flags);
 
 	if (aer_mask_override) {
 		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
-- 
2.43.0


