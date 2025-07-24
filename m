Return-Path: <linux-kernel+bounces-743691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E0B101E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64BD1CC71F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3E226D14;
	Thu, 24 Jul 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzg4n7gG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DC217F31;
	Thu, 24 Jul 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342428; cv=none; b=ah4x0SQ56Y2cozZ3SrdBUWmB5z0Z8vQ5aKQgQB5qhY4HUvA8waW/mxYLTTHgaiSDRz8MTBzuusXPw2tPHvAgnks2gqRd+0kN1y/Mm8Rp8/uo/54drnjMGIdCxvXN1vw1mV7ZbuN02HovzMIb0gS/DYCPxgh8XT+qrEmcgotg9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342428; c=relaxed/simple;
	bh=aObsBAoGBBbS4EVWo9hguk4Rk2eA0GmsWu89eLJzK7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m9BkxIQWJ4gkUjNhWaoVwksL8n8JBKX3ibnmhhjRBSKsem5H1B46sfnw5otAF+6sKwF+9iUTdeRu8/g6j/i5Ovnkm4RLRNEsu4jT/JRi5zgTBuD0JF97BisXnlWKXtptLAV+C3R/vzq+dkr0dD7tFTddtNEYxMt/0/qVR2+oxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzg4n7gG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a524caf77eso101800f8f.3;
        Thu, 24 Jul 2025 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342425; x=1753947225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoucDEJh6juhSDTP/5J04q2TLKLoSSBhBWMLBdIeZYw=;
        b=Zzg4n7gGzGvMl/KzzBEC6imggYb+sKkGnPQmVlQQ8+TBl3tavN1v6Wf1rBkHJBNQFG
         zKX/laxrPtmAn9/gX5cjLhzlaFEXhEjS4ZvBLABwJft2rG6aXQ4aRPcA9LyDk/RUo7ir
         iquqW+D6kioSf33d0h4/6lYYYGpH3Nn2axPasa4IXd7ZkYwaRj7kvhPOYdfQBtyoxJpA
         g8MFK94etPLYuG779agY+Igj2c68efODkDJPJTDy3PQYzfSHX/RQETDlagCW33tThrbK
         QtFGLYgt8PWEKSXY7/wZxHaJh7yoNt5m8D1nEuWnECyH213AC9Zgy05CETFs3bZEcg4o
         SOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342425; x=1753947225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoucDEJh6juhSDTP/5J04q2TLKLoSSBhBWMLBdIeZYw=;
        b=Zq4wHHMek0WxJ3bw0lPsWZ+eymasekfDqBS/k44iWYRRpXBz8f4SOCoO/3SAxC0dlk
         1RuzhP43GNABIiZBlC6FnHUMV8/UK1u/c9WgZXlU2osHmZAkNb6Cx4bhOEEI6R0VghDm
         +T51G/bFPP+RRJys5L6iBtKwLVdTce0uAP+F4g1mb0aBKV1bF3e0GJWBYNgHKdwcn3Oe
         qM8S5+sv35ncB16IeVKlN8f29mNixhNQ609hAb/zdb9SM5bvx1Dlru5Ms99ZpDfPqq1U
         s69qyCuDL4ScYKwLmuYTgb5UE1Tv9j/pyXa8O6VK6PAWSoG2aJDeWV5L7y3u0plqvZnK
         Qe5Q==
X-Gm-Message-State: AOJu0YwEXxM3OKkAYT3xpgHF57NDYG3xgFn4uVfmIfyJ0wwJqP1Qp0vX
	s3b7hLWWusAQt159elW7kYxwjINOPShKiuBVmlCu5mN6uYbA1NgjkscvQlhkV8Kwt6k=
X-Gm-Gg: ASbGncsjHqxvvkFS0uMoczYvJZWSij0/ctBI59viDMYqpQ9ofhwPl0rLLzX2UaZFRfi
	/UTapfJmY5BzkoxaaylQwwKW87UzljbB044MZBibATW50BB4LHT3TA+MaeZplw2sF/tpXQM/4nc
	Q6QUthc4qbYxZPIP/BwSdhJ/15uZa6cEmVAbQQ96RVDPRMjmwyFSNhssjA38PSrpO1mBBq/Amb/
	EPQQaTUnnBdTguJjx3XdCtHSgt+1yaC2ErxqFCK6TLq31gMo+h6Sk87xQa+LgY0n9WqPTLMbfNb
	fC8adrkb8FCw+JCt3Dvny2ed5ZVxI9I3F3qwbfzAF5jc9TYEkKozA6pWVOGpqYij+ZH3eQ1B/8b
	+SWXHOFrE96btnWCS36Qf4YD9mj7XGMvHW4KZf3ms1WhK1qxCz9YQ9QMkz+r2t4ln5GUaz0RZZw
	==
X-Google-Smtp-Source: AGHT+IGaDJX3UrMJQeo3nykPUV6Kn22StVVBHzFwzRtGM/Zl/QUhs2PhINq89KFXz01ycsgbK5tkNg==
X-Received: by 2002:a5d:5d0e:0:b0:3a4:d0dc:184b with SMTP id ffacd0b85a97d-3b768edc6d4mr1651253f8f.6.1753342424945;
        Thu, 24 Jul 2025 00:33:44 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb83dcsm1259849f8f.58.2025.07.24.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:33:44 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] of: replace deprecated strcpy() with strscpy()
Date: Thu, 24 Jul 2025 09:33:41 +0200
Message-Id: <20250724073341.27258-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

strcpy() is deprecated for NUL-terminated strings. Replace the uses in
overlay.c and pdt.c with strscpy(), using the known buffer sizes:
- new_prop->value (length in new_prop->length)
- local arrays in pdt.c

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/of/overlay.c | 5 +++--
 drivers/of/pdt.c     | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 1af6f52d0708..b11e1d045c9a 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -258,8 +258,9 @@ static struct property *dup_and_fixup_symbol_prop(
 	if (!new_prop->name || !new_prop->value)
 		goto err_free_new_prop;
 
-	strcpy(new_prop->value, target_path);
-	strcpy(new_prop->value + target_path_len, path_tail);
+	strscpy(new_prop->value, target_path, new_prop->length);
+	strscpy(new_prop->value + target_path_len, path_tail,
+	new_prop->length - target_path_len);
 
 	of_property_set_flag(new_prop, OF_DYNAMIC);
 
diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index cb0cb374b21f..1337ac4e8e80 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -51,7 +51,7 @@ static char * __init of_pdt_build_full_name(struct device_node *dp)
 	if (!of_pdt_prom_ops->pkg2path(dp->phandle, path, sizeof(path), &len)) {
 		name = kbasename(path);
 		buf = prom_early_alloc(strlen(name) + 1);
-		strcpy(buf, name);
+		strscpy(buf, name, sizeof(buf));
 		return buf;
 	}
 
@@ -84,7 +84,7 @@ static struct property * __init of_pdt_build_one_prop(phandle node, char *prev,
 
 	p->name = (char *) (p + 1);
 	if (special_name) {
-		strcpy(p->name, special_name);
+		strscpy(p->name, special_name, sizeof(p->name));
 		p->length = special_len;
 		p->value = prom_early_alloc(special_len);
 		memcpy(p->value, special_val, special_len);
-- 
2.34.1


