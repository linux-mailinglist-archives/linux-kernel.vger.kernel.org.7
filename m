Return-Path: <linux-kernel+bounces-848265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC9BBCD0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142FB3B8EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7179204C36;
	Fri, 10 Oct 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBbCyWyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A82F0692;
	Fri, 10 Oct 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101874; cv=none; b=eh3UlWEXVthpF8zv/PbEHb6u5aMQ5J/O1t1LZO/LHB1xsuNh1x8g2KZDS6B8mwPDGEex4enB97mlKb/iGrgCFEeI08qd/Eyeopap31hBx/ijacA2lug5jrwMxo08Szt9qEzah5ZjIPKWRGwqW+Z07ywRMjALSt5hIr4oBAoG7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101874; c=relaxed/simple;
	bh=YRfRCQf6n4cPuhCA6MRI2nvKmWxnUc5yTbXXP4MKi2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjaNlkpztG60gs4IPYia9njhazVaqKUbg6jVHbTUheiqRRsAdcEdPq9G3/fzK4piHGWe9TFGPQ/4hzUcOXhDdjQEYvtaYVS9NqnoCsNuwKqHDUBTzhDzsdnyra9ymRWGrjY0bpiA1U1ZgYIY8d1wyiDNrYOXDZz7K4rQTMY7/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBbCyWyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCC3C4CEF1;
	Fri, 10 Oct 2025 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760101874;
	bh=YRfRCQf6n4cPuhCA6MRI2nvKmWxnUc5yTbXXP4MKi2o=;
	h=From:To:Cc:Subject:Date:From;
	b=IBbCyWyIsZkNBuBJNxV7dYZpy8m+sw4mGZZ0mWmDPsjJswFaC+Q8cQsMUty/ksKAd
	 XHqJKuNrsFKH1uoVpQyMF3wTgGqcQvG6dascT8dLUDskwU3wexbcRZhY0+JtjYG+26
	 7oYHaPdC3z4Z6hssUy9tr4UBBWW3CHgakbrdqaA3gDRggSWWUbMxInOQ6tIyJ8j2Ol
	 22rIBOZHHifk6elftPinxZs7zKYHxLP94eG+WXm4asgawhJm9eeGxVLWuKDtLlF2Qh
	 I5QXDpjmQHlsBKlrSu8vTDd3Ns0slcbgV8uURewxeg3J4g7vlLVTDmQeT9/CynPt6x
	 3syrOadEAl/SA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Move DT patchwork to kernel.org
Date: Fri, 10 Oct 2025 08:10:58 -0500
Message-ID: <20251010131058.69778-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ozlabs.org PW instance is slow due to being geographically far away
from any of the maintainers and seems to have gotten slower as of late
(AI scrapers perhaps). The kernel.org PW also has some additional
features (i.e. pwbot) we want to use.

DT core patches also go into PW, so add the PW link for it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c1970f96d99..9ffa6408fa97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18882,6 +18882,7 @@ M:	Rob Herring <robh@kernel.org>
 M:	Saravana Kannan <saravanak@google.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
+Q:	http://patchwork.kernel.org/project/devicetree/list/
 W:	http://www.devicetree.org/
 C:	irc://irc.libera.chat/devicetree
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
@@ -18902,7 +18903,7 @@ M:	Krzysztof Kozlowski <krzk+dt@kernel.org>
 M:	Conor Dooley <conor+dt@kernel.org>
 L:	devicetree@vger.kernel.org
 S:	Maintained
-Q:	http://patchwork.ozlabs.org/project/devicetree-bindings/list/
+Q:	http://patchwork.kernel.org/project/devicetree/list/
 C:	irc://irc.libera.chat/devicetree
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/devicetree/
-- 
2.51.0


