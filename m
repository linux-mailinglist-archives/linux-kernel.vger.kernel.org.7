Return-Path: <linux-kernel+bounces-737778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2384BB0B079
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AE5563B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9B2882D0;
	Sat, 19 Jul 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="LVAHdl1W"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2F2877F2
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935653; cv=none; b=SqV2zqbFbABUVz9vCl45erD4oe+w4Tk6AkNX7zp1BgEZuw54h/giU4FEUdKPcOu6+AcZUyk/3Xbl93iyoElM0WIqdRYiUHRtqak2euN4+OQLCZSNQkV4UFSW54uhcsxZxbahn0O0uRTPmwVOyIqWlJMqUxVQ6OPXVi9QxKAVvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935653; c=relaxed/simple;
	bh=H4aHIJOV1TJAq6ZuusFg9Zqr2Br14ng8uZtfr3ysksQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbHKxEO6F8AarwiWzB1FivbcCqqP3aiHqXXDm2iBoZiJ1b8sfthxiaqfHwvBFLtqCJxOBZHsJPd/c/Vp9HrG28pmRrJKdZsnHGR9+h9HyXJnw+p/kPAi7AXR2Hi6RFjCqqSo0GNUcPfyDsERxyMyY1mqX9mgJWiOvZxOYRGjxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=LVAHdl1W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23649faf69fso25507605ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1752935651; x=1753540451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkIl0Ng87tj2Fj8IQfRrJkmK5nZP9FIei480gavcNNA=;
        b=LVAHdl1Wrq0uawe3y/ixfQc3yT6BbiwWtht0+RGCFhvZFl04LGSg35NAT9ETQYSSIc
         eRM78ss+P/L8QQxPEu199EbTHs/EQ9g3YV4dr3LiQM0BxAbwQ1RHRazR6lk4ixQh2zw9
         6o3GqZIh3A/YNGjwytyV0iLgE2VyEjzUW+KbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935651; x=1753540451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkIl0Ng87tj2Fj8IQfRrJkmK5nZP9FIei480gavcNNA=;
        b=LRVIIiQKPnlONl+bWRUzU5PgAnhDMSa38J6ahBup/ZcZHA17L7ltD0PVte3YB4U7/A
         CqvUJYixCs3CNKB+CWEAkpz/09mh3iNO2pVf+NllJYiSnQt0lxsGT/17ateivMkfdEiv
         F46tBMCHRDva2pH7mhZb8bM0KFt9/wjHgm43Z8RLVyu0YOsRy0LJhVzJiExo4+SZ/gvx
         6eB6wrNR8wKV8NB9TOKpsX+hx3cucCV443NOcj7qGYuohr7ZX9Vj/odqOyCKqrB+0QYX
         GvJjXAZGpTcEzef1TJZTM+OJz058ZlaITVtJoFKyxUD1S568HUjI1APN7m/PQ0frpiLh
         htig==
X-Forwarded-Encrypted: i=1; AJvYcCVcRvePH8WkhUNy9H9s1Y+vFNxWx5/871oQxI+XhurvJT/ZGzs632nU5DuzWWq71rE4GSIrCZIDI3G+QJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfipQFm5SgHnOlnPv8eA8mGTV9Qf2SmN3P8wYdvj1oMvhoPb06
	jWCkP6Ed4xqwmmENTPfUQoYQxvXcvVcE0P/prWRGbQjm5ZPYBWwHqwF5DhDS1+8z2gQ=
X-Gm-Gg: ASbGncv75Xx+XGo3+jDenl0L62NXuHawQRc1/CWZTUBEjVL5kKJKvtB52R1gkYKo1TM
	3BLH48XcQIbPSLNAK3qKGqtOGnmRdInlsqIwsbgptUGR4PpQFKmFWh3nLUFbqnW6sViVeJL5s8O
	oZRyKRSIRlv9z9fCBHB8e9Y2L/HKtu8Yy+voKQ63zvBzOlQerxdH5KYwtqbuhhQzh12jO5zr34y
	k9JWNXKek0OgxG2raC3g30n7rkXQQprX7HcFJCGpgAAHrF7hUzf7Tb4zZhJgEurBcDhS2zmCC2l
	7YgunJsJ8dy12afjjJHQq30zUIPuOQGCCyWxxkbW6hZsM3YLtQCrqL1izNxAoO4y2fcKQf1UTEL
	aVNk0rQj+PjJPRRsnC/0qzEnkKflr+FsTW8a81FSdiiHKAKr5wbQa29n8W/U=
X-Google-Smtp-Source: AGHT+IGpEs8uiBA7/aVMtHrt52Qtzk5GqQnPoy335qfDXK4TTerS+kRTHT4TOUh64k+czliVVMOb7A==
X-Received: by 2002:a17:902:e88d:b0:234:ed31:fc96 with SMTP id d9443c01a7336-23e2572fbc3mr200769665ad.26.1752935651099;
        Sat, 19 Jul 2025 07:34:11 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm30017525ad.23.2025.07.19.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:34:10 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 1/4] rust: bindings: add io_uring headers in bindings_helper.h
Date: Sat, 19 Jul 2025 14:33:55 +0000
Message-ID: <20250719143358.22363-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250719143358.22363-1-sidong.yang@furiosa.ai>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds two headers io_uring.h io_uring/cmd.h in bindings_helper
for implementing rust io_uring abstraction.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/bindings/bindings_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8cbb660e2ec2..a41205e2b8b8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -72,6 +72,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
 #include <trace/events/rust_sample.h>
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
-- 
2.43.0


