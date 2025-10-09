Return-Path: <linux-kernel+bounces-847207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779ADBCA3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88AE423392
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9B522A7E0;
	Thu,  9 Oct 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRxZXibc"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062F220F2C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028676; cv=none; b=dGahPcmmpgi/qQS+8xx/bNaFNBO45tTr4PVFwBNZrAmuuR3KHF0iGOk7npHPZRpAO3Yz04+O+HZdYCplUkva7v13jLdJlBjF0IqUL+Ml0l7x7ur4KN7vuW3G/uOfN6BGeV8C7P1aKWgy+rx//X5MGYcgALFoecA6dU9VoepBnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028676; c=relaxed/simple;
	bh=bSULI9f+euykcipRhqd0laADfcpo8VaHK0Bofko8OAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAOB46KMG9KflCYSuifKTjf9HYX1ZO8quH0fNefAk/eSnqJDxY4MVB0GJYI9b5VRbLhr0wx8C+CiMcBllAsBySMY1RZGE3tUh3IXaXdZxdyl9JPpP/tRbEHifre9gtegp3qRo7Tbd+eFf3GZWQ0j+WBxg2UPw2qq5lASUmousiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRxZXibc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-795773ac2a2so10084146d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760028674; x=1760633474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxPWjMVHD3JpD/tJd3lWXNciFLmIC7SPnsETCC2Sg4E=;
        b=BRxZXibcDRtWwnL8THZjG7UwR2Zgg4kE9ib2naVMeZts14zCuwhlOdAqQw7HNyuRTJ
         YITFIBiZTcvg2P60wZiJBsi1QdeyMTQpPb8+gcCReRZ4ryZZz4T1cKNj3kkdN3SuswWI
         cgZE+s8nl/3jx/eXQagZqUNQk1bs72N4xyjBDAGEdjmW58pFSmx5JPasJXLtPogFGXru
         ulw8DdQumqNpGTDfeB0rnfy8Ok//hRoffI/8/myDCeI2t5xsr83OT1/gcs5EqJRMAAUp
         cR7yCaj2I49SEKz6QTfeqnl5r4VgjLTxhd1epIh0evsXuIZ2sW9WyfQbD0jx16Q3iBn6
         HsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028674; x=1760633474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxPWjMVHD3JpD/tJd3lWXNciFLmIC7SPnsETCC2Sg4E=;
        b=fnjB4tiqLq8bJHJY5ft62rTIYz85bF5Hnfs0t4hDzSZ31hqfmwZF58UKlMUMgS0B7+
         NEQYnGS3pWxS+19cPPAS4eshE5bVyW15OrWk45SpH3f+jzeKrmTLL6tzLVRn0QkL1U+M
         shMCDvVeZTQAUdVKwSah6+vsWChbJF+prAUuAeATzqsVkQUHDVL5+dO3eOfT12U9PHcF
         sqfbgPFkWeziWwbgf/OEu01qBLKPGFsPg8maNK+//ZB8VhJpuR2mZt97Zi85ZYV3SPMs
         Mqw2Le0nzYB5DZigv+Zs2jZTuJ4mT+jIREWpGGkB74f1QUxFNSfE1V4bpcxgBoC2kx1f
         4Jcg==
X-Forwarded-Encrypted: i=1; AJvYcCXY2f545JBp81xkqnsrvwybrAVoszVQfg8TWwguSdD67p3j4rpzD+SVCLfpS9g6ESFyIiNB7JKC1K592mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRs7+dJ1zmOSbh6JXU/I7HfTSctJ7Yxwx8QfR7txC8rlmp/Yz
	3K4f2o4f+NPzOUQ6XCpJewXCLLfb8KktMozsnQNl908lVH2HDC5wgUnk
X-Gm-Gg: ASbGncvsm0T7eh5pOgXDi20FhocjUwhMKbCVfRdmcg8FxT1mZKNwAQDmX4EZWLe5p3O
	NcokaR6rqVnBxcRFZd4Y6ZQ79zNiREC44IT/iNBHb/EZrE7YHyUnangm+bwvXUwhBbGvnm/6QrN
	ZmYCr6BQg+AbvfNQHaBN7SExGXmBb321AchrHshEsrqls9tZN8ET9/uGJNAzbFzFml/J0aDvG7n
	whAZu5+p5zWj1bmC3/L+FvgQXF/VVekwZd035KDpeOo/odCeX0m2TEw8UTYGaW0f00HGrFaiOrM
	gsDAPH/K5mjxPh6PHo1sUoDpFQKmRuhqAgNQcOAetYvIvNV7dPl0dBPEQ/n6YZIoU6P5YPSAOkP
	ZIQD2s4P6mE2ugc8gTJOWyoyOayYdW0PZNM8kiPE+6RNsZ7wIiPZ6nJUmaRnNZYcYg5oDymCs/j
	4YzTK8fug4n7NXHW8OySn6v5dtk899PSlDob6Nd9LCIA==
X-Google-Smtp-Source: AGHT+IEmFjLt2SYiuU5RDKLLiDCSk74xNuT+5x0tojzgJe36FuA1P9ps+/00iZzayGg6ph9RL0gTgA==
X-Received: by 2002:a05:6214:9c7:b0:879:e666:c2bc with SMTP id 6a1803df08f44-87b2103c76dmr71921636d6.1.1760028673927;
        Thu, 09 Oct 2025 09:51:13 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fb91sm182464266d6.60.2025.10.09.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:51:13 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Thu,  9 Oct 2025 12:48:18 -0400
Message-ID: <20251009164817.3762787-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de>
References: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in a while loop.
The logic does not sufficiently validate the remaining buffer size(count)
across loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel
panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
  v1 -> v2: Fixing the error function name
  v2 -> v3: Addressing feedback from Paul Menzel
  v3 -> v4: Improving the error message for the block header count

 drivers/bluetooth/bfusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..02ba16775004 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,11 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+			if (count < 3) {
+				bt_dev_err(data->hdev, "block header count %d < 3 (too short)",
+					   count);
+				break;
+			}
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0


