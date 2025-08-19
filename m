Return-Path: <linux-kernel+bounces-775786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4FB2C4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298C0189C0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B8340DB9;
	Tue, 19 Aug 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QYf2Og+m"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD833A03A;
	Tue, 19 Aug 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608915; cv=none; b=Ccy/Ptl0SleXoegakEaTn69pK62QyH58SUMNMdGkctDQmsu3TCwWQ+ruFFXF/Sn3cBRP6c/Vtl90CiBdGHyWvq8oQn+rY+tm9NAiyVKHJF8Hh4oFnda3cAP6XxQTtDp8C1ObJ2MM958VZJyPMgeXXlHIRjBVbcrOb9PRFQny7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608915; c=relaxed/simple;
	bh=TQVwtClWCA+8RO65CTYwYAjYCrYVmjvFMzpWRSn7zIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KVWQQrzY6KyHTl0Xb2JS9zLfgszgOTIidbLvmpxpq6R/yEyOqGbzlvEWUoxdRec9Efk8oQzNwnMn8MqbYltcEXPk8ahlT/SKrelvttPYeNvMPDG1pVlAnNrjEY4KO3/fJSK/j4A5bwUDtQ6BZha7Vt+G6D1wTOLGF77EsIH5BVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QYf2Og+m; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JD8BEQ014894;
	Tue, 19 Aug 2025 08:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755608891;
	bh=uRqHHzGDVQyZmbbWGYjj8UmUVEoB6TmINAhU6vBkxb8=;
	h=From:To:CC:Subject:Date;
	b=QYf2Og+m1yNZdiYix801ZQVniURWzUd3RTomw9xb20Rz2TvwjhNA76dshKNbhKjAd
	 8jF5eE6azyEZiZkjDPsRYm4Nc+7t9DlfezQpNvav39iWBc45FkWK8gdHHg8dqH7xd+
	 45ltD9VhQ0KW0k3QZE7zCqh6F1ISrLu5ONIHMdLc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JD8Bmd421278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 08:08:11 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 08:08:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 08:08:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JD8AmA2747727;
	Tue, 19 Aug 2025 08:08:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>,
        <dmitry.baryshkov@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 0/5] drm/bridge: it66121: Add initial it66122 support
Date: Tue, 19 Aug 2025 08:08:02 -0500
Message-ID: <20250819130807.3322536-1-nm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

Add initial support for IT66122, which seems to be compatible to it66121
but probably has additional functionality.

BeagleY-AI uses this it66122 as the old part is no longer in production
as far as I understand.

Now, BeaglePlay uses it66121 at the moment, but at some point, it might
end up flipping over to the new part. Additionally, it also looks like
Revision D of BeagleBone Black switched over to it66122 as well.

Changes in V4:
* Added patch to sort the compatibles alpha-numerically
* vid/pid lookup is done without using the match_data.
* picked reviews

Changes in V3:
Based on Tomi's and Devarsh's reviews, and searching online (and failing
to find) for a public data sheet, I have refactored the series to:
a) Detect the ID by matching vid/pid
b) Introduce it66122 basic support which seems to work based on
   empirical testing evidence on BeagleY-AI. This allows incremental
   patches in the future by someone who might have access to the data
   sheet to add additional features for the chip.
c) Irritated by checkpatch --strict warnings, added a patch to fix
   existing warnings as part of this series, but it could probably go
   in independent of everything else.
d) Stopped claiming it66122 is drop in replacement of it66121 :)

Changes in V2:
* Picked up Krystoff's binding ack
* Switched over to a vid/pid list

V3: https://lore.kernel.org/all/20250815034105.1276548-1-nm@ti.com/
V2: https://lore.kernel.org/all/20250813204106.580141-1-nm@ti.com/
V1: https://lore.kernel.org/all/20250813190835.344563-1-nm@ti.com/

Nishanth Menon (5):
  dt-bindings: display: bridge: it66121: Add compatible string for
    IT66122
  drm/bridge: it66121: Drop ftrace like dev_dbg() prints
  drm/bridge: it66121: Sort the compatibles
  drm/bridge: it66121: Use vid/pid to detect the type of chip
  drm/bridge: it66121: Add minimal it66122 support

 .../bindings/display/bridge/ite,it66121.yaml  |  1 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 66 +++++++++----------
 2 files changed, 33 insertions(+), 34 deletions(-)

-- 
2.47.0


