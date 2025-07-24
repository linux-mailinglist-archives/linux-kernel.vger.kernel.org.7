Return-Path: <linux-kernel+bounces-743707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358CB10226
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1791CC15D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1E265CBD;
	Thu, 24 Jul 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/gx0Ci+"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E01339A4;
	Thu, 24 Jul 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343146; cv=none; b=BH9KEaehPdJZE7Gs5kv3Xn4i8hdaBdD2ZtwBux7LdOINe5OBNCN3k8DpxPvAK64BD4lKEhcYG3gZkhKEcH94ic/Z2tYh4caw/zwPfEaoN8+ZTKoDi3NXIzSBxhBvVKto+/fuVtHyW9hbHhih3R9AMkQgHRXw8pHycmbXc1grKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343146; c=relaxed/simple;
	bh=3dyKErCKJTHeljzSzJvqwhZJGLEbOQ/ya1QqSqg28x8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=laUGVVozVW6QzIWFozp8ufa9th9+5FKR75SwjGcSLS5vF9gACv5lx5qsXYUJh/dJYpDB/pwOW+pwftCtSU6c5Gv2xUZO0Pqw+P8C0isCwfq7Selk49czb5Ai7nZCWSebwp4ApbY7Pg0mEkMlDxlPI+fPbQcq4uzm7Zr04otJeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/gx0Ci+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so98498f8f.3;
        Thu, 24 Jul 2025 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753343143; x=1753947943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sBME9NhLAa0V4tZedZfhbhdNAbturaKeP6X7bXODak=;
        b=B/gx0Ci+p+0aVTeMzZDGJp6FBfQe93i8O1XPm8Fq5meCyLRN7y9afxTLCgbwJXIiUC
         aJD0nywe35ru8eTjjg6mPdSaDVrGFmwWjdyqDi3MY/4YxRlLlY7mAzCJFTWNVJv6EOGj
         P1TusoLCraf6L0XC777Le3AgEWlvSV3P77iCEuqTjB1vnYMQpiLGHuCw/IlNzUHU7IJH
         FjTBVqj489ayruRp3ThE/kNIo/meqzMtwmy8ZjqVdlUHV+fdudB7YqZVvIygvol3YwJj
         NDVKjne/DusJ/dIACLkMXKli7vlcKODQ6r1wjmDgSdEDNE+MhCtehWxffUGutDgTqAzs
         AV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343143; x=1753947943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sBME9NhLAa0V4tZedZfhbhdNAbturaKeP6X7bXODak=;
        b=Nz91IVz7t8DQovIAUpkc4UIjFiJ/Gfy2nXkxLFfrCbnnZqyOhyIuKj6d2tj0AFqmyR
         gXLrbl1AOh0sUmnLXYo8OD+cCZ2syPSN/O+Yuiv8H68py3E/5B2SUtZxKkUKPQpwltUj
         Q9sL4qyMW5RWB5YINkeHtqIaB5P2jVui7f+2oaJVRZfNt1GDWjEpTPHZjYQlZHJT5IOb
         gaTOQ+FUtYVIl94WAAKiDeBq8/s5DyD5dUSHVz629kDtEjbT8sUWHCGOZuYYyBEjId7u
         D8bR0wja0dwRliPMBBKxYcQTPsbwg9zjmk6SAR5x9VNodmcuLyhb7cHse/1FpGnsUAKl
         xQ6g==
X-Gm-Message-State: AOJu0YxI/SlvKHV+8dPv6z/1aFmlgo2ecpctskO0OIfMRmK+WhMMi+KA
	wKU8TtBIFq2hpeqg92TFMchefgGIK5xcOziZ9O7BeaqxvGClHMD8rMo0IwMNH7aBVN0=
X-Gm-Gg: ASbGncv2YIMf78wn/P37+OljHMaM34V5RdUDGxusUBpx5YNzd1ukB+7o/NdpO6/Ghnn
	7q+kbXbOVDR8p14HkdruKgXh+Ss5beOpVybZvylr8HAsEvs2hp6Yre+NPrskuAPxHdwdA7yq+mF
	15X4ryRA9PeIXqHYC78pqhYXIyGDE/JzT0DELy5wsssst39WBqolAiEGU6yXcjwE0vWb0E+xzzx
	qb+BB6sLjaSRP1DNMW4Aj6MXyomeI8/KTld8KeQNx1C9FwxlzLCHUSAYRju45/70PaGfAhGfNEN
	HVc4iYTZzL8QPqMKGfPXZQDB5wTiH+wyJxEMJfqaLL3vEbejp3GKV3L5ITmoaBZAfjkTTYbFLtL
	sEax5jhlp7vhbR0Bo/Twq4elXXpsI92YM/Z/jeCTNfzwyHIuLj16okxxHnylRli1Ta+HzEy5JlA
	==
X-Google-Smtp-Source: AGHT+IG6jd6BwjGEHHK/7vOzi8NSNMAP/DY2RWfO0MPfSK/BWlkjDI8KDfYYLHvPQ1swDEkF7YBQsA==
X-Received: by 2002:a05:6000:2483:b0:3b6:1d07:b73b with SMTP id ffacd0b85a97d-3b768ef7341mr1788754f8f.8.1753343142771;
        Thu, 24 Jul 2025 00:45:42 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377dasm9666085e9.4.2025.07.24.00.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:45:42 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yu.c.chen@intel.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	luzmaximilian@gmail.com,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] platform/x86: surfacepro3_button: replace deprecated strcpy() with strscpy()
Date: Thu, 24 Jul 2025 09:45:39 +0200
Message-Id: <20250724074539.37650-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

strcpy() is deprecated for NUL-terminated strings. Replace it with
strscpy() to guarantee NUL-termination. 'name' is a fixed-size local
buffer.

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/platform/surface/surfacepro3_button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 2755601f979c..9616548283a1 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *device)
 	}
 
 	name = acpi_device_name(device);
-	strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
+	strscpy(name, SURFACE_BUTTON_DEVICE_NAME, sizeof(name));
 	snprintf(button->phys, sizeof(button->phys), "%s/buttons", hid);
 
 	input->name = name;
-- 
2.34.1


