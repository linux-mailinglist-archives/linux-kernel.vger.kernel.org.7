Return-Path: <linux-kernel+bounces-827178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C839B9111E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0B3A8A22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FF306B09;
	Mon, 22 Sep 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWcLntuG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818A2F0687
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543025; cv=none; b=DeYNstW7GS02sG/QSyLT7LuqG67uA6CDABfxlpNJbwyOGmVLpxxuV6CPbXbpyl2g3NCwGJbyYLULlqkSXAA8VC0mPa2rKQOd3h0Z6Hh61tQwif1NnPV2cGE0vZzrTF/QrGaA3ZwPYUIGeXAhoCGmDcLpHj68DA7vLC/ahRtpsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543025; c=relaxed/simple;
	bh=D/clnD1hIlVnSt9RwqpAPzOANdJ2p5vqoO7F4SHQKHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7EUgkXnpQ6Ga+lUzSH2ZxeYSHsqJMBCkOiCeDjblg3+7g+KJm+2+AeF26ZrnUy4EpRP2nQYReqOyv5brf5l1Vr1gqy2rz/ghHBCQOqk12jEYL0TypUOVEMGDPl1GDURwXnvuEC8+AQzqhGlRhfmKb7Tf1bNIY35medWmziV3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWcLntuG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so36929095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758543020; x=1759147820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71jw5Qy/VkNLzHuH4x3iqTkdWQrjxtig66ummONYtOM=;
        b=MWcLntuGxb2GSltYe7nmE8qf/7WZA0gETFKw5/s3LjGLiRx8JM5pAHaM02mbQYl3XG
         1SW6cGtsLhpDL5D/1lUbf8aEv7hxYvo4H7OY3mJMx9TuSAGj7cYzrKdCP94GDLY0hsYd
         Kx/pVKFVVTZADei1ewDy7QxmN1pXJIGbOp7kjsW1ZdnhF8iE/gWijVcYluG3+DKDISwT
         KKSXZ13Qa67Rt8b/qM/5WSJyklaPMhgvNgYUaAbhbSlGzQFVs21JG0c3a/R7cRg99d1v
         /mSiKRzki5VIC6uIKbr328WP4PjOVxkBDSz99ACpvCYs5jTKvK9gC+Vrb/wU7KXPZj5h
         OXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758543020; x=1759147820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71jw5Qy/VkNLzHuH4x3iqTkdWQrjxtig66ummONYtOM=;
        b=BYrU1zDQMyzXmTMbC489uEtYHoNZcM8wtbpgoPgbHNrEavUIMuMLjp/aLmrHE+HWxw
         6dQwymHAHxfrXmz9Cda+yftqmwAODRbsCCBNAV842ozOlbp9Kx3zqEhsBnAbHAHtfsHH
         0PVs6DXFavSMa+IEEbfngAGRKuWs/DuMEAL/O6/xBss/Tybk8Jk9bVA1TX3glcGIHhk5
         tklHGqmFnHi750LFnR1BlNI+FqV5gTP7nyt1Nndv3QbVBsQdVL86kVDBSgDhl1xCL2qE
         Rg7HlKcW+v84f8es0Cfypk+d4Q8YaVftWaplAC3JTdBLShhHCof4nxfv6WVCDgH/AL3h
         m5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWLkmWL3ofwbJWA3ojWsExeAhZ3PRWBMWrICxOYHlloy+jB3Y+ZSMekFPnlkEEwQ6ydZBkSuKwOP3VJiBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRltv627rodC/iRMShh5/kAYFl6MO13ZDh1L6QIAdTs9SfEN4
	vqad46bvnqW1VFwiBYLWBckC/+U9u8x5idNFCRfRPJTMD7/4CgSrqPNuDftTmAwh
X-Gm-Gg: ASbGncujoeHmZH0fogTO1giuYG80zjQTB4o0UxOQvxI3KdDL1geeAS/HkmCfg78bSe7
	fkz4gAuLlOgdyQ0deBFKK/YwE7txpkogZEYaOFj5XuZkx4ay48jKnDOssq8DVtZBssMeLMrGQln
	Jz+y20e9/oUws4/CkjHhzz25431nuqpAucvuaZvKdpgGgw3MjSznTiIQ+ah4aPpQXbHfSbu554j
	MvYuQZNlaWRvUty7nLaw8WPrMUBXE7Ujb1Oq9DHFwiZNZfjoxJFQhJvYXweUOL3oGGuvmYeY1Af
	O+60r8Cw8JM6HvGcXXQSCf2R69j4zSVYHQHAm3sml2pieE/kpHIXbZtrcZ5vctUgEcRdFuHgVP6
	Zahab3ZX3YHvcgZdO/eVMUg==
X-Google-Smtp-Source: AGHT+IGHW9CPoYUliHRmOI9QW83IwXhzxlqJRF4i5x3vsGF8rbB4SFo9J0Y/nPh3bivEr5ReaiyMtA==
X-Received: by 2002:a05:600c:468a:b0:45d:e326:96e7 with SMTP id 5b1f17b1804b1-467eaa86e42mr112243105e9.29.1758543020076;
        Mon, 22 Sep 2025 05:10:20 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f32141ae9sm131846735e9.5.2025.09.22.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:10:19 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH][next] selftests/clone3: Fix spelling mistake "supportd" -> "supported"
Date: Mon, 22 Sep 2025 13:09:30 +0100
Message-ID: <20250922120931.56786-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksft_print_msg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/clone3/clone3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 05c3d2dcbf2a..385cf08f8cf8 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -71,7 +71,7 @@ static void test_shadow_stack_supported(void)
 	} else if ((void *)ret == MAP_FAILED) {
 		ksft_print_msg("Failed to map shadow stack\n");
 	} else {
-		ksft_print_msg("Shadow stack supportd\n");
+		ksft_print_msg("Shadow stack supported\n");
 		shadow_stack_supported = true;
 
 		if (!shadow_stack_enabled)
-- 
2.51.0


