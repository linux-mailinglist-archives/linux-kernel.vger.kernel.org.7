Return-Path: <linux-kernel+bounces-756313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811FB1B28B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94ECB620FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE8262D0C;
	Tue,  5 Aug 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOrOQqhB"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC425E828;
	Tue,  5 Aug 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392732; cv=none; b=hjFRVvbSVnyZ4hyhO44o53SNgbi4T4lkAjL3SfaXuc8odtMQgk6IvllG/mgW5NW6w+teBlaHFpoAgGoIEVjchzgM4AR8sIZ/NIStBUtj7D94TBim2vemGD4hDXiFwCJEAGOF2SOC3F5P33vEeWGsLqTQe0SagTm9YRD0vESBKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392732; c=relaxed/simple;
	bh=wryQdfxH6n20JyHtj7sthlA3Q+wGAChxADhvmVnFQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mik3d+3V/z7mj16MCar0xzWTasMRFkOPY3KBVEx2pdZhllN4mPRumEaiVwgmQbRyqyj7vVa8+9nZZvJtu/q9VV9Hzefu0IxCg8YFVC88MvSx9MzwpU5eNCJ3qq2H/zlXTnD+66iKwJXNpTwdUeCduKPbQg4sPzy5oZTQQNVxOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOrOQqhB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3323afe4804so37198371fa.0;
        Tue, 05 Aug 2025 04:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754392729; x=1754997529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAyT/OJTRuY2JWhPWK5JkMm7Zn06/WfS2T6aNl4VFA0=;
        b=HOrOQqhB3o8wELKXwOtBvq2j6IqAgbAdgq3AOI+6xYjQu0I6WyjyilRFnA6ur6F/Fr
         k7hjhgeiAIzPeQwRWNyC08fNDrObl7aHC7uc6XYgUuJ6YgCamKPnjW7RNfJiwkjgUyxl
         pMaN5I9zr1lLWYBq0EKD4aYCi61OXg/LEyH4+iXSLWy4+m+AKl1hQMumbriRu25brlkF
         sZH9NY1YwbC5DRHZ/bcQRK8KYSLBmLAuIej6lBRw852BbJLvU3oj4wHnqRDlAe9nI6Oc
         DOkygvyi4D6ePk1cCspiuQiJrCHXQUh3yoT3ldH6q7u+xZaYw1eI2nwkujchqvzDO6lz
         iWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754392729; x=1754997529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAyT/OJTRuY2JWhPWK5JkMm7Zn06/WfS2T6aNl4VFA0=;
        b=WTb4nY5Lyf9t86/xjM3qzyZbimRJFtqGjT+nGJu3vvyyonTodx48/bewJvLMCQlRwp
         3YC6RmikBrsXqaI2tnLcd83vdZwwD4pVTVDKBvPKd7/0PtE7eFJDTjOjJjFGuUVJ1QZm
         YIiX1XS74qCbDdGqqz/jKCxJZfV/rc7Za0gP/TPQ/q6iu5R99t7M8eCYy3+W3a7II6+R
         Q1uFWzsg6cUB1nBtaNenYA6Icm8Nj8P/V7M13E3J4QV6dm06Cz2gQ0BYjbdYfbaatnye
         48oRioBB6TqWXKOhJ5YAT/2LhqrIGMuA7bj/tqGgCG7FCTfA4xEdRbi26WLUkeS5bUML
         jMwg==
X-Gm-Message-State: AOJu0YxAk+E9McQfWRTluIpaGLTsBZ+E8sH05uzJLaY7Xzxrtjkdir3F
	Yv/QWiH6l6RHVBvd8pr0b6r6VC6RNSEimxdyvHVeSPcDe5T+6PW1njLGCvTu+wQiXe6KJQ==
X-Gm-Gg: ASbGnct10AU1RjRPzXvz+nYtNUKFm4MGKU59UAlOtsGs+8X0PWzI467yM87A67rGshx
	ukyrTLM0VQTUMj7gLTGbXEsN2ngr+JddFw+StyqePJcsgI+ZneJpsSvddIWlSvDAsQZzyEBuato
	mYTVgBmp0tsItLT82zMVtebJvOhPJhAdo4r8c6bu1J633tiBZ34lN9qbDUB2c7I8x1v5W/ACPR7
	jQ7y8Iwll4/YpzLQtuifPpp0KKojV44fxW7aayo8ghCXUAeHe94hmPRv3bFZ5U70efu+xmAuasu
	squEJrtQ8DXTV7YkgM4r+I+HgiTCFq3aN4HbU1kHgvZRL6nDNqy5L4rr1LPDQWOQtNGZ8gKjy5W
	Wc7DjIPTs7b7UUA66eMolMLAH/fZL7yBZgZU=
X-Google-Smtp-Source: AGHT+IElH7b/75Ma+jBw8PKihX4HZPFXpMoR8XxP/rRa/9gSS2dzcy1NLjC6CraI2p5QLL31jSCjLA==
X-Received: by 2002:a2e:a718:0:b0:32a:604c:504e with SMTP id 38308e7fff4ca-3325682d84bmr26666271fa.38.1754392728532;
        Tue, 05 Aug 2025 04:18:48 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9054sm19367161fa.28.2025.08.05.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 04:18:48 -0700 (PDT)
From: Artyom Shimko <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com,
	Artem Shimko <artyom.shimko@gmail.com>
Subject: [PATCH v1 2/4] hwmon: scmi: Remove redundant devm_kfree call
Date: Tue,  5 Aug 2025 14:18:39 +0300
Message-ID: <20250805111840.6472-3-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805111840.6472-1-artyom.shimko@gmail.com>
References: <20250805111840.6472-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

Fix potential resource management issue by:
- Removing unnecessary devm_kfree() call in error path
- Relying on devres automatic cleanup
- Preserving all error handling logic

Rationale:
- Memory was allocated with devm_kzalloc()
- devm_ thermal registration manages its own resources
- Double-free could occur during probe failure

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a3b5b5c0ec25..d03174922e65 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -211,8 +211,6 @@ static int scmi_thermal_sensor_register(struct device *dev,
 	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
 					    &scmi_hwmon_thermal_ops);
 	if (IS_ERR(tzd)) {
-		devm_kfree(dev, th_sensor);
-
 		if (PTR_ERR(tzd) != -ENODEV)
 			return PTR_ERR(tzd);
 
-- 
2.43.0


