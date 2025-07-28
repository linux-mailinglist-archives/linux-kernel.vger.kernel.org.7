Return-Path: <linux-kernel+bounces-748561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5FB142B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4535421DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF06277029;
	Mon, 28 Jul 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhc03HnT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E481EDA2C;
	Mon, 28 Jul 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733502; cv=none; b=kcm8dqgg7bzWJyOzwsVKehTklXdjeaBFM1/4T1SU0MjJnoEpM+jaQc1rpgoPGVGZbtRRIbcp/optOizoA9ccEPMKGBi1+cTm9jHBVofsaItibpw2hwCMfjQyFq25aJ9Gx+TDBvJ8FOJEijCT0DTSgWfyaWphd/dpjXPDX7FogvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733502; c=relaxed/simple;
	bh=vzq27EKg2VCy29xHgaQqsGMLZwzkt8Wg1+tXSx57q6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMDXVzbjhXudldAdTkM6eVurukt0j9JCHYEYDet4mQhkxaXrnwjoyvzhmYlUyNETDmqusGye/qk4YChDwvvPDtP4CSnVeLpCtB7k5QrWLlxdu+zITmO7jzjkSdB0UX5UGJU8BtKThBe/bb0hwo4ybOxbCKTp44DHJjtHK6D+3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhc03HnT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7889ea74cso120054f8f.1;
        Mon, 28 Jul 2025 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753733498; x=1754338298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w8E1AFa1gNNtbJ7eBZ6F/bA2uq/FM/15UHeQIe5sxQ=;
        b=lhc03HnT7NS6V9p+MrGw6uLHcTne5w3hY8PMcHl4vE6M45YrlA6dfLCjAMOxbdYGU8
         32YZeS9nwXCLPl+JeS+qRMlPjW/nrG4pDg0lVMLPihRtz/4pkOv6Bokh4wQWaySitPJH
         cjMmWtDj/j2q8vB0ZjGDJZZxm/JVuZKcETUmxTBmFFXvGKWaqXzawrNS/VXmqKQNlhDX
         fyPKz2JV/Br1BJ0ZaF9DWk2Vi2NoH67qTBgIc+8cCPQT9/Ym8TCOLEapw/+4gV4lt3pk
         c0RvnioeDL/1kvYDURuC/pxBxUxP3JwuuMZ1r1oV/j9e/jHmzfxqhPsZ3L36uOpFFJvy
         oNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753733499; x=1754338299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w8E1AFa1gNNtbJ7eBZ6F/bA2uq/FM/15UHeQIe5sxQ=;
        b=c/lLV7wlaV/9h/VeaDt+km7C58CMv16gd6Oiyfns8vg592+az2s2w2oRqrw7vZ+7M+
         h+5xuL6CvxkLZPxlPyVHDY/plgbxxY5vCxWO9Cu+/AOJoPWOOy4AZZ7kqNNTAMfGWSh8
         XJR8UHpu91rdQEYE0t3pbrmopI9L2s7woCP1DMKtWk/F/kknaq/Mb1d0zhiUgBcGpSar
         XJfNsfF8frMGRYZIwwySkEbtzqIdcGqlHKpJomY1jqzPD3cHBb3+p6pnb3dyIHkLO7nA
         7dBdNoGx6IvNvqfEeHIRqXQn/XozcdF41JMy5bgKiSmowuN3CmdaBd0vHW/nxS4d+8H3
         iH/Q==
X-Gm-Message-State: AOJu0Yzm2MV9nXH/CFSHI0U+ZMP9RmaA+iS27ZBcj+KYIZvFGKB/ogyP
	K83o0SXXjFq/RvQnH3NOCDxV+kL2LKaOrG8978h2HDz90ktGxtKKyOhcy4bc2sjqCJI=
X-Gm-Gg: ASbGncvMOy+rFrJghJESx54RZGKukQ280u1WXd7lN005vS1NHbCuhvQ8PMXk/IR9NST
	YWBLv9rW5jKETs8my588vsnB1N+XBcY76wiAaz2hFM1d8qTSkIaYyVBaRVdIsSTmRE+WvAJcuVE
	aooeSYVvFJ74j+IV6kikj+BT5aDh0KxUF3JcEBCqydVmOU12Pz8WgRrD2bege7nGdVVYpc6vFb4
	C73XIFHKWX8v8ai9oa7UYw4pqc4EmzjG3XpX9mgwItcdL3MXKotO0rnyn9kX/8NpZClu6hktVhK
	FXcefHKJAFFAKG8Sk2yND/f4K/ZuE0HPnks45TrWuCAzYA8nDUnWJB6Gqa3pWhASi7mWFxscEdU
	CPzZvPoY/rAKfVoukc5btF0aOUa/zBcxRsowFdkMVtgr/0+iiPYTOAoTqef4CFX9zYMa3/srYGW
	N945pLsG0S
X-Google-Smtp-Source: AGHT+IFpgGQrIY3SlL5TvH0uVBovSFoJbINfl5NNalgH7sGCD2hRYHlq6e/YI7Y42k7+vLWQIfRWXQ==
X-Received: by 2002:a05:6000:4284:b0:3a5:2dae:970f with SMTP id ffacd0b85a97d-3b776758780mr4077171f8f.13.1753733498374;
        Mon, 28 Jul 2025 13:11:38 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9bbcsm9760389f8f.18.2025.07.28.13.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:11:37 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	krzk@kernel.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH v3] platform/x86: surfacepro3_button: replace deprecated strcpy() with strscpy()
Date: Mon, 28 Jul 2025 22:11:35 +0200
Message-Id: <20250728201135.584023-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728194942.558194-1-miguelgarciaroman8@gmail.com>
References: <20250728194942.558194-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() when copying SURFACE_BUTTON_DEVICE_NAME
into the device’s embedded name buffer returned by acpi_device_name().
Bound the copy with MAX_ACPI_DEVICE_NAME_LEN to guarantee NUL-termination
and avoid pointer-sized sizeof() mistakes.

This is a mechanical safety improvement; functional behavior is unchanged.

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
v2:
 - Use MAX_ACPI_DEVICE_NAME_LEN instead of sizeof(name).

v3:
 - Add full commit message (v2 was sent without message).

Testing:
 - Build-tested on x86_64 (defconfig, allmodconfig, W=1).
 - No runtime testing on Surface hardware

 drivers/platform/surface/surfacepro3_button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 2755601f979c..772e107151f6 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *device)
 	}
 
 	name = acpi_device_name(device);
-	strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
+	strscpy(name, SURFACE_BUTTON_DEVICE_NAME, MAX_ACPI_DEVICE_NAME_LEN);
 	snprintf(button->phys, sizeof(button->phys), "%s/buttons", hid);
 
 	input->name = name;
-- 
2.34.1


