Return-Path: <linux-kernel+bounces-805643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEEB48BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A388D160AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5773002CA;
	Mon,  8 Sep 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3fzRQuJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A43002C8;
	Mon,  8 Sep 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330000; cv=none; b=R/eSsc6R9HtI6bwJxP5m3dk+/zZSSOE18Uu4H66zQVgq/L/T1gRP84db5iu18vq7QkxEDhx9tTx+LmDf8h99oQeuCzLByZFOg/eOxOnLRKn2RqGObh6WgDhNyT418v79y1pBKoLqxwfGWIINvUtKtrkbboJ1i8MgNgnC0JdjUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330000; c=relaxed/simple;
	bh=dPb288Jo21uTWPVnj9MDJ0ryDL9Is033HnSH62NlSGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u11fRUOwWWjekPthGHap+f2Y3YgeKF2JBjf78/D9CMSc0jbQfYByHNUbSiDjmbEXJvYWhNstaWThABS0C0lfsu9Le2ZTyNEn9mG17O+N5SQ/dsgqF0hT30jtDqIgeLp7iCGobKX+x7118OXqFHr1kyWAfM5iuyQaZQazVx2xuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3fzRQuJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de6490e74so7673325e9.2;
        Mon, 08 Sep 2025 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757329996; x=1757934796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JFsZ9+YKTnrhkakgaIYMEKoDfFk5f5bJk4s8F2eCHU=;
        b=B3fzRQuJ6+Cdp+071F70MmQEnqOMkrMzZ54s7LNtYx63+Evh3pkaOVMiqR+RRd0GIR
         0FGj5KQ2gfDFxwfg0pgEAXT5v2kr14iCvMT/oO6JfHHjDIMJM2+8AKavbvTmR0hF7R9Q
         QnaeMl6k6c8ZWJZd36ve4gc5nPvxoiv+bShuV3Xb70zCdawx1cFI2ZNDQM2ySBWagugB
         7OsighNzJBLwgtExGqXITHHGCRcTvRnrFz0PrJBzH5mTgzVJb+W5jORLlGu9XblVjCYi
         tvsMfAOMHVQdv7N1O4HGA1ki97jEelKX6rX8vvPg76oprwXUANllG8eprTfYG3E8ZFQP
         rE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329996; x=1757934796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JFsZ9+YKTnrhkakgaIYMEKoDfFk5f5bJk4s8F2eCHU=;
        b=UsT+R0pb9EtuJttQRk0DrXXD+loDblGqdvHU5QI8+DCDsP56hfBWZ4xvkXs1kI52hv
         l94my9ncckS4Uzsd2Uf30XLJLgACcjAJIRzQut3kOaN/C9HyUYjI1WrC7pmmlkEp6i6p
         q4g4ywTRigYP+6LtQHbYzYNWI+u6mQ+hu4GRMuFfTkrB+tFwOSvvXkbjYdDaAP4tSsDO
         zsNkl+N+dy4dlGkGX1p9NSF6etvPjHYOckVMlyJB4MF7RVDJBdYzOigmSPmUrHiYF+AG
         LtHRmJql0Bb50sqs03MH4KYw4LuFZ2q0qbsFoH3eweI/G0kow87lojkH6EheFb+f7h5W
         JEow==
X-Forwarded-Encrypted: i=1; AJvYcCU9y//PL/R9eeBxfCTZ0Aew8TcGKdf/UI27dWjxIuiX+Scmyx4j0HdmBllZ6BpEbPWKp/LH/wL9S2AxANoy@vger.kernel.org, AJvYcCXgXz7EWDzWfWLoPb4L2zHJSOEAplwTI8jbgtEUaDGh9MyUAUJrP472fcbg6r2Hbm4sMrKSaQ8H/b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAF+aPXDv3vbS+fbCgoRWGr+94kI+fdTCOVwgKWup71UVH4Udc
	Tz3SDI4UO/w/7TdE7J+CfEdEhWFOCWVmIPMywd71irl7LbdaIBbKYqu5
X-Gm-Gg: ASbGncuyqQkTxBcsoWK3MjhItvJLBXms5kwyhLT8HIiEhVNixBkYODM62iFOVaJVEqQ
	hn/V2EmjNDkrH8z93o5Qct6yOO2k0rtpnNK4k8CDIBTYkn6HXJcrwrfodTd54TXqDQNhWL417cf
	c8naB4PzFCHEYgYMKzqNVWHr3y5HLE5K0AjJ/vFu422OL3jC/9rON0A/PJLkWcCFrDURdOd/PDG
	z0/zdjE9b137u/cqFE4PnLYkKQQUa6RVGki7SE4EPjjNU/TD7zafjUJPIoV0LPWXlMPyTXT9SVa
	zb7r6/AN7Ct5VRnTmORQmp7temOZHoN9BOdbvR4UDSW7HIH9fQM8LMrJYpIF9CEa6IqEeFMAdsF
	MlfcZhOtSyA7yITSQ///6ZvcM
X-Google-Smtp-Source: AGHT+IG5uQOiOoQhJJ/mhTQdnV7nSQkKRpmjvrrmU/zTkJX7X66L4LIULBGIcjgXcCeKAsh4gyVJsw==
X-Received: by 2002:a05:600c:3586:b0:45d:d56c:4ab5 with SMTP id 5b1f17b1804b1-45ddde9583bmr63031115e9.5.1757329996041;
        Mon, 08 Sep 2025 04:13:16 -0700 (PDT)
Received: from gmail.com ([147.161.145.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm141671515e9.4.2025.09.08.04.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:13:15 -0700 (PDT)
From: hariconscious@gmail.com
To: shuah@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: HariKrishna S <hariconscious@gmail.com>
Subject: [PATCH v2] documentation/arm64 : kdump fixed typo errors (review comment addressed)
Date: Mon,  8 Sep 2025 16:41:19 +0530
Message-ID: <20250908111118.46666-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna S <hariconscious@gmail.com>

Signed-off-by: HariKrishna S <hariconscious@gmail.com>
---
Changes in v2:
	- Review comment from Jonathan Corbet addressed

 Documentation/arch/arm64/kdump.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
index d3195a93a066..36701262ccaf 100644
--- a/Documentation/arch/arm64/kdump.rst
+++ b/Documentation/arch/arm64/kdump.rst
@@ -5,7 +5,7 @@ crashkernel memory reservation on arm64
 Author: Baoquan He <bhe@redhat.com>
 
 Kdump mechanism is used to capture a corrupted kernel vmcore so that
-it can be subsequently analyzed. In order to do this, a preliminary
+it can be subsequently analyzed. In order to do this, a previously
 reserved memory is needed to pre-load the kdump kernel and boot such
 kernel if corruption happens.
 
-- 
2.43.0


