Return-Path: <linux-kernel+bounces-863068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C1BF6ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 207D54E6073
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5648232E133;
	Tue, 21 Oct 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="namZPUvH"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63A32D446
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055073; cv=none; b=RlVZyVsUOEcsQwXOt1DLZZCaKDG42URifrOLe2CLARhSakDQdUa0z0FQY9Pkh73BWwhmFF3+/AGvhCsChBygaKm1FI+GsExOex+yxepQc2KlBbgwwkUufqutthHrP/G5FH5Xp2j5bZ9J/bVPiq3kdCUdn1Cgrj+1G0tP1WNPdAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055073; c=relaxed/simple;
	bh=ZAcTL8M002zmANHjY3+w3aDIiUrkHrT0rUcV/qO3NhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqEsZYuWlS2bLyIkaCDxHTxrbid9jgCXYdrcOAJQoYPFvZhUTRVcczsOllwPxw5XGDMRvEaKrczLo4Z9esjmCDZExCS/jnGb+1FneYsnyhkNGf2GT7q6NlgVfV/h7LBPNReq+iL4f0GJHg0aX07Rg1tmrlX4cFTI56aaqtJ/q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=namZPUvH; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-794e300e20dso5290314b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761055067; x=1761659867; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wHHLO1nrC9l8QjMvY4cQYnLP8vm7w5UyvMsLKL0imRM=;
        b=namZPUvHqq1pYoky3Ade/LILfQ2QuBwIitbT6T/zB2pDkW32CrzX65LftIPVSou/4s
         BNVUy456g1Jvf24C4wpvpX+6X3gSJUv2cJ7CYtW0Y1REl1e8fugW8Z6oHeH7JcS/1I4p
         Z7CuRU9vCUJq4WK96/XV/RG95/KVUMIQTzrN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055067; x=1761659867;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHHLO1nrC9l8QjMvY4cQYnLP8vm7w5UyvMsLKL0imRM=;
        b=Y6aJ9HjjS+1apE/RlynKQfS5Rwy0DxKSqQfWGJdvRe+P+F0uvbSng+JWzvcgtJyXbb
         fa2CjBd/MxDFJDyUXAdHh70IA86ioAAwAAEKVV2G7ctaOSJk/yB4J/u7o2ZfJOY1TDVw
         naKYqLERjRPX6TG7CRSAechqCHk/oP5ING/GWGTf6Tr6wH+cQoBa/r40YTLvcGR1+J1w
         PS5hiaSXQGqnZXNASY4pUPXrW7tykzPDtwcIEQCjjM/Prb5dPW+2dOrR9T7QxcsK5Iv+
         t1Q1pEhDG0lEFnUltkk+Oij0ixjdFV58Hr9vbX9HkI7DnCOto3TsPZ4QlGSYCO/SChar
         F1YA==
X-Gm-Message-State: AOJu0YxJ53HkbH2lIP5yO6XZ/vroXj4kkY155EQsNfpoTkqUexUP7y8T
	6oH6cb1HRRjS1MA0P+4HWJeXIUAP99hnSyU/xXtvcfQaCiH47TlcaUX/bL2xJelDWoBjdHQCzMn
	KbLtoWhnKxVNzqBUzhDyJgekxE6KNlK1wd2PxNoRvyTGkcMtS2rruj4yC6VFtFTSwYPypTDAlIN
	h92Q==
X-Gm-Gg: ASbGnctovPvC+ADxGC/yM83yVqV5whkNtyJxSBbv5QXJ9TATCXY6BzDeESpVCf1Fw39
	O7olrTX4ByfjLwEQhlYeyJjLT0+VzvmIF8UljRYCC8GVNw/9kh9CFFuFShp+JgeOoxqWpzp3tGx
	t9rjR1ugdn1gMqm74ciVzAY0D+BWqS8gKwFaLlelyCnvF5B9UQeseQZQiNNHY96rUrAY8tqZzlp
	MadwD8V/3LKh/e9qooGYnhnp1FSrCQPoLv4hxgTdBN8jA2kalx9EUmpRUCdepD/L/hiejzRAXZ0
	1g5fbH7XcOJPLIMdwKUuvzprahdoHBdiAZb9zzlXE8i6N3w3uO5Ost+DCR6l8Hz55K+KVY3LVUi
	m++fAb4GZ7QeYyfGNFBvkWdPugvQDRENjen1B+y5csQkrzoE5EtkH1tObFNapkZqMhlWaL3l9V4
	z22Efp+6V9+fMMx/A2QZ8QySaAx2OSNQZb7XwxJMwDQ/zZWbe0hNwvIpaHaytQWaMiD1hFfLr/b
	agVLzfXNaPIODsvLFs4N6d2Cg==
X-Google-Smtp-Source: AGHT+IEpeHvqItbO06cyyRj+gHFpo8k4TbzfikUBGmhMOUd2ZY1YFJSFHFADRKXx/p1Ugpk4KLHF2g==
X-Received: by 2002:a05:6a20:939d:b0:327:957:f915 with SMTP id adf61e73a8af0-334a7930a37mr20691819637.24.1761055066444;
        Tue, 21 Oct 2025 06:57:46 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34ba6sm11475176b3a.18.2025.10.21.06.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:57:46 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Added braces to if conditionals to make it more clearer and to prevent errors
Date: Tue, 21 Oct 2025 19:27:40 +0530
Message-ID: <20251021135740.31874-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 .../marvell/pxa1908-power-controller.c        | 35 ++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drivers/pmdomain/marvell/pxa1908-power-controller.c
index ff5e6e82d3f8..a48f33d07812 100644
--- a/drivers/pmdomain/marvell/pxa1908-power-controller.c
+++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
@@ -73,15 +73,17 @@ static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
 	int ret = 0;
 
 	regmap_set_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
-	if (data->id != PXA1908_POWER_DOMAIN_ISP)
+	if (data->id != PXA1908_POWER_DOMAIN_ISP){
 		regmap_write(ctrl->base, APMU_PWR_BLK_TMR_REG, 0x20001fff);
+	}
 	regmap_set_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
 
 	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
 				       status & data->pwr_state, POWER_POLL_SLEEP_US,
 				       POWER_ON_LATENCY_US + POWER_POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT)
+	if (ret == -ETIMEDOUT){
 		dev_err(ctrl->dev, "timed out powering on domain '%s'\n", pd->genpd.name);
+	}
 
 	return ret;
 }
@@ -169,16 +171,19 @@ static void pxa1908_pd_remove(struct auxiliary_device *auxdev)
 	for (int i = NR_DOMAINS - 1; i >= 0; i--) {
 		pd = &domains[i];
 
-		if (!pd->initialized)
+		if (!pd->initialized){
 			continue;
+		}
 
-		if (pxa1908_pd_is_on(pd) && !pd->data.keep_on)
+		if (pxa1908_pd_is_on(pd) && !pd->data.keep_on){
 			pxa1908_pd_power_off(&pd->genpd);
+		}
 
 		ret = pm_genpd_remove(&pd->genpd);
-		if (ret)
-			dev_err(&auxdev->dev, "failed to remove domain '%s': %d\n",
+		if (ret){
+				dev_err(&auxdev->dev, "failed to remove domain '%s': %d\n",
 				pd->genpd.name, ret);
+		}
 	}
 }
 
@@ -195,9 +200,10 @@ pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, int id, struct device *dev)
 	/* Make sure the state of the hardware is synced with the domain table above. */
 	if (pd->data.keep_on) {
 		ret = pd->genpd.power_on(&pd->genpd);
-		if (ret)
+		if (ret){
 			return dev_err_probe(dev, ret, "failed to power on domain '%s'\n",
 					     pd->genpd.name);
+		}
 	} else {
 		if (pxa1908_pd_is_on(pd)) {
 			dev_warn(dev,
@@ -205,17 +211,19 @@ pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, int id, struct device *dev)
 				 pd->genpd.name);
 
 			ret = pd->genpd.power_off(&pd->genpd);
-			if (ret)
+			if (ret){
 				return dev_err_probe(dev, ret,
 						     "failed to power off domain '%s'\n",
 						     pd->genpd.name);
+			}
 		}
 	}
 
 	ret = pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
-	if (ret)
+	if (ret){
 		return dev_err_probe(dev, ret, "domain '%s' failed to initialize\n",
 				     pd->genpd.name);
+	}
 
 	pd->initialized = true;
 
@@ -230,14 +238,16 @@ pxa1908_pd_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_
 	int ret;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl)
+	if (!ctrl){
 		return -ENOMEM;
+	}
 
 	auxiliary_set_drvdata(auxdev, ctrl);
 
 	ctrl->base = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(ctrl->base))
+	if (IS_ERR(ctrl->base)){
 		return dev_err_probe(dev, PTR_ERR(ctrl->base), "no regmap available\n");
+	}
 
 	ctrl->dev = dev;
 	ctrl->onecell_data.domains = ctrl->domains;
@@ -245,8 +255,9 @@ pxa1908_pd_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_
 
 	for (int i = 0; i < NR_DOMAINS; i++) {
 		ret = pxa1908_pd_init(ctrl, i, dev);
-		if (ret)
+		if (ret){
 			goto err;
+		}
 	}
 
 	return of_genpd_add_provider_onecell(dev->parent->of_node, &ctrl->onecell_data);
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

