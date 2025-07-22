Return-Path: <linux-kernel+bounces-740900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E8B0DAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61A53B7F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD72EA16C;
	Tue, 22 Jul 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2fhEWVT"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8652EA72B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190913; cv=none; b=g+64EMWMieqtU2Rl+JWUHcMMcwI3aaj+E9aV8ADwxQj3FvgiwGF+xnI4bJPskmRy1hB68eYTx1ePNPGJlQt8KAjys6CawdNUJNno4Fa16pz5Qz4rqwNJRh1xNxYhgHhSIgijNoktG6hpuLASYRDYzYg9knAuqfRl/tEv83p/tqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190913; c=relaxed/simple;
	bh=lZfuCpsNtCDFtD2mIkqfNGc6k19kTKUYwNokWS/5tAM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KEtzQsv9Jz9NjoOEJEjUbENYnD7ps1NKOA96xzaxnbPS2XoEFfjdt4juZtJo32mNDCCiWfi+H7mxgdiP2TqGwc60mubwbWuTGew8YHZPmvAhLOCa3qEEnhtDXL0laoJxzPZFiAu6W0YHVaIvo1VdFHuxYKOatpJkX3UaP+nC4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tmichalec.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2fhEWVT; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tmichalec.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-60c6d568550so4595701a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753190910; x=1753795710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2ZdCOMadLYtwQ17YQBl/MkVa95WXMm29CGtxSF5vMk=;
        b=e2fhEWVToHDrG9kXVGIfRQCH5ADIQkXLo/RORrj/O8WgSkiUKCPwEqTWVXI1BJjSAI
         PtaS0rON2xCalrXM6KBf5nmeie9QSPJWCbtGogUxJKthpUHVktfw4zdxKvQzUw4WvFIG
         zL8DDcCGCuKwAEbaCkkheOvQrMcoGlq6814T5grrIjEfV4JFFgCBhwrKZzY8lqERKGjr
         sUnPPTl/zbTKL52yd/uivhtmgHtdtMGt8g7aZJipRUmf5tmSW3wGPxyd6QfaM7u2yKuQ
         ZkdLqtrRFY8nEKHHwOHVz3CTnW88gOMjwS1+wV437sizB5LWYpf5GwqvoHhizmE0kgya
         O0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753190910; x=1753795710;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2ZdCOMadLYtwQ17YQBl/MkVa95WXMm29CGtxSF5vMk=;
        b=u8D8iYC2V1amRhh+j81HYNV6HrTpzxWR/wlG0K4ps2ihh/C1xZ4+gtlvlWrJkwKp5u
         HJU1A/bjiVJyGBUA5/noqXN/vLQNPHFmp4a1CIMDvsQEY15BJnQ37OPn7joF37SGoRri
         puUr/KGuQmTq69ELnCeogHD55/Ivilb87zVQYqkq7ifP5OvJbUxKfRCpYGRV2JtMTmQk
         ffsPqlcXdljE6ABXhjFyO5NDxESttw8SXL4FgGfFFx0CKIEJCuvOxxSNeCrl9SN8E6pw
         WFOD/780gFFSjgsrcq4X7P32bMM8uHPxW8+2BRXBq92zaXjOrhPxgZUHniKjlLxDrgeb
         MVjA==
X-Forwarded-Encrypted: i=1; AJvYcCVPCb6yp1YRDUD34VmxM5bOvNj1WjgHfaewdIFORARHKQ5U1akK8ypOtL3sHjx5tfpUWe956zKVQPlt590=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm15SqL7d9pDL8mn+WyCWHw9wTrJv9cWzUzqnRO4vPFfeqaOje
	cdzSgAq1LqVuoUHvkBA1KKTYrd4VrCtnXbFUUtuurfFWCZXbtp5kehOw/FmNxyTqf/IS7hpqUW4
	4rmL0IcNStOFLxy88Gw==
X-Google-Smtp-Source: AGHT+IHhABfNDI6aFdSjh37rLs3eT9u7XfYoSpwrqg3BaY2FdWTG8XAloBBVS7kg58Tqg+LF5DEduLfWGJgT9C8=
X-Received: from edys5.prod.google.com ([2002:a05:6402:17c5:b0:607:3229:efd5])
 (user=tmichalec job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:270b:b0:612:c928:ead0 with SMTP id 4fb4d7f45d1cf-612c9292d12mr15692866a12.19.1753190910362;
 Tue, 22 Jul 2025 06:28:30 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:28:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722132826.707087-1-tmichalec@google.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: Check ec platform device pointer
From: Tomasz Michalec <tmichalec@google.com>
To: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, Konrad Adamczyk <konrada@google.com>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, Tomasz Michalec <tmichalec@google.com>
Content-Type: text/plain; charset="UTF-8"

It is possible that parent device for cros_ec_typec device is already
available, but ec pointer in parent driver data isn't populated yet. It
may happen when cros_typec_probe is running in parallel with
cros_ec_register. This leads to NULL pointer dereference when
cros_typec_probe tries to get driver data from typec->ec->ec->dev.

Check if typec->ec->ec is set before using it in cros_typec_probe.

Signed-off-by: Tomasz Michalec <tmichalec@google.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7678e3d05fd3..1ef181614d4a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1271,7 +1271,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	typec->dev = dev;
 
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
-	if (!typec->ec) {
+	if (!typec->ec || !typec->ec->ec) {
 		dev_err(dev, "couldn't find parent EC device\n");
 		return -ENODEV;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


