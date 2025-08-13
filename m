Return-Path: <linux-kernel+bounces-767391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5072B253A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE6A1C84C67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B05309DDE;
	Wed, 13 Aug 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qxs9WYze"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E156309DC4;
	Wed, 13 Aug 2025 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112133; cv=none; b=TemX7L2ND1drHD862EXsEUIU7NkYhK53eySovKb0LUPqKW8//O7sEogwLxxzwRC8A5e/GmwHZHPJmvSOxjeTtISno/JWzvZ1oLU+JdYj4M1JSGA2s0vWBZ5R7EN5QV9Atrh1QPZ6O8ceqG7vxHeUUXIVg77kIbmrjC3KgWujV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112133; c=relaxed/simple;
	bh=0qdqke5Tvw5rlJZQjomO73sVMHQrQU6/UJEe9FfVE0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afbVjOjxq8g7VR9yXjtDcIvxzCjb7aSuGeTx97Mxi4A/1fo/PGAO6ct3/v4wv8GPvZHi+qDVl7moDzEgG3DE2JT6M1YCtRbO1rqMfi5hCo3NW7U+DGJugOqURGKpVAcEPsE2q896se1lrOKhoYqyeTVovEqoeTqpqr6TI5/iBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qxs9WYze; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DJ8a8L1712667;
	Wed, 13 Aug 2025 14:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755112116;
	bh=TaPk+ccuvMGmv9TIdYwFz87jfaQlmzkZCZgAz6btmAE=;
	h=From:To:CC:Subject:Date;
	b=Qxs9WYzeQZkspsZ6ea/JKNDr015J3WHJtw25wJgyFpX+6gn+kZgtHzAEQHAEVjlSk
	 ZbGBsSVstcrsR0THMphxkk5w1xN1YBan2b9WgifTxTz0CSc0sLQ24i9rZjmHpfJwmC
	 bLkbu/OsAyvkjbKgYfVxNsn7f1ptTdu4nmFlX3ek=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DJ8aaa601290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 14:08:36 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 14:08:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 14:08:35 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DJ8ZaH2756631;
	Wed, 13 Aug 2025 14:08:35 -0500
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
        Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] drm/bridge: it66121: Add it66122 support
Date: Wed, 13 Aug 2025 14:08:33 -0500
Message-ID: <20250813190835.344563-1-nm@ti.com>
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

Add support for IT66122, which for all practical purposes is
drop in replacement for IT66121 except for the ID register
definition.

BeagleY-AI uses this new part as the old part is no longer in production
as far as I understand.

Now, BeaglePlay uses it66121 at the moment, but at some point, it might
end up flipping over to the new part.

An alternate implementation could be to drop the revision check or make
it66121 check include alternate ID check.. but that seems a little
non-standard.. Anyways, I suppose mediatek platforms will face this
problem as well at some point.

Nishanth Menon (2):
  dt-bindings: display: bridge: it66121: Add compatible string for
    IT66122
  drm/bridge: it66121: Add it66122 support

 .../devicetree/bindings/display/bridge/ite,it66121.yaml   | 1 +
 drivers/gpu/drm/bridge/ite-it66121.c                      | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.47.0

