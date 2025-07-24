Return-Path: <linux-kernel+bounces-744600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57718B10F14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024B9175260
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA0D2D63F1;
	Thu, 24 Jul 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6nXUH6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A3EACD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372122; cv=none; b=HMZtIT3T80wuJGqf1ScXIbcmxTB5gujxca139mt5/sT40qmwlVqucrxmJ8Npka5DCfuDqWjW42ZIU9ONpuasvHzz+cIePkPuGL4Me31ZJ9zckRS4qNarJzEWBEH5PshSyBVG6iteL/K8b8NYux0i/hhEYYIcKG5UdUthObDB5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372122; c=relaxed/simple;
	bh=E9cWd+56yehgJKY/GSciEMexZ/xXlWXUW6cJwWeuDCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6lajFmEKGm5NM/zEwssYgGPqFjviuTqHSLieEuooIJbdVMthAUQtKpQ2oxsS3cGWhsLvny4X7FX+884GnW4WMMtYzetj6fMDr1wEk15ZwPF28qMSVOWre3fp2FnT6qZhdKOpp7wzyubXv3y2AyJzNfngbsMVH42pnzGeck6ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6nXUH6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEE8C4CEED;
	Thu, 24 Jul 2025 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372121;
	bh=E9cWd+56yehgJKY/GSciEMexZ/xXlWXUW6cJwWeuDCM=;
	h=From:To:Cc:Subject:Date:From;
	b=b6nXUH6cY7SAQnJ2IPceEHNJ0PNktPOb81WmQL3iu2xCje9pPrnUK8vVxZmnSRtXu
	 6wDyqIp9+Mx+Sv/5YYIpdBdBmlxabyVRxHpf6LClPfHtqgiS/+KrDWMMTLiMiF12Gv
	 BIKGHxEvXr4DSFNDm86ncNZ/hiCUwCf14Ud/Aa1+LrKhDcuC+1Xag++KQXqCcxiFWP
	 rRptjkgV9gJsiy104d7kuTfJk3HNas6tT0muTHeHUnGgAVBkItzGWflDUWeR6J/w5C
	 AdYIIX4kqwKwQvckA42VsqVSFqVYp8Cqrk8LHBE8YrXinVCGvH9Ho7C+xfKMNgLETr
	 qZirLkkHV4bOw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBQ-000000004Aq-3Rkt;
	Thu, 24 Jul 2025 17:48:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/11] phy: drop unused module aliases
Date: Thu, 24 Jul 2025 17:48:12 +0200
Message-ID: <20250724154823.15998-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fixing up some device leaks in the TI drivers I noticed that the
commits introducing the leaks had also converted the drivers to only
support OF probe.

This series drops the unused platform module alias from the PHY drivers
that never have supported or no longer supports anything but OF probing.

Johan


Johan Hovold (11):
  phy: broadcom: brcm-sata: drop unused module alias
  phy: broadcom: brcm-usb: drop unused module alias
  phy: cadence: Sierra: drop unused module alias
  phy: hisilicon: hi6220-usb: drop unused module alias
  phy: qualcomm: ipq806x-usb: drop unused module alias
  phy: samsung: exynos5-usbdrd: drop unused module alias
  phy: samsung: usb2: drop unused module alias
  phy: ti: omap-usb2: drop unused module alias
  phy: ti: ti-pipe3: drop unused module alias
  phy: ti: dm816x-usb: drop unused module alias
  phy: ti: omap-control: drop unused module alias

 drivers/phy/broadcom/phy-brcm-sata.c        | 1 -
 drivers/phy/broadcom/phy-brcm-usb.c         | 1 -
 drivers/phy/cadence/phy-cadence-sierra.c    | 1 -
 drivers/phy/hisilicon/phy-hi6220-usb.c      | 1 -
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 1 -
 drivers/phy/samsung/phy-exynos5-usbdrd.c    | 1 -
 drivers/phy/samsung/phy-samsung-usb2.c      | 1 -
 drivers/phy/ti/phy-dm816x-usb.c             | 1 -
 drivers/phy/ti/phy-omap-control.c           | 1 -
 drivers/phy/ti/phy-omap-usb2.c              | 1 -
 drivers/phy/ti/phy-ti-pipe3.c               | 1 -
 11 files changed, 11 deletions(-)

-- 
2.49.1


