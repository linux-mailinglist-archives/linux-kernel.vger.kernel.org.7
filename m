Return-Path: <linux-kernel+bounces-735986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D32EB09649
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91883B581A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB522D792;
	Thu, 17 Jul 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSsxf+lb"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6021931C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786483; cv=none; b=B9AZqImsIZ6PVtQ5QNjZ1ygrOlu0MTGNBq1krHkqQ4q1wNO2OnktHatblXDrGsNGLJup67oQ8LjJlyw5iylCujk0aGUGaKdhXm4Mqa5sm6seQE7Uh4IO6qM/L8pXATf25JI660ZSHpG5apRwS+SI70OMDqMAx8HkdNWX3kZsfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786483; c=relaxed/simple;
	bh=pLMULtbR7Mi36wm5sHNfAi8NZTboQaIuwwPi+Z0xfX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aLS1s+c9Rj9wNGu/EZUIktMFOwg1c5hqEj/t9K+XaMaNU48mIcwGcZ8ZGozTS2ySDPE+8jHg4OKKAxPBoiEea7FewQ1iYPsySRK357A0z3EU3L5bXxmDXYhpFQwhLKV1OQO+QUC6p/f6A2tBZGAZwmslgR+NtmVg4+VnXuYkh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WSsxf+lb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b54cead6cso1059189b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752786481; x=1753391281; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwVNNL27C/8v/Jco5LCt0KQdKVLnRsz6O8n6NQbyEVo=;
        b=WSsxf+lbOVTYxtRDiaVKWEAp/JRr8aDUx4mOeUZNnYgZkQVq5M/eSxVJrjECaqu138
         vjbKWwgVHyquaDayVznrC5Tgn5HB0tRsL71pDB41wnvIRjSNFkFvawG+DI5A5o7fui2h
         PKiGrzXWleCQp98X5u7g8sAeLMYhaXMLhrpbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786481; x=1753391281;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwVNNL27C/8v/Jco5LCt0KQdKVLnRsz6O8n6NQbyEVo=;
        b=Zdn7eXuIdQvk/lqWgQBWB/Lf/2ZVocoGNyMschNDizB5NcK9dCXwFWQptJhqR25PG/
         4RAtsolDIUeWfmFBY6YVJBd9Xz6FGh13FYhN5G5YFfHV0o2KqCio7qo5k9GQ2gJsFblB
         LKU7OZyFVTyMEXKP7N28DFyouhtBlfgToPynOW0uR0/W/RMI5kjiKnJhI5T66iz4YDdY
         KRI1cafRXQyu69marI3KyFy2THU16dbVuGvkg9aLBAAo/hAzPK/JGLwFtIy1I6IbDlm8
         jJ8hEizT/fCQmp3ydAZLa0c+nPUDvE13rbQ4QF+nYzfJzIgkFwICmfa6MzI1wjW7MNm2
         KZnw==
X-Forwarded-Encrypted: i=1; AJvYcCV0O9lRy+OURR3Raqu9tAOITGE/ssYeklNrHMOjQzXWMH7Zl01m5HOMoBbqUkt2mKpr1b1QKVIUV4kNfcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+I2ijGBUhlnO9qkIPyKDPVONTuzGI29vFeK+Z41IZo0dki/U
	IfVTiNayeSYAOzCdg/CbSLrO8WNbzp9co9Cbi7a4KgRPEbGX5B11CyekmOZKuCronA==
X-Gm-Gg: ASbGnctbYe4/kylkFp3LCuT7spDMEtmCX1p2GX273kb0S0RTEsv/lNL8ncYH2rxVu3y
	EwDI2JMa3iL/pnpU9CmRVCTIG6R4+/ID44WXeBycti2oRi8XdqtjNLEzk2jsclBQ3MNf8Eu7eNE
	X+d2MznkKJMWEK6VB6AGo/gxarHkPamKjpKU9s048SeTtxe4LCS8GXeedzd3R86I0hyzfnF373j
	uQVVv9XbquKAG3cFyKXGbgDHL18+C7rFQ4Akv/ZwPzHiAE1zeYjAIS7hvJGO+8jPUXZBvz9wXCp
	CECF5/W7pcacJS+aTTvk30uTfBiF303dKhvQP6orjTN+Sdjz/be/Tu605tzFHfXEyzI4AxecbWS
	l9OEDWwWmcur+KIJOMZbn158B1wL8beEJIwI1BMk82mGCkX/jkEmlCePN2Q==
X-Google-Smtp-Source: AGHT+IEjUQhKWeMrNlt46k+ZOp1aRm105kzkupmgP226CRF3hn+ijFji8oRaUQW3Qvu3wWzG+qSDDg==
X-Received: by 2002:a05:6a21:6f13:b0:230:f3f8:6708 with SMTP id adf61e73a8af0-23812a55d38mr13625491637.34.1752786481609;
        Thu, 17 Jul 2025 14:08:01 -0700 (PDT)
Received: from ballway23.roam.corp.google.com ([136.27.48.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d5820sm754b3a.52.2025.07.17.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 14:08:01 -0700 (PDT)
From: Allen Ballway <ballway@chromium.org>
Date: Thu, 17 Jul 2025 14:07:58 -0700
Subject: [PATCH] media: ov8865: Preserve hflip in
 ov8865_mode_binning_configure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-su-v1-1-0f740fd8bfb6@chromium.org>
X-B4-Tracking: v=1; b=H4sIAC1meWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3eJSXUuTJEML87RE4xTDVCWgwoKi1LTMCrAh0bG1tQAoq39hVAA
 AAA==
X-Change-ID: 20250717-su-94b187fa3d1e
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Allen Ballway <ballway@chromium.org>
X-Mailer: b4 0.14.2

Prevents ov8865_mode_binning_configure from overwriting the hflip
register values. Allows programs to configure the hflip.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---
 drivers/media/i2c/ov8865.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index 95ffe7536aa6aba814f4e5c3d12e7279470b2f07..40a852d31f13aff960acfd09b378d71525e19332 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -1746,7 +1746,13 @@ static int ov8865_mode_binning_configure(struct ov8865_sensor *sensor,
 	if (ret)
 		return ret;
 
-	value = OV8865_FORMAT2_HSYNC_EN;
+	ret = ov8865_read(sensor, OV8865_FORMAT2_REG, &value);
+	if (ret)
+		return ret;
+
+	value &= OV8865_FORMAT2_FLIP_HORZ_ISP_EN |
+		  OV8865_FORMAT2_FLIP_HORZ_SENSOR_EN;
+	value |= OV8865_FORMAT2_HSYNC_EN;
 
 	if (mode->binning_x)
 		value |= OV8865_FORMAT2_FST_HBIN_EN;

---
base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
change-id: 20250717-su-94b187fa3d1e

Best regards,
-- 
Allen Ballway <ballway@chromium.org>


