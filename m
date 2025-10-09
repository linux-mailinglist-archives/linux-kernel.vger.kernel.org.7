Return-Path: <linux-kernel+bounces-846425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70116BC7F59
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D00BD352725
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A226D4F8;
	Thu,  9 Oct 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZFOkJJZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2525D1F5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997630; cv=none; b=T83Pq0PjrfqiC+xxCUA/VSRczF1S6YWeJbqgNEYzJ1c1rg+ehLNdivM+aoAfUQBB6pF6oXaWVbMBHvelCuRluSuHneiWTu8o3IYfXaY6paN2uB9iVkMYQkbuj5HHJZA0XEbmwK0mzT0IkOQtG0uDfkotV1CYI9ws7Lgk0SWDImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997630; c=relaxed/simple;
	bh=TN+/HuIl/tElekawhDQJfAyvvcptYtxxwnziK+Ps4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8P6sLYjzijL8cgGQMOQEOYYzwjnFsJ88pASOvEICgnNrWwQcbJzL3cNYkSWzrYAIawbANlQ15r1Dk/tQc0MSpIh7vm+sg1VI5a0BXFy1VloISGpgmuBG9a+NABw5n9wkOdE/Ii0THl5FC04TsUl2HFiE9EE5Geo31kZcs9va2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZFOkJJZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso2237542e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759997627; x=1760602427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q0cueZkPHkbn6Q4Lj1AUdLj1Jvz61p6khKCT5+d0BY=;
        b=iZFOkJJZ2hZM1ToA2JXSPoMV0l+9r87uiP0qBIZx0/KAFFIeKyJXAYs0zPwTJ4NDfo
         urHlyqAH5KKxXE9L0+o/Z9ob3A15G7tJcSRx56GZ1d6iSkXwoAh3VA04qF90/sNlHxUH
         0ijL2bTrc54wo6NOyesolr2e3uZL5+yDwTl7NN8DSzBAoZyGdPMnNJTU2GQjwUjB2jaM
         w3AtYPCBVfLpdbIxbDrfoYA6LaIYankkcM/nIfihDz8VpFoIevnc2hRClG/WrTwjhJIe
         Vjax3zpwQGACQh4tCi9fNxgo5X6DUWOGgqqcZF5NEM0Zo9Mhn7ZfeS826yX88Ax/pd5J
         drOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759997627; x=1760602427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Q0cueZkPHkbn6Q4Lj1AUdLj1Jvz61p6khKCT5+d0BY=;
        b=C4/kspzzwPA3Ae5e6qudXWOiPGbuu7R3+JAqq8cRZtlZz4NUMwolZzVnIRlucHd8E3
         jZa1tC7oIPLJQW/kZSFK/KrBs3ooh5E8X8JrNj6+Bkbw/q2srqM1F91qi8ob5X3SqIa7
         pT5lqqNIFpgHc5WATK+qF8hWtNXV2TK+NcpATpf+FB/o0MhMJ7skNBrerqgTTztsHGa6
         XZkLHAxz/ZPoVnXm34tUUS2ARBUODCi7wZrXkKvSDHR4FfAJXFRmW5G5FLc3SiGgTxo8
         kz1oydHotN6ThU5vDW1ito87IqlwKARGlOKlGJzN+4z6gZ0oA/vjYZWoEUoUq5plgf0Y
         t0gA==
X-Forwarded-Encrypted: i=1; AJvYcCXh5lu50hb36LhADoBARA8HbhHGgXyd/OICbEfTW9BbXjJ+O61KPL3L6I1XiHljjTwX8jC8sx4bHAwRmv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4gdNYq7LQ+ek+6sPdv4oSHNtPCvBOWNWKrk1/2gbJWlyH6qD
	8p1plW2eNjEanhZEklka0nDFIANqU3+9/Xu8CCTYsbB2dGv0z5vFy9zMHzNxcA==
X-Gm-Gg: ASbGnctnynmWQpc4r1ZRehrDsbKZ0kRN4CXDxKJh0g/k420IYcqQW7u4Su3HMI8wHbJ
	tSA0VAe8br9EIVe7c6zsDTf1NeMRyDHVaixXQiavDXkldhv9repmGKjzcOKrYpA0glJzo22AzuU
	t1+Xjk6M77st1IMHJDRFA5JYD8QNA6r7elUEZkpAEVyWy4UcDgvqcrCh1i8vp8CfzuByMP7I+1O
	5Mqi8xT5Dz4jsbkGJZ6T/qqEVwjlC83Tx74FkRDarPeV5/Khc2FRkgexQrrWoHd/60qF79abJIw
	5Lp5E/GUpEE0V9APMZttIU5d/AigfhWSlTZKolGmOxWauNd28Vr67AQouikUt+/cMvxWX5ypLz6
	FdysZYI7PLHoEmpmahHff219ZI3Ugs8HalDE8TOQQVYGdpJXj1fpfykr4XolRc6WseOZ/zMyuvr
	4=
X-Google-Smtp-Source: AGHT+IF0/FL6ISa07AMBLLSvo94NRr6Rl8+hqLbT73ju1TmIjYqpED4v5sik8/wuf7B6D2qEqWjVOw==
X-Received: by 2002:a05:6512:3d26:b0:586:a95f:cac1 with SMTP id 2adb3069b0e04-5906f3107bbmr1954853e87.12.1759997626591;
        Thu, 09 Oct 2025 01:13:46 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907aeb4584sm822206e87.125.2025.10.09.01.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:13:46 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: handle reset control deassert error
Date: Thu,  9 Oct 2025 11:13:08 +0300
Message-ID: <20251009081309.2021600-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello maintainers and reviewers,

This patch adds proper error handling for reset_control_deassert() in the 
DesignWare 8250 serial driver probe function.

Currently, if reset deassertion fails, the driver continues probing which
could lead to operating a UART device that is still held in reset. This patch
ensures we properly check the return value and fail the probe with a
meaningful error message if reset deassertion fails.

The change follows the same pattern as other drivers handling reset controls
and provides consistent error handling behavior.

Thank you for your consideration.

Best regards,
Artem Shimko

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.43.0


