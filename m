Return-Path: <linux-kernel+bounces-824078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533DB8812A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F551BC69FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226D2949E0;
	Fri, 19 Sep 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqI6tNjO"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD332C0F8A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265208; cv=none; b=oSHRXk/6MBcD/CmkRflKQpe82luQ0kQG1AUvbogpn7ea0Cry4DhOJMgwDoULZu7EP7u+7yoMbXbcShQDKzUJXpmfVhrdvV2LlPqTEb1Ejnsw+D2mLtejQitBLGs2Grsg3S9mJPN/w/MfmK9KkMfzHYW0rfosaWGpX77Kmf898AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265208; c=relaxed/simple;
	bh=uAk+KA/2arGgRYi6RKljz+pNp4Iu/ABT1xGE3Hki/kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rq2+sMWbXAd1Xg4mQKav2ryXDlwA1GS0aV2FVCTCo1sL1Op8z0G/SXQ5JWhByZQ1uwqIz6jCoN7hxlFUsqY3xm2x3Q+QTvcU2MY0rsi7sjzyGNXkJkZM5q6io99PzgieXbbnt+aTa6feISj/YMVdpszKJ//Wa9Ag8jkjKqq4MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqI6tNjO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77d94c6562fso1501372b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758265201; x=1758870001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqB+YMZcuLYAs8+OHarhQxNJf94rd8pAU5DBCBmw7lU=;
        b=PqI6tNjOWce3MJsbjzGtyDHkksJ0/LkABbBStkw/InSXyyhJo64aF3FiZjAZmBv2Av
         j2j9ThiMZg/HmpDZJiHqJURSblgvgaAonZz8uUWGjRP0r99XCLY6y/gQfHGsIXuER3WU
         9w+CSbJ5bYB48lHdQ3VlmSIUsKZs609zeQuDvDQHk3fCcHwhSte5cXtFg+U1d1/p/wGm
         77qxX4jMZVAmplZA7EDdQBo+f4cDpgNfc+MvRquUl1dvbHa5VkArHg6h8yHg7XUOxUP6
         +aWqH4VjoDyUSqqqjB0iiGukmm9+ie8I9+uOu1EH5MTAVdij5EMe8ki3GzJQO8SBk30e
         DWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265201; x=1758870001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqB+YMZcuLYAs8+OHarhQxNJf94rd8pAU5DBCBmw7lU=;
        b=q9O1cAi3MvSy97VwIoQokrK1NJUe+SXm2ZRkru2/CMOOzEHGh1QhvyhLxW0xn4SirE
         8eYOlLGSai6whT3hdAmuLZCNBT/tg0D6bhqAcYouu5irNxhNu1x+B7Adqk5gzy6GSzk0
         MZewVM3KQ3Y4AEnVB4AtS1mE3QJ+BtMKt3M8FdiSnlnRGjLerXQJ0/R2of082ZNS74kR
         Qe4N5gcxjR2MadXCTuHfklt9twrAQ4LOykIg7Y3MAemQ/hWlw08lD7Kf5Q2T/s28xrgS
         2jRv0qzG7aM0/oybqqvGA8bpC5km0gTEMToWvxJvvrCDfatmBq7yFA5TIHjpfvly/0Ad
         /LSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Zdi+tCoyYAgAflzBGMtmUUmEuqnzrTC3zoG5uele3+7/RikjUY1eaJaOA1IPX+8qv5u3qipO0E4/p2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bn32NHRQdJOKf1Gbl6t2+2dMiT38xFe8RPJLzz8orA2vQlVT
	Wf8X+XtakKyiTCHoRS9UfHTYntkLalaHIXX96jcS8svCIHq9QguIG4DB
X-Gm-Gg: ASbGncuOqChA/rsX3aH0MdBsbXVqXBmINTmj95rUnCQH/dG2GLORYrtBnwz/ffPbxmX
	n4ffFnLZI5ze9XnBhadazDPqS+u3e3T/WvviVZdN5nJ9aZfu9d6EhKubvUY5N9MXpha0nfYK+Wb
	6Lo7nKn19uipATFmiVweOnyWYYAUcfKtHb6FQk0uWMghAoScTB5VEFAlOnGbxahuuestunAbFEa
	U2lS4+mu3kRX4StHM5iA5bY1GKAko/q++WUKTw+b93YmLnviLmRdF9CLaRdoOY9/8Rw0nea65Zk
	tKjOZIVnMxKENnSO7aMhn4anQF/9c+4rTlzDCvTfoS9AwCbpZFrEqBUKLZjKF4uOf8MSqC0ikeQ
	JLpV/fDFhqkVow40PcciBeKSo2w==
X-Google-Smtp-Source: AGHT+IGRyWOudoRi9Tem9txO7j0k6xxGJSz/N2dM0RUuqwAkPE1QePAX965M+SCjwpij//u2J7rKzg==
X-Received: by 2002:a05:6a00:4b55:b0:776:1a2a:6baf with SMTP id d2e1a72fcca58-77e4f19fe23mr2906611b3a.32.1758265200897;
        Fri, 19 Sep 2025 00:00:00 -0700 (PDT)
Received: from archlinux ([103.105.227.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm782455b3a.96.2025.09.18.23.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:59:59 -0700 (PDT)
From: Harishankar <harishankarpp7@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	harishankarpp7@gmail.com
Subject: [PATCH] ACPI: property: fix spacing around colon in pointer macros
Date: Fri, 19 Sep 2025 12:29:51 +0530
Message-ID: <20250919065951.156362-1-harishankarpp7@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix coding style issues reported by checkpatch.pl in
drivers/acpi/property.c. The colons following pointer
types in macros were missing the required surrounding
spaces.

This change makes the code consistent with the Linux
kernel coding style guidelines.

Signed-off-by: Harishankar <harishankarpp7@gmail.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96..8905a8b34 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1108,10 +1108,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				break;					\
 			}						\
 			if (__items[i].integer.value > _Generic(__val,	\
-								u8 *: U8_MAX, \
-								u16 *: U16_MAX, \
-								u32 *: U32_MAX, \
-								u64 *: U64_MAX)) { \
+								u8  * : U8_MAX, \
+								u16 * : U16_MAX, \
+								u32 * : U32_MAX, \
+								u64 * : U64_MAX)) { \
 				ret = -EOVERFLOW;			\
 				break;					\
 			}						\
-- 
2.51.0


