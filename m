Return-Path: <linux-kernel+bounces-897700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB33C53A35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E889582B90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A7342514;
	Wed, 12 Nov 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYHJODyi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E82340280
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963575; cv=none; b=s9b/gqvNgH5BcVolVDZ+w1k1DaQiEYb8zTOoyc+Vflg7QLICX47nS0PBxKP57ShVjjZPxpCtGYEP58ChpRZpfbD58jT3koAdl7+lOwNujnz4sw39GZRbZ5SDU7jXGIgdeW5DV7iCPnz1d94/69whhBQmXE1zMK/G7wHGtvhK8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963575; c=relaxed/simple;
	bh=/DmYL+Sj+FG4hqT/OSvBRhos+Di8zc6kpbnkQ+JHZww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jT+Iz4/T2cw1+khbYpyxtSHOcbRMl97S8nv6r1QI8URaR763FAqXWmMF+AF9OKGtXIAFXSj0hpwT4nF+f12oAUrMuPbYahDQsSt1pCxn9ow/vX4uW1zbBtBMwOxXTUloZqHWiYdv0SoX0As5nRerldJdWM6S0QvcYXI5Nj5UsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gYHJODyi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so11097685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762963572; x=1763568372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2s7+BrGGG8vXeljE4273Hpn3eddX5sKox/gHy4ML+U=;
        b=gYHJODyiglh6A5V8J+CA7HNP5Jdx1v/QujrZ+o2HP7c6W2M9V/si4C9DvMde9+dC1O
         8PQLj3FW9qBC2W8F8meZ5RD8kC6wJ5YG1wQ3OWElMJwgGdqI1MIpFsMeLnlFXJ5CZERs
         WbMGK53IGm9cYlgNe95aTP6LPfUR+9rAb/KY6Z6Kvf5oiUzYSe6Sqny+o+px1rxHnSHN
         JtEzYh+uEWVDdVTBTGuBAvDN6SxNfIfzzCTOg0TavNHDWFJ098NuSnyfxyfOH9cCz3bG
         kp3GSyOs5AIcNg8BLU1uVTbKmxoqbI2kE1AbyuP8sbEq2lA7dzkk41Tg9LUz2GmM9iCM
         NCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963572; x=1763568372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R2s7+BrGGG8vXeljE4273Hpn3eddX5sKox/gHy4ML+U=;
        b=RrYIiuw8PQ0kWUZq/T57a8Pz+GLCg7207xvDc39YWRi78nylSq1B2fujJGBQ67JkKy
         sGnv9sOJOmK9gSnlvmb8vFFsP4bNrkMBtHLx+kh9X/Vx0krU/neLjw1OHyEfV+tL85kL
         MPJ/FKKugPFqUE/Dm169BaiBafUrGs2XLJ5xa2DLuyNeHDzV1Ib4E4xA1qswDVZCUIMc
         qY4u33kBMcdn8u+0tTPF4p3NQxUWdzMPWO1efPelcHAys/gmQ/9Rt/i0sgEp0gjmD33j
         TPY5WzLlsMb7RgXiDELgMqyUQAzRLWbmY4PWR8DJy+XZTRx2JS1Uw73Xo2YiHh5ylCqY
         HOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrO4sGfTtt53IVFlKesciEmZh1/8CYDYpN00sCdNLN15qMJUc7znqULX/XDKTAIO++3OxQVq9jt62XwOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlOo8VGleOwLMZ7MxmPRTln9DcXQ7s8UH55he9mSgh4FUPpqT
	5CPwl3USwBZ/CT8dyJ0USNR+OTbLGUcLXQumYdZWsLk4icbBLGEcK8D5fph+8tg6OLQ=
X-Gm-Gg: ASbGncs61mkgu4DvxMavLT8r1L00/i3GJB0SvT+zn/nYMwayrDPxp70nBOt6kAl1J3a
	g+sb70LgVVyjk9EBlD+IKLa1VcuI8hmRUyewodkNox5tcnaPDt8w01U0GVsYrQx+2u1j+sz4/Qy
	R1bSmCP7xmwFvlDVt/0CevxMy3mzq8b9ZfFot56OMzgj5xbvzXkiRxvNoZ8QlU7KiJYTJSbqafr
	ZlXMfnReuE6rMr2RDIc13YCRBOwvokvVq8gDzWZNHCI6OmMUcMdB6PaU0zbAAYdVl7n3w22nB7m
	X8oI/jcmy9YEnLnHeQiqxUYMqAZglJoPesj1+Ld/tSo5z7Xj/ufvXM4FbUMQs/Tp51P5+BVT5Df
	0/sLYs4kS9gwgzmddUv8xm2VO/4ixTomy0zkKdD8G+13myBjif7+5CM1LPS7nSqDRfPTFJzVHn9
	Qrrd4LJQBE1tPuSQGyhqH0isw7kWhEaTY=
X-Google-Smtp-Source: AGHT+IHKHrOdUjXjAels/8ReX0ShDMbuZUygUAhmYWOg3ziJ8hrXgoDI7dWK+HfbhxmbPNnO1otz/Q==
X-Received: by 2002:a05:600c:1391:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-4778707d314mr29493675e9.11.1762963571622;
        Wed, 12 Nov 2025 08:06:11 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm41226855e9.12.2025.11.12.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:06:11 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Nov 2025 16:05:58 +0000
Subject: [PATCH v4 1/2] phy: add new phy_notify_state() api
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-phy-notify-pmstate-v4-1-717d78009d15@linaro.org>
References: <20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org>
In-Reply-To: <20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 kernel-team@android.com, William Mcvicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=/DmYL+Sj+FG4hqT/OSvBRhos+Di8zc6kpbnkQ+JHZww=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpFLBwgvMkGPlXQnGj7GfKo4tBFrDS/Q9ImctC2
 Tm2ORZ0t06JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaRSwcAAKCRDO6LjWAjRy
 uplzD/9HJ7MXRCGkSUZ6+T7w3qXwm7rq5u5AUn7VCR3X0m0loqgOBNiJTmlvB5ct9KPWV1GSgMG
 6ecW7FV1pj/lOXI8QjLy7GzSWcFwFdBgfSmBsC/7g+Vq/BSthcVJu+rTu8lwnLA7vNAUQyCZAAD
 Xr0Zuh/vCm+lUE9mbW8UOC3AUMIHC1IthE8ITWliWfbKfZcil4deKK9mJIYPQTYhzVGfAxqVMae
 i57tRREepnq0aE8nVL2+gIuaN/qq7VxlpP7AdCCmVtK36dwxDXJe+UpynFUgDT8r8gCOEdDluAv
 mW1taJA8xWQtPfKqaR9qbtm54sOliXFmnq9ImhHxKlItHueJKXrRZmD+2hbs0yQ9D6UB/ZehSZa
 l5f04XagJkdEQXcJtQ9kWO/W0t685SDDvSnk3FP/9Zl00BiCM3syKPo42fAuTAu09fT8rVgCszq
 uyG1IoXKEQotqtBwfe+GsBnC/s8b43IjmOqbAWv3YqjF85hXg65XdUUpOfX2DIhY5uBTcgMzM3W
 zbiXl1CKeujw9qkjzz2T8k7KKEnKtPKlC2FygnJD/2F8HlAgFjySHANjgQC+msNOFNDjZJFizfD
 bIbHSFxsyV1A+RmTeNAY5cJbho4VxgPGWIXY4qreNGZ0yfNAlUouqRMrM+DwKTDbpFUqdItEt7i
 a8aIwMqIhgdpiMA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Add a new phy_notify_state() api that notifies and configures a phy for a
given state transition.

This is intended to be used by phy drivers which need to do some runtime
configuration of parameters that can't be handled by phy_calibrate() or
phy_power_{on|off}().

The first usage of this API is in the Samsung UFS phy that needs to issue
some register writes when entering and exiting the hibernate link state.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v4
 - Add missing 'used' word (Vinod)
---
 drivers/phy/phy-core.c  | 25 +++++++++++++++++++++++++
 include/linux/phy/phy.h | 19 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 04a5a34e7a950ae94fae915673c25d476fc071c1..60be8af984bf06649ef00e695d0ed4ced597cdb9 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -520,6 +520,31 @@ int phy_notify_disconnect(struct phy *phy, int port)
 }
 EXPORT_SYMBOL_GPL(phy_notify_disconnect);
 
+/**
+ * phy_notify_state() - phy state notification
+ * @phy: the PHY returned by phy_get()
+ * @state: the PHY state
+ *
+ * Notify the PHY of a state transition. Used to notify and
+ * configure the PHY accordingly.
+ *
+ * Returns: %0 if successful, a negative error code otherwise
+ */
+int phy_notify_state(struct phy *phy, union phy_notify state)
+{
+	int ret;
+
+	if (!phy || !phy->ops->notify_phystate)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->notify_phystate(phy, state);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_notify_state);
+
 /**
  * phy_configure() - Changes the phy parameters
  * @phy: the phy returned by phy_get()
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 13add0c2c40721fe9ca3f0350d13c035cd25af45..664d0864c3a5042949cb121e982368fe0a97827f 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -53,6 +53,15 @@ enum phy_media {
 	PHY_MEDIA_DAC,
 };
 
+enum phy_ufs_state {
+	PHY_UFS_HIBERN8_ENTER,
+	PHY_UFS_HIBERN8_EXIT,
+};
+
+union phy_notify {
+	enum phy_ufs_state ufs_state;
+};
+
 /**
  * union phy_configure_opts - Opaque generic phy configuration
  *
@@ -83,6 +92,7 @@ union phy_configure_opts {
  * @set_speed: set the speed of the phy (optional)
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
+ * @notify_phystate: notify and configure the phy for a particular state
  * @release: ops to be performed while the consumer relinquishes the PHY
  * @owner: the module owner containing the ops
  */
@@ -132,6 +142,7 @@ struct phy_ops {
 	int	(*connect)(struct phy *phy, int port);
 	int	(*disconnect)(struct phy *phy, int port);
 
+	int	(*notify_phystate)(struct phy *phy, union phy_notify state);
 	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
@@ -255,6 +266,7 @@ int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
 int phy_notify_connect(struct phy *phy, int port);
 int phy_notify_disconnect(struct phy *phy, int port);
+int phy_notify_state(struct phy *phy, union phy_notify state);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -412,6 +424,13 @@ static inline int phy_notify_disconnect(struct phy *phy, int index)
 	return -ENOSYS;
 }
 
+static inline int phy_notify_phystate(struct phy *phy, union phy_notify state)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
 static inline int phy_configure(struct phy *phy,
 				union phy_configure_opts *opts)
 {

-- 
2.51.2.1041.gc1ab5b90ca-goog


