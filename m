Return-Path: <linux-kernel+bounces-881772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A3C28E3C
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535BD188ED35
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F92D8DD0;
	Sun,  2 Nov 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmyKiB3x"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61A270551
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083591; cv=none; b=iKXEOynkTskLg+E2ekq1z+gwnWKE7YdTf7Y4RvmLsSWABNbDy6I8tBhc+/G66AzqTytfxPbI/raf5sNV4FWfTz4DRt9TtjXkSNQ6eovNEWeD/H5Ao8TVCvvf1lbQ8vMYzQVVwap5qZK3wRdyAYcuK1BPnInBbPO+8EdWWD9U/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083591; c=relaxed/simple;
	bh=FO8B+XSbG8/tNz7UwdzRHKt4zk5YCDQOjGbVamOS/1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKomnc163+I+1t4mUX/AerUytioKkTLcDRMD3jSKMGDBjwsfZ5+OFQu5GBkcoTxrLGvagSATvm5JWycytXauEgUQQl+VFr6Ma6psTQSmz1HvIovo9sU2u8PIeVr3cttDU4BaPCI36uNczVRw9STQrbxNs2BC6JCFkcjY8GJM61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmyKiB3x; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378cfd75fb0so42262271fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762083588; x=1762688388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV8ILjCLbAd6Rh+u+y5fp6wN9Ns1g2oLwKcbOPZD8ow=;
        b=cmyKiB3xL74Az6H4x1Y/jt3wZ75kXeLCct9FCu8s3dhe7gfiTAjhxX39DXTtKU6TIr
         paEtY1YwhdsideHlDXczOgT5B/KFXj5o+wpnwTUJgyxCh88XDKy4Xw8svx1PbjvZQwwq
         kmya/MxGLWOTiFDjWp0pDpjmhNOLRocdB4LZlzJCLlz9tU+83MPUnmXr2UKFADAfdCCr
         pPN7nOQcswY7/3KgaAWPkMrux0/8SVYLxVLQdNvpGIlOl3X5VWrx7dhFjlcnDcK6gTki
         YIwvxrv9Qa+5l4S52Rwvqx128PhMegMti/ItEYNySGRzp0CSZsFQKeBNhCC9QajxYaKv
         YLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762083588; x=1762688388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV8ILjCLbAd6Rh+u+y5fp6wN9Ns1g2oLwKcbOPZD8ow=;
        b=p5V+5bVy2BlbE8iZlkGU0wdEGfVVimkgQSebHCZGBZnVd21R7qlk23jzNM0ibteK+d
         6XGKFAxZvhDmBerEkU+ZbOeJJjTZApH3Mw5dkAq9ezseUfWoYurdO3VOObp/N50t7kBP
         k6lTmT2xt2a38c9JzwudU27cSTcCSp8CeJ3FYLrWk9mlCSDXNxXh2ab5g96JJCmMVHm3
         f5/KZaiuNaLKTe86fut7D5A2nDVgioMtQ7z3XAOgjVoI6Ow9gPLpFaPiaPmTZ0sGBEUK
         3isaW8vlbLMjYa5oJDQCPjlyQE7xlhyurLIwulPO3bByrnPB5EOi8TUz0Uv38b9PvWmz
         RC0A==
X-Forwarded-Encrypted: i=1; AJvYcCWu4PUTgjFE2SxOADoSsXWFbJxgOKES7bLfWZYUWFMxZEMz+NSPhrj9oW3EbZwNrP3d0WTYh5gOx2StcgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0i35F8Rcn0O3cXN3I7axhSN1Q7twaF8Q19pr+DahwVBvEZ8+
	VvETY1v5Ql2SDXJeAUHHVxuGQma4SbuAAAr8ve34nj5Esiv2HzDD5ZT8T9ZSTB4+
X-Gm-Gg: ASbGncuPxbLWDiatb5sF1XwwoxRtFjogpsS5hrMYG3MXHAP4ixU5sAbj+N76REcjWRM
	SdMvcWsWDxJYlu+AR8g5Skhm3c9+rInZUwutHeSkvci+0BKR+SsI3q/NgNa70TZjcECM4rb1RO0
	qJWaiJjZJndP2+VwUssvC46t34niHczEUEgEheBx7FYzMErL8ke976LqeIbEPXZ0Ji7fXR0WMcC
	WZU9vU5ny2afHmd1xQN4uPcsOC9NhpyLPABK9Ctl0A/Xaq1Cz9Vfi4tRy5IroFmTvTHQm3hM6Y2
	PdXkJIXRglnj3M0P5If4X0A81pSsm3jGWLRBKvtU4/YhusbWhnjVe9Tm2+zClNrWqFzsrRq6AUL
	JI1XGZFbTlFNXOzrqNU+xgNfOzVGx3YFwA5Fq+4W0x3FN2Vd68nMGDPIky03usnaM3QpC4Y1Pkt
	y7iKcqCY2/RlMDGA==
X-Google-Smtp-Source: AGHT+IF5MuHNOFQad9POJ3EQYc0VGYemTssqUJUuIIhlti7JhbWBNjLgXwcxhlhjdqsvTxxddHJZDw==
X-Received: by 2002:a2e:a9aa:0:b0:37a:3204:aa15 with SMTP id 38308e7fff4ca-37a3204b08cmr6232551fa.48.1762083587800;
        Sun, 02 Nov 2025 03:39:47 -0800 (PST)
Received: from archlinux ([109.234.28.204])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1c0e3562sm14414601fa.47.2025.11.02.03.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 03:39:46 -0800 (PST)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	elder@kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH v4] Fix tiny typo in firmware-management docs
Date: Sun,  2 Nov 2025 14:39:38 +0300
Message-ID: <20251102113938.3116-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 .../staging/greybus/Documentation/firmware/firmware-management  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware-management b/drivers/staging/greybus/Documentation/firmware/firmware-management
index 7918257e5..393455557 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware-management
+++ b/drivers/staging/greybus/Documentation/firmware/firmware-management
@@ -193,7 +193,7 @@ Identifying the Character Device
 
 There can be multiple devices present in /dev/ directory with name
 gb-authenticate-N and user first needs to identify the character device used for
-authentication a of particular interface.
+authentication of a particular interface.
 
 The Authentication core creates a device of class 'gb_authenticate', which shall
 be used by the user to identify the right character device for it. The class
-- 
2.51.2


