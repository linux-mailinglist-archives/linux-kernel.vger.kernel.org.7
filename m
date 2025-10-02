Return-Path: <linux-kernel+bounces-840671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EABB4EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA047AF7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABE279DA1;
	Thu,  2 Oct 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ36Cb1L"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760C12C544
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431021; cv=none; b=HU/yaSWCLk2w/wKcigt47EskXlH5Yk9OIeNMetE2pxWgl4gHLearTAXd3NoIQC1MoFxokfcvlI8UmJRciXmqc02GdnrsQWpxcl8ku/N2t+H/uqsDI60mh2X75Gku+qe8KpdXdWS6DIzHX9foy8dHqoAJGV6qmkmyrD5l7xPMIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431021; c=relaxed/simple;
	bh=+5m+4sgTII4yCZaAet+Qp+1LoGf9H06zjUeyc9Iv/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=so2mVgZjYeb7PFJn4+73xtjZAhfC7mft56Y6omo/S6n9i1phcWXX1iJoVdGQFH8QaMlhbXAT0aWxReTfJFPedENYv8jEw9BTIqzBnP+m6XiSK94F/WuBA6G6kydIVfvi8tG+BrkDbfK8AlzzO72qznoxsjpJx76NRvWSlY9wRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ36Cb1L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so843549f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431017; x=1760035817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dRh7hUJcZfRa3tzyKlaq5YbJA/Dgq6bx57UbBqN/vc=;
        b=TJ36Cb1LUztBgvb+g9Yf/pHev1/35FtFS5DlsDFTfyEc6kjPRr8CLdh/+KOnjGc7mA
         ZmJ7XJ52ODB25cI/e5gb2NCf/940mKwrW0+678y+wQ/hbooOl+3teK0BWsZpLZGoV+tN
         31hXBpCkmHY0H9Feo5QJDYdskdQVMas9lR635J8K/Y2Fvf4Z/YO03fi8cAYAKl06NtZh
         i+qUlx+FQZ6mlEFLedRL3jkSyoe9DbiMsvam/6IPD7Gk/bQKE3zL+yYmQ0c4KvRIh/gu
         sSf3egzuBNN08ZshP9aWdtLuZsMOajtdhPLoYFxO8zJx7cO8ao8rree/KM/2wBEVLPvr
         FbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431017; x=1760035817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dRh7hUJcZfRa3tzyKlaq5YbJA/Dgq6bx57UbBqN/vc=;
        b=GOZQtDtIvPWhkvS11H0V+qzN77FvBDyGGVw9YYVVmNNNo5vlQkd4jciQ75IJ+szFl4
         1Fj6eafWs6IYr7J+FoDDd5k64FaNs4v47lmKpsbwAutVedVCyFZx7Fy8T+fHosJKlyea
         HMYqxvWVqLcq5H7qnwVS6H1wZXge8v9eOOiCbM9fDprUBtlt44/W/vFiMluij3dh13Xv
         XsNumePf1CakbusF7uqJCawH7gpuZnZC+RnuFcChZX+B7diIDXy/Q0LxXuZh6TUrxpt3
         fcOqxV+YSvNik1fiKkzjrnUBBOrZdUKRg+9C19mN+H4otIltKQaqpCLukVsN7xG43ORo
         7KzA==
X-Forwarded-Encrypted: i=1; AJvYcCUvr0kN5la3a9+lmu3DNQA2UyoSBm41b7bSxJep6JHg1t4TbKV/wUkr277sd9aR0r7V7VVZvaOmM/giHTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLS7k+sHFqPd7AtKmGdWh+efUNJ5RARvyJiCyj5/Ks64Kz9DPj
	mvo1YldsOdCOdYCuqQ5maYvtCnzZUHt9bRcFGsC4DCPCW/Ve3ptNKm1J
X-Gm-Gg: ASbGncvB3ifxCsqrl9PYRf+lY46yMOEhz/XDJWvRp3Aik+5O7iGJRypcdaIjoatcMpW
	mfrrGYsv6cLlQbBO1lHj/wJoGvIAaZ5sm8udQKxEEKfsFDmnOr57SjiWnREo++M0N1ASmSQ6TeU
	zGo5dNATKTkYbX5MA5RCSUXcHk69pv4u6Dj5Buh+KWV37CYTs/kC09hiL3uCfuLO9NEAGAxXFeA
	TEV8xw2bh5CImgem4Bq/+tlFbLNITLggNXfcEQ4BLcNRiNLYFBMWs/+b65ZgF6KU6bt1SqxxRa9
	FcaDZduJ8NcarGOkLcxdB4h8Ft7qqUKMxMii6745f/EF2GE/GyxOWOoM4NgLBHy1NF4rMt3c/mY
	id/whcOjo0RNKKK9bbYO041lOMkPR3B9vwnFEmYXkBztX81tHkjXnKTfaBN++QbPrGRXFm6/U6w
	==
X-Google-Smtp-Source: AGHT+IG0f8mpS6OQkJvra3BO7swBfZy5YCzRMfDwUCKFbpOkGl9skRSpnUpMfSkKZCiALKsmjFPRzg==
X-Received: by 2002:a05:6000:24c6:b0:3fa:ebaf:4c3e with SMTP id ffacd0b85a97d-425671b3081mr219050f8f.54.1759431016524;
        Thu, 02 Oct 2025 11:50:16 -0700 (PDT)
Received: from toolbx.fritz.box ([2a02:8071:b783:140:715c:faf0:31ea:b518])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9780sm4616246f8f.29.2025.10.02.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:50:15 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6775) Add ASUS ROG STRIX X870E-H GAMING WIFI7
Date: Thu,  2 Oct 2025 20:49:56 +0200
Message-ID: <20251002184958.359744-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ROG STRIX X870E-H GAMING WIFI7 has a NCT6799D compatible chip,
which is also accessed via ACPI.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

I'm not entirely sure if this is strictly necessary. There don't seem to
be any resource conflict warnings as reported on other boards. However,
there is some locking in the DSDT, so I guess it might be overall safer
to just go through ACPI, as it does expose AsusMbSwInterface.
---
 drivers/hwmon/nct6775-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 407945d2cd6a..c3a719aef1ac 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1403,6 +1403,7 @@ static const char * const asus_msi_boards[] = {
 	"ROG STRIX X670E-E GAMING WIFI",
 	"ROG STRIX X670E-F GAMING WIFI",
 	"ROG STRIX X670E-I GAMING WIFI",
+	"ROG STRIX X870E-H GAMING WIFI7",
 	"ROG STRIX Z590-A GAMING WIFI",
 	"ROG STRIX Z590-A GAMING WIFI II",
 	"ROG STRIX Z590-E GAMING WIFI",
-- 
2.51.0


