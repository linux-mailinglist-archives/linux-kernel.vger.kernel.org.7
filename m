Return-Path: <linux-kernel+bounces-803786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B84B46537
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E902D3B7DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC02EFD8A;
	Fri,  5 Sep 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O+DzMOjU";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="KrOohj5S"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB192ED143
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106612; cv=none; b=KCbrd0OLcAT7QAEvWKXGxewsQc8nqPkh4FrIKsxMsyBTM+SCcy/EO+PQ+TSHCVght4hWjkP0TWH+qgfXi/ZUpY1hzT5zCMm0RMjKZeM+tLZPQvmeoqEojPQEHapgCO427Aq+372aCfEbVmZwIP9CmQE2DM712X0dxcj8kKVk8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106612; c=relaxed/simple;
	bh=zUXslDRT5Pnpqr6o+a0EDCIsWR+TcWfZU2WreWPQZB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU2Hu2Wq4x3k/mGKAw3kCJ3dSP23DTP1JxoTQZO4Ns1pYDtVrz4KOzOsCwpRLabzU9IAFkfyNC5/akk3fKzl/L6rQvNtXfUH4wZB4AiNZAChAjStfQfTvYItxRESFo8M6PZxUJQsU/z6Jiqzv+JGcret7H6B6BrcZGG57qQOlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O+DzMOjU; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=KrOohj5S; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757106609; x=1788642609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zUXslDRT5Pnpqr6o+a0EDCIsWR+TcWfZU2WreWPQZB4=;
  b=O+DzMOjUEBtZMP3QcMm7+fVxFKJ0XrzuLYonic9e5+QwAV/+wbINRUYe
   jHWjI+d7+wjjo+d2B/GqXaAqnOYp4C1/KzgThPoxmADCVQR6u29qmYYYi
   0wUE4kgiBvQbB/Z+64AfWqQc2ZHtMBBpn8lrRdjchfQbdU8fxeAP9xQd4
   gb7F19X5mGkhzP7+Ibolaui+dTpihMNonvZgjrXS8UY1CrYcDBqJROwcQ
   /O2zspgtTPhb2b8aEwZeB2+bk9AZ+x4I44w6hSBKRwMJa0MAUwGhPtjPg
   jlcYbdL2kPB4bgKTj1KDFV4y1GMyHbhqTDgFG1ErUfuj8hBP3UiWjAsFx
   Q==;
X-CSE-ConnectionGUID: edNic6oWReWrA3/zwvcASg==
X-CSE-MsgGUID: +RUZLVHYSQCfKhckPvPk9g==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="108722699"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 05:10:08 +0800
IronPort-SDR: 68bb51b1_6E7+j3DV3QQyaeOa5ymLq8tzClzAyC/wkNdkBiZyRck/Byg
 tjXFmGtqmgYAlU2VnlXtT8apVw7ELXPAqaUAPBQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:09 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJTWh4kNpz1SHvg
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:10:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1757106608; x=1759698609; bh=zUXslDRT5Pnpqr6o+a
	0EDCIsWR+TcWfZU2WreWPQZB4=; b=KrOohj5SkU7dbfg8W/pStxiRxS+SwS4IRg
	MY7J79sP6OB96/HMNBHECv4eIZAC1uA7Atv8J17kZ3AuBnrsZFgw+TPlQp4Sg6Bg
	TTDRRdNMEDsDQD+KpfkgOpxdx1Sj9pLpaUFgDB/OFkTWEFJlR2XmasNyhUlsptRi
	quAdt/vDJSkg4Hbr7yBgJb4/y26EyiBdHV+YMzi1T4VMEw4qe43tRoX+rQeG5A5X
	hRL9zuG7pHIQx9g/yAihvTqW7KD8XPJUUmsdv2sNA/Ez6c4TXzMGxMZQGTk9eMU0
	lypcVH2fHrHqFGEl3YYIUsE7WIZ4pS7e7tkFgDHualeqEsnwRO5A==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UYANkqpFtBlW for <linux-kernel@vger.kernel.org>;
 Fri,  5 Sep 2025 14:10:08 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJTWg5w9Zz1SHkR;
	Fri,  5 Sep 2025 14:10:07 -0700 (PDT)
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: [PATCH v1 1/1] nvme-core: exclude ioccsz/iorcsz checks for admin ctrlr
Date: Fri,  5 Sep 2025 14:10:01 -0700
Message-ID: <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
References: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An administrative controller does not support I/O queues, hence it
should exclude existing checks for IOCCSZ/IORCSZ.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d67545bd7abb..ac72bae800a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3491,14 +3491,14 @@ static int nvme_check_ctrl_fabric_info(struct nvm=
e_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
+	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->ioccs=
z < 4) {
 		dev_err(ctrl->device,
 			"I/O queue command capsule supported size %d < 4\n",
 			ctrl->ioccsz);
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
+	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->iorcs=
z < 1) {
 		dev_err(ctrl->device,
 			"I/O queue response capsule supported size %d < 1\n",
 			ctrl->iorcsz);
--=20
2.43.0


