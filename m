Return-Path: <linux-kernel+bounces-720678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F693AFBF27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F87D4A2CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6912E7E;
	Tue,  8 Jul 2025 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdIbl8jH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0E3C01
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933693; cv=none; b=G8jgAso6XFFKLkmbGC41wZyfuqFaREn1OW8ilGgKqoiEgYC4CLomYzLJ7VVeO4Z5ZNwCyj/6YF5+HvSoSBzlPfXLygwa0EqOvNUBc1t2KIXdLS8obdvOPSCk6GshxmyQO386zs4c5D2720SUin/+K3CEP/NxnWYiTqKoBe18WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933693; c=relaxed/simple;
	bh=dmlr9QU9PejKKi6yw4+ngRoaBiSbg3gp5UFCg3+6BGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0sdFNcst8Wn5rqsvSuC1DK96flQGLIt2jg0a937qAlE4aeDKPR1si9iK72GZSlw/CVb5V6dX6cJD1hwvQNJrNSjwjo1IUFx3GVSPTS6dfgpOiS/eS3hdqU4EexSP0Daoe7P+klT8n6pBA8CuT7LEwUroD5F5ZLhQk/gfZ7ADTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdIbl8jH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2350b1b9129so25196675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751933691; x=1752538491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZetFX6wW4YDbBAC0JxzbJ3+PwShQwl335DiD7tIdsd4=;
        b=HdIbl8jHRtHo6WV8GbQk/crxLRaBNt+Y2aTxqLV8281mdZOWeNsYtlBwx3+KV1dFtZ
         VvTJwNrFm0Kv4SqZXz1eU9QxwU9uMf91Pi3GHd3FGDJxVcPRtQ3A4CjS688qdF5SilSS
         3wNGIzTJwE+STpM46hT8pKwJtJtjzKWhmWM5bALNa18BbvsrhuW4ox1vuDTIq5kYkBln
         946KtxsXPq1eBKxMYew6bVVVdCXfttDnwbZ49X+nm9DPlp5ZMVZF4kBttm3fSy8gd9cH
         SGIoah57aOVBhVGlXpm6YcROOTFYPhZjs9X2D0BRpA1cEalFVPez68uWH6kqq/eCqwgh
         yTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933691; x=1752538491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZetFX6wW4YDbBAC0JxzbJ3+PwShQwl335DiD7tIdsd4=;
        b=uKtFxZu3nlLousVDf19NUT+wTOMQX6DckAoiadgIWtDKdvzNouvD9AH7wi0RycgYvG
         Vgnt3RZ9ecw8feLDkTcLf7R+KZX/07Axx6mOqfBVDtu2XBg2XaCDyoa0rdzXtmwxxTZr
         W4ya5TQnjHxwqUbTlBofgbWjt+iIVVqOKH6rDtEDFRLH/QdSRtSuMsyEPpiMn/crq3To
         PR+gU9PIiaYaEHXtlqrGg1n4+6E8kfRqgpoDZBdqgkC+mG4eEAbM2lBrk/MXKYAhi0UI
         2pEZITZPm3VMerj7RWRhZn0ErN5+Nzj4drbeM97Ynbde7zfzzoFyzKXfrd965zqLmqaX
         46nA==
X-Gm-Message-State: AOJu0YyaPeJBFaHcazi0NTLGorF+DR/Ciq9aqfNYZKpOp+K3hJm8+EnI
	V9C/WyRd234otOdiRg/1y+x/s6GvgQDta7g7GY1OQZZwd/GeUw2Ro6fXx9R8rzFJeeo=
X-Gm-Gg: ASbGnculguWJfB7DtMu35Ac48JvasIa7YgZgOBmLo8AteszTqfd/5nVbEpwullfVnqh
	hLJvGy8+09v2L4TKBzWnaz0WcfI93XqfCcFR3UtXtjoce3vrf0mn41V9TcvMCztza+VVKsqboaw
	n3tEuc9Dcqcrl0VHQXYoZssc7ssXeyW2Sh65lGpwhz348JA0A/eNBzhwAHL6NPFPLaM7bUmn+u7
	6CI2jrn8A0yRaS8tuXNCekFj4hV5n7tiKG2QTqjYCF4knC7R+hnMejnq1IoToS6rs/1vL1f8ndM
	asI3bZSwSK/EJR2kBqhBl5xLRJ7kDPSiElGU9dlhcd/400m1Mc/u234vHs69hD94NfALM50S16e
	zsz3cjoVp
X-Google-Smtp-Source: AGHT+IG8TGYBMB1axi5fHGbVJ42BJ87cjqsFjSk1o0khIde1Z/ZybxhjiWb4KmGSQ8SCNbMNkpEj1g==
X-Received: by 2002:a17:903:2784:b0:234:986c:66e0 with SMTP id d9443c01a7336-23c85d8f78dmr180752565ad.4.1751933691057;
        Mon, 07 Jul 2025 17:14:51 -0700 (PDT)
Received: from localhost.localdomain ([115.137.3.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c22055c73sm481201a91.1.2025.07.07.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:14:50 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH v3] xen-pciback: Replace scnprintf() with sysfs_emit_at()
Date: Tue,  8 Jul 2025 09:14:40 +0900
Message-ID: <20250708001444.86155-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624070443.11740-1-seokwoo.chung130@gmail.com>
References: <20250624070443.11740-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the third revision (v3) of this patch series.
No changes since v2—only adding Reviewed-by lines.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 5c2f829d5b0b..045e74847fe6 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1261,7 +1261,7 @@ static ssize_t slots_show(struct device_driver *drv, char *buf)
 		if (count >= PAGE_SIZE)
 			break;
 
-		count += scnprintf(buf + count, PAGE_SIZE - count,
+		count += sysfs_emit_at(buf, count,
 				   "%04x:%02x:%02x.%d\n",
 				   pci_dev_id->domain, pci_dev_id->bus,
 				   PCI_SLOT(pci_dev_id->devfn),
@@ -1290,7 +1290,7 @@ static ssize_t irq_handlers_show(struct device_driver *drv, char *buf)
 		if (!dev_data)
 			continue;
 		count +=
-		    scnprintf(buf + count, PAGE_SIZE - count,
+		    sysfs_emit_at(buf, count,
 			      "%s:%s:%sing:%ld\n",
 			      pci_name(psdev->dev),
 			      dev_data->isr_on ? "on" : "off",
@@ -1375,7 +1375,7 @@ static ssize_t quirks_show(struct device_driver *drv, char *buf)
 		if (count >= PAGE_SIZE)
 			goto out;
 
-		count += scnprintf(buf + count, PAGE_SIZE - count,
+		count += sysfs_emit_at(buf, count,
 				   "%02x:%02x.%01x\n\t%04x:%04x:%04x:%04x\n",
 				   quirk->pdev->bus->number,
 				   PCI_SLOT(quirk->pdev->devfn),
@@ -1391,7 +1391,7 @@ static ssize_t quirks_show(struct device_driver *drv, char *buf)
 			if (count >= PAGE_SIZE)
 				goto out;
 
-			count += scnprintf(buf + count, PAGE_SIZE - count,
+			count += sysfs_emit_at(buf, count,
 					   "\t\t%08x:%01x:%08x\n",
 					   cfg_entry->base_offset +
 					   field->offset, field->size,
@@ -1462,7 +1462,7 @@ static ssize_t permissive_show(struct device_driver *drv, char *buf)
 		if (!dev_data || !dev_data->permissive)
 			continue;
 		count +=
-		    scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+		    sysfs_emit_at(buf, count, "%s\n",
 			      pci_name(psdev->dev));
 	}
 	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
@@ -1521,7 +1521,7 @@ static ssize_t allow_interrupt_control_show(struct device_driver *drv,
 		if (!dev_data || !dev_data->allow_interrupt_control)
 			continue;
 		count +=
-		    scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+		    sysfs_emit_at(buf, count, "%s\n",
 			      pci_name(psdev->dev));
 	}
 	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
-- 
2.43.0


