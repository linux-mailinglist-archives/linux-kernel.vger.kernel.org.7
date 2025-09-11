Return-Path: <linux-kernel+bounces-812757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA4B53C50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338D31CC1FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24A925F798;
	Thu, 11 Sep 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmqLRgaB"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A52DC765
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619242; cv=none; b=mF01R5hHJnJUFrm0TYM1upjNgcnDXTu9rBQk9wcqplbLOWHLVZahLLlW6HRIGyArQ2x/bj7xU9w2AXemfCf8RZY74nEBqm9u2mqUzHefneQihQZz6RFmfa/iv2Z0Go/Df2PiYINSjvc4i1UhJkyUnjZO1ToNcocN2sa0CxOzm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619242; c=relaxed/simple;
	bh=Y05O7Ah8m3VrEBiRrZdSc+R+4Iv9NkkVIZ6x07U3YEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCD2BZN8bBo4KwavMJ3QMsJib7o/lvcSlquz66nqIEBpz6DPsyeQXBej+/OC3951PVGED9KJ6WEliKESrKo2uKK5yAEjmcHiEm4mSWlkv9C9TlL9EgKMHuirNb0mGjHTWP1LK/MBNCGRJYDy8vVWBQkSdaFsDROqY/nId6EhMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gmqLRgaB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d5526596c8so37366f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757619239; x=1758224039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2hRnWl9DPmgNwOJ9eqmgc5MwP0KykD19C+0v95Q7Lk=;
        b=gmqLRgaB6zrJensKYRwiJsSqmkZQLwUBHov+JByPzki01NYPQXIg4ywhZMPo5A6xDQ
         uqatsGlYvBWsQZ89+ADrQV1F0ltK0EVBQ3M28e2CzLJ5r99zjTfbPHZ+1aRmFrVsAa7E
         OpO7AAzzWeMkUvcJU9hS2AIh2LMnoJzRZEfS8UvQCoafHvyvF+1xow+eH8+bQcjPTiEu
         D0b+KwbUU40eRvug6HyU0sb9u0zYdar87oJqAuA9wa7r6tb3TUSncWO87hxZXeJqWgch
         3OT2t4tg7Qk6fsBSEgNZHF1A6cKu473JC+gy1u4O8jQ0lOnHM39OiWWMgNMOcbfsXr5v
         qovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619239; x=1758224039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2hRnWl9DPmgNwOJ9eqmgc5MwP0KykD19C+0v95Q7Lk=;
        b=FMyHWRkM/63EigEuUrWCj+ZV8uE6e9/b4WTws8hcHyjV/dVYKmoYBz1CHfA7+PMtQu
         68u06L0qHig0Y7OLoXaNHdp5EW0l89G9+CU4A+IujBX1KHQnJyOymnlKbK9uytD806ns
         SGGFPnuvai3k9hzPysbt0sE+rsssLRNDXIrZ+FyKzK0p8/R2bgPNn4M6YRsCKSgP8k/2
         m2ABTpRVJUj2Aa2z6H0kH5jDggjKOPlzHkhKIkXtvBxFq8SH6+AV/TD1fAmioMCoPHII
         ZsDdHE2hDYdNUXbgUncjc3U0JWP01EHD+b5OsFc2gwMr9gkoYvtpDVFLR1/h0zP8lf+W
         asgg==
X-Forwarded-Encrypted: i=1; AJvYcCVuhgmOrulS3AWJp/Hwu5l6IrhpHeFtOTHKBcCtHgzfnZMSR5K8MyPuLhFX5lAT0ZqpDPvtne+j7fLU6IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUf1Uygfc08pgcoWQ2TVy3zmYV/OZeexSGJkYFe1BfGKpXrROf
	nzoc+iXCNvtKVmXTDZtCWxLujgmZVgWLBNf+AB0D/Im7yLagRCc2zcQAhZlRUcpRPU5mvBGy4oN
	NNvj2
X-Gm-Gg: ASbGnctGOxbF5XpjkN6LAdHBr1TEk0+H/gwzHKayGNPW00nExhCBZZbXMCFX8hZyrpN
	bxd4/xaAtaeFiZ2VYIeTZfeThr/U1K9op0pzBSu2XasJY6ljlaE6BTnZy+axnlOpcpBdXbTp608
	kNNf+m4Y+x3/4dcLEEiLhn2tbkQxzXR0H9CJwRHIBwsRuPsPFTOLq1MGn+wgQnhBom6c2M35PLO
	kAKcMgv81m64Ok/jrBCPLFF3WWzp/FXuMAl+4KKpS2HMDbvtXrIgHab6FQIjhuQ16J54MZWHqwg
	9FyIvxfaLfxF820jb17M/TyR9stQzHjcZ5rsWJ5lpMZ8lXSbxOeJ+CRj+/6HfDuzEn2EJInpcpm
	KayZUchTLXkdCSvZndUT4x81a+0o1eBEaVX7oFaWLA5JkVc/QBHpBIjc=
X-Google-Smtp-Source: AGHT+IFGziCCby5D2Qd9w4NHMZF8PAOpitnAJxu/QUYRHu3OcmybUGvrHEdGkUEWhZ4AJdmxmzRrBg==
X-Received: by 2002:a05:600c:6090:b0:45d:d289:f505 with SMTP id 5b1f17b1804b1-45f211f859dmr2930595e9.4.1757619239071;
        Thu, 11 Sep 2025 12:33:59 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015313aesm21482975e9.1.2025.09.11.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:33:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] coccinelle: of_table: Handle SPI device ID tables
Date: Thu, 11 Sep 2025 21:33:55 +0200
Message-ID: <20250911193354.56262-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Y05O7Ah8m3VrEBiRrZdSc+R+4Iv9NkkVIZ6x07U3YEQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowyQi+cSPrAv1rp5UH7+T2nsmq+xlq6yAIsx8P
 Qozzjt5QfuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMMkIgAKCRDBN2bmhouD
 166OD/9YQ0dD2iuqqC+ZD585xgymLed/9O9kWjjSX7YCQy28HGCLCSvlMY/pYzOl7IOhZ1bAgyH
 149EUs50IFMsFXPfofEnW/Y6dHjiNO5C8lD9F4NeycppZ1P0VbLOL3EIjoQfW83sP0EXT+hCbW1
 SJhUSPYjh7jLNKoorDG1oJiCZwc60G10DK+vG2KwKUC18PksmSUSXe8rog+C8KJO1LyhqmmhRmu
 FUVRa6cs1doCz3nEfssqNdS5SPn2tPBY52U4pJHEZxIkT8KlQjQ6B8kjLfnYtm5T9rCNq2kHg28
 tp4/x3RCWyOKQ5Jv3ZHy39kqSJ2Ud2U+5uF2J6O4CH6/O4Jt/mVAy2Y6bdbvw4Pq5iAH30BAbok
 CULqzqvuOw6s7GmRgC/XuoAAkQiWm9ArksRn5Z+5hboIMV6qtTn1u4cxtTDLwEe3OUa6vwAho47
 tag7LElYHUmuRgQFv7FROGw4qC4ZcLpyj5gfIh5Zffm12rlsARWMwvm6DSZJcNJC78yjpNq/SZU
 /nxAKmoHEGQLt8pwiVqY/lAc+2peYG9akyzMoz0Tlsb7BNp7AVvNt26ifsTDqvvNPl+g3Kf9w2S
 GsrPklvGEXuF2mPhDn7ABd/mt1gLw5GrykSMz0zVn9I52/coYtmU8Pg+Y7r3fh0b6pdsg2/ZLpP fR46MfihNPN+m+A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

'struct spi_device_id' tables also need to be NULL terminated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 scripts/coccinelle/misc/of_table.cocci | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 4693ea744753..17881cb0884b 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/// Make sure (of/i2c/platform)_device_id tables are NULL terminated
+/// Make sure (of/i2c/platform/spi)_device_id tables are NULL terminated
 //
 // Keywords: of_table i2c_table platform_table
 // Confidence: Medium
@@ -15,14 +15,14 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
 *	}
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 *	{ ..., E, ... },
 };
@@ -33,7 +33,7 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -42,7 +42,7 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 +	{ }
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{ ..., E, ... },
 +	{ },
@@ -55,7 +55,7 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -63,7 +63,7 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	@p1
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{ ..., E, ... }
 	@p1
-- 
2.48.1


