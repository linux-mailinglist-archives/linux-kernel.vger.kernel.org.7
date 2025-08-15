Return-Path: <linux-kernel+bounces-770116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A8B276F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E635E389A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE322BE040;
	Fri, 15 Aug 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k5zVo/Iv"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC24292B4B;
	Fri, 15 Aug 2025 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229279; cv=none; b=FiFLlCkPxr/HwXtfGV0iUrbFGdtnEgeRife8vQg7lyLzzLJN68sXF6NMSZLpmXY/g+dfIGXFvKX0ZzdCNwo+WWGE/Hd1lOM2wCp5FHk5g4mXFHpPLP4B4uxnxMh3s+XRFwwDpHEQ0RJx7dqjYNqaxfdpZI1+kRWAt9mQBaK24Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229279; c=relaxed/simple;
	bh=xlTstruN7TR553TGg6aAGK2kUEYuxmRjzfUX9Qg5PCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVfGTafOHbZhwpjL2vcW19qhoCPOsgKIAWQKd6m0rhIGKQTuqMvxcRXPL6z8n5elG9TIK9UvuC1OD86YZxMRsSQpC4QgYQu+L5cO1LPyp/EWP5Vxm/Va2eliTfLsVIaPKxJznl+rFyl7YU7SjNLNzHySf46mLpnbuvZrz8cRKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k5zVo/Iv; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F3f9ut2075234;
	Thu, 14 Aug 2025 22:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755229269;
	bh=6DoGU6fuw7kJKhPDT31ltrAucunWKXI/LWYZ8mc01u8=;
	h=From:To:CC:Subject:Date;
	b=k5zVo/IvPEcf3R5BW+mc8Sdi5MddnE56WB1RVceIAYonW8Cj6ZAUScJtHi4HjBUuX
	 85BTMlkwodfCGLvPJ0KlFg/DWzs7RNKCA7BgOKanujkpYGdy/0YYcIo+DJSE7ypUrP
	 C4xatAJnSZGoRImKGqB6vFrTe3FBTADaUv8t3yV0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F3f8mt2307931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 22:41:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 22:41:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 22:41:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F3f895419038;
	Thu, 14 Aug 2025 22:41:08 -0500
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
        Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V3 0/4] drm/bridge: it66121: Add initial it66122 support
Date: Thu, 14 Aug 2025 22:41:01 -0500
Message-ID: <20250815034105.1276548-1-nm@ti.com>
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

V1: https://lore.kernel.org/all/20250813190835.344563-1-nm@ti.com/
V2: https://lore.kernel.org/all/20250813204106.580141-1-nm@ti.com/

Nishanth Menon (4):
  dt-bindings: display: bridge: it66121: Add compatible string for
    IT66122
  drm/bridge: it66121: Drop ftrace like dev_dbg() prints
  drm/bridge: it66121: Use vid/pid to detect the type of chip
  drm/bridge: it66121: Add minimal it66122 support

 .../bindings/display/bridge/ite,it66121.yaml  |  1 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 63 +++++++++----------
 2 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.47.0


