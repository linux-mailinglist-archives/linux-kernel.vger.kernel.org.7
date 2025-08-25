Return-Path: <linux-kernel+bounces-784401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA62FB33B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9580200013
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694272BE643;
	Mon, 25 Aug 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufzo9fn0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A926299AB4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114482; cv=none; b=sNEsAlR7JgmBc5PsI4MvOgyZiexKgKtmOutgntS+439Vli7hKERSz+tOy7f0s8SdREgb3lJRWOqzdFhfeeaJ2gj3CF058KkNb7mnQn0tjwnR3BMNfnzEhITlDsphBvskkQBilFI8ygUA0iGyoxmM55NpDleOgh4CDInuOSKygaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114482; c=relaxed/simple;
	bh=DJsq6AtzdFZwSxVpALFJVGeOJOAvbBZhA6DdnM9kylg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YvqM79gt29NC1OrhTum68/97tTqCLsPe9hFHvdac0ZUfkMe2RxTuzKfMHpZguScT7gCK8Iy2TUm95jbykEefJb9tGZEbUUUiJb458FoRzWAZ2+WcaznZSRHn58RYBEAHQs1ShbgyOY+lKUR8vpj977Oys2F7e7jAwP5f7NKVKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufzo9fn0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so33122355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756114479; x=1756719279; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0ekzX7hOfhzup1TYo38EYe+UPAgqh85cgI3qFYsCcU=;
        b=Ufzo9fn0hZI2SBH1/qbUAGuo6jZYmcjPbMRPQ9JLlt3Hi2TXCGUibUu9sacACawMwo
         6hlB8FwjHUPtXxtYOdndYAU8IXxlB0lrHY9t0UNAxCxSdquTv9z3ivFpL6tx4r8D6EqH
         Ro3Jtn5GKK/IQ2g3PKFbo7mG+PREhv9USex0MOOxhDPEfj9k/wcr9VBtc7BWRgncW8y1
         Ms3dvoiCoJ2qpJYTJ7IEX8DbsT+et1LiqjmABHeW+wV+G9bu2udCb0SLKAAGYzUgVz6s
         p21el53ov1rVzPnKat1xWNRIe8QY1XMBmad6ucGIhmTDJAId/+vVv91ispAQ6G6HY21r
         3UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756114479; x=1756719279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0ekzX7hOfhzup1TYo38EYe+UPAgqh85cgI3qFYsCcU=;
        b=di4QKRITSGCzuDdIEFTIByTUbPF6ocSbi55uYVew4UhGyFL/QHUcJ409c3z9bwTSvq
         EZVNzT5cNUXN8bRstgdnoM+UJ+fDVqmHwzYaWyMMUDpQoQyJ99DhgmgUecMIzy1sXbbR
         DPEIH8uKuXjYrLM9Y62TxpuyliWxURgTMiu+f9eFXP5L1i9IyWKMJqt5TVaegg08wJHW
         DxUQTWdFGKQzt6mqGfxv2c2UlW4mdLg61j6atdL2yd8SovAKhxj3dVve2c/JsQxG2oNO
         H2XC+St0WshGH1iOh0f651O3UFP7RWEPFbvVSSVbegX39zYaDs3/fKZcsTIrZiZYN2NY
         07kA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIHtOpz/2JsVhKLaZNG0S03QDAvPi0rRwzW8mHKLVaHqewZqc4cfnz3a3pCEeehQYMcjzWA9uRdEbNIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTItPydXqsFPNW6iAe5v93T4VtMw3d83J3fTSSRuWt3K8ltF+
	c4kFZFGaDcf0DG0/j50oa3lg8ij2lIHT9BI0rcBNPzSB6KXxxZT4t4M5
X-Gm-Gg: ASbGncvkCg7pwfMdrUjq5/iOjJbDTd44b2Y6NcKop7eREGaihBvA4KjAvfJbytCtT5a
	xS9xrqELluKUzlppy+GkRmFqYTULz+Ls1hnDluAgpJFuxsrRju+d9r45YCeeqagCYDg+DMQTFKt
	lz9H1VVV9myiC9bxspr3iQQF9GtaacaI349Dcw7aa2vryp0XoM0zVXa7tIVqTKLbneMxIavLYXC
	3dYtBZd5hlz8jNBBUSH+6mBACchuq6273IUsRMeH0Aj6rW8EVzmn6fF9BEmWes4FHX7z1OK4p4D
	pe+yi4QGUzDUmMZNa1SuY7dwbsC4jptBlxRRCy8tKvtThic3zBsrUgmoYc+NfwmoZ0au1Pp6rGf
	zFNOZJXTXGbSK
X-Google-Smtp-Source: AGHT+IFcndbm4f3NcGG45AtxWvCWfIECRUoVl/7A3Y21V4o4YWwd+7uBs/nxY7ed57LZP0qUl1f1Yw==
X-Received: by 2002:a05:600c:46d3:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-45b517d2ab6mr92679845e9.28.1756114479052;
        Mon, 25 Aug 2025 02:34:39 -0700 (PDT)
Received: from pc ([196.235.191.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753ae41sm101865975e9.9.2025.08.25.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:34:38 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:34:35 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] bus: fsl-mc: Check return value of platform_get_resource()
Message-ID: <aKwuK6TRr5XNYQ8u@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

platform_get_resource() returns NULL in case of failure, so check its
return value and propagate the error in order to prevent NULL pointer
dereference.

Fixes: 6305166c8771 ("bus: fsl-mc: Add ACPI support for fsl-mc")
Cc: <stable@vger.kernel.org>
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
   - Add Fixes and Cc tags, as suggested by Markus Elfring and Christophe
     Leroy.
   - Remove blank line before the if statement, as suggested by Markus
     Elfring.
   - Replace ENODEV with EINVAL, as suggestd by Christophe Leroy.

 drivers/bus/fsl-mc/fsl-mc-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 7671bd158545..cd83cd564736 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1105,6 +1105,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	 * Get physical address of MC portal for the root DPRC:
 	 */
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!plat_res)
+		return -EINVAL;
+
 	mc_portal_phys_addr = plat_res->start;
 	mc_portal_size = resource_size(plat_res);
 	mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
-- 
2.43.0


