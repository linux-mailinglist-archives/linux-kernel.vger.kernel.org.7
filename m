Return-Path: <linux-kernel+bounces-803785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE09B46536
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5ACA7B2435
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E52ED166;
	Fri,  5 Sep 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rx9P372C";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="inaA4eHu"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076E2EA493
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106609; cv=none; b=QzPjLYffh0CQJCyToEPwtCdPdGEy4cuuuPrQt/ZKGd8Je4uADUcZHHrizyFWTjDKAAabA4eLHVmQ27426tOKcOOCNqdUHzRkgKlju771nY2jda69jdiFNpeHPqlxGd55+iiB/btG8DnroBnI+StxlfAwJUDNkXjD0QPqYc0ZOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106609; c=relaxed/simple;
	bh=CYVAyYXPatsdLzMjk9BfS+eVNO3wXN5nXzMRYuQDU6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgIQe4d6SgjTgO1fkDYDZmV+YVSRcm/zz+R4rShrWPDK1WbPrtTtKOnVJB9c1F3ZMrcRcltLI8WD62JS1e2TEMzEVDHd31YHX8dgHK8iOF9kaLkJJWawDWRC+hu8iOsOHP6cX6jAao1FZm8G9fcrV8ldERfGU0qWgOw1Vj8wQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rx9P372C; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=inaA4eHu; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757106607; x=1788642607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CYVAyYXPatsdLzMjk9BfS+eVNO3wXN5nXzMRYuQDU6Q=;
  b=rx9P372CzkEXl00W84GdiLoUysCmtOsKAJcrmCFWKXqxd0EflouGkcUU
   /D/TXzbzsMsnVxAY8JHNdolfzGCcdxsOqJ3u4GHqDmoOwe4skgh/Po8j6
   2SW7PKprmsi0egHN10PztW9xsE3EElOykuRZnRctTA/V6kcq0ZS7nil/o
   AZ7yPz22fyzTRNm+n5MXdH193/CYHi5iwUCJzm4Wge9G3qJ/KkneJA4Yb
   u4k0qsOnXzIVFZDMf+GMVcq2rbHycVzscIPjoCN9gF4TswRXTEB51Q4Y4
   ZCZo82dDoKmc7e8rniZUyAauhbE19HxQpb9o1StssBQ6lATPrOwPKjW+o
   A==;
X-CSE-ConnectionGUID: tzz00ah5TEa+an7c+XOhJA==
X-CSE-MsgGUID: GYnk0c1vST6GuSyTYz9Bsw==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="108722695"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 05:10:06 +0800
IronPort-SDR: 68bb51ae_I7aGEKDcGtf9iOyHuKyc74qi6OIbKMtmaAMs5zBkh/TVWi4
 PTb0FH7s3AO8LA39xXBK6/dG9fd3knwvGanrrew==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:06 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJTWf0gSGz1SHvk
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:10:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1757106605;
	 x=1759698606; bh=CYVAyYXPatsdLzMjk9BfS+eVNO3wXN5nXzMRYuQDU6Q=; b=
	inaA4eHunSj5nhdp2qJFBHVOSuII8fs/VeBdonbMSgc+7gS91rZ+yrcmDjaBqIcz
	alUzFezuLbwx7WH2DyA8EHdAs3faSFfr8IQIVQ89UYqk+X07o9QHq/OScWHoMAtP
	S7gUZrtcaL7G3ArS4D6HBBQ+w0OMfvSFp9vDgLQSTSGbs7Ge5GQs1DU/6IjWV3IC
	rZaaPBlM7tbd8mbHn/+H4Ajs9ICNfa40WeZGD+GUsQCPErIH12zBANTenVad27OX
	YB6a4WlWvXlBFik+1CkYuExBpmflCecFGWIZM+5delNBZCNs1sIH1L4pXe0CHzdk
	OzRn7PIUD5jH7MEgfEjpHA==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6mBqOyexWaTT for <linux-kernel@vger.kernel.org>;
 Fri,  5 Sep 2025 14:10:05 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJTWd0f9Nz1SHkR;
	Fri,  5 Sep 2025 14:10:05 -0700 (PDT)
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
Subject: [PATCH v1 0/1] Preclude IOCCSZ/IORCSZ validation for admin controller connect
Date: Fri,  5 Sep 2025 14:10:00 -0700
Message-ID: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
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

Kamaljit Singh (1):
  nvme-core: ignore ioccsz/iorcsz checks for admin ctrlr

 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.43.0


