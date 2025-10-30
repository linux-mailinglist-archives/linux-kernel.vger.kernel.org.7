Return-Path: <linux-kernel+bounces-877624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE0C1E9A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A670E19C12E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF021304967;
	Thu, 30 Oct 2025 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojLVIWMn"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95711E2858
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806232; cv=none; b=otnblE6JimIklLwBy1FfZtYb3hR/pQNQnYO5Oo8JjKCl4FkfdUyligmktxQeACNzIGQOoazCGHVW6k30jzV60BcqLzuyWNOpUgkQ+UINBCeCA8Z68LlDC0QJrs/qQR22tb0pBqx+IhDSwZR0HJeUmbu9T7s16RYCTecz+eEkVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806232; c=relaxed/simple;
	bh=z6RMcyk5XD0HE6+7NbYB8avXShQxig3SkzJmyzRO5I8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kxagzJ5UR+LsVcAQBeQzr9h6CieFCNrnqAb6fZ5vewNVW1LktS/4RkR/cBBJJO/7hliIsTcPuzSitKYHp4Y6RLLFiV/yR+7W28Vp0vgQWa6c7r0ScNbolCFVJHxe/9XKCg963lj+6IDv86MbU5y+hxf9wiv+EyVYCJtnN7/03tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willyhuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojLVIWMn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willyhuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34029cbe2f5so1758671a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761806230; x=1762411030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MoYlSypTMFSr6JglkBvey7GxaEYRPECj/uuYV5+iM1E=;
        b=ojLVIWMnVhbze87l5K+Dc1z7HDAK3y/Oj4O2KD35TzcgA3eFmHRM+JU6wajxgz6D+n
         v3Jfle6FpzwWqjxDb7piMxyXDig+rCR7zQSiHKkznyfXefvkQXSfl/qCTdDdWH7vnyZ1
         oLrIQwYS/+Yc2acKrAFzRlaoM+EVOwl6tmFcjr84cH8CAAs0F6LODDk5VWR+jQafvXy6
         jY8KbB7GDltE2s7WP6FbvbFZk9/H+f/J7sZzro3UdmAECz75/KUwQFnvsHo6IgiJTzpH
         ECUqS2DMJSjBZVZsy3Hm0hXjrT0RmTB/Ta5lSVi0Hs96MdnEoIJB/RsaoWmcAGeypwtx
         esUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806230; x=1762411030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoYlSypTMFSr6JglkBvey7GxaEYRPECj/uuYV5+iM1E=;
        b=DuPZBNIp65zL6ERxPlqLBCns6nVwof3nSGH98A0ok2St2Npw1Epw5jERDzFg/Y8idd
         V5CUUIOuiH7Q4O4uUFh4VaudgSVWoSfAke9t0UPDhqDGQZoZ7LhCGYSpwAvGHNB6eYHn
         /ZOJ1C3SB0YvvPIjLUACoFRzoK+yopf+9PHkEej8ftF2Z7FhSqqAFrGxjewwd6o4Solw
         IFSzg42aZWh9XsVDMmci3y5ei7stKo3E346o2KPQJIRChePsgxYwatnMBCX/yZmRR0oa
         k2m4yUhz+Ij6hWwqJsPFwSnB+ng5p2wH9uDXu0j2n2X1Jx8DK5A54GFNL2FP6GBiMGCv
         zZwg==
X-Forwarded-Encrypted: i=1; AJvYcCV3kuRLJcmYmAEVvgNIE9it8zAhORr5JIVKhgWvpdshgpqE4OMS+cpkwEthFle6P9zG8tm3kwTG+FScXk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7DP96CvCgluQshPvtuU5Bq3D5nSPm+Rasb3d+KiXrx2ew7i8
	dCX+/EkGAkg/Fz8Zag/CFzcOObBcYbfYLRW0sZviStzsue6jggR3tv9obzJvbhEvbrSduTJplB+
	7hkDJBpLxJoB0mm2ynbVXfg==
X-Google-Smtp-Source: AGHT+IHAGgw5s3hEmyfwxh0QyF6n/uwNh5Ln8ayUug972f15fOZ2MS+UtAFmFMuPISJpw6fLDTKNs63Tda82X+gP
X-Received: from pjlm20.prod.google.com ([2002:a17:90a:7f94:b0:33e:32fc:fc4f])
 (user=willyhuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5108:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-3404c3e456amr2241897a91.5.1761806229967;
 Wed, 29 Oct 2025 23:37:09 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030063704.903998-1-willyhuang@google.com>
Subject: [PATCH] HID: nintendo: Reduce JC_SUBCMD_RATE_MAX_ATTEMPTS
From: Willy Huang <willyhuang@google.com>
To: "Daniel J . Ogorchock" <djogorchock@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willy Huang <willyhuang@google.com>
Content-Type: text/plain; charset="UTF-8"

The JC_SUBCMD_RATE_MAX_ATTEMPTS constant is currently set to 500. 
In a worst-case scenario where all attempts consistently fail, this could
cause the loop to block for up to 60000 ms (500 * 60ms * 2, including the 
additional retry after a timeout).

This change lowers the maximum potential blocking time to 3000 ms 
(25 * 60ms * 2), improving system responsiveness and efficiency.

Signed-off-by: Willy Huang <willyhuang@google.com>
---
 drivers/hid/hid-nintendo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index c2849a541f65..342cd6893502 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -819,7 +819,7 @@ static void joycon_wait_for_input_report(struct joycon_ctlr *ctlr)
 #define JC_INPUT_REPORT_MAX_DELTA	17
 #define JC_SUBCMD_TX_OFFSET_MS		4
 #define JC_SUBCMD_VALID_DELTA_REQ	3
-#define JC_SUBCMD_RATE_MAX_ATTEMPTS	500
+#define JC_SUBCMD_RATE_MAX_ATTEMPTS	25
 #define JC_SUBCMD_RATE_LIMITER_USB_MS	20
 #define JC_SUBCMD_RATE_LIMITER_BT_MS	60
 #define JC_SUBCMD_RATE_LIMITER_MS(ctlr)	((ctlr)->hdev->bus == BUS_USB ? JC_SUBCMD_RATE_LIMITER_USB_MS : JC_SUBCMD_RATE_LIMITER_BT_MS)
-- 
2.51.1.851.g4ebd6896fd-goog


