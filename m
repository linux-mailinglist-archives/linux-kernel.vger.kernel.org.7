Return-Path: <linux-kernel+bounces-733243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46918B07210
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20F13B5CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAD2877C8;
	Wed, 16 Jul 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwA0tqQw"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB222F199B;
	Wed, 16 Jul 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659016; cv=none; b=cDM91kmjbiPutKhX4Lo45KW+bupfQnNryx94b1Qk2bO8H8bunNl66p1GZ5B3ngEed1pGGyVdRYwvruYX9FthWJVmx0tmBe/kJhI6+1UDJ9Odl88HTQ0JfHTSYGF/mobnchOt83qrzGsqNrOO9HFn8Im6VdqvG/Z5s2JH4F5G8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659016; c=relaxed/simple;
	bh=dhm3xocr5iaNuduS+eigV/azx1gGGvuqWKVuj+K5CNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKwATQ3VCdkXhgdvhy2emDow0c69GZRIv8qicLWctdiZ7mN38/nzIrlX2SRxR5JHJDdWGJC5vaQlsi1iKsla5HvwcVp6LrYQRQhopjItRv+QB8khtUSXpYm/XXi24bXj2WRRrOQnzZtcuTo1hZ299mfBnRu8+9IfcndEMw6sfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwA0tqQw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3220c39cffso6513835a12.0;
        Wed, 16 Jul 2025 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752659014; x=1753263814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5vVXw+LoXYmvFQxN+y9Jtu16e9jAjGmsO29XS/9U5o=;
        b=hwA0tqQwR7aHk3u9zOdBS/NMNw9kWeTykN87aSIbzYeNaWXW3OJ2TQN27rbeKGEGLb
         mCkJ9W+UF/eNBCqSwG6rTox4KLJ3zsgR0u9ZZlr6t4xnrsaW2X/Mm4j0+KVKWlcsXYHo
         7Ddn6sdpe4eVs/t2Q4aet7s6SOEkdaKhx8XCn6+N7DJSxDP9fkFuH9QWQVUedEM5F9YO
         EiwCtT/93kIJIrprm1geeX7t6EKqMwopn0/IM+2+9JVci95/8n/kKbWVworf26vHIv6D
         3B9mn8dGVwRIJ22TUjhFrCrulIEeEyL3toEbExBPQ+8xu1g/faf3xG+zHyP46v28Grcv
         Fb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659014; x=1753263814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5vVXw+LoXYmvFQxN+y9Jtu16e9jAjGmsO29XS/9U5o=;
        b=o2WHHT8fxz6nAtsOxRTQuCTZLKlPP2YHQ7dOTw52ZN5BVWwH6np3rrCVVJnn5c7k3T
         ORg1SEyRExSndP0oUgrlzWlAHIOgm/4XfQMNNp0XmDEQvQa3eo0AqyUIvsEO77a6NeUN
         ISlRoZU+fWXMvf89NSLPuTQffRN+ETS6XmkCZw4sT1JCTesITeaDQRlG0uW7UKnJGzHv
         QIQGXe/uMQh7KaQvtUTazWEHPMTfcAF2YLFd/Ved9te0XDVXQMZzWs0WhaikCIW8vmYT
         SaRNv1Y194Vv87TKh8NPuhbf5td55JxKqJfdNd1jTzTtVjX1bMBtEBI2DybIkUfiND7+
         qrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUX5oCn5v8LljRobQOlZIu1dXqRYEkKPvAJPgrA/DwfAiG7bUNqdok/Ao2bYs1bQVgaw9tyLI4UHCHOWmD@vger.kernel.org, AJvYcCXlIBLbZHBumY5WNxyOjq9R8vD2d4BX4Y09VrA2lPtOa9uvYcoAz5NZ4HHITrFxQDmPCmN7pRT31R+K@vger.kernel.org
X-Gm-Message-State: AOJu0YweBOf3jFMMD9oPqaOqnqRcZnQ223CMJ9ZuI/5UzhW0VzUyhAtx
	+/xirBTKKYurSZCw34MeXqFIC0y5gQWjZjUFxX4ItdXBG8UJjKfEuW7a
X-Gm-Gg: ASbGncv8AxAbzc2S7wAR3lRadAFyzdNOqg2Q4hSaiMe3YpM2X7h4WQ6kehwrmaq6TMi
	N4YHgo/r0gi5mVsZZJD+0xR54oo9Rgq2Q/3RFytWzmVwDfE36wGMum4aYuRd9d/mRY/5Fdqgc5b
	Rn+LxGZdWiKsubJPqFWS8g9+x9JQDw2FsT5+wflEB+wut7ukcR5OhtAJ64exv21bdwQSPobKaE7
	MxzYPc7veoX7uRaTpP6R2P6l1kriK1MdbuD/tV4w1n0mVvjJiJg9Y9SnHtcZT6QmRPvMgLwqyeY
	Xc4+uqvAhwk0CtOHW5hxqdXyR+YFADTjQayI0XSL6rkdgTX79bWMPpa/GgOL3AGBKgtu5s48GkH
	KnjV3+sYuCmnGpv3t3i+9h30wTr2ia9WNKE9DB7w7RCaAS6sYuQxeEYrLTKi7rd8n7ytNrg2FeD
	xyvHMvbgzQ
X-Google-Smtp-Source: AGHT+IEQ8TA8a/Tp8JVUJ4l4ZbjYlDYN0wAMilYaPQ7xEw3y9Z5/A8bzzrn/UjeSnv2yhj0GESvLrA==
X-Received: by 2002:a17:902:d547:b0:23d:f499:79fd with SMTP id d9443c01a7336-23e257647e5mr37218635ad.40.1752659013872;
        Wed, 16 Jul 2025 02:43:33 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2350acsm1039503a91.45.2025.07.16.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:43:33 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v9 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Wed, 16 Jul 2025 17:43:27 +0800
Message-ID: <20250716094329.1069203-1-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
v7:
    1. Fix broken indentation in the device tree file.
    2. Sort nodes alphabetically, then by address if equal.
    3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
---
v8:
    1. This patch series has significant changes compared to
       previous versions, and quite some time has passed since the last
       submission.Therefore, previously received Acked-by/Reviewed-by/Tested-by
       tags are not included in this version.
       If needed, tags can be added again after review of thisnew version.
---
v9:
    1. Reordered the node sequence under i2c5.
    2. Added a description of the platform's intended use to the commit
       messages.
    3. Added 3 GPIO expanders to i2c10 and defined the necessary GPIO
       line names.
---
P.K. Lee (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1553 +++++++++++++++++
 3 files changed, 1555 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.43.0


