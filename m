Return-Path: <linux-kernel+bounces-776378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2FCB2CCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A192B72033C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F01322A3D;
	Tue, 19 Aug 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E8v2S9Rl"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19024A069
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629981; cv=none; b=SIQHL3KN6fHxv40+Cz7lMEKJYVkkAUAeXvarl3h9ohMSVVpgWicZCdYGYp0Z6MYstQaEh5EYZwQUzqEUxB7eStqEnbtdfv4eQo44MH8PyuGdOR0CFApSlMPLlL0BiMGbFsC8xIc4cXefciGxOOY43pykKxiWuTOs7yQE4bn8sUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629981; c=relaxed/simple;
	bh=GuFz78XnzwEhW/V7fBTyTrGnww3kA2QEKMPSAbrajM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIF/2FXtlQeKDwr6W4FytwDOiRXuBGYIsCeL0V9fk/vIyRI7gg/3Np+8v+cSv7q9CVxVub2wF5BpNH4Cv3hmPTf9XQQfRLz58GrzofNS2ilBmF+Tykd2ITDnBmbxYpZrjsK0qE5bx4lZzXlHg+3DSjqtF642pLZNxcc6PwefHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E8v2S9Rl; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id oRXOup0HXu5eaoRXOuIxVH; Tue, 19 Aug 2025 20:58:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1755629907;
	bh=jQMm5lX79hpkXoospWDhgP5wKUoifkftmnOqTB8QKSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E8v2S9RlavQgFVTDluft7ElzXpaJLSdbQmjCyOskKSmu9tuBLwTd1U2mUlBQyH3+K
	 UvdfJ7QHLVHtwAV1byud5TOS7grfbTEUQjqN576OAAb4T/qps24LjFb//q5KUjxwX3
	 LmCxRY6+Z+P30TOWabzRHGYnIlqY4Bu9SuTO2C1OQFd/HyNdOIX7RvowT6251FLmVq
	 wlVDbKouBL2ueXBoG62+8d0hwcG6IkgW8lYduB7bIWGtXZou6p49guUOdHWPgwR5Qf
	 ANYuLkV/8duukmgzl48XBpLThKEZKtz7pWf6uRGg1dCIA18xNMaL5dsEPXp8krZZEp
	 Xp5CUMqPFI2fg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Aug 2025 20:58:27 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] uio: Constify struct pci_device_id
Date: Tue, 19 Aug 2025 20:58:17 +0200
Message-ID: <114791f85f0f81531ca2169721eac4911dbe0865.1755629302.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct pci_device_id' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increases overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4073	   1336	      0	   5409	   1521	drivers/uio/uio_cif.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   4233	   1176	      0	   5409	   1521	drivers/uio/uio_cif.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

checkpatch generates some errors, but checkpatch is wrong. It does not
have enough context to see that the arrays do have a sentinel.
---
 drivers/uio/uio_aec.c     | 2 +-
 drivers/uio/uio_cif.c     | 2 +-
 drivers/uio/uio_netx.c    | 2 +-
 drivers/uio/uio_sercos3.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_aec.c b/drivers/uio/uio_aec.c
index 8c164e51ff9e..dafcc5f44f24 100644
--- a/drivers/uio/uio_aec.c
+++ b/drivers/uio/uio_aec.c
@@ -33,7 +33,7 @@
 
 #define MAILBOX			0x0F
 
-static struct pci_device_id ids[] = {
+static const struct pci_device_id ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AEC, PCI_DEVICE_ID_AEC_VITCLTC), },
 	{ 0, }
 };
diff --git a/drivers/uio/uio_cif.c b/drivers/uio/uio_cif.c
index 1cc3b8b5a345..4e4b589ddef1 100644
--- a/drivers/uio/uio_cif.c
+++ b/drivers/uio/uio_cif.c
@@ -105,7 +105,7 @@ static void hilscher_pci_remove(struct pci_dev *dev)
 	iounmap(info->mem[0].internal_addr);
 }
 
-static struct pci_device_id hilscher_pci_ids[] = {
+static const struct pci_device_id hilscher_pci_ids[] = {
 	{
 		.vendor =	PCI_VENDOR_ID_PLX,
 		.device =	PCI_DEVICE_ID_PLX_9030,
diff --git a/drivers/uio/uio_netx.c b/drivers/uio/uio_netx.c
index a1a58802c793..18917b2ac04c 100644
--- a/drivers/uio/uio_netx.c
+++ b/drivers/uio/uio_netx.c
@@ -127,7 +127,7 @@ static void netx_pci_remove(struct pci_dev *dev)
 	iounmap(info->mem[0].internal_addr);
 }
 
-static struct pci_device_id netx_pci_ids[] = {
+static const struct pci_device_id netx_pci_ids[] = {
 	{
 		.vendor =	PCI_VENDOR_ID_HILSCHER,
 		.device =	PCI_DEVICE_ID_HILSCHER_NETX,
diff --git a/drivers/uio/uio_sercos3.c b/drivers/uio/uio_sercos3.c
index b93a5f8f4cba..12afc2fa1a0b 100644
--- a/drivers/uio/uio_sercos3.c
+++ b/drivers/uio/uio_sercos3.c
@@ -191,7 +191,7 @@ static void sercos3_pci_remove(struct pci_dev *dev)
 	}
 }
 
-static struct pci_device_id sercos3_pci_ids[] = {
+static const struct pci_device_id sercos3_pci_ids[] = {
 	{
 		.vendor =       PCI_VENDOR_ID_PLX,
 		.device =       PCI_DEVICE_ID_PLX_9030,
-- 
2.50.1


