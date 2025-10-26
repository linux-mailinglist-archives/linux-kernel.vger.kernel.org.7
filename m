Return-Path: <linux-kernel+bounces-870199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B6C0A29A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B06934ACD5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF724C68B;
	Sun, 26 Oct 2025 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ53fAxG"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3E22FE0A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453849; cv=none; b=lkU+ixJjKbP/AS53ac3/uDKCGRqTHoktZqRQy0kyTvPXab4dd1kZ2O2PqQq//Sc0U7x32AF6/shnP5SaS7T2T1v1yU+filFiGpT0d2jlh5FoIvAnYKgylEuEY2tE+1ROL4ptFxl3YKWvmSbyJswzpXaTguYVben3GxmoRM2yC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453849; c=relaxed/simple;
	bh=sAHI5iIZM5NABgTl/sQiPfhdR+xFRe//xBPBZe5FW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO31ZwfsGRU76Qvcr0GMZ0kcRgh3arOnRDJ0cXLlVQkNISqbIVZEoP7bdiWWI4nESsATcbiocvxU+q6uqT9z/6q/oHAeM/9JYlZUfzr1PgvVFz4rOHpVVkGt+61HoqSGD/O9MeBOmxfMtGOvrp+RP8WmU/WhsBtN/9BiEMP6EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ53fAxG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b556284db11so2913359a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453847; x=1762058647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk1/Yc6Z7SPwqUmBl+xKHBmZ07J03/Mj+lkIe6IoAeo=;
        b=CJ53fAxGg3cCsgFYtnnxWHIy4D2wgBb8mcunh16Cv7IXJ88mMamdCC9m02eP9Va4e5
         vR0Yo5aSPzcOEMgAN+NWRzyf57NzwBGIicGtXDaBZAinvf6is4kNa6RFQsHiAwdRji8f
         68fuIj6ZmyUFZjsIwsETT98b580LRZ82D2bFswJd94ZjCQAVM1MdSf02uNd+Z2gXRmnS
         G3GhG0GTwkTnkNXgjGqYMG5tKySBdl8dKg+kPA9Ifua9g7pmYGJ6Om3TqCuH82noAPKb
         iElDqpGaFR5HrYPvY7tF70avJSEkUuZdnDcgoArn9NclDzgU8u48herM6M7ZYmzIvx5G
         mfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453847; x=1762058647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk1/Yc6Z7SPwqUmBl+xKHBmZ07J03/Mj+lkIe6IoAeo=;
        b=kqx9Z1GRlgNuoVgzaZbC0H0HJfogP4+i6qtw8Gk5hKTaaSinr87qKZnY+LOby4oe7a
         BeLYpEZ0BM7Dw+KVhOU0J3cioCpn3DkP/Cbcwdu4b/7jUV9b37EnIOmVtRbq5fUPq/Kq
         xaBUR65DDCYt6p6j3EnW2XOQjySUmMzNzKdKZyMDe1riy6aJ8YnPrB6TW64soaoRK2NI
         Q1LGuQNhLSfRHNs/daKjwYqiVeHOWMZUPrV8wIbKjpy2XG/IYegfmVMtZ1Kc170j3SCj
         SOzHzR7R6prhTyRtxg7YAQK6erUM8aTqJsRHKcQ2VEfsVbM0QgB1+Zh1alIP8/ehR+Tn
         q5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCViqkFFbbePynHdF4t1o7Pgr+pakrXMXUPbldCbNJhEpxJwYtJdw23U3DYFBN3Tn8pC1c4kXBtzpya3+Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdj9W3DZj86PRb1LEGjRl4qISiy7653PkDMLGUR3gv68iN/i+
	xbcRMw+RcQ6d8SsLFcAt8fspk3pa80c4mLKNModDr3gFsQIY2rx848pI
X-Gm-Gg: ASbGncuvGZeiLs96ruJvr8ZvJp7vy5hF7HQgZF/XUrjwGLOyDu773kIsdSjmCIRgwzr
	JxQhqyrrhrM4G8AVNCUbnZsxLZ5m829ODy2lYaQ5LEOV+Z9MFCWIxkK7rcqyiMwgi4PrR1eJrdH
	dkUjW58o673waCXjG72zlNgPbU2BuIOsKSwVoq1xaeBHLfHZvu6gb18ofRhJ2lYSZ6tbnwDDa7p
	Nc/k4/atxQEnZucEQ1Bpt5kz3683zC1IMFPNHX148wm9Z0oEvhh/764hesACAd1lzyMS3vvA/SN
	/+V7LRk5PULnBDK99faJzYn8Rb1EARI7uV6h28kStkvPWAGqDRvrC4vBrHQ+K5aKJzcY9EkBxjO
	WZEiAQV6We5rkrEKYteSq2l8lFxCEIqVbjKtBHmFJWWKw5eybVNPi5kQP4J4kheiZuLVFMN8dhO
	AaoIZngIEpCeDpvwHRXm09xqeam1tVH89321kaGwvp65yrTLs+Gg==
X-Google-Smtp-Source: AGHT+IHc8dm0fiYDLt8rU8qfupJlNJN9BRtqR20SQ0bZw140gD/aS1oyiyBfrB9MNCNRXcTWNyoazg==
X-Received: by 2002:a17:902:f68c:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-290c9c89ce1mr445488005ad.12.1761453846681;
        Sat, 25 Oct 2025 21:44:06 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:44:06 -0700 (PDT)
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
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to raw_spinlock_t
Date: Sun, 26 Oct 2025 04:43:34 +0000
Message-ID: <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AER injection path may run in forced-threaded interrupt context
under PREEMPT_RT while holding the lock with IRQs disabled.

On RT kernels, spinlocks are converted into rt_spinlocks, which may
sleep. Sleeping is not permitted in IRQ-off sections, so this may
trigger lockdep warnings such as "Invalid wait context" in [1].

  raw_spin_lock_irqsave(&pci_lock);
      ↓
  rt_spin_lock(&inject_lock);  <-- not allowed

Switching inject_lock to raw_spinlock_t preserves non-sleeping locking
semantics and avoids the warning when running with PREEMPT_RT enabled.

The list protected by this lock is bounded and only used for debugging
purposes, so using a raw spinlock will not cause unbounded latencies.

[1] https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..c8d65bfb10ff 100644
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


