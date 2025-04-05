Return-Path: <linux-kernel+bounces-589642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19FA7C890
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073E41894717
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBA1EF0BA;
	Sat,  5 Apr 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OIjBXX3s"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6981E8351
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845270; cv=none; b=uucK+TBY6jkv181uYotcApGo7SWgiiQOKx8xomun7ZjBwE7R9pjVU7OA3kkmrzvJ+XDo71OEeNyBfx6j4DPCPQssSU078+/JBu7hPz/e0X2hjGqQqwkHUCxobaS3BhUh0MNGn7Cp3g5uZveW+xg2lV03N5rCazPG/mQ7ntv8tSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845270; c=relaxed/simple;
	bh=h+RAQXYSITaOiNsLe2ePMBjKmCGb+M39CxPGqSKEDLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSDp8m3GZWHKXS0qXmYyXHZT90Af30PFt8Mv/biuVGe8ciEqOrbwsLEJxXjX+jTFLiszbWGicylAf/ZB0sTClaVXP8ySWl3XnJJo8pA0tbVmhzlFUrtePVoxwOLLoAYSjOuajxNMyUWuvFzqt45bMJx3EcyJBz994H5hS5P1phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OIjBXX3s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso5445722a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Apr 2025 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845267; x=1744450067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0XfOP7KXTOvrLLmbA7G7E//9/JJRiC7GmYyGwejK5U=;
        b=OIjBXX3sC5b+avAUbqgke3uGrgIuWUpkfdzx5QETTdfQLm7FknZy/xIdTVY3PlCZ+R
         AqCJN5yFpBIhj0179tF75B/luq7ys4Gbc4SzuW64DAntxp5rdmafB3NmtjHOWRL/270v
         XExTHgivTrO5VuIfVSH3z3LmPtw/zWzyo4xBJ7Yqya6axxzHIYhK/Fyi0gDx9F7T28+n
         SBi6twqYM1d2aRbDdBqlHulvW7zammbeUjHU/GdpvEgJ7rICJv4PRUUJ/AxmdmlhmrrY
         ot4gSiZMu2mU6Q5E3AAJTJhkd+kHwTH+TDarVppiXmdlAg9MEe6SS0u4T6D/7nAiq3+U
         HvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845267; x=1744450067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0XfOP7KXTOvrLLmbA7G7E//9/JJRiC7GmYyGwejK5U=;
        b=DiHqxGFHxylxODZdQzj/K8CAOpDgPlCbXAGdPKCsAky6rZaHl4D3HeizDj+00RnAzr
         bvK1sZRkISwG2TcBtLrZRnNbchi5L7mIuitfIl5d9Ezjk1iiimRnKDbAa+YNhxzU9G6H
         +2YU5jNUHb0T/ItNDnNgxubTpiZlU0GV5eacxFJBXI8o7ik0qUMBZ972SDcVPm7Mtabf
         ckAzla4jNagTMPzBkTXYIvEIMdShYXj3Yc175tzb6Ozb1SYf/M1nsT3UikPXSWNvNt3L
         J5bi3RUSRpAksQQhVm0hd2GOfiWE6N8A48m5ydMfnGaPFfwcdU2Phqvg3lVJhuYBkCbv
         IVrQ==
X-Gm-Message-State: AOJu0YwfQxNmLDpx5hSkW9D8MzvJBS4r0BuJEkQqrbHGBTJurSmjjSWA
	d5E+zTGv9bbno379hecguKjdfW7TGt3ex+FcLRT8wHDhdV8PxYFH91k9BVF3Qbo=
X-Gm-Gg: ASbGncsWcbQa/Vih1JxyWlVmehUh/oPMsaDUTpuXGzvqRoICnOq4S1yUIdx0AdWQBgu
	bfnY/2Vpsh6XiWrEZ2+ZxLzfmv34exRwhlxw6/4uYIUv9wYmdlV7zCxow66+/iOZMGmZg54nDga
	N4ZvAb+exu9ftelRxFikJBq6s0GB/Mai64id5utfx8BcWyv+XH3Z1DFEivbzv8F44BO2SthpJrG
	6q6neYJbO2uBBou9hi3wYsvAQV1ZMSmh83ZcLShge+eWz3RRlb5uV0/XSTWROJcJMSerr85XMT7
	XLW3D0b3UmWyStq/jP1V5eRqEPAnlzctMUlxYB6BnKd4IBXQAw==
X-Google-Smtp-Source: AGHT+IHcPuNnQdvjEZGxLPBJJORKGUlBMvOOsXG2rT8CHe8kehR0JAeRO5Ili3XDX4FIT+2l5nB4gA==
X-Received: by 2002:a17:906:fac6:b0:ac7:b8d8:62c3 with SMTP id a640c23a62f3a-ac7e7776951mr197064066b.51.1743845266713;
        Sat, 05 Apr 2025 02:27:46 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfea13dcsm396143666b.66.2025.04.05.02.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:46 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] pwm: Do stricter return value checking for .round_waveform_tohw()
Date: Sat,  5 Apr 2025 11:27:17 +0200
Message-ID:  <dfb824ae37f99df068c752d48cbd163c044a74fb.1743844730.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=h+RAQXYSITaOiNsLe2ePMBjKmCGb+M39CxPGqSKEDLU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn8Pd/Em6PFcd8tBWV1tx1yEKiDSebSwqn62/rE EtO7onCdOiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/D3fwAKCRCPgPtYfRL+ TjUYB/9jcxIIPsMTxx2e1W421sqRJ6RRbsNfeeXQKkdhnvxfvVIPvAWv+fylKgLnckgD22H/M94 X6vOlHrXjb/Ht/KXedhKG9hdZtZNGvUwsziov5L7RpD4c1rrELvlq53b3mM4dR4MD2d7vIH15N6 Ow+DkVk8K3QH2mgW6jeqUDg+YgnQolddwKBYr77wJ5c7iF5dAMliU1aryv5Nbn0d4/RQ4jEagEE oAc8sc6Pn/DwnvEH/f4ZVAefxVqcwIyR6fqSCQ+q6oBnyseZqNaXTAzpMPCiCwzKoIQJcBFKXQC OxKvqmCUB4nufUO/v8NxIR4gN1bW/X6ET/1Mmf2dzCTrYIvE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .round_waveform_tohw() is supposed to return 0 if the request could
be rounded down to match the hardware capabilities and return 1 if
rounding down wasn't possible.

Expand the PWM_DEBUG check to not only assert proper downrounding if 0
was returned but also check that it was actually rounded up when the
callback signalled uprounding.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0387bd838487..1a9d497f5cfe 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -270,10 +270,10 @@ int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *
 			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_tohw);
 
 	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
-	    ret_tohw == 0 && !pwm_check_rounding(&wf_req, wf))
-		dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+	    (ret_tohw == 0) != pwm_check_rounding(&wf_req, wf))
+		dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu], ret: %d\n",
 			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns,
-			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns, ret_tohw);
 
 	return ret_tohw;
 }
@@ -341,10 +341,10 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 		if (err)
 			return err;
 
-		if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_tohw == 0 && !pwm_check_rounding(wf, &wf_rounded))
-			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && (ret_tohw == 0) != pwm_check_rounding(wf, &wf_rounded))
+			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu], ret: %d\n",
 				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
-				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
+				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns, ret_tohw);
 
 		if (exact && pwmwfcmp(wf, &wf_rounded)) {
 			dev_dbg(&chip->dev, "Requested no rounding, but %llu/%llu [+%llu] -> %llu/%llu [+%llu]\n",
-- 
2.47.2


