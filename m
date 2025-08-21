Return-Path: <linux-kernel+bounces-780219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C9B2FF32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5E5643BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718234F46E;
	Thu, 21 Aug 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MabXnc5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD782F659B;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=Hf0BTeisPHf1NeS0H5K+0ktLaSRMibd1AF+1+xMvg57Gtd8kWp4rSL24oK0H/a1AYYKhkw4Ycnd7vCzmVD4h5pNElnhTOGWn3FY08aAYFFFi+VB2uBQTeVeyOM3dIcsEJrDV+jqntsAYs32j2YCyQouSuQ6ZOvR0rn+jf/K7Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=YOUvjA7ZxBoWfbdlcJU7aVjGOvnp3BfxTVe9MsnlukQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rL4g2KilW7dHOCnLcy0VfsvjG34ufc3J0K6HF/nxm7TdQD64ksEilvx9k6ekzXXN5TM/0Mt4jI5elb+StA1PuJ9CCPIUVvpkntfLiCii3dDft0431OAuVZZgNBGj8FymiGaCoJ7xTrp2zQwDImrV/EUgh2BMVyaFOpen4PF5tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MabXnc5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3D5C116C6;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790804;
	bh=YOUvjA7ZxBoWfbdlcJU7aVjGOvnp3BfxTVe9MsnlukQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MabXnc5ygb9IfJn05RWLX0FIUPq74OEuDXN4vXihub4HoC8xY4VcP8QsItt24FCkp
	 uQYeHV4kzjtaR3lsEmb+o1+t+LosOW4y5lbveM3GRA437n5/qUf2pFGEuPNsaV0IN8
	 tuxnWIU0MsWIPjQrXfZr7JU4v4D7YpTsPjNgUQXUeyNSjSExtQLpXgiLkbpIq78Eze
	 b6bwvEqAh9zcmK0IH6uEqQCOzQGBuc+81VKeUos0J2OQ/usJkX5pP16Vyt1UVjGCeE
	 /AKlo79zZIuh/o+4D0qQt9YFJfYVop6A4dTb86s5y1tay7nr+yoz2n813Qo/iCY7Po
	 yHJjxt75JBibA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E093CA0EEB;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:39:10 +0000
Subject: [PATCH RFC 18/22] usb: typec: mux: Introduce data_role to mux
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-18-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=JRN0Pkcv1Gw9Rq/i5eF+ACOnqAvxuHK0oC9pDd6cKvY=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy233WGZb7kycy/csIv9MoWLJLr6P0mWfg/jSNDxKST
 q8L0z07SlkYxDgYZMUUWbbvtzd98vCN4NJNl97DzGFlAhnCwMUpABPZOpWRYRk3h9t/k1k257m0
 GFvPl7k9vnvu1M5pF6/eV9nQJnT2WCvD/8ItJ1ynXdys4DJ9nmP53TPh5nHccsFrAx2X+30qdlx
 8mREA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Some muxes may need to know the data role that is being switched to,
such as to direct the data pins to separate host/device controllers or
configure a unified PHY correctly.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 include/linux/usb/typec_mux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 2489a7857d8e10a73450a66ee85b5068f401f047..89b64ed081aecaa70529aaa717579c0dc7a5f961 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -45,6 +45,7 @@ void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
 struct typec_mux_state {
 	struct typec_altmode *alt;
 	unsigned long mode;
+	enum typec_data_role data_role;
 	void *data;
 };
 

-- 
2.34.1



