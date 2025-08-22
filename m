Return-Path: <linux-kernel+bounces-782427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E563CB32054
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CFD3B4D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE90263F3C;
	Fri, 22 Aug 2025 16:11:43 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278024A076;
	Fri, 22 Aug 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879103; cv=none; b=V5wrXxs8ZVJjabkIu+c1Zc1fVSHTpPCBUn2BLWLVrRbKhXDadJbt6R0tB6Ypp6eVpAkbYUTfk4pvxzILhG7zARxjPXgQlWqE5kgrVykr0mlNFFiRBtngnJ4Z/rrlambpp4NETvlrosPUqDvqszbu/MstDdekwiOLqtBJRClgqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879103; c=relaxed/simple;
	bh=7fEWYxxS9e/HLjVM37+JV+JRgYz12UDQzpgzmP/0et0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fkyQXRskNhkElVIQxAufYE5knlQL86D6ScVwj4YhbcnfUM+nrgmWfqeSR9cV9EJhEtTtGxX8o2K7/EDB4MCqhcuUgUxxXT/OwC5jvrmZ1+nDixuOz++uimN4W0V79ooYs+cL3vJgbAb0sfC5xLbWoBNKBsAjWPVrUlGjhTVKjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upUMN-000000006nQ-06Fd;
	Fri, 22 Aug 2025 16:11:23 +0000
Date: Fri, 22 Aug 2025 17:11:18 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v4 0/7] net: dsa: lantiq_gswip: prepare for
 supporting new features
Message-ID: <cover.1755878232.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for supporting the newer standalone MaxLinear GSW1xx switch
family by refactoring the existing lantiq_gswip driver.
This is the first of a total of 3 series and doesn't yet introduce
any functional changes, but rather just makes the driver more
flexible, so new hardware and features can be supported in future.

This series has been preceded by an RFC series which covers everything
needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
had suggested to start with the 8 patches now submitted as they prepare
but don't yet introduce any functional changes.

Everything has been compile and runtime tested on AVM Fritz!Box 7490
(GSWIP version 2.1, VR9 v1.2)

Link: https://lore.kernel.org/netdev/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/

Daniel Golle (7):
  net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
  net: dsa: lantiq_gswip: prepare for more CPU port options
  net: dsa: lantiq_gswip: move definitions to header
  net: dsa: lantiq_gswip: introduce bitmap for MII ports
  net: dsa: lantiq_gswip: load model-specific microcode
  net: dsa: lantiq_gswip: make DSA tag protocol model-specific
  net: dsa: lantiq_gswip: store switch API version in priv

 drivers/net/dsa/lantiq_gswip.c | 414 ++++++++-------------------------
 drivers/net/dsa/lantiq_gswip.h | 272 ++++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h   |   9 +-
 3 files changed, 375 insertions(+), 320 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq_gswip.h

-- 
2.50.1

