Return-Path: <linux-kernel+bounces-736097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E8B098C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08D7A41AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26A46B8;
	Fri, 18 Jul 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YWGuJMvF"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9693C1F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797658; cv=none; b=NUdP97qSdh+bgbn1b2zJPDsH/NRAoY9R7vhdIrUMJJZ1rTHwUvNYR1TxWEfQQz/eXMxdNAUwuYg+H1OyxyIBCuIcB0v8s6avw6V80hk6Y0PT0SWlARS3YaXsTSKr0btI/9x+cdyc+w+J6h45rCVCxG2r4CVhIG3YW2VLzvyz+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797658; c=relaxed/simple;
	bh=En3rA6x2Gu9JvlFAJw2uquATA8Ug4Tk93J3ouV+xvg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGnG+WHbmXI0mfuPgE8ko742l5tEZNoLRtFfgIgVgDXMN7nMEXrBvC7CLBaVctE4YlbNOi3AaMMHQvVjxqx8n56uh/eX8Eip6Y5eB+FZA6zzu2xSDlYJLd9HGOfUMW7lVz5Qgj3hIgbM80JbBXpBsfRpPfj87HokHfvhroMxRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YWGuJMvF; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752797656; x=1784333656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=En3rA6x2Gu9JvlFAJw2uquATA8Ug4Tk93J3ouV+xvg4=;
  b=YWGuJMvFSIeg3pvFwOLvA+RpBhyG1a7wAPs82Ohi4yugeP+lQTLGseyi
   GMubV9jXcGw5fvF+CzZf57raltliwPTs1+q76B7G9oTG/k2eOGwqKJ8AE
   6joti1ttCLxhgKw/RWfAkk6qhHZ1YG2nrzoQoz4qDhXboMQ9yNWfdCClH
   RyKzZWUeUq2VTAd5rm3ihxq1qzpxWhsf5OIXlE3g1C3kCtGtZMeIZwdmc
   ibgdTS6dDSdK0drw+HQEFGfsP7Xm9D9W6IMJg+6uAnllSyO3V6NuHuhKm
   G8riQ45hmfB+Dtd3dyzYuD+IMTDij6YEAzuevpbVnaplrNy1Qfipl9uZg
   w==;
X-CSE-ConnectionGUID: ITqbFFdfSFW58ygahx5mFA==
X-CSE-MsgGUID: LbgSC1PiRo2un/F1KVdOZA==
X-IronPort-AV: E=Sophos;i="6.16,320,1744041600"; 
   d="scan'208";a="94801296"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2025 08:14:16 +0800
IronPort-SDR: 68798334_T+ryPtskr6hmIbijsVRuf4N/TaWHpu30+Hh4tYtTOK8dT0V
 wclFVhdVV9lCVeF6K+9TLdHq1kHd5et7+/apgfg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2025 16:11:48 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jul 2025 17:14:15 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v3 0/2] Support for Administrative Controllers
Date: Thu, 17 Jul 2025 17:14:13 -0700
Message-ID: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[1] Add capability to connect to an administrative controller by preventing
      ioq creation.
[2] Prevent an admin-ctrl from getting a smart log (LID=2)
[3] Prevent ioq creation for discovery-controllers as the spec prohibits
      them.


Kamaljit Singh (2):
  nvme: add capability to connect to an administrative controller
  nvme: prevent admin controller from smart log fetch (LID 2)

 drivers/nvme/host/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.43.0


