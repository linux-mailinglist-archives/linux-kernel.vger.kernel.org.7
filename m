Return-Path: <linux-kernel+bounces-892897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF43C4610C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18CC3A342D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30307306492;
	Mon, 10 Nov 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YwOOKMqs"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FA30216D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771923; cv=none; b=CUz+LsIg5uqRPeaii4wa9MjSRAOKdAH6Pfe+WPVcK6UqZM6otLNVNDDhg0KiSsMjq69CzgzX7krLKeFewGhwDYB6amW0E28jJGUzVhKUtKbjk9EWIYU+yiDGC/0fVeCd27BsEhyg60m70dd1VsK85F8UJtwNNkINE5c0oLIfJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771923; c=relaxed/simple;
	bh=y3edu1LJoiiM9LC+PEFZk26GY+1kMRaZynUHxgNfbZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RM9r/BglSlDGvi9F4klApkDW62zJCM5TEUpvbePO6qCyp3mEEh37uZyL98mNw74cQcjp1fzGChSzbBgG2xpdfe+TUiNhMPO+KIlEKHdd7WCHG3ItxTYLzE/uQSaQkAREgfhY3saojEhS++Tw1YCnwgkwt8eq0r8Tt81Mal2jwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YwOOKMqs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so920219a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762771920; x=1763376720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlF8y7focvzFqRSo0xYtMNEXP2QB9fpiWlRAbhS1B/M=;
        b=YwOOKMqsvRuTx0jTMnkaD06bBMCN8ErckrQFoZi8W63ys1y3WFpcUYPoSanTykbytM
         3/oaeCmoouTzGPP0qEsOTzU/2/XeHsT50ZU79QayWITvg2FCNI9H5u2zFoRxUKVuT7RC
         njjrxSxXl1lBeqo7nH/IVIU+XNCV0O9xuKcBr+AXNG5Vn9df3oss0gDBloCoYpIB6DQm
         rCbaVhmlE+M7/Ce5cmPC8vylz6wyXC74zvIbhKTG+l55Kgrduz2ft/WsY1sMXs1pCThq
         mLqepJec3odPNvwnaEw/GLg2Dfxl9YVjqr0Mcf1mMAf1rmbvDJtDAHoSRDGDTUmtMTnJ
         2RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771920; x=1763376720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlF8y7focvzFqRSo0xYtMNEXP2QB9fpiWlRAbhS1B/M=;
        b=w+RKhuKzCO9RuZJ9MF1pha1WtvWlqxd65imF3y8dJgDm0F9LguN0SGNiImvbt/4f65
         iXPMr5dL5xbJyR7e4a69nfczCYXxK+CgKtmGsNFyvRX7b7iAUQh3u5GuWYXV6e4+IlQv
         O7DzmguCbGHVmonwBrm2K6ReslEaP/ReiO9OqXhKcgoBgOTQY1H2tDLm0CXsppndKkYV
         eefacWcjH1/snvd/T/ZFDOq8mpiGnVAtT3MlYgEyX9LlWCOptw0Vo2XxTtPK5F6XAuld
         a2h6V8EOVKkC/4iiW4NhcaYG9nOdgi16Y/6jKLmDh8SWIeFLgMO54XmFPjZ3jitPw7kh
         05Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUv0xwBxdyGwBqujA+vuAH5u14/v8icGceC0bSM++OzckiMGnvhi4p6sT0MhIp2XLJAJmFLf8q0FzX4C4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGOpfaHQpPZNkE177rjzd8oxKJGiVSyH8oXUwGqCA2ibGKBlo
	eIWuQfqZWvYIdCvVvyDz1QePGohvR1/QXXPT0n6e62hFCYrqVqX45nmZUh/JbjHMADc=
X-Gm-Gg: ASbGncuaE4U7ue2dEyd6Cn2asmy08cWQXHDtndetztot2+AVWWa7UqlEOduetfFdC+o
	f801QDK0uzG5lPMpjnhMbGEvzzEY7L2uimJxjTqaG+TNz8Crjhn/P1CJW6nm8xyt9P2p9sqo/Cn
	j/K3mUbO64Pg/kIPWlNU2Ykgw4+No6+x607SyCtkhkYLWHCf6h0jppuo011DbekAEtSVHR/JWZh
	x5s5yXAh4ZMMUVuKusKVmyUrS4xw/ZSwaZknA68uNz+O7nK+zJZMrvNNTLkt/a9i+vgQC3/wfYA
	XM70LqSPwMvdxxuLekoqA+RhVG5gXaQzDkagyPIgwZ10gAeShhnHjvOV/qucZgtafsOe2e9b778
	zThU1MjPv40wrIirxt97MbQu7r80XqrA5uEFC1Yi+m55PunAeasQHLfBemTzmbq+DzRaVXGyc3A
	pBg9oEJpIeJsyvMvw5kEkZN56r2aINtTqHfFJFbPl9ioaH1Ir1gm8MtuC46gorQAKYNCM=
X-Google-Smtp-Source: AGHT+IEJOeTNgGSs6glS/5JXjFHhVoGWQ87V9gmhirZTX566XAbdRF9c9nY+pzK/lLddmBIEA1OCuQ==
X-Received: by 2002:a05:6402:2346:b0:641:1cd6:fecd with SMTP id 4fb4d7f45d1cf-6415dc084e5mr5969245a12.8.1762771920024;
        Mon, 10 Nov 2025 02:52:00 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm11079924a12.13.2025.11.10.02.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:51:59 -0800 (PST)
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
Subject: [PATCH v3] PCI: of: Drop error message on missing of_root node
Date: Mon, 10 Nov 2025 11:54:15 +0100
Message-ID: <20251110105415.9584-1-andrea.porta@suse.com>
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
Changes in V3:
- Dropped the error message
- Changed the commit subject

V2: https://lore.kernel.org/all/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com/
---
 drivers/pci/of.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..71899b385f7c 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.35.3


