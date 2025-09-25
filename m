Return-Path: <linux-kernel+bounces-832722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D2BA0295
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244DE188FF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B76305058;
	Thu, 25 Sep 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSd9K53u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94782313E36
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812716; cv=none; b=p4iisCGAHRFq0Hmc3ZXQaYKImWYy7PdtqG4ljLQlINQdG9B0V5oGGK/YVl5aZSivQxLizPqlM+sVGVcZqlGfx3vhAwSvUA1SCy2Bx3HKcaZVD0F83+jFx8RZmoz+yO4uQMgfdq3CNb9Rez6I1DcM1GyOc7Xqu+6lZ+pUbVPuIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812716; c=relaxed/simple;
	bh=L7+MLZXUn4s2xKeCLN14iKRnmZ1hd+qPub/czGy8+3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcSn4vx0cIqDVZu2t8nzyLGF15QYcr9bpzmNeUykDfUdIzAi9+R7elZOmlO/Q+Wh09it9sGoI64aWNMkyEzMhL8jd7Wn/bXHfxra60HHFwxY4WNDbXF1xHQ+xNwXhKHmUYNEu6hC3DT4dNdK+LfMQEhlljkgE4Y/lJXDQnRJCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSd9K53u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31002C4CEF7;
	Thu, 25 Sep 2025 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758812716;
	bh=L7+MLZXUn4s2xKeCLN14iKRnmZ1hd+qPub/czGy8+3M=;
	h=From:To:Cc:Subject:Date:From;
	b=JSd9K53unPRPQ1SyuCilv7V2WvG8/eMFB18vBr/RN1wXdzQkegeyqBoEVE3ZvGZwb
	 Zjw7Px5rBmAtvLssQjH1TwiqwZwwC9AB3pwTfSNJESxW60xbc+xaiBlHhb2jnpSSrW
	 RA9cs+UmUIGqVNjbJtiFmpdQMxiThZ5B33edcp/3L7GIqKn1a3kDvKM5efFamjSYGw
	 9mMOM+1LnPQEcAX5aTAL9g1D9/uF634gnCyxvGcck+YC5Ssmer2CWTGSjPpoqm0zV8
	 Rf8wOOiaHOLg0WriaQVKKGYsTpSAqgIzXnmDn+J0ub7/ci4Vt5OA9AvMaLG/x3qeNx
	 8GqQNNf2FP4dQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1nWv-000000006Ur-0NXp;
	Thu, 25 Sep 2025 17:05:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] mfd: altera-sysmgr: enable compile testing
Date: Thu, 25 Sep 2025 17:05:04 +0200
Message-ID: <20250925150504.24955-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing seems to prevent this driver from being compile tested so allow
that.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c1b58181f79..aa950b0cfda3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -45,7 +45,8 @@ config MFD_ALTERA_A10SR
 
 config MFD_ALTERA_SYSMGR
 	bool "Altera SOCFPGA System Manager"
-	depends on ARCH_INTEL_SOCFPGA && OF
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	depends on OF
 	select MFD_SYSCON
 	help
 	  Select this to get System Manager support for all Altera branded
-- 
2.49.1


