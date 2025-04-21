Return-Path: <linux-kernel+bounces-612437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B140AA94EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF291892E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94826258CD5;
	Mon, 21 Apr 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EJ4zcCi/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721125A35E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228654; cv=none; b=KI3+Udp5du6KJ6WJkJBIYtG2qS/ecKDrSlePws7FATgX9IU+9v7WHGSlfgXsvt5pg5jombBQOdJgoRqvuLFwscQlSR5ttijkVaItpV7aahOjCp3/Kvzwjlun40ai5vwhMDSBmOejEnXPrIZm/l8xGioPEMyNlLfmv30edQx/ygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228654; c=relaxed/simple;
	bh=HTZHrX+QD3w1gIgaVzbbMlu+aTdm2k5g1RRT3+WvqSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9u4Dk2GkauXC5d3c4/5yR6QQLNqLvHaxjYn0Qg/AgBgAxBFDP2ZDZ3ZEbnlsMNPm59MZ2mSOX15fZiUWy/I4MzGcL82aDO28K/SDu89EG7LT4Xf8V1Rj8RH2VzX7uClaHTJwFoqXqzUB8PlW98dtebVh606FqFo7IagmYq3prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EJ4zcCi/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so3418130b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745228651; x=1745833451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um8ly0YURJhIZsPOAVFkm7bN0ZzL1kP1o400anZrFdg=;
        b=EJ4zcCi//X7Ayhw1v3BBrs2xC2RExi9KrekolRcnhJQSQhZySbiZCayZX4EbiVqegC
         iFPYJvU93JsLVQBc7AcQ+ipB3Tzhf12p9HshL9SPwiZPIP051f4yDmP3tk11Fprjjcfv
         9v+/v4koqNoH0BrnbI8ovkJEjuTLwIG8YFOQh2sYiQTVunZ/Po1JNxJQiuX/VkqYw/ZP
         gYmWhJO3OAzzjM3O1xiGvstc2ZG1dgSyxiPPwWEY5ouomDRBJSEQ3ABQQeEMBTGxwstZ
         SBYibUf58MKAL2RchK8ZptNV8N9KYsmRYAfXBZoLpP/ZdTfTHh9sFMy4qvtGTlc5sJ9f
         8ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228651; x=1745833451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um8ly0YURJhIZsPOAVFkm7bN0ZzL1kP1o400anZrFdg=;
        b=CdGhfZEiq/ALIbph0LBOvK4yNbG+2qA8c5x8sWT8VKfEpYPRLx3RCrlzzpKI4Dyj9U
         AjQvw7vnwzxjnktdPjkjpkYXfodyGWG7y4MKFnHC2e3js+LrNP6bKN8SokTH1farkIht
         hELn8PYb8VkXA19zY3PQq9SwNAGWUv3p2BmRUHo8NLRITV++GQZmgZ/31CKLQEzsD0AX
         pNz2F5CHbJUsoJFl1ool3NNBWDGl0739tmFC07cqBFa7JIJHA4ga2V3K90zJzUowCSnc
         zq+1WR8+h0zl/Pga/qTKVr99hNU6zB9nX+RV7QvmcOrqvgdUQ1YKtagcB5qV16SrSDuq
         92uw==
X-Forwarded-Encrypted: i=1; AJvYcCXCnQ4Ns7qGBp+MMnftcJv4nflqa0cnA1oqfGCi/+DVtgJ8tJ4Th2q+rjzt2Z32jXgf351H+yT0VB4l3a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFly3pMgdzdYdRDffMtpIAeyr6Tq+ERfOHwbdEJ0QXQ6UbnZlJ
	rX+qprhxv49rLlMVBVJ3/rj8pPw1+fbmGUxIhiIJt3pArqEC3Rt/xQ+h5H6q4t4=
X-Gm-Gg: ASbGncufemiOLh6QHLv8FnepolADD35BlIYYVfwMMwib8DvQ3HS0D5rL/WAlG4BUF4m
	dh5cwKcfAW9+2HjjBC5XWmOgmP1Gz8VU4YpoOR9fevmm4jXyf4FNnnhV6mNHE0Zf2+fz+SqkqjN
	fqHPTPNQZgqkh0OsS0dsDh3t5AzJNY76JNpH7yG6kaDrneRlrvIVaAnLkoDMQgGZJqHWgqL25Mr
	JIsSkjW++QMKv/2U0IZ2gL+OjVtN28SHFOjsHpnjKMy7Za3oU+Sel6+5vbj86+ifg3HwEFh4bcl
	wOBaw9+FyHsi/+4d7dFcbpmA/je/TNnxBinwqCossdFXozey+vNuhNvt4GhHOdtt6xdMbVFCmCK
	ySQ==
X-Google-Smtp-Source: AGHT+IGhB4JLMo8xKvJ4+oFdsJWwteHF/WDSaTr6oGU66k5hwiWHHJcvohJuF1VquOrooltC9l1OFg==
X-Received: by 2002:a05:6a21:9203:b0:1f5:86c6:5747 with SMTP id adf61e73a8af0-203cbd153c5mr21074579637.32.1745228651586;
        Mon, 21 Apr 2025 02:44:11 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf32sm6371965b3a.142.2025.04.21.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:44:11 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v11 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
Date: Mon, 21 Apr 2025 17:55:20 +0800
Message-Id: <20250421095521.1500427-5-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421095521.1500427-1-nylon.chen@sifive.com>
References: <20250421095521.1500427-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix PWM apply and get_state rounding to ensure consistency between
setting and reading values

This fixes the reported errors:
pwm-sifive 10021000.pwm: .apply is supposed to round down
duty_cycle (requested: 360/504000, applied: 361/504124)
pwm-sifive 10021000.pwm: .apply is supposed to round down
period (requested: 504000, applied: 504124)

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 6259f8500f71..1404c383461d 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -122,8 +122,8 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 
 	state->period = ddata->real_period;
-	state->duty_cycle =
-		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty * ddata->real_period,
+					     (1U << PWM_SIFIVE_CMPWIDTH));
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -157,7 +157,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
+	frac = num / state->period;
 	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
-- 
2.34.1


