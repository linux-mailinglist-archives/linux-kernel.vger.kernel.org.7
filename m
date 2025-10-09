Return-Path: <linux-kernel+bounces-847031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CFCBC9B33
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21C23E213F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705E2EC0B0;
	Thu,  9 Oct 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LThOjMvF"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68762EC0AA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022429; cv=none; b=WQHSDAEaahrvzH9ok0ipXIBOaDjA1A583uNJ9QGnY+5QKqx7nYJXyY+ubgQzjAWRiWcHuexyGbYVphU+k/DPz/APAiqcNtRhq57+tGkMTmXnvyWib2ZS2TBulzBh4Fi8EH1WvNu6vndlaXEKB/lEspv0PU+Ap4BYs1fqmEHxh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022429; c=relaxed/simple;
	bh=MCV/UPvicPJb69eUQgmnsoFbwCslV+n9NPE5LP4vs4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyO8lynY86qqy3g6bd71ocO134gGVRksaLWtpYY+8+d7QAe4BR7DCfTQUfKUJAtPcHSMjuqqRZrRrECE1VDtNjd8HCYngtqBh7xfAPIB6UnxDljv2gYqDUlGsF81of24y2mm+AB+JWqLeaeWeh8epV1RqIgP0bRGrV7Xan66gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LThOjMvF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1091991b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760022427; x=1760627227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMhg/akYhh9FLVNXWkmixFsJkM0F7NIHl3Wh7qHVX1c=;
        b=LThOjMvF7B93cWo8/qiqTGd7/dWqB+i+Z4vl7Cf3EGr8Y0r6vh0eY2J/r9M5tVqwnx
         HjnYycY+2wSgxoiAAxw/WXntH4Ti4NFExFRDW3/dm9Mjt+mAQGw5knbzC4W1VUGiG4Qh
         6H6RNJUkxs9/YpKp/jeTmarJv2Gn71H2dpQU8cBRQNkrxEqneTNC18399EqASwLXHjBz
         HXHJOpZ+8r9/Xxp1OaEM7Pq86eiv74Qe33iM18S+twyYh/k4CGfqTMM6qdxZsCF2cx/6
         55F7qsBQTJpxp7Kq9QRq0qDDHRAgDpQVlQVfiWydckHJ5bBdB+ZU0IUwp9TOI1XFLx4x
         2RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022427; x=1760627227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMhg/akYhh9FLVNXWkmixFsJkM0F7NIHl3Wh7qHVX1c=;
        b=hG498wrVXDjH0SIK5oCO2rkC0ILd8apcNnSpEV0dBwU3r3Ni4IBifEBb3H5B8dCGg1
         9+6hl0IvYF1lMbnqHfAbboZKh8zWaGxeiWE9HuNS9/nRuUoFaWdszBFMtxkjRu2k9vWN
         2DnOU6b1/K8FKKpQPo7YkcKldrege/Drj1AxOy+tvDMVIey85Y2RL5BIBeQ1GLXbMrR5
         VXgKnfLYYt89AA50M/XK48f5ARDRXXARHVFjRXm2lG0rhr8PkEfDCnA/JtRMpZb2fJk5
         oniClmA0stwycYYCEooNr+TULaasLHAjELVvoyGCEY4Fsb8Wyfcj8N2FKj/qAcKqKDmX
         mlEw==
X-Forwarded-Encrypted: i=1; AJvYcCVBraLe8ZthezYfYs1QZGp5vPR02UbclVK9K+omDfdtmrSHHDDN5mH3x3PshKDnQEgD2NyC7K0UouVj+lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Sv8t97we1cehKHksgHBddk935vwpAJdzsuEI//Ibt8kcItm1
	++ZXGqQi/BAukVjNg8vho/VH5fEMk+PR/Lj1QXhPxU5+lGz4XdhWKOyk
X-Gm-Gg: ASbGncsxw1vrNwim3u9T9aYnrbVwixf1bNtpA5E5V5hMRaHUNfNYJClld/pXTsyOqc1
	hKNprdytWnta8p6msjLZrwLDFY+WG4ezjI+3qg8F3LOUvxsdA8mHRNXJDzcY2ZHBXB1w3e9gERG
	MeBkG3dkppJkjKQ7zyp5OpRMfGu5L4TKcoVUpYKVA32iwdNI9B5t1O1ne0pHJfwicAVtu0o5clj
	MCcZPXX4DRBzgPnLWS6P3DNlzx0Qupd6KcqhefFmGvKwdQ3COEdV8T78YMSuoFMy/LmYQDz/kxE
	Dtm//7j4N1Ndk9Wik/Nc+GazDwjXlSvd0ZUynLIALrgqT98lxhAhL+cJyD0BqPsjTG7mFzwD1Ec
	TBSCF6azHrhWSlJ0LnTXcFagiAZwkDCuAaqBvlrS5YkCI2684u577i2KaocGohXKvooh8cBDMso
	gmbnKNMZv9
X-Google-Smtp-Source: AGHT+IE8AaDi5/+pKe6FXYvrz6gOtwVnUjotnRHBWrfyDNasFLAlpbPt4G5A8FZhItpKwM89IDiRUw==
X-Received: by 2002:a05:6a00:178e:b0:782:ec0f:d271 with SMTP id d2e1a72fcca58-79385ce0c44mr9485358b3a.8.1760022426811;
        Thu, 09 Oct 2025 08:07:06 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33efc46sm3168825b3a.74.2025.10.09.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:07:06 -0700 (PDT)
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
Subject: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
Date: Thu,  9 Oct 2025 15:06:50 +0000
Message-ID: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When injecting AER errors under PREEMPT_RT, the kernel may trigger a
lockdep warning about an invalid wait context:

```
[ 1850.950780] [ BUG: Invalid wait context ]
[ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
[ 1850.951457] -----------------------------
[ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
[ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
[ 1850.952731] other info that might help us debug this:
[ 1850.952997] context-{5:5}
[ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
[ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
[ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
[ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
```

This happens because the AER injection path (`aer_inj_read_config()`)
is called in the context of the PCIe PME interrupt thread, which runs
through `irq_forced_thread_fn()` under PREEMPT_RT. In this context,
`pci_lock` (a raw_spinlock_t) is held with interrupts disabled
(`spin_lock_irqsave()`), and then `aer_inj_read_config()` tries to
acquire `inject_lock`, which is a `rt_spin_lock`. (Thanks Waiman Long)

`rt_spin_lock` may sleep, so acquiring it while holding a raw spinlock
with IRQs disabled violates the lock ordering rules. This leads to
the “Invalid wait context” lockdep warning.

In other words, the lock order looks like this:

```
  raw_spin_lock_irqsave(&pci_lock);
      ↓
  rt_spin_lock(&inject_lock);   <-- not allowed
```

To fix this, convert `inject_lock` from an `rt_spin_lock` to a
`raw_spinlock_t`, a raw spinlock is safe and consistent with the
surrounding locking scheme.

This resolves the lockdep “Invalid wait context” warning observed when
injecting correctable AER errors through `/dev/aer_inject` on PREEMPT_RT.

This was discovered while testing PCIe AER error injection on an arm64
QEMU virtual machine:

```
  qemu-system-aarch64 \
      -nographic \
      -machine virt,highmem=off,gic-version=3 \
      -cpu cortex-a72 \
      -kernel arch/arm64/boot/Image \
      -initrd initramfs.cpio.gz \
      -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc earlyprintk nokaslr" \
      -m 2G \
      -smp 1 \
      -netdev user,id=net0,hostfwd=tcp::2223-:22 \
      -device virtio-net-pci,netdev=net0 \
      -device pcie-root-port,id=rp0,chassis=1,slot=0x0 \
      -device pci-testdev -s -S
```

Injecting a correctable PCIe error via /dev/aer_inject caused a BUG
report with "Invalid wait context" in the irq/PCIe thread.

```
~ # export HEX="00020000000000000100000000000000000000000000000000000000"
~ # echo -n "$HEX" | xxd -r -p | tee /dev/aer_inject >/dev/null
[ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
[ 1850.949951]
[ 1850.950479] =============================
[ 1850.950780] [ BUG: Invalid wait context ]
[ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
[ 1850.951457] -----------------------------
[ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
[ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
[ 1850.952731] other info that might help us debug this:
[ 1850.952997] context-{5:5}
[ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
[ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
[ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
[ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
[ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
[ 1850.955932] stack backtrace:
[ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
[ 1850.957039] Hardware name: linux,dummy-virt (DT)
[ 1850.957409] Call trace:
[ 1850.957727]  show_stack+0x18/0x24 (C)
[ 1850.958089]  dump_stack_lvl+0x40/0xbc
[ 1850.958339]  dump_stack+0x18/0x24
[ 1850.958586]  __lock_acquire+0xa84/0x3008
[ 1850.958907]  lock_acquire+0x128/0x2a8
[ 1850.959171]  rt_spin_lock+0x50/0x1b8
[ 1850.959476]  aer_inj_read_config+0x38/0x1dc
[ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
[ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
[ 1850.960454]  pcie_pme_irq+0x44/0xc4
[ 1850.960728]  irq_forced_thread_fn+0x30/0x94
[ 1850.960984]  irq_thread+0x1ac/0x3a4
[ 1850.961308]  kthread+0x1b4/0x208
[ 1850.961557]  ret_from_fork+0x10/0x20
[ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message received from 0000:00:02.0
[ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/mask=00000001/0000e000
[ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (First)
```

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
Changes in v2:
- Pulling kfree() out from the lock critical section. (Thanks Waiman Long)
- Link to v1: https://lore.kernel.org/linux-pci/20251007060218.57222-1-jckeep.cuiguangbo@gmail.com/

 drivers/pci/pcie/aer_inject.c | 40 ++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 91acc7b17f68..6dd231d9fccd 100644
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
@@ -523,8 +523,8 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
+	LIST_HEAD(einjected_to_free);
 
 	misc_deregister(&aer_inject_device);
 
@@ -533,12 +533,14 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
-	list_for_each_entry_safe(err, err_next, &einjected, list) {
+	scoped_guard(raw_spinlock_irqsave, &inject_lock) {
+		list_splice_init(&einjected, &einjected_to_free);
+	}
+
+	list_for_each_entry_safe(err, err_next, &einjected_to_free, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0


