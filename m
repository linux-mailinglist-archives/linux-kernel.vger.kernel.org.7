Return-Path: <linux-kernel+bounces-897739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C1C53AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092C1560E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B60340A73;
	Wed, 12 Nov 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5Z1kt9K"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC233E37B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964839; cv=none; b=IG5dwDrs8cwQMoTwu86q7sgBQkKFMVFovxnKeY59zPC3lhMAPxGvuaEM2GxhC9KGaai5S3mplPuck7i/F/vtO0lH7UKsFrNaQGgPsbw+VthNOROZxlMY+6iJJFiEvKnPsGsoKuXhwYZRzbzS+lUgXlP/pBQXwB2gGs0hwJsGVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964839; c=relaxed/simple;
	bh=DjGwOCNkvyUE4A7k0D/F77jFR+qtAXMy5dKibtq/0dY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riJFWyCzCLKaN2KWixFv98NON/gaI5DcM/h3PVeJFnloB11H6M45s/PJZdkt7cZk52IPWdxDHinqbF2fV34GejhrSM2rCcffRcVJpMj1iFZ/Lkwu7kXzkaHR3MPWxrvC6VCrGeiEKvW1VZFrGVY28jr2Z8N5u5UG4WYDvwYp7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f5Z1kt9K; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632b0621so6998555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762964836; x=1763569636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAKdburdmTrd3xFQbH7tEy2HoAp3nACgzFyFbbo8g0k=;
        b=f5Z1kt9KnT75YgK2WoCTzdf0PMr3ILdccWrrvdeBpopVBTF7IJnSK0JSCpzwZsZlrR
         hDequ/rF1Kg+kcY4qimtwbIytyjAFhaYBj+ecL/dlqgHWvZrbKpesLmyfaYrfULl7+5g
         DqGwxGadq7g02Ftf9whF5rY1tJlkOVQt7Js6762ivQJBg0crPR0laeOHl0TeJdk7jQX/
         pMOFk4xbyKSxgYCL8FF4NVHRyaqEYUak0hmpkQjOluKZmW7mYegWFrbjZhwmEC1nQQYo
         cZCM1hPb4y28o6EcxnmCieAYS/XoMbpV+YJ8uWh77NGNUUTxZKIZG6VzT/5g35awrKeB
         Fmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964836; x=1763569636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dAKdburdmTrd3xFQbH7tEy2HoAp3nACgzFyFbbo8g0k=;
        b=kizNycO9tT85mMr/gw4gVZdhcC7uXfl6LDgLymgr+Ze1RR2sFPx0bQ5iKiP2soiGNc
         uR6unerKJeEIqIjOFpohlfbBgWjYhEuBQ0Hs0slbkffu24V4jr34GvbTQgF5qUXqSH09
         odas7kdzvTmtG/prdvwDuQGoeYelVDlTFVoYT+p+SFssX5HGCeKm6zr9ncusQZunw6Sj
         vG3i7AcY7ElWUjaSKvrbIH5nAKVlpaLw+mBP2FWCYxY/f52fsypIKG3dZlmCzdQ0C00u
         Nl+eVFWWN83ILRbTW4cYcedOb/GsYrS+Rjsc66tCVSv2zMYf6g3tyaD4Ov/HasU4/npO
         IFbg==
X-Forwarded-Encrypted: i=1; AJvYcCXKoKr2qZdopWl/u5OYBKzXnmb/ULMDNJQq0aXdeqx8YpSrNlXbuofpuXpxSkTC+AGzikzKEYNuiA555/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhX3Rp9tpTHahSneXTyxKJdLhAXjRTRweVViSmRstox3bR9mG9
	vrsAR9evZME4eSSbCLM+1iuPte4uYU3CIcQo4GrphkZ0HnkACBHSl/RTTIpcQ/tTRwY=
X-Gm-Gg: ASbGnctlzVIahIST4W1wLD9Mcx7+fLHjGXWwKvhJ/T9pldjeVLEme+xWX9H9g/hcfan
	MY5mXJCMUPUId9AtkPlnRoWVSWeJH8MW0gJiXZZqofvpDlfYsH9um1QC/ZB2wgiEzu4lNosgtJT
	NfnpeKoNXtx3qteMv8NRd9pqJDGYUd+12Y367iO1QdsPo9UlxY805IgrnFjGK+ORYwoOMp89ogY
	DFNnxI148F4LpYU3MhiKGzfelHWJQAH3M3Wde6hO3BRTwfDefuKvEhKftfN+epahtxUDGujc8Y8
	m+uCse11tE04FS6Wi9Ai1zUgSuDMzSXnpd2R/twRZVl6JC0znNIkMT++pxYxTLaTFBTAxHCpQDp
	7d/w/CtaY9Y8nvmY+HtnUEp3sqmQ3BPjNfESOQrg3gxDzNtuDSSzhYaMKutAE+1jzZNzhUBjrzN
	y0CTdl3cSs1Hlt37Dq/VwQVQflRHUPoWg=
X-Google-Smtp-Source: AGHT+IFqo3/svwWqD0iD1WGGUDvvT++y/w5W7U0XhvmlLgCSNPX5h0N4MUoKFDwPP5zIqH55u/pB7w==
X-Received: by 2002:a05:600c:1391:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-4778704d776mr29462015e9.11.1762964835730;
        Wed, 12 Nov 2025 08:27:15 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm48534815e9.5.2025.11.12.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:27:15 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Nov 2025 16:27:06 +0000
Subject: [PATCH v5 1/2] phy: add new phy_notify_state() api
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-phy-notify-pmstate-v5-1-39df622d8fcb@linaro.org>
References: <20251112-phy-notify-pmstate-v5-0-39df622d8fcb@linaro.org>
In-Reply-To: <20251112-phy-notify-pmstate-v5-0-39df622d8fcb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=DjGwOCNkvyUE4A7k0D/F77jFR+qtAXMy5dKibtq/0dY=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpFLVfIqxBioAhOzku1ZwQVC5Gs7ki7qKHySjkQ
 rgVwmlIR3GJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaRS1XwAKCRDO6LjWAjRy
 upF+D/9ff2Zl3hJeeYUtZ+jPkL6DLhM9xU1xU3Yp1gA/XZLtyDMog2pNBCXhej5Tdw+Q92o5GDR
 QMF5/gtbNkazmxrbh3LPUWnP6TjP8Om8E4upWlcRpqmPpYti7vOQlV/w3jwi0SQGEZpd8PHQcii
 PIRLrX3BSPZFxBn/5ahvGrnglnlH1+K5fzllWbM+ZGqI/+lLHBcckfhcwvvbavHWh/jG1Ah0660
 m7tkJYaDpoKvEiIlmveZySppTu+yzR0XtFiR9PiisvGyzjFCfqgCjlubSRtOFQOe8gsDGz5tARP
 0Q6AglGz+P3c+oAwKcYM50L7yvMHmNVZWg4Xmt1I/ISN8v/J4Ot/lPdjvLBdgoVNL4H8+DGxB/j
 QGfIlkkBfdsCW7rcFejNVKFgVwxPA+X+Sz7YazyTgiTmIzHH7J2SYGM3/U0F0yXY5LQRcoCM104
 NQkdY4DlxdVhMWuVi0mbFOk0qHWBQ5gBHc/DtWXBdJj8ks2jk+CW8euND0drJK66DHKDn/NW6ny
 VP2QzrLnb5FXc+T48yA6VjRR0PrH3AHZ6ulxWiFJ4IU36WX/sRCz+xBvyI4oo4zzG3lzJNXxzPO
 O+S88sBnSEcHxXSM01yqY0X3iZ0DRs7Byz0jWYMm7o848Sr+ftCxj51CiCVvfz7PrRyVWo9uEa3
 Tt60bKvKELq+hww==
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
Changes in v5
- Fix typo phy_notify_phystate to phy_notify_state (Russell)

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
index 13add0c2c40721fe9ca3f0350d13c035cd25af45..2af0d01ebb39f27dfb34ccb5140771beef8288d5 100644
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
 
+static inline int phy_notify_state(struct phy *phy, union phy_notify state)
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


