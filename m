Return-Path: <linux-kernel+bounces-730079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C991B03FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00AB4A0E93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32600251792;
	Mon, 14 Jul 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb6ak4J5"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056E23A9BB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499800; cv=none; b=QedFKQT29UHbfhrHUe6x/dMluFVW+r61QiicuNo7NgyXVdbhMFSjfAvyoHzdQYL+fJWo6GkKmDVQ5FNqxqSuyN4cTV5vI0pP6+IzWYgvwM+N3kR2I+E3f93YHNtzRjGUApkieipNLCkWb1nlIFbNjvnf/D/u2rb/TJTXlH9u/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499800; c=relaxed/simple;
	bh=7Sm5LsOFtuRrz/TkiuLgXge3S0NaRIa9UfX2d9h8Clo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOlXu0mHyjpZOLzJXlMRo4KNmOWihZB4NSlaFVAynK4DJMNdWrv6UXNcSX6+EOXDKrvSMjYH9EEOyqkDufVXCFY3iw5hI/25XAozKHl3MGaFC42oYL+DZxdyM6wCpMoJCHKyodlU3yYQlXTR6aa30m2COyBIyrvUtAuNqmOld6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb6ak4J5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-712be7e034cso40139767b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499798; x=1753104598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar8UcJJp6D80cSBExxGKJ5XW7V6hUSuTns7AE4Udt1E=;
        b=bb6ak4J5VpL+C1u7/U3Bui83/b7eYIkTaR3eyJuz35GMNAfOH8LV63uZthvnB/GjCP
         IRt+Vs2vE7mUT7LgFXu5U0KjOlvciMxJEn1x1BDPmWlcs8HORmRX8Jxw4x37//7YaiMT
         /ZGvg3o5bQm/mCqye7h6cuisaCRClKoC2Np8SLzFReYWiCWtaJIYb+VDost+06mpjC6m
         d6DUKjdg2RB5ZyPjkCGRY/eFaNO5vI9eZ5LLsIJMkHV/7q4Dc5Q500g2MSObu7v7zg53
         8CKgjUpHm1Mr/Gta1/CtoOsHF4FGRF9ty8+0vmEUP27TJMlCRVXK5RIXsmW/WN5wnfAS
         sNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499798; x=1753104598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ar8UcJJp6D80cSBExxGKJ5XW7V6hUSuTns7AE4Udt1E=;
        b=FFdzVnS23zmh5joEf0DX9prpeB46RTdH8kGbkYSGw/O1Al1a2EGmQR4ijTOh8kcz9m
         s8L6B000/cSXDtWNCrFkVLYWXbSy3cAnMZqKmtwywokql+BWSxolJIIBfo5+vrx57z4Q
         MmBLpeqOxgJSL7EZqJV644XxECm0XXjlFgQCywbIxMW8AzV9dHimB8bgWudY+fc9Muha
         3HnwXniqSmB15cYc2gXD6LxbwbXTIc8MKclq7JcIzsTzcNvqqP+ui6XTv/CnQ5fB00g3
         ZuVdMX4rCdyGRh7tejySc3I3zqjGcj5sBKDW793M3t/BiSRwlHp10p+TeAWROtw6ZoqH
         j5zg==
X-Forwarded-Encrypted: i=1; AJvYcCXoL8vc28E/IzX1x37+NaaoA0AgaPH56ia+LjYhMIsFYDIQjshBwnNsOtGbfFmeGq4dyUaWDe1qi2aXuWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7kIebRXSxKY0D3xDB8o2+A63YHpRPgIzv0Y+Q+HsabYnDeYH
	PsR8pkHCZIh8g6DeVELd9L7LNwhPMFsnYZgbvEjlUx6YnkpkjMqPXVuD
X-Gm-Gg: ASbGncuOCWtFFpAdBaH3SYPgT3y6i5pa+EQ4b3R/hnjAsO6OUN6+RCfqZYHrO8dOtnE
	sWAYP4aTdb+q3vB4R0wmfyeCI+FKw/jo6EvF8Jfbr9kNeYejSWmxoTrqol4YxaUpWBOROh3aLy3
	C2/TEFfuxcJeApxaYfv6lH4QYkWDjECknN7OmHsPBzcrcP6DSQygYTbEnzHxHDQU2epvFDeUR/V
	52f/LK4KSr8kuiIMG0vor7zv9QLPwkYCD+QfTkf3CyOOiTKykfWMHpeWP7Gl710Kh4d4EewsUlM
	nhzutMRGGgjJ5ODV8UfdpeiFS/cNMYmWRhlPGL9dKPVvjYsRlYOV8ztJcj7oXmcwjvYuSncNB8Y
	/xn0u9xWO/XkTB5G4Olb0X5f5aqFPFWk=
X-Google-Smtp-Source: AGHT+IH7+og1xlpSo1KjxvBX6cVnUl4llNG6qDuzOyNqlBivr5CMAMFFA7FG/5rqovphZxKeWwjDDA==
X-Received: by 2002:a05:690c:6608:b0:70e:326:6ae8 with SMTP id 00721157ae682-717d5b83502mr204844177b3.2.1752499798235;
        Mon, 14 Jul 2025 06:29:58 -0700 (PDT)
Received: from localhost.localdomain ([89.234.162.240])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d792d1sm19529317b3.48.2025.07.14.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:29:57 -0700 (PDT)
From: Ravi Kant Sharma <rks1986@gmail.com>
X-Google-Original-From: Ravi Kant Sharma <contact@r4v1.net>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Ravi Kant Sharma <contact@r4v1.net>
Subject: [PATCH] staging: rtl8723bs: remove blank line before close brace.
Date: Mon, 14 Jul 2025 09:28:34 -0400
Message-Id: <20250714132834.79911-1-contact@r4v1.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch CHECK Blank lines aren't necessary before a close brace '}'
FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:631.

Signed-off-by: Ravi Kant Sharma <contact@r4v1.net>
---
Hey, this is my first patch, I appreciate any feedback, thanks!
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index d4dc169e1..292b5f8dc 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -627,7 +627,6 @@ void rtw_reset_drv_sw(struct adapter *padapter)
 	padapter->mlmeextpriv.sitesurvey_res.state = SCAN_DISABLE;
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
-
 }
 
 
-- 
2.39.5


