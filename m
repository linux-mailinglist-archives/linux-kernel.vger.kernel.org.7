Return-Path: <linux-kernel+bounces-774889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F500B2B8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9352C3B0029
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415143101C2;
	Tue, 19 Aug 2025 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Q+7XebGE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98E3101BD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582143; cv=none; b=Z8+VmcOnpZyp5a3vGWOYkV/uvle/GY29RHJuntCMiAAxtB45FVUx7vtyOw1kUhxWjcz0a9LHsOoltwTXbYVkpfR+exgcHtYNRQSSxO0OXYVeX/Ate2l9qXidlJ3ffHi1JPU5v81yihRpx62cOet5m/M1dlbwEs0ThpcT5MSNjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582143; c=relaxed/simple;
	bh=tW3SGAniASI8s9+kQcRTAqiRLJ4/jHAEEZxh+DdwAcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD55WeGJBHbhqxu5RTA8QT501uCCx4E5xcZxekWg9hKdeoVFcQ6EU/fkwirwGS0p20DvUxvL05A73BRvsYF4Kvf44xbCI9TqJVpjh8sTDQOZdzneqiLQDV0fq8b7ML1kAx33NNg4G4pF26k/bBzxguQwR0Dl62cr0/e2SNiPc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Q+7XebGE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so2543229f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755582140; x=1756186940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq7WIoBPG9xXngCJlnWqUJi/0mB6nKcl5wjr3xJWyLU=;
        b=Q+7XebGEopsTQ9yVMLQUIoRAxQPttLJ/e3SfWs/AtLyZSnciAz9Z9FoT0zjksw84gv
         QehORmwhZnWub5dUnqB4yUrPgk9A0LWa3lQZ4BprAZHZEtf1vmEWA3n/x4Ud7/0QXz2x
         Blb95AvVE0WcnwQOm3Ruq2a9Mu68hirrTGfZdTpkVQldXiyaXX6Ib5hIbnTrLbdWqJUM
         BVmdXzMqo0wVcVJRJ+f3yIVklg/Gow/J2MduWYQ4S3pCGxRLyRVlvm/1UWt8pRDsR1Y9
         2A4lpYo2ZzJ4Yyr3Gnyu7NEe09yF7mn4r9Vj6kVhmnQfioSwZeMEBvdp2121i+yZChPe
         QZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755582140; x=1756186940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq7WIoBPG9xXngCJlnWqUJi/0mB6nKcl5wjr3xJWyLU=;
        b=c6flluLl1tKzMzFT//myi3ho//K4K/ZA+qFcc8TJLCcKrDDN7XQydSvzk88Mrj17tI
         +Q0HvBULQrvuXYIhhxB17Zrz0wHpZAXhEpA7zQXlArpTSbWPLBJYCEABNY6OzLXzKenC
         ijE5XzVBWEgtu6WUKC24cy6Mx/4m+JQ8dBoN9ciKNUxgeHTfUoig5iiKPo2HRPK5RhL5
         UgGWMjNNfWS72As3DsXi9gTGzvYj7XAPP0QAgqV6HTTThN6HY6dvfKPwW9UKZr4MrjSE
         aQ3jz0Eu0XSA1eBYugabblePYP2quLtlGxFKYY+EXFH+/PPQto6n6W7M5l1+FD3IDxjl
         dbPg==
X-Forwarded-Encrypted: i=1; AJvYcCWf9JejY0u8AwooysDnUHrWWpyJDgdF78a3q9jTYdtDe6is5B0eT9CX50eLY2yQhcsK5xNB59RthiYvejo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2ao2JW5mvHY1kwSxDstEjetPS2GIWgQGJpMZ99Dyq7TBN32X
	t9/xK3R1D4yCkaqm9g/1Q5RVSbGHI6X0gXzDyTfPh90vVDtYr6nM3NfGdMtWlcnr934=
X-Gm-Gg: ASbGncug3WZM+8tSo2GzCYWnCSaEJmi4elcKD11qBw86X+XDN3R1bMrq+yrn8eip9wy
	mEor7GBfJxWK4Hmd9x7i2/2t0CVCGo+nUOSBLgPCfTMQWRCxel+FJDldYl5obFyPMLy8YPs5l+N
	U6YAMD/zZS5L8bfGUToUYGvCFm17jHeLxVKrvdPKMZjz1lm56AOU+UFhMLWSt370YqF2lkQ6EFo
	/V3ZhSu0Vhq3sCROCuwyDKo5AYot6ZindBZWIQQt2oz8xGkn+gAiT6RjnMqxAElRZsluZ0y8bjg
	NM0k63EFgTzx+1Oq2KFFUaADDJRrWw5OLTEvZeYUWgs5qPPW/XYnkHcBoUdok2+D9ko7wrvslx6
	NyV6zkwAxMa2vn97mfdbojnrODfwmjYHnk737ybYXHeUt6h7uVprYsT/HDQlZAPgNSYMZy/StS1
	IkZtWyRgs=
X-Google-Smtp-Source: AGHT+IEI8M8CCrxC/o0xmg1e2mN4A1EKk3QdQY2K716FO/HX9J+mbdMcLDKjvGNhAJYIA3Fl3R8Xhw==
X-Received: by 2002:a05:6000:2dc2:b0:3b7:820b:a830 with SMTP id ffacd0b85a97d-3c0eb23340cmr878348f8f.25.1755582140339;
        Mon, 18 Aug 2025 22:42:20 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a9847fsm25097345e9.26.2025.08.18.22.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:42:19 -0700 (PDT)
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
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 2/7] phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()
Date: Tue, 19 Aug 2025 08:42:07 +0300
Message-ID: <20250819054212.486426-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v5:
- none

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


