Return-Path: <linux-kernel+bounces-803911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A2B46719
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FCDA46905
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D997A29BDBA;
	Fri,  5 Sep 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y2UJZU2j";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="m6JS2rkU"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7528467D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114758; cv=none; b=qB72y41dZy74hXWhjuhK+fI+7caY7K7Qk8SghgB9Y7efIrlZzY+TN7IlQmFh1LEvPYtcvmA19k3E2/yDoLy+4le0spjO5tp/4BDmalVBFRC5K3BaXKrH4Ds+7Ql3j/fzJtY1ableoh5Pcn1qfxn6xX9AKEYyCWu0rmeE6XJaZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114758; c=relaxed/simple;
	bh=xnm/rL7S5sreIfGIwvGukiv5lCZMGf/j8qxjqCE7hL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az8xBObl+zKL7jk2ZwXZt1ekM4QmV7rBA+s7Dyt6hxN7KzGdjDbiDc6JjXBTWWmIctpFxVkuEmJAVAe7tZrmV8FnXeVLje+PJ81/WMJ4zZqc3iyDMNuzbaMb8NmKrL84Q5pScXEeIBLZTuPQkebg52seLqFObXRkDvNMhm2yVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y2UJZU2j; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=m6JS2rkU; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757114757; x=1788650757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xnm/rL7S5sreIfGIwvGukiv5lCZMGf/j8qxjqCE7hL4=;
  b=Y2UJZU2jK+b8W1Sw7clocUxfLyPHc902ab7oM8sDl2wKLGbr7o9tAQkT
   kQyuumBsCgGttyFvcrrNzQGtdoCwmFiYYX5ja4yk+jp67c3TW4xIt7aAP
   3uZBZ7minL8DJ98e/N+Xmcdw6SDr1Agpc3IqcQ5ycmIqmJ0KV6tI515QE
   MC3o/W9TNOjDDSmxvIvAZpCV3HTlS9M5MHDUsHgL5hjyCx5DOMSJH8dKy
   jKuZx/SfzvtWu0NRK7CcDQsKq7PgS3CJCvOOjCDZXeUZvsDZ4c/HyVl57
   7Qp32St2aW1eEknrqoRguYbBy86lF9oet0klPSp9+iVv064G1fC4VGDGG
   w==;
X-CSE-ConnectionGUID: ZjolGDcSSTWQsjV6VJTNNA==
X-CSE-MsgGUID: MQTnVToJQZuWVNqUuBmqww==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109966089"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 07:25:56 +0800
IronPort-SDR: 68bb7184_+eahprR4caXyqv8XueEOZFXn9h+BKXXuHmeCzTewLoN8/U3
 ssTaniQBtBWk6L53yMlWma75B19Cidf4xqqSrIw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:56 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJXXM5ySDz1SHvj
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:25:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1757114755; x=1759706756; bh=xnm/rL7S5sreIfGIwv
	Gukiv5lCZMGf/j8qxjqCE7hL4=; b=m6JS2rkUQoFOD8mAJbzXHE+nQONbp8IwQ6
	wmqV1AyI0gzxneDvTVvMnguOejfzvdIA0WmBflRB4YzvXWJG6xD7e1I/xhiuUDec
	BO+F7m+AKWy3cCdMPTUvLwi/4UKqukUu2RfebIgQAGYqxLgee4Ad4HJlbe3rf9Sm
	KQet0NZvyt2/vsVEb+Iltsm+x/cjrnYukINv9we+9UVVDxlRGmlJPIpzFK14rjua
	KPd1cS4vJyAGJttq2GtNaWOVA51dAELCrKTL0N1C2Cs6G/965RWrEivy8RKUfrNy
	Gyp9uwMKUM8WH+rp3OuUqIHo2q85Fcr9Q8otgjPuVRDfB4okTlPA==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4wd0kpOPg8gl for <linux-kernel@vger.kernel.org>;
 Fri,  5 Sep 2025 16:25:55 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJXXL6mM2z1SHkR;
	Fri,  5 Sep 2025 16:25:54 -0700 (PDT)
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
Subject: [PATCH v2 1/2] nvme-core: add method to check for an I/O controller
Date: Fri,  5 Sep 2025 16:25:49 -0700
Message-ID: <20250905232550.1950307-2-kamaljit.singh@opensource.wdc.com>
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

Add nvme_is_io_ctrl() to check if the controller is of type I/O
controller. Uses negative logic by excluding an administrative
controller and a discovery controller.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d67545bd7abb..fab672e50510 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3167,6 +3167,11 @@ static inline bool nvme_admin_ctrl(struct nvme_ctr=
l *ctrl)
 	return ctrl->cntrltype =3D=3D NVME_CTRL_ADMIN;
 }
=20
+static inline bool nvme_is_io_ctrl(struct nvme_ctrl *ctrl)
+{
+	return !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl);
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
--=20
2.43.0


