Return-Path: <linux-kernel+bounces-749827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF754B15353
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BBC5446D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED0254876;
	Tue, 29 Jul 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PYuldCYN"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FD24DD17;
	Tue, 29 Jul 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816601; cv=none; b=qhaB1RRYU1w+2XsuhM3Jgm1nTJn+wGECHiC0CbwHGzqQX2kaWzEmg1S2To5PF+3DBwyQt8rRBVWW/SsrKE5CQxH12W2GB8z8C1L+1xDskoaWKAEqN0VKuvEXId20Kxkcb/1azNgwlQzQVyp/giSZDPF4m5d5bimVv7AOI5vME4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816601; c=relaxed/simple;
	bh=aYlccOx39s/EsBQMr5e6VjgbBdDXQE78ML1Uk6UEMD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/S1PagJSJmki2FjRjQ6CwVylNPX/tNHl+of8qkzNmkZiwQUN6Cp8XPLf79z6OMiSGFV99dgHW/B61JgZ8AjRww6mXBHnPph4ucXxXeA1A4UqhCPrdsgpIoJx/SqVw4J9JUeoOfhcA/cjhjGlEv92yKYcHIyrx5FvqA2d9n491s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PYuldCYN; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id gpnEuKAvXhl7agpnLuFsIM; Tue, 29 Jul 2025 21:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753816527;
	bh=Se0uhC0vl0Ybn7EgV4hvrXEBF1PwoqDdzFk0COuheJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PYuldCYNiaOM9Hi4emoxBXE83nGB2cZRq4w4ZH1B+7L27Rq9fK+C8lgQKB+ZiNwC3
	 12YX6uttYz/Ng07xUTD0oViMvL4lI0tDe64v42MCU2rtQpNedaAhDsWNX3Xt3hZeB/
	 Il6OCags9ImD52owIA2p/H2C3mAi3e7OLKn+TCpptePIVCmbuz3YW1fJx0hoBy/hA7
	 R+jKo7smI3ujcBaJHQbuVYxCeCbyvkZkcOikPnbGv1t2efBCdMxwnzEochzpaN/LAV
	 WPYbtwfFjkUBxuo/zrVHEIdLyk9/GM+jauDgd07BTVrPuBPPSl7gH0QQMjWLiGqCfx
	 ptuPQVw6nbstw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Jul 2025 21:15:27 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] firmware: arm_scmi: Constify struct scmi_transport_ops
Date: Tue, 29 Jul 2025 21:15:04 +0200
Message-ID: <881be6ad61037ed95d5e750a2565fd9840120a08.1753816459.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2091660c072dd2d5599897243a5d69e89d46ed4d.1753816459.git.christophe.jaillet@wanadoo.fr>
References: <2091660c072dd2d5599897243a5d69e89d46ed4d.1753816459.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct scmi_transport_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   6907	    680	     48	   7635	   1dd3	drivers/firmware/arm_scmi/transports/optee.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6987	    576	     48	   7611	   1dbb	drivers/firmware/arm_scmi/transports/optee.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/firmware/arm_scmi/transports/optee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/transports/optee.c b/drivers/firmware/arm_scmi/transports/optee.c
index 3949a877e17d..dc0f46340153 100644
--- a/drivers/firmware/arm_scmi/transports/optee.c
+++ b/drivers/firmware/arm_scmi/transports/optee.c
@@ -498,7 +498,7 @@ static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 	mutex_unlock(&channel->mu);
 }
 
-static struct scmi_transport_ops scmi_optee_ops = {
+static const struct scmi_transport_ops scmi_optee_ops = {
 	.chan_available = scmi_optee_chan_available,
 	.chan_setup = scmi_optee_chan_setup,
 	.chan_free = scmi_optee_chan_free,
-- 
2.50.1


