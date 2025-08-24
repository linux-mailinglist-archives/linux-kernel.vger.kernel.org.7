Return-Path: <linux-kernel+bounces-783590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2F4B32F62
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B74E04FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD92D5C6A;
	Sun, 24 Aug 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9zLHRPT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1C2D59E3;
	Sun, 24 Aug 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034681; cv=none; b=GcyxrW/tbnewSRoSe6Vt16Ah58KF5nIUHjsNCAJjTsVoLtXV7v4VDWZy92yMsmDCJtXDsJtwPn0gRJgBRaY9hh0zO/WAX2GdDg5aVDOpkNPMb7PdFt2GfvBFia7A4B04uPzD5OnV3QrgINMvXj9L+nia+TwY/DCBsKgoeKTy7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034681; c=relaxed/simple;
	bh=61FmKLEJ744CNLBIVPgj5tgRLtQAwx1a9iIsXvpw1wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/3W75QQQcP1vWxYgNveVXIhXO2dxLULmn0j7rgwA0+Yd9pn6lRVX7TOKm5Xmfau6fh+4duuirsBygJtQZcyTaurZWwRgDt+w/i9QZU1TeRk/TMl2OpKrva2I1Ca8cRQG5DERzzdwX4azGWXMzomuMl3SFe+YocVz3tGgkkDb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9zLHRPT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso29230205e9.3;
        Sun, 24 Aug 2025 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756034677; x=1756639477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gd9xjSw8m24oRJrzZMLLpErv0wod9zJH9fguDoTibXA=;
        b=d9zLHRPTRikIxvC2cbdDkOj0GfuhstHYdBQn7qq0XLaWPJJCCvclcd0kWctUltbAUS
         SQ5oMyyUQ1UVmCgrU/2UgUEMbk8rYCUyNXJpmr9xlfemZN2TMyBA5oS9XWn5i/anlzhO
         gvPnXKwi8pbVYiv9r42W7rG3X8ybDbfZHBtTW8dOgkiBN12UY+7NMu32jR4qCInPIUG4
         uKxCHybvopuweGzrnBODg2e7ckc6ALeNGWw6ZbMLPyYeKEzl9UF9Yq8cXOM3P4dZnfcJ
         ACvewXC5XmNh0w6dTSiroS0G3P0fNvEbP3PLSZp0pUL5t2d9Q1xJigNOj3XWbf/CUeAg
         506g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756034677; x=1756639477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd9xjSw8m24oRJrzZMLLpErv0wod9zJH9fguDoTibXA=;
        b=jS9jYHx+TfZBi70tMIQnj7G1v4wuY1/oLd3nPo7MADHOuCdpJ++RzoT4a5ycU4UoFD
         xwJFJuV9eLbhNA3q1Uj/1B/ERD4MkO4bEGWCam8heBOG+jcFsoUlw2jmtFZta5Rqmp9g
         zPZ3GYGkQsTG9/USBM/itZId+2wvyIBtYXEUhXCDEGwFYOV0ePwYBORecHGk/YlcdxZY
         Jifz0PHfoqppis8lIjiCFPyRRtO4MjBCj5Gh6BUFkpGVl+1E9mWR+t2k3ZxuIoygNSOo
         FvkVtVUxUKCzhyqNcDcAtOaw97gYYl5vz5I9odEcIMyte+Af1/V5XblVPzChgbC/2Ple
         fFEA==
X-Forwarded-Encrypted: i=1; AJvYcCULLbxrx2DpMdskYt5HSF1IwvkB9dsbwFp1oR5yKcs7iDZXESmxQRPHxGvBRGscevHNMhZl7rIpCQl9d4jD@vger.kernel.org, AJvYcCVdBKGrmWDsUsRDLcoOGvGVbQR2809/4Nym0RQHuyiY1QG752a7k22PLWPjSEA3sp3Fe2xJNUQgU524@vger.kernel.org, AJvYcCVlKeBGMjEujE+LsCO0Bm3j7+UnjCbybQcEb13w/R1Mxr3+h+9+F7ZlUCMdH0xpx7fGngUNgMvYZIzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYFkvOCKDSNaqnDmAD//BeoG9RX5rRjxup0KAFchLznVcbjYv
	1OhikR3kVRX0sVJLpmv/DdWYVXgEEKWxDaU1QDzOBIal1yTM7Ld+8oU=
X-Gm-Gg: ASbGnctxGG2zBtj147wWCYgs9Cong7Gz8SCKstQbOwaNgA6zEgjFesepdcekxTlP3Yq
	d8TRT0/mIMUxtERajM4j72IMKElIK9LulRKFrHzjKzg8YDiDqS9KqylIbRiD4LOpgBkoD4WkBbA
	kcfjOICUqhxd7pfZUsqZcBSM4feQoD5ivFeOJLl2yjCZudHE/XpTsJ9+4qMUO34BHGTRonvHS4R
	vSGFiF7SeIAMyMhkTj1em5HAslgLGfUC7J5NzgtXh2b4SlNm0JIlDwrKpvVJyC0/fS7sJSopDvy
	g67Wc8fE6+xtuTdqQVp4dEPTTO6iBRgla3P+6RHuM4/gGlhAArjnSAb0BhG+r2WSkF5mwSriGaM
	79CUuR22BIAYxC81GT09u41HLlFeO8moV77vCfOglVA==
X-Google-Smtp-Source: AGHT+IHsMOg2HCXj3aWnbqJR00tBbUuYcZEdUU4BfJjzYTjGE4YTHRtim8avT7VLSax+Apo05XHw8Q==
X-Received: by 2002:a05:600c:19cb:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45b517d2751mr71259025e9.28.1756034677087;
        Sun, 24 Aug 2025 04:24:37 -0700 (PDT)
Received: from localhost.localdomain ([37.169.16.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487c55sm67879755e9.16.2025.08.24.04.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 04:24:36 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: krzk+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v7 0/2] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Sun, 24 Aug 2025 13:23:36 +0200
Message-ID: <20250824112338.64953-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series converts the legacy TXT bindings for the TI TWL4030
and TWL6030 USB modules to the modern YAML DT schema format.

Thank you,
Jihed

---
Changes in v7:
 - Patch (1/2) removed the corresponding twl4030 section from the
   old .txt binding file. Patch (2/2) which deletes the remaining
   twl6030 section; removes the file.

Changes in v6:
 - Reworked 'interrupts' property in both patches to use a list of
   items with descriptions, per reviewer feedback.

Changes in v5:
 - Split combined twlxxxx-usb binding into two dedicated files
   for TWL4030 and TWL6030 per maintainer feedback.
 - Used more accurate header file for interrupt macros.
 - Improved formatting in the examples.
 - Patch 2/2 removes the old .txt file.

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

 .../bindings/usb/ti,twl4030-usb.yaml          | 74 +++++++++++++++++++
 .../bindings/usb/ti,twl6030-usb.yaml          | 48 ++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 43 -----------
 3 files changed, 122 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

-- 
2.47.2


