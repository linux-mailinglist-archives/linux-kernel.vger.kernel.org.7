Return-Path: <linux-kernel+bounces-660929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E0AC2435
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A9B4E021F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4A2949EE;
	Fri, 23 May 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZ35XNrn"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7ED293B5A
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007646; cv=none; b=unEuFVA79VDou51GfAmcyB+SLk5omuMEmiGmfywbq5KtthFL9XGsfp+wxo8H937Djzp5628/MFzMM4w4Wg0Hf+CojTtgkXhTxldyEV7HA65jKpYjnu5DisI62q0HUTlzwwbQNwDSwaSfQOeMAVtSTsmM3NpLZpMiS/zcp59wcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007646; c=relaxed/simple;
	bh=e1uaiNjXb5C8tSsGtflsn6CSqyt0d458eOACSxErWcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc0eONKLQwPqgRcGw6XX2qZgDRzZvmdmZtpV9TvupSRNORBG/3/pPFxfUnAVi7GPDTH+TPgzC5lKDDrPVjeib+e5eHNGUMIB/HjwwE+LY+rhj6lEc/bzpsZvBm4kuubh0oMrJ2zDBx//31BGSrhXd2zGLlbaMVCOe81Caind1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZ35XNrn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-551f00720cfso7705782e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007642; x=1748612442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YYTvqY48w7pyG/wWiP6f2TlpLJxz1KgObIIkEZbJpM=;
        b=QZ35XNrnV1AD43RI8Xkgnd+WNgIBwW6dinlZ+fDKlrGmhp4bNHNR2dc2nmMQ+GVeGj
         +Hl3OjDcBDkUrm1/XlGKZj2R+aXPnC6SP1hSCF3Ytf/OpixQck//HqQP9VvpLQyjYJm3
         R/uYyM6tDOF6RNJQSGeoJAwJVb2oQ4P/dLdzdKRgL3uz1EiEEFnlXMpSvZ/LWDAwmIfu
         bf729An96AuCcJtCb2CLukYGNPjJMadAI+T1i58qkEpP0v35C0x6jZM5E2drT7quTS3x
         BO+f/vfHYPGFhzPRRaiJ0PV6H8JvWQTKuof/hB7gxSXk1YFc20vsqUKSE5w6bV4Sj+Bd
         dR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007642; x=1748612442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YYTvqY48w7pyG/wWiP6f2TlpLJxz1KgObIIkEZbJpM=;
        b=KJ8PkDkc+qFFP/feMXeFjOAdidzu9XuOLJIcb4dBQFxF1D3C2JBeElgn45iRN28hQP
         Fy8x2PATSzlz2rxHHE4voXcTID8WiKZTaoH49lZ/y69Pvod9MvOIFo6GylOMZP7RKqHN
         EU+ijOo491DOh42dE7BClz6vygoV/lkCh6LbmL5yZAXk88nNB2HRdAbdGaqjcQcpE++O
         lQl+bCHE9TrfzxLqwKNprFUUO4Nxx2+R7+lFsJ6vCsr7Fn2oPzCZqRe0mxxVexpE2sOq
         9dt7tRWHkEiyXXnEF6lnQg+DAcLVxOA99e7J9rfa1rvvvrYlNFtqCzKn/0yrGK8sf0NJ
         2r5g==
X-Forwarded-Encrypted: i=1; AJvYcCW5wxH2miPROEgOY+nxblrGNi403MzpOBss9Ock9RLPOq7S41nGQFtPD3j8j86HeRPXcBNkZbyCmehdL4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+L9EbVb5gz3oNCiOMP9xpYRU1z5SWfCnaGdTkcCkrvF70oEw
	Vt4ONyqD9YXv8duxBSVWEnCqAvm0obeOHXWIRBMcFqXi6lv43n04wUGrlqWSG/zscN4=
X-Gm-Gg: ASbGncuE8C29mU5Hog4IzLP/azdLnz4v0kxHpiq1hflIT4PYZrUOhnnOIqemTt5QdcY
	lqoUnsAzF4qDI39IGZnnB9EH1kLplrN8sjbqNWWoKoCAV2KrQppf0TUxYe9rG08QX43gK0oX3l9
	jJeyAWvQ3wQ346LxBxtkjI2n1W/C1iVy13C1r9YULpW8WjHZBaLtUf+r+6jTsU2cAbYLXSovtxo
	jpbkOYSQ7wgTzcqKcTgpOWb8+gwZAJyv4V44wkhNxNutJRZo5M4mMx16Y2Z5KnaXOCg3DFfartF
	1QJeZeSsLWiTU2D4ExzhxR7pYuo+TMR0/G0NzHPdo9vjGTCHuDFoGPDFHvA5Yf/pVGzmQNInG1A
	oSOB5TQSJ7G6vyxl0DhkzWW5KQ5VZDfRAqVo7
X-Google-Smtp-Source: AGHT+IHOApUdbwQh8Jq2dmZDBk7bs8EbJneQ4drv7VpUV5nFeQnNH0S/KjC5HScjLN7hcK+M6+cnuQ==
X-Received: by 2002:a05:6512:31d2:b0:54f:c3c3:beb8 with SMTP id 2adb3069b0e04-550e7246413mr10436047e87.46.1748007642410;
        Fri, 23 May 2025 06:40:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:41 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/21] pmdomain: core: Add a bus and a driver for genpd providers
Date: Fri, 23 May 2025 15:39:59 +0200
Message-ID: <20250523134025.75130-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we create a genpd via pm_genpd_init() we are initializing a
corresponding struct device for it, but we don't add the device to any
bus_type. It has not really been needed as the device is used as cookie to
help us manage OPP tables.

However, to prepare to make better use of the device let's add a new genpd
provider bus_type and a corresponding genpd provider driver. Subsequent
changes will make use of this.

Suggested-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 89 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9a66b728fbbf..da515350c65b 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -27,6 +27,11 @@
 /* Provides a unique ID for each genpd device */
 static DEFINE_IDA(genpd_ida);
 
+/* The parent for genpd_provider devices. */
+static struct device genpd_provider_bus = {
+	.init_name = "genpd_provider",
+};
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -44,6 +49,14 @@ static DEFINE_IDA(genpd_ida);
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+#define to_genpd_provider_drv(d) container_of(d, struct genpd_provider_drv, drv)
+
+struct genpd_provider_drv {
+	struct device_driver drv;
+	int (*probe)(struct device *dev);
+	void (*remove)(struct device *dev);
+};
+
 struct genpd_lock_ops {
 	void (*lock)(struct generic_pm_domain *genpd);
 	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
@@ -2225,6 +2238,26 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static int genpd_provider_bus_probe(struct device *dev)
+{
+	struct genpd_provider_drv *drv = to_genpd_provider_drv(dev->driver);
+
+	return drv->probe(dev);
+}
+
+static void genpd_provider_bus_remove(struct device *dev)
+{
+	struct genpd_provider_drv *drv = to_genpd_provider_drv(dev->driver);
+
+	drv->remove(dev);
+}
+
+static const struct bus_type genpd_provider_bus_type = {
+	.name		= "genpd_provider",
+	.probe		= genpd_provider_bus_probe,
+	.remove		= genpd_provider_bus_remove,
+};
+
 static void genpd_provider_release(struct device *dev)
 {
 	/* nothing to be done here */
@@ -2262,6 +2295,8 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	genpd->gd = gd;
 	device_initialize(&genpd->dev);
 	genpd->dev.release = genpd_provider_release;
+	genpd->dev.bus = &genpd_provider_bus_type;
+	genpd->dev.parent = &genpd_provider_bus;
 
 	if (!genpd_is_dev_name_fw(genpd)) {
 		dev_set_name(&genpd->dev, "%s", genpd->name);
@@ -3355,9 +3390,61 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+static int genpd_provider_probe(struct device *dev)
+{
+	return 0;
+}
+
+static void genpd_provider_remove(struct device *dev)
+{
+}
+
+static void genpd_provider_sync_state(struct device *dev)
+{
+}
+
+static struct genpd_provider_drv genpd_provider_drv = {
+	.drv = {
+		.name = "genpd_provider",
+		.bus = &genpd_provider_bus_type,
+		.sync_state = genpd_provider_sync_state,
+		.suppress_bind_attrs = true,
+	},
+	.probe = genpd_provider_probe,
+	.remove = genpd_provider_remove,
+};
+
 static int __init genpd_bus_init(void)
 {
-	return bus_register(&genpd_bus_type);
+	int ret;
+
+	ret = device_register(&genpd_provider_bus);
+	if (ret) {
+		put_device(&genpd_provider_bus);
+		return ret;
+	}
+
+	ret = bus_register(&genpd_provider_bus_type);
+	if (ret)
+		goto err_dev;
+
+	ret = bus_register(&genpd_bus_type);
+	if (ret)
+		goto err_prov_bus;
+
+	ret = driver_register(&genpd_provider_drv.drv);
+	if (ret)
+		goto err_bus;
+
+	return 0;
+
+err_bus:
+	bus_unregister(&genpd_bus_type);
+err_prov_bus:
+	bus_unregister(&genpd_provider_bus_type);
+err_dev:
+	device_unregister(&genpd_provider_bus);
+	return ret;
 }
 core_initcall(genpd_bus_init);
 
-- 
2.43.0


