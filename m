Return-Path: <linux-kernel+bounces-823442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03ACB8671C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E33F5887A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BA296BB3;
	Thu, 18 Sep 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/eFFjXC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED481643B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221070; cv=none; b=Y4rg/I+qneIKH8lKqk8fyNMHh6bTIwJBUoJvaqr1FKI7Fb67Jpy5jnda2nk4vnYZPkFPatq22xJ5xdPYD2yOkFE/DobQKhcGntZ/j4AIX3aRm88HM49r7cPTnPeW2BD1eSOAuA7NZ3TCFW2CJtjlP5SV6ROvUqhKSeEmMncltxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221070; c=relaxed/simple;
	bh=fe3A6MnHA+kBcuSKcXPhgzXX8sc6RtnqsVbVSSBzilk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paKLwulleDno41tNRLT3/IN4J5fDg5B7U4AkutQRycudv0sD3G2JQkwx+ijjTqptt1zjUgKosnIpYE9vtbOnSDBEvRlWuQudmW4AM0khb293Gx0tEXA5NDpyPGCxM2F3Y7lmYpRHXO1TfmmkDo7Fpt4zozP5GoUISYISzAxS/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/eFFjXC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1330803b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221068; x=1758825868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8zgmbahM1VfgP+dW3KRwovtdnR9tCk8bO4aKfh2zws=;
        b=Z/eFFjXCWXG4mqtbYjWIwr50SFPpLpuwGi4wn7h4nT3cFteeuykG6vCIj0JFcaVZ+j
         c0dfoQ3Y429LpT30XwJSyXHmLwSUzpc+6FN/v+991tPxthgOQ+85K+ZhWAl1c1IuI6Y+
         y1NHLOn5RSQd1YI6euWyosNxLSDwKGkTyzYRGaD83qiPWjVU7xmdUkuhMuTTdmmYGche
         DrCw3ORT1LTk5x3Ztx1uRj8n4z/6FOlIQfClQDrYj0V7VtkGVltWOMA4SZo8HsftbUQ/
         jCyPxh2eypc00n+8cHNaMwC0zsKTMyKllGsP2qIiLw6fzEmMJLx3N8NTGlMA3QzVSIDJ
         zHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221068; x=1758825868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8zgmbahM1VfgP+dW3KRwovtdnR9tCk8bO4aKfh2zws=;
        b=oU45rgZryDdPV0NLjdjwJ7j3ZTuiv2E7g5Fk/mMWV7wTe/WjZ791AVKWHCmkPuVQ5b
         Vs8ciKar1SUaWAIYDlpV7+evtXeeJYIASMywgDNmt8Rw8hZr/FV6o/OirLjavIwlgtA3
         cXVyhGZdjMrtq2WpasHgIasA56KCUSKnX0ER2Qq5BhVF/d8u/qmx36HePCjSsZ4VK4ZN
         s/WnJk/hKUGyEUkEoKLAdZCfwiLAqpcXMaSgTbJMvCWa6oGN/lOa/Flg9pWngP4wGWLv
         HBVoZxlZi0fmyLZQR0enwf/Qoc/K5BnXhCASlNX1qGxHHZKP07mkG2z+0B+k2WkgMSXn
         hxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOyW7zxsFd/TUR3jF+Z9X5m1gD1gjzS9d6Vr6UVuS97KHhGldMZerGYr7RoDlgWWlVMIsCgNk0ShdkYuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2riv2raxSUUJcpYyANt5FBWH640NFw1Y14qlyy4bemQ/v3kQR
	cJNKJseJZRATt3Fm+d0SbwWkMeNJKp4074V1dVrShpw+RUgYYCy7p1rv
X-Gm-Gg: ASbGncu9PN1ZCppZzdDWwqNhERgb/sq8gjoThSX8y0sv5fb2Tpc8+Ycck4jvzYUniZs
	1YjApVHHa7MwgmKY7DETNfSdBEbGpxEj9OgPUS/We1/cHpwoXnPM/ivb0GW1eCMJw8eNExl6tKV
	Mzeh5MCEdWjThWHov5DQ3jwGiHhfjm07YOry3OHzPDlVtMf4vCX8i0hCe1fRR3H4SdGKl9p7hQH
	y+CvEqShNYVDDbhPm/gKbJ5YvexbPs8mSvgQiK2Ad6UtQSeJerEOQ6SUz2mGZIe/cH5UzCtgy8E
	2yOTUrtpUaVYeK5ri4L9IXcbQhbQhHZcY3zDzTJFJEtuPXI8tfyF+DUHZI00kAySJXCbHJy5ov7
	qUTciWM6cQg8Q3vwHDHuKHTJYYEESWssQjEmujbaE+AgqAwHoDHQ1tWHcYaee
X-Google-Smtp-Source: AGHT+IES0nh3YJZduE+bzFAmjo4n9/IGmSy36TfhXM3u3Sd6MomrUkG0ZxjN3Mi9LkDFwohHkOZtBQ==
X-Received: by 2002:a05:6a20:3d1c:b0:245:ffe1:5609 with SMTP id adf61e73a8af0-29270503242mr768026637.44.1758221068102;
        Thu, 18 Sep 2025 11:44:28 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm3051926b3a.94.2025.09.18.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:44:27 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] mtd: cfi: use struct_size() helper for cfiq allocation
Date: Fri, 19 Sep 2025 00:14:14 +0530
Message-ID: <20250918184420.76047-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against performing
dynamic size calculations in the arguments of memory allocator
function due to the risk of overflow. Such calculations can
wrap around and result in a smaller allocation than what the caller
was expecting.

Replace the size calculation in cfiq allocation with struct_size()
helper to make the code clearer and handle the overflows correctly.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 drivers/mtd/chips/cfi_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/cfi_probe.c b/drivers/mtd/chips/cfi_probe.c
index a04b6174181c..e254f9cd2796 100644
--- a/drivers/mtd/chips/cfi_probe.c
+++ b/drivers/mtd/chips/cfi_probe.c
@@ -208,7 +208,7 @@ static int __xipram cfi_chip_setup(struct map_info *map,
 	if (!num_erase_regions)
 		return 0;
 
-	cfi->cfiq = kmalloc(sizeof(struct cfi_ident) + num_erase_regions * 4, GFP_KERNEL);
+	cfi->cfiq = kmalloc(struct_size(cfi->cfiq, EraseRegionInfo, num_erase_regions), GFP_KERNEL);
 	if (!cfi->cfiq)
 		return 0;
 
-- 
2.43.0


