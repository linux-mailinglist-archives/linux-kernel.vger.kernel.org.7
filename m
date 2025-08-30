Return-Path: <linux-kernel+bounces-792976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67388B3CB17
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F815564F84
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A123ABBB;
	Sat, 30 Aug 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3xXvWho"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAB4AEE2;
	Sat, 30 Aug 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559554; cv=none; b=JjNjRZW4D+o59m3K1+Hk+DmWca47jnYOvPmxmvfOmHOp++ndPUpfXnRq4JaqLdZdD7ipned5b7mY9ArsK085bLGtry9Q8SoyPQXXm3OPn8fS8htSWZcI5kpZEj2eyCl+YKZOM8/eXH079HCQHCqZTrkV8j95ZkUjOiCc7//1UYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559554; c=relaxed/simple;
	bh=lab6EIjVw54xJwa2cl6149zTfXuI2ibiw5gf01BVNHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptg/uaspyC88rEhToRnkSBPFcgoYa269IYHanCUeJEM8ooKCbW5FI3c0rA4b3srxHzmrylPYMIWPqmuYxoey7TfTDxeeqzVFfwEkXlBUgBeQvPFpKVtRLInGqacAtFWp4I/LPEi5U8zW4SXsUlilpT1mZmxABIAw/9U6LCxKRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3xXvWho; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso3023717a12.2;
        Sat, 30 Aug 2025 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756559550; x=1757164350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsL6g+vj7TZWfmP3zjs8Q7MdwOAFoiTVtkztKEL4YA=;
        b=X3xXvWhorN3VK7XWb3NmrYYAfU8qtvy/vqc5wtIktgQOpPfGn0uqZBTJcdGE+PJUkL
         6I8yW/1MvUfZrwdL7ZkGxBOD9o2e3tZx2A3rxpej8P+31Ryot7Ae3ghhzWcKiV2SbQUf
         z/nYpNJgPe2q+/6o9Tmk/BrWDu9eLCmIIR9QD2iFnYrN+sm/QdLsbs1jU3jTW2O7DJwt
         ivtSZlkbXjpGSCeWZBXkmF+mQq+n6BhZm9a7GhzHg6zKefaNL4yiZQ0j3OKtX6zoyEFJ
         BX7Myxwwd4hOpdoyQUM7I4Atf6BoLSy7G2r+PUeqtbtIOTBzj/kkBuO4iOOmVQMZobL3
         ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756559550; x=1757164350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzsL6g+vj7TZWfmP3zjs8Q7MdwOAFoiTVtkztKEL4YA=;
        b=UQztoIS6vEtsoEcY+itqdz7v6t+Rn84unYgXrfQVsVQG37yhVNQIQ46b5DKN12V3UP
         M2qtrqt96es0nkZvFL+QD4drjUPdfdW1IRceRl/ltWS00wmbiUBbCvueDZMKyodKGAQ9
         6oClnZm3d0iYYq8Obu2INdCDmwonhkyBXpwGE+9sTIgk7IiMGan1f60fK0uZLLL9Jo0e
         j2gVC3ptwjYm34qQ9EzvmXxo3m0zMcekR4FaxqGaLzSNEerxqWTPm5MsQu3fJIUCUQLU
         s6U8vJyldGCljJ/hJsLciSqegIJWjLCksa1hYvU4ZDUYWXvxjjZ88WTQm5q7Pm6MZzNf
         /nPg==
X-Forwarded-Encrypted: i=1; AJvYcCUdtZcj8u22pnAkLUaW82quMHB3EuJkmp0PNgc4zyERytbX+QmFAcSlJCKeKUNOrk/ur5S7MRTCBwTtKg==@vger.kernel.org, AJvYcCUlbyKJNPaxZCmrXO8k+uCMzVEhGz2zRitBA2WZ9ic3gI/celPTe7+baL6TMdvXe1gL9BtPtI7p4MCY56Qs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dWMhk0E4EnIyteN1FkKHOTDGPFjG0hPU+Utoyla3h4cg8s/s
	YteZpja+tvy4JoSP3jo0/CvSp2LYthwN/d25jRdXOj86V90m+uGw8QoYNDvU8QMo
X-Gm-Gg: ASbGnctqjHc9eiPk3Z6b9aPDbCb/b82EkNwVqEn9CuBUuu8Gxb6RQV62/hbVIcEm1K0
	zHj20KoXz4SZmNYkUnZHbtCaGk2fHn3WRs32MFw/8rGLyaaSxLlvEeynTmeXm8XrCF+4QJiyr5T
	iT+MjSZu8LTa28iQDGzwi2hQHtvIU96N7N6Ba0zIhG113M4ZfXQ33iN3Uq7wRXs8nMDgZyeabYC
	u9qn+tY4b4rxEe4X8lrcopLIcNl70gAJIllAku7oUvNMubCN92U3gNwE+IYTpbS9/D2lwNKEYJP
	C0NbeYtdw6mu+zp4rm4XnXZTW41bYhttawoO4/mwJECiLc1ln126IKQJxyw4uvJreDwwMe+f7G1
	a2IaM5vpZF/VlcMytvhjz+tMZcOmV/u6bZpTfBvAoxOBLvWzbVNqufg==
X-Google-Smtp-Source: AGHT+IGsABVpYHsGItw7bTdNKhVYLHlGZ/1BYvQtPDROGwcwrwLKfdkJ6mxQCGE9GoNn2UiATS7XcA==
X-Received: by 2002:a05:6402:84c:b0:61c:e99d:fdef with SMTP id 4fb4d7f45d1cf-61d26988c6amr1969723a12.2.1756559549993;
        Sat, 30 Aug 2025 06:12:29 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm274461866b.88.2025.08.30.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:12:29 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) refine config description
Date: Sat, 30 Aug 2025 15:12:15 +0200
Message-ID: <20250830131224.748481-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove outdated mention of the supported mmotherboard families and add a
hint which sensor readings are available via the module.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9d28fcf7cd2a..c53c041c32ef 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2673,9 +2673,10 @@ config SENSORS_ASUS_EC
 	depends on ACPI_EC
 	help
 	  If you say yes here you get support for the ACPI embedded controller
-	  hardware monitoring interface found in ASUS motherboards. The driver
-	  currently supports B550/X570 boards, although other ASUS boards might
-	  provide this monitoring interface as well.
+	  hardware monitoring interface found in some ASUS motherboards. This is
+	  where such sensors as water flow and temperature, optional fans, and
+	  additional temperature sensors (T_Sensor, chipset temperatures)
+	  find themselves.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called asus_ec_sensors.
-- 
2.51.0


