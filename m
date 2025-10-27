Return-Path: <linux-kernel+bounces-870889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA06C0BE97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 722AF349D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62592DAFDD;
	Mon, 27 Oct 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pyq5YfFg"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EA239E7E;
	Mon, 27 Oct 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545419; cv=none; b=lHtSu/vOymmiEGD+SRmfahlLueeL1BzbtM83pX46T1zxoLIK+KzypjQnc2tEfUxeQvLSCYugW2BIyEAlrIfHPuHIr+mT99FYNLxBkNk2Jnbo/kdN9f7U0EqgIXHNn8TD0gW8oOlBA2QwqlLSJqXY7ac4L4FIOn523BLHpTDbK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545419; c=relaxed/simple;
	bh=rHuO+Fxffm66hBQpmDr6t5dg+JKPrEOXGwNo09f9Lzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hP/PvnniM8BPupzgT2JZY4psqn90jA0Ir32b9bGXn888NS/fwTO2XHc6tkXTpHswcqQYeRpyMZHoOEEQdefOjv1ing5mJr46QvzoR0jLsgnEdV+WimI4vnKbxiLoxlQpvV9zy/Ye0bnAl1hqqhlkfJwvAoVCUuCHcQpG4aiCSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pyq5YfFg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=c7
	X0msjc4cFLO9bbVjs4sHapCnnVSyPJnGSjo/CEPxI=; b=pyq5YfFgIETb87AY9K
	318aB90ElsfH2eClCbtZ+JiBt2q4QV2/Y+ivtwuPe2DSxjlNX8WWIba6haKCVPhi
	nMdCvqHaI0raGVDFqSYjifKm75Egkd3Pzt6MTC+eqeus4k2p/x+blXJYmYrln1M5
	zyzs8SlQk1IdRYtItPnuuGg6o=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3H4+bDP9o0wJZBg--.32785S2;
	Mon, 27 Oct 2025 14:09:32 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Date: Mon, 27 Oct 2025 14:09:29 +0800
Message-Id: <20251027060929.394053-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H4+bDP9o0wJZBg--.32785S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1UWw4fKrW5CFWfuF4rZrb_yoWDGFWfpF
	s0yry2qay5JanF9r1DGF4xAayY93Z29a4xCrWUG34Yqr1DAry8u3Wqgryjvr95Grs7Crya
	yF4xta4DCF12vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziv38UUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRw-zCmj-C1MoiAAAse

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push interface in the TTY
layer uses system_unbound_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, it may be preeempted by real-time
tasks or other high-prio tasks.
In flush_to_ldisc, when executing n_tty_receive_buf_common, it wakes up
other tasks. __wake_up_common_lock calls spin_lock_irqsave, which does
not disable preemption but disable migration in RT-Linux. This prevents
the kworker thread from being migrated to other cores by CPU's balancing
logic, resulting in long delays.
In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.
Introduce tty_flip_wq in tty_port, allocating a workqueue using WQ_SYSFS,
so that we can set cpumask and nice dynamically.
We set the cpumask to the same cpu where the IMU data is handled and has
less long-time high-prio jobs, and then set nice to -20, the frame
processing interval remains between 10 and 15ms, no jitter occurs.

---
Change in v3:
- Add tty flip workqueue for all tty ports, as suggested by Greg KH.
  Every tty port use an individual flip workqueue, while all pty ports
  share the same workqueue created in pty_flip_wq_init.
- Modify the commit log to describe the reason for latency spikes in
  RT-Linux.

Change in v2:
- Do not add new module parameters
  as suggested by Greg KH
- Set WQ_SYSFS to allow properties changes from userspace
  as suggested by Tejun Heo
- Link to v2: https://lore.kernel.org/all/20251024155534.2302590-1-jackzxcui1989@163.com

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 drivers/tty/pty.c          |  6 ++++
 drivers/tty/tty_buffer.c   |  9 +++---
 drivers/tty/tty_io.c       |  2 +-
 drivers/tty/tty_port.c     | 58 ++++++++++++++++++++++++++++++++++++++
 include/linux/tty.h        |  1 +
 include/linux/tty_buffer.h |  1 +
 include/linux/tty_port.h   |  3 ++
 7 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8bb1a01fe..93779bc09 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -412,6 +412,8 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 	o_tty->port = ports[0];
 	tty->port = ports[1];
 	o_tty->port->itty = o_tty;
+	tty_flip_wq_init(ports[0], driver->other, idx);
+	tty_flip_wq_init(ports[1], driver->other, idx);
 
 	tty_buffer_set_lock_subclass(o_tty->port);
 
@@ -547,6 +549,8 @@ static void __init legacy_pty_init(void)
 	if (IS_ERR(pty_slave_driver))
 		panic("Couldn't allocate pty slave driver");
 
+	pty_flip_wq_init();
+
 	pty_driver->driver_name = "pty_master";
 	pty_driver->name = "pty";
 	pty_driver->major = PTY_MASTER_MAJOR;
@@ -889,6 +893,8 @@ static void __init unix98_pty_init(void)
 	if (IS_ERR(pts_driver))
 		panic("Couldn't allocate Unix98 pts driver");
 
+	pty_flip_wq_init();
+
 	ptm_driver->driver_name = "pty_master";
 	ptm_driver->name = "ptm";
 	ptm_driver->major = UNIX98_PTY_MASTER_MAJOR;
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b..54d61792f 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	mutex_unlock(&buf->lock);
 
 	if (restart)
-		queue_work(system_unbound_wq, &buf->work);
+		queue_work(buf->tty_flip_wq, &buf->work);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(buf->tty_flip_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -560,7 +560,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 		tty_flip_buffer_commit(buf->tail);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(buf->tty_flip_wq, &buf->work);
 
 	return size;
 }
@@ -583,6 +583,7 @@ void tty_buffer_init(struct tty_port *port)
 	init_llist_head(&buf->free);
 	atomic_set(&buf->mem_used, 0);
 	atomic_set(&buf->priority, 0);
+	buf->tty_flip_wq = system_unbound_wq;
 	INIT_WORK(&buf->work, flush_to_ldisc);
 	buf->mem_limit = TTYB_DEFAULT_MEM_LIMIT;
 }
@@ -613,7 +614,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_unbound_wq, &port->buf.work);
+	return queue_work(port->buf.tty_flip_wq, &port->buf.work);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70..95bd6ae19 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1191,7 +1191,7 @@ static void pty_line_name(struct tty_driver *driver, int index, char *p)
  *
  * Locking: None
  */
-static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
+ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 {
 	if (driver->flags & TTY_DRIVER_UNNUMBERED_NODE)
 		return sprintf(p, "%s", driver->name);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 5b4d5fb99..7eb9f31d1 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -103,6 +103,62 @@ void tty_port_init(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_port_init);
 
+static struct workqueue_struct *pty_flip_wq;
+
+/**
+ * pty_flip_wq_init -- initialize workqueue for pty flip buffer work
+ *
+ * Initialzes workqueue for pty ports, they share the same workqueue which
+ * should be created when pty driver init.
+ * Pty ports are numerous and hard to distinguish, it is meaningless to
+ * separate them when create tty flip workqueue.
+ */
+void pty_flip_wq_init(void)
+{
+	if (!pty_flip_wq) {
+		pty_flip_wq = alloc_workqueue("pty-flip-wq", WQ_UNBOUND | WQ_SYSFS, 0);
+		if (!pty_flip_wq)
+			pty_flip_wq = system_unbound_wq;
+	}
+}
+
+/**
+ * tty_flip_wq_init -- prepare workqueue for tty/pty flip buffer work
+ * @port: tty_port of the device
+ * @driver: tty_driver for this device
+ * @index: index of the tty
+ *
+ * Not all tty_port will be initialized by tty_port_init where tty_flip_wq will
+ * be set to system_unbound_wq as default. Allocate workqueue with WQ_SYSFS for
+ * flip buffer, so that cpumask and nice can be changed dynamically.
+ */
+void tty_flip_wq_init(struct tty_port *port, struct tty_driver *driver,
+		      unsigned int index)
+{
+	char name[64];
+
+	if (driver->type == TTY_DRIVER_TYPE_PTY) {
+		port->buf.tty_flip_wq = pty_flip_wq;
+		return;
+	}
+	tty_line_name(driver, index, name);
+	if (!port->buf.tty_flip_wq
+		|| port->buf.tty_flip_wq == system_unbound_wq) {
+		port->buf.tty_flip_wq = alloc_workqueue("%s-flip-wq",
+							WQ_UNBOUND | WQ_SYSFS,
+							0, name);
+		if (unlikely(!port->buf.tty_flip_wq))
+			port->buf.tty_flip_wq = system_unbound_wq;
+	}
+}
+
+static void tty_flip_wq_destroy(struct tty_port *port)
+{
+	if (port->buf.tty_flip_wq != system_unbound_wq
+		&& port->buf.tty_flip_wq != pty_flip_wq)
+		destroy_workqueue(port->buf.tty_flip_wq);
+}
+
 /**
  * tty_port_link_device - link tty and tty_port
  * @port: tty_port of the device
@@ -119,6 +175,7 @@ void tty_port_link_device(struct tty_port *port,
 {
 	if (WARN_ON(index >= driver->num))
 		return;
+	tty_flip_wq_init(port, driver, index);
 	driver->ports[index] = port;
 }
 EXPORT_SYMBOL_GPL(tty_port_link_device);
@@ -259,6 +316,7 @@ EXPORT_SYMBOL(tty_port_free_xmit_buf);
 void tty_port_destroy(struct tty_port *port)
 {
 	tty_buffer_cancel_work(port);
+	tty_flip_wq_destroy(port);
 	tty_buffer_free_all(port);
 }
 EXPORT_SYMBOL(tty_port_destroy);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0a46e4054..c4d535912 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -399,6 +399,7 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 	return tty;
 }
 
+ssize_t tty_line_name(struct tty_driver *driver, int index, char *p);
 const char *tty_driver_name(const struct tty_struct *tty);
 void tty_wait_until_sent(struct tty_struct *tty, long timeout);
 void stop_tty(struct tty_struct *tty);
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be..e9928fa36 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -34,6 +34,7 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 
 struct tty_bufhead {
 	struct tty_buffer *head;	/* Queue head */
+	struct workqueue_struct *tty_flip_wq;
 	struct work_struct work;
 	struct mutex	   lock;
 	atomic_t	   priority;
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 332ddb936..31c149640 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -138,6 +138,9 @@ struct tty_port {
 					   kernel */
 
 void tty_port_init(struct tty_port *port);
+void pty_flip_wq_init(void);
+void tty_flip_wq_init(struct tty_port *port, struct tty_driver *driver,
+		      unsigned int index);
 void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
 		unsigned index);
 struct device *tty_port_register_device(struct tty_port *port,
-- 
2.34.1


