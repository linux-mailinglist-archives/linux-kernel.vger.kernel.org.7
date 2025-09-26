Return-Path: <linux-kernel+bounces-833621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8793BA274D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC597A2C27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E127817F;
	Fri, 26 Sep 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ0Ccq6C"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E8278156
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865126; cv=none; b=n8Yfp6yJzsvMRuCIwhTXJJhnpF5Y/b1iAx1tcXz2EviKdas95tEYCrL1WU0LQS8EBzPzB0Md9UDFw4+iOJZF3jRMcqXfwoN+O9li3NfaCFUF6HD/VH9nDgDL7P9dnYJr+GkXUma7ayaIFmJqIyRZ0nHlBGD3J57hQQPfDzm/qiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865126; c=relaxed/simple;
	bh=YbrHKCMbCiBU5zkG2mMwLrOZrArn3NNUOSo5527fkgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hq5cs1yyG8Nx9R+ILrDd9lvEzbBAeYjdBfMXBXGY4EU9sVNZA2IIIyJuGDCombvg7Ln9u37gNtPjSXYTjwqBaUyvrGyFCatCXzFkSuVmm+ak7kLYoz/gU1BvGUYVxkj8qpmDrqG9ne7fLqSP10qGUwv5lC36g8ZureK7v4U+Hoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ0Ccq6C; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2570bf6058aso25701745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758865124; x=1759469924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qcTncsLJv6moujHTG6Gv5g4cydsLFc1bTxR1LD+rBM=;
        b=AJ0Ccq6Cj/oO3daC3kZOIZKM8oF9nKl0gSbphDjI7VAPL8jiYtEwdviJ/UNchfQjdi
         DdKmx1eXS2r6bSYXwM1KhaGDDLuu2A0EDjqP3WjNupzdSoiyJbO1yTC/71TpcaH9ZghV
         7r6AGjzYeBaSNYLQ4MVlsf/r+YSUlrQpVQCN1vRdzwZkNMeGYY8bhH9GkJq6M39SMHWT
         P8mk+6Ppush3pXb+ZwLNWCWBBgX+Sd3e1k8ryRk3xnxbgXrmhIdrzlGgixdvUtHJSX/i
         T1JLdoHdNxHOxwmXuKBdQlrSVEsffq1BIPgEj4aH4U4dP5o3/af37EGn4dCR1q8Eo9y0
         l8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758865124; x=1759469924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qcTncsLJv6moujHTG6Gv5g4cydsLFc1bTxR1LD+rBM=;
        b=VK+OCli02rBzDidXBjMisKy2oGk3sYwMnkiM+AgWHobAsBcwMpVLfptBY8sh8Zr3T6
         H/b1ZcappYnYe5vBp4EbF8gHgdih7HOoqX3jdOdWE/St+pJnoiH/nmjjJQ5J7zUKp3DN
         Xrz7XCx4WgDCG4pKqdEjVxRM4A8eEjnbaoeHK6zu7kAXA9nSR8kFgpEugUYqgARaZ/5E
         2Hmq9KBjZqdTfzZUI0XHBjneAqjffj2WyNBcl8zqBLv4ehd9XRL3KVEVMdrUkm4cIE2V
         k94Mp/llUK4hY+7GStiLciKaSbGjlMmCVufV6qBWIpZeaG2pFTI3Wzkl1kRcRrT0e7Md
         aSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUQmpyoSKKL+u3k/DdErhkPoTgMPcHDPsqFqyFeFq9+KpRNOHTAsavzXZA/V9zGfmijMpKtWzaxuB5lLzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycb+sjvOg2A9Zjjx3KEdj+m1MIVJOAZLvuyid3VmU50uJrt0TN
	3K2/3B62ANufkOSD2AVtbxuqFTlL8UXr1+equdS+rQJgbERtvnI1Ib0T
X-Gm-Gg: ASbGncsgdI1LF2Hih064upKhK7ByrPX2yThJW5HC/SeifkKI6A7bV6SGPlnGtCx0yqW
	032Co4Yf7XU0sP7kb+DBAX/7KfNkHofeVs0kL0Kwg/E0Y9s5FDZKlXbjJNlcuAchdmp1O1KRt76
	qb3WklmHXUqGVCPqCLVbHsVO07PegC38Y4ATuTqXxLwJot2wKCrmP4KjMbi1KA9N3ftEaq7c02d
	UHTtnaV9EGDy4ti+hjbAh46ywBlTBhyEYs2mKbBS92+nwPw/qjXa+JlBGzTgsQFFXI4O6kz6/ef
	sjSifmbTzUEm6YSw6L9U7r+fvu9iTDueR1y2Zs7ivh3kCILZAnRQOsPzwvdPB1b9vPK/fiWZ8ye
	th6TEwCpAuOHcoq6WiGBNLtiaP4IM/h7oA38AZg==
X-Google-Smtp-Source: AGHT+IGCzgHZjN3LJlOsoXHyNz0FIxfti8aiB7qnhHMcVfvyqe879onGPV3fh7v7SrTOjr2Vucwgcg==
X-Received: by 2002:a17:902:e84e:b0:269:9719:fffd with SMTP id d9443c01a7336-27ed49b8623mr81081225ad.1.1758865124592;
        Thu, 25 Sep 2025 22:38:44 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66fb07dsm41925025ad.36.2025.09.25.22.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 22:38:44 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH 0/3] MAX77675 regulator driver: Add support for MAX77675 device
Date: Fri, 26 Sep 2025 14:37:54 +0900
Message-Id: <20250926053757.480086-1-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

BLURB: MAX77675 regulator driver and device tree bindings

Joan Na (3):
  dt-bindings: regulator: Add MAX77675 binding header
  regulator: max77675: Add MAX77675 regulator driver
  dt-bindings: regulator: Add MAX77675 regulator binding

 .../bindings/regulator/maxim,max77675.yaml    | 202 +++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77675-regulator.c        | 794 ++++++++++++++++++
 drivers/regulator/max77675-regulator.h        | 252 ++++++
 .../regulator/maxim,max77675-regulator.h      |  78 ++
 6 files changed, 1336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
 create mode 100644 drivers/regulator/max77675-regulator.c
 create mode 100644 drivers/regulator/max77675-regulator.h
 create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h

--
2.34.1


