Return-Path: <linux-kernel+bounces-744414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C23B10C94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95619561928
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B792E11C9;
	Thu, 24 Jul 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJGzWX/6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D632E92DE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365406; cv=none; b=N5WbJqKBXuaEpwZbbagkZpYXNemY3Xalf0DyiLDOrQSFGWte43gOvDas2b6P56tTIm6SDWctRqal7tMg35QmqfSTEYMhxVvdhKIdBBRNt9on/5WD1VQoXp8XSoXjjLk/4VSM/r3m3cB7AQrC+sC5gSnSMnOXZESuW6zq1Oghyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365406; c=relaxed/simple;
	bh=wYMeidmYjvDlycPH4G07GZhntMp09MWX5qBkhRN0CfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HROaEWvT+pnd5hwvIZO3jkcEIsE9fcKnCnTX1QVi+/aDwBgyc7TGeiGRUeb7o6Vez5kfPSnk5Czrq6mOCdfPJhNHj80mU4BAXDtOX4V3sSn+W4BTPNIn5GdbdW+wX2xTQCAPAV+xIoMwOFEGl+NERYxal4Xg0BfglITOxO7OtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJGzWX/6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso11043895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365401; x=1753970201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieqGzTCdj4VITWiplNNA/VccLe5fuArNXR2nSJt3s9g=;
        b=TJGzWX/6v2x3LKFOGORhb25GV3SG3O5lJhLzN12s/kz3xZzSeCM2F/DPwP25r/rfjt
         tHSsxbljdsMdjhPrIByOBKv+U7WX0wlixs7UQeh/CpNrBitqyYW2s4gR8dLIRyOm9RTb
         X5gLNzW6X1Te9HXIZwJfvz9l61YLYNyHPE5jJHkr6haAkWG8sJitt9NfyZ7VW2oAURPh
         3aZKnmcEKHumzKpIpyRxJjLWney0vVSv2+GaknSiXmiCIuku4s+m1scu25JSQPYnO7qg
         AcwqG7YrjHPSLpIuX1y6I+spSSKnMA87XLj0W6wfJfgAlwNIYFEfR3n11iV/luMdlKDq
         7xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365401; x=1753970201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieqGzTCdj4VITWiplNNA/VccLe5fuArNXR2nSJt3s9g=;
        b=sl/aJDy8P7KeUvOfPeq39hWQOLt/SFozruiBlWCDLaxr1C94jQbt2fN44yHxO3xwWM
         CluyFNepP/1vDGIq4WTJVEKSt2nlWVZb/ntw0jPevlUGGP+0p/g7p1+fhMIVnZ7v4SDK
         oOEkI/uQVbDvvso20AsnJOuZD8LcdIlS9WDmw+SUZk5yri1TDUfS5RsCkURTgPa3F/XH
         BOjkToKRIIwZipsVDuviVXNcuW8mVF3AtUW3FvNrcuVQsASbsHOVZxmcbjqNqHGzG3mP
         4Q0jZFwAgQ6qGuoBfI2tYkO5euaMiLJgqJ7B13FheLy5v/E6c/UiKehzIAZGUkeTt59u
         bgQg==
X-Gm-Message-State: AOJu0YxJzVvaatD+ZvidDZg/l/Fbs29hcAmIfeMRxFHPug2aQxo8Y+mA
	fmhl/efIUXAzDk4iR0TmUEe4M+xX99e1VNHr9MGHy41lgQYBYFFYGNqvvUW/Ptvn82qthi7sb9D
	tbfvE+g8=
X-Gm-Gg: ASbGnctyGNguyWhXtRia4DQCC98CRmgt1lP4riua4GFx2mRBVqYB+8jzshofVzRS+gM
	c1FvAZpshelNoJSkK/mQfu8ZGVv7z9iL7FGiEDUt0bs/ReTYeM5UW1npGcArNCxVDlThRgWJarl
	KSrxlDnyeIsUDUHGWQ0kJoMIf3HcYCwKi+WMWZGbOcEBVS5YKCvI5ryvx8X0aisPUp2wBZU6XZH
	I/j1MB2PEs3VIBJtELoWPm6RJtmqRJZYYt/wuwYw5h4TiExLylqk3w8PLRAGAyYPfWnlpZrbtlO
	c+0h/xFdFnATx/kKIuNAP4TFSYI2FInwqF0nbZrBL2op3Px82nOUmr4tPBJt2Ib0QmVgdpioB9u
	dd4t2ZFzYln08yadyv3iKHqqauo4il9hbSjqcH7mlTIM6xvhFiBSomqegX41ENLw/koiVqIrvp1
	vFRiHu4mXp999V
X-Google-Smtp-Source: AGHT+IGXEHFsoY1KVpxzOAw5TwDBINg782dVci0CvVy56NLBcwsZCPP5/3Z/QT3qLnRYduHfxvJiyA==
X-Received: by 2002:a05:600c:c167:b0:456:1c44:441f with SMTP id 5b1f17b1804b1-45868d7266fmr61139855e9.31.1753365401169;
        Thu, 24 Jul 2025 06:56:41 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 21/29] kernel/configs: Register dynamic information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:04 +0300
Message-ID: <20250724135512.518487-22-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register kernel_config_data information into kmemdump.
Debugging tools look for the start and end markers, so we need to capture
those as well into the region.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/configs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/configs.c b/kernel/configs.c
index a28c79c5f713..ec94b695f234 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/kmemdump.h>
 
 /*
  * "IKCFG_ST" and "IKCFG_ED" are used to extract the config data from
@@ -64,6 +65,11 @@ static int __init ikconfig_init(void)
 
 	proc_set_size(entry, &kernel_config_data_end - &kernel_config_data);
 
+	/* Register 8 bytes before and after, to catch the marker too */
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_CONFIG,
+			     (void *)&kernel_config_data - 8,
+			     &kernel_config_data_end - &kernel_config_data + 16);
+
 	return 0;
 }
 
-- 
2.43.0


