Return-Path: <linux-kernel+bounces-880701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A40C265BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DD1A65CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C36E34DB7A;
	Fri, 31 Oct 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="o9te/yYP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6E34D4E9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931706; cv=none; b=oeF5PEN42RDpYmPo2QuOr7nYlTbXyup98UMuZ+V4B6ixDGTsClh2+GdaeWDz+NWgtrWaxjLgVDBBU7ocuoBWHcVQv+KbEzbjHRkAZhSzrq0HksgBL6l6HNBu4mqtP73fccAXj9B0lrjOjoiA4vA2QHrX1SWEqqO3F9JyjmzS7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931706; c=relaxed/simple;
	bh=533NYx92g40jb1ADfvwqEdHJ9gcFkilXSs69QufQenU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJ1bapGNE8mCWMea5ElCHuD1GwE3p5w27xoCgHSRA6bjDENkBWwU3YOtNJbu2T35poOThwmrnexyv8Kw5bwshYzej6GsC+jN8nDrSAxS7d8bZyB4Vaw6ygnKpYWElplWz1Lc9N+IiDk+FUHyGU1m1EFqa4NRhm+Q5w0T+Sa0QHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=o9te/yYP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A325B5;
	Fri, 31 Oct 2025 18:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931592;
	bh=533NYx92g40jb1ADfvwqEdHJ9gcFkilXSs69QufQenU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o9te/yYPtmNzGapb++L7vSxLJEaVhKTyq8ptOegIK/TqOGXg/FDMpmILI7g9jB/nP
	 ATLXrZeU06CvXJsdCX+PZ/65hlN/Qmi+yUVFR26YRviej9kjMqPkYV0/TdvhaTf7hv
	 QHoWyC4B4zVfTld899NJuK5cv9cWqkiK9d+aBwzs=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:23 +0530
Subject: [PATCH 03/13] platform/raspberrypi: vchiq-mmal: Support sending
 data to MMAL ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-3-0dd5c0ec3f5c@ideasonboard.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=GGB5nUrnx+IB8Xu2CwCZTqROE4qS6bk1utWTjQbFuYs=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGWd9fNZvo+twIRO1O5q6/cVyUHvPYmTjVQx
 EcGMVcq3QqJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxlgAKCRBD3pH5JJpx
 RWdAD/0VEPbvjctIPCAUaattr3z/NJ9SBxd1hWpz087+/NooVrkuFjCpIlF59I9FJnTQKaY+hLn
 G/u6PzlmJlOkvDb4+lWI6NZqP9bxc9EiheucJE0C4uSFb4foKtT+9k9zqa+MFNyFhqQ+t+dhsbE
 zWGhq6jI6F0AX9nkMXoaCBb1dxcTFhRbxIJ2ArGA0UH/IxNA+BvhHlgLLmDccyTWly8vudfeHXS
 vrg5E0YscM5mzKceg7gWtqBdy6+eo2UiNMIoAk7o+ZOCBg+k5ouy7aQBiOlUbG9VD8/1S+QUCsV
 D13LwXnYQkwNXatGpZbPmXx4HkzJsbtJAsc/jRsj8tlDgaTTKOCWNWqWlnANjI3mI1ANAaZKsBW
 8GPov53HE+X7rnGiUQLk6fEDxyeqWfaRp5WH5ndY+t6o6vEVPyk/zmvhw9flB3O+F7kWkUAs6Zc
 MFn8bWHnlV/KvxVRTZuJyURyEqiqAg4sjTuBf7XgJVGfsk3AkVZ42iuYRXNbDCCHflRCar84/LP
 pr7gKdqdMPmd4d7cqAoeXhsYzFUkGB1sgEFs0MDrEcirIfGNJeF8dyGUA8bBq++M7ItgrIvEoff
 DM621AlXiK8eCTSVol5sFgGSuOSEYOl5xYq0917CM1xDIFct0XjG0dLnLeBTyn5f5h3lZffkBVb
 kULiK/jfnlUsSOA==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

Add the ability to send data to ports. This only supports
zero copy mode as the required bulk transfer setup calls
are not done.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index a115a391908da06e101e159905a4403b91e051c6..1ad00bb0a02b482719a75749ed6ca50f43df24b2 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -421,11 +421,19 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	m.u.buffer_from_host.buffer_header.data =
 		(u32)(unsigned long)buf->buffer;
 	m.u.buffer_from_host.buffer_header.alloc_size = buf->buffer_size;
-	m.u.buffer_from_host.buffer_header.length = 0;	/* nothing used yet */
-	m.u.buffer_from_host.buffer_header.offset = 0;	/* no offset */
-	m.u.buffer_from_host.buffer_header.flags = 0;	/* no flags */
-	m.u.buffer_from_host.buffer_header.pts = MMAL_TIME_UNKNOWN;
-	m.u.buffer_from_host.buffer_header.dts = MMAL_TIME_UNKNOWN;
+	if (port->type == MMAL_PORT_TYPE_OUTPUT) {
+		m.u.buffer_from_host.buffer_header.length = 0;
+		m.u.buffer_from_host.buffer_header.offset = 0;
+		m.u.buffer_from_host.buffer_header.flags = 0;
+		m.u.buffer_from_host.buffer_header.pts = MMAL_TIME_UNKNOWN;
+		m.u.buffer_from_host.buffer_header.dts = MMAL_TIME_UNKNOWN;
+	} else {
+		m.u.buffer_from_host.buffer_header.length = buf->length;
+		m.u.buffer_from_host.buffer_header.offset = 0;
+		m.u.buffer_from_host.buffer_header.flags = buf->mmal_flags;
+		m.u.buffer_from_host.buffer_header.pts = buf->pts;
+		m.u.buffer_from_host.buffer_header.dts = buf->dts;
+	}
 
 	/* clear buffer type specific data */
 	memset(&m.u.buffer_from_host.buffer_header_type_specific, 0,

-- 
2.51.0


