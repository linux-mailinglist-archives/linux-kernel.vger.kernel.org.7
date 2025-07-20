Return-Path: <linux-kernel+bounces-738407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F1B0B7F6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7443BD151
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E031223DD1;
	Sun, 20 Jul 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xURukzX9"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A52236EF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040324; cv=none; b=fFbVzVlHrFrFlX6R+t+Tky+sD6VXtrLLC5EYD2Grz1eps5/Q4FAGwLUgvmj/OmqZ9bFbA1J66leF5lVhaCxKBp8/1QLF6tN46OJ7xxKaJd5YVtZzSoKtPUxozQ0R63AMqTzyLpwb5f+zyHnf5JAyRj/82pED9u6KPWFZdFQOCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040324; c=relaxed/simple;
	bh=NGvVaxHT6GAmFiO4/MidCvEywAVxDk7Jl939F55Z0dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9HjtBKWh7wSvYm9C1qhrn9hIEWEk2NuW0lYXcaP13JViivi3+8WCzpwnXr9ufvaHKZ1NKnpINfX45IPNMbxIH9rPcDkf9WvIGXRdZRJXhIotwpGyQcLMHk9gcoRGbg3AjHBy1F050PWY/g3MuJmeGzdMh/O7PMPiq89sGCk35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xURukzX9; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-615d75ee53dso115086eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040322; x=1753645122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8e0Rkt8jdkgvftQKNoZRYfHGuTcfUv00gpyykQyZ5M=;
        b=xURukzX9xG/OwgS474fODizN51RwJT7HiKxjhoaHkXB/BmQt4vJX2WX0s7Ql2g1ALs
         gWqsX1pVFv11bd5CMefY9iaJt3OchcllDfqr5gHjXP1wRVhUqMhvYkqMLc8xTAKKXU6N
         QU25j5dQlsSnQxrFBgUusVgRrgq4krWXgE5rgSlRDJpZQ3aJEjqGNs346RrRxL/dmNXV
         dVyzZ6d+FYNme9iLEsrNA24WE7OdhBeJ/VEB58xD0yQCCWKmtwMBc7RbzOoyNqj17pA8
         jr4O50JEBOuTGKo5t7+O4NKck+uS2rlm5lUt7i0NfFa9FY8wzcrGcSCUNvDY2zEx2/pu
         QYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040322; x=1753645122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8e0Rkt8jdkgvftQKNoZRYfHGuTcfUv00gpyykQyZ5M=;
        b=XUREINU6NtmNF37IAhJlYSA/BnXvz2nwhciuqMjLHLwUJzJsDE4gL5F7mW5PDnb9Wi
         KKOi4e1DRGBZBx347g9pIZHcDqWsLrpjviDbgydUOy6tDnqbpuVAUwpeB8K872Phf9TH
         1EHMZ/cflsiavoiNqeGJZvrwewjPQCPi/UVLs8uwPM+4aC1VDpEvQhVWEGaoh10HFr2s
         QPPiOB/dcs+o0kPi/XFrol+W6Qn65ImHExg7dfxiyJV+mcUTSZw9qWmB/Nlnwh4isat8
         SBT4l+TtDIPrNQ9VsKPYmjM1S+ZTeyEjjn8eSFxEL/8+nYdcQrdCTtxn6kVSBM+XcfgC
         imLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZtmJGXrhAuBL1HHJR0vBmv6ywAb4GF1tvNRPZCGcubswy79nTPXRJboeIadviSN3igMISbjLe96v+WcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANxm2L+Tu+zrL3qXHGXVy/Yc+KktCI2qKW6O2Z/XHOGRjcJvD
	TcGbxsRhbEDm17ZYrQfXoyY09jBZX83Bv4a/+UffCtznTpA2x5H6TCAUJxibJt3rBF9Pg5Ffla8
	cCPuBIh0=
X-Gm-Gg: ASbGncvgAiBkFM/GIjRl8e0p95dWVVZHOGxjbE8CbUHPn7S2R3dw7eCGZUhvUFANsTh
	rT9cukgpIpmjqgkRY2hgyKZ15HOj6SLtnw8xMtBssq4WHzFoJHdG9Wtv0HXno6A66CRmWuPR6H0
	dxsmLLrLEKeDjJ+afOrtif2/MtXE0qfrHlYG5feaAG7KVKGiC5pUtJfm+85q88b4ueSrHC63hEG
	ZThbCfLFQ+Cucc0tZsQBWvBFhJs3ZD/YA1i5EOgBbny48o9B5gcdYXgaxfCUrjox5oW/s3WfHLv
	tJigOArvqY+RbBEP5omH11ndvYDGjb16bhdO7hJ3QyBf1QgLFx4BfZJ+u/hAIotHtHotMowz1MM
	+qXdURvni8JE=
X-Google-Smtp-Source: AGHT+IGeTlhYB9KS9TF9xSDd7VU5hXZEme07PjGtrxZBrvFLIeMvThRyC/+06//IuEU+tzOyCgkyAA==
X-Received: by 2002:a05:6808:3c4b:b0:41c:d19f:27a7 with SMTP id 5614622812f47-41d031f1b44mr15123791b6e.8.1753040321954;
        Sun, 20 Jul 2025 12:38:41 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd10c2058sm1777647b6e.2.2025.07.20.12.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:38:40 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:38:35 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/7] firmware: arm_scmi: move boiler plate code into
 the get info functions
Message-ID: <7a47cf3d-05e1-4702-87ef-cb7f36f03149@sabinyo.mountain>
References: <cover.1753039612.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753039612.git.dan.carpenter@linaro.org>

This code to check whether the selector is valid and if the item has
already been recorded in the array can be moved to the
scmi_pinctrl_get_function_info() type functions.  That way it's in
one place instead of duplicated in each of the callers.

I removed the check for if "pi->nr_groups == 0" because if that were the
case then "selector >= pi->nr_groups" would already be true.  It already
was not checked for pins so this makes things a bit more uniform.

I also removed the check for if (!pin) since pin is an offset into the
middle of an array and can't be NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/arm_scmi/pinctrl.c | 108 +++++++++++++---------------
 1 file changed, 48 insertions(+), 60 deletions(-)

diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index 3855c98caf06..d18c2d248f04 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -596,11 +596,19 @@ static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u32 pin)
 }
 
 static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
-				       u32 selector,
-				       struct scmi_group_info *group)
+				       u32 selector)
 {
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	struct scmi_group_info *group;
 	int ret;
 
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	group = &pi->groups[selector];
+	if (group->present)
+		return 0;
+
 	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector, group->name,
 				      &group->nr_pins);
 	if (ret)
@@ -632,21 +640,14 @@ static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
 				       u32 selector, const char **name)
 {
 	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	int ret;
 
 	if (!name)
 		return -EINVAL;
 
-	if (selector >= pi->nr_groups || pi->nr_groups == 0)
-		return -EINVAL;
-
-	if (!pi->groups[selector].present) {
-		int ret;
-
-		ret = scmi_pinctrl_get_group_info(ph, selector,
-						  &pi->groups[selector]);
-		if (ret)
-			return ret;
-	}
+	ret = scmi_pinctrl_get_group_info(ph, selector);
+	if (ret)
+		return ret;
 
 	*name = pi->groups[selector].name;
 
@@ -658,21 +659,14 @@ static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
 				       u32 *nr_pins)
 {
 	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	int ret;
 
 	if (!pins || !nr_pins)
 		return -EINVAL;
 
-	if (selector >= pi->nr_groups || pi->nr_groups == 0)
-		return -EINVAL;
-
-	if (!pi->groups[selector].present) {
-		int ret;
-
-		ret = scmi_pinctrl_get_group_info(ph, selector,
-						  &pi->groups[selector]);
-		if (ret)
-			return ret;
-	}
+	ret = scmi_pinctrl_get_group_info(ph, selector);
+	if (ret)
+		return ret;
 
 	*pins = pi->groups[selector].group_pins;
 	*nr_pins = pi->groups[selector].nr_pins;
@@ -681,11 +675,19 @@ static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
-					  u32 selector,
-					  struct scmi_function_info *func)
+					  u32 selector)
 {
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	struct scmi_function_info *func;
 	int ret;
 
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	func = &pi->functions[selector];
+	if (func->present)
+		return 0;
+
 	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector, func->name,
 				      &func->nr_groups);
 	if (ret)
@@ -716,21 +718,14 @@ static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
 					  u32 selector, const char **name)
 {
 	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	int ret;
 
 	if (!name)
 		return -EINVAL;
 
-	if (selector >= pi->nr_functions || pi->nr_functions == 0)
-		return -EINVAL;
-
-	if (!pi->functions[selector].present) {
-		int ret;
-
-		ret = scmi_pinctrl_get_function_info(ph, selector,
-						     &pi->functions[selector]);
-		if (ret)
-			return ret;
-	}
+	ret = scmi_pinctrl_get_function_info(ph, selector);
+	if (ret)
+		return ret;
 
 	*name = pi->functions[selector].name;
 	return 0;
@@ -742,21 +737,14 @@ scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph,
 				 const u32 **groups)
 {
 	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	int ret;
 
 	if (!groups || !nr_groups)
 		return -EINVAL;
 
-	if (selector >= pi->nr_functions || pi->nr_functions == 0)
-		return -EINVAL;
-
-	if (!pi->functions[selector].present) {
-		int ret;
-
-		ret = scmi_pinctrl_get_function_info(ph, selector,
-						     &pi->functions[selector]);
-		if (ret)
-			return ret;
-	}
+	ret = scmi_pinctrl_get_function_info(ph, selector);
+	if (ret)
+		return ret;
 
 	*groups = pi->functions[selector].groups;
 	*nr_groups = pi->functions[selector].nr_groups;
@@ -771,13 +759,19 @@ static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
-				     u32 selector, struct scmi_pin_info *pin)
+				     u32 selector)
 {
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	struct scmi_pin_info *pin;
 	int ret;
 
-	if (!pin)
+	if (selector >= pi->nr_pins)
 		return -EINVAL;
 
+	pin = &pi->pins[selector];
+	if (pin->present)
+		return 0;
+
 	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name, NULL);
 	if (ret)
 		return ret;
@@ -790,20 +784,14 @@ static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
 				     u32 selector, const char **name)
 {
 	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+	int ret;
 
 	if (!name)
 		return -EINVAL;
 
-	if (selector >= pi->nr_pins)
-		return -EINVAL;
-
-	if (!pi->pins[selector].present) {
-		int ret;
-
-		ret = scmi_pinctrl_get_pin_info(ph, selector, &pi->pins[selector]);
-		if (ret)
-			return ret;
-	}
+	ret = scmi_pinctrl_get_pin_info(ph, selector);
+	if (ret)
+		return ret;
 
 	*name = pi->pins[selector].name;
 
-- 
2.47.2


