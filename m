Return-Path: <linux-kernel+bounces-756646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52EB1B72E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3A1626C46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521D279DAD;
	Tue,  5 Aug 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="pZK1pKaC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C2279903
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406540; cv=none; b=sKtjoEIVwo38BLy89C8MfmMzkffI14mTTjSKZ/xSYxRfKF99Ev5/tmhErdSwitHWr9zlcinrNRTs+X6wd32hwoEkebXYWbgXB9JFZhIv1BIaY2BViPsQpeyhS/sJ9QDadm0aNjBa6MEM0aZmL+Z8CESg0zqsBu+MGPcRG3NgmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406540; c=relaxed/simple;
	bh=6ooIakJHfw7YXMmRWfrQTaJz2DBq2g0w8g/ZJdwjlOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alPgdgdTYS9zC5w0xa1AUxX4NaU9h9bK01eKHEYpdWrwVmJLuaFYUiLRNcN8h0WlaEbMKj5RiwuDKzSp91SAbuf1C4eBwS6KYWEO2f2N5PZiEYs0xx+p73ldTrsSxGuZffIR1RCaOMTvUGE02Zhjra41WXsmx9LqqlvesDKOY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=pZK1pKaC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so29655535e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1754406534; x=1755011334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1NFToLTMCBICwkF2bXpGG3zLl1KYY37VeQX64wTwe4=;
        b=pZK1pKaCVVqsaJRmnQv9BGUpH8zqjzBDD1nBiFOKVCM/nXjAqrX9qsXB7xGfupQTRC
         LtQBVmRTh1rrhoYBdGj0rgvPXnq/fd1NjhJc57CBF3YEhN0GL62csOuekYMjRJIyR/gt
         No0HVXykylmZICNMVqMVBymH9nBZ/8Oyw5Ld/QiTOTUySBsk96cWX+7CV2UyDYP0dOLk
         jnYNes4AI2IPhcy/HKaaLOZNPWGdCHhnEvbIhqwxtdicD1XFkYjcbm2qXq7Mh1Qyyk81
         V2A0ZL6BN/fBsW7qqGXSP33KHyTI9T7NXpDvHvOCUKWsoMnx+ZZDVWTL57tcFBp8F3fc
         X04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754406534; x=1755011334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1NFToLTMCBICwkF2bXpGG3zLl1KYY37VeQX64wTwe4=;
        b=aGY0/k10a6XUONZfoQF0clg2qLZ2mC7wmtzoin1R9X9jdA7QCse9cCvg48BJAdFgLX
         ig2UsDVIiXtrpRzXqbjMpM/YuxEhuvUAVYUT1JRPdV/+2mXy6Wc8YO1pML5sFq/Jy9sS
         eoydHrdxe00BiWkaRdGGKFw8fNvqVbZdbIBucjQJXPNx0ycXXaLiOcynPpaXOvT0hp4X
         VV21QyPdQCkuANlbZG0lO0MWusM0amxNcFtxCvljFhrBkMth3QX+5Dw0GFfr5kBif0jN
         6/bGqBnNOz8o6jgg14dsUGUi8PPvSbq26QAwc7BrJBjhnQz86ObxhmA04+HkdQd+72aH
         o5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk4K2MvsmeA2i2z87aM++QZDjEpzvwJyFXWRbfbFFc6zOEx8onJlz6frl1Dr9AwJdNKaWitup3vKR/8VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUUeTH1kK0PuNwuYPXJeSYjhASdBjha14zoKwEGimx331aDBv
	Wtdvzm9TFOCO27SuKb8VovouVH8IAwuNthAMh9N4IswOgG4D79qDB0yA6g2Q9UGbj9Y=
X-Gm-Gg: ASbGncu36ENpRvfN6M00ymqZbqtNDDqPgoY9m3VNhGnzt+8LevTMGN1vq/aBEr33tiP
	JcpBQwQPmwXxjtb5r4qZSQBTURAYCUojR/tzYQRtrbFXWpDfwIvjuh9mu4e9qQvJ+SlRbT9BktG
	0/+iIkkR49ajgHndkHVmKE/vjOJOwYHbEw1mQHR1/PPlfQi3Fc8yL68Be4gSpEbWyI4oVrAiVx0
	5kklvlZHkC2Jh/OPOQt2rAbW+1biAPPZr3VeZeIuBr7uDktILQjfIGO/Y/CPj8IJhnCG1rdJwXn
	P9TmDoGMxlvNeBzJAs8Cl7UajUMU3hmDjAyNoAelqV93bSCBxkNx/aLUxALg9wb+XkTDkS8h7Ls
	oaYAVxAuACVeFOBPN8jW4mmc4zFb7mrRf+tUPdPMbxLNaoMpX
X-Google-Smtp-Source: AGHT+IFxn5pLwK5DhH3KCFQWy4nsv5vsgTiDMhFW15HhwD65qkQk4OJb8IifzI8vS1mm024ju4SDkg==
X-Received: by 2002:a05:600c:1c98:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-459d8c2833amr66948015e9.7.1754406534167;
        Tue, 05 Aug 2025 08:08:54 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:e77f:3816:a0b:2c4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm19264199f8f.52.2025.08.05.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:08:53 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: linus.walleij@linaro.org,
	dlan@gentoo.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH] pinctrl: spacemit: remove extra line in debug output
Date: Tue,  5 Aug 2025 17:07:01 +0200
Message-ID: <20250805150701.129113-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debug output for spacemit_pinconf_dbg_show() prints an extra newline
at the end. This is redundant as pinconf_pins_show() in pinconf.c already
adds a newline in its for loop.

Remove the newline to avoid the extra line in the output.

Example current output:
$ cat /sys/kernel/debug/pinctrl/d401e000.pinctrl/pinconf-pins
Pin config settings per pin
Format: pin (name): configs
pin 0 (GPIO_00): , bias pull disabled, io type (Fixed/1V8), drive strength (32 mA), register (0x1041)

pin 1 (GPIO_01): slew rate (0x0), bias pull disabled, io type (Fixed/1V8), drive strength (32 mA), register (0x1041)

pin 2 (GPIO_02): slew rate (0x0), bias pull disabled, io type (Fixed/1V8), drive strength (32 mA), register (0x1041)

...

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 9996b1c4a07e..fb361f2acb54 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -707,7 +707,7 @@ static void spacemit_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 			   spacemit_get_drive_strength_mA(IO_TYPE_1V8, tmp),
 			   spacemit_get_drive_strength_mA(IO_TYPE_3V3, tmp));
 
-	seq_printf(seq, ", register (0x%04x)\n", value);
+	seq_printf(seq, ", register (0x%04x)", value);
 }
 
 static const struct pinconf_ops spacemit_pinconf_ops = {
-- 
2.43.0


