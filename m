Return-Path: <linux-kernel+bounces-887119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6DC374FF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E75CE4E3A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723A27EFE3;
	Wed,  5 Nov 2025 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZStljLmF"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7212CDA5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367487; cv=none; b=CU6leBI1t0Q9m4GqD67BKAgZCOpix0QijOSfIey4h4N9icEZLJFlM2P1krqLdTl3fBjPTJSG2XX/G4/EjeMfSWd/1SpZhITLQJ0nbVZaltRh4T7Ds/ji4oQF6e4O/9lbWm4YZqTlUzn64Ctu7GQQ7XsfyP8S7IM6eKWGeiqG2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367487; c=relaxed/simple;
	bh=/YBNU2Zs9bQwCzypQZCl7czbp0g43BJMAns5HeydPQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixjLOS5JDD7gjZxveQ2sptFONfOq+vYNeJ1DlqsA79xri/t24Me8fd3yDo6NW8XGIlJKER0xhENp2C51WMNtL7ybBnpXPsfiAAzwvkI9tgMXybh/g1k1c8wrfPxyuByYZA/YiTlGguOglll1XCxg53fQqRcGzSOBvb7MnF5vQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZStljLmF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64034284521so153262a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367484; x=1762972284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1nR0mbklQG2hJieOjc7M8VFk9hHWwwuGzNsGBq/ERk=;
        b=ZStljLmFf7/UrBHvXoWrCx+H7T8ehMJz11n+sIxWgTD5owoBb+YWtqr1JFU3jpqh/d
         7v5v88Cdh+PE9rJeI1eacn8YfeeEZcutCH9FSlXk/NWAEV6LAAJpeUw1H0crNw5pXJ5O
         Kx47o6XqWYYzMuLWo45Qae8fmHBj16MZ6tfVyB5SUcwiaMmgPK8qmMv/qWXbocTJVW14
         cOPMrsxBs4WkHbiLGAg3XuU+uJQQxYJxbURd6rdn4pgsjoPHr9OA5zmJiWSH8CrLrok2
         giojrz8OEca+er4aSAFr6Xz7LKb83hCHLNs5eFFdq3dwhdRiTNLA9cTzxe322yWp/ORa
         jQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367484; x=1762972284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1nR0mbklQG2hJieOjc7M8VFk9hHWwwuGzNsGBq/ERk=;
        b=KAK/4NUkKK82oZQRWiOK2FS/qkFy1fpgSVfHDOydud5hWwCJJAiAw5e1OGQzMfLwwI
         Kk+Ov0KhydqQQDCeB4Tnxhgg9zK+be5vM4brX26tsV9Bh1/FfgDNwmP+zSgtvb/KpOIp
         xwBrx9ZUc1xFZJSFBX2+iIT88CCV1Ut3i6E3HT24mBXr2zy2H35Z1jERCqoa8t8u00xT
         0JBh30HZwN6uoteHqqhJrAzOLMyx7ZNjvFdIUVwQG/K8F+GDVWvk2A9RBSs0eYRJFvFj
         BUFR8GKEZOeqSw9UM0dEuv1BNULxHP53u0rpTLcFm08/PHZuXasoj07Ow38seuYUA63V
         IKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBSV+sVbO99Pak0G5xaZ+vXW9MTY69pLpjLgGY9ewuS/xjv9JbFQtaqoHgb3r5jBLHwgW0aaV0FUF4IpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlVGGf+s0ghvTKwEP8zeG+EUC7AyYFQkqq+5gHDfmVhL+HZod
	pKlQlKWrYYjOR1mcNMTZ5TlSe/Y9JnYGlbD3VJeS9vc7wQ0hC7PEmMLC44WQ+8FCbYM=
X-Gm-Gg: ASbGncsprXj4bKM0l3+vPWNcRHRROuy5q+i7Tyyyy+gMavy+LyYPZBcPg+99nsFi/S8
	W9p7Jw0uG3aJuaqU+HEPJ4woyFnMR8nWHwyJWaeord6yfXgQn56d23bn/jH4ziscPBgKNi08Gvu
	qI89mI9IEe9sT8mtjr1GUvvs+ocKL3yH30o+w3N1soJhlhLy7vpSUlG37LXqdOxa/ETT9KewpSv
	/U03IbJEzKKlZfRdNKZYnaPoki/1XjK7VbuES6wUugZRAw9+KE3ieJroamyLPYtQmZeQyadTXvx
	J/JB2mMgq6eMu/f9asHHQ4gOrqZkcL6lu1tkXArt1kbLCTQv/kVaXCDaYOuRfMJxatJcoG5pXq1
	VQrNgXaBLzo/ZwVmb8dd8xYbqRCE+fg+xlWn0j0k8K3TmIV2F+RwBcJelugEfNM36pOfxe0zwAD
	A59UQ5p7BzQKtxTBSzbzV+sVKr0am2l+fkXW0r3MPF
X-Google-Smtp-Source: AGHT+IE1NNcGqm+HRLEzkP77SOA+h1IB2k5I4Zb1LrX/nDwePxv7lray2sPF/mzmLS27Do1651fjKQ==
X-Received: by 2002:a05:6402:34cf:b0:636:a789:beb9 with SMTP id 4fb4d7f45d1cf-64105b88fe3mr3769353a12.37.1762367483984;
        Wed, 05 Nov 2025 10:31:23 -0800 (PST)
Received: from localhost (host-79-51-28-73.retail.telecomitalia.it. [79.51.28.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6806d82sm5224368a12.16.2025.11.05.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:31:23 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mbrugger@suse.com,
	guillaume.gardet@arm.com,
	tiwai@suse.com
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2] PCI: of: Downgrade error message on missing of_root node
Date: Wed,  5 Nov 2025 19:33:40 +0100
Message-ID: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
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
always present. On ACPI-based systems, this is not a true error
because a DT is not used.

Downgrade the pr_err() to pr_info() and reword the message text
to be less context specific.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
CHANGES in V2:

* message text reworded to be less context specific (Bjorn)
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..872c36b195e3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+		pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.35.3


