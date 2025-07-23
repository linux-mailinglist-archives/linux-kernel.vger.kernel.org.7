Return-Path: <linux-kernel+bounces-741875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF10B0EA18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AB0560067
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E1238166;
	Wed, 23 Jul 2025 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZRt0Nnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF3523A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248921; cv=none; b=TIHU1bIxMENxcGqWgockAsXg11I/kdrEEiZun8FUjzOn+vCX7JxoBGlEq6ViYcDb0BhV6YEeneC+tAelGhJhBdCRsKXGKeWxhRz522usjJZDNm54ogoG5pHv0jU1+h0LyzZazRqOCxkrW1Ppfw139X3GJZKpHN/kGTog4e7tKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248921; c=relaxed/simple;
	bh=WTpuM/cdSDQcqL8JFZ7izVhbeMLIQNORS/NPD3j0SMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxleKlp/4LOU6Lyyjx4VXDQg18FFwbI1GAeGNPNwk+C0+ROzmzIX8f6zs7tDgGul0q/D5jmEHEBOQNBZ74qeYFpRKgiLTMu+wxBfa2VPPYdyS6vcIkBQwT4XtXdJFwtsSmjstlVHuIBMa4ZJ8IOH310Ckw4CdpeMuqL53Bf1zwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZRt0Nnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9F6C4CEE7;
	Wed, 23 Jul 2025 05:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753248920;
	bh=WTpuM/cdSDQcqL8JFZ7izVhbeMLIQNORS/NPD3j0SMk=;
	h=From:To:Cc:Subject:Date:From;
	b=VZRt0NnfGbsVUTjikN/krsnvaFAhhlEJpRLnt0MEHiJV9cCTCD0DmyauJV3G785H3
	 9vm0dndEabhByY2odTiluklj8ZSb3UDFH14pi9NE7r5Gma/MLeeXmzfYMYqq0pHb0/
	 u8MrN1NwVEZYjseX1hqe3TQbg/GZnxdgHYMlWcV3ekeCUBiVN2PZIEWXf98bKZcVv0
	 nrC+PHI86mqnKrFWJHn0yjAG2QPryyLhIlV5/P4rjeVWLdY9w+q0RTtXsUibo3hKlM
	 /eyBh4wVXFeGpsy6pD+3clvkEamEq92FIhbmeBt84xxkDWdWUAeKjCh8WdCEE6iCcs
	 hAGxcxi3GugCQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: wsa+renesas@sang-engineering.com
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH -resend] misc: ti_fpc202: Switch to of_fwnode_handle()
Date: Wed, 23 Jul 2025 07:35:16 +0200
Message-ID: <20250723053516.1796097-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_node_to_fwnode() is an irqdomain's reimplementation of the
"officially" defined of_fwnode_handle(). The former is in the process of
being removed, so use the latter instead.

This is the last in-tree user.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 1e5c9b1efa1c ("misc: add FPC202 dual port controller driver")
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/misc/ti_fpc202.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ti_fpc202.c b/drivers/misc/ti_fpc202.c
index f84cae50e2c9..0b1a6350c02b 100644
--- a/drivers/misc/ti_fpc202.c
+++ b/drivers/misc/ti_fpc202.c
@@ -281,7 +281,7 @@ static int fpc202_probe_port(struct fpc202_priv *priv, struct device_node *i2c_h
 
 	desc.chan_id = port_id;
 	desc.parent = dev;
-	desc.bus_handle = of_node_to_fwnode(i2c_handle);
+	desc.bus_handle = of_fwnode_handle(i2c_handle);
 	desc.num_aliases = FPC202_ALIASES_PER_PORT;
 
 	fpc202_fill_alias_table(priv->client, aliases, port_id);
-- 
2.50.1


