Return-Path: <linux-kernel+bounces-868039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E646C0435F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB8F64F466E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A92459CF;
	Fri, 24 Oct 2025 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjEyUQiy"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5C1F8724
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275159; cv=none; b=E0HyVCX6PfbxFiIruFOFqEnTVQuqTUqRuPqV85SxC/L6kmtqk/rgP4xsWlEmRJp19CNHye20vsP9Dyv4KErmUPlyCgbNK2ljjIt7028PUoJt5Dk1dpHGG648gSOyQrPQ2bb7Vi61KsDv/Q/y8Tj1gwh2IhC56gHF02X57Ktb8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275159; c=relaxed/simple;
	bh=4FHl7ZtxkDyyaY2ICzAcXGfZZ9UdpflrdhShRLPsLfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5ubi5puLkk4tblsEsBUWHJA6fGNbIPehdQ+CazRnQge6HgpOO6frTPAVHd8dGInf2wxaXuzgItS4NZBm2bA+Oly77uLAix90et1aqFn/EFMMrYJ3ooEJDtC53Qg2JTchQemk8dYMY9t4BT/SXPcrOh+YP2Nih2RwfZJlP6ycFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjEyUQiy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290c2b6a6c2so17337495ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761275157; x=1761879957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4EzmryWBAlOE+6PvafZLTL8RGcukfyVnYUGcNucBOXE=;
        b=HjEyUQiyP2vNSdSa3Nkz6/bqoheLhkmmXLGH4evdtBQfL5+3+jt9gIQ5aM/rDNRrRx
         doSW8RpxaJIIYyzM5QhqQfUAh2P2J+5azvkNA5PqicfNX8TR5JCT9KfrfA5Gk6q+USYD
         hBMXet25LXt1QLVVwXMPstDkNnGC8bNy8sZWGcP4YWebe7//SjnU9zfxIQDKdrd4abRu
         7jdCrZQJZn1Znj+/N9UpZTWIc3P0v4Z8pFrMwYDsdMUB0d3i7yhkewaOZS/EzcP1ohTS
         L+vaB+QWyE4zjfp5V6qyBMg8ydcKrP2FBCRRRyvDyjsFgWAz1BxpAtJxdqfh/LZogfy7
         VfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275157; x=1761879957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EzmryWBAlOE+6PvafZLTL8RGcukfyVnYUGcNucBOXE=;
        b=Xs572kBExoZJ/9N4UAqJ2hH/OBDWoHJOfrKbimhsDB8wm5MrToCsjqB11S4RNga/OU
         qWnU82bVQxHtTZYyp7qS0i3BaXJnuJBi6uxW9MxJHsoqBDW9Bm3hlR3f013UDcoMhbBg
         SFwHji4jC+cB4nESWZ/wGKqmPDw8eAFBkwcubN3ziYjrNfNXZFChfBi14aRfvPNjfxLi
         IEmgN5ugESooo8tIzzjgLWdvpWpvdHpQ6nhA9jL5vXd5U63U6b7dNHIudVHl8lin2yJQ
         /zxJqp44iZU2s2UiuTx2pdvGnqLw/M2uSgwtHIMOvQezO5R82BYP9HWIN2cL1BDgtPZS
         Myqg==
X-Forwarded-Encrypted: i=1; AJvYcCVq0KLhUpdh78MNX4ZM2PqCBR5SNMXdDiIQObt66RGbfLxGhJNfmi+STwowbd5QRUtqvVlUIJitxC83Ils=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm96GQ3+ks101ojwsdFb/xWzEFNAtCbypVh9VI2cXBHrC1oBTH
	rrSoj1AQR9kkZpJcoau6QBFwX45waCo+lRA3iVfp15gkTTgk88Q+JGYe
X-Gm-Gg: ASbGncuEHO28FPZtbjiHfz5VobJKHJm+DKiTm6P9jCihur0LnqHDepG/G1bw7NY+fzO
	U19B8Jlg0KSoknse7mnZly7x2IvxfOgGhJr6vTGUnCBqha01UQUvS2lSwqxhVSJWGh4arOxMZh+
	rtsDbfR4fKs7fZ/N5Q9RUCKFY1R9pZLd4d36/UcDmjdwIB5pHJZ+Tr2/SD0riFqXfNdcQ0HUzv/
	o4W17RJemdyBlzCLom+/ZVUlZ9ecMeG7+pCLtEOzylkOxo9fhKbKDxUCq8BxJhyh5GqDqAkPv29
	3MO0tc7yJ3UjNY+MfgPs80b2NlMX0EzFKjHfgnO2PUY4tS37+qvJXIQ3YZjodDoL33Mm766i+7N
	1CqVksBroRMxEnpJ+6ACZiES7NFz2HIyU95iHYGL2ctWalnyYL40ou9s86n3vQdTHYV9FcSHyAY
	DKVzRuS3gJaFcjjh+R2khoLLOGPLw=
X-Google-Smtp-Source: AGHT+IF8b4avL0/1iLczBKXPJIE+YBOYlfAMVKvJQQ45ng5xpwwuuzbCszJkZUGkuxOMXW5DM24w0Q==
X-Received: by 2002:a17:903:298c:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-290c9c89eabmr329227425ad.7.1761275157084;
        Thu, 23 Oct 2025 20:05:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm3574172a12.7.2025.10.23.20.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:05:56 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/3] riscv: sophgo: add top syscon device for cv18xx
Date: Fri, 24 Oct 2025 11:05:13 +0800
Message-ID: <20251024030528.25511-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add top syscon device bindings related DTS change for CV1800.

---
Changes from v3:
  - https://lore.kernel.org/all/20251020083838.67522-1-looong.bin@gmail.com/
  - Corrected Co-developed-by information in commit message.
  - Fixed patch version number.

Changes from v2:
  - https://lore.kernel.org/all/20251012022555.6240-1-looong.bin@gmail.com/
  - Add ranges property.
  - Use proper regex in patternProperties.
  - Add complete example including child nodes.

Changed by RFC:
  - https://lore.kernel.org/all/20250611082452.1218817-1-inochiama@gmail.com/

---

Longbin Li (3):
  dt-bindings: soc: sophgo: add TOP syscon for CV18XX/SG200X series SoC
  riscv: dts: sophgo: Add syscon node for cv18xx
  riscv: dts: sophgo: Add USB support for cv18xx

 .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 81 +++++++++++++++++++
 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     |  5 ++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        | 42 ++++++++++
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  5 ++
 .../dts/sophgo/sg2002-licheerv-nano-b.dts     |  5 ++
 5 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml

--
2.51.0

