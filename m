Return-Path: <linux-kernel+bounces-724823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF3AFF74A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654461C4181B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F342836BE;
	Thu, 10 Jul 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPJ5wft0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006B283695;
	Thu, 10 Jul 2025 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116635; cv=none; b=TOD7vldCytBab8xD+pou+V5Isr9g96xDyGAD4IxnrBC9WDJRXXQfN77ocDij/1GiWBOXLrxmwa6bBwK6wkN08hMjoBLsy8W8pKuAQFoEY9Hlcu5edOIUY3LpIU9UyaCjUVlGKoZ8wJ7VN6hqw4oDV2n7OgUBwmiaZeiLyzvtGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116635; c=relaxed/simple;
	bh=PGzNmxKPeKeIW9y3SLrZgxUtNxszaOvcO3mqQbh5IU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EteYKou9hI1w4BI92xaG8YOAA0tlEn9kJQZ08Vxu0T61BfYlaeHDdjYffpIzyXXPTkQOoZD72Ss1TojE9n1Jx7DXf+E5TwwypqxJRup3SQpoNphyvK2G7luS8apZvBUCnqxXCewP9tnG9+jjJVUnonMhulomKIYKCOWfcyOJb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPJ5wft0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2353a2bc210so5678545ad.2;
        Wed, 09 Jul 2025 20:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116633; x=1752721433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXIjFbe4Vrz2bi8rFlLHVCaoVK6EIDR/YQX7SQMy1sc=;
        b=GPJ5wft0REkbSF7FNu+GCQoXc4XNbCaX5gUQj7XSFxZbLY8tqhcNW/xG4gF8BjPvy2
         n8lD/HL0jL76TqumMARvfDCHQgB+gpCDQ5Oo2oRD7GY5DMxZXkHZpZKZaWphXdtR3A94
         MNcMQlYx9Hodk7dAj59YZbUt0lDFh/O7ticvXuzuWYO0efCdUuWfUfL1rK6lT0OLOpyG
         c4weeqRo17QSREKluKyslh1FBpSaA+0v3ioaPNMGosPjEazYian/abajHYUF1zgvh45v
         8yq2Kl0Z3vhysoFpcp+d2OZEimhuA0UBBsKNAU2PK+5ieyOiB2KsMy443YQG056q+aL1
         atmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116633; x=1752721433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXIjFbe4Vrz2bi8rFlLHVCaoVK6EIDR/YQX7SQMy1sc=;
        b=VrqdsJUyxClLs23D482LhQ9kwdbXz1Ftfjfsl1hRue9l2eBRQpDnIPNsYy9WprXf8F
         HJ+owRGSRLeHlZxTGEx3zpEtgG8ergTj85Tzac2iXEWvwddLoAGuMG71qXCDPK8vV2sG
         suxEt/8PbhN6eApSlB2VEQVNhtnfQZvp37CoyMqmyEo0sVBkk9NDcUm6wd4w9kH20CZE
         KBfxmbvlMPyj9NbnrhT4LWAZAD5ibgrxdHVkve7sXDHGnCv57n/rv+y17rcTj+o7jCiB
         uu/V868BU0YdyWhC4x7cywa363fiv5TQEmVnT/DDmRH3LrQtZo69VYibJyS3EHOy8/9D
         xuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3yoXybAt2T72hkp6K7FkSfX8G7CEkaX4F1Y1IPRH7fVdzX0Y9tU+h2A5ky2avUGdtZhJe7sH9iTBognY=@vger.kernel.org, AJvYcCX7FeQC6sTkHAw7PdZgvmFBg0j2sntW/lExdrOqIGltNy0AhBIkiU/G9HpqpBuBmaIvol9Zuk06qKj0VaSiskODHu4Q/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmYAAYDgru4CyIsh8Cc0EP95AcxQjQPherOiyQlyhx5HKB1tE
	nVKmwFUQ7YgoUDwk1qbRvAwIWR0ZYeueDiyBpgl0pZ1Sqca3IT/e2nOt
X-Gm-Gg: ASbGnctCfUwS+qJSHQb6TnezmL12OiJ1DdWxlszthRHX1bYuoZnL8eEYJJMglpGhv7q
	4phUwib3DHI8siAiNf1ebrW31k2ZTqX23/VLcozbOCtmhlSheZEC9qf0UEoAiGpWDKy7r0Qo9Vr
	DIIemB6oROF1FxSiWASnLyx/gOUJKVo9FLziSgh5qEOMUT38TRDKyuyRrdFE1Qri4Ll9CoNIU0b
	1lJx5nlWd6LFuqzLfszwY6m3ek7DZ5NnAiMigu8L7qUDXcoe1KkahQ5RGBh9nvVBtEuhV0e/WYN
	6vdH3j2QeLjbzvzXa+/9XmtGwV2q/QGXhHzYE1A4POp7oUqgw5RgHoRFGH5R4Q==
X-Google-Smtp-Source: AGHT+IHrgD3VdqjJ19DTZubtWqeYSn6DUskkZ+P8TziZK0NPI1P9/RRwcb9bYSMrI5ZrSsAHwBf9Tg==
X-Received: by 2002:a17:903:2448:b0:229:1619:ab58 with SMTP id d9443c01a7336-23de24f5a39mr37319685ad.43.1752116633351;
        Wed, 09 Jul 2025 20:03:53 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:53 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:03:20 -0300
Subject: [PATCH v6 5/6] Documentation: ABI: Update
 sysfs-class-firmware-attributes documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-fw-attrs-api-v6-5-9959ef759771@gmail.com>
References: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
In-Reply-To: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=756; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=PGzNmxKPeKeIW9y3SLrZgxUtNxszaOvcO3mqQbh5IU4=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5uo1XZ0Xcf/KxTeHBPgnjfS23WUtncp1ob3potiLEV
 zEu5eyKjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjI5V2MDFfEdTXt6vIelSUb
 7tSve50nkWxzSOih3G51n2/BEXOe2DIyXLu5j9dJbovvM65O2blH0v4keD3+KMZ2JshcMLkskrm
 bDwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add a simple boolean type.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-firmware-attributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 2713efa509b465a39bf014180794bf487e5b42d6..64b8d5d49716e8387fee26e3e56910862f6a4f5c 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -18,6 +18,7 @@ Description:
 
 		The following are known types:
 
+			- boolean
 			- enumeration: a set of pre-defined valid values
 			- integer: a range of numerical values
 			- string

-- 
2.50.0


