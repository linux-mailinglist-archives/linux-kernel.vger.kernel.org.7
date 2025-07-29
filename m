Return-Path: <linux-kernel+bounces-749826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C4B15351
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1306E543767
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EA23ABB7;
	Tue, 29 Jul 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="onGhTKcO"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC405290F;
	Tue, 29 Jul 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816597; cv=none; b=g4oW/2puYHDz5MrBC2XkgJiqwWIHVLwDbocpq9aYQX0vehaaHOzM4FaM0iMSEfAzuU8CUcvHEu01ET6MzT+8luf2S630Ckw5McmDAgLtoNElAfgLl1PsX1T8xyN94Un+NyvuY90szvdw+sFuI1QD4BtmJmAoMoIh3BVm73Fxmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816597; c=relaxed/simple;
	bh=HWandojxEP88/Mvy6zHFKRv2PnW5dbqKLagPBjp2p2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U08ipH626riZwkVePEiccu8jv6eXHi8O++AgoEdXmxb0d03s0Z1nTc6PstJNlMY11FBvK6uft4i9wICUH6KvFKWEMj6jPfvotOwi7pRDdM8B69SjmEKkzP5wC/uMkKGgqKdTT0CjvECer5cStGXGyIQ//DH6QHtd81rxlqAa1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=onGhTKcO; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id gpnEuKAvXhl7agpnEuFs9u; Tue, 29 Jul 2025 21:15:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753816521;
	bh=kVABmX+BtOiePTH3OXz4BhV4vXGTNHgUqsYtS3wkQ18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=onGhTKcOrJSWSwIPnznS3eEO+AmSUkC00oTjkU9zlOJwTqBTu8A7UKjcH5mM5pe3P
	 sOG8fwX7Lkmaz+lKnCxrL+VSdnbEu9XP7QWduWI8tZZCnZ3/SC1UqIWOm6rxlJuDT+
	 P+PzzWwWBe8UXHqcXp6cyz/bBQzoqitK1jC8thaRQxvIohwg36LEbL1RRCU/BaNGgg
	 kF0WgYU+NKHAunp+YiUANnfGH6VcPromr0iBUL2aVJ3RNABFniCvrsgPiDb6Y7QHlZ
	 pyi/EM85uDmDTDRPnSS/1VaXLVFkzUceeehEs7lIsprgrbPdlxYqN8E72cDnAPMmYv
	 s1AS/CDYMvGCA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Jul 2025 21:15:21 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] firmware: arm_scmi: Constify struct scmi_voltage_proto_ops
Date: Tue, 29 Jul 2025 21:15:03 +0200
Message-ID: <2091660c072dd2d5599897243a5d69e89d46ed4d.1753816459.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct scmi_voltage_proto_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  13142	   1808	      0	  14950	   3a66	drivers/firmware/arm_scmi/voltage.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  13238	   1712	      0	  14950	   3a66	drivers/firmware/arm_scmi/voltage.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/firmware/arm_scmi/voltage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index fda6a1573609..17127880e10a 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -393,7 +393,7 @@ static int scmi_voltage_domains_num_get(const struct scmi_protocol_handle *ph)
 	return vinfo->num_domains;
 }
 
-static struct scmi_voltage_proto_ops voltage_proto_ops = {
+static const struct scmi_voltage_proto_ops voltage_proto_ops = {
 	.num_domains_get = scmi_voltage_domains_num_get,
 	.info_get = scmi_voltage_info_get,
 	.config_set = scmi_voltage_config_set,
-- 
2.50.1


