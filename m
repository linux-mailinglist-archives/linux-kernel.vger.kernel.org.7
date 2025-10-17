Return-Path: <linux-kernel+bounces-857533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79714BE708F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340B062445B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C926738D;
	Fri, 17 Oct 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bQ/CSqVm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302662620D5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688172; cv=none; b=oiS1ZGOf902gngKnNJQEo8pXCa8uBkBvlkuS7WrmNFs662d96MFAbdmlAMZuFZDqfP+aKUGAyUF/JpOxyK7ondmgdfdLvbD8+OhS7PW5z2ibF3dYtb5l8zIEmasqRDLPnBShA96+coILFv1dSHJr9uqlVMufGn/OrXSaDenoHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688172; c=relaxed/simple;
	bh=ahY8cqJej6WQifsWXROQdHcvhwcArd92M4vlAfVPn9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHCNV1p7h/sDs2BjGK2XNoOwiciNQSm9RmF04jhqIQlCv82dVADnZLgqNHVttObtGO76BihBLCF8o/KVYkw62Q9m+udtSV+V9JEvCq7AFX33RciloxVkAsKZJGl3UR7n5y0WG20gL5b74DK63S67sIR2KNKxDUBRETbwntLx8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bQ/CSqVm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471076f819bso12725795e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760688169; x=1761292969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vpqXmEuFVERfrJK4S9HS5UBFe3EstmRsCR0kjyhhN4=;
        b=bQ/CSqVmk6cN1pQIse+GIuKyI9kt9zOtevYx5YpVrzmJKx+hTI3bSSczH1pkIQyxG3
         g2J9+cpIN7cYt9VMROciB7QJ9MLqkC3qJuJIeowPVuHmE5xNUqHlqY8JwYV8d8pZY52R
         EDA9pahgx7e920c3cwcygBO+e2s7WLkkP6ibLJWERxC4MTIDGsljqnPy51tJ/XExk4Qz
         K8KVUpTgEx99F0VcFZF1d/r0cjgrKXU66CAMNb9JGo2ejGBEcvAgnSWsklTzCj18VQPM
         nPnFN1flWFygyb56RO8VJsWT/KqyK0TaLa5eGxcY0Sqq86muTzMzjFvDCwkcHwSsClVH
         YMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688169; x=1761292969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vpqXmEuFVERfrJK4S9HS5UBFe3EstmRsCR0kjyhhN4=;
        b=gXEvHpJJAj46S3ZqKUoJGnohSkeMKEpld9RnY2IMtstGC2exeI3zzojP0/VUiwwv1e
         Y6NBXydfNsSziYSzHRoVr1Hlsdz+aPvzgz7b4++Eq4h1fcoEZCrnvdbt932l4MYGGvvH
         G9OfcynFfiEWS6ngmBQardFd4adTVEXcxYi2VOqatwFXbvD1DuhFIIKTwdG5FXDD8aIE
         4zRrqdDepQ1HFUs0VfC4JFuNDvPYZyuuYFlXeCdtYVvjtmkVG98StD+iexbUFjsbVkjL
         pu0A2cgMCnNMb/iZEuzaZ9q8c31MgbSO8mx6hSkEnXe7e5K5Hug1P/DIh4D7Jl0IviLI
         0pMg==
X-Forwarded-Encrypted: i=1; AJvYcCXRyrG0F2+As3NMv2+o0l6of3Rmn8UncZY4DDrNskGPopZWvO9sCpMHP4zs6iKiDJoW9qlbpxuSbFbURaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UyEcKiTrPtPU1vHtI2/iRWjbFVhq5nQAmusCm5mP0ZP2MXEa
	R1uMcByBnWYCmcr4Q9VD3OktpBlaNFTJFt4t/fx8wtcISK43qKdRYxtIz+u/yIYx3m4=
X-Gm-Gg: ASbGnctrhX5TcyNKxgoAEdK7sVL9yNuhydhLsPYLNZ7wM5wkb9Eo/yA65RWpiDMhNoe
	HsiAxR9/ulc9LU+Z5P7SRGuSoOgJMrIl8V1V8oL7zssgok6gv9+7yKD8o1RW2xPiYvSc86W0XSp
	gdJaGntuzkNPUYjw3CYl1fm2PkMhIkTgb0o7um3aplTwkUZt17E7qFIQ/ZrI6vsd2LXNaTkOO2F
	imZZNT6AGIezNwi9RmVaOzt+Wd+7CqLcGflL90MwLGhJcW8sKAaubBl9BM+SINTfxMUIIy/ydMe
	m5clSrs6ZiB519n+Ot9v+y5yw0Azj91Uk4SoWzuPvsz3V2yyzVfwzRtsByaclscpjNZqxcbxLPy
	bU6pZiRrgKArXM+m5jKMVNo859clzoYCkhTTNWfzO/6xAK0HRKAtcrzPHmv8Tp0qcRU8Hqf/12z
	K6SRJhoQ==
X-Google-Smtp-Source: AGHT+IEeCOXghFcgH6Nmit42fyBYKsK4gGqalXJNeIk0O3d2EPTDkkric354Pe4+kxFIZZN6Gaikqw==
X-Received: by 2002:a05:600c:8284:b0:45d:d505:a1c3 with SMTP id 5b1f17b1804b1-47117920935mr22021975e9.37.1760688169583;
        Fri, 17 Oct 2025 01:02:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6c59:a281:27c9:93a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42708bcea1bsm1082308f8f.14.2025.10.17.01.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:02:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 10:02:41 +0200
Subject: [PATCH 1/2] clk: davinci: psc: drop unused reset lookup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-da850-reset-lookup-v1-1-362a309a9f09@linaro.org>
References: <20251017-da850-reset-lookup-v1-0-362a309a9f09@linaro.org>
In-Reply-To: <20251017-da850-reset-lookup-v1-0-362a309a9f09@linaro.org>
To: David Lechner <david@lechnology.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=BEFSWjFwHX6uExLjBneDWL7iOS7pXsOG61qh122CNKk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8fgmkGJM2FghgVKiGXSaiqPcCwHcUqJA5V/l0
 igZLJZ0BMGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPH4JgAKCRARpy6gFHHX
 cpeqEACLUFUP4oi7NBoysKpQkCTRb8/qtj51+4P/ZfwrTUNR8XewleRbaUEtPt0pf831GhWZghF
 IvY+7Gx7R0acWZr6OPEAdrHEYl1+lsBKoMdjjmxOX5aX28jIvPCWBMJl0Uio6ORPQo6VYwXGWzD
 JDkZn/tZrMsR365yJ73XSHH2pCj0/5HuDwWs2LzGKSQbHIP3EaVMXLEXy0IOQa33+/i6jUpRbwE
 Jfwm9QY8KfHEE7kMwl1dyQdoY53AH6AKLD6i0tcdpGzIK01Np5noyHFGl0usM2PGxK1SFxChA+r
 bu5jIgHVtsrSOdTMKH/ibN2ma4vnsDANro70yJZu+b5AfEH+brSyZgwDPebHT45NEDIBIzt+1Cm
 RQ5e+PQ6+bBithrcbzkILI/jh5w9Jj0Zb4oQXigoFZv/ix77vkQ/qaxB8l5aqoOJwLWU9FcnVai
 BNNuqdC/qPHjfR6B8r+b+ZyEoa/IiDy4Rd2VPP1yQZikotc2xyJSWnt2rLcQR/ktxWWRCie6fYv
 aiuOJGeGOZjQ82t6OzKbVVr9OZHP2gjCwfcQiNFHWwIbB8cr0Mhl/P+kUcA7CAcCdCafpP+s1/X
 5SqCiFoOdKNfBDs0Fa5Ah4eE2BedEYqhAkqms+e6JaljKnZSl51L5RYsdUBtrqOue2GvQTalPbI
 lvg5lHjmHtk8TEQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We no longer support any non-DT DaVinci boards so there are no more
users of legacy reset lookup.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/clk/davinci/psc-da850.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index 5a18bca464cdaf3a0f3573cf9d70b79ca591cf28..94081ab1e68872d978e4cb162d8f9101de656d3a 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/reset-controller.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
@@ -66,14 +65,8 @@ LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
 				"fck",	"ecap.1",
 				"fck",	"ecap.2");
 
-static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
-	RESET_LOOKUP("da850-psc0", 15, "davinci-rproc.0", NULL),
-};
-
 static int da850_psc0_init(struct device *dev, void __iomem *base)
 {
-	reset_controller_add_lookup(da850_psc0_reset_lookup_table,
-				    ARRAY_SIZE(da850_psc0_reset_lookup_table));
 	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
 }
 

-- 
2.48.1


