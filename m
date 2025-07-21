Return-Path: <linux-kernel+bounces-739640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F9B0C90D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987A11AA59D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF922E092A;
	Mon, 21 Jul 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI6LUflm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905102E0B6E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116286; cv=none; b=DmulKfR//uRJJnobXNQLm3i+V5/coUY7k/7J11IijE5Su/0hFnR45XHyAl7G1qnjsvIpZHSFl5fLjxvJzjU7LZbpcJggl6R+62DXQDupIuS5LKODh4EEbXEJ0ZN+ipCspwOHqjON8xEaTMRtl3+KZWSgzWdZY/J147PzSzt9P8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116286; c=relaxed/simple;
	bh=ozpD8mIJx3HAYQyJIXz1aK5rJHg9R626L5Xl/hIiu6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMCy9P1AOwPELZNMgRgACluWKUL7L9qcU+3Rab5naEytZ6L57AptJjdE/beqVGk5lV1go9TAatXmqI0uPpcacguQuAEsJRx8+1UnhC6Lgt+ZCLmyfGm0shuIwxgO9gFTV+BADshFJcfjWIejdPwl9IEGwt/jME7nY/Jhn2G52Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI6LUflm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so9688687a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753116283; x=1753721083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzHkl7xJ687bImnwe/db425jqWJdwTAxnpiPvFCOYTE=;
        b=FI6LUflmz+/tJutrAvQBFjeutQSYRd9YfAGBmRHXHAbcSMsotiidEpoGkJMxoeZym3
         l8LyYSiTUqo4SejgqPrh2MF76fZUWEozL6zAOSg4DgJjcv8uVGu050lMx/l0HK4VdgKU
         ELxE9MZTkXNQogmCc0A+mwfs8KODKunnzaxHSTzZJwwR97uOvfv4aynaoIHQwFJE12H0
         McLDSh+Zv/OIrj8MM3DXFni7XzNr540Kqno7CdY5YThRgdh5gFW8uloeF851R651U3G+
         NJQx1hm+ElIP70Ks8JmyJfXmTNnUPtGAABf1lcWZvoMRq7GRawz1DUtQ/sA1PoDWj3IY
         XYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116283; x=1753721083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzHkl7xJ687bImnwe/db425jqWJdwTAxnpiPvFCOYTE=;
        b=tNNVu1XxM/I9rXBGL0mGgrjT1VMiRvc4SF5sIl5zCfysfcdi3NJ9W2eDeNNzro46me
         TV0pe4khhQbNhMh10UyGwfNHWfWdoULc5feyBBUWSqiActy0ozMIiH8gIogFcCkyoH99
         xnblHeQKHH/2aoiy3BXfEahAxCGEZFoR0nYMPbD0q3E970Y5lyYNEF/jvOljy4JVYxqw
         XLqDkz++EYpwuErhB2wc4E/yAIArzhliMJO4C1x03UFPikkMp5731kTvUQKDtou87wnZ
         Wgo8ljCxhfYGHHJ9R2kqaNguQVP+Hkmx22pRyomxdcU4Z23yOfFDl8IVqhHR2vbUMjTa
         0SWg==
X-Gm-Message-State: AOJu0YxY6lOSDgkoWp3KPlsyKPKcPXGj2hq/BXp4+tF6/fnSD+L3I364
	3/lToQsl0J6Y3KhP7bl9Cx5GWO97Yyo6PR59BA0T34Ems/aGnIw1U4zt
X-Gm-Gg: ASbGncvC9IbOZngJC16Cimb/vncfOo5Rw32kw95sWSpYqcwyUDsVybEaGMGlVYh9uXj
	29INPbDxOa8nN1OROv3bsNloNmT9j1unMLKqxl5zCrdDqnWfq1tvcnArsnMKoRcGHhqvwQc9QPT
	l65xWmPMesQEDlqGBPd49WKXZobZYLt3SRdSxo/SnDTj44KCGYw9tOQR+ee5GWkLHGmw55325We
	UgX9dgJpHsZlhSFSWnu/wcdWcHhc2kTCD3twr37/YWHxKdGNucyqEdEJhZR8vayU187hKiTwECI
	Ae4GkfzHaChqSy9tMHlRwU69p9DyNQVUaC/U7/uPIrUiK2EqjXttXirQcvMmo4sgejZOCXWTOIk
	N8yeoROlaVh8+rvnUXjY=
X-Google-Smtp-Source: AGHT+IHGb+bQ1SgEFJbjuN/De+PLXEUVViPTQFolyGaaNV1SuyKKtaBoSqru8wqxg1KKqb6+D436AA==
X-Received: by 2002:a05:6402:321c:b0:602:a0:1f2c with SMTP id 4fb4d7f45d1cf-61346cc2119mr168386a12.9.1753116282378;
        Mon, 21 Jul 2025 09:44:42 -0700 (PDT)
Received: from zephyr ([77.237.184.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-612c907a5b1sm5662655a12.53.2025.07.21.09.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:44:42 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v3 1/2] staging: rtl8723bs: fix comment formatting in basic_types.h
Date: Mon, 21 Jul 2025 20:13:42 +0330
Message-ID: <20250721164343.8395-2-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
References: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/include/basic_types.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index 57bb717327c..e2f203910be 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -26,7 +26,7 @@
  *	1. Read/write packet content.
  *	2. Before write integer to IO.
  *	3. After read integer from IO.
-*/
+ */
 
 /*  */
 /*  Byte Swapping routine. */
@@ -94,7 +94,7 @@
 #define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
 	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
 
-/*Description:
+/* Description:
  * Return 4-byte value in host byte ordering from
  * 4-byte pointer in little-endian system.
  */
@@ -105,11 +105,10 @@
 #define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
 	(EF1BYTE(*((u8 *)(__pstart))))
 
-/*  */
-/* 	Description: */
-/* 		Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to */
-/* 		4-byte value in host byte ordering. */
-/*  */
+/* Description:
+ *	Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to
+ *	4-byte value in host byte ordering.
+ */
 #define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
 	(\
 		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
-- 
2.50.1


