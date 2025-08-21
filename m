Return-Path: <linux-kernel+bounces-780721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949DFB30858
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4305E433E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70F2C028E;
	Thu, 21 Aug 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOvzX4yZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52478393DC3;
	Thu, 21 Aug 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811761; cv=none; b=ucT0eZ641+gs+TTGMPh0t6jgt/UUHTXQf9M2myUJHSgd+TNLW6ZPXkAtdfsNLs0+O+K0hGqim0FA42sByRMy0+sGFsSB8h+eFX6EzexYwM9vQDfWQN/qL/fXCeITyz8j/gWmmMVAcVwQ+kx5GKoaSEFemkPEYQnQcLcYYGybqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811761; c=relaxed/simple;
	bh=Y8bpOfrh8QUVsCFSG/Z0WpruykVMjh/Y6T1rXLAfTq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sm+Z9N2wK9WAHlIsrWh+aKTJnIYF3OHS6MZXNC0gQWDCrk0ekGPqFCicHU+yfyMbn7EeWa2oh/j0BPV3FfhpDPyX9lKY7fsrBhAsxussk8E8GYD3ADNOxcE6ShYOUyC6pJfvtfX4NhK31GfifwevPUSxTA/v7fHk8lwcSsH+KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOvzX4yZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso10828395e9.1;
        Thu, 21 Aug 2025 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755811757; x=1756416557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9MVEYh20Ft9l0A8AKMc0WvT3MnzTDP+LI/4aJOCeSg=;
        b=EOvzX4yZLrk7ywt4q/3h2lNlD+qevRMrJaAzsuLERCO238aPJE61fib+LhoEnLu9jS
         cIlrSE0x/ah7yYM0TmS6VrGQiCl5rK7wyjcStdRcf+jd1vA2o4CDFGCDGOfZ1KzzNm2F
         CAGndaz008YXwlYTeSUB897s7JLxQcmngx4N9vt+nWU7uGirdzu5z5WRPTHLlKi3im68
         ZfkjgDcNnMOQ0fdXTUT5WM++wuSybJqGdwgHowLi+A4SPxM2eFH3xPj5keSmpVfDqBsB
         F0LRkJUyhI3wCVmwWIk2opNWMSLG9RdxsGwVq8wRA5kKz0sE7YOiouq+moaLLAzQ/ynA
         a3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811758; x=1756416558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9MVEYh20Ft9l0A8AKMc0WvT3MnzTDP+LI/4aJOCeSg=;
        b=KS3bxwrFzKR5JAyRenBD9Opg7X6i9xk7Zt22nOjmh1vIRQuX7br6wjzRpPNHMSYP14
         S7ghTGusLnvsjAnBoGd00Jq06u8KXHKddkp5TpzhRTNK3axElMxYGG3WGWHkGz0Sm6u1
         SG8na+Bo0nS+12OynwBQl+wveyzv0EcwJlrseQStwAj8mP7dBf6afd+mcS1W4VXMgYuY
         iONUywJAFi4n4QUv5BEeMqXXBWojmJUMyv3DZc5oXqHSb4ETqXGFbkNH42xz9zvLVd8A
         afT50xiCcIYaNnPO3SlMcBcel7ajX0qVPmJrQQ72uR43XVCrZ8mLngvbnoFgGnlaM2Ze
         WFxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZAiVAHrfKxv7aXcZR8WpvVqh0RObuOHFSby3r0rZcCwu+6ErEH+nHSkbLKASyKSPLQ15+AMVOY7ir@vger.kernel.org, AJvYcCW73xN1YC/GuXQUgKW4ntdUsiYSGkR5JYPUp+XGlYIaGjZc+6hmJh7n9/4WcC+OluNLAYXZcuivWDk/KNb9@vger.kernel.org, AJvYcCW7ezU+9x/Sfnp/9HtnnoIU9sluIWUu0qVW/NtOVVgzuEcOnSodjuGKkv6k7QEpnoQ4xshtGgNoInz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHA/834++7eDAHwAX+Xy6Y6wEUN8tUKxqcPq8XVHsRyNLS5JN
	57qihYwnzJ+pQU21id9K38kzQUusH+TAsNfEUXhmoFq6MD4lqgy0UoR9JpdN
X-Gm-Gg: ASbGncsG9ZzpmVTpz0fbUpebSIfPo0gd2SSyTy6sCogfy6u2olowvCjYmkUbSiUNc6W
	Wl3VN49tgMOCkoOC4XJcgSY5w4bpsJA85HoCDcVFA53GeM+K2+DIl2+VRZW4L7baJ+NzivjgJbj
	FsYRUuwjVU2Hc4vQwBi+8KdZi1o/iDV4LcrBa4ABrF2PHSgJx8NZ8qJEb8UeJF0y1U3ZEegnYOQ
	IRQaz5qjDM6VseAc7v7mXo2e89/SZ1xPg1WPK1TPUwCh9ISCaLrpX21Khr/3K7yXIriLYTbXUND
	3704f2IBY7KWREh+a82HE61ZQ0Hdb5Cj2aqkTTVkZ0sIX5cW4fdNzKIPhT8VNzLA+QvX9QCoRa2
	N/OEu9c/ZaCXCpsnCF73b/aZZTF2wz+7wInBPxSXUFmm/xjc=
X-Google-Smtp-Source: AGHT+IF7NjppryrDewWlvu1eEyKNNNzLXx6iF7nyTLD5ca97e6Zk/RkkYapHKhd48DC54IyHfzIb4A==
X-Received: by 2002:a05:600c:c87:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45b5179ebb2mr4904115e9.12.1755811756598;
        Thu, 21 Aug 2025 14:29:16 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:142f:8982:f293:902e:d51a:6b6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4c218c62asm3945798f8f.64.2025.08.21.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 14:29:16 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org
Cc: gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v5 0/2] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Thu, 21 Aug 2025 23:28:22 +0200
Message-Id: <20250821212824.70569-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the legacy TXT bindings for the TI TWL4030
and TWL6030 USB modules to the modern YAML DT schema format.

---
Changes in v5:
 - Split combined twlxxxx-usb binding into two dedicated files
   for TWL4030 and TWL6030 per maintainer feedback.
 - Used more accurate header file for interrupt macros.
 - Improved formatting in the examples.

Changes in v4:
 - This patch is split from larger series per maintainer feedback.
 - v3 link:
    https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
 - Removed i2c node as it wasn't required by the old binding file.
 - Updated node names to 'usb' and 'usb-phy' in the examples to follow
   generic naming conventions per the Device Tree specification.
 - Replaced raw interrupt values with standard defines for clarity.
 - Improved formatting in the examples for clarity and consistency.

Changes in v3:
 - No changes.

Changes in v2:
 - Added '#phy-cells' property to support PHY framework integration.


Jihed Chaibi (2):
  usb: dt-bindings: ti,twl4030-usb: convert to DT schema
  usb: dt-bindings: ti,twl6030-usb: convert to DT schema

 .../bindings/usb/ti,twl4030-usb.yaml          | 76 +++++++++++++++++++
 .../bindings/usb/ti,twl6030-usb.yaml          | 51 +++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 43 -----------
 3 files changed, 127 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

-- 
2.39.5


