Return-Path: <linux-kernel+bounces-803912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102ACB4671A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C576D5A82F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86EB2BD02A;
	Fri,  5 Sep 2025 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R+QSslE2";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="th+T+nn+"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74F28A72F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114759; cv=none; b=HFJlzFwOGBUNgXF7xqW1T+5vg8JgxoCnMAo+/ENhDum0evPOksP6HYm3hwaIBzQFABbhMjcBjEW0BRpNA7treHJzMb7wZrPVzfFLPhw5xCeB2tMwJustnfIvR33Rua8QgdARSQm5lpoy0zyO8OvvWHeLVvU3QewlOeIpWv8mXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114759; c=relaxed/simple;
	bh=vkLGon5Ycp4wW93u90Sw0Ny4k82oDFhfXs3NR6U/ofI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bn9zK7W3c3MW3ThG2ut/j5BsepjFtv1Dt+UFw5/WUHzBOhoPb2Pvzem4SKWrmfGcHTrdjdTk/qchn5gmN55yoJ/XSO+BK4bU/J8cmYD08jfCHYgeu8pQzbdzj3s7S4qgflcLM4nycRHYVzNmJhbtovCBYgw/hqADHpWHXHatrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R+QSslE2; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=th+T+nn+; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757114758; x=1788650758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vkLGon5Ycp4wW93u90Sw0Ny4k82oDFhfXs3NR6U/ofI=;
  b=R+QSslE2apR+oujgBHWGnAkeS2dPnSnd0rrQHpe6K9F3Io6PGu0oQOoZ
   RYxost6boZL4rxLv+YAfCkUcz3WXWfgoLiv18NS4rMJNoM1FqCsJEYjoD
   LafwnFvaKar7SeJKbYuAbShHDemUrdRe+Pr+qQtFGpQMZ68YFWQBCA2AS
   LPOnqJh1rEPEuv9ndKzyoENpgGUWsvTRrBR0AWFZJA7JPzr0QA4JJCjLK
   YdGs2HT5Xlbs2J/cutNJf8VYnslyQfDgpGiSy5SxN9tTNLTPInkdVzm3j
   wNmOn2g/5sKO5v/ki3lheklEACCWYRK3CrkaNIZrEow+iCC5E1DiJEEZY
   g==;
X-CSE-ConnectionGUID: HkKOef78TdyJbLUR+vG3EQ==
X-CSE-MsgGUID: cyXm+PKVRvaDBflPbgIqew==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109966137"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 07:25:58 +0800
IronPort-SDR: 68bb7185_IauwivNudzFhCx2F/9wCmbJiFOAgUjfGmLVm7kCPq6BMuHu
 W5U1IhO21oNXp8jewORqkxwy4+rwynfzrj7yrmw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:57 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJXXP1ctFz1SHkS
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:25:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1757114756; x=1759706757; bh=vkLGon5Ycp4wW93u90
	Sw0Ny4k82oDFhfXs3NR6U/ofI=; b=th+T+nn+cUP+UpbyW3nJ3OQRd5ZGJMkTi3
	pKK9X3v4p/EnzzUcNJSRenyyANYT3J6s37i/c2bNysLVia7mcjxJAebIY4NGpwvm
	OZUEDi0ek31QuY1J7KhbLSxQL1VdgyNkS1awto2OIXBOO+dvfoDI0u8794jiKWi0
	znpEJh1Ol9LhDzFxnY8MZVEc8FFS8OLPXLoqa3FWeoRnNZ7eoLNYiGWFIhMpuqM+
	ByHeWFUB1pT1a0UzV7gyDRbBQCmoZnikiy3ihk0ho002hVrIDvMkgEcQFiA7WyHF
	cUGImqnMxJvBFMYFDSXUP8rgw7fJ7LOxkoO37jb7Jl2+Ij2ZES2A==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ICWSq-GmcvkS for <linux-kernel@vger.kernel.org>;
 Fri,  5 Sep 2025 16:25:56 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJXXN39dnz1SHkR;
	Fri,  5 Sep 2025 16:25:56 -0700 (PDT)
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
Subject: [PATCH v2 2/2] nvme-core: do ioccsz/iorcsz validation only for I/O controllers
Date: Fri,  5 Sep 2025 16:25:50 -0700
Message-ID: <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An administrative controller does not support I/O queues, hence it
should ignore existing checks for IOCCSZ/IORCSZ. Currently, these checks
only exclude a discovery controller but need to also exclude an
administrative controller.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fab672e50510..ef6f84d677d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3496,14 +3496,14 @@ static int nvme_check_ctrl_fabric_info(struct nvm=
e_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
+	if (nvme_is_io_ctrl(ctrl) && ctrl->ioccsz < 4) {
 		dev_err(ctrl->device,
 			"I/O queue command capsule supported size %d < 4\n",
 			ctrl->ioccsz);
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
+	if (nvme_is_io_ctrl(ctrl) && ctrl->iorcsz < 1) {
 		dev_err(ctrl->device,
 			"I/O queue response capsule supported size %d < 1\n",
 			ctrl->iorcsz);
--=20
2.43.0


