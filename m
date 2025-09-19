Return-Path: <linux-kernel+bounces-824994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01622B8AA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C641CC3F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A175321260;
	Fri, 19 Sep 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChXCuJeX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6A22A4F1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301027; cv=none; b=t8l2UEXqmj8Qb+vymDH7c7U3++48o7F6J7E2afX2Ys4fDM1vODVTabGhBSI3/S9561LAjZncYU1veUdzlLdnryPGs+3uXLC0VqDLMCXRET6LvuxYzhE7NIr7vtUKg/9yjiPNGyQL+mjc4yOsHSOD1YnAsP3AR6vtF9rBZsvTnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301027; c=relaxed/simple;
	bh=7XTOh57VEkTeSyA7TZkjr8pxdTNTa0H6p/lmmQoFBJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5z8syucJMdkiqLnUji74l3rXwYpAiv11CH/dv5CpWUkp+1SixTZdWBcxwGO2AM/GeQ+fd1I6xs6zWrpAN7EQHtjfBjDyva4ize9xjFB4MH+eNVthmd8tCYk6SEeTR6iOuq4UFSK9oiyhwhSZBRigA+XOgzEgTejjnr7UN2hrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChXCuJeX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf6058aso30767155ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758301025; x=1758905825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TftbRKt7nat2IQL5KZaz5H5oFD7jsz+Ow/tM+X9VXHU=;
        b=ChXCuJeXJpYe3wSOVf/pf2nlLFoysKzUPYbDo3NQZiqxnD4zOFxBLA4pkkGYeonFoC
         Fiy0ELNrFWgPkEP0P/YatzfBjVP4tTGa2rUTsgoSAAMB1gmPdCLK/uuHI7pkN5/Pvq9R
         6kcDToFe2xgMh9DTyjcBYkjAs8DGnOWRb3XfgUIqHls7QQMaLiT0lYAMikKUeNKy0kAt
         SxvDuRbQGgDoUi1LIFf1M6zRJKsxFqsxocrDxZ0pFCQmSGYwJVNPWhUFvDs/Ryu2dHQJ
         wF2Jq5H4YAwMdisb80qHQxMpZU2g2X0Ec9i0sZu82aGorkvSBNsDoJGmUFjTR9Tfp5h1
         s4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301025; x=1758905825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TftbRKt7nat2IQL5KZaz5H5oFD7jsz+Ow/tM+X9VXHU=;
        b=en5H6RDV2XGmxQtaaS6WGcWrybtS3AWw7PJ58VLqVZLDf8FOGr67lQRmtndhGRma2a
         G4WkJErFwEXymvNwTC6oWRQSL/AesPBsjzW/32oMQBdphur78lZ193Yj84CgPUDTf/uO
         W5MYTDKoJmk8UUxMnwcZXEPRMiK7MH1KsKpGkBWQUcCHEjRIracmywgDHQpfFej6ty2Z
         MNPnAXiD2g3jqLO33zKFHzjd7W8+qiVrhp7FsUbmk+Gr8YdZsZWIuibobrW/4poF27wt
         yJu5rDXW/a2nHvplYlOKf1HAJPzwJ7pNJ1u31psj/dl9raOavlhk0qZvVfqoqmprIXhh
         oMsA==
X-Forwarded-Encrypted: i=1; AJvYcCVjgNB9vbhIqApJ2bO5A1OZVp1YH9fdOpq0gC1YR5Q1iZ/OeN15wxp5JW/30CncaMRChnEM8kQ0I+R/Cxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjiwrhLWJ5ycReRNmuaux2kTU5RmS4wtUAqThCK6pTCU2r7TNQ
	Ca1Nbi+db5ls3aVIV1m4KMPUc5VLl55PoKtd2HY104pcfORoY4hF9F5R
X-Gm-Gg: ASbGnct4Fdq2JCidXkRK4i5L5IQh2VOtDEA9iVlsHdT1zEdzXkSXnkIu97y497kPrOe
	1wOdTYxwXCosF8Y2YR7XUPOGyCD5jNFdTpPndUyDnxlG9DJDfPJFqePVa6vdkVrSLO+/4Pfeo+z
	t5ZPPJ0K4zzPIg1dn8IVOoWCZZvkbFGAgaIJeRB9SDE+sP/OY/LeUr1n38rA7anr6esa2p7b/ZK
	ksgAVwSTxjX2eFIK4cz3WmxdEYDMzIEAsXtMJxtqJWufqsoygW2CWSn4oqI3oRzKqTi1AufBepn
	GIfc/SDBeVw9EzfzixfvPNRCwI8ROUPocwxRRZrRQI7PF2at2o5C0whajMJO8TQbiXkcVB1jDPo
	Ntz159usZSQEyeNH8AQdwxVE6Np/V9m7z1PFANg==
X-Google-Smtp-Source: AGHT+IEHnI+5JqY5oh2wVE/p0uaWi8W8+LTXmEU/n3gNihFpXyfo6AaBIua2NXrGXkPTkpR3pNPw4g==
X-Received: by 2002:a17:903:b48:b0:24b:bbf2:4791 with SMTP id d9443c01a7336-269ba511bd3mr57822435ad.39.1758301025146;
        Fri, 19 Sep 2025 09:57:05 -0700 (PDT)
Received: from mentee25.. ([2405:201:d003:7033:afa3:5713:fe33:4b7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033ff66sm58550555ad.133.2025.09.19.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:57:04 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: joe@perches.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Cc: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH v2] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
Date: Fri, 19 Sep 2025 22:26:57 +0530
Message-ID: <20250919165657.233349-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0gTtTZt7oE0vME0qRo8nZ=KX3DwF46PhyUVe7e85uZaNA@mail.gmail.com>
References: <CAJZ5v0gTtTZt7oE0vME0qRo8nZ=KX3DwF46PhyUVe7e85uZaNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

The ->show() callbacks in sysfs should use sysfs_emit() or
sysfs_emit_at() when formatting values for user space. These helpers
are the recommended way to ensure correct buffer handling and
consistency across the kernel.

See Documentation/filesystems/sysfs.rst for details.

No functional change intended.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 drivers/cpuidle/sysfs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d6f5da61cb7d..61de64817604 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -27,14 +27,14 @@ static ssize_t show_available_governors(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >= (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
+		if (i >= (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
 			goto out;
 
-		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
+		i += sysfs_emit_at(buf, i, "%.*s ", CPUIDLE_NAME_LEN, tmp->name);
 	}
 
 out:
-	i+= sprintf(&buf[i], "\n");
+	i += sysfs_emit_at(buf, i, "\n");
 	mutex_unlock(&cpuidle_lock);
 	return i;
 }
@@ -49,9 +49,9 @@ static ssize_t show_current_driver(struct device *dev,
 	spin_lock(&cpuidle_driver_lock);
 	drv = cpuidle_get_driver();
 	if (drv)
-		ret = sprintf(buf, "%s\n", drv->name);
+		ret = sysfs_emit(buf, "%s\n", drv->name);
 	else
-		ret = sprintf(buf, "none\n");
+		ret = sysfs_emit(buf, "none\n");
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
@@ -65,9 +65,9 @@ static ssize_t show_current_governor(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	if (cpuidle_curr_governor)
-		ret = sprintf(buf, "%s\n", cpuidle_curr_governor->name);
+		ret = sysfs_emit(buf, "%s\n", cpuidle_curr_governor->name);
 	else
-		ret = sprintf(buf, "none\n");
+		ret = sysfs_emit(buf, "none\n");
 	mutex_unlock(&cpuidle_lock);
 
 	return ret;
@@ -230,7 +230,7 @@ static struct cpuidle_state_attr attr_##_name = __ATTR(_name, 0644, show, store)
 static ssize_t show_state_##_name(struct cpuidle_state *state, \
 			 struct cpuidle_state_usage *state_usage, char *buf) \
 { \
-	return sprintf(buf, "%u\n", state->_name);\
+	return sysfs_emit(buf, "%u\n", state->_name);\
 }
 
 #define define_show_state_ull_function(_name) \
@@ -238,7 +238,7 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  struct cpuidle_state_usage *state_usage, \
 				  char *buf)				\
 { \
-	return sprintf(buf, "%llu\n", state_usage->_name);\
+	return sysfs_emit(buf, "%llu\n", state_usage->_name);\
 }
 
 #define define_show_state_str_function(_name) \
@@ -247,8 +247,8 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  char *buf)				\
 { \
 	if (state->_name[0] == '\0')\
-		return sprintf(buf, "<null>\n");\
-	return sprintf(buf, "%s\n", state->_name);\
+		return sysfs_emit(buf, "<null>\n");\
+	return sysfs_emit(buf, "%s\n", state->_name);\
 }
 
 #define define_show_state_time_function(_name) \
@@ -256,7 +256,7 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  struct cpuidle_state_usage *state_usage, \
 				  char *buf) \
 { \
-	return sprintf(buf, "%llu\n", ktime_to_us(state->_name##_ns)); \
+	return sysfs_emit(buf, "%llu\n", ktime_to_us(state->_name##_ns)); \
 }
 
 define_show_state_time_function(exit_latency)
@@ -273,14 +273,14 @@ static ssize_t show_state_time(struct cpuidle_state *state,
 			       struct cpuidle_state_usage *state_usage,
 			       char *buf)
 {
-	return sprintf(buf, "%llu\n", ktime_to_us(state_usage->time_ns));
+	return sysfs_emit(buf, "%llu\n", ktime_to_us(state_usage->time_ns));
 }
 
 static ssize_t show_state_disable(struct cpuidle_state *state,
 				  struct cpuidle_state_usage *state_usage,
 				  char *buf)
 {
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 		       state_usage->disable & CPUIDLE_STATE_DISABLED_BY_USER);
 }
 
@@ -310,7 +310,7 @@ static ssize_t show_state_default_status(struct cpuidle_state *state,
 					  struct cpuidle_state_usage *state_usage,
 					  char *buf)
 {
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 		       state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "enabled");
 }
 
@@ -358,7 +358,7 @@ static ssize_t show_state_s2idle_##_name(struct cpuidle_state *state, \
 					 struct cpuidle_state_usage *state_usage, \
 					 char *buf)				\
 { \
-	return sprintf(buf, "%llu\n", state_usage->s2idle_##_name);\
+	return sysfs_emit(buf, "%llu\n", state_usage->s2idle_##_name);\
 }
 
 define_show_state_s2idle_ull_function(usage);
@@ -550,7 +550,7 @@ static ssize_t show_driver_name(struct cpuidle_driver *drv, char *buf)
 	ssize_t ret;
 
 	spin_lock(&cpuidle_driver_lock);
-	ret = sprintf(buf, "%s\n", drv ? drv->name : "none");
+	ret = sysfs_emit(buf, "%s\n", drv ? drv->name : "none");
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
-- 
2.43.0


