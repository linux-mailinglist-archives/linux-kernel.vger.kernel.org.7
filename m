Return-Path: <linux-kernel+bounces-794992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEEB3EB8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0363D483735
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055942D592E;
	Mon,  1 Sep 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMQzlAga"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB421FDE31;
	Mon,  1 Sep 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741704; cv=none; b=HiqI4dMveh+nItZgYru7adVGIkC1SmdqFE/HipOxqfcfXRuhaXYETRt2aQ+SAL9CkVS1x1CjuPtBEOXlzE0dWwxg4PjCR1wq9f/0/CV+tp6TiI7KvVOk6atzYP6v1YpOMmjkAAXqTelw2AeZXwiULMDgZ7R66WgUhA0lIKwC9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741704; c=relaxed/simple;
	bh=OqJQDBezv0KJgsVTeq1hX94oEHJB4wRXKS15iRrG2wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iUv4+VnncOEFaSzxODYI5JryGkXrUgGv1LFfUon7Jd5kU8bqKHDz9jqEqKnz2avqZ05gP+bvO7u4NUSLBNxKpOUT28rema+Y/Tv5p1uQ80FWar8rGzsYi23t9KEy9tThDXj43gxJysJP/n7zWYh/gI0i+kym/IItxwVa6jq1ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMQzlAga; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb5c9c9so217274b3a.3;
        Mon, 01 Sep 2025 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756741702; x=1757346502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A1q0uazSEYJUDRSjtghELC+ozHQQUtJWLevcbmZOggI=;
        b=iMQzlAgaSltR3Cfs8s8VAbK4ewahePQ7/l+Aqtc4+xpdjB7i3pvsTnbedo/dOi1Vr+
         lFffE3sicTTmg+9kOipSZSY07mf9sECTlWCemk43+dgJS9Vw6Szr9VDGQe9fKqcV3icX
         CEPv4vGAYOm0Xgoox2FUHMErI81dUummYAAzviT/FONqUzcmXqLgvbpJsh6N9kw9xECH
         HIEsyOEQm3/gMWWCABMwhNzgKLV4zdwjcd7nJ65KZpJbg9JcHsKs1FUXUSQuGCzEuSAZ
         H42VWRcQQiccWJL0aN6rKRwm4nC+ca0oYJQF2UEHRDc/KXF8DJp0m/yVu6+sb6nhECtW
         kK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741702; x=1757346502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1q0uazSEYJUDRSjtghELC+ozHQQUtJWLevcbmZOggI=;
        b=ZAWaEgFEnzgp29eMq86ueKoGIqn2cU6nPK+6jdRszktZ6VvIdQsj33qrUZJDOhzEpN
         SzE/q0Cr9KSLpDI2Oo+TwSjO8UqoewFni2f5HNwvIqhu/LDZxn4OV9ck1JvL+zAJvpeW
         FpI7B1vaJ5d9cUcSK+mm7pmpmOebXGX+4MUAip26ILSEwDMN64/wfaCaEg0OvLNOIhdl
         cBYdVBz5cH/pwPUs8ifAtqAkTriWJ4qRdN7yOx/Q66zPtF9pm7pUmoaB6DfH4Db9z20q
         DK1PFNd165qLiI+SBFK2o5NCv/R0wqEAbtQHWcIvxUBVhBHFwGamsnshjvdgL+evlV2w
         19eg==
X-Gm-Message-State: AOJu0YxRyh8dpVGVGDkGHcaXawvd/hXrXE9reccLJFtIimV0zAmYUMf7
	lSkFAP5b7orjJIWAHOjEew7Qzm2MymX0AHaxx3aA0OahTeMzVbPAs/7NICbjSg==
X-Gm-Gg: ASbGnct77pdldFMYmbcUy2ju+p3asWxRfQmnDTb2ZNyKW9O89qWosKBqBui8KJsGY12
	x4mcWL7fNia7h/mZXM09jHgEjF7OD3x0rtHUk5oXFKhQc+bOQiyEDJjg4B1dfMgIY4DKs7TL+MX
	LjMBCBKRDr0HZFgxIKtQ4R9qBfcwZXf90FXlz4sdLbR/i+vCvmibJD6DgghzCW+UCTkIi1gEfS6
	zB+B2jfWApUTypqWM0X1h6oiw39htgAGIUgGCXqIPEkWenvCND07VzdvS8f/pk+QsRa6DnmNFad
	1/SKBzr1h8heiW9RH+NeiwoZyfeomT6Vi1L1IPUQZavnDd955bTIKylwZA+3hlJmAvexXbiDPft
	4DLqTfQ0WnUNNRrCTW8n0eFMjyxiW3/AbJKRBaRZ3Y/h+71Kq7j1U
X-Google-Smtp-Source: AGHT+IF7vWSHQYg4wXLV6wn2h0lHFPZgnsqscH5yncQPpUMF/tWGnIlSEZykoEyu96TfQG1MyJmg7Q==
X-Received: by 2002:a05:6a00:10c7:b0:772:db8:9de5 with SMTP id d2e1a72fcca58-7723299b526mr8251096b3a.7.1756741701996;
        Mon, 01 Sep 2025 08:48:21 -0700 (PDT)
Received: from raspberrypi.flets-east.jp ([2400:4050:d860:9700:eabe:57a8:cf74:875e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725d5b90fasm2962679b3a.100.2025.09.01.08.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:48:21 -0700 (PDT)
From: Masaharu Noguchi <nogunix@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH] Documentation: fix typo 'Andorid' -> 'Android' in goldfish pipe binding
Date: Tue,  2 Sep 2025 00:48:12 +0900
Message-Id: <20250901154812.570319-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 This patch fixes a small typo in the goldfish pipe binding documentation:
'Andorid' -> 'Android'.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 Documentation/devicetree/bindings/goldfish/pipe.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/goldfish/pipe.txt b/Documentation/devicetree/bindings/goldfish/pipe.txt
index e417a31a1ee3..5637ce701788 100644
--- a/Documentation/devicetree/bindings/goldfish/pipe.txt
+++ b/Documentation/devicetree/bindings/goldfish/pipe.txt
@@ -1,6 +1,6 @@
 Android Goldfish QEMU Pipe
 
-Andorid pipe virtual device generated by android emulator.
+Android pipe virtual device generated by android emulator.
 
 Required properties:
 
-- 
2.51.0


