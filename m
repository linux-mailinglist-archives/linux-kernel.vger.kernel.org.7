Return-Path: <linux-kernel+bounces-817632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C05B584BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC72D3B22E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8631353D;
	Mon, 15 Sep 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDRzj/C8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938D26AD9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961465; cv=none; b=VcJvE6htUQMdfR/jjmx/fHkLGIJyprmFhs5vW8Tw0v3lC6AR4VyOqo5SFig7pZXTwxAtB04m71fCegYTbQcecA8ZRtkir9IJyCNt+QM28BJmBU1GI81nALJyxnpaYN7CDl7l0Kq4NHZs64JMnfRf7cnvYO5zKHEb7Dx8fJkdRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961465; c=relaxed/simple;
	bh=nNyJAqPzUbsMstGn8KK/RzOT1a5rF94uDp1blWPy1lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpDoQSaPLf1D6q/TUgSt4TJU9vRvh3ol1biOTjDufcnN0LrXwXkQQ8y0ghUU+XsdOAEwWGiZzpL7Q0TH+alXYFu7mcn++EtNNG+MPGUrKjgxNo31IAKeJGXOhkJFjvAN1XeWflUM0kuJdGud0FzHzAhO8FlLLKSob8z5nDythg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDRzj/C8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso3654492a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961461; x=1758566261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+49Y+bB3RvywezAkTwvS7iRVhJ0Xt45mru9DJDyH0I4=;
        b=BDRzj/C81+Ih9KJefRLdG2R0UcSsQP4IigNoz4UuB2c9oLwJX44N6WzY9HXr6K3oO3
         vYTABNmaSbgpVu21jiNu2RwmSy6MXFiZjIMb29ESDTQDO7HdPakHnf0ZrTRbjn5esX8b
         CQgezoPvf13eQlA8cctRJ7S6YjbrtFSiLl7aON5VOsi0veUVTc1euTt2P4HXdaQYPgKY
         jm04YaC9/3YYEPKyISmsVSvEstfwIawAcb2I9E0mEXv5XkayMMMdyMP0fCUukRjr/LJS
         5EuOpcf1lXu1LP+R6XzyprUbxY+5bIJLlpW8mwEEp1tfX/jje4zbyoC1Ish93xGjr9dL
         cCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961461; x=1758566261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+49Y+bB3RvywezAkTwvS7iRVhJ0Xt45mru9DJDyH0I4=;
        b=Js1WhJOidp4novhk6NeCsq+gubOEk2MPCEDH6ja7/gtqYUNUkt1l9YpbkHrA3gkksw
         lY1Y9JaKjU+NkkoGIIcDfFZo4AihQ8rAGSCDWZBa1KQpFwFzVl+yPFx6YF/w/m9s5cR5
         jqB1O/dWrhcoZLbc+W2DbvLgpKqs1ei07Ml0Zp58DofGucBorHtpPAs3/7uCNKOBlrWM
         sRBSH5HVXwbZG3J+OQx1eFVFOrMiiApd0fl02ztmkiJjS8Ls4w4waOCCWnuVAIuMK0fQ
         3Eev6PWwC42B201jgDQ6WR2lYgDDp8mPL71ZevxP1kRX6bFred1DD3mbJFs+pumrCU1I
         jl8w==
X-Forwarded-Encrypted: i=1; AJvYcCUxoG1OpAayhjFV3Yj0RttFGI5gKbo8ZPeD9CE7619jDMIHYY0+MfP1nPL1+mIilF3TTMJzVwFKwluOYRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5A5U6HfBrN1rXzIYpcUPn0oe/V1+SQDq+EIDYpfZnK4CZqzl
	cgxmW8IUhPV7K2fE0Ug+gw/Vddv2/JDnieJzNJQbd1czZo++mIrRkEfI
X-Gm-Gg: ASbGncufLbxOLngG+NBUFBpTYrnp//sWQ6MfrHtJSE6+YyddODuQdbrCPpSycZvDoKH
	GKJdwL7RiVex5z7/Ed5X8pF1e2mClV7O0m6Nu/7wwgZV/6gk0F0x8PVzzsN1wVq+Klgsy/L31T4
	AZ4hZemFfCQaFvRTUy+B53dme0QZPUlWY/7BpOQJdFFEXyeRtzXnZGMGYdX8Em5mUhLgZd9Am85
	iX14Q0CtvIi13UnCSDKImz2pxadzd1LGE/wV4gnnnPaqEHHUPI/SzF6D+p65K2ChDNzh0riJGxG
	ly2f5FLUsJ144GMI/TNxwucJBuVARw6yAL/1rkuqfdWJW/bNx0VTNkD9AVGJdDWxwnH5Qvv02A5
	bb+Zpnx3xKj7I4YVl//pTFXf/ek6osP93SYCcwMaYv93gXVA0W4cXk7EQwEV8421B/th634kS14
	xvexbUxBrelqiMtg==
X-Google-Smtp-Source: AGHT+IG0HDooEQiV6aZa1Xu+D32GfMTtE75Na7INqqUdeAb78fEIj6a5Ia+hK7zoxv1DVPrGll47hQ==
X-Received: by 2002:a17:907:7f13:b0:b04:858e:c1ee with SMTP id a640c23a62f3a-b07c3540588mr1496134266b.2.1757961460486;
        Mon, 15 Sep 2025 11:37:40 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07dbf5dbf5sm633180766b.79.2025.09.15.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:40 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/7] spi: keep track of number of chipselects in spi_device
Date: Mon, 15 Sep 2025 20:37:20 +0200
Message-ID: <20250915183725.219473-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several places where we need to iterate over a device's
chipselect. To be able to do it efficiently, store the number of
chipselects in spi_device, like we do for controllers.

Since we now use a device supplied value, add a check to make sure it
isn't more than we can support.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changes v1 -> v2:
* no changes

 drivers/spi/spi.c       | 29 +++++++++++++++++++++--------
 include/linux/spi/spi.h |  4 +++-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b07d6cdf587c..6598fb862d80 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -586,6 +586,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	spi->mode = ctlr->buswidth_override_bits;
+	spi->num_chipselect = 1;
 
 	device_initialize(&spi->dev);
 	return spi;
@@ -635,7 +636,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	u8 idx_new;
 
 	cs = spi_get_chipselect(spi, idx);
-	for (idx_new = new_idx; idx_new < SPI_CS_CNT_MAX; idx_new++) {
+	for (idx_new = new_idx; idx_new < new_spi->num_chipselect; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
 		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
@@ -652,7 +653,7 @@ static int spi_dev_check(struct device *dev, void *data)
 	int status, idx;
 
 	if (spi->controller == new_spi->controller) {
-		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			status = spi_dev_check_cs(dev, spi, idx, new_spi, 0);
 			if (status)
 				return status;
@@ -674,7 +675,13 @@ static int __spi_add_device(struct spi_device *spi)
 	int status, idx;
 	u8 cs;
 
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+	if (spi->num_chipselect > SPI_CS_CNT_MAX) {
+		dev_err(dev, "num_cs %d > max %d\n", spi->num_chipselect,
+			SPI_CS_CNT_MAX);
+		return -EOVERFLOW;
+	}
+
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
 		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
@@ -689,7 +696,7 @@ static int __spi_add_device(struct spi_device *spi)
 	 * For example, spi->chip_select[0] != spi->chip_select[1] and so on.
 	 */
 	if (!spi_controller_is_target(ctlr)) {
-		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			status = spi_dev_check_cs(dev, spi, idx, spi, idx + 1);
 			if (status)
 				return status;
@@ -717,7 +724,7 @@ static int __spi_add_device(struct spi_device *spi)
 	if (ctlr->cs_gpiods) {
 		u8 cs;
 
-		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
 			if (is_valid_cs(cs))
 				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
@@ -1024,7 +1031,7 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 
 /*-------------------------------------------------------------------------*/
 #define spi_for_each_valid_cs(spi, idx)				\
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)		\
+	for (idx = 0; idx < spi->num_chipselect; idx++)		\
 		if (!(spi->cs_index_mask & BIT(idx))) {} else
 
 static inline bool spi_is_last_cs(struct spi_device *spi)
@@ -1080,8 +1087,12 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	trace_spi_set_cs(spi, activate);
 
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : SPI_INVALID_CS;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		if (enable && idx < spi->num_chipselect)
+			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
+		else
+			spi->controller->last_cs[idx] = SPI_INVALID_CS;
+	}
 
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 	if (spi->controller->last_cs_mode_high)
@@ -2452,6 +2463,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
 		return -EINVAL;
 	}
+
+	spi->num_chipselect = rc;
 	for (idx = 0; idx < rc; idx++)
 		spi_set_chipselect(spi, idx, cs[idx]);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e9ea43234d9a..49c048277e97 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -170,6 +170,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	two delays will be added up.
  * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
  *	the corresponding physical CS for logical CS i.
+ * @num_chipselect: Number of physical chipselects used.
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
@@ -229,6 +230,7 @@ struct spi_device {
 	struct spi_delay	cs_inactive;
 
 	u8			chip_select[SPI_CS_CNT_MAX];
+	u8			num_chipselect;
 
 	/*
 	 * Bit mask of the chipselect(s) that the driver need to use from
@@ -315,7 +317,7 @@ static inline bool spi_is_csgpiod(struct spi_device *spi)
 {
 	u8 idx;
 
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		if (spi_get_csgpiod(spi, idx))
 			return true;
 	}
-- 
2.43.0


