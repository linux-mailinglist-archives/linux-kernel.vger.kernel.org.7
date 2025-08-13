Return-Path: <linux-kernel+bounces-767461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCE8B2549D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BAF5A52CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E12D46D4;
	Wed, 13 Aug 2025 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ll/6m25Q"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5A2FD7DF;
	Wed, 13 Aug 2025 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117680; cv=none; b=dvdpVcrfSjXCUsI2MnSLDA3vuZs+Hop6OKSXYHU/+wARjuAFBVy6yjJDytz0BEzGKzN1oweIpqq9mf+/ZK9oaj6yiqMCEOu6oVv/WPGXtYhzorDUvp4vm5iNvrLP7ORTby+vE2Ce2ll3wIZ+uBcEIol9hW38ass0fNyuIZvFtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117680; c=relaxed/simple;
	bh=/hVnjGurG+wRx78ATz1Xr5RkDjhzM+9y3No+kd5SbZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHcx6RL2FPnE6dIFM22ajur4h+x+8TteLfKhIJSaraoGzNc/rG5FKKhjXTJtGfQcV+t2ijYgqxV3AjIdG66Xmem4mKO9QdkdFLWxB1sycEBavoc7kfT/O85KwbaotQFQLlYMRfCap3OP992HyZk/g+Yz+5Sm6fSd3fS/oduiGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ll/6m25Q; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DKfAQu2154325;
	Wed, 13 Aug 2025 15:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755117670;
	bh=Wdvf/jNhiHmkxjIEZx3swrAG0Wn7qiN5MEB1zX7qGEY=;
	h=From:To:CC:Subject:Date;
	b=ll/6m25QMS4TjdFp35YDDcLZTp3XyH2Z81YAe75gG2palTt5f0IS1JHddm7zpDCQS
	 F3oFkkoOyytR8sNnVWAv1iH+ls1kFtoZwqgRjZqLY1H833Z81joZ8cxmPOZ4JscaOt
	 sOp71q32S4BelEJk7H0MkE36DA6U2uwG3Tm8lf08=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DKfAC71329210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 15:41:10 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 15:41:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 15:41:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DKf9AM2853509;
	Wed, 13 Aug 2025 15:41:09 -0500
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
        Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V2 0/3] drm/bridge: it66121: Add it66122 support
Date: Wed, 13 Aug 2025 15:41:03 -0500
Message-ID: <20250813204106.580141-1-nm@ti.com>
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

Quick boot log on BeaglePlay for compatibility check:
https://gist.github.com/nmenon/6cb8b8a00bcce1755628d131df878840

Changes since V1:
* Picked up Krystoff's binding ack
* Switched over to a vid/pid list

V1: https://lore.kernel.org/all/20250813190835.344563-1-nm@ti.com/

Nishanth Menon (3):
  dt-bindings: display: bridge: it66121: Add compatible string for
    IT66122
  drm/bridge: it66121: Convert the vid/pid entries into a list
  drm/bridge: it66121: Add it66122 support

 .../bindings/display/bridge/ite,it66121.yaml  |  1 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 32 ++++++++++++++-----
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.47.0


