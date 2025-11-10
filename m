Return-Path: <linux-kernel+bounces-892956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607ADC46342
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7763BAAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE0309DC0;
	Mon, 10 Nov 2025 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OXq52Cb7"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0D306B11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773535; cv=none; b=vGjEQ2nqRgEVKJb+snmUwgaUn1E2YssBC3FJFRRQXeOMaAdAmslGppeLF2nwo0UVG5MM6jnh3xkSLu4WEPs+ym2YbjGqOibuGTfrl5WMwmXhrNihDWwviskxjrdBr9NFYWcJcCdu3JoFy19oVqGaiLePds0/sgUsZVLeaket8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773535; c=relaxed/simple;
	bh=CtcnWX3Saefaqoy8rC2bEN8d8RUkMd9EngZJbMCIyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYePhIesUjbnXree2jAVIdZQZPzKB8RVbbwcqKlu6wdA7F3wpKzh4RQrUttbIbIX3dBY9D0OvxVMkm0S6OwK3l9hU+gyRkDTPfsSyDGp+jGekZaXntydeFYsBYXGC5BHKfvr+y2QQi+UMCwhPzVqm6Z+/qNK0NAAbaPnhKJmK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OXq52Cb7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso5008136a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762773532; x=1763378332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWujc1t71h98OiupS/0FkoKIpGifqdnl63DSESHd7Mo=;
        b=OXq52Cb7SWnSIzwdEYTgNtqfRqxu97eff2EFTTPGm8+hM2bN8cy3tn+3nUa4Box/Bq
         nJLUQcXknP7RQN1rBoDAlnHGIe8N4PJVpecddcivug/2wLxBK0gPdEfkXr9a7/RfHmvR
         2+dSTbmPEIgpAaM34ZWnAdNmvhWV7XDVV0IHQ3fsJX/Nagel7DU8qoPoL4jCgP6/esCw
         eQc1rHCbW5ahjIyAP1eEMLMbGNyMCzA9n8ED+yEmbtRGNWH8Z4uyMvpOMt/GYNBScSCU
         Ds0RYcu0BlqzvYVBph3amLc/uUdWT6QoAFWWamlplwgzh+RfOX122UmDX8HpMfDHH3YU
         4STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773532; x=1763378332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWujc1t71h98OiupS/0FkoKIpGifqdnl63DSESHd7Mo=;
        b=Ny4gBd0kOa37Hyi6VYNJsyFRT8UMfU9vg0GmaukkHqMVkqlX2TjT/IR8QNeMT6/g4G
         Vn/SrDe3nD7QDR2LYYaH13GRVzQieLBjKyZ1ZqF7GR8D+gM8cD2eW6iSR3SOuXnEhZ0j
         1aU+MIxOzJKcRy8I1dSmqV68SHRJZU6LC8QHWMyKTjLdGlSdJic7GvfQAdsIrts5lwnr
         bhGaZDe8IQtVseg3c9xhHXQ4JLo05fMztDvK4K0Zh4HvycFDX8ZqfdvmGVuF+xXAUa9R
         V2+zUw2cHkgzfLXENDp9rtgdqneY5xpRybUmx8DmXP3AhBgD2qArBO8P6cIrI/83zVUD
         QYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGZUf8g878QMBHD2GmancNy17GPlhpbFl8ktDgJVLiDOC6CgbD4na2mO7kfWedSTYRWgq9c3wL2EhiiAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQuSFlTCpLV+DLD/c3PEs9z9nQyYK/aX5CIDfBqRn6xFwENHZ
	1lFcRK1sntyIqqHsrMX4myOOl6dXYB835YX5buLpyt8GmHeywa7ZS+uJRrW/1d+c7JZwfPukdfv
	7m+2D
X-Gm-Gg: ASbGncuRIDRlpst5lst2XpbyexQWQNWCQ07cTn8iSZT31PMRDTsh8BETKxUZ5rhzi2A
	acBlI1WjqFBmkq48X5B5pelD6QnAglzR1sB21+KAgBMDAQjRJs6wTXNTG1s1ee3K/3GfBFUGFN0
	ld2dOIhd2qMjk9rnJoUAGMj9VTtT2Iy/dUSezlaUvp0Pj/Ky1yGBjbLW7k+8QT3ky6RpmWHTwEj
	EgiXFmj3a90l2Yuo8gx9VoA0PZBEGgIObYjDWMDHy9Si9wCv6UMzSIdWlvOKh259Xhsy4JZcS54
	PpmFCt9hfakohkQ8F1X6BdXWWL6L9DUX/qUqa9m1AHOUCJJ+7bkOuloI8ZU9v1dny2ml5LULOAT
	hIwgNysYJnQZ+Z+HGmau8GVlLF68RoM56ilt088QIQsEsvIyWxC1aaI3yZ+PKYYyYwyPgntysgZ
	k76E4ONHBQ9FKuC4UbILjhw1p56pxJm5ONslQqv+7JOonw4Q==
X-Google-Smtp-Source: AGHT+IGKZ4MeSZHa1um6peBrNmfVOTXndNtZud9k37T7qMj8M9oQCOFbXIJKx4r88XPM9ZK0mYZCng==
X-Received: by 2002:a05:6402:440a:b0:640:bb31:cbf4 with SMTP id 4fb4d7f45d1cf-6415dc0dcc6mr6197325a12.11.1762773532050;
        Mon, 10 Nov 2025 03:18:52 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86ea13sm11070391a12.37.2025.11.10.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:18:51 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mbrugger@suse.com,
	guillaume.gardet@arm.com,
	tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v4] PCI: of: Drop error message on missing of_root node
Date: Mon, 10 Nov 2025 12:21:10 +0100
Message-ID: <20251110112110.10620-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
is generated if no 'of_root' node is defined.

On DT-based systems, this cannot happen as a root DT node is
always present.
On ACPI-based systems that declare an empty root DT node (e.g.
x86 with CONFIG_OF_EARLY_FLATTREE=y), this also won't happen.
On platforms where ACPI is mutually exclusive to DT (e.g. ARM)
the error will be caught (and possibly shown) by drivers that
rely on the root node.

Drop the error message altogether.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
CHANGES in V4:
- dropped {} from the single line conditional body

V3: https://lore.kernel.org/all/20251110105415.9584-1-andrea.porta@suse.com/
---
 drivers/pci/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..c222944eec40 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -774,10 +774,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	}
 
 	/* Check if there is a DT root node to attach the created node */
-	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+	if (!of_root)
 		return;
-	}
 
 	name = kasprintf(GFP_KERNEL, "pci@%x,%x", pci_domain_nr(bridge->bus),
 			 bridge->bus->number);
-- 
2.35.3


