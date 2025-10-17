Return-Path: <linux-kernel+bounces-857534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C70BE70B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF7625AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3135C26F289;
	Fri, 17 Oct 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QI3LYkqf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E2265292
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688175; cv=none; b=IUiiIITw/KivRIHZe4Bsoe7/MxeZRf3JQDNXZVXafuVBngay7ioKBdYU3Z+qmUWg5vi7aiVk5dGQj+DQN0gUN3cizEDKi83ocoCB6IW+5K2qL2NbMhjwTTK/2XytFH4zGUDT7wPHDb+xxpHe0Mt7ZoGkLbVjLZlMp6x707jXbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688175; c=relaxed/simple;
	bh=BHss4FoO2Qi0SvA29bXFSquG2p3R4Bnd8ZfEOJ8J/48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHaG2qjR2Xuc54Rl7Id3A2CkvLc9a59C0voM3mS/4W9qSBhgwzqEkyp3yoQf5uLLPaNxFhCaNVuKYis0w3iRA+qJUHvWRKdypaiogTHFyZFpmQAQX46tlGlxZ/sA92D+5ykMiSqd5C/KY98y9/1upu1Ugdrt21RPOTIbkC7rDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QI3LYkqf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bca51so1256932f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760688172; x=1761292972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAxSMRXVZPlPv/36eReBoBLx3IDrZODJTLPnejHOYjs=;
        b=QI3LYkqf1evy1hZLcNUlOmXftN9gD02zLR4s59g4xPS5FgoapWx2sSht7w+fkVGdXq
         VgaO9hoO1sJr9y55QmaqjrKSfU+rqsM/WazBW9aDcqScjl0vI+m5CQ8zDWS/hms4TWyn
         z+sCa8iNVtFaBCjioktlMc8opC4Ps4G+MIHaywlRQwp8B6yJUo6e4bgp12P8Abic+cD8
         N7K5i2L8cD/Gthgnbrsa7MGALSEuwEToIA5O9VX7p+ac3r5xmfZB/FXkUyISwmoXhLW0
         i3vU+GFm4CB/xBN8fUnYvckoj6B4NvKjfdyJNFB7DbGuDBz4b3Er8XfUnNA/PlxwLTx3
         CZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688172; x=1761292972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAxSMRXVZPlPv/36eReBoBLx3IDrZODJTLPnejHOYjs=;
        b=nxMTuPSy/viEv7v/ihb3N1idLrrLk0KyfUIvgs00uvOfq/GiP+Zr9HUuNnTA3WmE12
         l5Ohqy/7pb7uk/R2Fj8cUyDY4t59S891eHGKeXm9lg5fXLyKmhY7RP+lDdcDpR9BovJe
         SyqjVmzII78oOlNGnMskihaSQYtHgeelnX/EItilb1Zps54CWhZ3yHpQDvuS+ItrllmZ
         K4loA+sFadc0PKSpBS0ElhNVc7ucXP4A6yNphhQSIZKLhaL0+c/fI55v5Yg5DFet+MKb
         E1xrCIItXy3p+TYREbx2genRaxAMT9VRDiaYtkdu7+zOt2XQWGN7N/KgRZ9tgQ+jWWET
         cOKg==
X-Forwarded-Encrypted: i=1; AJvYcCW2v7KUbboS695gYpLnnLTAKURgfLVn726BacekDBd0Me8PoBFg7bcO5QzjkmZ3fDfdhwR/AtFFmErSghY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDJ7CL2Vx2j7dyTc5Ty1amOfOkHqepsrKPDw7ILNjRUIQbVpS
	pZ5w7W5LHpk/htIik7mRJg1KRAWgfN3k/VxDsb51scy5DUbBsRAVXrm40Ik+dC5fTQQ=
X-Gm-Gg: ASbGncu+AWCzpTNyGG0GaxHiQMyFCDY/xx6cbRV5gG8jh4PR4MQ4aYXywEIrosaODno
	0/79zhn0wreZb7o94ITaB2qKvvbeP4SXW1Xk1VUqi59qAFFYI8eNawruSUE8o9rM7/VsPoLMB2G
	QNTGz818srEDwo/THJlz5y5RJnJAc29MlEnuLRJsbq+GWGnjYhaWocw5EkKMqWhRqb0FPmLrX7w
	NF26ibXsn/SGNEfA4zP/szWZzhB/3+ivpI2N0Sp5qC25V/YtroyhX4ocea/+jAXzvRZnzHkDwu3
	Mfy6JnO0jIU3QRgNmmdwts5GOxHRgsR4wKr+REo/0ovxyB75m56Z0rvQbeRxxdgM84dSqn/QgwX
	z536drJzbRRCptVnRzor+nJtHlCHrbHhmlYHL2NT0LTt8DSpgO4VhC+hU06oMS3qkFCQwxts=
X-Google-Smtp-Source: AGHT+IHvCHZjcj7wi3K1kJaTaFOa1B+LFzitGId9ApKssL7/DI8nCK+H7MZM4mkNZmUXbA7wEjH1aQ==
X-Received: by 2002:a5d:5f82:0:b0:425:86c8:c4ff with SMTP id ffacd0b85a97d-42704d90011mr2229269f8f.22.1760688171765;
        Fri, 17 Oct 2025 01:02:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6c59:a281:27c9:93a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42708bcea1bsm1082308f8f.14.2025.10.17.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:02:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 10:02:42 +0200
Subject: [PATCH 2/2] reset: remove legacy reset lookup code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-da850-reset-lookup-v1-2-362a309a9f09@linaro.org>
References: <20251017-da850-reset-lookup-v1-0-362a309a9f09@linaro.org>
In-Reply-To: <20251017-da850-reset-lookup-v1-0-362a309a9f09@linaro.org>
To: David Lechner <david@lechnology.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6888;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=A2X6FNVmrkD9MIoR5QwN+WAFrugrM3iUCi2XfKX/Rgs=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8fgmUaaxm5mLolw+xBKawAlQ/qYaq0ttSCT3q
 YFt0rYPJ76JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPH4JgAKCRARpy6gFHHX
 clGDEADCA8fWq+VssPhKVjgjOC8Xqdy9nrNm9DnAhZKSvv/wSZ7TCkSqc2eLxMwLgXAMjchQd1H
 hb4W22aIVDhVyrZRU/aG+Q+B046614BepLfGNvosR1gzgMFHe+0KXDeAQaQ4gUaB4sqkMkY2Q6n
 YSWoSy1hKKnJkuZ4//e3Jp2eyBTDz51CcWa6EZTZGeFmWpANL6HH6m65X8AjtOGj2WFmXkACQds
 vOXbECFD+bqPKaJYeWYNxMPBpLZXFe4Gzy8GWKQZe11yGE0j7atG439AENCmvTaKQ+XkGCMDih6
 8oTMmPQwxg/UcRNCe+e3ehVmDGTBMTycPfg+Qpkrro/m/fJFLcbmUEfKBzsfxlW3g59B9QHGTnI
 n+5Fgau1WaAuU95nKKclwL49j6l3/B4th/pBpzDWVLRAPKUBhHr6eBLxwwi8N69gTGNxC4XpOX5
 7DZGlwDVHFiERoyW/wdd1/1lDaAe/rCWuMMsAZpbw+fzqREMeU+oVJelD8evr/V243Rinq0sOfB
 g8t2ZCiKRewjxoZEvXP+8pt29MbpMh0VZVHNVNR0BMX56g387f4MawcLWlNuut8XEaU2BMacsPt
 cc4BmjWVTgYGI9MJckswxLyOjRy6uD0XnPEJROMh4qq8nFLVnt8dhilyQkNC0ao3SEyzpiek1rt
 bcIvB4OSbHScotw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more users of this code. Let's remove the exported symbols
and the implementation from reset core.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c             | 120 +--------------------------------------
 include/linux/reset-controller.h |  33 -----------
 2 files changed, 2 insertions(+), 151 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae531c6efba3ce92cc73a2d57397762..9ca4ac27daf955d7fe74f7684819072a6f32492b 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -190,33 +190,6 @@ int devm_reset_controller_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_reset_controller_register);
 
-/**
- * reset_controller_add_lookup - register a set of lookup entries
- * @lookup: array of reset lookup entries
- * @num_entries: number of entries in the lookup array
- */
-void reset_controller_add_lookup(struct reset_control_lookup *lookup,
-				 unsigned int num_entries)
-{
-	struct reset_control_lookup *entry;
-	unsigned int i;
-
-	mutex_lock(&reset_lookup_mutex);
-	for (i = 0; i < num_entries; i++) {
-		entry = &lookup[i];
-
-		if (!entry->dev_id || !entry->provider) {
-			pr_warn("%s(): reset lookup entry badly specified, skipping\n",
-				__func__);
-			continue;
-		}
-
-		list_add_tail(&entry->list, &reset_lookup_list);
-	}
-	mutex_unlock(&reset_lookup_mutex);
-}
-EXPORT_SYMBOL_GPL(reset_controller_add_lookup);
-
 static inline struct reset_control_array *
 rstc_to_array(struct reset_control *rstc) {
 	return container_of(rstc, struct reset_control_array, base);
@@ -1081,70 +1054,6 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 }
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
-static struct reset_controller_dev *
-__reset_controller_by_name(const char *name)
-{
-	struct reset_controller_dev *rcdev;
-
-	lockdep_assert_held(&reset_list_mutex);
-
-	list_for_each_entry(rcdev, &reset_controller_list, list) {
-		if (!rcdev->dev)
-			continue;
-
-		if (!strcmp(name, dev_name(rcdev->dev)))
-			return rcdev;
-	}
-
-	return NULL;
-}
-
-static struct reset_control *
-__reset_control_get_from_lookup(struct device *dev, const char *con_id,
-				enum reset_control_flags flags)
-{
-	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
-	const struct reset_control_lookup *lookup;
-	struct reset_controller_dev *rcdev;
-	const char *dev_id = dev_name(dev);
-	struct reset_control *rstc = NULL;
-
-	mutex_lock(&reset_lookup_mutex);
-
-	list_for_each_entry(lookup, &reset_lookup_list, list) {
-		if (strcmp(lookup->dev_id, dev_id))
-			continue;
-
-		if ((!con_id && !lookup->con_id) ||
-		    ((con_id && lookup->con_id) &&
-		     !strcmp(con_id, lookup->con_id))) {
-			mutex_lock(&reset_list_mutex);
-			rcdev = __reset_controller_by_name(lookup->provider);
-			if (!rcdev) {
-				mutex_unlock(&reset_list_mutex);
-				mutex_unlock(&reset_lookup_mutex);
-				/* Reset provider may not be ready yet. */
-				return ERR_PTR(-EPROBE_DEFER);
-			}
-
-			flags &= ~RESET_CONTROL_FLAGS_BIT_OPTIONAL;
-
-			rstc = __reset_control_get_internal(rcdev,
-							    lookup->index,
-							    flags);
-			mutex_unlock(&reset_list_mutex);
-			break;
-		}
-	}
-
-	mutex_unlock(&reset_lookup_mutex);
-
-	if (!rstc)
-		return optional ? NULL : ERR_PTR(-ENOENT);
-
-	return rstc;
-}
-
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, enum reset_control_flags flags)
 {
@@ -1157,7 +1066,7 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 	if (dev->of_node)
 		return __of_reset_control_get(dev->of_node, id, index, flags);
 
-	return __reset_control_get_from_lookup(dev, id, flags);
+	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
@@ -1492,31 +1401,6 @@ devm_reset_control_array_get(struct device *dev, enum reset_control_flags flags)
 }
 EXPORT_SYMBOL_GPL(devm_reset_control_array_get);
 
-static int reset_control_get_count_from_lookup(struct device *dev)
-{
-	const struct reset_control_lookup *lookup;
-	const char *dev_id;
-	int count = 0;
-
-	if (!dev)
-		return -EINVAL;
-
-	dev_id = dev_name(dev);
-	mutex_lock(&reset_lookup_mutex);
-
-	list_for_each_entry(lookup, &reset_lookup_list, list) {
-		if (!strcmp(lookup->dev_id, dev_id))
-			count++;
-	}
-
-	mutex_unlock(&reset_lookup_mutex);
-
-	if (count == 0)
-		count = -ENOENT;
-
-	return count;
-}
-
 /**
  * reset_control_get_count - Count number of resets available with a device
  *
@@ -1530,6 +1414,6 @@ int reset_control_get_count(struct device *dev)
 	if (dev->of_node)
 		return of_reset_control_get_count(dev->of_node);
 
-	return reset_control_get_count_from_lookup(dev);
+	return -ENOENT;
 }
 EXPORT_SYMBOL_GPL(reset_control_get_count);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 357df16ede328657478eceb1ba6065f42a210ea2..46514cb1b9e0626872fe71357b24d54ff0e81a8b 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -26,31 +26,6 @@ struct module;
 struct device_node;
 struct of_phandle_args;
 
-/**
- * struct reset_control_lookup - represents a single lookup entry
- *
- * @list: internal list of all reset lookup entries
- * @provider: name of the reset controller device controlling this reset line
- * @index: ID of the reset controller in the reset controller device
- * @dev_id: name of the device associated with this reset line
- * @con_id: name of the reset line (can be NULL)
- */
-struct reset_control_lookup {
-	struct list_head list;
-	const char *provider;
-	unsigned int index;
-	const char *dev_id;
-	const char *con_id;
-};
-
-#define RESET_LOOKUP(_provider, _index, _dev_id, _con_id)		\
-	{								\
-		.provider = _provider,					\
-		.index = _index,					\
-		.dev_id = _dev_id,					\
-		.con_id = _con_id,					\
-	}
-
 /**
  * struct reset_controller_dev - reset controller entity that might
  *                               provide multiple reset controls
@@ -90,9 +65,6 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev);
 struct device;
 int devm_reset_controller_register(struct device *dev,
 				   struct reset_controller_dev *rcdev);
-
-void reset_controller_add_lookup(struct reset_control_lookup *lookup,
-				 unsigned int num_entries);
 #else
 static inline int reset_controller_register(struct reset_controller_dev *rcdev)
 {
@@ -108,11 +80,6 @@ static inline int devm_reset_controller_register(struct device *dev,
 {
 	return 0;
 }
-
-static inline void reset_controller_add_lookup(struct reset_control_lookup *lookup,
-					       unsigned int num_entries)
-{
-}
 #endif
 
 #endif

-- 
2.48.1


