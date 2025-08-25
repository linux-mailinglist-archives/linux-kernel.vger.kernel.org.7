Return-Path: <linux-kernel+bounces-785708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F4B34FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63733AB541
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3462AD00;
	Tue, 26 Aug 2025 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5YVWmrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071E29A2;
	Tue, 26 Aug 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166548; cv=none; b=fF7mefl3jpiBG3KFLHDS/pVllVFDDGdxgJFEDXTAc6XfzNklVFKc2iPAlCFmY7KKdD2G1Dv0jX0pUI8BRxm2ZoXqRsanYht2XVrBBIj+RTSNMX9K+XGWQLsnuMsz7OqZhy1Pof4f4DUWmo/Cx0w94dkcBFywSpLkXC4ccu6pE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166548; c=relaxed/simple;
	bh=Loc5pohHYUjhyJpSTUM6FXiXSt81XFswTcKuhTvLXa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRQjNWGIcOoyEBQ1J86pkLgK/PL/KMDyrvaikZ8vJXsqgpydxRcCYWz3RFzKr0vBF/5IFeJPIubwlkA27ef5pe8+GxfBVDcTdLeadT60on6Bpo3DBn1ZNZuDPEj4DmShoq0S6xjC1aCek7a2PLODPXI6hUYujEuIcIyv58PqOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5YVWmrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D1BC4CEED;
	Tue, 26 Aug 2025 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756166547;
	bh=Loc5pohHYUjhyJpSTUM6FXiXSt81XFswTcKuhTvLXa8=;
	h=From:To:Cc:Subject:Date:From;
	b=r5YVWmrHj7xVjWD6QCu15oSr1HYapHyDPkoDoAyrSIbW4aZJV0odYiTYpxMysfOPP
	 vRW2QdgMnVIQpslTZTitlbRFZZOWTza+NlEDsgyTek9XIwqrAl4jieLUo+JKxQNvu8
	 qLNA+fB1BOBRDz9XxQfD5MA4p9fl6pvs1JRtv0qbPeam8U393A6eifcKlt/HdLzW/h
	 NCxueYoFRsXSOOGO/Q2vkNO7SFf4XoriFJuwOzBFkQoFG4ly6K2NerfNM8n6IG2OBo
	 tFUxhoQuU+yl5fFIUtsfj6nl+hLiVRUIzCiyEih1KXzgXR+HeKr6CrbxKZzJFAqnuk
	 4Ed9VWUXBWv7A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] usb: usb251xb: support usage case without I2C control
Date: Tue, 26 Aug 2025 07:45:06 +0800
Message-ID: <20250825234509.1041-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the usb251xb assumes i2c control. But from HW point of
view, the hub supports usage case without any i2c, we only want the
gpio controls.

Refactor the code so that register writes for configuration are only
performed if the device has a i2c_client provided and also register as
a platform driver. This allows the driver to be used to manage GPIO
based control of the device.

Since v3:
 - collect Reviewed-by tags
 - update commit msg to remove redundant content
 - keep memset of i2c_wb[]

Since v2:
 - add usage example w/o i2c control in dt-binding
 - update commit msg
 - remove of_match_ptr

Since v1:
 - make the modern pm macros usage a separate patch
 - use pm_sleep_ptr instead of pm_ptr for usb251xb_plat_pm_ops, because
   this ops is for PM_SLEEP only.

Jisheng Zhang (3):
  dt-bindings: usb: usb251xb: support usage case without I2C control
  usb: usb251xb: use modern PM macros
  usb: usb251xb: support usage case without I2C control

 .../devicetree/bindings/usb/usb251xb.yaml     |   9 +-
 drivers/usb/misc/usb251xb.c                   | 108 +++++++++++++++---
 2 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.50.0


