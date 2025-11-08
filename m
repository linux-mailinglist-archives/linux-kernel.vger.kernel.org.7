Return-Path: <linux-kernel+bounces-891756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159BC4367E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887CD188CA99
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F81F2382;
	Sat,  8 Nov 2025 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVx2PyO+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B841C8626
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762644738; cv=none; b=rKKPJ77xi4GjtDZVfnIW40XFrDXu3uYi9G1Kt7LH9lw3t6SkDpzgBhPKHtry0NJjaZlOMdv6Bf4qGL0y3Zu/9V20DnULkFMsLW3M9w/Z5F3vkm4D1as+2Y44WRwgVP7GotNy/eHvUBy/MkwHcYQG7VI87bMyWTAAe7KZ8Cw/axw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762644738; c=relaxed/simple;
	bh=xKs8wYkk+cdW/0EbGiN/udJKAvFLzY1GYmzjS/+rDlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEDvmpHr0loFaBEPMZ8C7492/koNxYgvw6D5t79ZXS37D9Y+lePqgA3lNpvE2ssmLoxJ87FT4lR6Lae7nQ5zshojs24nVhtgxoO9ujYpi2ipZ2MWSVzCb91nZLfZTB7g8clTi1s9OitWWVRYrKPwEzLNPSvYLop/HPiZgIqTnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVx2PyO+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so289593a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762644736; x=1763249536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2fxYKfyTmTI/AxonjY+SqxajrG2P4Kjo61uGzKE6W8=;
        b=bVx2PyO+GbGyv/co34eemITrgkf82Ln62iuzCZizLsMg24H5pBex2AdDJ5TqG3r2Si
         KCvBDZRwHOHkDxwkVelYipdWzQzBHRfLfWEFEaJvzdUw5RHdcatL8OBfm6Ug7HtvMOmE
         Dj2EuN0QdjTN9oq703vDEtQpe2zOLOd1KOLke4MFPE/k5z+uiAxcSqoNxw3Ej/9LnGyc
         J+YHERMJzscwaDOxHApjMPjo04bq8M5r3okSo6e9S19B5M9trKDjm9Kv1fcwS0DxB3AI
         +8iRlFgmkWHeumpAG1Y2g7/7vqDYCYKu4sJKHqeE/PlZJ9QRB0KEbl2mZUjWM/dGmKtg
         3mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762644736; x=1763249536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2fxYKfyTmTI/AxonjY+SqxajrG2P4Kjo61uGzKE6W8=;
        b=RXqJviBndfdoVLkoHh/JMBnICLu2aaMl+dRFsZeURW0oDwBTRPP+F1Z3ZqQMZXV9Km
         0JcVAKkK3yreoX8Kv+3gqSDKqNX/no2m49chBK+LOYJBAphwN9KjJ7+xQ7m4TRAO6+C2
         YbJM/XN9gNXyCphwXLOi/TJnaiCERGt9YodkQYTLK9UkSceVdUwS4oQBfBq4DqgKWgEw
         V+CQGbqqwWIljCJeEkrPquCATYYryNJ/4NufoX/8f3owOUBBGcvGbxXFdcUJ9aZ2lYV0
         dCiic1jSrwqMA/tH9WjCyti/j61sO+apLG9y2fUt1KVpGuoASIdOWJUMvgX+qT5a2eh3
         uLDg==
X-Forwarded-Encrypted: i=1; AJvYcCVJq9Ol/RFdTS1aAebEo2b3VNdr+aqnm44Dme58VSpir2C6qiMxlOXsVAeu8Eq0qnhqvfU82DaBJIV+6k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfuUgoffaQ3Og51Ma3U6DDo3kgBd3isH9ob0jFTFLjDVDlTUB
	O3d8eqzaOucgq/j9g6Ysms3zyEVa/AwaFEQb61nIH6H42eCChCjTaN11faL73B82
X-Gm-Gg: ASbGncsah7Hdig+1d8EvIZ7W8tqOYm4gAMxl0kpqJlC/jFS5mIJ0fnvLchbF+opgCaI
	SYvpdkeceFYPBRJFF+LuDw+TrYt9Lvv5kfze7zgL0BNBvsp+Oolp6tYZtjxAqsgEf9tCIK+l77P
	maDDXTw7uSjuyUSzzR8859pRSp72hvctSwrvo07VwMo6OjVJ35LBZ8wW1zXJG5XloveTYDBEUPz
	wp+LQ7jzWY8jAxuvWR4ReLhM2ua52KrUzmMYI8ZRhFbG3etAVsZRoUOFAnpZqHRoWw3IcL/fUMM
	rUJInCM08YCukCgV+BoDbHsf88mOO2yJWYg3HEo/BcxjA2fo7TIHPDqDwQqksME4Bb8REbnCz4z
	UokNKj3h5FISiFREFgX0p8LFmFPzr9i5EMxFjDsurYFo/qR8OtCbUEWNAMe4eFW5795wX313JZM
	kU
X-Google-Smtp-Source: AGHT+IHt0Vn3SiG3I6Pw+8+ukG4cQ6WeXSBHOSQlHyfoi+jjU2LC0v/ov1yYPZ3yv8FjxrEwPlJ0Ug==
X-Received: by 2002:a17:90b:5710:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3436cd0f1f0mr5195603a91.36.1762644736252;
        Sat, 08 Nov 2025 15:32:16 -0800 (PST)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436d76d382sm1343594a91.0.2025.11.08.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:32:16 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1 2/2] dt-bindings: media: i2c: et8ek8: document missing crc as optional property
Date: Sat,  8 Nov 2025 15:32:00 -0800
Message-ID: <20251108233200.2068334-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the optional crc property to the endpoint node for the et8ek8 sensor.
This property enables CRC checksums for the sensor bus and was added to
match the new driver support for reading it from the device tree.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 .../devicetree/bindings/media/i2c/toshiba,et8ek8.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
index 8d8e40c56..5fd30f59b 100644
--- a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
+++ b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
@@ -30,6 +30,12 @@ Endpoint node mandatory properties
 - remote-endpoint: A phandle to the bus receiver's endpoint node.
 
 
+Endpoint node optional properties
+---------------------------------
+
+- crc: Enable CRC checksums.
+
+
 Example
 -------
 
-- 
2.51.0


