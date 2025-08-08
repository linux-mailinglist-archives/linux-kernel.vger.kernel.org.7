Return-Path: <linux-kernel+bounces-759763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BDB1E21F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E3580A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25F22D9F7;
	Fri,  8 Aug 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Yxm55OY/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28098224B06
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633910; cv=none; b=WtUpY1veusx6l9iNb5KVAPT/H0+cepS1OLVI7Z/8IFCkwLjlvyD8cbOgeTITaYFWM88JXI6F3cYcdAhZ+BZ8cQlVtZwfzuOd0L8ZJ2rZcoJvnSVmFXO2Ca9VaN38uYi7NdYVDBpb3uAFnDk7YYeJfcbN946VT/Zr8qlW/T5eNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633910; c=relaxed/simple;
	bh=5EMuFxZZvKXeroJTxPHmMFr2FhfaMFLO6e3lqjZrqx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JShV9UvggnhwbiwiGzZiaFvwkbwhR0NLWLbdcItHiUwHc67XiZQ+BnlkQow2q7qDCRWZqmewMpeBPGfvDGjhJ3cw7Cyz2yaw1PjXcoPtw71QfGC/IfZvTqSdOTT4PjbDnjlY63KNQP9BwweWpi0zmYV5+ogx3uE8C6TP56BQiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Yxm55OY/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af925cbd73aso345766366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754633907; x=1755238707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL3e94u2V9QLjXt1P6arYe1Izptm7cDG3511sG7BR2k=;
        b=Yxm55OY/ZednOtaY6ek+wrxnFSpndwufCI186pJ0G7ZNrq0zwlvlcC0vOOiyrAvy6E
         aKuGscHhlbxpTnbYPruC6nxmBdkmFaulCtDKuKQgbSKyCM0DEii9vatUDphYjIG1jNrl
         Fosv/OH6hP0pLwCXaCo/V4EsfgPLrtcO6g6LUhBgaX695kfW+MjkUiRwJWIEij7KFbv4
         iC4zEd26AlNXY+VEACHV7jWMLtyjWe9BnHCGpXbOePLOSoICEKLlgurc/iGTOCljQDpU
         jmXbGUfGwoPV2UloA6M27uZhqT+AHQWXzyufoMTyuwZ6sdOtcXv6GDqEXEp+r4Cal118
         O7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633907; x=1755238707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL3e94u2V9QLjXt1P6arYe1Izptm7cDG3511sG7BR2k=;
        b=NDqYojwuA/0koqYPsHk12MeIVJ6YoFFwx/YttGFKTzn3fwR3BFwSNvCaJ7ZPrOqG7k
         yCgP81jQqACy2iaJ2MUMQU9IkF3MDMA3ePeyKYMlnSoYLjcbAeV5FsfPo7nrNCUCYdvY
         GtgtYcJPuiXaF7gY2EGwW0AG/ucPcTh0H8BD5rqDjBz2AxWnufy5I3gg7hx6IQ9Xnrlk
         aKFezvN9E0y1enPn2XJTTJ6CSi0m+7kJaHfjq0xhltBtOZcS7saGdK1VqjJENAbPaX7R
         z2nWDIkOwjzbEeoyFl+z8CK8YHe4glOCPcv+bWcIFrQmssWOQMYSvOQr3HdSRM6oZOwl
         xI1w==
X-Forwarded-Encrypted: i=1; AJvYcCUa52sRTuTj8c/sQ6bPzRY5jbgojE8RZMwkWXFD3htzV3qzat6654XUg6IrJ366Oqx8pdSUKE3qRm8VD8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0NON3I7lT7EAoyCbSI2ZTnfy/6lV3t3YLtpDiU4VhYVSkIsC
	nBvuEcSD5hyTCYmaYhAyYitNrODQ9/GGT7WU/zIQoUh7LVQSo57jWQbzoxPGVEAXdFA=
X-Gm-Gg: ASbGnctR74t7CndbsJJFDCQf1D/AdD//Rih5epUL2iCqprlP7+IqlW4PkkUqUUewvn4
	S6IRKnE/CQAVpg/DszOcKCtbsJeF4+d5rbKVysU6S32K33AyEZPK0GnUl7J8/hj/1s8Xzdn1b5P
	iAUSuPl5l2McaaZ0MxmXVuyq4og7qpBctxCXS014PEdbiU098mkgG5/5OZ0t4vToeHOnJyW+C12
	dJah4IRGn0smM1XJFdLRK0rPuyNXirCUeQmHYv5yviqvm2tkIvmBG+Jn1+UbwlImAWutfnXqeKL
	JXQX5BLVYcU95xfUYZoqVHEX+WVkdX/s+FjcVSW91flRKgPyoYtLRicKCg7Ya6LunOZIoqo++qV
	YylqqiprHde1Dbvf04yO2CeaXozFmX/1fP/txpWNMEnAjQVCAWRux
X-Google-Smtp-Source: AGHT+IHQTGJ/wmiZp8s/hEwD1TQvz/dSoODt4iFA4o4Riitc+vO+5bZQdHaQm8JOei5Ab1lV1sHSBw==
X-Received: by 2002:a17:907:3da2:b0:af9:5260:9ed3 with SMTP id a640c23a62f3a-af9c642fdddmr146019966b.14.1754633906925;
        Thu, 07 Aug 2025 23:18:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm1440488566b.92.2025.08.07.23.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:18:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 3/8] phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()
Date: Fri,  8 Aug 2025 09:18:01 +0300
Message-ID: <20250808061806.2729274-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If an error occurs after the reset_control_deassert(),
reset_control_assert() must be called, as already done in the remove
function.

Use devm_add_action_or_reset() to add the missing call and simplify the
.remove() function accordingly.

Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to initialize the bus")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: removed "struct reset_control *rstc = data;" from
 rcar_gen3_reset_assert()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- none; this patch is new; re-spinned the Christophe's work at
  https://lore.kernel.org/all/TYCPR01MB113329930BA5E2149C9BE2A1986672@TYCPR01MB11332.jpnprd01.prod.outlook.com/


 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 47beb94cd424..d61c171d454f 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -699,6 +699,11 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
 	return candidate;
 }
 
+static void rcar_gen3_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev = channel->dev;
@@ -717,6 +722,11 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 	if (ret)
 		goto rpm_put;
 
+	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert,
+				       channel->rstc);
+	if (ret)
+		goto rpm_put;
+
 	val = readl(channel->base + USB2_AHB_BUS_CTR);
 	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
 	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
@@ -860,7 +870,6 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
-	reset_control_assert(channel->rstc);
 	pm_runtime_disable(&pdev->dev);
 };
 
-- 
2.43.0


