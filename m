Return-Path: <linux-kernel+bounces-870392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E942C0A926
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453AB18A13DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD932652AF;
	Sun, 26 Oct 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="WYv4sFCg"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E702255F22;
	Sun, 26 Oct 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761487839; cv=pass; b=QtNBRfKriIYhap28ua7DAu7IlGDAcqRAx483+8teJJ97WRmC3gh13/0tYShGMENtcPQHEVF07+VIDsnE/oqFFr8zJk5W2u9sUf20NuiFIW2tUndIVKwHpOuYYtPAdD0W3vFxQE63d45vzLQJvoOa1x3qmZ5iIR3RSO+CUfA5PRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761487839; c=relaxed/simple;
	bh=1yhYT2z87P1zTkyAheEnTR4QxDASI6qps88CMucuwTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWBk2ZlDF3EIU65MQKIDnFEulj39gGCh2JaIMMxXSI/j5RfgezIznOA/3/46ROrs+O9XOfoCqaJLTQy3GvYDBF89jq+spffGiwQi68N9Qq02xUEOo9oQlOqtXu6nEa96yYUFJPq1YgE4M8m5/2V/iZwjPbyTOaePvJ3qv9U1J1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=WYv4sFCg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1761487825; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SNSTG/WL0hxfvh6+JbR3ZAuSkdWt+cio9bA65lobkpa/qGjFEHCkDUAdILs79iFR9VfDweWvT9W5S4by4ov+WgVYqOsfqsFUJJ3aNXAb8grbvahSASnAubXLhnX2H3VTIyS+sgT4UCkRUJlW1IOHl2WKb6zGP7Da2IoR7IRoHhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761487825; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PCZLoT7Yms1wkMm2rkwrm4xGwAENwGA6Phuef9shGWE=; 
	b=JRcQjj6Ur20sQw9hANHc0N2uf7qcN2mEu+WV62EehqCK3OSbLl61/IVD0SrurJIOFrpo0N2mi4MrdapWIkpm1uyf/nO9i4+mfJh0jA4JGGtYSytljt9KXP2KNP5FtuvTV0bkIwXyrJwdTsPh6ec92L8GlKJS9SZNwd0hX6IG4A4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761487825;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=PCZLoT7Yms1wkMm2rkwrm4xGwAENwGA6Phuef9shGWE=;
	b=WYv4sFCg6aMqKvNY73a3qSEGWprPERCNyttoQq1tsjlOF+R2FOcLDRAlrYHKbmP4
	SHOwJfvdI3YVXUii+p0GYRNlA2ZT2/qonyRUQxHSRHlQyAPNweQKd0OuQmQ0jyX5nKx
	1vQVWhgivK4vk8h7NiWw4NqlxnGWPb+r3OCEkHhw=
Received: by mx.zohomail.com with SMTPS id 1761487822637611.4557356961272;
	Sun, 26 Oct 2025 07:10:22 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sun, 26 Oct 2025 22:00:46 +0800
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for Anlogic DR1V90 SoC
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-dr1v90-cru-v2-6-43b67acd6ddd@pigmoral.tech>
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
In-Reply-To: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761487753; l=759;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=1yhYT2z87P1zTkyAheEnTR4QxDASI6qps88CMucuwTU=;
 b=TdS7HWegtR9pY8oWt0g25hAlBrXuEHWXMGyRZIbKzINBytUo1whGzqPbQgt4Ai8XjJDTY2qqS
 1cI3I+6lA5jB7+96U8vbJS7xxVm84Ij6zpbQSwclTnVNF/nFQeWR9qD
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add myself as maintainer of Anlogic DR1V90 SoC drivers.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..f20d6e91cbbaf711532fd752ee39d156408f21fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1829,6 +1829,13 @@ M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 S:	Supported
 F:	drivers/rtc/rtc-goldfish.c
 
+ANLOGIC DR1V90 SOC DRIVERS
+M:	Junhui Liu <junhui.liu@pigmoral.tech>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+N:	dr1v90
+K:	dr1v90
+
 AOA (Apple Onboard Audio) ALSA DRIVER
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linuxppc-dev@lists.ozlabs.org

-- 
2.51.1


