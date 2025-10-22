Return-Path: <linux-kernel+bounces-865161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D7BFC592
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B9580839
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295834AB1D;
	Wed, 22 Oct 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="flPGK7q1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C128347FF6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141110; cv=none; b=Ofzfn6HEZH23ZsOpvZoZ9PygXXy7DYSqQPR8bpZAhaq0l3c43MIKH7uSOe3zu2G9btzQtLUEsAZyzSI1zQjXY1RddB9wD7oA9o3t+vmPq4UuMYii4H1duNwmPhyG9gd4EQua2wt4NVGOEv7Wx2ja4+KrlA8Dr+jzwnoL+hQQoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141110; c=relaxed/simple;
	bh=wZ+o+hwAKnLlNs+A0VYTT8wN6AfjaPJ6mj3D+4Vo+d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvrPNbSfYDsrEITsRd/RlCr8R8/jmOTLgYSw3FIB7owz0tenrU3vTU+LMmu3NylG3ADFNZJhpdRjywqoD6OmPIBsndVbo5smmSFKlNqdPKZ/LDfqFZVqS6tK70JNrdEnLaV4ySX4Aeq31qyUJCX+R+g0Ku6V6nRc2O1ghMfqSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=flPGK7q1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso21299635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761141106; x=1761745906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XurdmkccZ/HxUILJCt4rZndcxIWry1SfSRWQL/ewAlQ=;
        b=flPGK7q1gtIxoJHxvMyryvUieL8cpuymk4qvsSjCkiqQWzw3pdzGa7774HUqkRrKdY
         +sHD2l/crpMLaXo8EiNlqXgw3qAvRbyHu4yMoLIJuAwiALQTmtaU4fD3avzW8LzUFGTD
         4S8a20u+YKLHjqqMabIMX8WucC+GELZH5dcrWvUbizSUGUiKk3kYES11NQuisWIz8var
         rzmsIb0Ad7OZ797mP2E0v8/5bDKp6/F37DcVYUhACTltETJPXNLOIlxLLW+EQTPaonLl
         jB4x9fvrCg4Mz2NQAgt4UtavzumdU8aIL9Lg7928WGoh/QO3dpEtLTHsl2ikvjcrHR6E
         YiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141106; x=1761745906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XurdmkccZ/HxUILJCt4rZndcxIWry1SfSRWQL/ewAlQ=;
        b=iGcJoM07JXnPWaPf3xy1rMGj1R0/l7CuHzAYCTZkHbwtW9UK95RiOPnD9KOKKTn9RO
         vlF5QTuZ3JuPLNVZkidBCHz41a/L6UXC9PMISa6exIh7okYpmEmyyp4DPm1juOpcTrtR
         xwjsoM/DerT6aC59f5Romrs76aDFeELOyoztuGNnLeDZMpZvGpeQIdoxKhcfh0J145O8
         P4O4CU83CDbAU0VQJhFWl/ify3QV8cQQyOXe5IyUNKaqi7GFZFwpwcxEXKu6y8L39G43
         WW/OrbvZsF76ntg47P8VOvUOfJVmLL64gQ7HmmEF/MXELQ9qApnKr2+NERjfS48bGqKB
         QBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJ9Amd+l0kitKlIJbwn0894Ls/Z+srD/+uXskVzSp25BDOIG+g/wdWyahcg6M+G5MbMbf2uc31GYR7BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqC+Zs+77QyKqUDacCPANoMlX9UR9PA79Vs2lNYgZ7Ek3GDIUB
	9aDTDFZReqy/GbX/aM4wlkdEcdK+7nef5/Aydif0sSWOYc43rXybMY79CpLCnSMk5qU=
X-Gm-Gg: ASbGncsjORZFm9zAbH4yHfYcKXV0u157X8Rtdei+cbk+l7K49T5cJYcwZO6cE3w9JWI
	vUl9HOdxclvkrtrE3TQrm32MXIqeabO9NQNZlcAEwsLgd/RqXwwRwOO9I1TrdgLMqvic0BqNduP
	uHGpHsmuUBhtnB979boGf+gli/UD4uShkk+kxMBCfaCu4EiM7irlRQt/GCOplVxae3TYjufMrJI
	I0vetDS+UfGWRUbHvme5dtyR7UAgDymHjoy4iiYzS6SGYRtEYcUq6np/qFex1ZeMNYvwfpQf7bZ
	5GmQQpp+Rue102xJEMKHnY2grkM1iwSX7Es3Teq1eJavbUYfBu1wgXdycB1xaWDl2CvS+gYwj5o
	vQ98ytJNG1zGDpOl9FmKBxVbI+abRiO8KNoIBqF2UGZr7Fm89gztIjXtZiAKTm0OeuO5S4Ht8dW
	ogt6XknRA4z+6biWw=
X-Google-Smtp-Source: AGHT+IHsZ7KZICEtERPW/M6aeAmKp4ZxpzWPoGZkMg4b46VjEQUp923eei/p89+58xNcqQn8+OeSqQ==
X-Received: by 2002:a05:600c:871a:b0:46f:b43a:aeef with SMTP id 5b1f17b1804b1-4711791d923mr127420505e9.38.1761141106480;
        Wed, 22 Oct 2025 06:51:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c2c9dasm38474625e9.4.2025.10.22.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:51:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:51:32 +0200
Subject: [PATCH v2 2/2] reset: remove legacy reset lookup code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-da850-reset-lookup-v2-2-c80f03831f63@linaro.org>
References: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org>
In-Reply-To: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org>
To: David Lechner <david@lechnology.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7207;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Wy6M9Sm8KHFxc4nB1a90t6BthKTqvLVK5O+m0RSU8b0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+OFtZCqOA2nVH3fYnx4YIjHmIE3s6JOUsv4ny
 HDUwStumK+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjhbQAKCRARpy6gFHHX
 cicZEACe8UkAX4MUaTjkwgvn2b7lp8JqF8XQs/wdGRY9vWell7EVWF47AQ0M34giYckjMc/rPDT
 T5E1139YmFvYQ4tfLR0hUGS3bdTijOKwYhLRasy+OIyDputID9qjte3aVRnvALG3AC4WjF2bhww
 Rcs1TGkGif1utRVSYQcuReTE4q9jIhPY34zPeDRZ5sY/K//tbmUl2jFBm3EQlnT9gVAQAlyAk3X
 GzuTaUJ/OYz6s5hSa0OCKGPWcqobFIu7Vv5VunG5HB8M3+0I7jlFvHOsqZz2Mgk77gl3ixNkIBS
 /vRHQVBYdG5oL9FJQj/PgleQVZosXYN9GpkqdK5mwCuIDFMBQmG7beyIVCJgyI2x4XHROr+y4AX
 qA3RUU1oL0h+gGPw+IiZxuJ6MQPMMVz7cQ/SA3xmTBjx5ljPEndn106je18JW3V11QLFlxnl+/e
 PzijwzJdz6jVGuKlAjjQAuwxqQ90xh6pY3fg07mxOIePctzf1IM08Ew8wieovHBqYqSBD3sPEWq
 9tP+bUrr8ncdE5SnYEFy5xG/zc8bzKfCJBNc8+E3q0N7K4aqkjlVYHr30XMKOX1/nrO24EC+QDb
 Gx3JNYWNFDPOAUdsmx1nZoIT1TaOp5CjcCGTqQIRz7LuQ1j3NKj5tRK23X7I8+ttHefiOVtvzru
 CjBpD9xPAOM4mFg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more users of this code. Let's remove the exported symbols
and the implementation from reset core.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c             | 121 +--------------------------------------
 include/linux/reset-controller.h |  33 -----------
 2 files changed, 3 insertions(+), 151 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae531c6efba3ce92cc73a2d57397762..8029e547e3db90ddb85c717dfd735bc8a314dd44 100644
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
@@ -1081,75 +1054,12 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
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
 	bool shared = flags & RESET_CONTROL_FLAGS_BIT_SHARED;
 	bool acquired = flags & RESET_CONTROL_FLAGS_BIT_ACQUIRED;
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 
 	if (WARN_ON(shared && acquired))
 		return ERR_PTR(-EINVAL);
@@ -1157,7 +1067,7 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 	if (dev->of_node)
 		return __of_reset_control_get(dev->of_node, id, index, flags);
 
-	return __reset_control_get_from_lookup(dev, id, flags);
+	return optional ? NULL : ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
@@ -1492,31 +1402,6 @@ devm_reset_control_array_get(struct device *dev, enum reset_control_flags flags)
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
@@ -1530,6 +1415,6 @@ int reset_control_get_count(struct device *dev)
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


