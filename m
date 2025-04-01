Return-Path: <linux-kernel+bounces-583150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C726A77737
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 11:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BEB16A1B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FD1EC011;
	Tue,  1 Apr 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="VHSoDJGB"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3B1EB184
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498415; cv=none; b=o4WdorAF1h7xO2+reJZGjaKojH3FPj1GZ+Rgo/vh5ECfESXCXmfhllcnG/kL50NFPiYxgXbJ9YnDYiGXyW6os2mYaAr/xM0by/dmt+y/O/eKALbYUSIafKl306LKYXcsajlMdOS56hudVZoEtsqJXCLq8V/tph9xnePV4/fIrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498415; c=relaxed/simple;
	bh=kKr/tIt2LCEu9owDBfn3bQojzZ0WnrYrGhqQqPDytWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzEK63lQKqv0uLtbio7sUt1bCpI+riOJlIo1UntOaYFtJBpxpxIJO+PLgrC073eVuS4HYhYX70wRE9s/sTa2DS8rl+59xLNmA/lFVf5Q7FPz+T5Xm4Iwil96IU+SP7Y68wsM6IRMb8grzUzGvNxAryuqNwT3aUIFx9Mf2DYTCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=VHSoDJGB; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250401090647c4296a87fa35f2cbfa
        for <linux-kernel@vger.kernel.org>;
        Tue, 01 Apr 2025 11:06:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WL92Zqa9pFjA8RNRarusWwAsiJfwqAlo3KLnH3r3wI0=;
 b=VHSoDJGBuAminTb59v2NFyXwPHMG5YDp8mtNd9BQeOTZqNfoqD7VgqHHN52gy0fIucDJrE
 E/UzAfGa4PDpaksnwnZ2DjnDpL8Ix6n0xzD0azh/fzqz0nvxybrQpQ9sTqGrPkld1f26SxhZ
 yXV1i2g/toTcBgqw0JEK72qxxuSRQJtma8zMyt9Xx0D9aVj7OCKbP/1oLyzFBXgBjKZ5mN3W
 vHrFwV4v2k0a0naQb09w90WiYxRqMQT+jk4Grt3ilbwWdd/9vJbNieWGvdii+dtkLzVTt6Jn
 jzZN3d2nt5/evXvGbQ1Wglq0LIY6pdtDOX6L1z1YQ115f0YEBjr7IMWw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"
Date: Tue,  1 Apr 2025 11:06:34 +0200
Message-ID: <20250401090643.2776793-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

This reverts commit 4700a00755fb5a4bb5109128297d6fd2d1272ee6.

It breaks target-module@2b300050 ("ti,sysc-omap2") probe on AM62x in a case
when minimally-configured system tries to network-boot:

[    6.888776] probe of 2b300050.target-module returned 517 after 258 usecs
[   17.129637] probe of 2b300050.target-module returned 517 after 708 usecs
[   17.137397] platform 2b300050.target-module: deferred probe pending: (reason unknown)
[   26.878471] Waiting up to 100 more seconds for network.

There are minimal configurations possible when the deferred device is not
being probed any more (because everything else has been successfully
probed) and deferral lists are not processed any more.

Stable mmc enumeration can be achieved by filling /aliases node properly
(4700a00755fb commit's rationale).

After revert:

[    9.006816] IP-Config: Complete:
[    9.010058]      device=lan0, ...

Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04, Panda, BT200
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v2: Massaged the commit message.

 drivers/bus/ti-sysc.c | 49 -------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index f67b927ae4caa..e5c02e950f2c1 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -677,51 +677,6 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	return 0;
 }
 
-/* Interconnect instances to probe before l4_per instances */
-static struct resource early_bus_ranges[] = {
-	/* am3/4 l4_wkup */
-	{ .start = 0x44c00000, .end = 0x44c00000 + 0x300000, },
-	/* omap4/5 and dra7 l4_cfg */
-	{ .start = 0x4a000000, .end = 0x4a000000 + 0x300000, },
-	/* omap4 l4_wkup */
-	{ .start = 0x4a300000, .end = 0x4a300000 + 0x30000,  },
-	/* omap5 and dra7 l4_wkup without dra7 dcan segment */
-	{ .start = 0x4ae00000, .end = 0x4ae00000 + 0x30000,  },
-};
-
-static atomic_t sysc_defer = ATOMIC_INIT(10);
-
-/**
- * sysc_defer_non_critical - defer non_critical interconnect probing
- * @ddata: device driver data
- *
- * We want to probe l4_cfg and l4_wkup interconnect instances before any
- * l4_per instances as l4_per instances depend on resources on l4_cfg and
- * l4_wkup interconnects.
- */
-static int sysc_defer_non_critical(struct sysc *ddata)
-{
-	struct resource *res;
-	int i;
-
-	if (!atomic_read(&sysc_defer))
-		return 0;
-
-	for (i = 0; i < ARRAY_SIZE(early_bus_ranges); i++) {
-		res = &early_bus_ranges[i];
-		if (ddata->module_pa >= res->start &&
-		    ddata->module_pa <= res->end) {
-			atomic_set(&sysc_defer, 0);
-
-			return 0;
-		}
-	}
-
-	atomic_dec_if_positive(&sysc_defer);
-
-	return -EPROBE_DEFER;
-}
-
 static struct device_node *stdout_path;
 
 static void sysc_init_stdout_path(struct sysc *ddata)
@@ -947,10 +902,6 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 	if (error)
 		return error;
 
-	error = sysc_defer_non_critical(ddata);
-	if (error)
-		return error;
-
 	sysc_check_children(ddata);
 
 	if (!of_property_present(np, "reg"))
-- 
2.48.1


