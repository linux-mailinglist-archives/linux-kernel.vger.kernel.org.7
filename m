Return-Path: <linux-kernel+bounces-803910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C114EB46718
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB81B22CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2DA28BA83;
	Fri,  5 Sep 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cnuxdNLn";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="cRNSGdAF"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A6274FEF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114757; cv=none; b=KubFBYpMwx+y5jtfeJpiyWGdIMxXsAbJWgVgZgAqESmIsMyproKY1xwbwKFzPiJV4uJuWHtXxriksWuRtqeNCFXIJ2sz+MJqqqEN6IzeonKk+IadoSEaMuI5zaBws/ZO7n0d5paEs9FSr/apes0LD1292y6JLA58Rz8fb6buWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114757; c=relaxed/simple;
	bh=xvDJg2Gz33BS+doCIEG0sIMD3bw8L32HmXlhTBzK+YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmhgD9bxSHmCr/iVS/OLNIIffvjWKcZtjsbYhOUwK9LQ8a1xyPNM8jVXn1pozIn4pJOsy2ZXs2MYLDmEorHrKzj6ujf+1mMPgQLpk51QtmoJ7VuHTG+uU6sBdT8//zBBN9q7dy5RNuZEbQGyig20i12DR/7ladvtRkAVI4AZ4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cnuxdNLn; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=cRNSGdAF; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757114756; x=1788650756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvDJg2Gz33BS+doCIEG0sIMD3bw8L32HmXlhTBzK+YU=;
  b=cnuxdNLnxWbAHzgUBnyowWtnZj9OWbr+E5P0jifi4MsSScjA6V1Sa7Sz
   UDWeBCOmnQfVOv7ZoLIPMxWAHA8DWIRXP4f+6PgePOFH6bX0pvJYBrBw/
   t65DNYpxoMjm+1D8NB8h2AWO8sjT1olg7K4+ghenc0JEI7+SMg/LMmMfS
   I95OxHXiE7q8GCU0TCXfqZ4865mfPUr7HW8iO3sVBAoNct8anHqO8IDPi
   NwGeYJ4QN5PCzA8re4nYB/2d13KiIIttwr81XQplNPvsD2XAynFoDgQ9E
   ZfkJ0+on6rsAjdaka3QD5FTZk2BwrXWr0hxfofnJxOOAWU/FFEEseYP6u
   w==;
X-CSE-ConnectionGUID: dcHiTTG8RpeHCZqW4+wC5g==
X-CSE-MsgGUID: YZoeITffQYWVgZBMdAnSiw==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109966052"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 07:25:55 +0800
IronPort-SDR: 68bb7182_a9hpYf2vXGxZjcoW9OXeKLmLNjVtYEIKt5xBt4LiCrBuT0T
 /eY+3cB5dQSY/nGaTKPZQrRdHcxTx9Jwv+tM9nA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:54 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJXXL3Kl5z1SHvm
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:25:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1757114754;
	 x=1759706755; bh=xvDJg2Gz33BS+doCIEG0sIMD3bw8L32HmXlhTBzK+YU=; b=
	cRNSGdAFPb07GFoLCSozal6DjXlFMSOAc2TqLmbajdhZk2ozUVAiFyf8UlPwWdg7
	SvzkTo8Ppo5pB9ydkhopxCi4GWyje1+pXSZ4/ce7wmJoZAaUNp8/iGv6V+yOSEuD
	PRKZZ+7QCFW2pRsic50CXbGTALfDcZ61RcogRWsk9DT6y7d+i6lpESH4iUjDGVwi
	Yqe7fZ5cg6ChyU0VI2OHC9JTal7go0mh9E5XnuKjVJwbyy2JM9KevttlAgQmV9W0
	BzXgAbMf2uQ/X9EkTGfw4WebetEDGAAeRbfb2kK5BBGWWVbTH7SOCNCqG812B+w3
	AA6a43shABrWbATQQOZj8g==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id psP15H_R4B1l for <linux-kernel@vger.kernel.org>;
 Fri,  5 Sep 2025 16:25:54 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJXXK3RYFz1SHkR;
	Fri,  5 Sep 2025 16:25:53 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Preclude IOCCSZ/IORCSZ validation for admin controller connect
Date: Fri,  5 Sep 2025 16:25:48 -0700
Message-ID: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During negative testing it was observed that when ioccsz and/or iorcsz=20
were cleared to zero on a Target, a new connection to an administrative=20
controller failed to establish, due to driver validation of those fields.=
=20
Since an administrative controller does not support I/O queues, these=20
checks should be excluded for such a controller.

Kamaljit Singh (2):
  nvme-core: add method to check for an I/O controller
  nvme-core: do ioccsz/iorcsz validation only for I/O controllers

 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--=20
2.43.0


