Return-Path: <linux-kernel+bounces-737902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAEB0B1B6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF68C189E908
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58B22422E;
	Sat, 19 Jul 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ5DkPUN"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C91422DD
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752955813; cv=none; b=alQUo/GgM5Lsi42Eb5q3Vv+QPmZfH+PPpX2RKln9Vpxf1SVPZbqoynaF8x3RXSbJ/+WrFXdrKvsF+ZLwdcQhRRQxl2fKh8bC53cN+j8qsxpGeb+rgD43YjopWW4pnR/wHkUI7NDE+0G8P40HcB8z7BQwEHfdfMXRSoo7Y6zu2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752955813; c=relaxed/simple;
	bh=smZb3xOKcq7L+Utu/R9oVTel/bZlDNEDZQgW8BLDZZI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GteSnIeShYg7JAFsWbYQf1/awtSrakC2QeCXdUUiBc5Omfyk/v6SNna5QPIFCiQ+AZGhg1Il9liQqYGAoLMWGPpKeOkOa77TBrBP+RDneCb136fknlf7IDuWg2i5NjtDLs8m/v7qw98hFL0B7AT2aJCuAhwVz+Z3ifhPeL31qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ5DkPUN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4abc006bcadso13311201cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752955811; x=1753560611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqqizxQe8ekNjxVKo+J8buM8BmdZV1Qc9uPBEsl5I0E=;
        b=NJ5DkPUNmq7kTUUxjicpL5bA8lGlLFbewmXF8kBCA+yHOUxZv/tR3WoTx/vu1X2gP6
         ZOC7Uvec4wedDMSaTPJKL8TKv7Cv1jHVe9SgVGd4CyfV2R5XNITBBspTUOKsssYx6P2Y
         KWhBqFZVNeY0R26ebgQJotWw1X+heT75U0qcc6ThDcoFovhGtHx0cpNKEy+JOBRvp33i
         ZEgjtM1p6vMUHmOsDANNdqolhqgsIm1LA1iXV+1wzppheeu3UZaKXuamnfOAushas9VX
         apMffUMmVvd6VPGy/QHdVqzBtGTHjPQtWJWWH22oGtuX8cSEfGRnwrHBaA20IzEfKE/Y
         ibMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752955811; x=1753560611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqqizxQe8ekNjxVKo+J8buM8BmdZV1Qc9uPBEsl5I0E=;
        b=jyxn2US4cuYnqDTPFC3fVDGUoT24KLh01a1Yn8APpwAx9E9fSpSpNbXTVO+29re9uO
         qXCMI+n05vDIRLKc3IxKKVE8m37ftcuqT5TQwiXvp3aF9aH9ITqK48p3G+7q0fhoUKr/
         FAaCDAVAclZxYRLIJ6QCyS4zDHlEby/KXVPaSy/KEw8RiFB6ZHY3TFWNNeeER0nUTgAc
         BZA33I3B3UPBD3uRCSTPf3aoXarzS1RdHx6ZaLBJEOwMYQMUhYtijtmtQKBJfniNoiM7
         z3y12K5LSN8PFVtpaZix023APK2f5gztaZ7TLERp1vbxKrwmz2LzSNiQNPFIEtUHFjKI
         rwDA==
X-Gm-Message-State: AOJu0Yz8U8tBPBBmMvpZs5DAU00C9CgF6JtI+k6xXs6zJOiNcjL+x6Y1
	N9ml/451+OuL0/cEPyfmTe69/4VmTqBIEENMfhO87ltdiSxog83TyPSbHB9nRJZ4yE7sL0qh6YB
	8+ySggB3ny2jmm1mkqAXpAU4UjmVjxg+A2p6ITrU=
X-Gm-Gg: ASbGncuBSY2tj3g14UCP+/bdbqtLpvl819hFgKvRsMXfqHryc4UTSiuIi2RWc7XwXKr
	gLWifzDsBMmy7GSKdfay9wQHsqzuA1Tw7xHt1WpbdCqUkMdpJDMqPoQfR9MMa8RwmGitP/4q3f/
	Hy91COA3RvM7iCGGPdcNtKzU3XzypisA2J8Kg44tGTS1fD2cny5UEnO4D/AbcPxR3UysX7gvLAi
	3GrSwmc
X-Google-Smtp-Source: AGHT+IFy8B86A7gyd5qqtpRLoXWM3vwyujqeNz9Zc/QlBJne3coHyPRIp5EV7k+SnQZrUl/03zyRqsbQmlZOjEI6Q9Y=
X-Received: by 2002:ac8:7f15:0:b0:4a8:9f0:84d3 with SMTP id
 d75a77b69052e-4ab90728f1emr179858931cf.0.1752955810634; Sat, 19 Jul 2025
 13:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Date: Sun, 20 Jul 2025 01:39:59 +0530
X-Gm-Features: Ac12FXzmr-V-sMhku2fjUM-6xVygmWKlwMQWJASdyGrVAXxnzC3LHtyYM8J_Sy0
Message-ID: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
Subject: [PATCH] docs: devicetree: fix duplicated 'is is' in amlogic-dwmac and ti,dac7612
To: linux-kernel@vger.kernel.org
Cc: dt-bindings@lists.infradead.org, skhan@linuxfoundation.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	- Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This patch fixes a minor grammatical issue by removing duplicated "is is" in
the Amlogic DWMAC and TI DAC7612 binding documentation files.

Please review.

Thanks and Regards,
Sanjay Suthar

---
From ece9928b37d8ac6d398976332da43db6d64bdd5d Mon Sep 17 00:00:00 2001
From: sanjay suthar <sanjaysuthar661996@gmail.com>
Date: Sun, 20 Jul 2025 01:11:00 +0530
Subject: [PATCH] docs: devicetree: fix duplicated 'is is' in amlogic-dwmac and
 ti,dac7612

Fixes minor grammatical issues in the Amlogic DWMAC and TI DAC7612
binding documentation by removing duplicated 'is is'.

Signed-off-by: sanjay suthar <sanjaysuthar661996@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml      | 2 +-
 Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
index 20dd1370660d..624c640be4c8 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
 description:
   The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
   guaranteed 12-bit monotonicity performance over the industrial temperature
-  range. Is is programmable through an SPI interface.
+  range. It is programmable through an SPI interface.

 maintainers:
   - Ricardo Ribalda Delgado <ricardo@ribalda.com>
diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 0cd78d71768c..5c91716d1f21 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -149,7 +149,7 @@ properties:
       - description:
           The first register range should be the one of the DWMAC controller
       - description:
-          The second range is is for the Amlogic specific configuration
+          The second range is for the Amlogic specific configuration
           (for example the PRG_ETHERNET register range on Meson8b and newer)

   interrupts:
-- 
2.34.1

