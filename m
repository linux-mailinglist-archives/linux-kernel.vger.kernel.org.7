Return-Path: <linux-kernel+bounces-871944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CE3C0EE93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 787084FB158
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1582566DD;
	Mon, 27 Oct 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eT9KRazD"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F630ACF4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578174; cv=none; b=uBvAbcvCvCDhB9fPQJUV5s4KOd5LR3TQArD5UXsDPu+N5rvQe7dH7KFE88hoxs19AEmqp5FdCUyLHOPDQrGmc/3uau71XBwNwRHjv1YO8GB0fXw04U5uR0XdDq7a33aKzrVTAWl3CbxwV56RORPwqPCyAxzgz4EJbpLosZDQVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578174; c=relaxed/simple;
	bh=HFi+5jzbzkDJhJ74N9vt34VSKsKa/+KypnZEEOeAjng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV0zDz8qAsluMTb1PIkLktizoSbJCqZI9YvbYCmW84MAuTjIPA7mp72aQwxR6kIXN4RkVSL0oEnjY4ej7I+55bxKiHING5KbxybS4J+KA3kb0RyqVvjFhODC1lY5ahmFpS8HA4K2o196uKwNR0wKffKzd4T+RHAYQeuOqMcsJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eT9KRazD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso30622195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761578170; x=1762182970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28LMzmOlKg+KTnmCehGJ4yq2NWfrmOTiYLvi3XZto1U=;
        b=eT9KRazDs15k/EflOM1WaRlrBsWQPQ5X6Ro6rTpiPV+eMkDTakRDYqHHCwaoGJfPw3
         KijxMPe8uihCejY8YPq53bz8/5gZ+ebCsUnSOmFLvbcMp7RtED68lDISCVSd563fErAN
         FANbDtpyJiWGOHXyZqxWld4deWJL0nhonsAPdPlg7BVC0ZF7EB7x/siwLzE0j3he0r3i
         YMkIiLr2sSQTPPG5abJK+qX7JAXIpuyIer33uIkQMdqWMHrPuPJQOFjyFsPv8tzliuja
         NX8Q1uCgFotWTHHFx1D4FRHV6AED//pVEw7kfs/SJH4p+q21hDXQppf9SVESWDBZ1xXp
         aQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578170; x=1762182970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28LMzmOlKg+KTnmCehGJ4yq2NWfrmOTiYLvi3XZto1U=;
        b=UbAkPxxKdOWBE58fTeit4GM8z4GDHtyBY4hkUW0GD84nS/OyH54BF34Aozn/rQHEia
         In4+Kqdv8LNmnsJZIgc+yBZtkQOsSQ90JQVNm8/Cuj6Ez1mPIa/Afrpnu7guR7j9AhQP
         oeY75EMf/7lkJSRPnOg9tglDs8UOrl3XcI7OWd26P1HQ0ktwmPlISgLUERpWmnviR78p
         NN1TwvgAJv3ZiONIjiHNKlv4jd/kEMnZ/VlTv1VifaMYk2QWhEC2eW7wgnCSx/G2OZ3G
         nrF13Vz4U2GAwQqWK7S+92FDVdTpF173MmdNh13rx3tp0x3mjVCMvmcJj7G8McXn77fD
         refA==
X-Forwarded-Encrypted: i=1; AJvYcCXPUQUVmWRa7M8n5R8FsMuzmIpAVx9k0kZKItckYRZHSCjpr6y/JV9miGERDbmXskO1yPTT6IRIEPIrd0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTk7rMCAvgVmeTPd4xW8xhYdiqoZglfgUJ9F/QyeHt4YMKkumP
	fcAcYwwaLug0W0pcC3+YewozX9EHYj12lKGniS9tpoFJK8AZeeDSbU+whr8/eWe7UPU=
X-Gm-Gg: ASbGnctnJBnl+fAzM/IBPGoQnWxuw3zJDp/ikiliZxFIKpBqGq4ASfl8VrxGy1VEBSf
	3oZXx1sncbCDQxCOsyTvEdlGnq/E6pW8M4bFRtF6AwpixcfRu2+qSOdpD+VlRoAlGJLrFjLZb2d
	w8wekMZltb/kLf6kacukKAR1efhn/5XpEbaQVgrKBR5bG1WFyHD23MGuM3RUpHmDOdOTVUhfo9o
	BrC7tecz5Ka3esXk/CGpiHc9gqskQtODsNVsd27OeM1lbRZ8gsQMtxjDo0gPecr1Lh9fiGAWqrW
	qS+snn2/bXxPZ7GEUSeqShcV9m6duuWIyNxlgsEoGgMitI89FkZg80QAobt1RZ5DKxb3EoTnofA
	z3pY32H2bY37cs6IbLKXhwbpSZD6myDKVSJL1okA24bNz+RiUxaFk1Uq4EjoeGFYKH+vp5598mx
	OEagMLh6tLM5neT5jB
X-Google-Smtp-Source: AGHT+IF2Q+U4P39LMqUNYJRoBXTbX3H+nbIPvbSIsonN/qYyyF3APhKrFIUh2pTy2NcU3nGppP4j3Q==
X-Received: by 2002:a05:600c:3103:b0:471:1717:411 with SMTP id 5b1f17b1804b1-475d2ec5e4cmr85126425e9.24.1761578170439;
        Mon, 27 Oct 2025 08:16:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4924e2sm142618495e9.8.2025.10.27.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:16:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 18:16:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: move boiler plate code into the get info
 functions
Message-ID: <287b5302f583e3535d50617ec3b0856e38253171.1761576798.git.dan.carpenter@linaro.org>
References: <cover.1761576798.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761576798.git.dan.carpenter@linaro.org>

This code to check whether the selector is valid and if the item has
already been recorded in the array can be moved to the
scmi_pinctrl_get_function_info() type functions.  That way it's in
one place instead of duplicated in each of the callers.

Remove the check for if "pi->nr_groups == 0" because if that were the
case then "selector >= pi->nr_groups" would already be true.  It already
was not checked for the pin case so this makes things a bit more uniform.

Also remove the check for if (!pin) since pin is an offset into the
middle of an array and can't be NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
---
I had sent this as an RFC earlier.  It can just go in by itself.

https://lore.kernel.org/all/aDmpD9qz-4RUXvFq@pluto/

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
2.51.0


