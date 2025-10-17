Return-Path: <linux-kernel+bounces-858659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A786EBEB5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8712D742B38
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27685337B87;
	Fri, 17 Oct 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="g7Bw5wPU"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0E336EC3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728077; cv=none; b=kIKpv8soWriywswU+9p51x3AxNJQ2LPOsKfBGPrObUvb8J5yMg6wXINMjHwM2cmrc81ThldMf7zr21Dlu48heY4g3gY7dfLwJkHKbsHpzqTA4eXNFE0axEElzV8ITOFKepK67iCRgmTFUOty38s7KA0VCzhaRoEelEKAZF7In4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728077; c=relaxed/simple;
	bh=ENUIv7Y5invqW9/JGzvHqg+snh4IuRykpfxDvM9mXnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsYu64kUdbcVDhg/4hWUM/YagS1gnGfkqcyfuq1D8kLkcUvCzgXhKWHSMDuW4ipyQqGCHw715xK4f2w4wbet5JGDnOQDzUXzRzkyijb8ljIJcbBm9/CY7MQNyGJKkE5zChueluLga3qDkLB7LEhvfI5qMCopCm+cTDoh2F3pogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=g7Bw5wPU; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430d098121cso1135875ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760728074; x=1761332874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfI/HxKZ5aLnk6gHq9CwlPfs/i+7HssnS2IuZUrc0Ms=;
        b=g7Bw5wPUbKKexD070DW7f5b/zvz8RKv4dL7L1KlYgBiqlPcGryG+mLbtnrF6JpJLeK
         ZkhN5SX5p6mBxtJHhoPG+6oB3C9cjJn/i0/HLxwuNTF6J/TX+xlr6B/+zeHBmNQsa1U3
         9hk+S9ZtHIztOZLeg1IBN9jS5OTwTzegs2cb7p/UEdHd17sJfbSm/LooM2J0FVYiAu9L
         IJ7FpzbQwoPemxN03PJpF0uq5OpbX/MUJXdt6ZA9a91K20pdqP2QaGqcjz1pPd7cshpg
         4lCYMG0cYjGEruBQDYT8olKVvZ5arqvu+cykYaL5G4NmNqwZgHGckd02NRViGduEqOyi
         4fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728074; x=1761332874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfI/HxKZ5aLnk6gHq9CwlPfs/i+7HssnS2IuZUrc0Ms=;
        b=K7VqWJmiLgxGhiN9VA2VDW/SI4SCWD9LB9sdCMeyMmfm/J9roVRu/EQaaYumhADbeC
         Qt1LKYQBfpdMjInlE/Q7bvxJdngXJBew+/JOZegiyS9NlwT7R3aQA4kiCSk+P2ocbPcJ
         L4I7J9MHPdJDgEVmd0Zshdp3rWbEcGrsfETpB8z/c1iMFAD6NyjfXsEcoJwNyIWm8xNq
         XxjTjkj1cCZSZuvSl8Qn/tGTMsGmrOHosVWhnZEenCoMwvLD3fS7ZwLwM408fEcqMysp
         kho08Fethb3ziWCcJiS7TgTOVaiMeAL5LVTKbb1dt8BzfrfkxE1GnQUPAvVciNAW5bQp
         4KUw==
X-Forwarded-Encrypted: i=1; AJvYcCWEuV9OvAGLSrpUyGTqw8PhLoORWeB7tXMYxxuJzdMLA6TABAkwQlTPmNaXK1ywPvzy3ZFnFH9zTqzD9P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWZJzyfokIGfOqB4377KFZQ6Swc7b6b5FrXVhBq1VKgAhVp9W
	HZOR9MM6fRTURlxCaqdqqG31lLr4QiTg68TaPnxko3/f1YxXCn8K5q9/+8y541t9nX6Jb7ofLAq
	308yLVuw=
X-Gm-Gg: ASbGncvThbBg6qjsjSV0FJtD3WFwyI418bSasvwrozjhldIxBhVIR3XSSwQeYu94MvL
	M5tX/NCPPwJaT5GPN1xf2ycISU0c7LXRfcOa6ThWvLCe/iSQx/AyLmIjikxTW/pTMNE9jlhpcM7
	APBlJxAcA5O2nxr3PWGv9Bo0iNt2jkTnFOLDNtc+AsmskSLKYqQPK7mqciozY7WtNXEeV1fGE4b
	MASMzFr3o/S0kiJLNsHriJCd+tlVfZTK71IjcuCtUZWuGDL8FQY1ftVm14FsxjAx6Exmw9362SV
	lWOBuTkhBpoTPUg9HmCt7fNzEs1znDd+3FdteBSa3vL0IR7b3KIA+pGVBm8uQfNm1q3K3+RGZGK
	r4Mck4TEedtXdmTulkAwtuxOH+ZLPuZ5e7a7jV70LyiVBx2fGAH6jZVE3ygn0J0wtw68eAq9xkh
	gc9fwd8EnwSpQ3jpunnvC8EmYxYFVaKSLQKmWH0lOsD9kbQKBJ2L4+cA==
X-Google-Smtp-Source: AGHT+IGgZuyks8/SPpqGraEYOHD64JLctbaQzahczxp3t8Isq+v66Q/LNb1tqq+q1CnCV61aP2fWQA==
X-Received: by 2002:a05:6e02:1a42:b0:430:b338:e55 with SMTP id e9e14a558f8ab-430c53068c3mr81229225ab.29.1760728072707;
        Fri, 17 Oct 2025 12:07:52 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9768b98sm153462173.46.2025.10.17.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:07:52 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] riscv: dts: spacemit: add a PCIe regulator
Date: Fri, 17 Oct 2025 14:07:38 -0500
Message-ID: <20251017190740.306780-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017190740.306780-1-elder@riscstar.com>
References: <20251017190740.306780-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a 3.3v fixed voltage regulator to be used by PCIe on the
Banana Pi BPI-F3.  On this platform, this regulator is always on.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..046ad441b7b4e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -30,6 +30,14 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	pcie_vcc_3v3: pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &emmc {
-- 
2.48.1


