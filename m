Return-Path: <linux-kernel+bounces-741838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2DBB0E98F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A157A77B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588D210F4A;
	Wed, 23 Jul 2025 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIL9lM5q"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86205188CC9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244429; cv=none; b=KIPq77jmNhT8rV3U81wWJWE3n47s0jEgEnGAkboKdUb1RNyw3NT662u+tVut4CTCh5kY8ox8fp+B4QjoHQC14k1AzJbryO63sSAGohMKvPxGyfvJZ/wdC35XbtN3eWoypXrHoPM4yrvjAojipDMh7XLbJrnIZcm1n0AKz8seH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244429; c=relaxed/simple;
	bh=nUybmxEjUgZoFF8qKzweqegM7JvT+hk9E8RYEVIYVwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afTTLGmzlCNSTHFpe5V5X+zIQW3bTRn3FsfFR+ySSdnJ0x7f+xRKfCjnjzOr8EgnjPL7okBH4PCt8AtM0+EgmR3qsSm7s3L8zvcX0YDZ1wdZ6ypNik1EUtxxLRv1msuXUlSQfEdKVJicpm4oj4rRk0ARTwYWxOtxJYKS5Voh+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIL9lM5q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561607166aso47978475e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753244426; x=1753849226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=En7KJtyJSwnrZsH4lDeg9kMr8qGpBkZWwaCC2J8P8Xs=;
        b=HIL9lM5qseVUMnMWJGu0ywaHQ8VNzgohV+N4o1vD8SmQ7fORPeoOba5iL528N8CILt
         hrejH64hB3tEH7Mp2DEwtGJ40uHqG/D4dIPJMDL7YOKgXuk8mBCu0oIXV91QP3DLlY6L
         B2xzHP4Sn89lBH2Yx2KmYJx8HvUSxNjLRIreaY9355YzjYMLiOlszO9KPENNM5u9SzzE
         OilqKCMlhxaWMyfoC4CWMfN6DLyC3EfPRsInBUB9iuDsoPTj6IWfNTWhsGIGc0mdeOkU
         drhEk6WnUyk/Cm8lDQ+gqwV6k6Wume7d1/YLw5Mjp4Txr9u13I9YT8ZH/OmtTDNt33F4
         np/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753244426; x=1753849226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=En7KJtyJSwnrZsH4lDeg9kMr8qGpBkZWwaCC2J8P8Xs=;
        b=J4EtrRrWY0MGeMQdDBDsn6JWYUy3s8R1Gc6W6s0OYNpBkWTjFLMWvhEWcwAn4/vo8x
         CJIpMompoXAUCW5QV/o9GsHWcwmcE3gbflzjK2FifPt/DGRS7anHgm8rykCoOEpq/QYY
         L6MH6t7YlzaCtBNF2qgHCNnpi5HnlYnK+nE13Pirt/iXp3kQWWZ1JjEhc0UxuhWHxC70
         pdr4xohUMZPWjG1c6qfS+Cs0Y4m0rrKvEQ47nv26dSpC7UrjiSJWMXCNqp33uhegvisF
         E4QNbGYLu3M7giUJC9C4FRVPyA6xS/6JbPED+6hDzCd2mGOv9lo65QWVpg1hf/DZevfs
         GgCQ==
X-Gm-Message-State: AOJu0YzeuHNmile/TjBFKJrki/YVqkbqro4WN/pe5nM0UUFn+B9fSgJ+
	amMPJlGiBuJK0ukMB0nDyvX3oGXgINfPJayL4AEakvsuPxsCZvtKtuPGmFgg20zxhqk=
X-Gm-Gg: ASbGncvtEx8ui5UsXsD8hfJQWsK+/TkKjiAeNi3bzB4mkgloSM9d546FavnvJOoMh53
	QlD29Mei+kunx0kqIQAQ13SLZOqdfggysAuSKF6O258EN28sNdq+a0yP9dXIYOJb51JG8F4wRl2
	b7smtA0zyzYcn0vqcRWzdFmfM09YjSGWvFPVEeyxzi1vTjvTWtUigVIFGTdyHh12PM432O/IBay
	8FXg6Iwp+ksPHx7WiBlZz2BYlWgYKde/i0FNxEeqoykc740koed9p2jaEvdxSTtN/+8Am3+ywGq
	+PkvSNlRsUvqDhdnc20Tow332SEqQjBUY/Ns8uH4trgkpodbp45d6Ez/WNgYvT+V/cV3AmrxlJL
	ljjlV/hfGsv8DrajdjyLFxcR3ddgdtzo=
X-Google-Smtp-Source: AGHT+IH+7wJvVSiGwJccW+P53ZiuQE9AatDgb9VpNpO6qzD7aOLdZazB+3EAT3qo9QKAG9L9CG0USw==
X-Received: by 2002:a05:6000:250f:b0:3b5:def6:4f7 with SMTP id ffacd0b85a97d-3b768ef96a5mr1079669f8f.30.1753244425754;
        Tue, 22 Jul 2025 21:20:25 -0700 (PDT)
Received: from zephyr ([31.130.177.100])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b762bb4f6csm4747577f8f.4.2025.07.22.21.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:20:25 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: remove redundant semicolon in basic_types.h
Date: Wed, 23 Jul 2025 07:49:21 +0330
Message-ID: <20250723041920.9623-2-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro SET_BITS_TO_LE_2BYTE ends with a semicolon inside its definition,
which can lead to an extra semicolon when used, resulting in inconsistent
formatting or potential warnings.

This patch removes the redundant semicolon to comply with kernel macro
style guidelines and improve readability.

Detected using checkpatch.pl.

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
Changes in v2:
- Rewrapped commit message to follow 72-character limit
- Added explanation for removing semicolon
- Thanks for the review and feedback!

 drivers/staging/rtl8723bs/include/basic_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index e2f203910be..640db1e79e7 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -162,7 +162,7 @@
 		(					\
 		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
 		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
-		);
+		)
 
 #define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
 		*((u8 *)(__pstart)) = EF1BYTE			\
-- 
2.50.1


