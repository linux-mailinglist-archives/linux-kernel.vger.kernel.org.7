Return-Path: <linux-kernel+bounces-609236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FB6A91F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD047A30F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68217253B72;
	Thu, 17 Apr 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSz5gDD/"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D277253B46
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899951; cv=none; b=MbETCgRsNtSyfFytSyxsnSGTaBRjk6BPgTivLZ8Grr8w16VcxsU5PGmiPl50IxlLjJwdVYfaMnIMs9zgHWWWBdwU7HJvo0mhimnK47RnFZ83DG+4HfZg44FsmUuS905aa5nfTiPEAQQ7P5xLYcLnn5S1CEt6mYAxiv5njWq9xlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899951; c=relaxed/simple;
	bh=qufReoonGhxKbTrj9KGiMOUNKUggmPheexh2sLrPrQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6y5tZe68a3o6SKg/lpN0rLJ/ekcHrOqhpl4a2BehKzEiQkm1LjkC++Z5RS2pTll8Neb/5ZCzLJGUDhfPczqPQfOxmPUawo1IoqtF9WqtX9AWxNWsEnJiqLPA9J+6o1kLitNCR9UeZi2Ek5VIVvhFH1g+1NjS4FAWuVAoWZA9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSz5gDD/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54af20849adso887787e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899948; x=1745504748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TjEcikoo6DSPkHDkOpmkpqUSlM//3uPYTFXI+t8fY4=;
        b=XSz5gDD/eUy8E/wN11YQasrdC1RN+9ZKaKBcYBaZ6C7i9QXro9HpQuHKGLRWYgLZSw
         we9J3j0MDCm2LrACBdpt0aMiOTlNXLkAENzuZnBoLBiptBBapXMSCgZ7IEo2RBlbrLdv
         lrpY++ZDI8Mahsmmb8MIGUTi/POrNH4Z1oyPtvZtfZ+PFmmkzolO0m6B8kGjqE1B6njb
         drljXOdtTdaTEvy+zdFi9g78la7Ia+IMzHgC1qG1H9F6ihJ/Ugk6QFDdKyWK0dG5susi
         OBk9Qre87MI8n0tMIHYtebv9X65Ti6fvJyq3Gnf/8LD6dbcA7h/324yhajRF8SaNQ0VU
         yFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899948; x=1745504748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TjEcikoo6DSPkHDkOpmkpqUSlM//3uPYTFXI+t8fY4=;
        b=oyN+CjnLGJfdef/EhA5sXf59TtD1iYptf/lRfmMEYqPRhAqEyHBkwe5Tb28u7gy6Cx
         kURxMPeNeWcdaXjn8ZIWc8N5hzpsmRCpxd3optxhrJAaJ0+wS7SXUPg6cgtFWBq22ACQ
         pOgWYHGBZTSxKDOstg1l30RTkV67p9zizmeBTcbWbFKbUxLiouhrlx8KWW9V2c27/bO/
         D/CXSEuFG3YY1S2ALgpesOtCOTzUF6cPd5UF7q5wPD11axc8u0IwcCr/2U69HVoZbKGu
         Ezd+TTO1OOPkRRjmK91VuQTkX3pAJWosWmf84xZTwoH9cUFHHjpcSCo7HTVcyfZV/p7H
         33lg==
X-Forwarded-Encrypted: i=1; AJvYcCV6aOwgOx0agq9Sh/pSveYtxihz5qClR2CWTnWn1etiid6Ic9MzZ6G6z6QlsB7rrNxq16akxZOgdaDC+UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwI6PPuf0ndpeWrrRn8LszbekDnRadrsslMC7inaMovONJpiRI
	IY8CXKZ+fyEQ44hXJJadhhdF+MN0FTAW+/N6OeqZUsPxxqtreXZHgf9xLma1lbc=
X-Gm-Gg: ASbGncvC64SrqErQkOXMuSRq/rHKgSAMnS8iYeVvV/7K35q1WY06wZg8R6eOPvyBv97
	bwMTkW+CrxiMdTC5SF5tMJOxlPoGR+c2BrSAZi0Lf03nfWeeBudqVwpPp5OjNCEAT1UgO0jmoVE
	eOkhriEvFLdue8D8m5saH8sWPZ478ChQHzQpFldwtigxW+uZVI7Iyd/ypGaJdvm5Q9nED4XS9Aj
	6Bkw71HMcgBmOyx6j/TmrbR654rCB1uFrYgbu55DFptGH5Hw6AEZwJtkYnMi457aw8DHkgQZKvY
	ISPqWZ3QBzug4qoY6eBqhRdWFEbprMc9uq16J/Y8uGqJ5t8VChDtyXrybTcUsrKK1h3qJ5igIcF
	kb9VwwRu0qb/wNRk=
X-Google-Smtp-Source: AGHT+IHqso8NP2mkjGd2codcc9AYXMx3rITJMfiumhfwHLFCKjgzoXmRta3CnFxIynd4smfXKHkXFg==
X-Received: by 2002:a05:6512:3e01:b0:54b:117f:686f with SMTP id 2adb3069b0e04-54d6dc1df78mr5182e87.28.1744899948235;
        Thu, 17 Apr 2025 07:25:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] pmdomain: core: Default to use of_genpd_sync_state() for genpd providers
Date: Thu, 17 Apr 2025 16:25:08 +0200
Message-ID: <20250417142513.312939-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless the typical platform driver that act as genpd provider, has its own
->sync_state() callback implemented let's default to use
of_genpd_sync_state().

More precisely, while adding a genpd OF provider let's assign the
->sync_state() callback, in case the fwnode has a device and its driver/bus
doesn't have the ->sync_state() set already. In this way the typical
platform driver doesn't need to assign ->sync_state(), unless it has some
additional things to manage beyond genpds.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9c5a77bf59d2..695d7d9e5582 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2671,6 +2671,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	if (!dev)
 		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
+	else if (!dev_has_sync_state(dev))
+		dev_set_drv_sync_state(dev, of_genpd_sync_state);
 
 	device_set_node(&genpd->dev, fwnode);
 
@@ -2740,6 +2742,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 	if (!dev)
 		sync_state = true;
+	else if (!dev_has_sync_state(dev))
+		dev_set_drv_sync_state(dev, of_genpd_sync_state);
 
 	for (i = 0; i < data->num_domains; i++) {
 		genpd = data->domains[i];
-- 
2.43.0


